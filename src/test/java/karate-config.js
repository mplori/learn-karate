function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'krt@test.com'
    config.userPassword = 'karate1'
  }
  if (env == 'qa') {
    config.userEmail = 'krt2@test.com'
    config.userPassword = 'karate2'
  }

  var accessToken =  karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization:'Token ' + accessToken})
  return config;
}
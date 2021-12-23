function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
	baseurl: 'https://reqres.in'
  }
  if (env == 'dev') {
    config.baseurl='https://reqres.in'
	config.myVarName='DEV DEV'

  } else if (env == 'qa') {
    config.baseurl='https://reqres.in'
	config.myVarName='QA QA'
  }
  return config;
}
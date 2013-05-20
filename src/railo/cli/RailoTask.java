package railo.cli;

public class RailoTask extends  org.apache.tools.ant.Task{


	private String webroot;
	private String uri;
	
	public void setWebroot(String webroot){
		this.webroot = webroot;
	}
	public void setURI(String uri){
		this.uri = uri;
	}
	
	private String getURI() {
		return this.uri;
	}
	private String getWebroot() {
		return this.webroot;
	}
	
	public void execute(){
		// -webroot=$CURRPATH uri=$2?$3
		
		
		String[] args = new String[] {"-webroot=" + getWebroot(), "uri=" + getURI()};
		
		try {
			Main.main(args);
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}

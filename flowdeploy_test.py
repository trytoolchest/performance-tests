import flowdeploy

flowdeploy.set_key("MWZhMDA.NzNiZDE4MmMtMGRlYi00NzVhLWIyNzktYzBjYmQ5YmYxOTAy")

flowdeploy.snakemake(
	pipeline="trytoolchest/performance-tests",
	instance_type="compute-2",
	run_location="fd://shared-demo-fs/runs/scuff-haven-squad",
	branch="main",
	snakefile_location="Snakefile",
	snakemake_folder="trytoolchest/performance-tests",
	is_async=True
)



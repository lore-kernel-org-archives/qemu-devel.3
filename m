Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E82ECD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURvl-0004w4-Np; Tue, 02 Jun 2026 12:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvV-0004sB-5Z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wURvR-0001NC-Ma
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780417507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHf2jrK0TMUhvLaAP8L2IdURLJ9Pl/1Hv8X/zR+6Htw=;
 b=PINEjVs7W6e1U6nk9ju8pZ6PAvTUUwA9SyCTjdovCHwNLkqvgstUQEH8yc/0BcF+csEPfE
 /SB8hrovDxne+mSI0+Q4dbzTXo2oBRGFowKTLb41JfnlF4oNZDA7gvWGLWBdE2FtHTjl4f
 ldVYf7Iqs1qaXQLmZWQ6E3PWBG87jQA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-OMOynMXXPOygAeJY_w7Tjw-1; Tue,
 02 Jun 2026 12:25:04 -0400
X-MC-Unique: OMOynMXXPOygAeJY_w7Tjw-1
X-Mimecast-MFC-AGG-ID: OMOynMXXPOygAeJY_w7Tjw_1780417503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C9418002D7; Tue,  2 Jun 2026 16:25:03 +0000 (UTC)
Received: from localhost (unknown [10.2.16.102])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCCED18004A3; Tue,  2 Jun 2026 16:25:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/3] lcitool: remove Cirrus CI support
Date: Tue,  2 Jun 2026 12:24:55 -0400
Message-ID: <20260602162457.828969-3-stefanha@redhat.com>
In-Reply-To: <20260602162457.828969-1-stefanha@redhat.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove GitLab CI integration for Cirrus CI now that nothing uses it
anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitlab-ci.d/cirrus/README.rst     | 54 ------------------------------
 docs/devel/testing/main.rst        |  4 +--
 .gitlab-ci.d/base.yml              |  4 ---
 .gitlab-ci.d/cirrus.yml            | 32 ------------------
 .gitlab-ci.d/cirrus/build.yml      | 42 -----------------------
 .gitlab-ci.d/qemu-project.yml      |  1 -
 docs/devel/testing/ci-jobs.rst.inc |  6 ----
 tests/lcitool/refresh              |  6 ----
 8 files changed, 2 insertions(+), 147 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/README.rst
 delete mode 100644 .gitlab-ci.d/cirrus.yml
 delete mode 100644 .gitlab-ci.d/cirrus/build.yml

diff --git a/.gitlab-ci.d/cirrus/README.rst b/.gitlab-ci.d/cirrus/README.rst
deleted file mode 100644
index 657b0706d7..0000000000
--- a/.gitlab-ci.d/cirrus/README.rst
+++ /dev/null
@@ -1,54 +0,0 @@
-Cirrus CI integration
-=====================
-
-GitLab CI shared runners only provide a docker environment running on Linux.
-While it is possible to provide private runners for non-Linux platforms this
-is not something most contributors/maintainers will wish to do.
-
-To work around this limitation, we take advantage of `Cirrus CI`_'s free
-offering: more specifically, we use the `cirrus-run`_ script to trigger Cirrus
-CI jobs from GitLab CI jobs so that Cirrus CI job output is integrated into
-the main GitLab CI pipeline dashboard.
-
-There is, however, some one-time setup required. If you want FreeBSD and macOS
-builds to happen when you push to your GitLab repository, you need to
-
-* set up a GitHub repository for the project, eg. ``yourusername/qemu``.
-  This repository needs to exist for cirrus-run to work, but it doesn't need to
-  be kept up to date, so you can create it and then forget about it;
-
-* enable the `Cirrus CI GitHub app`_  for your GitHub account;
-
-* sign up for Cirrus CI. It's enough to log into the website using your GitHub
-  account;
-
-* grab an API token from the `Cirrus CI settings`_ page;
-
-* it may be necessary to push an empty ``.cirrus.yml`` file to your github fork
-  for Cirrus CI to properly recognize the project. You can check whether
-  Cirrus CI knows about your project by navigating to:
-
-  ``https://cirrus-ci.com/yourusername/qemu``
-
-* in the *CI/CD / Variables* section of the settings page for your GitLab
-  repository, create two new variables:
-
-  * ``CIRRUS_GITHUB_REPO``, containing the name of the GitHub repository
-    created earlier, eg. ``yourusername/qemu``;
-
-  * ``CIRRUS_API_TOKEN``, containing the Cirrus CI API token generated earlier.
-    This variable **must** be marked as *Masked*, because anyone with knowledge
-    of it can impersonate you as far as Cirrus CI is concerned.
-
-  Neither of these variables should be marked as *Protected*, because in
-  general you'll want to be able to trigger Cirrus CI builds from non-protected
-  branches.
-
-Once this one-time setup is complete, you can just keep pushing to your GitLab
-repository as usual and you'll automatically get the additional CI coverage.
-
-
-.. _Cirrus CI GitHub app: https://github.com/marketplace/cirrus-ci
-.. _Cirrus CI settings: https://cirrus-ci.com/settings/profile/
-.. _Cirrus CI: https://cirrus-ci.com/
-.. _cirrus-run: https://github.com/sio/cirrus-run/
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index c0321d1d25..3408b5836d 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -551,8 +551,8 @@ mappings to distribution package names for a wide variety of third
 party projects.  ``lcitool`` applies the mappings to a list of build
 pre-requisites in ``tests/lcitool/projects/qemu.yml``, determines the
 list of native packages to install on each distribution, and uses them
-to generate build environments (dockerfiles and Cirrus CI variable files)
-that are consistent across OS distribution.
+to generate build environments (dockerfiles) that are consistent across OS
+distribution.
 
 
 Adding new build pre-requisites
diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 7640a1d52c..72eadc8073 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -52,10 +52,6 @@ variables:
     - if: '$CI_PIPELINE_SOURCE == "schedule"'
       when: never
 
-    # Cirrus jobs can't run unless the creds / target repo are set
-    - if: '$QEMU_JOB_CIRRUS && ($CIRRUS_GITHUB_REPO == null || $CIRRUS_API_TOKEN == null)'
-      when: never
-
     # Publishing jobs should only run on the default branch in upstream
     - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
       when: never
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
deleted file mode 100644
index 4769d00c67..0000000000
--- a/.gitlab-ci.d/cirrus.yml
+++ /dev/null
@@ -1,32 +0,0 @@
-# Jobs that we delegate to Cirrus CI because they require an operating
-# system other than Linux. These jobs will only run if the required
-# setup has been performed on the GitLab account.
-#
-# The Cirrus CI configuration is generated by replacing target-specific
-# variables in a generic template: some of these variables are provided
-# when the GitLab CI job is defined, others are taken from a shell
-# snippet generated using lcitool.
-#
-# Note that the $PATH environment variable has to be treated with
-# special care, because we can't just override it at the GitLab CI job
-# definition level or we risk breaking it completely.
-.cirrus_build_job:
-  extends: .base_job_template
-  stage: build
-  image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:latest
-  needs: []
-  allow_failure:
-    exit_codes: 3
-  # 20 mins larger than "timeout_in" in cirrus/build.yml
-  # as there's often a 5-10 minute delay before Cirrus CI
-  # actually starts the task
-  timeout: 80m
-  script:
-    - set -o allexport
-    - source .gitlab-ci.d/cirrus/$NAME.vars
-    - set +o allexport
-    - cirrus-vars <.gitlab-ci.d/cirrus/build.yml >.gitlab-ci.d/cirrus/$NAME.yml
-    - cat .gitlab-ci.d/cirrus/$NAME.yml
-    - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
-  variables:
-    QEMU_JOB_CIRRUS: 1
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
deleted file mode 100644
index 41abd0b31a..0000000000
--- a/.gitlab-ci.d/cirrus/build.yml
+++ /dev/null
@@ -1,42 +0,0 @@
-@CIRRUS_VM_INSTANCE_TYPE@:
-  @CIRRUS_VM_IMAGE_SELECTOR@: @CIRRUS_VM_IMAGE_NAME@
-  cpu: @CIRRUS_VM_CPUS@
-  memory: @CIRRUS_VM_RAM@
-
-env:
-  CIRRUS_CLONE_DEPTH: 1
-  CI_REPOSITORY_URL: "@CI_REPOSITORY_URL@"
-  CI_COMMIT_REF_NAME: "@CI_COMMIT_REF_NAME@"
-  CI_COMMIT_SHA: "@CI_COMMIT_SHA@"
-  PATH: "@PATH_EXTRA@:$PATH"
-  PKG_CONFIG_PATH: "@PKG_CONFIG_PATH@"
-  PYTHON: "@PYTHON@"
-  MAKE: "@MAKE@"
-  CONFIGURE_ARGS: "@CONFIGURE_ARGS@"
-  TEST_TARGETS: "@TEST_TARGETS@"
-
-build_task:
-  # A little shorter than GitLab timeout in ../cirrus.yml
-  timeout_in: 60m
-  install_script:
-    - @UPDATE_COMMAND@
-    - @INSTALL_COMMAND@ @PKGS@
-    - if test -n "@PYPI_PKGS@" ; then PYLIB=$(@PYTHON@ -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi
-  clone_script:
-    - git clone --depth 100 "$CI_REPOSITORY_URL" .
-    - git fetch origin "$CI_COMMIT_REF_NAME"
-    - git reset --hard "$CI_COMMIT_SHA"
-  step_script:
-    - mkdir build
-    - cd build
-    - ../configure --enable-werror $CONFIGURE_ARGS
-      || { cat config.log meson-logs/meson-log.txt; exit 1; }
-    - $MAKE -j$(sysctl -n hw.ncpu)
-    - for TARGET in $TEST_TARGETS ;
-      do
-        $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=1 ;
-      done
-  always:
-    build_result_artifacts:
-      path: build/meson-logs/*log.txt
-      type: text/plain
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml
index 9cbb5fe787..104a147b2d 100644
--- a/.gitlab-ci.d/qemu-project.yml
+++ b/.gitlab-ci.d/qemu-project.yml
@@ -17,6 +17,5 @@ include:
   - local: '/.gitlab-ci.d/buildtest.yml'
   - local: '/.gitlab-ci.d/static_checks.yml'
   - local: '/.gitlab-ci.d/custom-runners.yml'
-  - local: '/.gitlab-ci.d/cirrus.yml'
   - local: '/.gitlab-ci.d/windows.yml'
   - local: '/.gitlab-ci.d/macos.yml'
diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index f1c70344ec..d5b081978a 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -91,12 +91,6 @@ Maintainer controlled job variables
 The following variables may be set when defining a job in the
 CI configuration file.
 
-QEMU_JOB_CIRRUS
-~~~~~~~~~~~~~~~
-
-The job makes use of Cirrus CI infrastructure, requiring the
-configuration setup for cirrus-run to be present in the repository
-
 QEMU_JOB_OPTIONAL
 ~~~~~~~~~~~~~~~~~
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e903a33f7a..fa545cf1f4 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -81,12 +81,6 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
     generate(filename, cmd, trailer)
 
 
-def generate_cirrus(target, trailer=None):
-    filename = Path(src_dir, ".gitlab-ci.d", "cirrus", target + ".vars")
-    cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
-    generate(filename, cmd, trailer)
-
-
 def generate_vars(target, trailer=None):
     filename = Path(src_dir, ".gitlab-ci.d", target + ".vars")
     cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
-- 
2.54.0



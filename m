Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C552CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVAd-0004oJ-FT; Sat, 13 Jun 2026 16:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAb-0004bc-1n; Sat, 13 Jun 2026 16:41:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAY-00056X-Ge; Sat, 13 Jun 2026 16:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=WpsrbVsZQk8gvShA9vq/22yy5WfUAbdU37e8V5+3KFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PRiOWR/PGSZSwtR8Cbe1lM74JpB8FJnmCy2k7rdeawmTBu2+ZuktkiRiqQyOd8/Vc
 b9Z6MP0mw55Yn+D41P4fgvmIoqa6yVIiUKF2GkrMPhDDUSqmxR8i9oohIKiU9jg6go
 hMhmGf0vE7lxMkIU6+UlvaSCgzDzlur5IltBvIZOqw57axjYVVsOwwASDXIJ/hWpia
 DtQllKhUnaY+C/p72GJXPbr+TDiPAnGwiIVgi1MrFCe2DVEgaCbfPdrPX2iz5qrtI+
 wtW8hS1KgrK/yEqxLKcLww14YULhy9od8Fgpz5f7WzPb/IsTtFdvsDRY4FszxeHxqO
 JE0U3vq1+ecZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E237B1B6F19;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 546813CE963;
 Sat, 13 Jun 2026 23:36:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 55/72] lcitool: remove Cirrus CI support
Date: Sat, 13 Jun 2026 23:35:21 +0300
Message-ID: <20260613203542.1809153-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Remove GitLab CI integration for Cirrus CI now that nothing uses it
anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260602162457.828969-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
 
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 0662766b5c..e929ab3ec9 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -516,8 +516,8 @@ mappings to distribution package names for a wide variety of third
 party projects.  ``lcitool`` applies the mappings to a list of build
 pre-requisites in ``tests/lcitool/projects/qemu.yml``, determines the
 list of native packages to install on each distribution, and uses them
-to generate build environments (dockerfiles and Cirrus CI variable files)
-that are consistent across OS distribution.
+to generate build environments (dockerfiles) that are consistent across OS
+distribution.
 
 
 Adding new build pre-requisites
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index ad6a1e6fe8..0ccce6d5be 100755
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
2.47.3



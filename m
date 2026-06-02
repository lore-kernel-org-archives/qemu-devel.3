Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCDECD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUTik-0001zX-FL; Tue, 02 Jun 2026 14:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wUTie-0001vZ-Ma
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:20:04 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wUTiZ-0001nb-KR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:20:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so5326286a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 11:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424395; cv=none;
 d=google.com; s=arc-20240605;
 b=CDYXTUvX35IhB4JwjeG93iHtJi84Xyo/zfo+hJGiQOXjKfQxmYh12Hww35FUfOOpG/
 CJJSvCXv9Ssid44a0rh9HHqkywOlKsvXH5fhGhETjamV+oX8Fx8eAWhrKs2cC9Xjz/Sz
 8AQ+L/slGR3Ri9v570vt05lNjLjD4g6yz/a2tql2arbVUk9+IiJZliNGlqSZANwsuFsg
 ZAiUuVB3UugrLF/Xl90qvr6w93Y7yYLQZX7M6RPorfOqU5lgl9qSMQ7oktkj58rrcc6X
 TNGfRsFBq2LqYdEtv5pLyDjbw5w1UKH6k8kZgYmCPnXRcDaHCvG5fnmogNrl/4mSWpJp
 cs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sVus9xNq3ZfpAnVki8p30l7CFYI9Tr7UfON16FvlRac=;
 fh=UJHGz5Bqv9TXg4CfWcRzGmrP6GGdI6iJit9KQITBKh8=;
 b=ilz492jXfiaN0gAyoj7rh8PFKr/9M26PvvZVt9cqEWcudy64MVXNdy8KdS+Bgos1Sz
 rVNaCa4zpkY2L/izSco3jUMjGj3kfBOBaKW9Fl7C+oTbtJ20hKoqexTvGAJItmHcjy8n
 mDsgUOjJ2turDrujJeMMTM8azNFNsRf1eRKv4tfn9wksTDCCPNM8GnJmFbPFbE93FTke
 jOBNxAhIUwHi7DbEIJO1h3EFZfCEOp+Ok9bOFZ/lIhPN9Mat6i4w4LYuNiLs4iU1jPZO
 gKiTt0uD4JUxzGZF5I87Dw0TlLxmjZqkd49DUVJgAsQDlzi6dQ5M0WlizEJc3JgIPs59
 pPIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780424395; x=1781029195;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sVus9xNq3ZfpAnVki8p30l7CFYI9Tr7UfON16FvlRac=;
 b=tij4sL2jRV37MIS1nkSnfqlQaC7xEOSqM4LAEcKoh5E+KRo9iae+JNOu2ZycIjJ2pR
 0BtKWo765aOO/x2nrXpTgXrRsJQe0BS3tdEuBOhyzf/r60vOqZAUVCMUDMT5njvLSNhb
 crGPspkV6UxDsjiJ1TkPNkSi9PGGFvdxPtrRIg7OCxjbj+mZZbZnHBRh87LgWlA/NDcp
 p1bX6Ao0cn0NrlDdzc0NCh0XF/jshlFe6DyqUs0Fztic0+FTF16MRLTDuREMP7NgWG0r
 euskz/94kVVhC9ztFZps0RVNUIiYrkQOCHDWAah6in23PUqSGRlWNtjJaGwmck5+4YJm
 VWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424395; x=1781029195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVus9xNq3ZfpAnVki8p30l7CFYI9Tr7UfON16FvlRac=;
 b=Nz9QqZEgqfNBP5TGIBGHld4qZETU+AwYriNaZROL8uizg5rjbuuY7HmyRs9RJQayex
 XzKKGLRVCzUAXef0O6sirE2rZik/rU7Ax8ouQ0iQ+St2SJygCSLkbAZnKzxT6Ld4TOy4
 ws/+mkNGQb+MKkcO8NPxH8VU5+1SVlxCTjbN7l2+tb5fZ56ItvWam2OU8qkoPG+PD2rp
 ZsUfRTK5BD1akElUw3C00iUzjudCNMOwiwSTlyzAraOeBmJXlf01Bto4p2PQ0yrBKTgK
 QNRxsceDnARA7rjjVD3quO3dR+975YExt7ng/12WYIDSm2qnuuxFdV2DVq0HxHmpnFH8
 yiXQ==
X-Gm-Message-State: AOJu0Yzdo/zC4DQGpokV5+rOz91CMvQBQv3FPEwD/0ozbInfpV0T3hGQ
 6gAvmoI+/SxdEkSu8NxsMMWmEdjZx/CiemEnC5oN53MAL/CjjFwouusztmFmZ2XruFI26yGisWf
 tRL7eD9Hk2OkQxEx0mPXK5uXcvEjJfpTQnoB8p9IOoQ==
X-Gm-Gg: Acq92OFiDr6EJnFHnMfunCvwQImpQe/79PbceJFDqZ9VqDIuqO2agMfYE2ggU5///3E
 0GWd02oub4zADs07O15u5mg+X/2pffENTavg9pwwxuM2ZgBb/PjkirmcYZpJlOx5KmZfvrNU4BU
 alibO10wAVdJZ3Ag8GyZplwSqlU6gk1IRLEoHnYrwMTJfNMaMqVwm226yX+8eVLJWEz6chpVWcq
 s/z+82X4uKMWfZquLjg2VQOjb9vbKiiMswECC0Q7SyK2T0H0f45+CREyJBY/M4vN4g1Lwxi9aFN
 kkHVyrfLj2vnW0LWUwcbu/T+56yjyg==
X-Received: by 2002:a17:90b:574e:b0:36d:635a:ac1b with SMTP id
 98e67ed59e1d1-36d635ab5e9mr13747606a91.22.1780424394695; Tue, 02 Jun 2026
 11:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-3-stefanha@redhat.com>
In-Reply-To: <20260602162457.828969-3-stefanha@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 2 Jun 2026 11:19:43 -0700
X-Gm-Features: AVHnY4Ly3ph0zWeIFkMnAc5bt1qOhHXqcPH9LMigNiVR4bHLSlNJ6QAkIw77mj8
Message-ID: <CANCZdfofyp+qWbGvnye05trnWpEbuFb5ZEogb8BgBFmgocLd+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] lcitool: remove Cirrus CI support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000009875470653495b2c"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000009875470653495b2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 9:25=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> Remove GitLab CI integration for Cirrus CI now that nothing uses it
> anymore.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .gitlab-ci.d/cirrus/README.rst     | 54 ------------------------------
>  docs/devel/testing/main.rst        |  4 +--
>  .gitlab-ci.d/base.yml              |  4 ---
>  .gitlab-ci.d/cirrus.yml            | 32 ------------------
>  .gitlab-ci.d/cirrus/build.yml      | 42 -----------------------
>  .gitlab-ci.d/qemu-project.yml      |  1 -
>  docs/devel/testing/ci-jobs.rst.inc |  6 ----
>  tests/lcitool/refresh              |  6 ----
>  8 files changed, 2 insertions(+), 147 deletions(-)
>  delete mode 100644 .gitlab-ci.d/cirrus/README.rst
>  delete mode 100644 .gitlab-ci.d/cirrus.yml
>  delete mode 100644 .gitlab-ci.d/cirrus/build.yml
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/.gitlab-ci.d/cirrus/README.rst
> b/.gitlab-ci.d/cirrus/README.rst
> deleted file mode 100644
> index 657b0706d7..0000000000
> --- a/.gitlab-ci.d/cirrus/README.rst
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -Cirrus CI integration
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -GitLab CI shared runners only provide a docker environment running on
> Linux.
> -While it is possible to provide private runners for non-Linux platforms
> this
> -is not something most contributors/maintainers will wish to do.
> -
> -To work around this limitation, we take advantage of `Cirrus CI`_'s free
> -offering: more specifically, we use the `cirrus-run`_ script to trigger
> Cirrus
> -CI jobs from GitLab CI jobs so that Cirrus CI job output is integrated
> into
> -the main GitLab CI pipeline dashboard.
> -
> -There is, however, some one-time setup required. If you want FreeBSD and
> macOS
> -builds to happen when you push to your GitLab repository, you need to
> -
> -* set up a GitHub repository for the project, eg. ``yourusername/qemu``.
> -  This repository needs to exist for cirrus-run to work, but it doesn't
> need to
> -  be kept up to date, so you can create it and then forget about it;
> -
> -* enable the `Cirrus CI GitHub app`_  for your GitHub account;
> -
> -* sign up for Cirrus CI. It's enough to log into the website using your
> GitHub
> -  account;
> -
> -* grab an API token from the `Cirrus CI settings`_ page;
> -
> -* it may be necessary to push an empty ``.cirrus.yml`` file to your
> github fork
> -  for Cirrus CI to properly recognize the project. You can check whether
> -  Cirrus CI knows about your project by navigating to:
> -
> -  ``https://cirrus-ci.com/yourusername/qemu``
> <https://cirrus-ci.com/yourusername/qemu>
> -
> -* in the *CI/CD / Variables* section of the settings page for your GitLa=
b
> -  repository, create two new variables:
> -
> -  * ``CIRRUS_GITHUB_REPO``, containing the name of the GitHub repository
> -    created earlier, eg. ``yourusername/qemu``;
> -
> -  * ``CIRRUS_API_TOKEN``, containing the Cirrus CI API token generated
> earlier.
> -    This variable **must** be marked as *Masked*, because anyone with
> knowledge
> -    of it can impersonate you as far as Cirrus CI is concerned.
> -
> -  Neither of these variables should be marked as *Protected*, because in
> -  general you'll want to be able to trigger Cirrus CI builds from
> non-protected
> -  branches.
> -
> -Once this one-time setup is complete, you can just keep pushing to your
> GitLab
> -repository as usual and you'll automatically get the additional CI
> coverage.
> -
> -
> -.. _Cirrus CI GitHub app: https://github.com/marketplace/cirrus-ci
> -.. _Cirrus CI settings: https://cirrus-ci.com/settings/profile/
> -.. _Cirrus CI: https://cirrus-ci.com/
> -.. _cirrus-run: https://github.com/sio/cirrus-run/
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index c0321d1d25..3408b5836d 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -551,8 +551,8 @@ mappings to distribution package names for a wide
> variety of third
>  party projects.  ``lcitool`` applies the mappings to a list of build
>  pre-requisites in ``tests/lcitool/projects/qemu.yml``, determines the
>  list of native packages to install on each distribution, and uses them
> -to generate build environments (dockerfiles and Cirrus CI variable files=
)
> -that are consistent across OS distribution.
> +to generate build environments (dockerfiles) that are consistent across =
OS
> +distribution.
>
>
>  Adding new build pre-requisites
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 7640a1d52c..72eadc8073 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -52,10 +52,6 @@ variables:
>      - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule"'
>        when: never
>
> -    # Cirrus jobs can't run unless the creds / target repo are set
> -    - if: '$QEMU_JOB_CIRRUS && ($CIRRUS_GITHUB_REPO =3D=3D null ||
> $CIRRUS_API_TOKEN =3D=3D null)'
> -      when: never
> -
>      # Publishing jobs should only run on the default branch in upstream
>      - if: '$QEMU_JOB_PUBLISH =3D=3D "1" && $CI_PROJECT_NAMESPACE =3D=3D
> $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH !=3D $CI_DEFAULT_BRANCH'
>        when: never
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> deleted file mode 100644
> index 4769d00c67..0000000000
> --- a/.gitlab-ci.d/cirrus.yml
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -# Jobs that we delegate to Cirrus CI because they require an operating
> -# system other than Linux. These jobs will only run if the required
> -# setup has been performed on the GitLab account.
> -#
> -# The Cirrus CI configuration is generated by replacing target-specific
> -# variables in a generic template: some of these variables are provided
> -# when the GitLab CI job is defined, others are taken from a shell
> -# snippet generated using lcitool.
> -#
> -# Note that the $PATH environment variable has to be treated with
> -# special care, because we can't just override it at the GitLab CI job
> -# definition level or we risk breaking it completely.
> -.cirrus_build_job:
> -  extends: .base_job_template
> -  stage: build
> -  image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:latest
> -  needs: []
> -  allow_failure:
> -    exit_codes: 3
> -  # 20 mins larger than "timeout_in" in cirrus/build.yml
> -  # as there's often a 5-10 minute delay before Cirrus CI
> -  # actually starts the task
> -  timeout: 80m
> -  script:
> -    - set -o allexport
> -    - source .gitlab-ci.d/cirrus/$NAME.vars
> -    - set +o allexport
> -    - cirrus-vars <.gitlab-ci.d/cirrus/build.yml
> >.gitlab-ci.d/cirrus/$NAME.yml
> -    - cat .gitlab-ci.d/cirrus/$NAME.yml
> -    - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.ym=
l
> -  variables:
> -    QEMU_JOB_CIRRUS: 1
> diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.ym=
l
> deleted file mode 100644
> index 41abd0b31a..0000000000
> --- a/.gitlab-ci.d/cirrus/build.yml
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -@CIRRUS_VM_INSTANCE_TYPE@:
> -  @CIRRUS_VM_IMAGE_SELECTOR@: @CIRRUS_VM_IMAGE_NAME@
> -  cpu: @CIRRUS_VM_CPUS@
> -  memory: @CIRRUS_VM_RAM@
> -
> -env:
> -  CIRRUS_CLONE_DEPTH: 1
> -  CI_REPOSITORY_URL: "@CI_REPOSITORY_URL@"
> -  CI_COMMIT_REF_NAME: "@CI_COMMIT_REF_NAME@"
> -  CI_COMMIT_SHA: "@CI_COMMIT_SHA@"
> -  PATH: "@PATH_EXTRA@:$PATH"
> -  PKG_CONFIG_PATH: "@PKG_CONFIG_PATH@"
> -  PYTHON: "@PYTHON@"
> -  MAKE: "@MAKE@"
> -  CONFIGURE_ARGS: "@CONFIGURE_ARGS@"
> -  TEST_TARGETS: "@TEST_TARGETS@"
> -
> -build_task:
> -  # A little shorter than GitLab timeout in ../cirrus.yml
> -  timeout_in: 60m
> -  install_script:
> -    - @UPDATE_COMMAND@
> -    - @INSTALL_COMMAND@ @PKGS@
> -    - if test -n "@PYPI_PKGS@" ; then PYLIB=3D$(@PYTHON@ -c 'import
> sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f
> $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi
> -  clone_script:
> -    - git clone --depth 100 "$CI_REPOSITORY_URL" .
> -    - git fetch origin "$CI_COMMIT_REF_NAME"
> -    - git reset --hard "$CI_COMMIT_SHA"
> -  step_script:
> -    - mkdir build
> -    - cd build
> -    - ../configure --enable-werror $CONFIGURE_ARGS
> -      || { cat config.log meson-logs/meson-log.txt; exit 1; }
> -    - $MAKE -j$(sysctl -n hw.ncpu)
> -    - for TARGET in $TEST_TARGETS ;
> -      do
> -        $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=3D1 ;
> -      done
> -  always:
> -    build_result_artifacts:
> -      path: build/meson-logs/*log.txt
> -      type: text/plain
> diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.ym=
l
> index 9cbb5fe787..104a147b2d 100644
> --- a/.gitlab-ci.d/qemu-project.yml
> +++ b/.gitlab-ci.d/qemu-project.yml
> @@ -17,6 +17,5 @@ include:
>    - local: '/.gitlab-ci.d/buildtest.yml'
>    - local: '/.gitlab-ci.d/static_checks.yml'
>    - local: '/.gitlab-ci.d/custom-runners.yml'
> -  - local: '/.gitlab-ci.d/cirrus.yml'
>    - local: '/.gitlab-ci.d/windows.yml'
>    - local: '/.gitlab-ci.d/macos.yml'
> diff --git a/docs/devel/testing/ci-jobs.rst.inc
> b/docs/devel/testing/ci-jobs.rst.inc
> index f1c70344ec..d5b081978a 100644
> --- a/docs/devel/testing/ci-jobs.rst.inc
> +++ b/docs/devel/testing/ci-jobs.rst.inc
> @@ -91,12 +91,6 @@ Maintainer controlled job variables
>  The following variables may be set when defining a job in the
>  CI configuration file.
>
> -QEMU_JOB_CIRRUS
> -~~~~~~~~~~~~~~~
> -
> -The job makes use of Cirrus CI infrastructure, requiring the
> -configuration setup for cirrus-run to be present in the repository
> -
>  QEMU_JOB_OPTIONAL
>  ~~~~~~~~~~~~~~~~~
>
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index e903a33f7a..fa545cf1f4 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -81,12 +81,6 @@ def generate_dockerfile(host, target, project=3D"qemu"=
,
> cross=3DNone, trailer=3DNone,
>      generate(filename, cmd, trailer)
>
>
> -def generate_cirrus(target, trailer=3DNone):
> -    filename =3D Path(src_dir, ".gitlab-ci.d", "cirrus", target + ".vars=
")
> -    cmd =3D lcitool_cmd + ["variables", "--format", "shell", target, "qe=
mu"]
> -    generate(filename, cmd, trailer)
> -
> -
>  def generate_vars(target, trailer=3DNone):
>      filename =3D Path(src_dir, ".gitlab-ci.d", target + ".vars")
>      cmd =3D lcitool_cmd + ["variables", "--format", "shell", target, "qe=
mu"]
> --
> 2.54.0
>
>

--0000000000009875470653495b2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 2, =
2026 at 9:25=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redh=
at.com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Remove GitLab CI integration for Cirrus CI now t=
hat nothing uses it<br>
anymore.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0.gitlab-ci.d/cirrus/README.rst=C2=A0 =C2=A0 =C2=A0| 54 --------------=
----------------<br>
=C2=A0docs/devel/testing/main.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +--<=
br>
=C2=A0.gitlab-ci.d/base.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 4 ---<br>
=C2=A0.gitlab-ci.d/cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32=
 ------------------<br>
=C2=A0.gitlab-ci.d/cirrus/build.yml=C2=A0 =C2=A0 =C2=A0 | 42 --------------=
---------<br>
=C2=A0.gitlab-ci.d/qemu-project.yml=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0docs/devel/testing/ci-jobs.rst.inc |=C2=A0 6 ----<br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 6 ----<br>
=C2=A08 files changed, 2 insertions(+), 147 deletions(-)<br>
=C2=A0delete mode 100644 .gitlab-ci.d/cirrus/README.rst<br>
=C2=A0delete mode 100644 .gitlab-ci.d/cirrus.yml<br>
=C2=A0delete mode 100644 .gitlab-ci.d/cirrus/build.yml<br></blockquote><div=
><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.c=
om">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
diff --git a/.gitlab-ci.d/cirrus/README.rst b/.gitlab-ci.d/cirrus/README.rs=
t<br>
deleted file mode 100644<br>
index 657b0706d7..0000000000<br>
--- a/.gitlab-ci.d/cirrus/README.rst<br>
+++ /dev/null<br>
@@ -1,54 +0,0 @@<br>
-Cirrus CI integration<br>
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
-<br>
-GitLab CI shared runners only provide a docker environment running on Linu=
x.<br>
-While it is possible to provide private runners for non-Linux platforms th=
is<br>
-is not something most contributors/maintainers will wish to do.<br>
-<br>
-To work around this limitation, we take advantage of `Cirrus CI`_&#39;s fr=
ee<br>
-offering: more specifically, we use the `cirrus-run`_ script to trigger Ci=
rrus<br>
-CI jobs from GitLab CI jobs so that Cirrus CI job output is integrated int=
o<br>
-the main GitLab CI pipeline dashboard.<br>
-<br>
-There is, however, some one-time setup required. If you want FreeBSD and m=
acOS<br>
-builds to happen when you push to your GitLab repository, you need to<br>
-<br>
-* set up a GitHub repository for the project, eg. ``yourusername/qemu``.<b=
r>
-=C2=A0 This repository needs to exist for cirrus-run to work, but it doesn=
&#39;t need to<br>
-=C2=A0 be kept up to date, so you can create it and then forget about it;<=
br>
-<br>
-* enable the `Cirrus CI GitHub app`_=C2=A0 for your GitHub account;<br>
-<br>
-* sign up for Cirrus CI. It&#39;s enough to log into the website using you=
r GitHub<br>
-=C2=A0 account;<br>
-<br>
-* grab an API token from the `Cirrus CI settings`_ page;<br>
-<br>
-* it may be necessary to push an empty ``.cirrus.yml`` file to your github=
 fork<br>
-=C2=A0 for Cirrus CI to properly recognize the project. You can check whet=
her<br>
-=C2=A0 Cirrus CI knows about your project by navigating to:<br>
-<br>
-=C2=A0 ``<a href=3D"https://cirrus-ci.com/yourusername/qemu" rel=3D"norefe=
rrer" target=3D"_blank">https://cirrus-ci.com/yourusername/qemu``</a><br>
-<br>
-* in the *CI/CD / Variables* section of the settings page for your GitLab<=
br>
-=C2=A0 repository, create two new variables:<br>
-<br>
-=C2=A0 * ``CIRRUS_GITHUB_REPO``, containing the name of the GitHub reposit=
ory<br>
-=C2=A0 =C2=A0 created earlier, eg. ``yourusername/qemu``;<br>
-<br>
-=C2=A0 * ``CIRRUS_API_TOKEN``, containing the Cirrus CI API token generate=
d earlier.<br>
-=C2=A0 =C2=A0 This variable **must** be marked as *Masked*, because anyone=
 with knowledge<br>
-=C2=A0 =C2=A0 of it can impersonate you as far as Cirrus CI is concerned.<=
br>
-<br>
-=C2=A0 Neither of these variables should be marked as *Protected*, because=
 in<br>
-=C2=A0 general you&#39;ll want to be able to trigger Cirrus CI builds from=
 non-protected<br>
-=C2=A0 branches.<br>
-<br>
-Once this one-time setup is complete, you can just keep pushing to your Gi=
tLab<br>
-repository as usual and you&#39;ll automatically get the additional CI cov=
erage.<br>
-<br>
-<br>
-.. _Cirrus CI GitHub app: <a href=3D"https://github.com/marketplace/cirrus=
-ci" rel=3D"noreferrer" target=3D"_blank">https://github.com/marketplace/ci=
rrus-ci</a><br>
-.. _Cirrus CI settings: <a href=3D"https://cirrus-ci.com/settings/profile/=
" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.com/settings/profi=
le/</a><br>
-.. _Cirrus CI: <a href=3D"https://cirrus-ci.com/" rel=3D"noreferrer" targe=
t=3D"_blank">https://cirrus-ci.com/</a><br>
-.. _cirrus-run: <a href=3D"https://github.com/sio/cirrus-run/" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/sio/cirrus-run/</a><br>
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst<br>
index c0321d1d25..3408b5836d 100644<br>
--- a/docs/devel/testing/main.rst<br>
+++ b/docs/devel/testing/main.rst<br>
@@ -551,8 +551,8 @@ mappings to distribution package names for a wide varie=
ty of third<br>
=C2=A0party projects.=C2=A0 ``lcitool`` applies the mappings to a list of b=
uild<br>
=C2=A0pre-requisites in ``tests/lcitool/projects/qemu.yml``, determines the=
<br>
=C2=A0list of native packages to install on each distribution, and uses the=
m<br>
-to generate build environments (dockerfiles and Cirrus CI variable files)<=
br>
-that are consistent across OS distribution.<br>
+to generate build environments (dockerfiles) that are consistent across OS=
<br>
+distribution.<br>
<br>
<br>
=C2=A0Adding new build pre-requisites<br>
diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml<br>
index 7640a1d52c..72eadc8073 100644<br>
--- a/.gitlab-ci.d/base.yml<br>
+++ b/.gitlab-ci.d/base.yml<br>
@@ -52,10 +52,6 @@ variables:<br>
=C2=A0 =C2=A0 =C2=A0- if: &#39;$CI_PIPELINE_SOURCE =3D=3D &quot;schedule&qu=
ot;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0when: never<br>
<br>
-=C2=A0 =C2=A0 # Cirrus jobs can&#39;t run unless the creds / target repo a=
re set<br>
-=C2=A0 =C2=A0 - if: &#39;$QEMU_JOB_CIRRUS &amp;&amp; ($CIRRUS_GITHUB_REPO =
=3D=3D null || $CIRRUS_API_TOKEN =3D=3D null)&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 when: never<br>
-<br>
=C2=A0 =C2=A0 =C2=A0# Publishing jobs should only run on the default branch=
 in upstream<br>
=C2=A0 =C2=A0 =C2=A0- if: &#39;$QEMU_JOB_PUBLISH =3D=3D &quot;1&quot; &amp;=
&amp; $CI_PROJECT_NAMESPACE =3D=3D $QEMU_CI_UPSTREAM &amp;&amp; $CI_COMMIT_=
BRANCH !=3D $CI_DEFAULT_BRANCH&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0when: never<br>
diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml<br>
deleted file mode 100644<br>
index 4769d00c67..0000000000<br>
--- a/.gitlab-ci.d/cirrus.yml<br>
+++ /dev/null<br>
@@ -1,32 +0,0 @@<br>
-# Jobs that we delegate to Cirrus CI because they require an operating<br>
-# system other than Linux. These jobs will only run if the required<br>
-# setup has been performed on the GitLab account.<br>
-#<br>
-# The Cirrus CI configuration is generated by replacing target-specific<br=
>
-# variables in a generic template: some of these variables are provided<br=
>
-# when the GitLab CI job is defined, others are taken from a shell<br>
-# snippet generated using lcitool.<br>
-#<br>
-# Note that the $PATH environment variable has to be treated with<br>
-# special care, because we can&#39;t just override it at the GitLab CI job=
<br>
-# definition level or we risk breaking it completely.<br>
-.cirrus_build_job:<br>
-=C2=A0 extends: .base_job_template<br>
-=C2=A0 stage: build<br>
-=C2=A0 image: <a href=3D"http://registry.gitlab.com/libvirt/libvirt-ci/cir=
rus-run:latest" rel=3D"noreferrer" target=3D"_blank">registry.gitlab.com/li=
bvirt/libvirt-ci/cirrus-run:latest</a><br>
-=C2=A0 needs: []<br>
-=C2=A0 allow_failure:<br>
-=C2=A0 =C2=A0 exit_codes: 3<br>
-=C2=A0 # 20 mins larger than &quot;timeout_in&quot; in cirrus/build.yml<br=
>
-=C2=A0 # as there&#39;s often a 5-10 minute delay before Cirrus CI<br>
-=C2=A0 # actually starts the task<br>
-=C2=A0 timeout: 80m<br>
-=C2=A0 script:<br>
-=C2=A0 =C2=A0 - set -o allexport<br>
-=C2=A0 =C2=A0 - source .gitlab-ci.d/cirrus/$NAME.vars<br>
-=C2=A0 =C2=A0 - set +o allexport<br>
-=C2=A0 =C2=A0 - cirrus-vars &lt;.gitlab-ci.d/cirrus/build.yml &gt;.gitlab-=
ci.d/cirrus/$NAME.yml<br>
-=C2=A0 =C2=A0 - cat .gitlab-ci.d/cirrus/$NAME.yml<br>
-=C2=A0 =C2=A0 - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/=
$NAME.yml<br>
-=C2=A0 variables:<br>
-=C2=A0 =C2=A0 QEMU_JOB_CIRRUS: 1<br>
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml<=
br>
deleted file mode 100644<br>
index 41abd0b31a..0000000000<br>
--- a/.gitlab-ci.d/cirrus/build.yml<br>
+++ /dev/null<br>
@@ -1,42 +0,0 @@<br>
-@CIRRUS_VM_INSTANCE_TYPE@:<br>
-=C2=A0 @CIRRUS_VM_IMAGE_SELECTOR@: @CIRRUS_VM_IMAGE_NAME@<br>
-=C2=A0 cpu: @CIRRUS_VM_CPUS@<br>
-=C2=A0 memory: @CIRRUS_VM_RAM@<br>
-<br>
-env:<br>
-=C2=A0 CIRRUS_CLONE_DEPTH: 1<br>
-=C2=A0 CI_REPOSITORY_URL: &quot;@CI_REPOSITORY_URL@&quot;<br>
-=C2=A0 CI_COMMIT_REF_NAME: &quot;@CI_COMMIT_REF_NAME@&quot;<br>
-=C2=A0 CI_COMMIT_SHA: &quot;@CI_COMMIT_SHA@&quot;<br>
-=C2=A0 PATH: &quot;@PATH_EXTRA@:$PATH&quot;<br>
-=C2=A0 PKG_CONFIG_PATH: &quot;@PKG_CONFIG_PATH@&quot;<br>
-=C2=A0 PYTHON: &quot;@PYTHON@&quot;<br>
-=C2=A0 MAKE: &quot;@MAKE@&quot;<br>
-=C2=A0 CONFIGURE_ARGS: &quot;@CONFIGURE_ARGS@&quot;<br>
-=C2=A0 TEST_TARGETS: &quot;@TEST_TARGETS@&quot;<br>
-<br>
-build_task:<br>
-=C2=A0 # A little shorter than GitLab timeout in ../cirrus.yml<br>
-=C2=A0 timeout_in: 60m<br>
-=C2=A0 install_script:<br>
-=C2=A0 =C2=A0 - @UPDATE_COMMAND@<br>
-=C2=A0 =C2=A0 - @INSTALL_COMMAND@ @PKGS@<br>
-=C2=A0 =C2=A0 - if test -n &quot;@PYPI_PKGS@&quot; ; then PYLIB=3D$(@PYTHO=
N@ -c &#39;import sysconfig; print(sysconfig.get_path(&quot;stdlib&quot;))&=
#39;); rm -f $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi<br>
-=C2=A0 clone_script:<br>
-=C2=A0 =C2=A0 - git clone --depth 100 &quot;$CI_REPOSITORY_URL&quot; .<br>
-=C2=A0 =C2=A0 - git fetch origin &quot;$CI_COMMIT_REF_NAME&quot;<br>
-=C2=A0 =C2=A0 - git reset --hard &quot;$CI_COMMIT_SHA&quot;<br>
-=C2=A0 step_script:<br>
-=C2=A0 =C2=A0 - mkdir build<br>
-=C2=A0 =C2=A0 - cd build<br>
-=C2=A0 =C2=A0 - ../configure --enable-werror $CONFIGURE_ARGS<br>
-=C2=A0 =C2=A0 =C2=A0 || { cat config.log meson-logs/meson-log.txt; exit 1;=
 }<br>
-=C2=A0 =C2=A0 - $MAKE -j$(sysctl -n hw.ncpu)<br>
-=C2=A0 =C2=A0 - for TARGET in $TEST_TARGETS ;<br>
-=C2=A0 =C2=A0 =C2=A0 do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=3D1 ;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 done<br>
-=C2=A0 always:<br>
-=C2=A0 =C2=A0 build_result_artifacts:<br>
-=C2=A0 =C2=A0 =C2=A0 path: build/meson-logs/*log.txt<br>
-=C2=A0 =C2=A0 =C2=A0 type: text/plain<br>
diff --git a/.gitlab-ci.d/qemu-project.yml b/.gitlab-ci.d/qemu-project.yml<=
br>
index 9cbb5fe787..104a147b2d 100644<br>
--- a/.gitlab-ci.d/qemu-project.yml<br>
+++ b/.gitlab-ci.d/qemu-project.yml<br>
@@ -17,6 +17,5 @@ include:<br>
=C2=A0 =C2=A0- local: &#39;/.gitlab-ci.d/buildtest.yml&#39;<br>
=C2=A0 =C2=A0- local: &#39;/.gitlab-ci.d/static_checks.yml&#39;<br>
=C2=A0 =C2=A0- local: &#39;/.gitlab-ci.d/custom-runners.yml&#39;<br>
-=C2=A0 - local: &#39;/.gitlab-ci.d/cirrus.yml&#39;<br>
=C2=A0 =C2=A0- local: &#39;/.gitlab-ci.d/windows.yml&#39;<br>
=C2=A0 =C2=A0- local: &#39;/.gitlab-ci.d/macos.yml&#39;<br>
diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-job=
s.rst.inc<br>
index f1c70344ec..d5b081978a 100644<br>
--- a/docs/devel/testing/ci-jobs.rst.inc<br>
+++ b/docs/devel/testing/ci-jobs.rst.inc<br>
@@ -91,12 +91,6 @@ Maintainer controlled job variables<br>
=C2=A0The following variables may be set when defining a job in the<br>
=C2=A0CI configuration file.<br>
<br>
-QEMU_JOB_CIRRUS<br>
-~~~~~~~~~~~~~~~<br>
-<br>
-The job makes use of Cirrus CI infrastructure, requiring the<br>
-configuration setup for cirrus-run to be present in the repository<br>
-<br>
=C2=A0QEMU_JOB_OPTIONAL<br>
=C2=A0~~~~~~~~~~~~~~~~~<br>
<br>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
index e903a33f7a..fa545cf1f4 100755<br>
--- a/tests/lcitool/refresh<br>
+++ b/tests/lcitool/refresh<br>
@@ -81,12 +81,6 @@ def generate_dockerfile(host, target, project=3D&quot;qe=
mu&quot;, cross=3DNone, trailer=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0generate(filename, cmd, trailer)<br>
<br>
<br>
-def generate_cirrus(target, trailer=3DNone):<br>
-=C2=A0 =C2=A0 filename =3D Path(src_dir, &quot;.gitlab-ci.d&quot;, &quot;c=
irrus&quot;, target + &quot;.vars&quot;)<br>
-=C2=A0 =C2=A0 cmd =3D lcitool_cmd + [&quot;variables&quot;, &quot;--format=
&quot;, &quot;shell&quot;, target, &quot;qemu&quot;]<br>
-=C2=A0 =C2=A0 generate(filename, cmd, trailer)<br>
-<br>
-<br>
=C2=A0def generate_vars(target, trailer=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0filename =3D Path(src_dir, &quot;.gitlab-ci.d&quot;, ta=
rget + &quot;.vars&quot;)<br>
=C2=A0 =C2=A0 =C2=A0cmd =3D lcitool_cmd + [&quot;variables&quot;, &quot;--f=
ormat&quot;, &quot;shell&quot;, target, &quot;qemu&quot;]<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div></div>

--0000000000009875470653495b2c--


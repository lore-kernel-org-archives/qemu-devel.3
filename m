Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2049DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx7ws-0007R1-0d; Wed, 17 Apr 2024 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx7wk-0007QJ-Pn
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:15:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx7wh-0002pI-64
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713370532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tLMaeaBGfoPn6e1LP2X1xxgGs+uDX+Uy+KNnrSE8u0A=;
 b=TXxWKHVMaJaloTpFMJ88cGOJI0eF3Nqatk+Xk4Gn/NWife66IwLcbyXK2XJL6tr65nASG0
 iJ6DCBVdzc9awctjMz+WgBIE3McJuRDeSddbR4oTHrgC/MNy6BdfGoXSNO/YqmrYAeJF+Z
 yBOxSGq/iz35bPrheCQPfujejXvZ5lE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-I6PpvmjgMCqYOv7PFPV-Og-1; Wed, 17 Apr 2024 12:15:28 -0400
X-MC-Unique: I6PpvmjgMCqYOv7PFPV-Og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 404291049BCA;
 Wed, 17 Apr 2024 16:15:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CBC62026962;
 Wed, 17 Apr 2024 16:15:24 +0000 (UTC)
Date: Wed, 17 Apr 2024 17:15:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 04/13] tests: Update our CI to use CentOS Stream 9
 instead of 8
Message-ID: <Zh_1l1v13QG6fNF3@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240412132415.282354-5-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 12, 2024 at 03:24:06PM +0200, Thomas Huth wrote:
> RHEL 9 (and thus also the derivatives) are available since two years
> now, so according to QEMU's support policy, we can drop the active
> support for the previous major version 8 now.
> Thus upgrade our CentOS Stream container to major version 9 now.

The second reason for doing this is that Centos Stream 8
will go EOL in about 1 month:

https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/

  "After May 31, 2024, CentOS Stream 8 will be archived
   and no further updates will be provided."

I'm seeking confirmation, but I suspect after that date we
will be unable to build centos8 containers, as the package
repos will likely be archived.

RHEL-8 and other derivatives (Alma Linux, Rocky Linux,
etc) remain actively supported by their respective vendors
/ communities. Only CentOS Stream EOLs.


This has implications for our CI on stable branches. It is
valid for our stable branches to continue targetting the
RHEL-8 family of distros, as a 2 year cutoff in our support
policy is evaluated at time of each given major release.

IOW, cherry-picking this change to switch to CentOS Stream
9 is possibly inappropriate for stable branches.

lcitool supports Alma Linux as target, so we could switch
stable branches to Alma Linux 8 if desired to keep CI
coverage of RHEL-8 family.

Thoughts ?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml                    | 16 ++++-----
>  .gitlab-ci.d/container-core.yml               |  4 +--
>  .../{centos8.docker => centos9.docker}        | 34 +++++++------------
>  tests/lcitool/mappings.yml                    | 20 -----------
>  tests/lcitool/refresh                         |  2 +-
>  tests/vm/centos                               |  4 +--
>  6 files changed, 26 insertions(+), 54 deletions(-)
>  rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index cfdff175c3..9f34c650d6 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -158,9 +158,9 @@ build-system-centos:
>      - .native_build_job_template
>      - .native_build_artifact_template
>    needs:
> -    job: amd64-centos8-container
> +    job: amd64-centos9-container
>    variables:
> -    IMAGE: centos8
> +    IMAGE: centos9
>      CONFIGURE_ARGS: --disable-nettle --enable-gcrypt --enable-vfio-user-server
>        --enable-modules --enable-trace-backends=dtrace --enable-docs
>      TARGETS: ppc64-softmmu or1k-softmmu s390x-softmmu
> @@ -242,7 +242,7 @@ check-system-centos:
>      - job: build-system-centos
>        artifacts: true
>    variables:
> -    IMAGE: centos8
> +    IMAGE: centos9
>      MAKE_CHECK_ARGS: check
>  
>  avocado-system-centos:
> @@ -251,7 +251,7 @@ avocado-system-centos:
>      - job: build-system-centos
>        artifacts: true
>    variables:
> -    IMAGE: centos8
> +    IMAGE: centos9
>      MAKE_CHECK_ARGS: check-avocado
>      AVOCADO_TAGS: arch:ppc64 arch:or1k arch:s390x arch:x86_64 arch:rx
>        arch:sh4 arch:nios2
> @@ -327,9 +327,9 @@ avocado-system-flaky:
>  build-tcg-disabled:
>    extends: .native_build_job_template
>    needs:
> -    job: amd64-centos8-container
> +    job: amd64-centos9-container
>    variables:
> -    IMAGE: centos8
> +    IMAGE: centos9
>    script:
>      - mkdir build
>      - cd build
> @@ -651,9 +651,9 @@ build-tci:
>  build-without-defaults:
>    extends: .native_build_job_template
>    needs:
> -    job: amd64-centos8-container
> +    job: amd64-centos9-container
>    variables:
> -    IMAGE: centos8
> +    IMAGE: centos9
>      CONFIGURE_ARGS:
>        --without-default-devices
>        --without-default-features
> diff --git a/.gitlab-ci.d/container-core.yml b/.gitlab-ci.d/container-core.yml
> index 08f8450fa1..5459447676 100644
> --- a/.gitlab-ci.d/container-core.yml
> +++ b/.gitlab-ci.d/container-core.yml
> @@ -1,10 +1,10 @@
>  include:
>    - local: '/.gitlab-ci.d/container-template.yml'
>  
> -amd64-centos8-container:
> +amd64-centos9-container:
>    extends: .container_job_template
>    variables:
> -    NAME: centos8
> +    NAME: centos9
>  
>  amd64-fedora-container:
>    extends: .container_job_template
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos9.docker
> similarity index 82%
> rename from tests/docker/dockerfiles/centos8.docker
> rename to tests/docker/dockerfiles/centos9.docker
> index ea618bf352..6cf47ce786 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos9.docker
> @@ -1,15 +1,14 @@
>  # THIS FILE WAS AUTO-GENERATED
>  #
> -#  $ lcitool dockerfile --layers all centos-stream-8 qemu
> +#  $ lcitool dockerfile --layers all centos-stream-9 qemu
>  #
>  # https://gitlab.com/libvirt/libvirt-ci
>  
> -FROM quay.io/centos/centos:stream8
> +FROM quay.io/centos/centos:stream9
>  
>  RUN dnf distro-sync -y && \
>      dnf install 'dnf-command(config-manager)' -y && \
> -    dnf config-manager --set-enabled -y powertools && \
> -    dnf install -y centos-release-advanced-virtualization && \
> +    dnf config-manager --set-enabled -y crb && \
>      dnf install -y epel-release && \
>      dnf install -y epel-next-release && \
>      dnf install -y \
> @@ -42,7 +41,6 @@ RUN dnf distro-sync -y && \
>          glib2-static \
>          glibc-langpack-en \
>          glibc-static \
> -        glusterfs-api-devel \
>          gnutls-devel \
>          gtk3-devel \
>          hostname \
> @@ -82,6 +80,7 @@ RUN dnf distro-sync -y && \
>          lzo-devel \
>          make \
>          mesa-libgbm-devel \
> +        meson \
>          mtools \
>          ncurses-devel \
>          nettle-devel \
> @@ -95,25 +94,25 @@ RUN dnf distro-sync -y && \
>          pixman-devel \
>          pkgconfig \
>          pulseaudio-libs-devel \
> -        python38 \
> -        python38-PyYAML \
> -        python38-numpy \
> -        python38-pip \
> -        python38-setuptools \
> -        python38-wheel \
> +        python3 \
> +        python3-PyYAML \
> +        python3-numpy \
> +        python3-pillow \
> +        python3-pip \
> +        python3-sphinx \
> +        python3-sphinx_rtd_theme \
> +        python3-tomli \
>          rdma-core-devel \
>          sed \
>          snappy-devel \
>          socat \
>          spice-protocol \
> -        spice-server-devel \
>          swtpm \
>          systemd-devel \
>          systemtap-sdt-devel \
>          tar \
>          usbredir-devel \
>          util-linux \
> -        virglrenderer-devel \
>          vte291-devel \
>          which \
>          xfsprogs-devel \
> @@ -132,18 +131,11 @@ RUN dnf distro-sync -y && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
>  
> -RUN /usr/bin/pip3.8 install \
> -                    meson==0.63.2 \
> -                    pillow \
> -                    sphinx \
> -                    sphinx-rtd-theme \
> -                    tomli
> -
>  ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
>  ENV LANG "en_US.UTF-8"
>  ENV MAKE "/usr/bin/make"
>  ENV NINJA "/usr/bin/ninja"
> -ENV PYTHON "/usr/bin/python3.8"
> +ENV PYTHON "/usr/bin/python3"
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 407c03301b..03b974ad02 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -1,66 +1,50 @@
>  mappings:
>    flake8:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    meson:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3:
> -    CentOSStream8: python38
>      OpenSUSELeap15: python311-base
>  
>    python3-PyYAML:
> -    CentOSStream8: python38-PyYAML
>      OpenSUSELeap15:
>  
>    python3-devel:
> -    CentOSStream8: python38-devel
>      OpenSUSELeap15: python311-devel
>  
>    python3-docutils:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-numpy:
> -    CentOSStream8: python38-numpy
>      OpenSUSELeap15:
>  
>    python3-opencv:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-pillow:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-pip:
> -    CentOSStream8: python38-pip
>      OpenSUSELeap15: python311-pip
>  
>    python3-pillow:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-selinux:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-setuptools:
> -    CentOSStream8: python38-setuptools
>      OpenSUSELeap15: python311-setuptools
>  
>    python3-sphinx:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-sphinx-rtd-theme:
> -    CentOSStream8:
>      OpenSUSELeap15:
>  
>    python3-sqlite3:
> -    CentOSStream8: python38
>      OpenSUSELeap15: python311
>  
>    python3-tomli:
> @@ -69,15 +53,11 @@ mappings:
>      Fedora:
>      Debian12:
>      OpenSUSELeap15:
> -    # Not available for Python 3.8
> -    CentOSStream8:
>  
>    python3-venv:
> -    CentOSStream8: python38
>      OpenSUSELeap15: python311-base
>  
>    python3-wheel:
> -    CentOSStream8: python38-wheel
>      OpenSUSELeap15: python311-pip
>  
>  pypi_mappings:
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 692752a3df..24a735a3f2 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -125,7 +125,7 @@ try:
>      # Standard native builds
>      #
>      generate_dockerfile("alpine", "alpine-318")
> -    generate_dockerfile("centos8", "centos-stream-8")
> +    generate_dockerfile("centos9", "centos-stream-9")
>      generate_dockerfile("debian", "debian-12",
>                          trailer="".join(debian12_extras))
>      generate_dockerfile("fedora", "fedora-38")
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 097a9ca14d..d25c8f8b5b 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -26,8 +26,8 @@ class CentosVM(basevm.BaseVM):
>          export SRC_ARCHIVE=/dev/vdb;
>          sudo chmod a+r $SRC_ARCHIVE;
>          tar -xf $SRC_ARCHIVE;
> -        make docker-test-block@centos8 {verbose} J={jobs} NETWORK=1;
> -        make docker-test-quick@centos8 {verbose} J={jobs} NETWORK=1;
> +        make docker-test-block@centos9 {verbose} J={jobs} NETWORK=1;
> +        make docker-test-quick@centos9 {verbose} J={jobs} NETWORK=1;
>      """
>  
>      def build_image(self, img):
> -- 
> 2.44.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



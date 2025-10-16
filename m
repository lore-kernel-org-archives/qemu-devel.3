Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDFCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pxh-0001lZ-Uj; Thu, 16 Oct 2025 11:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Pxd-0001ks-B8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:32:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9PxU-0005Jn-Cc
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:32:12 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so11039875ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760628717; x=1761233517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PL8YOWmB2c68vjqnVAng3hylZSGSdPKdCyrPQ29+1eQ=;
 b=JtiaawAV4r3FI21iu726awhmOiRrdT5cHfAD+mwzlho7Hz2w0SW21QcXiTU+c96sFt
 H2hJ/UnkahABrhZ8/SlC6rvxNbhA9Psg0oUcKHbbY9a1QWRJMa6IitWNd3IbuF17e9h1
 k7/xyAFGXqkO1JTtkqNoliijpvhBwYpGv1Ql9nSuQALGIocf75O5muuCRDswxMyn7ZH7
 9WqtaBLvMyMBt69l/xvhaqP7KP2CWtPywCKdRrxSFm7iyD7Yx+XJqdu0spgHeQZjtS1M
 unY3oXsztyiLg0PeZi/TsB1ucgwxoVFrczN/j+PhDrXdA43PFkoVgNeWqykI0nzEwVjy
 E34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628717; x=1761233517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PL8YOWmB2c68vjqnVAng3hylZSGSdPKdCyrPQ29+1eQ=;
 b=uUzQqvt3THfcuYCLUqYGyj6Tt7JwlC0k7AJuVRxtnPc9Tq4QbM4LNIwAdrcNJYQA/X
 RMJiwMu5Rs7x93gVxCqGNEfLevw/784lBejzL0n3CSIYwr0mj58syZUHv0NyjAdhDIxO
 2axI35Xovlm24C2n++lPQpLBT5j5xKuOjtnxmRrFw3OVCSnj8v+qjig/tBteCG80RnrE
 Uz3PU75O39LBjmbyCm6+X9QNm/c7SrKE8mWcBhtCI07dyTktufS2ayG48YRIwzfAZlzf
 pmL1oxTaLCUDGznUNuHgnRe7B7OoF86FcdOoXjI/g7AZokg9wyznHPqZxkcYECa1YHpa
 P0Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOI0XjK40lKrBDeRjyosKLACzzHzdf0IInOhWTMQWC4nhVtK7DBHBzMJDYDnlsiytFM4F2CkN33ACw@nongnu.org
X-Gm-Message-State: AOJu0Yzj6eu0NcrJmyy/W8DvY30+Cc3Y6KZiKsMzGAA8fc+C4zOas7CS
 1abBe87EtyvNgf9QTHtTHVgnpASVfwtXuSxoTCQjhLpgtoBriRjmH8IPheCGh+70Paw=
X-Gm-Gg: ASbGnct//fq0/Q4WbOV9UxZjbGWqH1kiNnDgpSAeiaOR8vBJ3ybav+jxBpJEK9mIcl7
 fHsVbBe/q0liReh0triGMfTLs938i4r+EseMPs6U8L5lFabhIM58lGeI7uX2G2tSANFuBS0Mvjf
 Gc3gpF5gysXj6WF4OUCbT+ZI8JSUjUocMoR4B7+dAGNEvTHfuAUto1WJTEuWh7xekZ/+MmG9As2
 s7MqIvCNYAP+NdfD5jADq5bZKcnp5cYCWh2vP0vvGDn5QrGJEWrK/7hQKz0qJp2u9VlwYZX05fM
 liGR/X0VGH2ylzKf8Dy+pn3jlMhZibQR3CXY5UIU6dwAI6R8n6cbJXxZe6Bu1MayTJVSwLHMz2s
 VneC1oKmWn44Hu/XoZCr07bmAuyrmh9ze+woawL3olz651OGr2dTAOpA0EFV94KjSkS0gjEYlJi
 9YWMHDDIXfIkCJsLJdzvz84Bo=
X-Google-Smtp-Source: AGHT+IFkWNYp/Qmq7zm09fWaEkuS7Ervmu7DGSsYfvvRbF6Q66XUOue/sjAfZtV76QmJYZ9h2GCqfg==
X-Received: by 2002:a17:902:d4c4:b0:26e:7468:8a99 with SMTP id
 d9443c01a7336-290ca121e99mr4880335ad.36.1760628717040; 
 Thu, 16 Oct 2025 08:31:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba4d3sm33751605ad.83.2025.10.16.08.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 08:31:56 -0700 (PDT)
Message-ID: <6add64a1-755a-48b1-9a7c-d85319e0c6b1@linaro.org>
Date: Thu, 16 Oct 2025 08:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] gitlab: drop aarch32 runner and associated bits
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016150357.876415-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/16/25 8:03 AM, Alex Bennée wrote:
> While working out what hoops to jump through to get a full set of
> aarch32 packages installed on the aarch64 runner it was pointed out 32
> bit host support is deprecated. As the extra packages where needed for
> system emulation (marked deprecated since 8.0!) there didn't seem much
> point keeping this in.
> 
> While the full expunging of 32 bit host support will probably be done
> for 11.0 we can at least reduce the CI burden a bit now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/custom-runners.yml               |   1 -
>   .../custom-runners/ubuntu-24.04-aarch32.yml   |  25 ----
>   scripts/ci/setup/ubuntu/build-environment.yml |  17 ---
>   .../setup/ubuntu/ubuntu-2204-armhf-cross.yml  | 127 ------------------
>   4 files changed, 170 deletions(-)
>   delete mode 100644 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
>   delete mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
> 
> diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
> index 3eb8216d571..142fbf4a242 100644
> --- a/.gitlab-ci.d/custom-runners.yml
> +++ b/.gitlab-ci.d/custom-runners.yml
> @@ -31,4 +31,3 @@
>   include:
>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
> -  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml'
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
> deleted file mode 100644
> index 75029c9187e..00000000000
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -# All ubuntu-24.04 jobs should run successfully in an environment
> -# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
> -# "Install basic packages to build QEMU on Ubuntu 24.04"
> -
> -ubuntu-24.04-aarch32-all:
> - extends: .custom_runner_template
> - needs: []
> - stage: build
> - tags:
> - - ubuntu_24.04
> - - aarch32
> - rules:
> - - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
> -   when: manual
> -   allow_failure: true
> - - if: "$AARCH32_RUNNER_AVAILABLE"
> -   when: manual
> -   allow_failure: true
> - script:
> - - mkdir build
> - - cd build
> - - ../configure --cross-prefix=arm-linux-gnueabihf-
> -   || { cat config.log meson-logs/meson-log.txt; exit 1; }
> - - make --output-sync -j`nproc --ignore=40`
> - - make --output-sync -j`nproc --ignore=40` check
> diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
> index 6042750cb4d..0f8ec5fab04 100644
> --- a/scripts/ci/setup/ubuntu/build-environment.yml
> +++ b/scripts/ci/setup/ubuntu/build-environment.yml
> @@ -47,21 +47,4 @@
>           - ansible_facts['distribution'] == 'Ubuntu'
>           - ansible_facts['distribution_version'] == '24.04'
>   
> -    - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 24.04
> -      package:
> -        name:
> -          - binutils-arm-linux-gnueabihf
> -          - gcc-arm-linux-gnueabihf
> -          - libblkid-dev:armhf
> -          - libc6-dev:armhf
> -          - libffi-dev:armhf
> -          - libglib2.0-dev:armhf
> -          - libmount-dev:armhf
> -          - libpcre2-dev:armhf
> -          - libpixman-1-dev:armhf
> -          - zlib1g-dev:armhf
> -      when:
> -        - ansible_facts['distribution'] == 'Ubuntu'
> -        - ansible_facts['distribution_version'] == '24.04'
> -        - ansible_facts['architecture'] == 'aarch64'
>   
> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
> deleted file mode 100644
> index 0cc34cd10b9..00000000000
> --- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -# THIS FILE WAS AUTO-GENERATED
> -#
> -#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
> -#
> -# https://gitlab.com/libvirt/libvirt-ci
> -
> -packages:
> -  - bash
> -  - bc
> -  - bison
> -  - bsdextrautils
> -  - bzip2
> -  - ca-certificates
> -  - ccache
> -  - dbus
> -  - debianutils
> -  - diffutils
> -  - exuberant-ctags
> -  - findutils
> -  - flex
> -  - gcc
> -  - gcovr
> -  - gettext
> -  - git
> -  - hostname
> -  - libglib2.0-dev
> -  - libpcre2-dev
> -  - libsndio-dev
> -  - libspice-protocol-dev
> -  - llvm
> -  - locales
> -  - make
> -  - meson
> -  - mtools
> -  - ncat
> -  - ninja-build
> -  - openssh-client
> -  - pkgconf
> -  - python3
> -  - python3-numpy
> -  - python3-opencv
> -  - python3-pillow
> -  - python3-pip
> -  - python3-sphinx
> -  - python3-sphinx-rtd-theme
> -  - python3-tomli
> -  - python3-venv
> -  - python3-yaml
> -  - rpm2cpio
> -  - sed
> -  - socat
> -  - sparse
> -  - swtpm
> -  - tar
> -  - tesseract-ocr
> -  - tesseract-ocr-eng
> -  - xorriso
> -  - zstd
> -  - gcc-arm-linux-gnueabihf
> -  - libaio-dev:armhf
> -  - libasan6:armhf
> -  - libasound2-dev:armhf
> -  - libattr1-dev:armhf
> -  - libbpf-dev:armhf
> -  - libbrlapi-dev:armhf
> -  - libbz2-dev:armhf
> -  - libc6-dev:armhf
> -  - libcacard-dev:armhf
> -  - libcap-ng-dev:armhf
> -  - libcapstone-dev:armhf
> -  - libcmocka-dev:armhf
> -  - libcurl4-gnutls-dev:armhf
> -  - libdaxctl-dev:armhf
> -  - libdrm-dev:armhf
> -  - libepoxy-dev:armhf
> -  - libfdt-dev:armhf
> -  - libffi-dev:armhf
> -  - libfuse3-dev:armhf
> -  - libgbm-dev:armhf
> -  - libgcrypt20-dev:armhf
> -  - libglib2.0-dev:armhf
> -  - libglusterfs-dev:armhf
> -  - libgnutls28-dev:armhf
> -  - libgtk-3-dev:armhf
> -  - libibumad-dev:armhf
> -  - libibverbs-dev:armhf
> -  - libiscsi-dev:armhf
> -  - libjemalloc-dev:armhf
> -  - libjpeg-turbo8-dev:armhf
> -  - libjson-c-dev:armhf
> -  - liblttng-ust-dev:armhf
> -  - liblzo2-dev:armhf
> -  - libncursesw5-dev:armhf
> -  - libnfs-dev:armhf
> -  - libnuma-dev:armhf
> -  - libpam0g-dev:armhf
> -  - libpipewire-0.3-dev:armhf
> -  - libpixman-1-dev:armhf
> -  - libpng-dev:armhf
> -  - libpulse-dev:armhf
> -  - librbd-dev:armhf
> -  - librdmacm-dev:armhf
> -  - libsasl2-dev:armhf
> -  - libsdl2-dev:armhf
> -  - libsdl2-image-dev:armhf
> -  - libseccomp-dev:armhf
> -  - libselinux1-dev:armhf
> -  - libslirp-dev:armhf
> -  - libsnappy-dev:armhf
> -  - libspice-server-dev:armhf
> -  - libssh-dev:armhf
> -  - libsystemd-dev:armhf
> -  - libtasn1-6-dev:armhf
> -  - libubsan1:armhf
> -  - libudev-dev:armhf
> -  - liburing-dev:armhf
> -  - libusb-1.0-0-dev:armhf
> -  - libusbredirhost-dev:armhf
> -  - libvdeplug-dev:armhf
> -  - libvirglrenderer-dev:armhf
> -  - libvte-2.91-dev:armhf
> -  - libxen-dev:armhf
> -  - libzstd-dev:armhf
> -  - nettle-dev:armhf
> -  - systemtap-sdt-dev:armhf
> -  - zlib1g-dev:armhf
> -

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



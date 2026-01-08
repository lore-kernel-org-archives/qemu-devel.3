Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D798CF6A89
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlw2-00016w-Dp; Thu, 08 Jan 2026 04:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdlw1-00016o-7f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdlvz-0000Z9-8p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767863037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9U+IMldMN/E+8D6b7AiQ0lDP5tv+Ib5CRa2cG+rfDxU=;
 b=FirNK4Ht3C3GPj2aaYQRmegg45R/1si4jt9NLprDVe8mFnGJiZQQGOGL1KNxtTNwQEbO0Y
 yJi2FLTTDHhLbErAXfaAK9ecUfiVpRY692yhr9h4DUieWXFH7sC8jQekq/XZmBOiNtTvdS
 b6CBYKQkKPR9HoxnBZXCLdNW5cj8Aj8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-BGlIohVlO--Igu6gX5Wb0Q-1; Thu,
 08 Jan 2026 04:03:55 -0500
X-MC-Unique: BGlIohVlO--Igu6gX5Wb0Q-1
X-Mimecast-MFC-AGG-ID: BGlIohVlO--Igu6gX5Wb0Q_1767863034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 488A6180034A; Thu,  8 Jan 2026 09:03:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5DE18001D5; Thu,  8 Jan 2026 09:03:53 +0000 (UTC)
Date: Thu, 8 Jan 2026 09:03:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/50] gitlab: Remove 32-bit host testing
Message-ID: <aV9y9b2-XRvNOYTG@redhat.com>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108053018.626690-2-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 08, 2026 at 04:29:29PM +1100, Richard Henderson wrote:
> These deprecated builds will be disabled.
> Remove testing of armhf, i686, and wasm32.

CC'ing the wasm maintainer.

This patch is removing our only CI testing of wasm.  Is there any
64-bit container image that can be used to test wasm instead ?

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .gitlab-ci.d/buildtest-template.yml | 27 -----------------
>  .gitlab-ci.d/buildtest.yml          |  9 ------
>  .gitlab-ci.d/container-cross.yml    | 17 -----------
>  .gitlab-ci.d/containers.yml         |  3 --
>  .gitlab-ci.d/crossbuilds.yml        | 45 -----------------------------
>  5 files changed, 101 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index d866cb12bb..9c2ae39ddd 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -123,30 +123,3 @@
>      - du -chs ${CI_PROJECT_DIR}/*-cache
>    variables:
>      QEMU_JOB_FUNCTIONAL: 1
> -
> -.wasm_build_job_template:
> -  extends: .base_job_template
> -  stage: build
> -  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> -  before_script:
> -    - source scripts/ci/gitlab-ci-section
> -    - section_start setup "Pre-script setup"
> -    - JOBS=$(expr $(nproc) + 1)
> -    - section_end setup
> -  script:
> -    - du -sh .git
> -    - mkdir build
> -    - cd build
> -    - section_start configure "Running configure"
> -    - emconfigure ../configure --disable-docs
> -          ${TARGETS:+--target-list="$TARGETS"}
> -          $CONFIGURE_ARGS ||
> -      { cat config.log meson-logs/meson-log.txt && exit 1; }
> -    - if test -n "$LD_JOBS";
> -      then
> -        pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
> -      fi || exit 1;
> -    - section_end configure
> -    - section_start build "Building QEMU"
> -    - emmake make -j"$JOBS"
> -    - section_end build
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index dfe954fe3c..1d4b8a030a 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -784,12 +784,3 @@ coverity:
>        when: never
>      # Always manual on forks even if $QEMU_CI == "2"
>      - when: manual
> -
> -build-wasm:
> -  extends: .wasm_build_job_template
> -  timeout: 2h
> -  needs:
> -    - job: wasm-emsdk-cross-container
> -  variables:
> -    IMAGE: emsdk-wasm32-cross
> -    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
> index 0fd7341afa..044795d9ff 100644
> --- a/.gitlab-ci.d/container-cross.yml
> +++ b/.gitlab-ci.d/container-cross.yml
> @@ -22,12 +22,6 @@ arm64-debian-cross-container:
>    variables:
>      NAME: debian-arm64-cross
>  
> -armhf-debian-cross-container:
> -  extends: .container_job_template
> -  stage: containers
> -  variables:
> -    NAME: debian-armhf-cross
> -
>  hexagon-cross-container:
>    extends: .container_job_template
>    stage: containers
> @@ -40,12 +34,6 @@ loongarch-debian-cross-container:
>    variables:
>      NAME: debian-loongarch-cross
>  
> -i686-debian-cross-container:
> -  extends: .container_job_template
> -  stage: containers
> -  variables:
> -    NAME: debian-i686-cross
> -
>  mips64el-debian-cross-container:
>    extends: .container_job_template
>    stage: containers
> @@ -85,8 +73,3 @@ win64-fedora-cross-container:
>    extends: .container_job_template
>    variables:
>      NAME: fedora-win64-cross
> -
> -wasm-emsdk-cross-container:
> -  extends: .container_job_template
> -  variables:
> -    NAME: emsdk-wasm32-cross
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index f7d3e7205d..222522ca16 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -47,10 +47,8 @@ weekly-container-builds:
>      - amd64-debian-user-cross-container
>      - amd64-debian-legacy-cross-container
>      - arm64-debian-cross-container
> -    - armhf-debian-cross-container
>      - hexagon-cross-container
>      - loongarch-debian-cross-container
> -    - i686-debian-cross-container
>      - mips64el-debian-cross-container
>      - ppc64el-debian-cross-container
>      - riscv64-debian-cross-container
> @@ -58,7 +56,6 @@ weekly-container-builds:
>      - tricore-debian-cross-container
>      - xtensa-debian-cross-container
>      - win64-fedora-cross-container
> -    - wasm-emsdk-cross-container
>      # containers
>      - amd64-alpine-container
>      - amd64-debian-container
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 99dfa7eea6..59ff8b1d87 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -1,13 +1,6 @@
>  include:
>    - local: '/.gitlab-ci.d/crossbuild-template.yml'
>  
> -cross-armhf-user:
> -  extends: .cross_user_build_job
> -  needs:
> -    - job: armhf-debian-cross-container
> -  variables:
> -    IMAGE: debian-armhf-cross
> -
>  cross-arm64-system:
>    extends: .cross_system_build_job
>    needs:
> @@ -30,44 +23,6 @@ cross-arm64-kvm-only:
>      IMAGE: debian-arm64-cross
>      EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
>  
> -cross-i686-system:
> -  extends:
> -    - .cross_system_build_job
> -    - .cross_test_artifacts
> -  needs:
> -    - job: i686-debian-cross-container
> -  variables:
> -    IMAGE: debian-i686-cross
> -    EXTRA_CONFIGURE_OPTS: --disable-kvm
> -    MAKE_CHECK_ARGS: check-qtest
> -
> -cross-i686-user:
> -  extends:
> -    - .cross_user_build_job
> -    - .cross_test_artifacts
> -  needs:
> -    - job: i686-debian-cross-container
> -  variables:
> -    IMAGE: debian-i686-cross
> -    MAKE_CHECK_ARGS: check
> -
> -cross-i686-tci:
> -  extends:
> -    - .cross_accel_build_job
> -    - .cross_test_artifacts
> -  timeout: 60m
> -  needs:
> -    - job: i686-debian-cross-container
> -  variables:
> -    IMAGE: debian-i686-cross
> -    ACCEL: tcg-interpreter
> -    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
> -    # Force tests to run with reduced parallelism, to see whether this
> -    # reduces the flakiness of this CI job. The CI
> -    # environment by default shows us 8 CPUs and so we
> -    # would otherwise be using a parallelism of 9.
> -    MAKE_CHECK_ARGS: check check-tcg -j2
> -
>  cross-mips64el-system:
>    extends: .cross_system_build_job
>    needs:
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



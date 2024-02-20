Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23026C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcUW7-0006qu-Sd; Tue, 20 Feb 2024 13:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUW6-0006qV-7S
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcUW3-0001KK-UC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708452411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WG1uHTPmxbIkpkhXBcEp66pr8OcfeqB/OztN2xbdog8=;
 b=CvQ8QNYyBXzvY67CMQPxJYac3TC7rE+nWwHnI4PIB1jwvS4VFqIL7pm6QLJ6NVp8AxPdd3
 BlMb2+mpFVrgEPOYV8P/a6IlGh3tSF4yq1QEXW0JpDaZRxBNg6CUq0GmpkrvsOfBRdYNGP
 vStkRSPhr7p+aLwXW5mLargM/AY4h2I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-fdZc8SA8PeiG8LA1TAlaCw-1; Tue,
 20 Feb 2024 13:06:49 -0500
X-MC-Unique: fdZc8SA8PeiG8LA1TAlaCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57BB63C0F18F;
 Tue, 20 Feb 2024 18:06:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C191FC01644;
 Tue, 20 Feb 2024 18:06:48 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:06:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
Message-ID: <ZdTqNmZvM_S9SwDB@redhat.com>
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220174412.155885-4-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 05:44:12PM +0000, Peter Maydell wrote:
> Now we don't build msys2-32bit we don't need the abstraction out of the
> common msys2 handling from the 32-vs-64-bit specifics. Collapse it
> down into the msys2-64bit job definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 44 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 8fc08218d28..e784d5a68cd 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -1,4 +1,4 @@
> -.shared_msys2_builder:
> +msys2-64bit:
>    extends: .base_job_template
>    tags:
>    - shared-windows
> @@ -14,9 +14,19 @@
>    stage: build
>    timeout: 100m
>    variables:
> +    MINGW_TARGET: mingw-w64-x86_64

This var isn't needed since you remove the only usage of it.

> +    MSYSTEM: MINGW64

I'm fuzzy on whether this is needed or not ?   We don't use it,
but perhaps it is something MSys wants set ?

>      # This feature doesn't (currently) work with PowerShell, it stops
>      # the echo'ing of commands being run and doesn't show any timing
>      FF_SCRIPT_SECTIONS: 0
> +    # do not remove "--without-default-devices"!
> +    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
> +    # changed to compile QEMU with the --without-default-devices switch
> +    # for the msys2 64-bit job, due to the build could not complete within
> +    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> +    # qTests don't run successfully with "--without-default-devices",
> +    # so let's exclude the qtests from CI for now.
> +    TEST_ARGS: --no-suite qtest
>    artifacts:
>      name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>      expire_in: 7 days
> @@ -72,33 +82,35 @@
>    - .\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm --needed
>        bison diffutils flex
>        git grep make sed
> -      $MINGW_TARGET-binutils
> -      $MINGW_TARGET-capstone
> -      $MINGW_TARGET-ccache
> -      $MINGW_TARGET-curl
> -      $MINGW_TARGET-cyrus-sasl
> -      $MINGW_TARGET-dtc
> -      $MINGW_TARGET-gcc
> -      $MINGW_TARGET-glib2
> -      $MINGW_TARGET-gnutls
> -      $MINGW_TARGET-gtk3
> -      $MINGW_TARGET-libgcrypt
> -      $MINGW_TARGET-libjpeg-turbo
> -      $MINGW_TARGET-libnfs
> -      $MINGW_TARGET-libpng
> -      $MINGW_TARGET-libssh
> -      $MINGW_TARGET-libtasn1
> -      $MINGW_TARGET-lzo2
> -      $MINGW_TARGET-nettle
> -      $MINGW_TARGET-ninja
> -      $MINGW_TARGET-pixman
> -      $MINGW_TARGET-pkgconf
> -      $MINGW_TARGET-python
> -      $MINGW_TARGET-SDL2
> -      $MINGW_TARGET-SDL2_image
> -      $MINGW_TARGET-snappy
> -      $MINGW_TARGET-zstd
> -      $EXTRA_PACKAGES "
> +      mingw-w64-x86_64-binutils
> +      mingw-w64-x86_64-capstone
> +      mingw-w64-x86_64-ccache
> +      mingw-w64-x86_64-curl
> +      mingw-w64-x86_64-cyrus-sasl
> +      mingw-w64-x86_64-dtc
> +      mingw-w64-x86_64-gcc
> +      mingw-w64-x86_64-glib2
> +      mingw-w64-x86_64-gnutls
> +      mingw-w64-x86_64-gtk3
> +      mingw-w64-x86_64-libgcrypt
> +      mingw-w64-x86_64-libjpeg-turbo
> +      mingw-w64-x86_64-libnfs
> +      mingw-w64-x86_64-libpng
> +      mingw-w64-x86_64-libssh
> +      mingw-w64-x86_64-libtasn1
> +      mingw-w64-x86_64-libusb
> +      mingw-w64-x86_64-lzo2
> +      mingw-w64-x86_64-nettle
> +      mingw-w64-x86_64-ninja
> +      mingw-w64-x86_64-pixman
> +      mingw-w64-x86_64-pkgconf
> +      mingw-w64-x86_64-python
> +      mingw-w64-x86_64-SDL2
> +      mingw-w64-x86_64-SDL2_image
> +      mingw-w64-x86_64-snappy
> +      mingw-w64-x86_64-spice
> +      mingw-w64-x86_64-usbredir
> +      mingw-w64-x86_64-zstd"
>    - Write-Output "Running build at $(Get-Date -Format u)"
>    - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
>    - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
> @@ -115,19 +127,3 @@
>    - ..\msys64\usr\bin\bash -lc "make check MTESTARGS='$TEST_ARGS' || { cat meson-logs/testlog.txt; exit 1; } ;"
>    - ..\msys64\usr\bin\bash -lc "ccache --show-stats"
>    - Write-Output "Finished build at $(Get-Date -Format u)"
> -
> -msys2-64bit:
> -  extends: .shared_msys2_builder
> -  variables:
> -    MINGW_TARGET: mingw-w64-x86_64
> -    MSYSTEM: MINGW64
> -    # msys2 only ship these packages for 64-bit, not 32-bit
> -    EXTRA_PACKAGES: $MINGW_TARGET-libusb $MINGW_TARGET-usbredir $MINGW_TARGET-spice
> -    # do not remove "--without-default-devices"!
> -    # commit 9f8e6cad65a6 ("gitlab-ci: Speed up the msys2-64bit job by using --without-default-devices"
> -    # changed to compile QEMU with the --without-default-devices switch
> -    # for the msys2 64-bit job, due to the build could not complete within
> -    CONFIGURE_ARGS:  --target-list=x86_64-softmmu --without-default-devices -Ddebug=false -Doptimization=0
> -    # qTests don't run successfully with "--without-default-devices",
> -    # so let's exclude the qtests from CI for now.
> -    TEST_ARGS: --no-suite qtest
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



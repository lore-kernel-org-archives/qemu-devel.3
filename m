Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C3CF07DF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypPt-0000Ns-5T; Thu, 10 Oct 2024 05:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sypPn-0000NT-8q
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sypPl-0003ae-G4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728552296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CWVeO/ifGwzoh6U3ugWZd1DUu4EeBx5N9/asyIRwBQQ=;
 b=hz4SdSd3fXDGTP3mf37PRYcavAAonR2BSS6QJ5RgjPDDka5xR4TYbqkAdMjxlR5zgJB+nf
 V7/Hkq/+SPds+Fp8abuSnQSXV4h6SgKmw1WEugkIUP1z0SRU5Gf6C3IngcUrjwOHEaUKvh
 HXbIQYUyWQL3eTFQhSUTwYMplsKxIxY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-ifQVr7gJMPyHZBjhq2xPvA-1; Thu,
 10 Oct 2024 05:24:53 -0400
X-MC-Unique: ifQVr7gJMPyHZBjhq2xPvA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8179D1955EE8; Thu, 10 Oct 2024 09:24:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B6131956086; Thu, 10 Oct 2024 09:24:51 +0000 (UTC)
Date: Thu, 10 Oct 2024 10:24:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] meson: drop --enable-avx* options
Message-ID: <ZwedYPrdBaOz0n2U@redhat.com>
References: <20241010091322.1790604-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010091322.1790604-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 10, 2024 at 11:13:22AM +0200, Paolo Bonzini wrote:
> Just detect compiler support and always enable the optimizations if
> it is avilable; warn if the user did request AVX2/AVX512 use via
> -Dx86_version= but the intrinsics are not available.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                   | 30 +++++++++++++++++++-----------
>  meson_options.txt             |  4 ----
>  scripts/meson-buildoptions.sh |  6 ------
>  3 files changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index e4b2af138da..b4418d54e0a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2955,22 +2955,16 @@ config_host_data.set('CONFIG_ASM_HWPROBE_H',
>                       cc.has_header_symbol('asm/hwprobe.h',
>                                            'RISCV_HWPROBE_EXT_ZBA'))
>  
> -config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
> -  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
> -  .require(cc.links('''
> -    #include <cpuid.h>
> +if have_cpuid_h
> +  have_avx2 = cc.links('''
>      #include <immintrin.h>
>      static int __attribute__((target("avx2"))) bar(void *a) {
>        __m256i x = *(__m256i *)a;
>        return _mm256_testz_si256(x, x);
>      }
>      int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
> -  '''), error_message: 'AVX2 not available').allowed())
> -
> -config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
> -  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
> -  .require(cc.links('''
> -    #include <cpuid.h>
> +  ''')
> +  have_avx512bw = cc.links('''
>      #include <immintrin.h>
>      static int __attribute__((target("avx512bw"))) bar(void *a) {
>        __m512i *x = a;
> @@ -2978,7 +2972,21 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>        return res[1];
>      }
>      int main(int argc, char *argv[]) { return bar(argv[0]); }
> -  '''), error_message: 'AVX512BW not available').allowed())
> +  ''')
> +  if get_option('x86_version') >= '3' and not have_avx2
> +    warning('Cannot enable AVX optimizations due to missing intrinsics')
> +  elif get_option('x86_version') >= '4' and not have_avx512bw
> +    warning('Cannot enable AVX512 optimizations due to missing intrinsics')
> +  endif

Should these perhaps be error() rather than warning() ?

We only support GCC & CLang. If both GCC 7.4.0 and CLang 10.0 (our
min versions) have the intrinsics, then I'd say this is an impossible
scenario if x86_version is large, and thus would deserve error()

> +else
> +  have_avx2 = false
> +  have_avx512bw = false
> +  if get_option('x86_version') >= '3'
> +    warning('Cannot enable AVX optimizations due to missing cpuid.h')
> +  endif
> +endif
> +config_host_data.set('CONFIG_AVX2_OPT', have_avx2)
> +config_host_data.set('CONFIG_AVX512BW_OPT', have_avx512bw)
>  
>  # For both AArch64 and AArch32, detect if builtins are available.
>  config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
> diff --git a/meson_options.txt b/meson_options.txt
> index 5a5c2300261..d5abf5193f5 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -119,10 +119,6 @@ option('tpm', type : 'feature', value : 'auto',
>  option('membarrier', type: 'feature', value: 'disabled',
>         description: 'membarrier system call (for Linux 4.14+ or Windows')
>  
> -option('avx2', type: 'feature', value: 'auto',
> -       description: 'AVX2 optimizations')
> -option('avx512bw', type: 'feature', value: 'auto',
> -       description: 'AVX512BW optimizations')
>  option('keyring', type: 'feature', value: 'auto',
>         description: 'Linux keyring support')
>  option('libkeyutils', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 6d08605b771..dc796f48bad 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -94,8 +94,6 @@ meson_options_help() {
>    printf "%s\n" '  alsa            ALSA sound support'
>    printf "%s\n" '  attr            attr/xattr support'
>    printf "%s\n" '  auth-pam        PAM access control'
> -  printf "%s\n" '  avx2            AVX2 optimizations'
> -  printf "%s\n" '  avx512bw        AVX512BW optimizations'
>    printf "%s\n" '  blkio           libblkio block device driver'
>    printf "%s\n" '  bochs           bochs image format support'
>    printf "%s\n" '  bpf             eBPF support'
> @@ -238,10 +236,6 @@ _meson_option_parse() {
>      --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
>      --enable-auth-pam) printf "%s" -Dauth_pam=enabled ;;
>      --disable-auth-pam) printf "%s" -Dauth_pam=disabled ;;
> -    --enable-avx2) printf "%s" -Davx2=enabled ;;
> -    --disable-avx2) printf "%s" -Davx2=disabled ;;
> -    --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
> -    --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
>      --enable-gcov) printf "%s" -Db_coverage=true ;;
>      --disable-gcov) printf "%s" -Db_coverage=false ;;
>      --enable-lto) printf "%s" -Db_lto=true ;;
> -- 
> 2.46.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



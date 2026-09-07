Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B1DC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3YtG-0003tM-1l; Mon, 07 Sep 2026 08:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3YtD-0003t8-VV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x3YtB-0004CX-0i
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788785755;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqxX1fgu3FSGfM7JQoacPtoZpT3+jMZ0//AAbp9Tx8E=;
 b=VphsNkM9urvPFInui+FUdmeTFICsySYqmXKnkxGyiA/KWoT90v1q8K49QlNmpftlOwzacC
 1urWC1Ry2XG6BxjpLoQ7clzwXWAcEDwAU7eJu9JkobUDfDjEQ7XjrZdOXj3KSBV0RQz3mv
 xTdT2CY3El7Vdm+Oyf6mcOBA+nP3EBw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-m_638u__NVGsnMz0YCEGDg-1; Mon,
 07 Sep 2026 08:55:50 -0400
X-MC-Unique: m_638u__NVGsnMz0YCEGDg-1
X-Mimecast-MFC-AGG-ID: m_638u__NVGsnMz0YCEGDg_1788785748
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9B97182A10B; Mon,  7 Sep 2026 12:55:47 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 036341956044; Mon,  7 Sep 2026 12:55:45 +0000 (UTC)
Date: Mon, 7 Sep 2026 13:55:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 101/105] tests/tcg/meson.build: implement ./configure
 -cross-cc-* options
Message-ID: <ap60TwXjoICGsvKz@redhat.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-102-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904124604.2207440-102-alex.bennee@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit changes meson_options.txt, but did not refresh the
scripts/meson-buildoptions.sh file, so it is sometimes showing
up dirty when doing a build.

Paolo, I feel like there must be some bug in the logic for triggering
a rebuild of scripts/meson-buildoptions.sh as contributors frequently
miss this change. With the current git HEAD, sometimes when I do a
build it'll refresh the file leaving it dirty, but if I discard all
local changes and do another build, then it doesn't refresh the file.


On Fri, Sep 04, 2026 at 01:45:55PM +0100, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> When a user set explicit cross cc, we ensure it's available and working.
> When a user set explicit cross cflags, we ensure they work with default
> or overriden cross_cc.
> 
> Made the first implementation with a single meson option (array), which
> proved to be absolutely unreadable.
> By having one option per target, we directly detect issue at configure
> time, either for user, or when iterating on all our targets. This
> ensures user can't mispell any target name, and that we can't forget any
> new one in the future.
> Also, it shows them in the configuration summary, which is a bonus.
> 
> Since we now only need to know compiler to write tcg tests, we can
> simply alias -cross-prefix-* options to compiler override.
> 
> Examples
> --------
> 
> wrong architecture:
> $ ./configure --cross-cc-bad='cc'
> ../meson.build:1:0: ERROR: Unknown option: "tcg_tests_cross_cc_bad"
> 
> wrong option:
> $ ./configure --cross-cc-cflags-aarch64='-bad-option'
> ../tests/tcg/meson.build:228:10: ERROR: Command `/usr/bin/aarch64-linux-gnu-gcc /home/pbouvier/.work/qemu/tests/tcg/test_cc.c -bad-option -static -nostdlib -r -o /dev/null` failed with status 1.
> A full log can be found at /qemu/build/meson-logs/meson-log.txt
> 
> cross compile with clang (fails at the moment, since some tests have
> compilation errors with it):
> $ ./configure --target-list=aarch64-linux-user --cross-cc-aarch64='clang' --cross-cc-cflags-aarch64='-target aarch64-linux-gnu'
>   User defined options
>   ...
>     tcg_tests_cross_cc_aarch64      : clang
>     tcg_tests_cross_cflags_aarch64  : -target aarch64-linux-gnu
> 
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20260827221506.91574-102-pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> diff --git a/configure b/configure
> index aa98cf39584..1973f023b1e 100755
> --- a/configure
> +++ b/configure
> @@ -227,19 +227,6 @@ for opt do
>    ;;
>    --extra-ldflags=*) EXTRA_LDFLAGS="$EXTRA_LDFLAGS $optarg"
>    ;;
> -  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
> -  ;;
> -  --cross-cc-cflags-*) cc_arch=${opt#--cross-cc-cflags-}; cc_arch=${cc_arch%%=*}
> -                      eval "cross_cc_cflags_${cc_arch}=\$optarg"
> -  ;;
> -  --cross-cc-*) cc_arch=${opt#--cross-cc-}; cc_arch=${cc_arch%%=*}
> -                eval "cross_cc_${cc_arch}=\$optarg"
> -  ;;
> -  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
> -  ;;
> -  --cross-prefix-*) cc_arch=${opt#--cross-prefix-}; cc_arch=${cc_arch%%=*}
> -                    eval "cross_prefix_${cc_arch}=\$optarg"
> -  ;;
>    --without-default-features) default_feature="no"
>    ;;
>    --wasm64-32bit-address-limit) wasm64_memory64="2"
> @@ -631,9 +618,19 @@ for opt do
>    ;;
>    --extra-ldflags=*)
>    ;;
> -  --cross-cc-*)
> +  --cross-cc-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-cc-FOO option"
> +  ;;
> +  --cross-cc-cflags-*) arch=${opt#--cross-cc-cflags-}; arch=${arch%%=*}
> +                       meson_option_add "-Dtcg_tests_cross_cflags_${arch}=${optarg}"
> +  ;;
> +  --cross-cc-*) arch=${opt#--cross-cc-}; arch=${arch%%=*}
> +                meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}"
> +  ;;
> +  --cross-prefix-*[!a-zA-Z0-9_-]*=*) error_exit "Passed bad --cross-prefix-FOO option"
>    ;;
> -  --cross-prefix-*)
> +  # cross-prefix is just used as a syntactic sugar for -cross-cc.
> +  --cross-prefix-*) arch=${opt#--cross-prefix-}; arch=${arch%%=*}
> +                    meson_option_add "-Dtcg_tests_cross_cc_${arch}=${optarg}gcc"
>    ;;
>    --enable-docs) docs=enabled
>    ;;
> diff --git a/meson_options.txt b/meson_options.txt
> index f9604a6c192..292625af08a 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -391,3 +391,92 @@ option('containers', type: 'boolean', value: true,
>         description: 'use containers to cross compile tcg tests')
>  option('container_command', type: 'string',
>         description: 'command to build/run containers')
> +
> +option('tcg_tests_cross_cc_aarch64', type: 'string',
> +       description: 'cc for aarch64 tcg tests')
> +option('tcg_tests_cross_cflags_aarch64', type: 'string',
> +       description: 'cflags for aarch64 tcg tests')
> +option('tcg_tests_cross_cc_aarch64_be', type: 'string',
> +       description: 'cc for aarch64_be tcg tests')
> +option('tcg_tests_cross_cflags_aarch64_be', type: 'string',
> +       description: 'cflags for aarch64_be tcg tests')
> +option('tcg_tests_cross_cc_alpha', type: 'string',
> +       description: 'cc for alpha tcg tests')
> +option('tcg_tests_cross_cflags_alpha', type: 'string',
> +       description: 'cflags for alpha tcg tests')
> +option('tcg_tests_cross_cc_arm', type: 'string',
> +       description: 'cc for arm tcg tests')
> +option('tcg_tests_cross_cflags_arm', type: 'string',
> +       description: 'cflags for arm tcg tests')
> +option('tcg_tests_cross_cc_hexagon', type: 'string',
> +       description: 'cc for hexagon tcg tests')
> +option('tcg_tests_cross_cflags_hexagon', type: 'string',
> +       description: 'cflags for hexagon tcg tests')
> +option('tcg_tests_cross_cc_hppa', type: 'string',
> +       description: 'cc for hppa tcg tests')
> +option('tcg_tests_cross_cflags_hppa', type: 'string',
> +       description: 'cflags for hppa tcg tests')
> +option('tcg_tests_cross_cc_i386', type: 'string',
> +       description: 'cc for i386 tcg tests')
> +option('tcg_tests_cross_cflags_i386', type: 'string',
> +       description: 'cflags for i386 tcg tests')
> +option('tcg_tests_cross_cc_loongarch64', type: 'string',
> +       description: 'cc for loongarch64 tcg tests')
> +option('tcg_tests_cross_cflags_loongarch64', type: 'string',
> +       description: 'cflags for loongarch64 tcg tests')
> +option('tcg_tests_cross_cc_m68k', type: 'string',
> +       description: 'cc for m68k tcg tests')
> +option('tcg_tests_cross_cflags_m68k', type: 'string',
> +       description: 'cflags for m68k tcg tests')
> +option('tcg_tests_cross_cc_mips', type: 'string',
> +       description: 'cc for mips tcg tests')
> +option('tcg_tests_cross_cflags_mips', type: 'string',
> +       description: 'cflags for mips tcg tests')
> +option('tcg_tests_cross_cc_mips64', type: 'string',
> +       description: 'cc for mips64 tcg tests')
> +option('tcg_tests_cross_cflags_mips64', type: 'string',
> +       description: 'cflags for mips64 tcg tests')
> +option('tcg_tests_cross_cc_mips64el', type: 'string',
> +       description: 'cc for mips64el tcg tests')
> +option('tcg_tests_cross_cflags_mips64el', type: 'string',
> +       description: 'cflags for mips64el tcg tests')
> +option('tcg_tests_cross_cc_or1k', type: 'string',
> +       description: 'cc for or1k tcg tests')
> +option('tcg_tests_cross_cflags_or1k', type: 'string',
> +       description: 'cflags for or1k tcg tests')
> +option('tcg_tests_cross_cc_ppc64', type: 'string',
> +       description: 'cc for ppc64 tcg tests')
> +option('tcg_tests_cross_cflags_ppc64', type: 'string',
> +       description: 'cflags for ppc64 tcg tests')
> +option('tcg_tests_cross_cc_ppc64le', type: 'string',
> +       description: 'cc for ppc64le tcg tests')
> +option('tcg_tests_cross_cflags_ppc64le', type: 'string',
> +       description: 'cflags for ppc64le tcg tests')
> +option('tcg_tests_cross_cc_riscv64', type: 'string',
> +       description: 'cc for riscv64 tcg tests')
> +option('tcg_tests_cross_cflags_riscv64', type: 'string',
> +       description: 'cflags for riscv64 tcg tests')
> +option('tcg_tests_cross_cc_s390x', type: 'string',
> +       description: 'cc for s390x tcg tests')
> +option('tcg_tests_cross_cflags_s390x', type: 'string',
> +       description: 'cflags for s390x tcg tests')
> +option('tcg_tests_cross_cc_sh4', type: 'string',
> +       description: 'cc for sh4 tcg tests')
> +option('tcg_tests_cross_cflags_sh4', type: 'string',
> +       description: 'cflags for sh4 tcg tests')
> +option('tcg_tests_cross_cc_tricore', type: 'string',
> +       description: 'cc for tricore tcg tests')
> +option('tcg_tests_cross_cflags_tricore', type: 'string',
> +       description: 'cflags for tricore tcg tests')
> +option('tcg_tests_cross_cc_x86_64', type: 'string',
> +       description: 'cc for x86_64 tcg tests')
> +option('tcg_tests_cross_cflags_x86_64', type: 'string',
> +       description: 'cflags for x86_64 tcg tests')
> +option('tcg_tests_cross_cc_xtensa', type: 'string',
> +       description: 'cc for xtensa tcg tests')
> +option('tcg_tests_cross_cflags_xtensa', type: 'string',
> +       description: 'cflags for xtensa tcg tests')
> +option('tcg_tests_cross_cc_xtensaeb', type: 'string',
> +       description: 'cc for xtensaeb tcg tests')
> +option('tcg_tests_cross_cflags_xtensaeb', type: 'string',
> +       description: 'cflags for xtensaeb tcg tests')
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 2458a231f5f..9cf632d2717 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -180,6 +180,8 @@ foreach target, plan: tcg_tests
>      continue
>    endif
>  
> +  cc_arch = target.replace('-linux-user', '').replace('-softmmu', '')
> +
>    # Detect duplicated executables/tests, and report an error to force user to
>    # choose how to deal with it.
>    built_tests = {}
> @@ -197,16 +199,35 @@ foreach target, plan: tcg_tests
>    endforeach
>  
>    cc = find_program(plan['cc'], required : false)
> +  cc_cflags = []
> +
> +  check_flags = []
> +  check_required = false
> +  cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
> +  if cross_cc != ''
> +    # we make sure cross cc exists
> +    cc = find_program(cross_cc, required: true)
> +    check_required = true
> +  endif
> +  cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
> +  if cross_cflags != ''
> +    cc_cflags = cross_cflags.split()
> +    # and that cross cc can compile programs
> +    check_flags = cc_cflags
> +    check_required = true
> +  endif
> +
>    cc_from_system = cc.found()
>    has_cc = cc.found()
>    if has_cc
> -    check_flags = ['-static']
>      if target.endswith('softmmu')
> -      check_flags = ['-nostdlib', '-ffreestanding', '-r']
> +      check_flags += ['-nostdlib', '-ffreestanding', '-r']
> +    else
> +      check_flags += ['-static']
>      endif
>  
>      cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
> -                      check: false)
> +                      check: check_required)
>      has_cc = cmd.returncode() == 0
>      cc_from_system = has_cc
>    endif
> @@ -333,9 +354,9 @@ foreach target, plan: tcg_tests
>          endif
>        endif
>  
> -      cflags = []
> +      cflags = cc_cflags
>        if 'cflags' in setup
> -        cflags = setup['cflags']
> +        cflags += setup['cflags']
>        endif
>  
>        if 'cc_feat' in setup
> -- 
> 2.47.3
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



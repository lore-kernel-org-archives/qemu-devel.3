Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A89C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1h3q-0003LX-Bx; Wed, 02 Sep 2026 05:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1h3o-0003Kq-DO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:15:12 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1h3m-00028e-0K
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788340510; x=1819876510;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GBWd6TtW6GY3ZqtcgVHAvdNtoarJd31aa71x/S83FBU=;
 b=GpS0C3sStTxuPECmpvDS+RBRgapsjL3UPN9fHU5mZ56tr/IrdNkjgD9t
 LJwamZefIc3ViYMpYUArCAB6qAJ9hLsHlvGvy7YtjsVwrAdYN2SWCMFQh
 gN2VMhtiJQgfmo7ehy5Rsr3o0JzTUWLnM+nPQcepVycgEN/X4liSODfLC
 HZPL0D6gPhfp27ahOB/RSeAJZXQACGyXUrhgqr/It+TAM7bUWUUJUKsup
 6rz8hTSwNL2Enkw9dEFo6VbCT2+8CXfdQHh3m5uGkTdU6Ewi4e4vKxl+0
 ntBRdvkGuu8x6mKQLZnBrQwmE/JifoD33LKXPIv3zKPxmMXGfpJRuLhX3 g==;
X-CSE-ConnectionGUID: 5WMdeNe2QA29V5E19tfwJw==
X-CSE-MsgGUID: XBDrt4S3QummPjx9YjRPgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114335635"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="114335635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 02:15:06 -0700
X-CSE-ConnectionGUID: WlwMsKVCTUSbZKhwmjh1eA==
X-CSE-MsgGUID: YRT57IvGTGWxZitO9SQzUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="263206180"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa009.fm.intel.com with ESMTP; 02 Sep 2026 02:15:06 -0700
Date: Wed, 2 Sep 2026 17:15:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhaop1.liu@intel.com>
Subject: Re: [PATCH 19/20] target/i386/tcg: mark APX as supported
Message-ID: <apfpGLM4eZd2U9O1@intel.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-20-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825122921.431739-20-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e5ffb10d156..e966bd8049b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1005,7 +1005,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
>            CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
>  #define TCG_7_1_ECX_FEATURES 0
> -#define TCG_7_1_EDX_FEATURES 0
> +#define TCG_7_1_EDX_FEATURES CPUID_7_1_EDX_APXF

And NCI/NDD/NF is supported :-)

+#define TCG_29_0_EBX_FEATURES CPUID_29_0_EBX_APX_NCI_NDD_NF

>  #define TCG_7_2_EDX_FEATURES 0
>  #define TCG_APM_FEATURES 0
>  #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
> @@ -1554,7 +1554,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .tcg_features = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>              XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
> -            XSTATE_PKRU_MASK,
> +            XSTATE_PKRU_MASK | XSTATE_APX_MASK,
>          .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>              XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>              XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
> @@ -9722,6 +9722,17 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>       * inside x86_cpu_parse_featurestr() too.
>       */
>      if (xcc->max_features) {
> +        /*
> +         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
> +         * disable one---prefer APX if none was chosen explicitly.
> +         */
> +        if ((x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX) & CPUID_7_1_EDX_APXF) &&
> +            env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) {
> +            feature_word_info[FEAT_7_1_EDX].no_autoenable_flags |= CPUID_7_1_EDX_APXF;
> +        } else {
> +            feature_word_info[FEAT_7_0_EBX].no_autoenable_flags |= CPUID_7_0_EBX_MPX;
> +        }

I have some thoughts here:

1. we should check env->features[] instead of env->user_features[]
since the latter just indicates whether user touches this feature (maybe
on, or maybe off), in x86_cpu_set_bit_prop().

2. if accel doesn't supports APXF, then it goes to "else" and disable
MPX by default - I think this would hurt KVM.

3. changing feature_word_info seems not good - it is a global variable
and has longer life time than CPU object - so that changes to it will
affect multiple CPU instances (QMP's dummy instance).

For example,

 (QMP) query-cpu-model-expansion type=full model={"name":"max"}

 [mpx=off, apxf=on]

 (QMP) query-cpu-model-expansion type=full model={"name":"max","props":{"mpx":true}}

 [mpx=on, apxf=off]

 (QMP) query-cpu-model-expansion type=full model={"name":"max"}

 [mpx=off, apxf=off, NOTE: this gets the different result with 1st try!]

So, I think that if we're going to change a feature, we should change the
feature list that corresponds to the CPU lifetime, such as env->features[].

But I find it's still tricky to keep this check before FEATURE_WORDS
loop. So how about the following instead? 

-        /*
-         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
-         * disable one---prefer APX if none was chosen explicitly.
-         */
-        if ((x86_cpu_get_supported_feature_word(cpu, FEAT_7_1_EDX) & CPUID_7_1_EDX_APXF) &&
-            env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) {
-            feature_word_info[FEAT_7_1_EDX].no_autoenable_flags |= CPUID_7_1_EDX_APXF;
-        } else {
-            feature_word_info[FEAT_7_0_EBX].no_autoenable_flags |= CPUID_7_0_EBX_MPX;
-        }
-
         for (w = 0; w < FEATURE_WORDS; w++) {
             /* Override only features that weren't set explicitly
              * by the user.
              */
             env->features[w] |=
                 x86_cpu_get_supported_feature_word(cpu, w) &
                 ~env->user_features[w] &
                 ~feature_word_info[w].no_autoenable_flags;
         }

+        /*
+         * TCG supports both MPX and APX.  Since they they cannot be enabled together,
+         * disable one---prefer APX if none was chosen explicitly. If both were
+         * requested explicitly, leave them alone and let the check below report the
+         * conflict.
+         */
+        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) &&
+            (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
+            if (!(env->user_features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX)) {
+                env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_MPX;
+            } else if (!(env->user_features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
+                env->features[FEAT_7_1_EDX] &= ~CPUID_7_1_EDX_APXF;
+            }
+        }

Thanks,
Zhao



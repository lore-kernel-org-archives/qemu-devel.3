Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9357CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0yR-0007s8-61; Fri, 12 Sep 2025 06:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ux0y0-0007qM-1K
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:25:21 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ux0xw-000502-Kd
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 06:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757672717; x=1789208717;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1sbM4yCmeWiXdmOgKFmzG/hAtS/c6dil6UpINZ8Pyuo=;
 b=R2PDa0qXDA5L6rD7DC81BYwM+d+a2Q9c2hssa1065INOV6vPmjkbNrJW
 ZWKA4/8ZWR7fQDzBCD+wgcJgNJlCScsWT/r3bACk6UXu0DDjZeRaoUfcX
 Yv/Ll50nCQRLMcxhWhESVSWETcEImYJjTlFYgm+mtzp7Pg0PR7AD2piUD
 c21tsLMesuzODgoziMzh2SakKJOprbqh9+79gkZXeM4Zoj1gFNxcgtJki
 HveMS7Y6f7rFQZ6pxyjM49FEwIj7/vNLoPxjCzESynbgUiXATTaBd2Fdd
 4KuDxpbpegAlAgZosNRJFdGY1kzUAyRsOieuOT/itxtWKWgMnKdAVBc75 A==;
X-CSE-ConnectionGUID: cU48JOdWS62lEusfdfO1KQ==
X-CSE-MsgGUID: 71qDRp+0QSCQ2V87mKYfmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59952481"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59952481"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 03:25:06 -0700
X-CSE-ConnectionGUID: Bg9eUR2BRFKtN3BDErn30A==
X-CSE-MsgGUID: VZToNpFgRYCy7J6r3g/tMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173102988"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 12 Sep 2025 03:25:05 -0700
Date: Fri, 12 Sep 2025 18:46:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tao1.su@intel.com, chenyi.qiang@intel.com
Subject: Re: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
Message-ID: <aMP6IQ4TR/MW6C6u@intel.com>
References: <20250707141151.4187798-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707141151.4187798-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Xiaoyao,

Rethinking this patch, I would not remove these feature bits with the
comments inline:

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0d35e95430fe..1b50fd4e397d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -912,7 +912,6 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_SGX_12_0_EAX_FEATURES 0
>  #define TCG_SGX_12_0_EBX_FEATURES 0
>  #define TCG_SGX_12_1_EAX_FEATURES 0
> -#define TCG_24_0_EBX_FEATURES 0
>  
>  #if defined CONFIG_USER_ONLY
>  #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
> @@ -1208,20 +1207,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .tcg_features = TCG_7_2_EDX_FEATURES,
>      },
> -    [FEAT_24_0_EBX] = {
> -        .type = CPUID_FEATURE_WORD,
> -        .feat_names = {
> -            [16] = "avx10-128",
> -            [17] = "avx10-256",
> -            [18] = "avx10-512",
> -        },
> -        .cpuid = {
> -            .eax = 0x24,
> -            .needs_ecx = true, .ecx = 0,
> -            .reg = R_EBX,
> -        },
> -        .tcg_features = TCG_24_0_EBX_FEATURES,
> -    },

"Reserved at 1" means always enabling, not being deprecated.

So if someone has already cofigured "+avx10-128,+avx10-256,+avx10-512"
for his cpu, this patch will break his use.

Although explicitly setting AVX10 vector length feature bits appears
uncommon, but explicitly masking off these feature bits is even more
unusual.

Removing these bits has little benefit but brings the risk of breaking
the API.

In the future, QEMU may need the AVX10 model to handle different
versions. A complete feature list is necessary. This is another reason.

In addition, I also agree with KVM's point to keep these feature names:

https://lore.kernel.org/kvm/Zkz5Ak0PQlAN8DxK@google.com/

...

> @@ -7720,7 +7686,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *ecx = 0;
>          *edx = 0;
>          if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
> -            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
> +            /* bit 16-18 are reserved at 1 */
> +            *ebx = (0x7U << 16) | env->avx10_version;

Hardcoding is not friendly for maintenance, and they are essentially
feature bits.

>          }
>          break;
>      }

Thanks,
Zhao



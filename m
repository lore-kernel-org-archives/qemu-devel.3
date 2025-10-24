Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADDBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMPU-0008G3-A4; Fri, 24 Oct 2025 14:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPS-0008Fb-4T
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:06 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vCMPP-0008F3-3M
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 14:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761330063; x=1792866063;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=k0bKNFN0B0DwSby0hg8BRKJ31o3jyXYJrBr5Tg8C/Gk=;
 b=fuKue24RAhY5SGhmkq5OsiZ2F9hyA4yeQetsEj6mxPt5X7/XI8z391Z0
 VECTTcl6E418ndAhclCmvlv0/EKdgWAwqG0eHNy0JfpUNqcHlHTfHDnJn
 FRlndf56T3IPoNSKYuF/W2p4vybXUGommfKGtEfmDnvMCP2BzHOh7UVdQ
 BQa3ujDRco1Wo7cb6tQjNZxVtfivb9NbTmevId7qcrx8Soo4imQ2yG8fH
 xMq1/47Gov9rUPRrXC+U8VtGnJrI6Bk539ruJY49e6sz/LRPX5FaMujiP
 8mzZyoZzlJcf1QteCr3cT/kNRTKKvMhT9SVW3k4mGLNivy3vekF/yyG/P w==;
X-CSE-ConnectionGUID: GkaCi573QaOwYWBMouo/9g==
X-CSE-MsgGUID: SaB+SO6bRTST3QdVhwjQRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74119590"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="74119590"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:21:00 -0700
X-CSE-ConnectionGUID: c8BeN2ToToylWoHyo6OlaA==
X-CSE-MsgGUID: hiQFBLg+RB2RwDzMTdD+kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; d="scan'208";a="188882489"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.241.181])
 ([10.241.241.181])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 11:20:59 -0700
Message-ID: <242b8c3f-72bd-44f5-94f9-186ef87697c8@intel.com>
Date: Fri, 24 Oct 2025 11:20:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/20] i386/cpu: Clean up arch lbr xsave struct and
 comment
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-4-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251024065632.1448606-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zide.chen@intel.com;
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



On 10/23/2025 11:56 PM, Zhao Liu wrote:
> Arch LBR state is area 15, not 19. Fix this comment. And considerring
> other areas don't mention user or supervisor state, for consistent
> style, remove "Supervisor mode" from its comment.
> 
> Moreover, rename XSavesArchLBR to XSaveArchLBR since there's no need to
> emphasize XSAVES in naming; the XSAVE related structure is mainly
> used to represent memory layout.
> 
> In addition, arch lbr specifies its offset of xsave component as 0. But
> this cannot help on anything. The offset of ExtSaveArea is initialized
> by accelerators (e.g., hvf_cpu_xsave_init(), kvm_cpu_xsave_init() and
> x86_tcg_cpu_xsave_init()), so explicitly setting the offset doesn't
> work and CPUID 0xD encoding has already ensure supervisor states won't
> have non-zero offsets. Drop the offset initialization and its comment
> from the xsave area of arch lbr.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>


> ---
>  target/i386/cpu.c | 3 +--
>  target/i386/cpu.h | 8 ++++----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f0e179c2d235..b9a5a0400dea 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2058,8 +2058,7 @@ ExtSaveArea x86_ext_save_areas[XSAVE_STATE_AREA_COUNT] = {
>      },
>      [XSTATE_ARCH_LBR_BIT] = {
>          .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_ARCH_LBR,
> -        .offset = 0 /*supervisor mode component, offset = 0 */,
> -        .size = sizeof(XSavesArchLBR),
> +        .size = sizeof(XSaveArchLBR),
>      },
>      [XSTATE_XTILE_CFG_BIT] = {
>          .feature = FEAT_7_0_EDX, .bits = CPUID_7_0_EDX_AMX_TILE,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index d0da9bfe58ce..886a941e481c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1747,15 +1747,15 @@ typedef struct {
>  
>  #define ARCH_LBR_NR_ENTRIES            32
>  
> -/* Ext. save area 19: Supervisor mode Arch LBR state */
> -typedef struct XSavesArchLBR {
> +/* Ext. save area 15: Arch LBR state */
> +typedef struct XSaveArchLBR {
>      uint64_t lbr_ctl;
>      uint64_t lbr_depth;
>      uint64_t ler_from;
>      uint64_t ler_to;
>      uint64_t ler_info;
>      LBREntry lbr_records[ARCH_LBR_NR_ENTRIES];
> -} XSavesArchLBR;
> +} XSaveArchLBR;
>  
>  QEMU_BUILD_BUG_ON(sizeof(XSaveAVX) != 0x100);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveBNDREG) != 0x40);
> @@ -1766,7 +1766,7 @@ QEMU_BUILD_BUG_ON(sizeof(XSaveHi16_ZMM) != 0x400);
>  QEMU_BUILD_BUG_ON(sizeof(XSavePKRU) != 0x8);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveXTILECFG) != 0x40);
>  QEMU_BUILD_BUG_ON(sizeof(XSaveXTILEDATA) != 0x2000);
> -QEMU_BUILD_BUG_ON(sizeof(XSavesArchLBR) != 0x328);
> +QEMU_BUILD_BUG_ON(sizeof(XSaveArchLBR) != 0x328);
>  
>  typedef struct ExtSaveArea {
>      uint32_t feature, bits;



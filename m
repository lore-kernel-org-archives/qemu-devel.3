Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC8AC3601E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 03:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u34eh-00020M-VX; Thu, 10 Apr 2025 23:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u34ee-0001zm-U8
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 23:02:09 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u34ec-00039v-So
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 23:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744340527; x=1775876527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IumBLXUe8VhFG05ZvOX+MsW6+sGEoY4rN7+tPuKUsAA=;
 b=XDqGdJ0aKZIXpo+hL0/b1R8Xj7H7UmVvW0oAp4/nU9KVmlcI2wGPBuzl
 o901clKl8gupnQtXGzVQnJVbBSaMCvfZgRLJuLtWAxG+y+CFueTCjo8o8
 gQ0AeRgZH65b549tzTr7KWRaLCHTJwYSEhXINlxnCwehyEIrCaMtTHTxO
 TaR7yF0FqfBxbchCnH5uk98iNu+dE0C5ZqEmfygOLvWd8ZUPrtyw5gb2y
 EhrBxLT+WybAi3GLgIvO2NyU6lv278zHGhXSpVe+RkQbgFwizeTCFSMTM
 a2KCE+aODjT4xU6+LHZQYLVaWWAGSUmHXoXn/duGoTv5EbCZvzXYihK4+ Q==;
X-CSE-ConnectionGUID: DF2P4uFWR9q2pfLRnaZooQ==
X-CSE-MsgGUID: BDG2jIH5QRqJ/r+MiY955A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45021893"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="45021893"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 20:01:22 -0700
X-CSE-ConnectionGUID: 4ODoIhQyQIaNY+BSuyK28w==
X-CSE-MsgGUID: PdEDhXdgQY+kFN57qxaXDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="133175758"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 10 Apr 2025 20:01:21 -0700
Date: Fri, 11 Apr 2025 11:22:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng
 vCPU template
Message-ID: <Z/iK4wVFWTjhEa32@intel.com>
References: <20250407020704.2580294-1-ewanhai-oc@zhaoxin.com>
 <a0ca7d33-5551-41a7-be18-7fdb3b32a36a@redhat.com>
 <a8750eb8-63ad-4ed8-a80d-f4568c4bc778@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8750eb8-63ad-4ed8-a80d-f4568c4bc778@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

On Thu, Apr 10, 2025 at 10:07:15PM +0800, Ewan Hai wrote:
> Date: Thu, 10 Apr 2025 22:07:15 +0800
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH v2] target/i386: Fix model number of Zhaoxin YongFeng
>  vCPU template
> 
> On 4/10/25 8:22 PM, Paolo Bonzini wrote:
> > 
> > On 4/7/25 04:07, Ewan Hai wrote:
> > > The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> > > The correct value is 0x5b. This mistake occurred because the extended
> > > model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> > > model was used.
> > > 
> > > This patch corrects the model field.
> > 
> > Hi, please follow commit e0013791b9326945ccd09b5b602437beb322cab8 to
> > define a new version of the CPU.
> 
> I¡¯ve noticed that in the QEMU repository at commit
> e0013791b9326945ccd09b5b602437beb322cab8 (as HEAD), the following patches I
> previously submitted (which the Zhaoxin YongFeng vCPU model depends on) are
> not included:

:-) e0013791b9326945ccd09b5b602437beb322cab8 is an example case to show
how to fix model id.

> - 5d20aa540b6991c0dbeef933d2055e5372f52e0e: "target/i386: Add support for
> Zhaoxin CPU vendor identification"
> - c0799e8b003713e07b546faba600363eccd179ee: "target/i386: Add CPUID leaf
> 0xC000_0001 EDX definitions"
> - ff04bc1ac478656e5d6a255bf4069edb3f55bc58: "target/i386: Introduce Zhaoxin
> Yongfeng CPU model" (this is the main patch that needs to be fixed)
> - a4e749780bd20593c0c386612a51bf4d64a80132: "target/i386: Mask CMPLegacy bit
> in CPUID[0x80000001].ECX for Zhaoxin CPUs"
> 
> Should I resend the entire patchset, or would it be sufficient to just send
> a revised version of the ¡°target/i386: Introduce Zhaoxin Yongfeng CPU model¡±
> patch?
 
IIUC, because this fix is planning to land in v10.1 (next release
cycle), current CPU model (will be released in v10.0) can't be modified
directly. It is only possible to directly modify an unreleased CPU model
during the same release cycle.

Thus it's enough to just introduce a v2 and correct your model id like
this:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba46..1ca1c3a729e8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5621,6 +5621,17 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Zhaoxin YongFeng Processor",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "model", "0x5b" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
 };







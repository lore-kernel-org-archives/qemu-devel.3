Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFC9CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUdNi-0003gn-Ph; Wed, 03 Jun 2026 00:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wUdNg-0003gG-T5
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 00:39:04 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wUdNe-0001l6-PN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 00:39:04 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 865BD44611;
 Wed,  3 Jun 2026 04:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3580F1F00893;
 Wed,  3 Jun 2026 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780461540;
 bh=Tgc/mBwwWLf0yTSd7ryI7LY/lT7cZticZ4+48xKlahk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dmXopBRDIItTLCEyP4JGn4QYkDJtdSQZhG2wNRlL1brdDiBerICVAsVVTweDMR7gR
 ldxpXV6G4SWOFXRx/3yWX5LT6eCaQEp3D+rLTTxeASwo8sktJIJ36ffFgTsqzNiieK
 PQhERG7OgOHMblnZr/dj39kAed6MIaNvPbe6Je67t0hbzJEJS1KE7yijpvSgE2Zp4J
 +aWWLaO3z/4NWSuybggboZ4cXn0kmB05P0+lPDf07ttqjeltlgHDgYSbdgxI35Nc1k
 WHUXr2GRjJdNHH4L/eWDcOs0EANeXmZlGF8biDxdDv+GjKUeJwzP8rDBQZcJ56pnm2
 /QZme+qpmexpg==
Date: Wed, 3 Jun 2026 10:02:37 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, 
	qemu-devel <qemu-devel@nongnu.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, 
 Joerg Roedel <joro@8bytes.org>, Manali Shukla <manali.shukla@amd.com>
Subject: Re: [RFC PATCH] target/i386: SEV: Allow pflash devices with SEV-ES
 guests
Message-ID: <ah-sVzEY5npAf5Y_@blrnaveerao1>
References: <20260602071213.2084388-1-naveen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602071213.2084388-1-naveen@kernel.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 02, 2026 at 12:42:13PM +0530, Naveen N Rao (AMD) wrote:
> KVM commit 66155de93bcf ("KVM: x86: Disallow read-only memslots for
> SEV-ES and SEV-SNP (and TDX)"), and the subsequent commit d30d9ee94cc0
> ("KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM")
> stopped advertising KVM_CAP_READONLY_MEM support for encrypted guests
> (KVM_X86_SEV_ES_VM and KVM_X86_SNP_VM), but not for KVM_X86_DEFAULT_VM
> type SEV-ES guests. As a result of this, it is no longer possible to
> start SEV-ES guests with any SEV feature enabled (in particular,
> debug-swap) with pflash devices.
> 
> This is an issue since SEV-ES guests have historically used pflash
> devices for OVMF. Guests on older KVM+Qemu are able to enable debug-swap
> while using pflash devices, so work around the KVM limitation by
> switching to using a VMA-based write protection. This allows
> well-behaved SEV-ES guests to continue to work with pflash devices and
> enable debug-swap. Mis-behaving guests trying to write to the protected
> OVMF area will be killed.
> 
> Enable VMA protection and set the memory to be RO when adding the KVM
> memory slot. Because pflash devices support command-mode, change VMA
> protection to RW when tearing down the KVM memory slot. KVM
> SEV_LAUNCH_UPDATE also requires memory to be RW, so disable the
> protection when calling that.
> 
> Print a warning when switching to VMA-based protection so that it is
> clear that KVM itself isn't supporting readonly memory, and that a
> workaround is in place. Users can plan on switching to using '-bios'.
> 
> Finally, drop the check rejecting SEV-ES guests with SEV features so 
> that debug-swap can be enabled.
> 
> 
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
> Background discussion on this issue:
> http://lore.kernel.org/r/aUq9_cUDWeEW_qli@google.com
> 
> This series depends on VMSA features support:
> http://lore.kernel.org/r/cover.1779281646.git.naveen@kernel.org
> 

...

> @@ -2024,6 +2018,15 @@ static int 
> sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          return -1;
>      }
>  
> +    /*
> +     * Use VMA-based protection for SEV-ES guests that enable any
> +     * SEV feature, since KVM does not advertise readonly memory
> +     * support for non-default type SEV guests.
> +     */
> +    if (sev_es_enabled() && SEV_COMMON(cgs)->sev_features) {
> +        kvm_enable_ro_mem_vma_protection();
> +    }
> +

Manali reported that -bios no longer works due to this change. That's 
because we enable protection for all SEV-ES guests here. A simple fix is 
to move this to where we throw the warning for pflash today (diff 
below).

It looks like we will need an additional change for kernel-hashes since 
that also calls into sev_encrypt_flash(), so we need to move calls to 
mprotect to the OVMF caller.  The diff below also addresses that.

I will wait for some feedback on this patch/approach before posting the 
next version.


- Naveen

---
 hw/i386/pc_sysfw.c      |  1 +
 hw/i386/pc_sysfw_ovmf.c |  8 ++++++++
 target/i386/sev.c       | 15 ---------------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 9590458e00c5..41da3685b98f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -257,6 +257,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
             if (sev_es_enabled() && !sev_snp_enabled()) {
                 warn_report("pflash not supported with SEV-ES guests, "
                             "attempting VMA based protection");
+                kvm_enable_ro_mem_vma_protection();
             } else {
                 /*
                  * Older KVM cannot execute from device memory. So, flash
diff --git a/hw/i386/pc_sysfw_ovmf.c b/hw/i386/pc_sysfw_ovmf.c
index 2f7d15c9f3eb..d7a2e36aa736 100644
--- a/hw/i386/pc_sysfw_ovmf.c
+++ b/hw/i386/pc_sysfw_ovmf.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "target/i386/sev.h"
 #include "kvm/tdx.h"
+#include "system/kvm.h"
 
 #define OVMF_TABLE_FOOTER_GUID "96b582de-1fb2-45f7-baea-a366c55a082d"
 
@@ -184,7 +185,14 @@ void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
             exit(1);
         }
 
+        /*
+         * KVM requires these pages to be RW for SEV_LAUNCH_UPDATE_DATA,
+         * so remove VMA RO protection if any, for the duration of
+         * sev_encrypt_flash().
+         */
+        kvm_set_memory_readwrite(ptr, size);
         sev_encrypt_flash(gpa, ptr, size, &error_fatal);
+        kvm_set_memory_readonly(ptr, size);
     } else if (is_tdx_vm()) {
         ret = tdx_parse_tdvf(ptr, size);
         if (ret) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 0876e7c1fa1e..dc8851a12927 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2018,15 +2018,6 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    /*
-     * Use VMA-based protection for SEV-ES guests that enable any
-     * SEV feature, since KVM does not advertise readonly memory
-     * support for non-default type SEV guests.
-     */
-    if (sev_es_enabled() && SEV_COMMON(cgs)->sev_features) {
-        kvm_enable_ro_mem_vma_protection();
-    }
-
     if (!cgs->ready) {
         /*
          * SEV uses these notifiers to register/pin pages prior to guest use,
@@ -2114,13 +2105,7 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         int ret;
 
-        /*
-         * KVM requires these pages to be RW, so remove VMA RO protection
-         * for the duration of SEV_LAUNCH_UPDATE if using SEV features.
-         */
-        kvm_set_memory_readwrite(ptr, len);
         ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
-        kvm_set_memory_readonly(ptr, len);
         if (ret < 0) {
             return ret;
         }
-- 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429DAD10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHDF-0000Tp-6i; Wed, 26 Nov 2025 10:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOHCZ-0000Ag-Dy
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:13:03 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOHCV-0003d9-HL
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764169979; x=1795705979;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1RkIPUMbbgwD+fSkCBLsafOj+kpQf9/V3jdUzM1m5lU=;
 b=Ou4L5JgYobRDAK1u69k0qJ9YCn+BOQ6s3736ph0VIKzcAuY13Nn/+sqt
 6MvSe9EfVHxvE3C0e5LhWtsGQ1zNT4DpnGB7zYeTPWRfAuX4CeZan2H8R
 uSZo5GaWxRdtBtJ7eO4ax9XXwpw+u/rG/NoN2fQVLTHW+Gi7rDn9xAPX6
 Uns8D2ilA6ZkUPSeK6pvgIz38DbXOHwFJ6xITvsa+HkFC+/Nw9sggY3sc
 LtEtHPcVifE5+UGFXpWtyVpTvB0lAgrMFtGJFO5jXbq5qgUHgkNCdfyVa
 DbBJNl8Ofz+tIV4K+nSoI4sTvygEFVEJ6TWrxVINUV5MBNBQBu5uhcocv w==;
X-CSE-ConnectionGUID: Sbl6aHHDRO2lGog4KmlF/Q==
X-CSE-MsgGUID: 3bsnuxOvRd2mewsDdfwV3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="88856601"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="88856601"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 07:12:54 -0800
X-CSE-ConnectionGUID: HnX0kln7TgSYrYiXYXIskw==
X-CSE-MsgGUID: v5wn4s+XREuro2+9hJc9Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="197292529"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 26 Nov 2025 07:12:53 -0800
Date: Wed, 26 Nov 2025 23:37:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5] hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug
 field
Message-ID: <aScevCMDynm1dtIo@intel.com>
References: <20250508133550.81391-3-philmd@linaro.org>
 <20251031142825.179239-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031142825.179239-1-imammedo@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Hi Igor,

I find after removing legacy cpu hotplug totally, it seems necessary to
update docs/specs/acpi_cpu_hotplug.rst as well, since then QEMU doesn't
have legacy cpu hotplug. Do you agree?

I also attached my update for that doc. If this change is fine for you,
I will squash that doc change into another patch that removes
cpu_hotplug.[h|c] - I split your this patch into several parts
(following you another previous suggestion [*] to make review easier).
:)

[*]: https://lore.kernel.org/qemu-devel/20250509171847.0b505c96@imammedo.users.ipa.redhat.com/

Thanks,
Zhao
---
From ff3da76cf7de097c42bdaf64850dc4df65b4bf4a Mon Sep 17 00:00:00 2001
From: Zhao Liu <zhao1.liu@intel.com>
Date: Wed, 26 Nov 2025 23:06:09 +0800
Subject: [PATCH] docs/specs/acpi_cpu_hotplug.rst: remove legacy cpu hotplug
 descriptions

Legacy cpu hotplug has been removed totally and machines start with
modern cpu hotplug interface directly.

Therefore, update the documentation to describe current QEMU cpu hotplug
logic.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/specs/acpi_cpu_hotplug.rst | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.rst b/docs/specs/acpi_cpu_hotplug.rst
index 351057c96761..f49678100044 100644
--- a/docs/specs/acpi_cpu_hotplug.rst
+++ b/docs/specs/acpi_cpu_hotplug.rst
@@ -8,22 +8,6 @@ ACPI BIOS GPE.2 handler is dedicated for notifying OS about CPU hot-add
 and hot-remove events.


-Legacy ACPI CPU hotplug interface registers
--------------------------------------------
-
-CPU present bitmap for:
-
-- ICH9-LPC (IO port 0x0cd8-0xcf7, 1-byte access)
-- PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
-- One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
-- The first DWORD in bitmap is used in write mode to switch from legacy
-  to modern CPU hotplug interface, write 0 into it to do switch.
-
-QEMU sets corresponding CPU bit on hot-add event and issues SCI
-with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
-to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
-
-
 Modern ACPI CPU hotplug interface registers
 -------------------------------------------

@@ -189,20 +173,14 @@ Typical usecases
 (x86) Detecting and enabling modern CPU hotplug interface
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-QEMU starts with legacy CPU hotplug interface enabled. Detecting and
-switching to modern interface is based on the 2 legacy CPU hotplug features:
-
-#. Writes into CPU bitmap are ignored.
-#. CPU bitmap always has bit #0 set, corresponding to boot CPU.
-
-Use following steps to detect and enable modern CPU hotplug interface:
+QEMU starts with modern CPU hotplug interface enabled. Use following steps to
+detect modern CPU hotplug interface:

-#. Store 0x0 to the 'CPU selector' register, attempting to switch to modern mode
 #. Store 0x0 to the 'CPU selector' register, to ensure valid selector value
 #. Store 0x0 to the 'Command field' register
 #. Read the 'Command data 2' register.
    If read value is 0x0, the modern interface is enabled.
-   Otherwise legacy or no CPU hotplug interface available
+   Otherwise no CPU hotplug interface available

 Get a cpu with pending event
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--
2.34.1



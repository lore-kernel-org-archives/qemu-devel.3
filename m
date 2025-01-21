Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17CC02181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 02:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta3nV-00029X-5w; Mon, 20 Jan 2025 21:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nM-00025y-DB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:12 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1ta3nK-0002bj-MB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737425711; x=1768961711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TP2K8Rb/jMMnS5wMO67nH1b3eOlVP63rsStWUrnWzgI=;
 b=hh9DVjL37SDH1m7kS5vxPALvncVDPNrOPzRz/XJ/I7s8F7Ek6UqWa5+8
 CSECZw+AQn50guKq2IqsTQ4Y9EUsjWapB3jWN1gMmzrQ8Kjd8sGioB+cD
 0KrjcFGd50xXNJFsdVi6SFxHg2MLPg3cWsAxF3l1ypg+KkbSu8NQdzn3z
 eP4Zy/pZoUIiQTb44/elSyCahnMBTAvbgLuiNPJ4clsz8jy085CZTYIQZ
 lYa1oIaq0JXKSkE0Ftg/EqwhTXtbKbiz1qD/4VmTINHsulbSwmCjxE5Ib
 JhGfb9bMHEZYJYDRFy2iXY8robpnRcOGdVPcTpzE0Cl/P/wHoDrju59e2 A==;
X-CSE-ConnectionGUID: o39b2KySS6yY1JpfJ1Lxng==
X-CSE-MsgGUID: U+fu/mA1Ri6F3TSQQrGR4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48320170"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="48320170"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 18:15:10 -0800
X-CSE-ConnectionGUID: V5Dc/6BvTIufiYxupB3TiQ==
X-CSE-MsgGUID: NGVYPJZJRpu+f4wwp87hOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="106599381"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by fmviesa007.fm.intel.com with ESMTP; 20 Jan 2025 18:15:08 -0800
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@linux.intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 4/4] docs: Add GNR, SRF and CWF CPU models
Date: Tue, 21 Jan 2025 10:06:50 +0800
Message-Id: <20250121020650.1899618-5-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121020650.1899618-1-tao1.su@linux.intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Update GraniteRapids, SierraForest and ClearwaterForest CPU models in
section "Preferred CPU models for Intel x86 hosts".

Also introduce bhi-no, gds-no and rfds-no in doc.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 docs/system/cpu-models-x86.rst.inc | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
index ba27b5683f..f0b5189d91 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -71,6 +71,16 @@ mixture of host CPU models between machines, if live migration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
 
+``ClearwaterForest``
+    Intel Xeon Processor (ClearwaterForest, 2025)
+
+``SierraForest``, ``SierraForest-v2``
+    Intel Xeon Processor (SierraForest, 2024), SierraForest-v2 matigates
+    the GDS and RFDS vulnerabilities with stepping 3.
+
+``GraniteRapids``, ``GraniteRapids-v2``
+    Intel Xeon Processor (GraniteRapids, 2024)
+
 ``Cascadelake-Server``, ``Cascadelake-Server-noTSX``
     Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels 6
     or 7 only.  (The Cascade Lake Xeon processor with *stepping 5 is
@@ -223,6 +233,38 @@ features are included if using "Host passthrough" or "Host model".
   ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort`` file in
   the guest should report ``Mitigation: TSX disabled``.
 
+``bhi-no``
+  Recommended to inform that the guest that the host is ``not``
+  vulnerable to CVE-2022-0001, Branch History Injection (BHI).
+
+  This too is an MSR feature, so it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports
+  ``BHI: Not affected`` in the
+  ``/sys/devices/system/cpu/vulnerabilities/spectre_v2`` file.
+
+``gds-no``
+  Recommended to inform that the guest that the host is ``not``
+  vulnerable to CVE-2022-40982, Gather Data Sampling (GDS).
+
+  This too is an MSR feature, so it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/gather_data_sampling``
+  file.
+
+``rfds-no``
+  Recommended to inform that the guest that the host is ``not``
+  vulnerable to CVE-2023-28746, Register File Data Sampling (RFDS).
+
+  This too is an MSR feature, so it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling``
+  file.
 
 Preferred CPU models for AMD x86 hosts
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- 
2.34.1



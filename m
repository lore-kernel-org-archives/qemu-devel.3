Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC4C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8ei-0002Db-AF; Thu, 06 Jun 2024 04:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF8ee-0002DP-W5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:39:29 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF8ed-0004nc-2h
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717663167; x=1749199167;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O3uw5Ndb6sbyAdzF8DKyuQuxvsyqDFaZheHCc+LV6cU=;
 b=lctA5EWK/xz0aLIiLnRrXlZEaxWWUUAUCfuX+ZftA9cT8MfG8G1dL4qo
 Hox52HjXwrNq3hGAMc9cmMe6/QbVKvZlW8uKVUuiMiDV4pCTrUq6ZYLzx
 FMFl4jZi6qqw+XBeUpnCTcoTMLaBQjoU8ixjvF7rUB//gwB3T6H6E8r+Q
 xpP/fMqBirH9hUGNMppOU1qZ77SouRIPK5djny/kLDVgi8y+cLaO0m5zv
 VFPtmVrRQekH+gbGAFRPi+6YjtsizvGwp9qEWp/dEnWV3RV1LeNnSjhC9
 MSeU64Ypi3KtKDxmn8Hw8dbP2U5uye4KL3Q7DvTgSXYycMeB0FKiboTa0 g==;
X-CSE-ConnectionGUID: f1ULOJ3STfG2Bm5zSrbXJg==
X-CSE-MsgGUID: gv1C6GDwQo+BLD3EDKdo0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14058982"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="14058982"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 01:39:24 -0700
X-CSE-ConnectionGUID: IoVW7Cj+StWAGGtZ7rKWbw==
X-CSE-MsgGUID: Oygk6NrLS/GfnRYay2UDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="37956760"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 06 Jun 2024 01:39:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] docs: i386: pc: Avoid mentioning limit of maximum vCPUs
Date: Thu,  6 Jun 2024 16:54:36 +0800
Message-Id: <20240606085436.2028900-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Different versions of PC machine support different maximum vCPUs, and
even different features have limits on the maximum number of vCPUs (
For example, if x2apic is not enabled in the TCG case, the maximum of
255 vCPUs are supported).

It is difficult to list the maximum vCPUs under all restrictions. Thus,
to avoid confusion, avoid mentioning specific maximum vCPU number
limitations here.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/system/target-i386-desc.rst.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
index 319e540573d3..ae312b1c1e61 100644
--- a/docs/system/target-i386-desc.rst.inc
+++ b/docs/system/target-i386-desc.rst.inc
@@ -36,7 +36,8 @@ The QEMU PC System emulator simulates the following peripherals:
 -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
    hub.
 
-SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
+SMP is supported with a large number of virtual CPUs (upper limit is
+configuration dependent).
 
 QEMU uses the PC BIOS from the Seabios project and the Plex86/Bochs LGPL
 VGA BIOS.
-- 
2.34.1



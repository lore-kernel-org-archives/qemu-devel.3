Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB8C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmt8-0007xE-7j; Mon, 07 Jul 2025 10:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYmkk-0000oP-Ta
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:23:30 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYmkd-0003ad-1J
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751898203; x=1783434203;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PTjAZBusyBPL3ajvGomO5bUi034pYtFAs+m5/D3LElM=;
 b=HxFmLHyCrk4sasDm7k4XLCWNopM4EV5vfAV4ehtvqmZzUqvYAvh9GTZk
 MTjRAwUU61VQWgkpCKV1VocfBiF0bpDBoKlOfwyMIdDcD1lauTTuCjjn/
 Q0kdfbNHasC1HWUv9WiNUqpEff9aUlKxL5fHjaCxffSbXmL6PtK2lQWFo
 IeLKYQepD3KqVUnx2UlAyxw5A7vWRyZBHHnk3nfFf/bYdxLSFVuIh7RVO
 WjE7+3Mkgk17pZtNBV5VZTHOkGi05zA9AC9nfgAFRWwo5QiqcMtii6du+
 v27jAIc+ScDBl6wfWRt3IWFNp21BE5nUdckC+Zsl59fsdVAsOKIWJ+G4H w==;
X-CSE-ConnectionGUID: YAWCsjluSNOvqt6gFKJHVQ==
X-CSE-MsgGUID: nbhjRHGyTf+M6cz2jLn4Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54091234"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="54091234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 07:23:14 -0700
X-CSE-ConnectionGUID: obyjhDgfTCekZv/7zKcJ5w==
X-CSE-MsgGUID: qq/9KLrHQ5uKPoqBahJjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="155813160"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 07 Jul 2025 07:23:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add entry and reviewer for TDX
Date: Mon,  7 Jul 2025 22:15:28 +0800
Message-ID: <20250707141528.4188484-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I will continue looking after the TDX code in QMEU.

Add a specific entry for TDX  and add myself as the reviewer.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1842c3dd83fb..3937faf700f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -481,6 +481,14 @@ F: target/i386/sev*
 F: scripts/kvm/vmxcap
 F: tests/functional/test_x86_64_hotplug_cpu.py
 
+X86 TDX
+R: Xiaoyao Li <xiaoyao.li@intel.com>
+S: Supported
+F: target/i386/kvm/tdx*
+F: hw/i386/tdvf*
+F: include/hw/i386/tdvf*
+F: docs/system/i386/tdx.rst
+
 Xen emulation on X86 KVM CPUs
 M: David Woodhouse <dwmw2@infradead.org>
 M: Paul Durrant <paul@xen.org>
-- 
2.43.0



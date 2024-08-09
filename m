Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B65C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 02:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scFhT-0001rc-7P; Thu, 08 Aug 2024 22:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhS-0001qI-0E
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:54 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhQ-0000eY-4V
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723171793; x=1754707793;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3q1zJZ//GoxBS56Kh0HsoS3aXx9B2oO/r+rdOoTazB8=;
 b=BvzG73ZLfy5gHw4QI1whmSWn3t/ewID2f0+UYY1vz/wUmEu0kCliEZ3k
 I8avOfiFAorHP8m58kil91/+1nZEDT+qdXOWWTlk4e1z8YsK5XlpV+aSE
 b7EYHTi/jSIbevr9rVeD12MoIFtUVlWbey22vhd93YELdVPOzo+/AoGUC
 9ivSBNxBppG3fq9RdnIKCHZMlnxfK4hg3OktSITC8HECXmUoLd3RlE2gx
 icResjLoyjvKfRv0cWjXE95pdTBb70Nu9niRMG5uAJyK1BYw6jswrRSNv
 mcm5OpX9p5rCD9ezy0IT1VSPn1sYTOMV9NSmNylDA5P0V60FWE3W1NLGC A==;
X-CSE-ConnectionGUID: ZiriOZsPS3KJajttaCT6fA==
X-CSE-MsgGUID: 4YJFmr5dTrmslraFl2AfSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21484098"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="21484098"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 19:49:47 -0700
X-CSE-ConnectionGUID: AtCkfp2HRO2j0WSk6sNaxw==
X-CSE-MsgGUID: JiAVW4XNTt2MoWknobMJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="62377619"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
 by orviesa004.jf.intel.com with ESMTP; 08 Aug 2024 19:49:44 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	alistair.francis@wdc.com
Cc: xiaobo55x@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/acpi: Add empty ACPI SRAT data file for RISC-V
Date: Fri,  9 Aug 2024 11:09:47 +0800
Message-Id: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=haibo1.xu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

As per process documented (steps 1-3) in bios-tables-test.c, add
empty AML data file for RISC-V ACPI SRAT table and add the entry
in bios-tables-test-allowed-diff.h.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tests/data/acpi/riscv64/virt/SRAT.numamem   | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem

diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a3e01d2eb7 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SRAT.numamem",
-- 
2.34.1



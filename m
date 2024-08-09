Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CAEC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 02:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scFhV-0001zX-5M; Thu, 08 Aug 2024 22:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhT-0001ro-8C
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:55 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1scFhQ-0000eg-70
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 22:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723171793; x=1754707793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gTWPhn0Sazi3pvlcBT8v0Y9LZMTNHagz1l9t7zmUA4w=;
 b=S7r2TRR+LyOFCb1D1RL2U+4OM5M6TLAP3XFtdi36gq+LydjZcto8ZyhP
 +SgTDdvQPWJ+wW0/ngIU3HrH0gKpPN9QXij8JuegYOn2OEXQ4znNHsgdA
 JlfGTWACjlxfXsLZqRN6+ybrKKIwsw2Picsy9qpedgn7FQVGSYJ4ruERq
 XEoC9wNPrWHEZNWaYCuyYUy084x+rFh8gfIW3PUC/BhOeQXOw9Evp3WS6
 +ooyRbaPdE0Es/jHfRDSn4YRwMk2UYP38aR7TwE41S3EgIx/elzdZc3MM
 apM+16PilyuxHVz32CboV3VzoqruCXhC82T4H5WEiWMHnpb6a6yh/aYlN A==;
X-CSE-ConnectionGUID: 6p8CSJkkSGOFYWTWw6eCnQ==
X-CSE-MsgGUID: Np4nnHlkR6+MCh0Ag+qLQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21484111"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="21484111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 19:49:51 -0700
X-CSE-ConnectionGUID: +0VJB6rlTzG6Gc3IfuQM/g==
X-CSE-MsgGUID: 9HKFxpuJR4meKQ75IyAEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; d="scan'208";a="62377627"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.153.94])
 by orviesa004.jf.intel.com with ESMTP; 08 Aug 2024 19:49:48 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	alistair.francis@wdc.com
Cc: xiaobo55x@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/acpi: Add expected ACPI SRAT AML file for RISC-V
Date: Fri,  9 Aug 2024 11:09:49 +0800
Message-Id: <a667480203b35508038176c8ce4722370294cc57.1723172696.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
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

As per the step 5 in the process documented in bios-tables-test.c,
generate the expected ACPI SRAT AML data file for RISC-V using the
rebuild-expected-aml.sh script and update the
bios-tables-test-allowed-diff.h.

This is a new file being added for the first time. Hence, iASL diff
output is not added.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tests/data/acpi/riscv64/virt/SRAT.numamem   | Bin 0 -> 108 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..2b6467364b7673c366c9abf948142eaf60c9311f 100644
GIT binary patch
literal 108
zcmWFzatz5~U|?XDb@F%i2v%^42yj*a0!E-1hz+7a7zWryU@U|<qXt~80m|Zli6H9*
E0AFAS0RR91

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a3e01d2eb7..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SRAT.numamem",
-- 
2.34.1



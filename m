Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B820CD4F35
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJM7v-0001o8-Du; Wed, 12 Nov 2025 20:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJM7T-0001a8-88; Wed, 12 Nov 2025 20:27:27 -0500
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJM7Q-00082a-2Q; Wed, 12 Nov 2025 20:27:26 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d6N0v5YcLz8Xs6y;
 Thu, 13 Nov 2025 09:27:11 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl1.zte.com.cn with SMTP id 5AD1R8JR083952;
 Thu, 13 Nov 2025 09:27:08 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 13 Nov 2025 09:27:09 +0800 (CST)
Date: Thu, 13 Nov 2025 09:27:09 +0800 (CST)
X-Zmail-TransId: 2afc691533ed0af-7d401
X-Mailer: Zmail v1.0
Message-ID: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IFJFU0VORCAwLzJdIGh3L3Jpc2N2L3ZpcnQ6IEFkZCBhY3BpIGdlZCBhbmQgcG93ZXJkb3duIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 5AD1R8JR083952
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 13 Nov 2025 09:27:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 691533EF.000/4d6N0v5YcLz8Xs6y
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Add riscv acpi powerdown support

Changes in v4:
- Added modifies of DSDT blob in another patch
- Link to v3: https://lore.kernel.org/qemu-riscv/20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn/

Changes in v3:
- Added missing param to virt_is_acpi_enabled
- Fixed failure of bios-tables-test
- Link to v2: https://lore.kernel.org/qemu-riscv/202506201130099861lTkD839Hh6oko8Jo2W2H@zte.com.cn/

Changes in v2:
- Unwrappered acpi_dsdt_add_ged function
- Modified base address of VIRT_ACPI_GED
- Added conditions for function calls
- Adjusted code formatting
- Link to v1: https://lore.kernel.org/qemu-riscv/202506191556260735QxWC8sxRwFURYEvlD24y@zte.com.cn/

Xuemei Liu (2):
  hw/riscv/virt: Add acpi ged and powerdown support
  tests/acpi: Add acpi ged and power button in DSDT for RISC-V

 hw/riscv/Kconfig                  |   1 +
 hw/riscv/virt-acpi-build.c        |  10 +++++++++
 hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h           |   4 ++++
 tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
 5 files changed, 50 insertions(+)

-- 
2.27.0


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7597CEDA697
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4qX-0000td-BC; Thu, 05 Mar 2026 04:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vy4q5-0000qw-AB; Thu, 05 Mar 2026 04:17:55 -0500
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vy4q2-00012k-Lq; Thu, 05 Mar 2026 04:17:49 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4fRP7s5CRzz51Sdb;
 Thu, 05 Mar 2026 17:17:29 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
 by mse-fl1.zte.com.cn with SMTP id 6259HQl4044148;
 Thu, 5 Mar 2026 17:17:26 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 5 Mar 2026 17:17:29 +0800 (CST)
X-Zmail-TransId: 2af969a94a2949e-61b72
X-Mailer: Zmail v1.0
Message-ID: <20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn>
Date: Thu, 5 Mar 2026 17:17:29 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <peterx@redhat.com>, <farosas@suse.de>, <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10gcmlzY3Y6IEFJQTogQWRkIGluLWtlcm5lbCBpcnFjaGlwcyBzYXZlIGFuZCByZXN0b3JlIGZ1bmN0aW9uIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6259HQl4044148
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 05 Mar 2026 17:17:29 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69A94A29.001/4fRP7s5CRzz51Sdb
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

This series adds support for in-kernel AIA irqchips save and restore
on RISC-V.

Changes in v2:
- Added the BITS_TO_U64S macro
- Added the nr_eix field and dynamically allocated the eie/eip arrays
- Replaced the CONFIG_32BIT macro with is_32bit boolean flag
- Link to v1: https://lore.kernel.org/qemu-devel/20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn/

Xuemei Liu (3):
  target/riscv/kvm: create kvm_riscv_aia_access_reg
  hw/intc/riscv_aplic: Add in-kernel aplic save and restore function
  hw/intc/imsic: Add in-kernel imsic save and restore function

 hw/intc/riscv_aplic.c         | 200 ++++++++++++++++++++++++++++------
 hw/intc/riscv_imsic.c         | 171 ++++++++++++++++++++++++++---
 include/hw/intc/riscv_aplic.h |   4 +
 include/hw/intc/riscv_imsic.h |   3 +
 include/qemu/bitops.h         |   9 +-
 migration/vmstate-types.c     |   1 -
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/kvm/kvm_riscv.h  |   1 +
 8 files changed, 345 insertions(+), 51 deletions(-)

-- 
2.27.0


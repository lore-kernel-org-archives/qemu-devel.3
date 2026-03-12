Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CECFFED2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wec-00044o-Sd; Wed, 11 Mar 2026 23:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0WeZ-00043p-4P; Wed, 11 Mar 2026 23:24:03 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0WeW-00034V-Sb; Wed, 11 Mar 2026 23:24:02 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fWXyP6Bk4z4yjjH;
 Thu, 12 Mar 2026 11:23:41 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
 by mse-fl1.zte.com.cn with SMTP id 62C3NZGX022054;
 Thu, 12 Mar 2026 11:23:35 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 12 Mar 2026 11:23:36 +0800 (CST)
X-Zmail-TransId: 2afb69b231b81f1-550f7
X-Mailer: Zmail v1.0
Message-ID: <20260312112336983jY95IEDTtzVrPbyk-taP3@zte.com.cn>
Date: Thu, 12 Mar 2026 11:23:36 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <peterx@redhat.com>, <farosas@suse.de>, <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDAvM10gcmlzY3Y6IEFJQTogQWRkIGluLWtlcm5lbCBpcnFjaGlwcyBzYXZlIGFuZCByZXN0b3JlIGZ1bmN0aW9uIHN1cHBvcnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 62C3NZGX022054
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Mar 2026 11:23:41 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B231BD.001/4fWXyP6Bk4z4yjjH
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Changes in v3:
- Removed unnecessary changes in bitops.h
- Link to v2: https://lore.kernel.org/qemu-devel/20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn/

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
 include/qemu/bitops.h         |   1 +
 migration/vmstate-types.c     |   1 -
 target/riscv/kvm/kvm-cpu.c    |   7 +-
 target/riscv/kvm/kvm_riscv.h  |   1 +
 8 files changed, 341 insertions(+), 47 deletions(-)

-- 
2.27.0


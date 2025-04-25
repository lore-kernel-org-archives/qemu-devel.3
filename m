Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702CDC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 14:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Jfy-0004LU-5Q; Fri, 25 Apr 2025 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8I1Q-0002SP-8Y; Fri, 25 Apr 2025 08:19:13 -0400
Received: from out28-148.mail.aliyun.com ([115.124.28.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangran@bosc.ac.cn>)
 id 1u8I1M-0003Yc-CB; Fri, 25 Apr 2025 08:19:11 -0400
Received: from localhost.localdomain(mailfrom:wangran@bosc.ac.cn
 fp:SMTPD_---.cWeGshU_1745583526 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 25 Apr 2025 20:18:53 +0800
From: Ran Wang <wangran@bosc.ac.cn>
To: alistair23@gmail.com
Cc: 3543977024@qq.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Ran Wang <wangran@bosc.ac.cn>
Subject: [PATCH v4 0/2] riscv: Add Kunminghu CPU and platform
Date: Fri, 25 Apr 2025 20:17:50 +0800
Message-Id: <20250425121750.311-1-wangran@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.148; envelope-from=wangran@bosc.ac.cn;
 helo=out28-148.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Apr 2025 10:04:56 -0400
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

This serial adds Xiangshan Kunminghu CPU and its FPGA prototype
platform, which include UART, CLINT, IMSIC, and APLIC
devices.

More details can be found at
https://github.com/OpenXiangShan/XiangShan

Patches based on alistair/riscv-to-apply.next

Huang Borong (2):
  target/riscv: Add BOSC's Xiangshan Kunminghu CPU
  hw/riscv: Initial support for BOSC's Xiangshan Kunminghu FPGA
    prototype

 MAINTAINERS                                 |   7 +
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/xiangshan-kunminghu.rst   |  39 ++++
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |   9 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/xiangshan_kmh.c                    | 220 ++++++++++++++++++++
 include/hw/riscv/xiangshan_kmh.h            |  78 +++++++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  64 ++++++
 10 files changed, 421 insertions(+)
 create mode 100644 docs/system/riscv/xiangshan-kunminghu.rst
 create mode 100644 hw/riscv/xiangshan_kmh.c
 create mode 100644 include/hw/riscv/xiangshan_kmh.h

-- 
2.34.1



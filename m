Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D3CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st54r-00046E-3P; Tue, 24 Sep 2024 08:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fE-0005zB-OX; Tue, 24 Sep 2024 04:12:52 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zhouquan@iscas.ac.cn>)
 id 1st0fC-0008Ec-18; Tue, 24 Sep 2024 04:12:52 -0400
Received: from zq-Legion-Y7000.. (unknown [180.111.100.113])
 by APP-03 (Coremail) with SMTP id rQCowACHjKxxdPJm492dAA--.477S2;
 Tue, 24 Sep 2024 16:12:35 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, dbarboza@ventanamicro.com, zhouquan@iscas.ac.cn
Subject: [PATCH 0/2] target/riscv/kvm: Update kvm exts to Linux v6.11
Date: Tue, 24 Sep 2024 16:12:33 +0800
Message-ID: <cover.1727164986.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjKxxdPJm492dAA--.477S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry7Gw48Zw18KFyfXF1kKrg_yoWkJFgEy3
 WxXry8J340va4UJa43AF15GrW5uFW2kwn3ZF1jqanrWrnIqr4Yqan7ta1rJanrWr17ur45
 CFyxJw1fua17XjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
 67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU55l8UUUUU
X-Originating-IP: [180.111.100.113]
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiBg0KBmbyQ6C3MQAAs2
Received-SPF: pass client-ip=159.226.251.81; envelope-from=zhouquan@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Sep 2024 08:54:42 -0400
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
Message-ID: <20240924081233.sYBk3d1rOIVJZTJ24GnvTrqOA6yOpAHqzNYTP5xSYo0@z>

From: Quan Zhou <zhouquan@iscas.ac.cn>

Update QEMU's KVM extension support to version 6.11.

Quan Zhou (2):
  linux-headers: Update to Linux v6.11
  target/riscv/kvm: Update kvm exts to Linux v6.11

 include/standard-headers/drm/drm_fourcc.h     |  18 ++
 include/standard-headers/linux/ethtool.h      | 210 ++++++++++++++++++
 .../linux/input-event-codes.h                 |   2 +
 linux-headers/asm-arm64/unistd.h              |  25 +--
 linux-headers/asm-generic/unistd.h            |   6 +-
 linux-headers/asm-loongarch/kvm.h             |   4 +
 linux-headers/asm-loongarch/unistd.h          |   4 +-
 linux-headers/asm-riscv/kvm.h                 |   7 +
 linux-headers/asm-riscv/unistd.h              |  41 +---
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/iommufd.h                 | 141 ++++++++++--
 linux-headers/linux/kvm.h                     |  23 +-
 linux-headers/linux/mman.h                    |   1 +
 linux-headers/linux/psp-sev.h                 |  28 +++
 target/riscv/kvm/kvm-cpu.c                    |   7 +
 17 files changed, 433 insertions(+), 87 deletions(-)


base-commit: 01dc65a3bc262ab1bec8fe89775e9bbfa627becb
-- 
2.34.1



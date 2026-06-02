Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBF3CD6E61
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIdL-000401-2j; Tue, 02 Jun 2026 02:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wUIdI-0003zM-SE; Tue, 02 Jun 2026 02:29:49 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1wUIdH-0003PL-B9; Tue, 02 Jun 2026 02:29:48 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gV1C94CSRz5B100;
 Tue, 02 Jun 2026 14:29:41 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl1.zte.com.cn with SMTP id 6526TSM5068608;
 Tue, 2 Jun 2026 14:29:28 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Tue, 2 Jun 2026 14:29:30 +0800 (CST)
X-Zmail-TransId: 2afa6a1e784a090-9682e
X-Mailer: Zmail v1.0
Message-ID: <20260602142930300qtONy7P2DkDM40BX_T3_A@zte.com.cn>
In-Reply-To: <20260602142709086IsQxEt0LYI9ygtpFnj-XN@zte.com.cn>
References: 20260602142709086IsQxEt0LYI9ygtpFnj-XN@zte.com.cn
Date: Tue, 2 Jun 2026 14:29:30 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>, <peterx@redhat.com>, <farosas@suse.de>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIFJFU0VORCAxLzNdIHRhcmdldC9yaXNjdi9rdm06IGNyZWF0ZSBrdm1fcmlzY3ZfYWlhX2FjY2Vzc19yZWc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6526TSM5068608
X-TLS: YES
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Jun 2026 14:29:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1E7855.000/4gV1C94CSRz5B100
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Create common function kvm_riscv_aia_access_reg to access APLIC
and IMSIC regs

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
 target/riscv/kvm/kvm_riscv.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 17ba38403a..879b4d610d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 }

 static bool cap_has_mp_state;
+static int aia_fd = -1;

 #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
                                          type | idx)
@@ -1817,13 +1818,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                     "auto");
 }

+void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write)
+{
+    kvm_device_access(aia_fd, group, addr, val, write, &error_abort);
+}
+
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num)
 {
     int ret, i;
-    int aia_fd = -1;
     uint64_t default_aia_mode;
     uint64_t socket_count = riscv_socket_count(machine);
     uint64_t max_hart_per_socket = 0;
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index b2bcd1041f..b0ef0bc2d0 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -23,6 +23,7 @@

 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
+void kvm_riscv_aia_access_reg(int group, uint64_t addr, void *val, bool write);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
                           uint64_t aplic_base, uint64_t imsic_base,
-- 
2.27.0


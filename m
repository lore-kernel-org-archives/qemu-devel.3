Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC84FED2C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0WgQ-0005HU-JF; Wed, 11 Mar 2026 23:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0WgN-0005HA-DI; Wed, 11 Mar 2026 23:25:55 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1w0WgL-0003hd-K2; Wed, 11 Mar 2026 23:25:54 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fWY0s03cLz5BNS0;
 Thu, 12 Mar 2026 11:25:49 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl1.zte.com.cn with SMTP id 62C3PgOI024527;
 Thu, 12 Mar 2026 11:25:42 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 12 Mar 2026 11:25:44 +0800 (CST)
X-Zmail-TransId: 2afc69b23238fb1-59eb3
X-Mailer: Zmail v1.0
Message-ID: <202603121125441042seaT4WiHz7KqQob-s97i@zte.com.cn>
In-Reply-To: <20260312112336983jY95IEDTtzVrPbyk-taP3@zte.com.cn>
References: 20260312112336983jY95IEDTtzVrPbyk-taP3@zte.com.cn
Date: Thu, 12 Mar 2026 11:25:44 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <peterx@redhat.com>, <farosas@suse.de>, <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIDEvM10gdGFyZ2V0L3Jpc2N2L2t2bTogY3JlYXRlIGt2bV9yaXNjdl9haWFfYWNjZXNzX3JlZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 62C3PgOI024527
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Mar 2026 11:25:49 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B2323D.000/4fWY0s03cLz5BNS0
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

Create common function kvm_riscv_aia_access_reg to access APLIC
and IMSIC regs

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 target/riscv/kvm/kvm-cpu.c   | 7 ++++++-
 target/riscv/kvm/kvm_riscv.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index befcbb0a9a..2c29d8d07c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 }

 static bool cap_has_mp_state;
+static int aia_fd = -1;

 #define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
                                          type | idx)
@@ -1842,13 +1843,17 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
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
index 953db94160..cec13d9f31 100644
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


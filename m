Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD99FC83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeMs-0004Go-Ri; Fri, 04 Jul 2025 07:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeM6-0002fv-1E
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:24 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeM1-0003JZ-DN
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:21 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b3508961d43so616662a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627596; x=1752232396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/vCSMayWpkoFy9ut76DThDk/F2uNDNmhi4+LEdhx9c=;
 b=S8Qq93RzlDHXwIorvUvXlpNGhVNneKcoj/lte1aY5kz1Hu/igFYx85DDIICENRZaCG
 Kaq+sutj4QLaPCM/JhuF4EjhRD9t+14kNzcNFqFKao2Z7txjA/WasFgpYy1vB4fVjsP2
 VLnYean+TMBBaOVrPvIoJiKskWIq/wkxHaJiCZE+LngPe4Hyh8rlFV5/Cuv3jScstrsR
 9TKrPiztV3+bcY0oj0npzOnW6/jJ6HnPray2if5YjW3IgRpueBne7VlnIIceUEKrlBLS
 YLun2I6nSQv85oStN28o14W8GWw2Cf2Lq1IFyFMQ10KY598OzKTMAmXYsAUG8DbXlPmR
 m5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627596; x=1752232396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/vCSMayWpkoFy9ut76DThDk/F2uNDNmhi4+LEdhx9c=;
 b=fa7x9xmS4k/1lG7q3E2J9RRw3jxCYYhIU0K+vOvpr2eSHpn7u1ukCxDVmTF+xDnzZv
 e4b4fxmdEaXq/8lUor5eA2xFauMTclef2TMlOM25NhvUQr/gl2I62Fak7bC4e5m+jGw2
 rb8eltgf37z0SboHSGJyuvbjP/Y8Lesk2prC8AsZ6Kxuy0tHCCcHHB/6pWEsxH+S9kov
 oNeb6rXhEI5+bx1j6/HRQSSEfkitG3c3Tcrw/+Sg5gIuus+vCzA2gTLUYKI4kDwJJV6h
 GDXZNWcpzrnCPSi9ZJlFVrmwV+rLZnG3VKGszOXsqUJyKRWpNpE+lbXzs41VYvnV+H3b
 ZXRw==
X-Gm-Message-State: AOJu0YzDu1wjcahA2nE5ptJ+HV4YSB3LSYgtvcvhWGVX5T/eh0c4xfrR
 O9xsB54pYImWUphmNsiraett2iTERQXb8xkN3Ffj/D3lBobiyfJ4CgfwM8jOwQ==
X-Gm-Gg: ASbGnctwj7WQHvlRWk3FadL6Q7/WDukHcUMgCGVMcf412Q81VZ1/VMVAxLY3MSokofe
 xtjIIohzPZDMsDe7QIjld2jlz83kB7EX37BZ026r20FMbLVwinT6GgRykqrh7bbPBFxV+7407Wa
 f0V00lheN7d6GlvHzJ8Aat9/8hkyhAuJMvoJ7wQ7Yjg5WlkkkDBL3DlaGWjnSKpe7wK7m1nSwek
 UJw49BW4JhFFOolQ/kYbMZex9wKHmrdtpjkPgRE9/0N1I2H+nuvnHOEaIqijSsea9TxXy7ticCC
 jYIEpfuQ0Pz8PUXpGlkzRxPGoZlUjsRPeG7AES6jAUPEMOvCtJrLoeFiNLq3u7XVbZFqlD9FUaZ
 Hhb94pDJ/+a6qvY9spK9iABPP8LQi/J+TFtyIIArcc2AI2l4hoUpp70/WJhnObjTfQW7ae2MxDu
 YL5g==
X-Google-Smtp-Source: AGHT+IHgK7606OSktMcXJpFV2/VAxRbMpvTAL/Tn8c965cMn3PW0NFj+y1xuWwsvoVcv0omwqwvbew==
X-Received: by 2002:a17:90b:2707:b0:312:e9bd:5d37 with SMTP id
 98e67ed59e1d1-31aac43d215mr3144670a91.6.1751627595697; 
 Fri, 04 Jul 2025 04:13:15 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Meng Zhuo <mengzhuo@iscas.ac.cn>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/40] target/riscv/kvm: add max_satp_mode from host cpu
Date: Fri,  4 Jul 2025 21:11:42 +1000
Message-ID: <20250704111207.591994-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Meng Zhuo <mengzhuo@iscas.ac.cn>

This patch adds max_satp_mode from host kvm cpu setting.

Tested on: Milkv Megrez (Eswin 7700x)

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
Message-ID: <20250606034250.181707-1-mengzhuo@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e1a04be20f..502d33f404 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -999,6 +999,19 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratchCPU *scratch)
     close(scratch->kvmfd);
 }
 
+static void kvm_riscv_init_max_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
+{
+    struct kvm_one_reg reg;
+    int ret;
+
+    reg.id = RISCV_CONFIG_REG(satp_mode);
+    reg.addr = (uint64_t)&cpu->cfg.max_satp_mode;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve satp mode from host, error %d", ret);
+    }
+}
+
 static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
     struct kvm_one_reg reg;
@@ -1302,6 +1315,7 @@ static void riscv_init_kvm_registers(Object *cpu_obj)
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
     kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
     kvm_riscv_init_cfg(cpu, &kvmcpu);
+    kvm_riscv_init_max_satp_mode(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
@@ -1985,7 +1999,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
         }
     }
 
-   return true;
+    return true;
 }
 
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
-- 
2.50.0



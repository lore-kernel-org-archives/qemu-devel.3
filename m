Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A3FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJka-0001O9-Nd; Wed, 13 Mar 2024 04:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rkJkZ-0001M2-5T
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:14:11 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rkJkX-0001lP-C6
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:14:10 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so3781953a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710317647; x=1710922447; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv8wKA/KPYbFLr3DTp7mYK7V8Z+RK2NI/4+apdD1MNA=;
 b=SmZkFok0aiM6HiuH34Vps+q459YvjXLO08vjjlJW3jlFzWL+fvKOo6Le0yTQdRYudj
 gWgzS7m+eNWGETs5118LUcY0GzvvSmMMXDgXoJo0jOCuuf+6uQWPQIxlZGcB5uq9fY6N
 j85BjsqFmrFeTbbCj9fHxGB8wKgkBvIM3rro/ZHKVDg5jfU0vBOyMtx+GhC9r0Mn8nd6
 7rY1rPZfKFzJT6jb8UMujZQeT/anJJVecO6vU6r3LMc9PYVx8uhYxks8lzzaAeH/vfqT
 JLm9+Xaw9CMS6GZ9Nf3oexTz75WZvsBJGGuBvbMRTZG2UdTpB0k31t9XBBtjQXB2SPEA
 9anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710317647; x=1710922447;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv8wKA/KPYbFLr3DTp7mYK7V8Z+RK2NI/4+apdD1MNA=;
 b=hR9Gk2r2uycL097eXlZPo3iEFx3V1rbB5UGliNkuKnh8rnp8P6nhn0Jd62ZdGBmEYX
 oA4my3VsMfIdevNeR1ySPptEn9D8PPTQ/LBo2Gb+0nnkQJmR4tBMwWEXedbqRl9KRfWH
 K3elrRsE50We+SAWH+TrzX4DKP0pzJXev4WSvKxe3nZnqMDGafK3PcWGixD89IWoWm5o
 +4b/QurTuuTpQnOUENFsjuum+8FUyYrvq900i6FoaSAZhxeTaev6uHr8WMBXa6Pc+k9f
 9EzMaeu7E/JVoOSdpbI5KoyJnE0m6tGMAZ108KBPEUdE646CgfNQiuRsMF3PCbaK1kKN
 tT2Q==
X-Gm-Message-State: AOJu0YxMmL6l5YHHsoeRQ9G3Ms+AClaKNZlXAkPhY80bS0K67EiuE6xt
 LUzrVQK9kA+JRUf0vM4JV0nIjW/pc9jxkeB35DdmXkrg5e3Lla0lr8xlfRQZkbAF/aWQIDRomS5
 DQvIBp7RIaBLsc/yVm+LeSCZaSZIkKtWYhOyGTeg4DbW86vxVdukWRulxZcQWqCad08LvLIdc9e
 X2Z1I4sizK0+MwxaY1uGmJRUYR7vqVQj5KKURo7aFIuA==
X-Google-Smtp-Source: AGHT+IF9dTZQ87uwf7lhAsJ5YgIK8iAnEyvliRhDcIaIeZ+oa0mzLZ7VRZ+cbLV1F2Mct8C366kgWQ==
X-Received: by 2002:a05:6a21:6da7:b0:1a3:2b94:dbaf with SMTP id
 wl39-20020a056a216da700b001a32b94dbafmr4122449pzb.1.1710317647176; 
 Wed, 13 Mar 2024 01:14:07 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 gw12-20020a17090b0a4c00b0029beb0fc60fsm820291pjb.28.2024.03.13.01.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 01:14:06 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/1] target/riscv/kvm: fix timebase-frequency when using KVM
 acceleration
Date: Wed, 13 Mar 2024 16:13:57 +0800
Message-Id: <20240313081359.20845-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The timebase-frequency of guest OS should be the same with host
machine. The timebase-frequency value in DTS should be got from
hypervisor when using KVM acceleration.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 hw/riscv/virt.c              | 11 +++++++++--
 target/riscv/kvm/kvm-cpu.c   |  9 +++++++++
 target/riscv/kvm/kvm_riscv.h | 13 +++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a094af97c32a..a7ed7fa13010 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -710,8 +710,15 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
     int socket_count = riscv_socket_count(ms);
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
-    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
-                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
+
+    if (kvm_enabled()) {
+        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
+                              kvm_riscv_get_timebase_frequency(first_cpu));
+    } else {
+        qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
+                              RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
+    }
+
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
     qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c7afdb1e81b7..bbb115eaa867 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -739,6 +739,15 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
+uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
+{
+    uint64_t reg;
+
+    KVM_RISCV_GET_TIMER(cs, frequency, reg);
+
+    return reg;
+}
+
 static int kvm_riscv_get_regs_vector(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 4bd98fddc776..130a4bde0480 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -29,4 +29,17 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 
+#ifdef CONFIG_KVM
+
+uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
+
+#else
+
+static inline uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
+{
+    g_assert_not_reached();
+}
+
+#endif
+
 #endif
-- 
2.17.1



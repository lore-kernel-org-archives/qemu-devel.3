Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E77C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 06:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkeNc-0004Lz-Ml; Thu, 14 Mar 2024 02:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rkeNI-0004CM-Iw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 02:15:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1rkeN4-0004ea-KL
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 02:15:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so6015075ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 23:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710396917; x=1711001717; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBwpb36XCEiMRtGWe2harh1f9ZI9m89kctOkSqIXtF8=;
 b=e3gw2uegwRMznevJsLvTVK9D7iwydIoYni4ZlQ9FvheNsY0fQ7GfP/8rArMnSQNuVM
 q6hYe6S6M+v0xBX5cy3DF2cDIpVxKA/4UPa81XwbB1CP37Rnx9Cvu13ZWk6f7035EVeC
 eTH+PgQdo2ujKhx4oxgelpHQcR7NJwlxAZD/gJ++FIGJ6xv1RIICseO73ou24ryvVu57
 n15P/gQK9tqvf9T3LVFJDLNICtLULTDKyct3syueRTH6jTyKrFiNO3cShfQzWmyyrCvq
 W7js9XGO/YijSpUVNfttI4MXCNlVE30jD1gueEvVjOydJDUBWH3TpR0b3aVJvcrVMsM8
 ZjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710396917; x=1711001717;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBwpb36XCEiMRtGWe2harh1f9ZI9m89kctOkSqIXtF8=;
 b=AnLD33qHQcGQE2XeFitxooBGvx7f/EoUfOarZo/noFIk/OGMB3Mtg/DjZRgV614Cv6
 UnzOMAtYuG5ulwhXluD2H+BtCuS+BX6JRm1v5uo0LM2tCqNQk/T3ln0BqVAID0D+b2XQ
 6qgW0zN2mMzm9NpE43sehcdeWBIIDahUbpQBulCnhFrs58yU01CLm7oO0Hx8+uhqjrL9
 ir9ZTO7gi1fjocsJarv27ou7rlZqXYyekCIrVzwHPPsoGOOuGTYwK/K3ejI3XqIawom8
 e8wNCsjjaL2MTKYyJfEFN8neGDz6sTJBQqmLtPAp3Mep9kKI3jU+G8wLQc4YuzcJjHBE
 Q7rg==
X-Gm-Message-State: AOJu0YysrYpfJaCpxKSDZgWM05jXM2IDpIbcee58FNzq75jOvF9qtFP+
 2k2I6TleP/cqmJQZNJRFwq6mejmDRmkiMVUdF5yZ4wHlyTNRev7hHsZeeIuB8igrihsdnfHbKDd
 69m3XkpJ5WxtWUo1Dkf0oKr8PVKvebvZ8KkOeWmw4NfcIgZ06nQ3a1CV6R9W1w/koMjpvJbl0NF
 Ms13y/WYglUAhyVIkQA1x8z6NMICKBRhq/2UWfRr7MIg==
X-Google-Smtp-Source: AGHT+IENcHAWLKU+/90SZ6S0OGF0WabiIdXGwZL3pKcKjDDdFz0NFHT7lO/tdltWjh/IJ2G7MCWzpA==
X-Received: by 2002:a17:902:f54e:b0:1dd:6a1b:2749 with SMTP id
 h14-20020a170902f54e00b001dd6a1b2749mr966806plf.39.1710396916580; 
 Wed, 13 Mar 2024 23:15:16 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a17090341d100b001dddb6c0971sm726351ple.17.2024.03.13.23.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 23:15:16 -0700 (PDT)
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
Subject: [PATCH v2 1/1] target/riscv/kvm: fix timebase-frequency when using
 KVM acceleration
Date: Thu, 14 Mar 2024 14:15:09 +0800
Message-Id: <20240314061510.9800-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

---
Changelog
v2:
- update the function definition
- restructure if-else statement
---
 hw/riscv/virt.c              | 2 ++
 target/riscv/kvm/kvm-cpu.c   | 9 +++++++++
 target/riscv/kvm/kvm_riscv.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a094af97c32a..533b17799581 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -711,6 +711,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
+                          kvm_enabled() ?
+                          kvm_riscv_get_timebase_frequency(first_cpu) :
                           RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
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
index 4bd98fddc776..58518988681d 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -28,5 +28,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
 int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
+uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
 
 #endif
-- 
2.17.1



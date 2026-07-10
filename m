Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C677C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Pz-000076-0J; Thu, 09 Jul 2026 22:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pv-0008Dq-5Z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pr-0008Q2-2O
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so448141b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652197; x=1784256997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XbLzOOARiMTKSVxQIiwwlhEW6nV99yaxBK43zbONeek=;
 b=q/iLvAkPuORWMqqzGeUVZY+3urPynBedD9CHwiBYv0VdkP/GTMskMbyC/ev2c3j30O
 4bJSy8Ns/JUM2CBstXnJAIZ29u0FNJmZL3qHBCPlYLveeyhi1zuGCMX2DMDS8RUW5ion
 xGcfYIwWHmDpmHaS97xNGoaLh02AvLrN15ueJmhZK22+WXxplabTGv32LvuQZ7EvbM9J
 FxuvL2wyf+zU6RWVnfC8xjrrsjS3Tinyyy1w3C2rFQrCnGpwr/k90nrBjxdmDKZpKK8u
 Sm1C9avlqOcXWDrsfJbhELgr2jCUZVWjChELJpUAmhQN6Jq/6MMjGKA7bPpNz3tiRPO3
 tZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652197; x=1784256997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XbLzOOARiMTKSVxQIiwwlhEW6nV99yaxBK43zbONeek=;
 b=hxRgWWObyl+MYBtSNzNhI4sG9EsG0Jd7WEnRox32QjoRUvXtrI/TofSFa5kW3zCjnR
 w4EHj+TtlLRSIpKV8CGVrwCgvZjfjeMgWdlLfKfqLgZRQCzgHIU2cPX9noU4SWEbwyH/
 tWi2dVjHG81gcezx3moY3BSklNiRAtMzHstfNddRUkMacpPs4icjL7I7rcNEtPkRKoQT
 HEOUMhw96ulTRtDCpdsteog3gAp1jr+TpA1Qod91GULtwouuaCwElWJ3UCjiga/OT1nU
 rb3mtB+BO0Q1OcyE6LqCJlmxTV1kUNDxiBuET3PmAauB3Hfdty+T3Bya9kI8zOS/g7oe
 K9HA==
X-Gm-Message-State: AOJu0YyiA5crQwBUIMEnVH5oAE1Kr31aFZr0Pqc7o4sDA6rXcrKhVasT
 6jyXP3ubyLkzq/u3eZaOIpe1hkqcLYBRMrYVvife/ekXAHNKJ6FgSwbjUbB6ZQ==
X-Gm-Gg: AfdE7cnuL2pOewIADxEGHKtib/+Xmxd2h0CSDGL6S5Pxs1vVIdfc/5rzOIrj/ihlTd2
 peAsYqeMGP+/aIkvRJEBF+Ski9UC+gM05mAi5pivEJdD0wLffx4FmnAh5UIJKLlf247MyS8kCdR
 s73/y5MxUqxEzLSjYNjzwPQIlFQ2hJ9ZHudoHsX3aQijjIXbwLok7D4sTS1skczbdEdOut7nocF
 BLb3bIY3qeikLLDHahTbfE8kZy63YQe91ZeHsrgfwg0el7j7Lw9ycfdTq3oDYLQpjRdEtWBZeID
 thGLfzlnmon1ejYqnGsCdmdkmbsQVCnO7476d4acY8It+1BiOKvo9RKpQGCG/jISdeLqSyEz3fI
 24aeYCpbIpzi4/pO90Cwv8Gs8KxjOt+UpS1ey0Vr9WW0Bgv7nI/IHi1odXNajJcPY2urEbB2UN+
 RyZDRdT2Z+fjwsltwNbb1VRso/awKZmWg=
X-Received: by 2002:a05:6a00:94a3:b0:848:4c0c:9482 with SMTP id
 d2e1a72fcca58-8484c0c9598mr6617194b3a.35.1783652196965; 
 Thu, 09 Jul 2026 19:56:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/40] target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
Date: Fri, 10 Jul 2026 12:55:03 +1000
Message-ID: <20260710025525.1704417-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

This function is related to Smrnmi and non-masked interrupts, firing up
interrupts via env->rnmip from riscv_cpu_local_irq_pending().

This is all TCG only code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-13-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 8 --------
 target/riscv/tcg/tcg-cpu.c | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbce58ee58..508e8dc03e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1180,11 +1180,6 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         g_assert_not_reached();
     }
 }
-
-static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
-{
-    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
-}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1203,9 +1198,6 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
-    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
-                            "riscv.cpu.rnmi", RNMI_MAX);
-
     if (mcc->def->num_triggers) {
         env->num_triggers = mcc->def->num_triggers;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fef66557c2..4af5cd9c73 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
         }
     }
 }
+
+static inline void riscv_cpu_set_nmi(void *opaque, int irq, int level)
+{
+    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
+}
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
@@ -1674,6 +1679,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.54.0



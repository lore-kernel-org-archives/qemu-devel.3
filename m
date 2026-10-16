Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AFBCCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbF-0000Le-BY; Fri, 16 Oct 2026 09:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfAv-0005s5-Hw; Fri, 16 Oct 2026 06:28:35 -0400
Received: from out203-205-221-209.mail.qq.com ([203.205.221.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfAt-0003rz-3k; Fri, 16 Oct 2026 06:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146507; bh=YwaWaU5X+d+kArCjwYR2hKxzlLwtZfg9MjarNZm95Ro=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VfTZCF3chF+Bw1eDayoC/K5bb/xryaMAgsgNQsCTYKZ8Eou3OyAFcSGM/02CmgwsJ
 rwUFn39VIzKMaorK8Xb+BbvQqiktZ6NHDxxwb5Brkg+t3dX6B1HuXf3D9p/eB+FZTT
 RLtgTBn6Er/8B9pft2zFegKE8m47jxoPzxO762Zo=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 71821C7E; Fri, 16 Oct 2026 18:28:24 +0800
X-QQ-mid: xmsmtpt1792146504tes6a0d92
Message-ID: <tencent_92ADA4D4FC4CE571D14A761AF4C425E2DA06@qq.com>
X-QQ-XMAILINFO: N9nestr1/QrEmMCiF24lzLdd55/6jfhnM4xF7IJWFqYmETFC5BP4pzl3TDRKP/
 /YPYUjHGgjGo+VZ7v2TaVsNCxm+e+4d/h8mZa9I8H7HL7wi+xO9i2Qpn+PRG/U0IIjGKdRKJkESa
 I8IQ3lqtup8v3tV53four61kQrPzfGrnJsO4lp5t8Gk0iyctfy0DdlR9NGoJ7Krg6ps3Azc9f5UE
 6hynVR89PPL9Uj1lsHftnyQbpZwL0hl+U1aOICUTa5kgT4Wa5oty5zViHVaaY+hVuEo4OzpWCfkp
 28jG4gVsMAd8doH2a800yHigw3eoMYJqTXkRnrwnVZLIpl+spKA1Y9Us++U/H/aLlhBriSQjk6ep
 OJFeKyUvrmgCyhoJuB5QuVngs9R3o3beZf81SPIXTaL+DqpytWT4yHjN1MoPqXZdYMfMDVqwDPVz
 +8Xc/fpFlF18eF8CP9+42/qyqJcdcUp813HFzjjY6Rf2OzTmfcEppEEmaVaclXhd5mvTj+sEjzQm
 loiBdh2cbs+e/mfOkgkSQ3mdPHgOy5juXNs4W9z5kbUy5GLc/zZ+wdx18TxBs8XelI+Jofv5KFYS
 lHU48sbpK0kYj8WP2V4PJjXcvSJOdqDt6q24YewTouxq86/vACW3samqFLCGCPeW7NcX4PLTsc4y
 bkxgOJ2EonfqmR3wIn3PuMl1zNtJ+mSgNozRfhmv4oyKoTkFcLj+RYr18krlKX7nZcD1TunaeM1h
 GaK0n3gDjXpfnowY7w5+v7s6R9MOV8f4PVfBknNLR+FtMXsDJJAGBeC7bw8VA+fsFTcnoTcZxyW8
 5wxyd1CzDQqdyUiG40eHVwSrIKbJTBkNRyO7i/d3DsrO+kyHe+1BxG5KgT6a8S+THGJeqLnMWehD
 Zw4f0opjdCMKvtWOj3H99aW8MSoBrB63sbeXKGMLaLVy4AQkgP5X0LHM43vCLoHDM87U3ppdMm5S
 f/proXZ9z2E2F6tO2PgbBR9GcKhI38jOHXVL9ePuA9SIDiuoKo4egMvUTPLLWcbiVRv9B2yrA+xD
 Z1c7phYVLw9wpYIqZ/RNwYNQuR7Ue58puzlvqxbOWnrbVcctpPdEbLu86w2SgyXg7g+5PC5olGTz
 VAorbQ
X-QQ-XMRINFO: NmyfvsrRkCkJAbzJWTXK6qOFf6uNn0Tzaw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 32/37] hw/arm/mpam: Add error and overflow interrupt outputs
Date: Fri, 16 Oct 2026 18:10:52 +0800
X-OQ-MSGID: <20261016101058.1900808-18-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.209; envelope-from=2118537295@qq.com;
 helo=out203-205-221-209.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:46 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add the two sysbus irq outputs ([0] error, [1] overflow) with the
IHI 0099 level semantics: the error line is active while
MPAMF_ESR.ERR_CODE is non-zero and MPAMF_ECR.INTEN is set (8.2),
deasserted by writing ERRCODE zero; the overflow line is signalled
while any MBWU monitor has latched OFLOW_STATUS with OFLOW_INTR
set (8.3), deasserted by the write-one-to-clear of every overflowed
monitor.  Counter overflow latches the status exactly once, and
device reset deasserts both lines.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index c4a7567..0389dad 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -361,6 +361,10 @@ typedef struct MPAMMSCState {
     uint32_t ecr;
     uint64_t esr;
 
+    /* Wired interrupt outputs: [0] error, [1] overflow (level) */
+    qemu_irq err_irq;
+    qemu_irq oflow_irq;
+
     /*
      * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
      * means "no wired interrupt"; the ACPI MPAM table reports them as-is.
@@ -431,6 +435,43 @@ static void mpam_msc_sync_esr_ecr(MPAMMSCState *s)
     }
 }
 
+/*
+ * IHI 0099 8.2: the MPAM error interrupt is level-sensitive; it is active
+ * while MPAMF_ESR.ERR_CODE is non-zero and MPAMF_ECR.INTEN is set, and is
+ * deactivated by software writing ERRCODE to zero.
+ */
+static void mpam_msc_update_err_irq(MPAMMSCState *s)
+{
+    bool int_en = FIELD_EX32(s->ecr, MPAMF_ECR, INTEN);
+    bool active = FIELD_EX64(s->esr, MPAMF_ESR, ERR_CODE) != 0;
+
+    qemu_set_irq(s->err_irq, int_en && active);
+}
+
+/*
+ * IHI 0099 8.3: the overflow interrupt is signalled while any monitor has
+ * latched OFLOW_STATUS with OFLOW_INTR set; clearing OFLOW_STATUS of all
+ * overflowed monitors (W1C) deasserts it.
+ */
+static void mpam_msc_update_oflow_irq(MPAMMSCState *s)
+{
+    bool active = false;
+    int i, m;
+
+    for (i = 0; i < s->num_ris && !active; i++) {
+        for (m = 0; m < s->num_mbwu_mon; m++) {
+            MpamMbwuMon *mon = &s->mpamf[i].mbwu_mons[m];
+
+            if (mon->oflow &&
+                FIELD_EX32(mon->ctl, MSMON_CFG_MBWU_CTL, OFLOW_INTR)) {
+                active = true;
+                break;
+            }
+        }
+    }
+    qemu_set_irq(s->oflow_irq, active);
+}
+
 static Mpamf *mpam_mon_ris(MPAMMSCState *s)
 {
     unsigned ris = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, RIS);
@@ -506,7 +547,10 @@ static uint64_t mpam_mbwu_value(MPAMMSCState *s, Mpamf *mf, MpamMbwuMon *m)
         v += muldiv64(delta, rate_mbs, 1000);
         /* 48-bit counter wraps (MSMON_MBWU_L is 48 bits of value). */
         if (v > (1ULL << 48)) {
-            m->oflow = true;
+            if (!m->oflow) {
+                m->oflow = true;
+                mpam_msc_update_oflow_irq(s);
+            }
             v &= (1ULL << 48) - 1;
         }
     }
@@ -966,6 +1010,7 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
             m->oflow = false;               /* write-one-to-clear */
         }
+        mpam_msc_update_oflow_irq(s);
         return;
     }
     case A_MSMON_MBWU:
@@ -1006,6 +1051,7 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         }
         s->ecr = value & MPAMF_ECR_WRITE_MASK;
         mpam_msc_sync_esr_ecr(s);
+        mpam_msc_update_err_irq(s);
         return;
     case A_MPAMF_ESR:
         /*
@@ -1014,10 +1060,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
          */
         s->esr = deposit64(s->esr, 0, 32, value);
         mpam_msc_sync_esr_ecr(s);
+        mpam_msc_update_err_irq(s);
         return;
     case A_MPAMF_ESR + 0x4:
         s->esr = deposit64(s->esr, 32, 32, value);
         mpam_msc_sync_esr_ecr(s);
+        mpam_msc_update_err_irq(s);
         return;
     default:
         qemu_log_mask(LOG_UNIMP,
@@ -1096,6 +1144,9 @@ static void mpam_msc_reset(DeviceState *dev)
     MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
 
     mpam_msc_state_init(s);
+    /* Deassert the wired interrupt lines */
+    mpam_msc_update_err_irq(s);
+    mpam_msc_update_oflow_irq(s);
 }
 
 static void mpam_msc_realize(DeviceState *dev, Error **errp)
@@ -1128,6 +1179,9 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
                           MPAM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+    /* Wired interrupt outputs: index 0 = error, index 1 = overflow */
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->err_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->oflow_irq);
 }
 
 static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36A9FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHku2-0003zq-AC; Tue, 28 Apr 2026 12:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksO-00036F-VI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHksK-0003iU-9O
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:01:32 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c76b9efc299so4831078a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777392085; x=1777996885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgXtKy+iVz/buq8xrh+OuZeU7ZMd1UBY6bFU951VKdw=;
 b=a6gfP3knLsX4FtRJhfd+HzAp5azDYWJ38TrYQ8VeAgo0IPzUGamnfmfuEo8C5gWEdt
 K46RBFZHwzVHpNlbtlrbuB3vxAj3Gm1KSw4SsY7uoiJHsOyVDsFLxPTlXFuf5829pDWh
 xH/I+hgnHRtCKY6/OBfGvHxN/nw4kvzk0H08qAQAq5onjJa1tKETUCosZij/vPdirDv2
 MB34H2MuhbfPsxPaw/lATaKbHuqrvL+lXsk/A2ZcTmG8LG8FWH/MmmCE8Hbyx+IugzRl
 D5EmHkOp7Q2DL18NsdQ9tG6MK5lPcWZxVfg1vYM5OJKxekl7MTvpL1sXbN62LNOru11b
 DCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777392085; x=1777996885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CgXtKy+iVz/buq8xrh+OuZeU7ZMd1UBY6bFU951VKdw=;
 b=lFDUIpKgUwXYrxJBPA9Ab9lqlUsfCvdA4zq83DcPunQVGVHm46wVkFqRlDDBgSl4X4
 nP48KXTLG+jG0y6y97DZhOOL17hNPeY3JRT94puTIh4WLJq1taFcqzUFsY04Zm8f63yd
 qccDDDlPwm03rJVvqVaVw/xsxxEGTJMMi1JlEAseZNq0TsE7UfrueRhWbEc9pQ2ixHyB
 /6uBGxST4DkoFRxqyEBKMsnFHazbxWh8dXEEIXPpiZfg/EtUeOiezOJyzCQxiAtEKKjE
 XXFSPurT9aOJGjDOWRd4HUTxgF6ndqIcu6pmbWsh4beTlN6TcxATx7r9+s3Pedpvw4Ch
 PcSA==
X-Gm-Message-State: AOJu0YxCay4MHKh8Z7fEHfptoej0i16Sg3klxDyO4/ko3NeisJmOyISp
 BUMpGJgObODYJtPU6lDXd29SQYqq1fa11xxZekY8KTKWFtpi7mpT/ZYvw1MuTJt1En2CvWV7zkA
 8gdnU+90w9p/QvtDHNLIts2E3VPsD0mgm3KhTS2eDJpuadXZmARcFunDV+KVHYam3rPSDsPqIAV
 bwQkJZQQG3MvyIgBOYTyzYF+atLHHcfUTG/5qC402j
X-Gm-Gg: AeBDietRMLIF1zQRdaunuPa+L0mYVMVCeP0a2mF2CWx0cE/JIZcL3Mf0s44iwF9GY64
 inkBWtcznjsWQ7ArXUrtwIXE0KzDM76LkQQWB6fjlz5ZaB2cqe4TV3CSIkwjgu6m3V+fC0e9MZg
 aJ4aFNWCYJpTqBZMFUxIOQf0WmByJd3GOonFeSlpLaDoWo3+XTcVnUn/KANIZrVKYnkoBXr3sEe
 9nus8qB7vjCB6dgFbokE8a4EnoIkZXi6UwHG+SWsH9JqO1dRPLQlXVTo3ubotGohe6ixGv9S+DX
 AEMMw3HK9MJ4fRoaZRiPx3eeCNPT//BUFMS8XZEazVgQVJ21HnxvBVXMrZVAiBnPgaamY/GmwQJ
 TWAQiH3Vha7WBLeHKO9Ms4z9F8X0uxtfDR8iWvzxMus4woB30tkH2Q1OR2TVFt8pRpZJ2xDA1Ul
 qNoIqi9NJozdrO27cy0UUqf4f7HjeVE/M/qmAlrt5uq6Fvr/gXN4QSMUQ=
X-Received: by 2002:a05:6a21:3294:b0:3a2:d976:2210 with SMTP id
 adf61e73a8af0-3a39c04e43dmr4507133637.8.1777392084925; 
 Tue, 28 Apr 2026 09:01:24 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834daf30fbfsm3002331b3a.33.2026.04.28.09.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:01:24 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 "Fea . Wang" <fea.wang@sifive.com>
Subject: [PATCH 2/4] hw/intc: riscv_aplic: Add reset API to APLIC
Date: Wed, 29 Apr 2026 00:01:01 +0800
Message-ID: <20260428160103.3551125-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428160103.3551125-1-jim.shu@sifive.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Clearing APLIC registers and qemu_irq in the reset function

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 hw/intc/riscv_aplic.c | 45 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 791e0b01b96..a04e0e1a898 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -892,6 +892,44 @@ static const MemoryRegionOps riscv_aplic_ops = {
     }
 };
 
+static void riscv_aplic_reset_enter(Object *obj, ResetType type)
+{
+    RISCVAPLICState *aplic = RISCV_APLIC(obj);
+    int i;
+
+    aplic->domaincfg = 0;
+    memset(aplic->sourcecfg, 0, sizeof(uint32_t) * aplic->num_irqs);
+    memset(aplic->target, 0, sizeof(uint32_t) * aplic->num_irqs);
+    if (!aplic->msimode) {
+        for (i = 0; i < aplic->num_irqs; i++) {
+            aplic->target[i] = 1;
+        }
+    }
+
+    for (i = 0; i < aplic->num_irqs ; i++) {
+        riscv_aplic_set_enabled_raw(aplic, i, false);
+    }
+
+    /* Need to unlock [ms]msicfgaddrh.L */
+    aplic->mmsicfgaddr = 0;
+    aplic->mmsicfgaddrH = 0;
+    aplic->smsicfgaddr = 0;
+    aplic->smsicfgaddrH = 0;
+
+    if (!aplic->msimode) {
+        /* Reset IDC registers only in non-MSI mode */
+        for (i = 0; i < aplic->num_harts; i++) {
+            aplic->idelivery[i] = 0;
+            aplic->iforce[i] = 0;
+            aplic->ithreshold[i] = 0;
+        }
+
+        for (i = 0; i < aplic->num_harts; i++) {
+            qemu_irq_lower(aplic->external_irqs[i]);
+        }
+    }
+}
+
 static void riscv_aplic_realize(DeviceState *dev, Error **errp)
 {
     uint32_t i;
@@ -925,11 +963,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
         aplic->target = g_new0(uint32_t, aplic->num_irqs);
-        if (!aplic->msimode) {
-            for (i = 0; i < aplic->num_irqs; i++) {
-                aplic->target[i] = 1;
-            }
-        }
         aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
         aplic->iforce = g_new0(uint32_t, aplic->num_harts);
         aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
@@ -1014,9 +1047,11 @@ static const VMStateDescription vmstate_riscv_aplic = {
 static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, riscv_aplic_properties);
     dc->realize = riscv_aplic_realize;
+    rc->phases.enter = riscv_aplic_reset_enter;
     dc->vmsd = &vmstate_riscv_aplic;
 }
 
-- 
2.43.0



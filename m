Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CF8CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjx-00015w-HT; Thu, 23 Oct 2025 00:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjv-00014N-IR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjt-0007Nl-Cx
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso449722b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192947; x=1761797747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Mao6PD8wwENV7peOfswOR2w88gBwEoO4ue8fP0vqGc=;
 b=SujPqDR4OhCvdIwPF5ajfuKQjq2cNewe/QkZkWdEYol+UFcH+DYkvDpYQSCzVFz1lF
 WTmnXvoQ2KaAsRxszhfu1VApq/tLTmovp/3VevvtN8isA1Nttgjh+Sr1q32JLkuhpKsG
 ER4owa329qMPowqGP5Wm99K37dv84EPWL3Sx1MJwhTBVrjDAkgabvs09DzK3kqQ/C4PG
 UIAV14oxNsqFUd/3Nox8Ht3i9CUFclXKnUT2Sq5ex8H0gVAEFXSgcpT25tP/2SVoRKkb
 PDFeUc9fuKV68Mx1Lz4YxwC8I930fC8q0j0JFyQp0KPs7+Ceh0Sqhi6dd1URtQbYaYhb
 px3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192947; x=1761797747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Mao6PD8wwENV7peOfswOR2w88gBwEoO4ue8fP0vqGc=;
 b=FKmFv6kL6Km4OaFM5/vISzcwz/R1ZwbqvBI0JJDz9cGwpfT18O3bVHAtIAQj+Zgr26
 8k85YjLECCQXln5p/wtHX0DYLxS0iKCgIcD5XgDBiE3hPimMkqXz1loCHNZTRtFt8ItW
 aV5C7Hbn2jPZFXYPcd1xm0d/iIjlH9khknRQfumS7jWrSosxk3XUENx1ULNAsoIfw6GM
 Z7XySBATkTfvVY2MsGKAZHn4NMnuPwhjKZyltC5pJjVclK2Ng4eDHu8foNUsbiKV8fLh
 1Pv98rDTY1KPIgEWnTG777nVXXa6kdZhQ6OmqbMyIMICrugrN7Slew2cfpeO3ag02ZVv
 Dy5A==
X-Gm-Message-State: AOJu0YzpsET+C0TeoKS0GWOPzoPJqjgd9e8/eNx8MQwJLWk/6tJgCKUf
 nY/O4AwdbKf9Widt8EEpKdOWwnnqo4ztIlKdpE4EUHWFz7DehgRoEIVBpkrmlw==
X-Gm-Gg: ASbGncuCyfg66gxsYZfNECCYT8KSI1PkFxtwKL0yLEfki/b70Z7xJvAnd5QEG3HONni
 NnGJ+KglwbdSV9CYSZ3s8j9dWu0dB81/OAKkr9PsCBDrF1K9tsDJVhGHpLLrGZ92wM8Z9zubwp+
 MYqIDRkoB8hAfwwjmztDh65ncxFLwQn5dU00ZWiWhCaw8MuU2guwCfK3FfAGhvXuf+1FfWFX0lP
 f549KmNm/nkeNLKUeKijSsIhxeb6SYU2B0RvTrbE9eULRAzk5c2vQbP3oIDMSQWx327cd2WDVSi
 RZApR995xcgYjI8wvejII131c0oL/D1xVgYsJzr2MJDnM/+ppgNEiydvKkX9o+6iDUK39172JOX
 sx/rf2mAIXAQAZQbzbQo0Vvgj6cpFCds/cXU/FHHfUqTsuwaVUnh80H8W+76cM+6ybbYkreYIhb
 uxlcaaDEiljrsUIyzjwDdicKgz+cBa4mAKyDVcfcjJSFdHJSQMGpxsZC9KUt6Dj9Fshep4ECDTo
 U2M5VZpUA==
X-Google-Smtp-Source: AGHT+IHzrdbgICr9bYVV0tVRXfzZGNnOBmoOuY0hEvHgQYs6WmrgWjMypMEuK6d+y7eBVrjhkyGvQQ==
X-Received: by 2002:a05:6a20:158a:b0:2e5:655c:7f93 with SMTP id
 adf61e73a8af0-334a8616c19mr32310941637.33.1761192947438; 
 Wed, 22 Oct 2025 21:15:47 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jialong Yang <z_bajeer@yeah.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 18/37] aplic: fix mask for smsiaddrcfgh
Date: Thu, 23 Oct 2025 14:14:16 +1000
Message-ID: <20251023041435.1775208-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Jialong Yang <z_bajeer@yeah.net>

 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
   smsiaddrcfgh)
smsiaddrcfgh:
        bits 22:20 LHXS(WARL)
        bits 11:0  High Base PPN(WARL)

Signed-off-by: Jialong Yang <z_bajeer@yeah.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <44f3e0d1.161.199d0c338b0.Coremail.z_bajeer@yeah.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 hw/intc/riscv_aplic.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..6dccca73af 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -96,7 +96,7 @@
     (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
      APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
 
-#define APLIC_xMSICFGADDRH_VALID_MASK   \
+#define APLIC_MMSICFGADDRH_VALID_MASK   \
     (APLIC_xMSICFGADDRH_L | \
      (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
      (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
@@ -104,6 +104,10 @@
      (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
      APLIC_xMSICFGADDRH_BAPPN_MASK)
 
+#define APLIC_SMSICFGADDRH_VALID_MASK   \
+    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
+     APLIC_xMSICFGADDRH_BAPPN_MASK)
+
 #define APLIC_SETIP_BASE               0x1c00
 #define APLIC_SETIPNUM                 0x1cdc
 
@@ -184,7 +188,7 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
         addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
         aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
         aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
-                                 APLIC_xMSICFGADDRH_VALID_MASK;
+                                 APLIC_MMSICFGADDRH_VALID_MASK;
     }
 #endif
 }
@@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
         msicfgaddr = aplic->kvm_msicfgaddr;
         msicfgaddrH = ((uint64_t)aplic->kvm_msicfgaddrH << 32);
     } else {
-        if (aplic->mmode) {
-            msicfgaddr = aplic_m->mmsicfgaddr;
-            msicfgaddrH = aplic_m->mmsicfgaddrH;
-        } else {
-            msicfgaddr = aplic_m->smsicfgaddr;
-            msicfgaddrH = aplic_m->smsicfgaddrH;
-        }
+        msicfgaddr = aplic_m->mmsicfgaddr;
+        msicfgaddrH = aplic_m->mmsicfgaddrH;
     }
 
     lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
@@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     hhxw = (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
             APLIC_xMSICFGADDRH_HHXW_MASK;
 
+    if (!aplic->kvm_splitmode && !aplic->mmode) {
+        msicfgaddrH = aplic_m->smsicfgaddrH;
+        msicfgaddr = aplic_m->smsicfgaddr;
+
+        lhxs = (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
+            APLIC_xMSICFGADDRH_LHXS_MASK;
+    }
+
     group_idx = hart_idx >> lhxw;
 
     addr = msicfgaddr;
@@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_MMSICFGADDRH)) {
         if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->mmsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->mmsicfgaddrH = value & APLIC_MMSICFGADDRH_VALID_MASK;
         }
     } else if (aplic->mmode && aplic->msimode &&
                (addr == APLIC_SMSICFGADDR)) {
@@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
                (addr == APLIC_SMSICFGADDRH)) {
         if (aplic->num_children &&
             !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
-            aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
+            aplic->smsicfgaddrH = value & APLIC_SMSICFGADDRH_VALID_MASK;
         }
     } else if ((APLIC_SETIP_BASE <= addr) &&
             (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
-- 
2.51.0



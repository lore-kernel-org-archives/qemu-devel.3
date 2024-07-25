Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD842C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jh-0003EJ-8g; Thu, 25 Jul 2024 19:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jd-0002Wi-2j; Thu, 25 Jul 2024 19:56:09 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jb-00012u-50; Thu, 25 Jul 2024 19:56:08 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2caff99b1c9so283569a91.3; 
 Thu, 25 Jul 2024 16:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951765; x=1722556565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+lS4BcdTD9KL7iugiwevIUzaEHouwFCAeZSV+PvIxY=;
 b=d+ng4ea3jHR6pZ90hEuw5hBBlvQpLDU4fvjCX0w/PDx9F+i4PwH7Ua2AD9RLwuET0I
 xPv+KVdNsdVivAU9yJqGR+kRvLsgHnnoC1+Mnst4DCm/c5U/h7RRfRrn5FP0eC3FvGKG
 GDhzfIArqBtgvw5ja/x0+eFHKJ9Ftnw7sVTEAReljWOz0OPovc2ltyplpB8PzLa4dwXN
 4cEIEOllHlJNdprDURrElr15Bd9EJErPvqqQCJsmQRK2ChXTcHeQptS3f4ac1IQPBhx0
 8SaPomrnJhalOqRHVxF/l+HaqD8GLgO40QNddg/rRxLdqruTrqAOT+sUfoE+rnf4pr02
 pDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951765; x=1722556565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+lS4BcdTD9KL7iugiwevIUzaEHouwFCAeZSV+PvIxY=;
 b=GZt+ueG3uo6jhOSocEO/PL/rPVpcdbzxXjRKDVZ9PLg8X76puIae4G5n82w0w+9zA2
 1rQFD2LfZxycW+GGGSPhlic3IatbGW/hEdUV69wXO4ipHZzUqPaKg1UlnI6a1scxhUAO
 9DnORC50x9KDK6+ZhDF1nQqGFT4S5xzzluCM8oiiUrH2j9wJd4p5y6t6OjTYSkOqhlZL
 L+xH7d4Lglw3ld1uiHfNOzp4VwtmonB0VJWO9HNy1M9/TViP9Z9KMUuzq6Jdyie0WMam
 8f5f2NI0nYwj1At/KBxaawJTC2B9jY/oY3dV6rF5OK82lxRd2c9IDySt2lnxYXXOH7F3
 Fffg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3bIPCv2EKnK/8kgGebhqEpWwFf2Z8cYOgiwPI97gU262zV7pMP02fR9yi3evkzeW7fqPz/+pDinPyCznJv96q8r6p
X-Gm-Message-State: AOJu0YwgWKHqHuUeqFeoJSbcM1ijTaZHdv83KZni3m5J63O5IHqB9Ois
 i6wQCJozu8KrNqpTI/bgGAVAnUhPblWL5e3DRJT2zY2oJlm4h0+QrDwvMw==
X-Google-Smtp-Source: AGHT+IHDfeIE6hgXaul2Y1k74aBlAW34kcYGTB0H1D2+4fV5lbh+W/p4hGCwcsTXlAyUnDW0WFKUzw==
X-Received: by 2002:a17:90b:3790:b0:2c9:649c:5e08 with SMTP id
 98e67ed59e1d1-2cf2e9d730dmr3633367a91.15.1721951765020; 
 Thu, 25 Jul 2024 16:56:05 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/96] ppc/pnv: Add allow for big-core differences in DT
 generation
Date: Fri, 26 Jul 2024 09:53:01 +1000
Message-ID: <20240725235410.451624-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

device-tree building needs to account for big-core mode, because it is
driven by qemu cores (small cores). Every second core should be skipped,
and every core should describe threads for both small-cores that make
up the big core.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 07a29411a6..a1c2cbbc3f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -141,9 +141,9 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
     PnvChipClass *pnv_cc = PNV_CHIP_GET_CLASS(chip);
-    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
+    uint32_t *servers_prop;
     int i;
-    uint32_t pir;
+    uint32_t pir, tir;
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = PNV_TIMEBASE_FREQ;
@@ -154,7 +154,10 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     char *nodename;
     int cpus_offset = get_cpus_node(fdt);
 
-    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, NULL);
+    pnv_cc->get_pir_tir(chip, pc->hwid, 0, &pir, &tir);
+
+    /* Only one DT node per (big) core */
+    g_assert(tir == 0);
 
     nodename = g_strdup_printf("%s@%x", dc->fw_name, pir);
     offset = fdt_add_subnode(fdt, cpus_offset, nodename);
@@ -235,12 +238,28 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     }
 
     /* Build interrupt servers properties */
-    for (i = 0; i < smt_threads; i++) {
-        pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
-        servers_prop[i] = cpu_to_be32(pir);
+    if (pc->big_core) {
+        servers_prop = g_new(uint32_t, smt_threads * 2);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i * 2] = cpu_to_be32(pir);
+
+            pnv_cc->get_pir_tir(chip, pc->hwid + 1, i, &pir, NULL);
+            servers_prop[i * 2 + 1] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads
+                                        * 2)));
+    } else {
+        servers_prop = g_new(uint32_t, smt_threads);
+        for (i = 0; i < smt_threads; i++) {
+            pnv_cc->get_pir_tir(chip, pc->hwid, i, &pir, NULL);
+            servers_prop[i] = cpu_to_be32(pir);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                          servers_prop, sizeof(*servers_prop) * smt_threads)));
     }
-    _FDT((fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
-                       servers_prop, sizeof(*servers_prop) * smt_threads)));
+    g_free(servers_prop);
 
     return offset;
 }
@@ -389,6 +408,10 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_300, sizeof(pa_features_300))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
@@ -450,6 +473,10 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
                            pa_features_31, sizeof(pa_features_31))));
+
+        if (pnv_core->big_core) {
+            i++; /* Big-core groups two QEMU cores */
+        }
     }
 
     if (chip->ram_size) {
-- 
2.45.2



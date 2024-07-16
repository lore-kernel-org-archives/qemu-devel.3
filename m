Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49010C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2P-0002bw-KI; Tue, 16 Jul 2024 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1C-0006PN-Qb; Tue, 16 Jul 2024 12:27:13 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1A-0006aP-CE; Tue, 16 Jul 2024 12:27:10 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25e0c0df558so2369974fac.0; 
 Tue, 16 Jul 2024 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147226; x=1721752026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqArnmvQ/vJDjlGwKA+4gw/JcAXFrp1FmAC8/CBrsWI=;
 b=aOmrYoP1pMZq7Z8YwSSLE/PZjtyeNNOe+sF4uhQSium2Sqgy4RLoMuqBd6NeC0Yl07
 IUtzMh2TwV5ATBBPnKKf0OLvCg0QfqpbtRE5VwnztBS2GOcmlIv9HnmyGruTPrt2r/6/
 rOojpzaPEEb5Y8U2RdCLemexEisZt3vgX47FbQDmLhKp3jZvoSFz7ss8odaLYkqCzPRY
 bfQqfAMcBgNq2ESjV9cDWrsbvIqf1FaZc7zoOLc9yDDjJmefNBBUAY7Pmvb8d7OV8q2X
 jG55Vs1hZ2EMbiaZXg7RLW1Jal6i/ooC9FckFTNlEqTUKQipLI/Xg0jVXAvo8zi1VAxN
 C2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147226; x=1721752026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqArnmvQ/vJDjlGwKA+4gw/JcAXFrp1FmAC8/CBrsWI=;
 b=SB2S2OIPHEV/7aLqzahyUyJ4Hg0lrPilBvKx8e14yBN+rsAct3xGiTkx6Pucb51XE+
 u4OnL+EU/JnTrm7GuGF1GI7dgtlPCqBrXdqJ6reaGWZ4/JTr44lLccd62/amse/hii3Q
 3gHziLAnsKUd/J0Gy1pBw63NFbwhm+YOZdF40tM+0tShKViMueC0cyvkG49bjmE72G1i
 MjSK2dTIWy4DCzN3ectVs8ayhvmKYFUATrDXHcUZcG4t/HBM09y/UNFbblyt1uP3z1TR
 GbLn/lQF4OCsHIvpRi1JB4V90ncItRRRC6SKGEQifCi6lg9fuuLVf/GJg9NboPqZgkNI
 kZxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxdwhUvn9fbSjfZpd6ArWt0H6+orC9tHzZ6Oz9B4hFevQfvRic2P+NU7C+TCsWWbczW6acZn694PNTcC4g379j1RyjTkk=
X-Gm-Message-State: AOJu0Yx7jaLNxYNvzVoFdgvn8EIOiNE6z0oFsq45vT/iRJ2s4u8HOMTK
 mE6XpchNa90r+07dQyMFj3bdMgiM9i+gkRwRJ4w7xcN4HEM5F1dRJROIAQ==
X-Google-Smtp-Source: AGHT+IG9i9FrA/O+kBq2GYmeyMWeyu5koMxf3KYBVUtV1AgtQLkemKmITO++YGiSN96A4zEaystvBA==
X-Received: by 2002:a05:6870:8992:b0:25e:b825:94db with SMTP id
 586e51a60fabf-260bdfefa7dmr2215686fac.48.1721147226542; 
 Tue, 16 Jul 2024 09:27:06 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 11/19] ppc/pnv: Add allow for big-core differences in DT
 generation
Date: Wed, 17 Jul 2024 02:26:07 +1000
Message-ID: <20240716162617.32161-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x33.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d902860ecd..1d08176b75 100644
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
2.45.1



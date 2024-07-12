Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144EEC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0G-0006V5-47; Fri, 12 Jul 2024 08:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzh-0004gQ-7L; Fri, 12 Jul 2024 08:03:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzf-0005Zr-9d; Fri, 12 Jul 2024 08:03:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so334304b3a.3; 
 Fri, 12 Jul 2024 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785797; x=1721390597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AyDGj3ZDezl1UlUVAm1qZ38iB6LaQ9Gbtb/xnqxjfY=;
 b=nNiBz7sQZ09eO3Y8RWn/e7qOJ+j8bFXxRq4JDw3as1hz4Qc7j+CeII9otVz9izknpv
 A1cG1E/uvSG13xGRxx15ieXUv3HhG/nvM7SWIGw8ROLf/vdRrNX9UHpwm6n71AZdtkOY
 B3RRONP9za3aVVxluHSm95wMFxWhnwjSf+0oEqKW+q/tjpiK05yCCKWQd4wR9kQooZ4A
 dVoviluDaGPy5C50YrQ25vYn+OljtGP3nIzt7sqJVSjVi21JKErVi3rnZLl5bdZkfNHU
 un5fXzzhAADNAIcUDqUAx/UyI+X94VFJjO6dP1jcy0H+HWPx9cR1Ajz+erv10hk3K6fp
 BCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785797; x=1721390597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AyDGj3ZDezl1UlUVAm1qZ38iB6LaQ9Gbtb/xnqxjfY=;
 b=KOaYSTPNdWmNHRwtf5BecPjOCw9975mG45P+5JT9c/SCOU3F3PngheFL/GXwlQJU8j
 L8iHasypXCpKQZseCahVxB/dfMFCJbM3mYFpHNKfwC4qfOG3XX2F9XAXruqizyi3kogH
 uLvYZ+XlVCa+X18xvLlQ/ctRpXqO8M7r0mK8rqg7Bcqs8UvfoDOtECUXcA+t13NrVniP
 eWzLQtV/nQou/d4Pt57wBXyDULii8d4gUACvDnh+fp2YTM5gumo94AtxeuHUWAyqdD8X
 iv68pi+rtdV55OBzbmZwBiK04WFlKQkHOCg/tBfZDPgfwJFLzgs1oZC4LX1Ssa3WSc+H
 rc3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtydlhrlwaff4zST2e2XCZx/gNaAcxmpJWjjAQPcfJo+jOthYGacr7Ot2zFBwNRccH+q+JqElcIhCRPW12fxbDJmGgUuA=
X-Gm-Message-State: AOJu0YzFlPGoiPQj8W9QKOeCMjNxgBow/8+RHQvuvS259pvfIx1qiFR6
 voDsqQpF5U38qduFb18LeFUYeVmckFlqePDqy5HVojkd4mnBbgS0UxnTCQ==
X-Google-Smtp-Source: AGHT+IGZrPUFOKKc6wttAOrLtWfTaPuLwbqZC+9f+1OSLdaIdSe8kWLK9GYge6NeVJXJboS957na8Q==
X-Received: by 2002:a05:6a21:6d9e:b0:1c0:e629:3926 with SMTP id
 adf61e73a8af0-1c298221bf3mr13184752637.16.1720785796762; 
 Fri, 12 Jul 2024 05:03:16 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 05/19] ppc/pnv: use class attribute to limit SMT threads
 for different machines
Date: Fri, 12 Jul 2024 22:02:32 +1000
Message-ID: <20240712120247.477133-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

Use a class attribute to specify the number of SMT threads per core
permitted for different machines, 8 for powernv8 and 4 for powernv9/10.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h |  1 +
 hw/ppc/pnv.c         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 476b136146..1993dededf 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ struct PnvMachineClass {
     /*< public >*/
     const char *compat;
     int compat_size;
+    int max_smt_threads;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
     void (*i2c_init)(PnvMachineState *pnv);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7878fed43c..fde51ca946 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -899,6 +899,7 @@ static void pnv_init(MachineState *machine)
     PnvMachineState *pnv = PNV_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
+    int max_smt_threads = pmc->max_smt_threads;
     char *fw_filename;
     long fw_size;
     uint64_t chip_ram_start = 0;
@@ -997,17 +998,19 @@ static void pnv_init(MachineState *machine)
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
-    if (machine->smp.threads > 8) {
-        error_report("Cannot support more than 8 threads/core "
-                     "on a powernv machine");
+    if (machine->smp.threads > max_smt_threads) {
+        error_report("Cannot support more than %d threads/core "
+                     "on %s machine", max_smt_threads, mc->desc);
         exit(1);
     }
+
     if (!is_power_of_2(machine->smp.threads)) {
         error_report("Cannot support %d threads/core on a powernv"
                      "machine because it must be a power of 2",
                      machine->smp.threads);
         exit(1);
     }
+
     /*
      * TODO: should we decide on how many chips we can create based
      * on #cores and Venice vs. Murano vs. Naples chip type etc...,
@@ -2490,6 +2493,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 8;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
@@ -2514,6 +2518,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
@@ -2538,6 +2543,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
 
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
-- 
2.45.1



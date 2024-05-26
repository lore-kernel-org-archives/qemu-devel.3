Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC787C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxa-0006Gw-5C; Sun, 26 May 2024 08:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxY-0006GF-Mo; Sun, 26 May 2024 08:26:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxR-0001MC-ME; Sun, 26 May 2024 08:26:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso1930560b3a.3; 
 Sun, 26 May 2024 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726396; x=1717331196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRRb5/JxNrhV4ZEJTCiySwcdnt6Whmnu6aunQADWVXs=;
 b=mMaa3LUoNb7RBTs4Pj+POdHnYf6K7hSJFWEQBf7YvoKWfPO43RMD3YLwkHfHRYMKu1
 BVeA3vjWkt6OYOXqRisuNZRRWci+gSkRGPe1BcdsIxCiKKoWRLvAIRIigUrIZRJUUdrR
 XB/N7RAknmz7ljblHG64+nr3YmyLI1z6W8fgjtRaa+KM+UY2b1RCjcM1YJuPAF1l3cFr
 gD41asLkFzpKjbLiGGQgzpkjCJ056JyQQY7Z3MkEU1g3yJCTnfGzAHNldYwJdn2+i4mH
 Lu6Z83lx+mw7fwPKb8+v1q2Ei7ElCFr7q9AvKszvQ4/R+sHzYYbxwYz4emMYnzCyivJI
 zOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726396; x=1717331196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRRb5/JxNrhV4ZEJTCiySwcdnt6Whmnu6aunQADWVXs=;
 b=auilnrGAcszbG6OnYX+WuRJPMyjariohuc3yNdloLrtJuiRM4RhvhmUg94BAdfdpBG
 SccZY4LBPjkRzuidVnPO5b/WqDw/TMT+hzX6XfJ4ij+225cYLdrNiI7PE7lThMCCvqB/
 XoyYJF+1Sh0IRTaXOPr8m++d7ZHMjWWb5u/xumeONFMooHOWhcasx/9ogOqmIfIEwfcC
 KrOwjiuXoWPPrEJoj9ytCCIdAfeUhTrh/oKzAwHusBhmisndx97o3GIe2r4snIcb/JNp
 evY5tGJ47t0tsxWwKYtz/hr7YuqEtRks7lLeN1rpQtS1dpCs5rFKuZyfuafrly4E02OP
 Rjow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0JiFdMnPn5zy5V9SzGAhukmLiu1lI3KXwlmneLNEgz3qMr6yk9KykcJz/KXu3HHD2VG9ZOwVqDcLKjijXjjSGw0aQ1/I=
X-Gm-Message-State: AOJu0YzP0KYmTCikk94shbAaN9AmFR9Rtjv60RESRrkhY2S6N6VKtOLN
 TFjAI+3hsJZ4drN+t2SR7Lgrc3qpzvz4aSwCgHM+I9duyf61QhNwWZuoqw==
X-Google-Smtp-Source: AGHT+IEd/tZf903RLyQdycmWpkG8E7bkjvT6eZzOxyRO20HpxULx453WiJvDG8xaeb1wlIhKT7z2wA==
X-Received: by 2002:a05:6a21:3981:b0:1af:f514:97cb with SMTP id
 adf61e73a8af0-1b212d5b19emr8111912637.8.1716726395678; 
 Sun, 26 May 2024 05:26:35 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 04/10] ppc/pnv: specialise init for powernv8/9/10 machines
Date: Sun, 26 May 2024 22:26:05 +1000
Message-ID: <20240526122612.473476-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This will allow different settings and checks for different
machine types with later changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..a706de2e36 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -976,11 +976,6 @@ static void pnv_init(MachineState *machine)
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
-    if (machine->smp.threads > 8) {
-        error_report("Cannot support more than 8 threads/core "
-                     "on a powernv machine");
-        exit(1);
-    }
     if (!is_power_of_2(machine->smp.threads)) {
         error_report("Cannot support %d threads/core on a powernv"
                      "machine because it must be a power of 2",
@@ -1076,6 +1071,33 @@ static void pnv_init(MachineState *machine)
     }
 }
 
+static void pnv_power8_init(MachineState *machine)
+{
+    if (machine->smp.threads > 8) {
+        error_report("Cannot support more than 8 threads/core "
+                     "on a powernv POWER8 machine");
+        exit(1);
+    }
+
+    pnv_init(machine);
+}
+
+static void pnv_power9_init(MachineState *machine)
+{
+    if (machine->smp.threads > 8) {
+        error_report("Cannot support more than 8 threads/core "
+                     "on a powernv9/10 machine");
+        exit(1);
+    }
+
+    pnv_init(machine);
+}
+
+static void pnv_power10_init(MachineState *machine)
+{
+    pnv_power9_init(machine);
+}
+
 /*
  *    0:21  Reserved - Read as zeros
  *   22:24  Chip ID
@@ -2423,6 +2445,7 @@ static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
     };
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER8";
+    mc->init = pnv_power8_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
@@ -2449,6 +2472,7 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
     };
 
     mc->desc = "IBM PowerNV (Non-Virtualized) POWER9";
+    mc->init = pnv_power9_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
@@ -2473,6 +2497,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
         { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
     };
 
+    mc->init = pnv_power10_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
-- 
2.43.0



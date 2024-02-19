Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6BCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3W-00012q-D7; Mon, 19 Feb 2024 03:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3L-0000tb-O4; Mon, 19 Feb 2024 03:31:07 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3K-0002IO-7y; Mon, 19 Feb 2024 03:31:07 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc09556599so405325ad.1; 
 Mon, 19 Feb 2024 00:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331464; x=1708936264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO+f3hPKeL5HSk7HpmCD/7SFZU9TBIYTsIyIXJfwhsQ=;
 b=UOpU48J2e2eMrjC4iqWff/63sFPhbGlYhSJomsk/rKLNmcAEjRxKmJ1hne/OpOIKTh
 f+I+SQppJ+bEwpzyoxPsLKqhbfhtnHei0JCSDJRMgL7QP3+5CvR8AImAl2lDN7WS9T2q
 CUryTPZTfwBhubq9c8mh+8SmrZ/KhqUFnGJzCDWymyYwMEZLU66KJrrHUhvVsvuGRx0B
 Q2FHutjr90nW4tbtOlij6vc2mGdtaYH5Uz0oeZe8HyziAuMcfvMGoFPe5IOTDUxW0cCV
 AlZR5Co8K92RfTr52JORorKDQY6oMJD78ZDmlPKJLoKtmJHSeJCTj3Z0OhOTOaM+70Wu
 BLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331464; x=1708936264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO+f3hPKeL5HSk7HpmCD/7SFZU9TBIYTsIyIXJfwhsQ=;
 b=Jq30zKGXtqXdfxDWjUOm6ljThKl7w1l9tKAG3MjAj7mRqh7HxfLjaIJBIsP1RYNs0A
 +jXMiIckFhip6E6uhqik1IXR1GkbuNhRrDGNEAhS5A2Gi80+4c8RtQBzSul9l8l93F86
 Pqa8fWAkFXB53lGJ7IKLdaO1QgfCO/nMLOtLhF8tnysKUBRExi7wwr68lTng0EcBqQTH
 0xJud0vjBTgwrtanwNCsW+gUq4R/UuAGdLeMbe1GspieFMG09CwNTgnXqpNnrynXFsAy
 WrEga0yHgmt4+meQuef1jKzR/PYJs86LwUxpvZ6kLOxEemFwllV8DPEZSCuZth2eZW7N
 jsaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJuJ//jNGJgJ0O8GB/x17hYihWI4V3q9K25QUkuvtQzMwGbY6381DH2uJGNR/kSldLH87hhvV1UsWusKRND10p6yY
X-Gm-Message-State: AOJu0YxFSLlbocDhA8Xne4vZLeCp3chQ9nNN7dlz5ZlD7d8X07mjWStN
 rwrNRofB1VNAapSqGzNKwRbAzSDB3On+/KgRNVJihVUtX/bBa4zTaXiItDfu
X-Google-Smtp-Source: AGHT+IEuUTilaMo2EhR80TXiGo8DEE2+vRLrWeInssa3XSVf5ZwgWPokXBKDdb2mZilXnG1jC0TCRg==
X-Received: by 2002:a17:902:e809:b0:1db:de93:464e with SMTP id
 u9-20020a170902e80900b001dbde93464emr5959121plg.10.1708331464474; 
 Mon, 19 Feb 2024 00:31:04 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/49] hw/ppc/spapr_hcall: Allow elision of
 softmmu_resize_hpt_prep
Date: Mon, 19 Feb 2024 18:29:03 +1000
Message-ID: <20240219082938.238302-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Check tcg_enabled() before calling softmmu_resize_hpt_prepare()
and softmmu_resize_hpt_commit() to allow the compiler to elide
their calls. The stubs are then unnecessary, remove them.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c  | 12 ++++++++----
 target/ppc/tcg-stub.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index fcefd1d1c7..0d7d523e6d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -123,9 +123,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_prepare(cpu, spapr, shift);
 }
 
 static void do_push_sregs_to_kvm_pr(CPUState *cs, run_on_cpu_data data)
@@ -191,9 +193,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
     if (kvm_enabled()) {
         return H_HARDWARE;
+    } else if (tcg_enabled()) {
+        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+    } else {
+        g_assert_not_reached();
     }
-
-    return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
 }
 
 
diff --git a/target/ppc/tcg-stub.c b/target/ppc/tcg-stub.c
index aadcf59d26..740d796b98 100644
--- a/target/ppc/tcg-stub.c
+++ b/target/ppc/tcg-stub.c
@@ -28,18 +28,3 @@ void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 void destroy_ppc_opcodes(PowerPCCPU *cpu)
 {
 }
-
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu,
-                                        SpaprMachineState *spapr,
-                                        target_ulong shift)
-{
-    g_assert_not_reached();
-}
-
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu,
-                                       SpaprMachineState *spapr,
-                                       target_ulong flags,
-                                       target_ulong shift)
-{
-    g_assert_not_reached();
-}
-- 
2.42.0



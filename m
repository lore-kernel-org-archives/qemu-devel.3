Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446EBC54766
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3i-0001XZ-1x; Mon, 19 Feb 2024 03:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3Q-00010g-U6; Mon, 19 Feb 2024 03:31:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3P-0002In-5C; Mon, 19 Feb 2024 03:31:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1da0cd9c0e5so37032125ad.0; 
 Mon, 19 Feb 2024 00:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331469; x=1708936269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/DLuXky9FQDqFdM2qoHQOMo5LuNUVQuzkj5LQTCSNQ=;
 b=iTlPi7s1ITsC6Z66zXFt4P9d5xuDeNOUGja5p6/YbKzCZNIFJRZJKjmVaPuFo6KTq8
 98pfGSnnuLeFdCPfhPc811XyBChN5cjQJf7TT3OVgQAcvCHPuDDLKN93hAmOcPpaCW+f
 Lh/x9frdrpFXTHKBDYu9jfrEd1bWTDXKJJAbiT6ZsJ9KO/dxTo1qIOfjNbmx8CrdWh27
 WJStEsb5NHF88MxoVRUZVQdUjSEaPOv9zR44egeqJTx5q2eO2NFQWGknE9ChrbYpOEG2
 FuNAdY36/E6g05js1OLOsslfL7FfUyKxxxVBFyfAbL49SH25pEwTAvaMcYL9MWrKF+Vn
 mdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331469; x=1708936269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/DLuXky9FQDqFdM2qoHQOMo5LuNUVQuzkj5LQTCSNQ=;
 b=kMqmMVoJLUuQtW5CYYxFAQoM4kwRBkItccFJgAX+/SzEEhZX/NJ9jFKVbIBOjVhl34
 hbyyClvoR/qxT0t5y1HCoYM+NX5nRMokbxzjbNhVDad793SzEWGeFhewFrjGczdb3wYO
 ObIaaj2hSFjDQhTcaJ/Ei6BGFY0WP1uBHbKHRlpNAQifoxN3ySRzeTyc5ozg/fA6dBDx
 i37dwYzI9yUN7hUC9vpQxtHGv3cvnQJW4sJaAyj0xZJj6RRFXEsTuDaAwYF3L68rqDE2
 cjWnaJuE8BwB9hpZ5eM4+naTyE8V6FBeFemLXay/38/sK/jgVg0pQ1f5iulKUiJjn/xb
 1WMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvrFm8RyzGrIjxBoJZA+cb2Nk9QCF5fdyxYkrE+28ZAi70okFsMdugSePgfIQ2d78LD+KKJ9j/fW77WhBC4GBpLwE
X-Gm-Message-State: AOJu0YwOiquOPit+hl8VyPJSckPj7c7kewcP+WoMQyMoALe0UWAUUfus
 mSatZMW5+AqdhmShTGYIFGpzf852tXeOzPb1j94q75lN8ztRfu5gvfMi3v9f
X-Google-Smtp-Source: AGHT+IGBvekDO5QI/CfzmHNJzhcORPoTyfzumLC1+5mdvCv8oWARi4ImpepXF+H3VPxfDliaBZkVoA==
X-Received: by 2002:a17:902:d512:b0:1db:cf64:7331 with SMTP id
 b18-20020a170902d51200b001dbcf647331mr6469868plg.13.1708331469270; 
 Mon, 19 Feb 2024 00:31:09 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/49] hw/ppc/spapr_hcall: Rename {softmmu ->
 vhyp_mmu}_resize_hpt_pr
Date: Mon, 19 Feb 2024 18:29:04 +1000
Message-ID: <20240219082938.238302-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

Since 'softmmu' is quite a loaded term in QEMU, rename the vhyp MMU
facilities to use the vhyp_mmu_ prefix rather than softmmu_.

vhyp_mmu_ is chosen because the code that manipulates the hash table
via guest software hypercalls is QEMU's implementation of the PAPR
hypervisor interface, called vhyp.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[npiggin: Pick a different name, explain it in changelog.]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c   | 4 ++--
 hw/ppc/spapr_softmmu.c | 4 ++--
 include/hw/ppc/spapr.h | 9 ++++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 0d7d523e6d..75c2d12978 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -124,7 +124,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_prepare(cpu, spapr, shift);
+        return vhyp_mmu_resize_hpt_prepare(cpu, spapr, shift);
     } else {
         g_assert_not_reached();
     }
@@ -194,7 +194,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
     if (kvm_enabled()) {
         return H_HARDWARE;
     } else if (tcg_enabled()) {
-        return softmmu_resize_hpt_commit(cpu, spapr, flags, shift);
+        return vhyp_mmu_resize_hpt_commit(cpu, spapr, flags, shift);
     } else {
         g_assert_not_reached();
     }
diff --git a/hw/ppc/spapr_softmmu.c b/hw/ppc/spapr_softmmu.c
index 2fade94029..b3dd8b3a59 100644
--- a/hw/ppc/spapr_softmmu.c
+++ b/hw/ppc/spapr_softmmu.c
@@ -378,7 +378,7 @@ static void cancel_hpt_prepare(SpaprMachineState *spapr)
     free_pending_hpt(pending);
 }
 
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu,
+target_ulong vhyp_mmu_resize_hpt_prepare(PowerPCCPU *cpu,
                                          SpaprMachineState *spapr,
                                          target_ulong shift)
 {
@@ -562,7 +562,7 @@ static int rehash_hpt(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu,
+target_ulong vhyp_mmu_resize_hpt_commit(PowerPCCPU *cpu,
                                         SpaprMachineState *spapr,
                                         target_ulong flags,
                                         target_ulong shift)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e91791a1a9..5b5ba9ef77 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -634,10 +634,13 @@ void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn);
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args);
 
-target_ulong softmmu_resize_hpt_prepare(PowerPCCPU *cpu, SpaprMachineState *spapr,
+target_ulong vhyp_mmu_resize_hpt_prepare(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
                                          target_ulong shift);
-target_ulong softmmu_resize_hpt_commit(PowerPCCPU *cpu, SpaprMachineState *spapr,
-                                        target_ulong flags, target_ulong shift);
+target_ulong vhyp_mmu_resize_hpt_commit(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong flags,
+                                        target_ulong shift);
 bool is_ram_address(SpaprMachineState *spapr, hwaddr addr);
 void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
 
-- 
2.42.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0B7C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRudZ-0002T8-07; Thu, 11 Jul 2024 10:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudX-0002Md-Dm; Thu, 11 Jul 2024 10:19:07 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudV-0005RJ-Mr; Thu, 11 Jul 2024 10:19:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70b5117ae06so758847b3a.2; 
 Thu, 11 Jul 2024 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707543; x=1721312343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TAH4O1NHOlM3uAyWb3ssMGd5UxeSj6AOHrFW8OMEk8Q=;
 b=LcFrO3/AqYLgUR0tZ2Oy0kw1bLuk4BOH7XADeE490wXYBD8HfWTmSQDkvReJOFYHM6
 +9xGuB4KetZXiO8eh251fTscx2aMO2skDwapY2etsOAVYqW8DLX17VC2g68sRMYG5Hz0
 qwGoUNkGeBOzv1zsz1ByzTJSHQc6GRCJjaOJfIAO6Vt5ft/tNo0541su7f7eAUd8q1Js
 Qd2zJy+99MeLb2AQ4zaarCbhwwaLRQM+eyC2tE4ttzFwa+2iANYHYGU2m5sdmJnup5ml
 4ka+epMO6lVxEm5OzMPG+qq4Oup0GlvLGeBat1gJEAWtWGo07DHrxupLhcmMbblp2nhW
 HJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707543; x=1721312343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAH4O1NHOlM3uAyWb3ssMGd5UxeSj6AOHrFW8OMEk8Q=;
 b=ll5Rrqgnomawew1YkQ3sqCD39oeSz84Dqqgwjam7QQCGQPy5fadGEIR6IUF0eGjGBe
 RIxRlHxJxdJf0cPyRGcnpqqtAXZq7gyaS7LuLOJlEVMZhI2FtfkaljDv+kJlZFE/fPS6
 2HIlugfHVlqj2c3DzN8Wx5aBa2K7dp/7X/abs2ZlCkl5GqrxILQ49Kyq+7P9rbtnFxOS
 q3CvS094FY3xHuDvYyTL/NI9HTytcLP37JN3QefgmW26TEN0vBglYKYYSlFBjyUacKF4
 7IR2rr3cpf0ZqHeVx/xYKV6PL/jBoeJqZvs5MAMWEr54KIr+ktzX0JPx35td81q/q+Dl
 RIrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWOLRU0MCZxrEFxd5Lb/YecjVP5eqS178RMNWKulQkHGMWeTX9Pz8O0bnSlUKfyzNktvZh1cCBq/Jhx3XbCRe6iUzY72s=
X-Gm-Message-State: AOJu0Yx8Gyy9AeYGfpMJp6tMWRQRZ6WKwfKh2Dw9AoknBssgkgR+pnY+
 xIc0Qx30TtAt7cTahtWiTXCpuCmvG7We8fPACHuu9dx9BzDecHYVqe7gnCjw
X-Google-Smtp-Source: AGHT+IF2+ZSKlwHmev7lpGiIX59OgDJfTQy/wJex4iRY8oXYM/UMchkdnxkbL/kDPVKoGsnlqBXYGw==
X-Received: by 2002:a05:6a20:3ba7:b0:1bd:2894:4015 with SMTP id
 adf61e73a8af0-1c2984c85b3mr7632762637.50.1720707543352; 
 Thu, 11 Jul 2024 07:19:03 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 01/18] target/ppc: Fix msgsnd for POWER8
Date: Fri, 12 Jul 2024 00:18:33 +1000
Message-ID: <20240711141851.406677-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

POWER8 (ISA v2.07S) introduced the doorbell facility, the msgsnd
instruction behaved mostly like msgsndp, it was addressed by TIR
and could only send interrupts between threads on the core.

ISA v3.0 changed msgsnd to be addressed by PIR and can interrupt
any thread in the system.

msgsnd only implements the v3.0 semantics, which can make
multi-threaded POWER8 hang when booting Linux (due to IPIs
failing). This change adds v2.07 semantics.
---
 target/ppc/excp_helper.c | 74 ++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0cd542675f..c0120c8a88 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2998,6 +2998,41 @@ static inline bool dbell_bcast_subproc(target_ulong rb)
     return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
 }
 
+/*
+ * Send an interrupt to a thread in the same core as env).
+ */
+static void msgsnd_core_tir(CPUPPCState *env, uint32_t target_tir, int irq)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    uint32_t nr_threads = cs->nr_threads;
+
+    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
+        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
+    }
+
+    if (target_tir >= nr_threads) {
+        return;
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, irq, 1);
+    } else {
+        CPUState *ccs;
+
+        /* Does iothread need to be locked for walking CPU list? */
+        bql_lock();
+        THREAD_SIBLING_FOREACH(cs, ccs) {
+            PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+            if (target_tir == ppc_cpu_tir(ccpu)) {
+                ppc_set_irq(ccpu, irq, 1);
+                break;
+            }
+        }
+        bql_unlock();
+    }
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3018,6 +3053,13 @@ void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
         return;
     }
 
+    /* POWER8 msgsnd is like msgsndp (targets a thread within core) */
+    if (!(env->insns_flags2 & PPC2_ISA300)) {
+        msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_HDOORBELL);
+        return;
+    }
+
+    /* POWER9 and later msgsnd is a global (targets any thread) */
     cpu = ppc_get_vcpu_by_pir(pir);
     if (!cpu) {
         return;
@@ -3064,41 +3106,13 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
  */
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs = env_cpu(env);
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *ccs;
-    uint32_t nr_threads = cs->nr_threads;
-    int ttir = rb & PPC_BITMASK(57, 63);
-
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!(env->flags & POWERPC_FLAG_SMT_1LPAR)) {
-        nr_threads = 1; /* msgsndp behaves as 1-thread in LPAR-per-thread mode*/
-    }
-
-    if (!dbell_type_server(rb) || ttir >= nr_threads) {
-        return;
-    }
-
-    if (nr_threads == 1) {
-        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
+    if (!dbell_type_server(rb)) {
         return;
     }
 
-    /* Does iothread need to be locked for walking CPU list? */
-    bql_lock();
-    THREAD_SIBLING_FOREACH(cs, ccs) {
-        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
-        uint32_t thread_id = ppc_cpu_tir(ccpu);
-
-        if (ttir == thread_id) {
-            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
-            bql_unlock();
-            return;
-        }
-    }
-
-    g_assert_not_reached();
+    msgsnd_core_tir(env, rb & PPC_BITMASK(57, 63), PPC_INTERRUPT_DOORBELL);
 }
 #endif /* TARGET_PPC64 */
 
-- 
2.45.1



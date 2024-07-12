Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA6CC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0c-0008Cr-Nd; Fri, 12 Jul 2024 08:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0T-0007Z1-T5; Fri, 12 Jul 2024 08:04:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0P-0005mA-BY; Fri, 12 Jul 2024 08:04:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b2a0542c2so1832943b3a.3; 
 Fri, 12 Jul 2024 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785842; x=1721390642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwGrMKj4cs0jZjJ7yD0GR8qpP2HCKrG9RQwqRirqlHE=;
 b=msi+3ijayEx3gUCKsqc5UGcaKzRxy1ML/8ZcylUPjg0N02TVXfJySjw/au9TjagDkG
 /MlwVM5JEWcjmVg6jTmz6rc+yUA06yHfQM+bmwhen2s+dOkorvvb+VbzArhErrkRX2vC
 l51AEniNPTu7KW9pEPAW7G78pMvb3T7p87RneWcySxKwbA/ZWAZf9h2TeQUxJ1GP3Ywh
 np9ukT9sjX9ExXUedmhguN8YmgE/fk/lEr0h2rq4q1neEC+86yHRitAPp4V4jErGS5Ne
 PId+5SvF9KGLGZ0LBabeinjRIUWw9OXmAWnZC5kH+0bzkrj84fNU02eUH7vMIIUzXv5v
 nVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785842; x=1721390642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwGrMKj4cs0jZjJ7yD0GR8qpP2HCKrG9RQwqRirqlHE=;
 b=uD8kVHKjiDaiOQhCq/vU9L0dMq5CqZO7aOL4190/MpMM6NcwoM8z3KmWPjubTlfJqX
 XFiSLQB77Hnf4ZnuoXRhK1moUaJAJOE82PsuzQhYGsc3I5dpCUlfKegx4mDTONopIM6V
 elTuoz2ie5QXjYkdLNjmsvRwidS2zYGe12kVnxifh6Oww+K0okIOHmjoL9vAoVO08YZv
 r4Pk4FTGUAsHJSgc38uiXABwelz7Bw1Be8RepcQE+miT1dH9iyNAhb99LtCnLjWEWmLf
 mblk5FZucSrBvDcSMW7b6/u9kOgZHDbU+t9xCtTpx2AgFUpHtwy4edCH15IHRqmLlnPm
 FPHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8UnlxUBv1UtMMGbfS/ivdo8jKFkxUiKvwtvKnoHD9hyP5Aq/neQ+wk83C8z80OHWW23gW5OvG6d4mZucZNAmAW7q1Wlw=
X-Gm-Message-State: AOJu0Yy/vQJIJiyXqi8xlznsh0r3D0dZe71Mf/bp3Fe4xuq2JZFzpBGi
 zMy4+Gcvjw8UKKijUrXwNOXhLlPCDMXAWH/FO0UlrcibZLlKRQpQh1jKPw==
X-Google-Smtp-Source: AGHT+IExA4Vel9ApnDgpubmx+RLGFmxlFbp+chx5PXO+EfaNSBSDMBa1OQQd95Y+UeR1CdJk1AdtVQ==
X-Received: by 2002:a05:6a20:9145:b0:1c0:f594:198c with SMTP id
 adf61e73a8af0-1c29820c067mr15409355637.11.1720785841739; 
 Fri, 12 Jul 2024 05:04:01 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:04:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 09/19] ppc: Add has_smt_siblings property to CPUPPCState
Date: Fri, 12 Jul 2024 22:02:36 +1000
Message-ID: <20240712120247.477133-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

The decision to branch out to a slower SMT path in instruction
emulation will become a bit more complicated with the way that
"big-core" topology that will be implemented in subsequent changes.
Hide these details from the wider CPU emulation code with a bool
has_smt_siblings flag that can be set by machine initialisation.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  3 ++-
 hw/ppc/pnv_core.c       |  3 +++
 hw/ppc/spapr_cpu_core.c | 12 +++++++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 417b284318..321ed2da75 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1248,6 +1248,7 @@ struct CPUArchState {
     int access_type;
 
     /* For SMT processors */
+    bool has_smt_siblings;
     int core_index;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1514,7 +1515,7 @@ struct PowerPCCPUClass {
 
 static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
 {
-    return cs->nr_threads == 1;
+    return !POWERPC_CPU(cs)->env.has_smt_siblings;
 }
 
 static inline bool ppc_cpu_lpar_single_threaded(CPUState *cs)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7bda29b9c7..8cfa94fbfa 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -288,6 +288,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         cpu = POWERPC_CPU(obj);
 
         pc->threads[i] = POWERPC_CPU(obj);
+        if (cc->nr_threads > 1) {
+            cpu->env.has_smt_siblings = true;
+        }
 
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4e13e6993a..2c6eeb41a4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -351,9 +351,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(spapr_cpu_core_reset_handler, sc);
     sc->threads = g_new0(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        sc->threads[i] = spapr_create_vcpu(sc, i, errp);
-        if (!sc->threads[i] ||
-            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
+        PowerPCCPU *cpu;
+
+        cpu = spapr_create_vcpu(sc, i, errp);
+        sc->threads[i] = cpu;
+        if (cpu && cc->nr_threads > 1) {
+            cpu->env.has_smt_siblings = true;
+        }
+
+        if (!cpu || !spapr_realize_vcpu(cpu, spapr, sc, i, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }
-- 
2.45.1



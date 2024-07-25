Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9E3C49EA1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jg-0002yd-2O; Thu, 25 Jul 2024 19:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JX-0001uD-Eh; Thu, 25 Jul 2024 19:56:06 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JV-00012O-Ey; Thu, 25 Jul 2024 19:56:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso306489a91.1; 
 Thu, 25 Jul 2024 16:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951759; x=1722556559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlYy55viqqVF2VCFTUUxxhloxGG2P4zq4cEUU0+GbS0=;
 b=OharIRxerPHz+1Ku0ow2MQa05l7kp1sJ4IUoR9o5Z1PVeGDJwUo3kJAOqc1yaMSmM3
 ClzzDLccr1mnfFP4g+SNKVZiG8GseSEACN/AJ/+r8oMmp8oDbH/LNkVItVcy+RumH9KV
 /ZbrKg2Ea0SJkrLVQcGu7+t0DNx3GS24VJB9KUUKC3OTPnyxJ2ayIMC7aVIa2wtdl4lz
 imulfV1W+I9x3nKndVy4/AwwSNDki72VhSLL9byM26PbF1LQEfwXTAqJiQ931FpKBcZA
 Q/8/cVMJ8ZwFgL4PkvZxRHyroS/O27VjJCcEAdfH1i8k8noBl+l81oYvGA53zoR1zDNW
 EHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951759; x=1722556559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlYy55viqqVF2VCFTUUxxhloxGG2P4zq4cEUU0+GbS0=;
 b=OprgnAGf3JqutlKr9TU5CvUCTS4+bIDBJi/heoXXZkVOMXf8Xn5sP6fPuvO6WTmd0y
 gwoO1geH316W9mcZB7Qa6PXVFyxGX8Na8722tzgmzcvVPc7u7SSlQbVLLzvr/iKmDv1j
 1s7/dVnvVw6woi/KS392dayOqLMzOTcQ6lxJuHaOk017Q7gKTgpHQvqicpMfaeoYrcgI
 JReqjdHr0n0nNf+qzdwhpKW6L7BkijHFaxPEiBdYVHK8D7E3/qWbsvJyVcItGSGzxDzp
 aRXhlRVawVrE/NZ1LELpMCOrt3SjgJBKgCcOxPOzNT8eM4v1ixbLFNP6rrlFx5sK5Q0O
 i6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk+WaBHXM+o0wrqYVSfXCQP4H3Oh9pn0SDA5AKRUtvpV8QIkUnO30H3eoTG29bzjBpUksCugd+yb3E1OMRh4re70M5
X-Gm-Message-State: AOJu0Yz5BjahyqWdDute/wP4iuVRGgaCKeOsLEgn5u9qvOQp9t8xT5kr
 QX95LNNsAp4gIDa7DHgeeEkO/Pv0vy+lPsu2aX5EcfU99mkXSpM7Dspvjg==
X-Google-Smtp-Source: AGHT+IF5tnfXeBAn32gfpC0H/jU7B8lXFfxwPL85HfAHhdys1QcfEJpIo4wpm/xHw/il2ytkcGJSNA==
X-Received: by 2002:a17:90b:1a85:b0:2c9:5c7c:815d with SMTP id
 98e67ed59e1d1-2cf2ea135dcmr3973302a91.22.1721951759152; 
 Thu, 25 Jul 2024 16:55:59 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/96] ppc: Add has_smt_siblings property to CPUPPCState
Date: Fri, 26 Jul 2024 09:52:59 +1000
Message-ID: <20240725235410.451624-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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
 hw/ppc/pnv_core.c       |  3 +++
 hw/ppc/spapr_cpu_core.c | 12 +++++++++---
 target/ppc/cpu.h        |  3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index b228c1d498..56090abcd1 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -349,9 +349,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
-- 
2.45.2



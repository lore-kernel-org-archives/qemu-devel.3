Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC113C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOy7-0002xM-7S; Tue, 23 Jul 2024 19:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxr-00029U-VI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sWOxl-0007xS-P1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:30:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70d138e06e3so2756219b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721777430; x=1722382230;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jI6U0BvTHQQ9+y5jpbqfCCV572dEAtDwxnif55veu+c=;
 b=0Yf1ipVjQvWy+fkEylTF3+W0hd+MoUCbRP0ISzY5CVG0H4tozC8WE2rBvlHWkoysWa
 qr43C9/5nueGKbC2Fjpp84L7yWqMCWsUwQ467KF/WepJm8ymSVBtMhrJv3Ekr9Bmq57D
 JI/C+mERktfmpWax2UgrkThhHv0DzPXl4dsZ9WpQglXru2B1l30gUKbd232xbPz3ziDX
 L9vTygu4pgywq9jipZlt7hhIbNVVrEZzPNFzlEoVCVr/Q0wnCxsgBEuLl5PmrpI27a12
 XwChulEf2FC5B1f7ituq2pRJbZJJKFoeXFeINknM9OVCIOOp6NulYdvxgKCKdue1h5Cf
 j17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777430; x=1722382230;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jI6U0BvTHQQ9+y5jpbqfCCV572dEAtDwxnif55veu+c=;
 b=E4MJn3mzknKr4qyMgon4dbRfmACv7vd5V5YxsMSfSV6+ml51UUlTMuD0ecBklaN7GY
 Y1ABzodKc+Q1NRn7xX8+3u4egeyAE+TzhuTKnoMF06kp+JXBLrS6grzItsda5V0KtTs3
 x2GKFfO/XtvS7VgCCqku9A4AnHgn0uTnK5ccEMt+K4bSL9GkuehU/vrZLoNX+O3DPliC
 j5IUG688DCw6xHDZzCvUYLp0GbWqpKWK/lLNIObWM83pk2S/P4sY/htcBRvZ+LFUmm5j
 Ni+Z6iQCrJZj+VZut1fSS1XkTk5N+L2Z21pI2wml+AhPJvjZkm7sG02WS7Ns0xveTXmi
 XvCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7AxMphuDeo4H2QoFb2FSBm38oJ/01OMV2vuoERQWR5mHH1lRTHNr8Y3hxSqSuR03ts8JFrZgKFIj0H/yb/bJFwxyjy/4=
X-Gm-Message-State: AOJu0YwyrKz5Xer6bF7eWMwZgF7jUEoq4NXXQ7/QnZOWes8yCg7O5VxZ
 sTjXNH0LxOCxW4VgPOsvBMq6u/urI63W/61401X5/GHzXB8KyFzliaceuW4OQSg=
X-Google-Smtp-Source: AGHT+IEMB/uTTk7trNXTFSXtM++S7cdg97r/VHKtFqFK5NEizxBks1RXkuGIK3pPek9tQcksCjsYMQ==
X-Received: by 2002:a05:6a21:3390:b0:1c1:e75a:5504 with SMTP id
 adf61e73a8af0-1c42287f402mr17626902637.15.1721777430306; 
 Tue, 23 Jul 2024 16:30:30 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e894csm179217a91.41.2024.07.23.16.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 16:30:29 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 23 Jul 2024 16:30:06 -0700
Subject: [PATCH v2 09/13] target/riscv: Invoke pmu init after feature
 enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-counter_delegation-v2-9-c4170a5348ca@rivosinc.com>
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The dependant ISA features are enabled at the end of cpu_realize
in finalize_features. Thus, PMU init should be invoked after that
only. Move the init invocation to riscv_tcg_cpu_finalize_features.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b8814ab753bd..d78d5960cf30 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -898,6 +898,20 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.pmu_mask) {
+        riscv_pmu_init(cpu, &local_err);
+        if (local_err != NULL) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        if (cpu->cfg.ext_sscofpmf) {
+            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          riscv_pmu_timer_cb, cpu);
+        }
+    }
+#endif
 }
 
 void riscv_tcg_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
@@ -945,7 +959,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
-    Error *local_err = NULL;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
 
@@ -953,19 +966,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         riscv_timer_init(cpu);
     }
 
-    if (cpu->cfg.pmu_mask) {
-        riscv_pmu_init(cpu, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
-            return false;
-        }
-
-        if (cpu->cfg.ext_sscofpmf) {
-            cpu->pmu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                          riscv_pmu_timer_cb, cpu);
-        }
-    }
-
     /* With H-Ext, VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
     if (riscv_has_ext(env, RVH)) {
         env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;

-- 
2.34.1



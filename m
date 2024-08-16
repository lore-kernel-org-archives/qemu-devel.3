Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A60C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJ5-0007GQ-Sl; Fri, 16 Aug 2024 03:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ3-000799-Vx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serIy-00041g-L1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-201e64607a5so12642265ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793003; x=1724397803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpBjGkW6BU4v1nqztsjjBjF53uYRgoULCdoJY53mCgc=;
 b=hv7mQFCgQIgC3vJK0aRnIiTcu8vpUYlF0sLpRib+1oau+KeNcOzHzDdZu1SURGdRmn
 l/0nNS4xEk6zdrS9IpSrhHePeE25QwgqfkMMu9HsjtUMTsXm3QSqOqvgS7tJHaiMCOxr
 5IliFdyG+0TUrUV25KHvGVsg0OJ1StwxtPvJxysvCP0D7zFPJVv4ORPDpOY4+72W6DDN
 nWkrJH5f1AXk8V7Z4I8cinWVtiendAcFh4DMzmg7RBQdX6UXKTmMheH3ODvSf/egsDtP
 UUdDMhLoFFhJhjRLk2nsYGPAuX4OSjxb5M4ycNT+TE+rW7j4UJP1qm8l6g5sv6+kXhAe
 jxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793003; x=1724397803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpBjGkW6BU4v1nqztsjjBjF53uYRgoULCdoJY53mCgc=;
 b=jmwkbw9IwcEvC58mBIYDpJWhwqr47TnQG9fO00G9f7c778+3OdgsK4WfE7Fy4jm9Sv
 ORG1e9nzX1K58zwcmeZMEiyLk4WgaN42g2oEdMkSwGGtWFtpRYWexTnfFbwNBHV9zViO
 meP7uCx9NGuwpvUQtILQtnxmHeHIXWSGfQPSJ9l+QjIi2wmAZOY7Cx5zP2MOBq4ms6pD
 v7Ity+2osVziDeyjjz2DAma2OCQlux+mJ9FzReRWB6PCuwImzBUgNCUn0N8wXQMjkQvy
 TlRv4ruE6BmqlfI8pfHpy19m2M7Ierdoikmx447xa25pz98Wx3zPWBk63r7DVr1Zel0g
 JOSg==
X-Gm-Message-State: AOJu0YzfHoeYtpchD9501wfdDBQBQdG4bMnkAt4kCVAbKDv7BjLQzU7Y
 0KDKK4rpztFkpAHemyyECGLEBtSnEQiRao4+ZZUG6hPzISBoXGDZyWRW0Srk4Jc6DIgqEap8jMs
 CGGk=
X-Google-Smtp-Source: AGHT+IFr2O8vZNyaBw50MbNjqTKEwM9Nmiwdb1WZHp1h8JQLVLFoa230ea5Vc9f6MBX0SOkQogcYxg==
X-Received: by 2002:a17:902:ced2:b0:1ff:3c45:48dd with SMTP id
 d9443c01a7336-20203eb85famr33930975ad.30.1723793002486; 
 Fri, 16 Aug 2024 00:23:22 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com
Subject: [PATCH v3 2/6] target/sparc: Add FQ and FSR.QNE
Date: Fri, 16 Aug 2024 17:23:07 +1000
Message-ID: <20240816072311.353234-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Carl Hauser <chauser@pullman.com>

Add support for, and migrate, a single-entry fp
instruction queue for sparc32.

Signed-off-by: Carl Hauser <chauser@pullman.com>
[rth: Split from a larger patch;
      adjust representation with union;
      add migration state]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h        | 22 ++++++++++++++++++++++
 target/sparc/fop_helper.c |  4 ++++
 target/sparc/machine.c    | 25 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index dfd9512a21..9f2bc44722 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -184,6 +184,8 @@ enum {
 #define FSR_FTT_SEQ_ERROR (4ULL << 14)
 #define FSR_FTT_INVAL_FPR (6ULL << 14)
 
+#define FSR_QNE    (1ULL << 13)
+
 #define FSR_FCC0_SHIFT    10
 #define FSR_FCC1_SHIFT    32
 #define FSR_FCC2_SHIFT    34
@@ -438,6 +440,26 @@ struct CPUArchState {
     uint32_t fsr_cexc_ftt;           /* cexc, ftt */
     uint32_t fcc[TARGET_FCCREGS];    /* fcc* */
 
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
+    /*
+     * Single-element FPU fault queue, with address and insn,
+     * packaged into the double-word with which it is stored.
+     */
+    uint32_t fsr_qne;                /* qne */
+    union {
+        uint64_t d;
+        struct {
+#if HOST_BIG_ENDIAN
+            uint32_t addr;
+            uint32_t insn;
+#else
+            uint32_t insn;
+            uint32_t addr;
+#endif
+        } s;
+    } fq;
+#endif
+
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
     uint32_t cwp;      /* index of current register window (extracted
                           from PSR) */
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 0b30665b51..b6692382b3 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -545,6 +545,8 @@ target_ulong cpu_get_fsr(CPUSPARCState *env)
     fsr |= (uint64_t)env->fcc[1] << FSR_FCC1_SHIFT;
     fsr |= (uint64_t)env->fcc[2] << FSR_FCC2_SHIFT;
     fsr |= (uint64_t)env->fcc[3] << FSR_FCC3_SHIFT;
+#elif !defined(CONFIG_USER_ONLY)
+    fsr |= env->fsr_qne;
 #endif
 
     /* VER is kept completely separate until re-assembly. */
@@ -591,6 +593,8 @@ void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
     env->fcc[1] = extract64(fsr, FSR_FCC1_SHIFT, 2);
     env->fcc[2] = extract64(fsr, FSR_FCC2_SHIFT, 2);
     env->fcc[3] = extract64(fsr, FSR_FCC3_SHIFT, 2);
+#elif !defined(CONFIG_USER_ONLY)
+    env->fsr_qne = fsr & FSR_QNE;
 #endif
 
     set_fsr_nonsplit(env, fsr);
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 48e0cf22f3..222e5709c5 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -143,6 +143,24 @@ static const VMStateInfo vmstate_xcc = {
     .get = get_xcc,
     .put = put_xcc,
 };
+#else
+static bool fq_needed(void *opaque)
+{
+    SPARCCPU *cpu = opaque;
+    return cpu->env.fsr_qne;
+}
+
+static const VMStateDescription vmstate_fq = {
+    .name = "cpu/fq",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fq_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.fq.s.addr, SPARCCPU),
+        VMSTATE_UINT32(env.fq.s.insn, SPARCCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
 #endif
 
 static int cpu_pre_save(void *opaque)
@@ -265,4 +283,11 @@ const VMStateDescription vmstate_sparc_cpu = {
 #endif
         VMSTATE_END_OF_LIST()
     },
+#ifndef TARGET_SPARC64
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_fq,
+        NULL
+    },
+#endif
+
 };
-- 
2.43.0



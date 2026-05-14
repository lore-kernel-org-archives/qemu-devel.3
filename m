Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C9CCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2S-0002wL-4q; Thu, 14 May 2026 13:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa10-0000r3-2o
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:31 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-0003ug-GI
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:29 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so3905791fac.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780287; x=1779385087; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IQRdatDjxrzcYE7e8afik9dgw3qpW4wd3ZugC47LA9A=;
 b=I9BEVf2Sfph2CcpiPvnzc91bLpkRw0s2fKMSofvWyv8OIWtDxfWD3r8COi2TjmvSQz
 S4yFXdwbLgLHQidjXv/1pVXf1p1R2MTrRbzqPdanac3AQ5YPHY0b51T03O7AWD1a9fKZ
 KZRUUOUuR10jDcIGO8cYBPJR0YUNsWhyJGMt9y0Eeo4kKegEhFxTzVnZ1v/VbaVjrLE+
 41Pn5JsXaTPmOTDKeOrlM/fK2upc0Y7ByR1GwehoElppl0aArZ4SzlMhnLyNryLkbuTC
 mOwRaq3a+cgRIgOQvXgGYX3L2zmylxIHKYyL/iQHpkx75UfdlAi4YqvuUpheAXpYgnPn
 GtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780287; x=1779385087;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IQRdatDjxrzcYE7e8afik9dgw3qpW4wd3ZugC47LA9A=;
 b=UjyabrPRvyrqxEbLMpAnetAVYka4kY67GHaIbLi/PM8UHqqAXrbOVtnswb7b7CfOMR
 EjtHi7ZGby/0T0SL0VfSuHavhTV0iPghQASN1+5pYxeZR1J6bUAJF7Ms28pEL1bUza/h
 eOamDbmMIvRBtpUaG3Ggj/DMd2aYdrzA5/Wd0mIW2bnKCMM/uWBaJ4wI1rLV590RoH/7
 DaOZ8b6T0sHGH2yz1HLBvwOOBDgPzOvQEFAfg/TX61Zuy01eC+DfhJAffia19xI+ae60
 w1oJAkLfgTzuPCvtc8Uer4aNTn/Wc8JtWFO7VdNMP5LyBrskTbi6AYqMC13wIe9v5UaE
 frrA==
X-Gm-Message-State: AOJu0YwYDYASMy/SjxhFABm1tzpkiwmKM0ygDzoBmCocqyaPhpwB+11M
 LK2LW2FzqhnqqDG86/XKFPgPrHprx59pGXzsj6TMcDOPn7oEw+W5LcST
X-Gm-Gg: Acq92OF7ccIPgXeTj2COdtMx5iW93MWJbWlK3TuWzpL8nHKRlli4KoY+3kaTG+P7j+m
 OyjL2oka3UsB3YWfValUa6fecMhMn5hbf6XmiWvbq2escJJs2rMWkKNZ2M0z67BuPaYQeN5o9S0
 wibhk2a1Pj4Y7Av9oI72OiTN1BUYyg27lEQbb3atX+TEV4v1C2ms3uJScImdW8T1e0J2P/JGLw6
 XQBVS5SubknkyLP07+ADSTPA0oT4zulerLK+446BNlhlSs0QrTG0BhPQAqcG5gzTwj3nX+zBE1i
 8qqnUk0HIhDI/vaRdaVegS5jlqxUuYlOzq5/iNTuGaepuc0BpLxzBsTYwVuBJ3UpaQ9KMYZ3PDW
 efNLWOmRQT3xG+GKUgVzrp13bAT10fvLXbJA7T059SxfDPu2x4+f5GP+jswl+sIfiATFFzY6Vi7
 V5nQHmsad9sdoiSJNXoNKvo4m77eshjDb3KMO0GPX2c0qWx3f//f51FpSWSCnt+KJThPuvRtXiS
 evIUu9dpY/dMr1oj/UdBXGJ3Ux9xHBkkg79y3S0fbQ5Rkevvfl3MBFSKq3jG3PNK3rVUFWUxLMZ
 yGhto78957O9vw==
X-Received: by 2002:a05:6820:1c81:b0:696:178e:695b with SMTP id
 006d021491bc7-69c9bfacb03mr244966eaf.44.1778780287388; 
 Thu, 14 May 2026 10:38:07 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:03 -0600
Subject: [PATCH v7 14/35] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-14-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add per-thread Octeon multiplier state for the MPL and P limb banks used
by the VMULU/VMM0/V3MULU instruction family.

Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
both banks as uint64_t arrays so the TC state matches the architected
64-bit limb layout used by Octeon68XX user-mode code.

Migrate the multiplier registers in an Octeon-only subsection so
non-Octeon CPU models do not grow migration state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split the multiplier state out of the combined Octeon arithmetic and
    memory instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Document and keep the Octeon3 MPL3-MPL5/P3-P5 high-lane state used by
    the two-source MTM/MTP forms.
---
 target/mips/cpu.h            | 12 ++++++++++++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b478f834c1..346713705a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -459,6 +459,14 @@ typedef struct mips_def_t mips_def_t;
 
 
 typedef struct TCState TCState;
+
+/*
+ * Octeon3 adds a second bank of multiplier/product limbs used by the
+ * two-source MTM/MTP forms: MPL0..2/P0..2 from rs and MPL3..5/P3..5 from rt.
+ */
+#define OCTEON_MULTIPLIER_LANES 3
+#define OCTEON_MULTIPLIER_REGS (2 * OCTEON_MULTIPLIER_LANES)
+
 struct TCState {
     target_ulong gpr[32];
 #if defined(TARGET_MIPS64)
@@ -497,6 +505,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[OCTEON_MULTIPLIER_REGS];
+        uint64_t P[OCTEON_MULTIPLIER_REGS];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 5880b401b0..f988b3695b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -120,6 +120,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -247,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -363,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };

-- 
2.54.0



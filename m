Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C750CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwg-000529-FN; Sun, 10 May 2026 16:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwd-00050o-Vn
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:12 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwc-0003xr-9p
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:11 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479d593a0c3so3146376b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445609; x=1779050409; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kXG9bIpf2vehciJOosSGn1ALlxlG293W6jH4Q8Jdd3k=;
 b=jgSoo1bJTeMpZLJtPCidNhgh16UGD1RJUuxU9Mq4NitSKJJdLE4LF0uklXbXgpwuMg
 GKDWALmzzoacjmcbRzGRF7XzvfhBUEp/IwIwXpU/qnBFTMQ6r6w2OOqyElhrBsPWO5Qf
 vTWsibzWWBnbcGDcOneXHVm/bfjURdBwJmh7t65xWaXlmqlNXpFjX+lL09E++YQXkGUB
 cArUn2Xvta5i6f9m2GZblyJvq2zyNTbmp6X0qtZaWwes2KgRTr1UwoPfy9aClA+VjwTJ
 MwxoGoO1hZbD2X8urP+SCZkAJ99fI0LgVb5sCmG/uIjAZKe/Wd2U836TDQmtcZFffyU5
 lhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445609; x=1779050409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kXG9bIpf2vehciJOosSGn1ALlxlG293W6jH4Q8Jdd3k=;
 b=qm6vrN2uWqHTgZjU5Dg6Gpky76x0rMCGck/bmkXBSwM3EyXwg8MT2XJN1IfA2M5u5J
 DsM7hgYZkg5o2IQjlm1SZA1kqaJJyifcKblOODCODWdqzKIRuJePB/GB2M3zMMIUgXmS
 Dv4coww69tDiEUWIlrwwJ51Wn6J4DbjHWtAqs0C+/wbhEwafAjui4EA+dzHAao9z8K4d
 eWY8pxRceWjdvKOKfFKb04wUGkgjT1ZIk7Kqks2Zs4nfUDyhYgz1Nupi71rwbk7rD87j
 2FsCJ6KfDujFrx2BgP4Ch2eXRAKJBQAzEGJpqJqSy4KpjU4WIKxPQ4QyBzym4k63b3BI
 7Mhw==
X-Gm-Message-State: AOJu0Yy5EEydW+eeFi/8LkAAh8AmKydb26K7AXT5wcaPgx9gBpNT7VBl
 X7lz4DRQ8MN2O1iM9eXA1WQz82h9+qrl/jJD+Ob8XWVP9/7IOrFonqXC
X-Gm-Gg: Acq92OHV/3L48VP0403UpBqwFCoIoN17vdQii0+BdJjUnrktN7T1cb3iCOIG3ej6TF1
 EOh0XT7Xy0k1izSLcw+zPyhMlifiiza/+BpXZcqXiz3XJoSouOLgjb5tZ9PVrchTR/ccb/bU+uA
 gFEOT9y196V+F6vdgejbaCjQ2/XYXwcAGMlcu5LWDF9K1DeutcDU3orRYJZkaMGynnAJ3b4G/3u
 zD2d4egcbBbk9qUZrW8geOOAkbCFC6Y0H3OSjQBaUvJAn4FsAnwEpCf14HHP/upAeJVSpuGIlOo
 rorwiCCUaHHSQm9MsE9aatEArTeRr/63depupwT1OZVYHhO9xUMUpkUO5gBJFQDeU4cJT3k4nGz
 btoo3efrG6ApIPezgrqBvsMytp2/sfm9OOF7I9ST2oqd/A6in8tL/RmJ1EH/VjOtvNrRjoI52Bm
 qkBIq51jZ1nFDOurTmz7iElkZ4Lop0Fw++VX4CLQbe76pGxmMmx8kezejI9pyCvXKCEY8WzVPim
 lPlbDTbCHcz1mk8TV+DKz64fRFBNI8UycGj2EEMgodhUqJck8ilcA==
X-Received: by 2002:a05:6808:f04:b0:479:e826:ccdd with SMTP id
 5614622812f47-48061aa6a41mr9798024b6e.5.1778445609060; 
 Sun, 10 May 2026 13:40:09 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:37 -0600
Subject: [PATCH v5 07/32] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-7-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x234.google.com
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
index 84d12b77f9..d549994aa2 100644
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



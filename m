Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D10CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgB-00068E-Ac; Sat, 09 May 2026 22:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg9-00067R-Fu
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:01 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtg7-0002wt-Rz
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:01 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-694891f8f75so1866637eaf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379238; x=1778984038; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kXG9bIpf2vehciJOosSGn1ALlxlG293W6jH4Q8Jdd3k=;
 b=RlTUXhhFLn+UnwPXrLikA4OjcbOz8mAlW+r2f8ax2N8hFjoMfT+KUmv0bTqqZgjv6r
 xdDpn3oFlFMMLWHi2avMvFBshD9Y6vgX6O6EdBJ1SNxhaa+DNAhjx+lCI5TQI9MLv1RS
 DJGlk+bDOu85P/QKzXpXi+JZ3noN/YJzOmDi7Y0fzsClOhSJn+0eaNE1AUXt25OoENTo
 SEcgx/pjyCht/csRxUf0HBrHcFSatxZWvIZsOcocZUg0VGmpZKMd4vrbdFMn7JrdcyuJ
 E8P+tdE5ljvEHHsli1pCmAbzK6DtbH2Sm+qJ3ByxXbmojugvwvvPjZ/z9wBTmpEhmrQE
 Yi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379238; x=1778984038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kXG9bIpf2vehciJOosSGn1ALlxlG293W6jH4Q8Jdd3k=;
 b=m3TP4keEpVN6QhZHAIGXifB3zTYxlQKM1j0f+kMu2nGSP/Wpf5YsEug21Jm3rMLtMk
 RUI70WWD9pq1Zcgx8YxYSGeAOrxmvloKrUHZKe/w6woVH28QHZjI2He2poXFXB4CDlbU
 Qx2K1KQv8E0WrXnID9yoAArqNNPPT6OJCkImRhLLkQpge4J3u3i3O4gefDz0BTSNJ+Wu
 qXJrZnz3HkbFhPWMui/2OTyzp9rot4ECc/MguZSorqbTbTQNn2jeWFF/u4b6S+Ib5Rz1
 HBFVE6e0y+6vh2edg8gxGg/zeHEo2dbrPxd0dR3urKvQOTH0m1xjGMDs1/IZJnSA6zhM
 Z+bA==
X-Gm-Message-State: AOJu0YyOv2HXU2Jgeb8JKfY63U9s9LL5b/vdyzfDVBHd5lLbHvJo/I6i
 tgeuTRByJdQOkUOIdqLEOzhJKxuz/5vjR4zcxnO5CQatgTYYR+k//R3oR9t5Xwbu
X-Gm-Gg: Acq92OGMKdIO4krJRdPc7VN7XKyuEHPFJVez31bXYNAy5u97IA9WxVM9QOsH5cT/e2u
 4NZYYoVqSLwI3VFx0vv6gbCFUOaDUWBypW1gd1xQjAZYl1+Jn/yGca0RCRYkmHZp2rGx6AA2/pi
 YtyaBoK6lWvjAGLBxhly3Jyww53deE52aDVxd+0RPEpuEvJs2KWx9jBDeo0v0QJXFEELPetHN0s
 J5PaQLcVaekPM8jLAbH19mbofnHbek2BI/uW8ogiyDUeeg02RILom4dwAwDGe8d4rKXlBZnk9jH
 dqEde4uxrbkY604dC1qWT47OIImBiYjneP2BMt+571M9KcyIlgdhsVpagvn1n9Eh6pOGHW00tAZ
 KnH83NrjHzGQ7qFSV0cgseYE34Nfo03N+hP4dSJV5WepL4kxIqz2c7SYCAXPeB+bu8Zeg+UxH9+
 YJeM9GU7oxqCXgXgzY9zc5ntqxVl8Azl6/RbWQcVk9dQlw4dp+WU93GvPJ0xZFopYd0lpSu2wTX
 Wbdw/QCPP1B/l/m8B4cjSrZtFF+ZRqVYMNtisw2eurgnnEuBvesoBsgYnRrcPtUJpHV
X-Received: by 2002:a4a:ee19:0:b0:696:6585:a4b with SMTP id
 006d021491bc7-69998c83817mr10837616eaf.5.1778379238377; 
 Sat, 09 May 2026 19:13:58 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:13:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:30 -0600
Subject: [PATCH v4 07/32] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-7-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



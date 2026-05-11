Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D985CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI5-0005Ia-N4; Mon, 11 May 2026 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHS-0004iN-1P
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHQ-0002gB-8L
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:01 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dca4debedaso4600330a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523778; x=1779128578; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rZs1QwMgMBOIZ7x0GopuMPx3PhSKBhRZ0iB31cIY3R0=;
 b=VQLOBo3x1ek6qhuZEq5ou4d/wubrc4AAxAq85vahfYISCdNNmzRneFSaETnjhxJTp6
 /Q4fu2K/iwJvU/FoMvxlR9SNeC1VYSxPJWLsxuTjPi0iKI7Wn8D8v/LvjfgI2JULdBWb
 47RsBS9EApoRsIgIMP8icCf/mRxcaQzKh7kKB/YpUqkBV6tjNV2a4eohI0e4tSE8MFDj
 /x/Sbg9rSDfCUvFz83pnXT+U3ERm+rSWWzMQaaqjqUslAgxNyrle7tv5J5biCn1N+3vZ
 wQIdEFJlIzWT7l2aXMp5GDUPafBGH8kOPOBe5X12XIIeLfGlQOc3TkVKVnzCfONz2AaF
 cdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523778; x=1779128578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rZs1QwMgMBOIZ7x0GopuMPx3PhSKBhRZ0iB31cIY3R0=;
 b=HPmhEYTTT1s9dOkYlEIIkuIDV+5XpdBI+T/xMtv38xFhu3YCDvtdn04v9xQ4FrLWAQ
 ATQZOhaW7mlTgNa9s272x+/2iV7gKz7YBFvRP03fYYrlUMS65KhqcWOR/Egjfu4b42b9
 DuA0VcVgemoxk1Kk/074DNY3mcN9+FPJygp8Xh3Cz/0em7IxJT/Vcv/LL4bEovldGADV
 PwPa/kz6rLVSDrmjy6JSyWugRfDYNan7b94dIbY/ra8hBbAHZy53fQA3rzI9Rory0bq5
 kzqtPYjQE9y0o8kEQwPzRXUHOYBesM6h6IiU4+4oT88FjeYMl98WPjPiAYyDmJdKnjyZ
 XXFw==
X-Gm-Message-State: AOJu0YxPnM/SS570Nn1df6xIPY2AmlHwNsLF9+KYW8n77VX1Y/4CeCIP
 MvNthmD1D2L3JnhK0VXhZHQVJ50qJT73j1hRyNgfGxolTu7EwyrTOl5S
X-Gm-Gg: Acq92OEkfZ/TIkdLKdbnw0POMcR6QwbybzoCME5J1fpmRP9f865ca3aGD2RK6U/6Bgm
 75rYBnKNXomh38cvhjQgk8xueqsv8eTz/H4DewzOyjkpC0gp3FmOMPuOi1R+/qwL4T80Xp256pJ
 8K0zJMAJ8A18vBxs/5kla6nb6CrnKv7yROX4UF1yYH1PEJKIWSp0ojf8hg6bBvhL+LSqNFEhKAe
 pD7R3G/m0sFUpPT3RR0F57GdyxkaPe2Vbtu1nJj843lmD9gMFEuB9ltFGbu6OBCj2P8s6JP6iFi
 Jj4er3UJ4wffjOoMBnJLqQ4CiEO6lXnIV+0daXgYJoDPrUg0+EBVW9RTXdko4jE+qw2vCsvM+1n
 MBfAmQn8vwSnuw5sZGVP/bnEsJw+uwykw/3QF1+DsZmRQroumhddBOXO2FYxl0UY4cvi0JEbglj
 aBFIcmcW+AB2ned7Ms5dzzzI2e/B+U2BZSBAVoZRveXyopgojLNdRE5A3/s05ZQdaSUQTpMTavu
 p5iZxCws8SqB2nUVmlh2gB9LJqtv+DeDB3OLjWCZuk4jVH15TqwK2uNJae98933Wj6a
X-Received: by 2002:a05:6830:6684:b0:7e3:7dcf:9d3f with SMTP id
 46e09a7af769-7e3820e58f5mr7503012a34.16.1778523778055; 
 Mon, 11 May 2026 11:22:58 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:57 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:38 -0600
Subject: [PATCH v6 07/35] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-7-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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



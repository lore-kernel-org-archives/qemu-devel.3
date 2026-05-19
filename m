Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1C1CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDr-0006p2-II; Tue, 19 May 2026 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDo-0006mY-BM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:08 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDl-0000nW-SH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:08 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-408778a8ec4so2314170fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207784; x=1779812584; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mFjqFege3N5MhFTYwu2Vh6X/u9SKjNii2bEMV2Iaks=;
 b=Lx4C6IzXlCayZC6t2YSioyraFni5+865lW2bwbcTGZc5NezTvIYmAGquV0hmgR9V3z
 b4E9U6B9na6hZIRxVhD3OhgfD4NBbdUMi2Leu7CN9CQF3BDrib6X7kv60FA+bcX4Tv2/
 L6gqXg9+Tc/6SFmb9IYVQZ4BG9r/9YwJ4O0Y4xNjFvBnboUF0weV7Ve9chhrRt2E6qcK
 raKCj6nyHcPepk7b7MMvmpIwEaC4OXxmG7EBq5Xfli6Nf+/Y6PyE+1w0ofLp7RkRt+HO
 RtP0bOSsDBmqFv2DKCzIuLamOiD+Ef6VpIaBH7cbKbmfUjxCpAgvOddCfBy9Czn31WLi
 ESrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207784; x=1779812584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mFjqFege3N5MhFTYwu2Vh6X/u9SKjNii2bEMV2Iaks=;
 b=hVsCdBVqMtSq3rAHrjilqUj/SQzJBG/kkEOjOprePmpQiU5ZA2vv8tW0dcuPs2f4iC
 uoDtLJrAO2cH57aUBaQRa8PsU+cI7JLt92fws+6Ou7JPBSBfe+sufHAOUFrycrFAgYcT
 4vz3dajT3gEEmihvcSEgnpgl9V92OhieKNQV+b82Lrcn7siMq6klhjiSbf/gAnK7OZjg
 rygRdi2UL6AVZ4JzYTRQJqz8thss9/mHC+KgBU8HkhdnqUSpGCEMRi8Cwp/VMRYbkIjq
 SAV9B0/j1AMuWs3YwKL/FiSszYIDrevBLhJAvhCi2BS/Bu8YfG+T699rZdSitPlZeFbt
 lHJw==
X-Gm-Message-State: AOJu0YyBcaYm3zgpZTC5tNuEktUQqbhSFRcH6mtOXZPNYRMheopb6XnE
 91InkaxZyHA0ijZzSh0CWf6uJCTy6j2/qt4eca/z6ihKqfmGjhljPY1H
X-Gm-Gg: Acq92OG66ZhuLz0IOkPiS0713nhkwBnuWI+Uu4mkTdMpb3Kacc9wIgP5xSn44sAe8AJ
 f+FyziTLDrM7T9oCtdUm99ysJEFgs6tAP7bRu/5wxGgZ9494KrxStNhVtknR0XF4yZOLdq7oPor
 6jG2bB5qT+ntPugzRqpPnm/jAAdhCQe3D6nLMNPVCG63Fcj/lNh/uFdv5hc3UrxUz2kCht9l7mR
 4Yi2rHGT/s/ijQIzRTInKrc44+otg804l955STZWXyxifPV5azCASqduczmeTeCR3fxbTM5MiYq
 V8cKiz0UArCRn/q1Iz5yO73PgnpIq+65WIhiXdWYy0f+zCOnGBf1pEG4cf9M5YXON66SReB1RAd
 CNuZ8SScmSd0TIovDTrM9/JJCcX2bf3gQ2K1kVyd9jmx37f6TvqCAs2q76u3DVXxI+XvJI3r55r
 6E3vyrB9o6LJl4OWYe858MN9lzjMM/v/TeswVMgBiGc5O5KTA71W4gR/i8OI6/4G7bXdbjK29ei
 GpzUPCczjHNnM+84oleaymiAZ7cZAtsJz7GTegXUr1R5qalYxt25TmAmGbTXcx4HU2/
X-Received: by 2002:a05:687c:408c:b0:42c:1e4a:8e28 with SMTP id
 586e51a60fabf-43a2da2a5e5mr13511840fac.12.1779207784518; 
 Tue, 19 May 2026 09:23:04 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:31 -0600
Subject: [PATCH v9 29/40] target/mips: add Octeon ZUC COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-29-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2b.google.com
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

Add the Octeon ZUC START and MORE helper operations and model the shared
state window used by the hardware interface. This covers the keystream
and MAC engine state, including the save-and-restore view that overlaps
the HSH/SHA3 bank.

Shared-window writes also update the SHA512/SHA3 backing state so guests
can switch between engines without stale register contents.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split ZUC selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation ZUC helpers.
  - Use helper-local selector constants for shared-window position logic.
  - Add matching helper.h declarations with the helper implementation.

Changes v1 -> v2:
  - Add shared-window selector predicates and assert on unreachable ZUC
    selector switches.  (suggested by Philippe Mathieu-Daudé)
  - Preserve aliased HSH/SHA3/SHA512 backing state during ZUC
    shared-window writes.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Use the manual-aligned HSH_DATW field and shared HSH window helper
    names introduced by the COP2 crypto core patch.
---
 target/mips/cpu.h               |   5 +
 target/mips/helper.h            |   2 +
 target/mips/system/machine.c    |   4 +
 target/mips/tcg/octeon_crypto.c | 324 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 335 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a061a86658..b57a7a0584 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -541,6 +541,7 @@ typedef enum MIPSOcteonSharedMode {
     OCTEON_SHARED_MODE_NONE = 0,
     OCTEON_SHARED_MODE_SHA512,
     OCTEON_SHARED_MODE_SNOW3G,
+    OCTEON_SHARED_MODE_ZUC,
     OCTEON_SHARED_MODE_SHA3,
 } MIPSOcteonSharedMode;
 
@@ -572,6 +573,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t snow3g_fsm[3];
     uint32_t snow3g_lfsr[16];
     uint64_t snow3g_result;
+    uint32_t zuc_fsm[2];
+    uint32_t zuc_lfsr[16];
+    uint32_t zuc_window[3];
+    uint32_t zuc_tresult;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index c0aa361ad8..3e6025b7de 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -62,6 +62,8 @@ DEF_HELPER_2(octeon_cp2_mt_sha3_xordat15, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_xordat16, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_xordat17, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_startop, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index e6336534f4..9bcb066245 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -312,6 +312,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_fsm, MIPSCPU, 3),
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_lfsr, MIPSCPU, 16),
         VMSTATE_UINT64(env.octeon_crypto.snow3g_result, MIPSCPU),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_fsm, MIPSCPU, 2),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_lfsr, MIPSCPU, 16),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_window, MIPSCPU, 3),
+        VMSTATE_UINT32(env.octeon_crypto.zuc_tresult, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index caad685cde..673932ceba 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -270,6 +270,276 @@ static void octeon_store_shared_hsh_window(MIPSOcteonCryptoState *crypto,
         g_assert_not_reached();
     }
 }
+static const uint8_t octeon_zuc_s0[256] = {
+    0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
+    0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
+    0x7b, 0x1b, 0xf9, 0x32, 0xaf, 0x9d, 0x6a, 0xa5,
+    0xb8, 0x2d, 0xfc, 0x1d, 0x08, 0x53, 0x03, 0x90,
+    0x4d, 0x4e, 0x84, 0x99, 0xe4, 0xce, 0xd9, 0x91,
+    0xdd, 0xb6, 0x85, 0x48, 0x8b, 0x29, 0x6e, 0xac,
+    0xcd, 0xc1, 0xf8, 0x1e, 0x73, 0x43, 0x69, 0xc6,
+    0xb5, 0xbd, 0xfd, 0x39, 0x63, 0x20, 0xd4, 0x38,
+    0x76, 0x7d, 0xb2, 0xa7, 0xcf, 0xed, 0x57, 0xc5,
+    0xf3, 0x2c, 0xbb, 0x14, 0x21, 0x06, 0x55, 0x9b,
+    0xe3, 0xef, 0x5e, 0x31, 0x4f, 0x7f, 0x5a, 0xa4,
+    0x0d, 0x82, 0x51, 0x49, 0x5f, 0xba, 0x58, 0x1c,
+    0x4a, 0x16, 0xd5, 0x17, 0xa8, 0x92, 0x24, 0x1f,
+    0x8c, 0xff, 0xd8, 0xae, 0x2e, 0x01, 0xd3, 0xad,
+    0x3b, 0x4b, 0xda, 0x46, 0xeb, 0xc9, 0xde, 0x9a,
+    0x8f, 0x87, 0xd7, 0x3a, 0x80, 0x6f, 0x2f, 0xc8,
+    0xb1, 0xb4, 0x37, 0xf7, 0x0a, 0x22, 0x13, 0x28,
+    0x7c, 0xcc, 0x3c, 0x89, 0xc7, 0xc3, 0x96, 0x56,
+    0x07, 0xbf, 0x7e, 0xf0, 0x0b, 0x2b, 0x97, 0x52,
+    0x35, 0x41, 0x79, 0x61, 0xa6, 0x4c, 0x10, 0xfe,
+    0xbc, 0x26, 0x95, 0x88, 0x8a, 0xb0, 0xa3, 0xfb,
+    0xc0, 0x18, 0x94, 0xf2, 0xe1, 0xe5, 0xe9, 0x5d,
+    0xd0, 0xdc, 0x11, 0x66, 0x64, 0x5c, 0xec, 0x59,
+    0x42, 0x75, 0x12, 0xf5, 0x74, 0x9c, 0xaa, 0x23,
+    0x0e, 0x86, 0xab, 0xbe, 0x2a, 0x02, 0xe7, 0x67,
+    0xe6, 0x44, 0xa2, 0x6c, 0xc2, 0x93, 0x9f, 0xf1,
+    0xf6, 0xfa, 0x36, 0xd2, 0x50, 0x68, 0x9e, 0x62,
+    0x71, 0x15, 0x3d, 0xd6, 0x40, 0xc4, 0xe2, 0x0f,
+    0x8e, 0x83, 0x77, 0x6b, 0x25, 0x05, 0x3f, 0x0c,
+    0x30, 0xea, 0x70, 0xb7, 0xa1, 0xe8, 0xa9, 0x65,
+    0x8d, 0x27, 0x1a, 0xdb, 0x81, 0xb3, 0xa0, 0xf4,
+    0x45, 0x7a, 0x19, 0xdf, 0xee, 0x78, 0x34, 0x60,
+};
+
+static const uint8_t octeon_zuc_s1[256] = {
+    0x55, 0xc2, 0x63, 0x71, 0x3b, 0xc8, 0x47, 0x86,
+    0x9f, 0x3c, 0xda, 0x5b, 0x29, 0xaa, 0xfd, 0x77,
+    0x8c, 0xc5, 0x94, 0x0c, 0xa6, 0x1a, 0x13, 0x00,
+    0xe3, 0xa8, 0x16, 0x72, 0x40, 0xf9, 0xf8, 0x42,
+    0x44, 0x26, 0x68, 0x96, 0x81, 0xd9, 0x45, 0x3e,
+    0x10, 0x76, 0xc6, 0xa7, 0x8b, 0x39, 0x43, 0xe1,
+    0x3a, 0xb5, 0x56, 0x2a, 0xc0, 0x6d, 0xb3, 0x05,
+    0x22, 0x66, 0xbf, 0xdc, 0x0b, 0xfa, 0x62, 0x48,
+    0xdd, 0x20, 0x11, 0x06, 0x36, 0xc9, 0xc1, 0xcf,
+    0xf6, 0x27, 0x52, 0xbb, 0x69, 0xf5, 0xd4, 0x87,
+    0x7f, 0x84, 0x4c, 0xd2, 0x9c, 0x57, 0xa4, 0xbc,
+    0x4f, 0x9a, 0xdf, 0xfe, 0xd6, 0x8d, 0x7a, 0xeb,
+    0x2b, 0x53, 0xd8, 0x5c, 0xa1, 0x14, 0x17, 0xfb,
+    0x23, 0xd5, 0x7d, 0x30, 0x67, 0x73, 0x08, 0x09,
+    0xee, 0xb7, 0x70, 0x3f, 0x61, 0xb2, 0x19, 0x8e,
+    0x4e, 0xe5, 0x4b, 0x93, 0x8f, 0x5d, 0xdb, 0xa9,
+    0xad, 0xf1, 0xae, 0x2e, 0xcb, 0x0d, 0xfc, 0xf4,
+    0x2d, 0x46, 0x6e, 0x1d, 0x97, 0xe8, 0xd1, 0xe9,
+    0x4d, 0x37, 0xa5, 0x75, 0x5e, 0x83, 0x9e, 0xab,
+    0x82, 0x9d, 0xb9, 0x1c, 0xe0, 0xcd, 0x49, 0x89,
+    0x01, 0xb6, 0xbd, 0x58, 0x24, 0xa2, 0x5f, 0x38,
+    0x78, 0x99, 0x15, 0x90, 0x50, 0xb8, 0x95, 0xe4,
+    0xd0, 0x91, 0xc7, 0xce, 0xed, 0x0f, 0xb4, 0x6f,
+    0xa0, 0xcc, 0xf0, 0x02, 0x4a, 0x79, 0xc3, 0xde,
+    0xa3, 0xef, 0xea, 0x51, 0xe6, 0x6b, 0x18, 0xec,
+    0x1b, 0x2c, 0x80, 0xf7, 0x74, 0xe7, 0xff, 0x21,
+    0x5a, 0x6a, 0x54, 0x1e, 0x41, 0x31, 0x92, 0x35,
+    0xc4, 0x33, 0x07, 0x0a, 0xba, 0x7e, 0x0e, 0x34,
+    0x88, 0xb1, 0x98, 0x7c, 0xf3, 0x3d, 0x60, 0x6c,
+    0x7b, 0xca, 0xd3, 0x1f, 0x32, 0x65, 0x04, 0x28,
+    0x64, 0xbe, 0x85, 0x9b, 0x2f, 0x59, 0x8a, 0xd7,
+    0xb0, 0x25, 0xac, 0xaf, 0x12, 0x03, 0xe2, 0xf2,
+};
+
+static inline uint32_t octeon_zuc_addm(uint32_t a, uint32_t b)
+{
+    uint32_t c = a + b;
+
+    c = (c & 0x7fffffffU) + (c >> 31);
+    return c ? c : 0x7fffffffU;
+}
+
+static inline uint32_t octeon_zuc_mul_by_pow2(uint32_t v, unsigned int shift)
+{
+    return ((v << shift) | (v >> (31 - shift))) & 0x7fffffffU;
+}
+
+static inline uint32_t octeon_zuc_make_u32(uint8_t a, uint8_t b,
+                                           uint8_t c, uint8_t d)
+{
+    return ((uint32_t)a << 24) | ((uint32_t)b << 16) |
+           ((uint32_t)c << 8) | d;
+}
+
+static inline uint64_t octeon_zuc_pack_pair(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
+
+static void octeon_zuc_bit_reorganization(const MIPSOcteonCryptoState *crypto,
+                                          uint32_t x[4])
+{
+    x[0] = ((crypto->zuc_lfsr[15] & 0x7fff8000U) << 1) |
+           (crypto->zuc_lfsr[14] & 0xffffU);
+    x[1] = ((crypto->zuc_lfsr[11] & 0xffffU) << 16) |
+           (crypto->zuc_lfsr[9] >> 15);
+    x[2] = ((crypto->zuc_lfsr[7] & 0xffffU) << 16) |
+           (crypto->zuc_lfsr[5] >> 15);
+    x[3] = ((crypto->zuc_lfsr[2] & 0xffffU) << 16) |
+           (crypto->zuc_lfsr[0] >> 15);
+}
+
+static inline uint32_t octeon_zuc_l1(uint32_t x)
+{
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
+           rol32(x, 18) ^ rol32(x, 24);
+}
+
+static inline uint32_t octeon_zuc_l2(uint32_t x)
+{
+    return x ^ rol32(x, 8) ^ rol32(x, 14) ^
+           rol32(x, 22) ^ rol32(x, 30);
+}
+
+static uint32_t octeon_zuc_f(MIPSOcteonCryptoState *crypto, const uint32_t x[4])
+{
+    uint32_t w = (x[0] ^ crypto->zuc_fsm[0]) + crypto->zuc_fsm[1];
+    uint32_t w1 = crypto->zuc_fsm[0] + x[1];
+    uint32_t w2 = crypto->zuc_fsm[1] ^ x[2];
+    uint32_t u = octeon_zuc_l1((w1 << 16) | (w2 >> 16));
+    uint32_t v = octeon_zuc_l2((w2 << 16) | (w1 >> 16));
+
+    crypto->zuc_fsm[0] = octeon_zuc_make_u32(octeon_zuc_s0[u >> 24],
+                                             octeon_zuc_s1[(uint8_t)(u >> 16)],
+                                             octeon_zuc_s0[(uint8_t)(u >> 8)],
+                                             octeon_zuc_s1[(uint8_t)u]);
+    crypto->zuc_fsm[1] = octeon_zuc_make_u32(octeon_zuc_s0[v >> 24],
+                                             octeon_zuc_s1[(uint8_t)(v >> 16)],
+                                             octeon_zuc_s0[(uint8_t)(v >> 8)],
+                                             octeon_zuc_s1[(uint8_t)v]);
+    return w;
+}
+
+static void octeon_zuc_lfsr_step(MIPSOcteonCryptoState *crypto,
+                                 bool init_mode, uint32_t u)
+{
+    uint32_t f = crypto->zuc_lfsr[0];
+
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(crypto->zuc_lfsr[0], 8));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(crypto->zuc_lfsr[4], 20));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(crypto->zuc_lfsr[10], 21));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(crypto->zuc_lfsr[13], 17));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(crypto->zuc_lfsr[15], 15));
+    if (init_mode) {
+        f = octeon_zuc_addm(f, u);
+    }
+
+    memmove(&crypto->zuc_lfsr[0], &crypto->zuc_lfsr[1],
+            15 * sizeof(crypto->zuc_lfsr[0]));
+    crypto->zuc_lfsr[15] = f;
+}
+
+static uint32_t octeon_zuc_generate_word(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t x[4];
+    uint32_t z;
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    z = octeon_zuc_f(crypto, x) ^ x[3];
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    return z;
+}
+
+static void octeon_zuc_fill_window(MIPSOcteonCryptoState *crypto)
+{
+    crypto->zuc_window[0] = octeon_zuc_generate_word(crypto);
+    crypto->zuc_window[1] = octeon_zuc_generate_word(crypto);
+    crypto->zuc_window[2] = octeon_zuc_generate_word(crypto);
+}
+
+static inline uint32_t
+octeon_zuc_window_word(const MIPSOcteonCryptoState *crypto, unsigned int bit)
+{
+    if (bit == 0) {
+        return crypto->zuc_window[0];
+    }
+    if (bit < 32) {
+        return (crypto->zuc_window[0] << bit) |
+               (crypto->zuc_window[1] >> (32 - bit));
+    }
+    if (bit == 32) {
+        return crypto->zuc_window[1];
+    }
+    return (crypto->zuc_window[1] << (bit - 32)) |
+           (crypto->zuc_window[2] >> (64 - bit));
+}
+
+static void octeon_zuc_advance_window(MIPSOcteonCryptoState *crypto)
+{
+    crypto->zuc_window[0] = crypto->zuc_window[2];
+    crypto->zuc_window[1] = octeon_zuc_generate_word(crypto);
+    crypto->zuc_window[2] = octeon_zuc_generate_word(crypto);
+}
+
+static void octeon_zuc_start(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t x[4];
+    bool restore_active = crypto->shared_mode == OCTEON_SHARED_MODE_ZUC;
+
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_ZUC);
+    if (!restore_active) {
+        for (int i = 0; i < 7; i++) {
+            uint64_t pair = crypto->hsh_datw[i];
+
+            crypto->zuc_lfsr[i * 2] = (pair >> 32) & 0x7fffffffU;
+            crypto->zuc_lfsr[i * 2 + 1] = pair & 0x7fffffffU;
+        }
+    }
+    crypto->zuc_lfsr[14] = (data >> 32) & 0x7fffffffU;
+    crypto->zuc_lfsr[15] = data & 0x7fffffffU;
+    crypto->zuc_fsm[0] = 0;
+    crypto->zuc_fsm[1] = 0;
+    crypto->zuc_tresult = 0;
+
+    for (int i = 0; i < 32; i++) {
+        octeon_zuc_bit_reorganization(crypto, x);
+        octeon_zuc_lfsr_step(crypto, true, octeon_zuc_f(crypto, x) >> 1);
+    }
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    (void)octeon_zuc_f(crypto, x);
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    octeon_zuc_fill_window(crypto);
+}
+
+static void octeon_zuc_more(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t t = crypto->zuc_tresult;
+
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_ZUC);
+    for (unsigned int bit = 0; bit < 64; bit++) {
+        if ((data >> (63 - bit)) & 1) {
+            t ^= octeon_zuc_window_word(crypto, bit);
+        }
+    }
+    crypto->zuc_tresult = t;
+    octeon_zuc_advance_window(crypto);
+}
+
+static bool octeon_zuc_is_shared_dmfc2_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_HSH_DATW(0) ... OCTEON_HSH_DATW(11):
+    case OCTEON_HSH_IVW(0) ... OCTEON_HSH_IVW(3):
+    case OCTEON_SHA3_DAT15_MF_SEL:
+    case OCTEON_SHA3_DAT24_SEL:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool octeon_zuc_is_shared_dmtc2_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_HSH_DATW(0) ... OCTEON_HSH_DATW(11):
+    case OCTEON_HSH_IVW(0) ... OCTEON_HSH_IVW(3):
+    case OCTEON_SHA3_DAT15_MT_SEL:
+    case OCTEON_SHA3_DAT24_SEL:
+        return true;
+    default:
+        return false;
+    }
+}
 static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
                            uint16_t poly, uint64_t out[2])
 {
@@ -316,6 +586,51 @@ uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
+static bool octeon_zuc_store_shared(MIPSOcteonCryptoState *crypto,
+                                    uint32_t sel, uint64_t value)
+{
+    if (crypto->shared_mode != OCTEON_SHARED_MODE_ZUC ||
+        !octeon_zuc_is_shared_dmtc2_sel(sel)) {
+        return false;
+    }
+
+    octeon_store_shared_hsh_window(crypto, sel, value);
+    if (sel >= OCTEON_HSH_DATW(0) &&
+        sel <= OCTEON_HSH_DATW(7)) {
+        unsigned int idx = sel - OCTEON_HSH_DATW(0);
+
+        crypto->zuc_lfsr[idx * 2] = (value >> 32) & 0x7fffffffU;
+        crypto->zuc_lfsr[idx * 2 + 1] = value & 0x7fffffffU;
+        return true;
+    }
+
+    switch (sel) {
+    case OCTEON_HSH_DATW(8):
+        crypto->zuc_fsm[0] = value >> 32;
+        crypto->zuc_fsm[1] = value;
+        return true;
+    case OCTEON_HSH_DATW(9):
+    case OCTEON_HSH_IVW(0):
+        crypto->zuc_window[0] = value >> 32;
+        crypto->zuc_window[1] = value;
+        return true;
+    case OCTEON_HSH_DATW(10):
+        crypto->zuc_window[2] = value;
+        return true;
+    case OCTEON_HSH_DATW(11):
+    case OCTEON_HSH_IVW(3):
+        crypto->zuc_tresult = value;
+        return true;
+    case OCTEON_HSH_IVW(1):
+        crypto->zuc_fsm[0] = value;
+        return true;
+    case OCTEON_HSH_IVW(2):
+        crypto->zuc_fsm[1] = value;
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
 static void octeon_sha3_mt_dat(MIPSOcteonCryptoState *crypto,
                                uint32_t sel, uint64_t value)
 {
@@ -404,6 +719,15 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     }
     crypto->gfm_xor0 = 0;
 }
+void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_more(&env->octeon_crypto, value);
+}
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {

-- 
2.54.0



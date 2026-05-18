Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29409CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ7-0000IK-Kc; Mon, 18 May 2026 01:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYG-0006wH-Tu
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:07 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0003XX-Hq
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:01 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-484ba8bc89eso932709b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082193; x=1779686993; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fPPFP163T+q5lC948cLqU0ulm2f9SH9fBmHw75TDRwc=;
 b=ik/bc6f7phJuloSiEqJGqc4PlryPVlVXnvMfWyTJlJGDVLiEj/HgLGC+xXx0V8Q3An
 t0INBuc1+rWoAHlmGjM/OBJvAOI/Dfh1SH9EEtd2VuXYTGyuAfebtgF6SCkUqTb4jAD3
 LTnMzGtGVyv1RNXyzXr6eNJ4ND2iolbVWQwykiEOXnaSPbg0i69L22XVQvkFrBlXAjQR
 +wLZG7v0vMGX/RwnBrqwYCXwT4MlZrZNsRZs24dPs/zNcLyIcP0WdBGKad6yKBRL4OVX
 4I7mMgkSBeiF4dDVaNEMLorR88JA3Sq3Csv1k8FxFXPhBegoBoZbKajcVjocTXFmnfEA
 hvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082193; x=1779686993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fPPFP163T+q5lC948cLqU0ulm2f9SH9fBmHw75TDRwc=;
 b=mkerlUcEK2tnfU+0nC7EhxUMVd8tnWTGbqrbCGQsY0WQHwWyvWtY1PRNNZg35fVJ6k
 7VSSQ5XfrKN91lXpCnKKTsZAyd7No/ZZxOU/IHpn22NGdUc+0jgdL9o2zmV0QQTFNSJx
 lKculwyENjXjOpwSPj3w2Burw3k2z6ro+BFimXGCJUIEqbm8pbASla8cpTj7LB9n55UW
 K1agWkcIGDlxqSS2r9wm/DWm7SA17IDPg/hYJnEosWGLJTrGRJxcqX37HjX7qnSfKWwf
 03tge2nnD5dlmZL4jAM2WHbNUTp5nPgZn2roV//WYAO/XiyYX48K9yKGPsEBfgkFBa51
 RDMg==
X-Gm-Message-State: AOJu0YyeJbMdrPGlLqkKpA0wtsHcqeNXuoJ6YTBNnrDRpGJ47gEcopS3
 FqRi1P/DDG3opVY4btBicf/lsqQb52bdPc07sM9x5MLvHByetB8iVVYa
X-Gm-Gg: Acq92OHHjUk0TQklQe5T9gfaHtzwBcSksyCGkFTwRqu+Wq+DfeUwwbUc8J4CqFmhDZS
 q+I0kSg7yJn1KJcjJhjwwBJzC1LOdDZEnJ/LMVjPSwMaFsYFiA8XUySyY70YXc5MboEIdSa++5N
 5EbtyvMBJQ9flBrlq3mMxxCOQ48qE6WYjBZPU8s6my/6YPmIdPs0KmfeX1c4Ha+HlQeCo+r8Zst
 PQvHLfK1jriEnoGpB7DEyczwrAA3xSzIBWMtFC4rMup3ca0G9S3d+PzTT14AuF10zCxS353CHEO
 F96z7e6SiPlHmJnAaVtdt4NLbEjKLWccETvo/MOnEkRHuBr337f7LUiLPSH1bX/FaTxyHCcD15q
 zLwOxcDB9wKGqUmX9GcfySGawifLj/9dXp9NhBq52U5BqJWW7VI/06Vc+mIcGeZUpu/cCHFvtaC
 u8Sxdzl4kWcqX1zXatfQBfNdbSE10riQ1ZJkXLTU+K9Gt1Q2TB4XAIS4LaTJbb6/5eDUMeDgyxQ
 8i8ZNshsPtMuxiv0JSQWHtLJW2i5ziaAiOMziXKa6rgUbpGZuODhu3v2loA7FQqlPibbpjo6QQR
 HvAxhw==
X-Received: by 2002:a05:6808:6509:b0:467:281e:3d85 with SMTP id
 5614622812f47-482e572c63amr8503916b6e.29.1779082193573; 
 Sun, 17 May 2026 22:29:53 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:25 -0600
Subject: [PATCH v8 28/35] target/mips: add Octeon ZUC crypto support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-28-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x231.google.com
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

Add the Octeon ZUC START and MORE selectors and model the shared state
window used by the hardware interface.

This covers the keystream and MAC engine state, including the
save-and-restore view that overlaps the HSH/SHA3 bank. Shared-window
writes also update the SHA512/SHA3 backing state so guests can switch
between engines without stale register contents.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
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
 target/mips/cpu.h               |   7 +
 target/mips/system/machine.c    |   4 +
 target/mips/tcg/octeon_crypto.c | 353 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 364 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 65c11b2072..0b16382dd3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -541,6 +541,7 @@ typedef enum MIPSOcteonSharedMode {
     OCTEON_SHARED_MODE_NONE = 0,
     OCTEON_SHARED_MODE_SHA512,
     OCTEON_SHARED_MODE_SNOW3G,
+    OCTEON_SHARED_MODE_ZUC,
     OCTEON_SHARED_MODE_SHA3,
 } MIPSOcteonSharedMode;
 
@@ -704,6 +705,8 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SNOW3G_MORE = 0x404e,
     OCTEON_COP2_SEL_HSH_STARTSHA256 = 0x404f,
     OCTEON_COP2_SEL_SHA3_STARTOP = 0x4052,
+    OCTEON_COP2_SEL_ZUC_START = 0x4055,
+    OCTEON_COP2_SEL_ZUC_MORE = 0x4056,
     OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT = 0x405d,
     OCTEON_COP2_SEL_HSH_STARTSHA = 0x4057,
     OCTEON_COP2_SEL_HSH_STARTSHA512 = 0x424f,
@@ -738,6 +741,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t snow3g_fsm[3];
     uint32_t snow3g_lfsr[16];
     uint64_t snow3g_result;
+    uint32_t zuc_fsm[2];
+    uint32_t zuc_lfsr[16];
+    uint32_t zuc_window[3];
+    uint32_t zuc_tresult;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
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
index 42e68f4205..30df901e6b 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -631,6 +631,277 @@ static int octeon_sha3_xordat_pos_from_sel(uint32_t sel)
     return -1;
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
+    case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW11:
+    case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW3:
+    case OCTEON_COP2_SEL_SHA3_DAT15_MF:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static bool octeon_zuc_is_shared_dmtc2_sel(uint32_t sel)
+{
+    switch (sel) {
+    case OCTEON_COP2_SEL_HSH_DATW0 ... OCTEON_COP2_SEL_HSH_DATW11:
+    case OCTEON_COP2_SEL_HSH_IVW0 ... OCTEON_COP2_SEL_HSH_IVW3:
+    case OCTEON_COP2_SEL_SHA3_DAT15_MT:
+    case OCTEON_COP2_SEL_SHA3_DAT24:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static const uint8_t octeon_snow3g_sr[256] = {
     0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
     0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
@@ -1527,6 +1798,39 @@ uint64_t helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
     int sha3_pos;
 
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC &&
+        octeon_zuc_is_shared_dmfc2_sel(sel)) {
+        if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
+            sel <= OCTEON_COP2_SEL_HSH_DATW7) {
+            unsigned int idx = sel - OCTEON_COP2_SEL_HSH_DATW0;
+
+            return octeon_zuc_pack_pair(crypto->zuc_lfsr[idx * 2],
+                                        crypto->zuc_lfsr[idx * 2 + 1]);
+        }
+        switch (sel) {
+        case OCTEON_COP2_SEL_HSH_DATW8:
+            return octeon_zuc_pack_pair(crypto->zuc_fsm[0], crypto->zuc_fsm[1]);
+        case OCTEON_COP2_SEL_HSH_DATW9:
+        case OCTEON_COP2_SEL_HSH_IVW0:
+            return octeon_zuc_pack_pair(crypto->zuc_window[0],
+                                        crypto->zuc_window[1]);
+        case OCTEON_COP2_SEL_HSH_DATW10:
+            return crypto->zuc_window[2];
+        case OCTEON_COP2_SEL_HSH_DATW11:
+        case OCTEON_COP2_SEL_HSH_IVW3:
+            return crypto->zuc_tresult;
+        case OCTEON_COP2_SEL_SHA3_DAT15_MF:
+        case OCTEON_COP2_SEL_SHA3_DAT24:
+            return 0;
+        case OCTEON_COP2_SEL_HSH_IVW1:
+            return crypto->zuc_fsm[0];
+        case OCTEON_COP2_SEL_HSH_IVW2:
+            return crypto->zuc_fsm[1];
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     if (crypto->shared_mode == OCTEON_SHARED_MODE_SNOW3G) {
         if (sel >= OCTEON_COP2_SEL_SNOW3G_LFSR0 &&
             sel <= OCTEON_COP2_SEL_SNOW3G_LFSR7) {
@@ -1645,6 +1949,49 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
     uint64_t data = value;
     int sha3_pos;
 
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC &&
+        octeon_zuc_is_shared_dmtc2_sel(sel)) {
+        octeon_store_shared_hsh_window(crypto, sel, data);
+
+        if (sel >= OCTEON_COP2_SEL_HSH_DATW0 &&
+            sel <= OCTEON_COP2_SEL_HSH_DATW7) {
+            unsigned int idx = sel - OCTEON_COP2_SEL_HSH_DATW0;
+
+            crypto->zuc_lfsr[idx * 2] = (data >> 32) & 0x7fffffffU;
+            crypto->zuc_lfsr[idx * 2 + 1] = data & 0x7fffffffU;
+            return;
+        }
+        switch (sel) {
+        case OCTEON_COP2_SEL_HSH_DATW8:
+            crypto->zuc_fsm[0] = data >> 32;
+            crypto->zuc_fsm[1] = data;
+            return;
+        case OCTEON_COP2_SEL_HSH_DATW9:
+        case OCTEON_COP2_SEL_HSH_IVW0:
+            crypto->zuc_window[0] = data >> 32;
+            crypto->zuc_window[1] = data;
+            return;
+        case OCTEON_COP2_SEL_HSH_DATW10:
+            crypto->zuc_window[2] = data;
+            return;
+        case OCTEON_COP2_SEL_HSH_DATW11:
+        case OCTEON_COP2_SEL_HSH_IVW3:
+            crypto->zuc_tresult = data;
+            return;
+        case OCTEON_COP2_SEL_SHA3_DAT15_MT:
+        case OCTEON_COP2_SEL_SHA3_DAT24:
+            return;
+        case OCTEON_COP2_SEL_HSH_IVW1:
+            crypto->zuc_fsm[0] = data;
+            return;
+        case OCTEON_COP2_SEL_HSH_IVW2:
+            crypto->zuc_fsm[1] = data;
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     switch (sel) {
     case OCTEON_COP2_SEL_3DES_KEY0:
     case OCTEON_COP2_SEL_3DES_KEY1:
@@ -1859,6 +2206,12 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
         octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA3);
         octeon_sha3_permute(crypto);
         break;
+    case OCTEON_COP2_SEL_ZUC_START:
+        octeon_zuc_start(crypto, data);
+        break;
+    case OCTEON_COP2_SEL_ZUC_MORE:
+        octeon_zuc_more(crypto, data);
+        break;
     case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
         octeon_gfm_mul_reflect(crypto, data);
         break;

-- 
2.54.0



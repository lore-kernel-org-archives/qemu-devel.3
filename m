Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082AACD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgo-0001Dc-Qz; Wed, 20 May 2026 00:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgm-0001DE-Iq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:48 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgj-0003qK-JI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de7c57b52cso4050342a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251863; x=1779856663; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nr3FxQZz7OKL7DfXK1cm8SMgEzktB58VYgFBPF1B1YA=;
 b=dVlc9eDKHs4qSGZ9RcztO0DLBE6wM6kme1Pm9XBoRekV/3PiqvSv2z5rcC2PXQTJa9
 s3LImC2z+9/+5w3WEktu2JHJ/K3a6mVeczKo1/KqNO9O3W8NrXdvae8VGV0HoOO/z1ID
 7P8ChnFcmwhjeMX8AY1EywrukQ3dawoGTQf/iDzNjphv3Q1tcG74aw1MCaozH5kzb/oY
 awCtfIsREghZfeWC1E6ds0+Q1g5LkRdeozleUyRizuPu/Aeb6pTA0wJV6oiWcRY7dTvb
 5eeyI2CR7og8xSIBCYWIua9QX7zwGFFuzDXmWIuL+RXAtbtjyXTDdjL7ZPqDkSl3a8fp
 H66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251863; x=1779856663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nr3FxQZz7OKL7DfXK1cm8SMgEzktB58VYgFBPF1B1YA=;
 b=Lo4azLiI/aQtm0neC7yN7AKP5Jjl6hJBL6O77Q4hN87GI//V5YdYYw0y6aFnh8+kj/
 aaasT8NlgWBNBn1F4N81PCZZqEqDmEf30dYQkaOx8Y1C7+LmSLQi7EAdUEcnoAeo33yv
 p0Kd3Wy8q8Kgi//3fxkYpy+JiKvbm2w9KjQjpBn/JUxlKf/iCFCtVjHQFsbvZs4WKx7n
 BVGHkVLKDjMw+ID8Ozq/shlctqEhUd0soGrhMdyhzW6zuVyjkn8rqdUG+SLyi7aH/wL3
 o1kYdSSRGjdlIKwk+KwUXIrBaBRBeVioOzifs2L5tsys2xfqO9O11jY/FlbltvjMhoB/
 nWcA==
X-Gm-Message-State: AOJu0YxquVCAlnvyWt1GgotTo7LaNhuyhCkHwn2xTCn6tesGYtt2ovxr
 BiizyS0yeFQ2ypDcAWXhbskEiCS0za0KS5iZIsUo9TvznWfjqj0zmrFx
X-Gm-Gg: Acq92OHlnoZ27hSG8gvCp56XVDEMItU3R7lB0d7XkUto1jwNDaJPvYy/7VU7mM+7Gdx
 CJnD3uhoc7GQn48VGo33DhQPNE/mtrQCKddWIdDBii5OfPVPevh8ME66I1VNJZKDOQC7trE11qm
 QQES2UFO1ghvTRu7velvGN6XNs0eOsKaLlCBSyWxTbxnyr8TlbbWF7hW4awy9w3DoQZZ9JiEzi+
 KGmg3uUP5vbg1g1eos5w0/620G47bTRWHnAtnj5kImwzrVud/XN15Xnh6o6yvE4ar9OcfsFj7Cv
 xCioTW6QHG26Yz3aQRQII/m3f2nh4bEHH033ieFnT5F6X2VqkFv9ycyD/cBWj+vUyCROPjKpZl9
 yDMc8TfOnxSMF41Dfbr+fBecEFrD4saQV4JSofBvq/nghABXjAp6se2G2NjQEE/yk4pgAGwFvax
 qW5FrAkT7YmmSRyeAmwc7rB8/0NeV+P4haMQL9lcDaMpJ9uUp0r6rEvV1u+Dq4dHFoBVRm0uP4j
 ieccJ4FkGki4SXCVA8EZ86BW5pFg9LwHUbIwtJOl8HP3Cvkw+CcftZG67dNli0ggzfzo3N+Pth6
 TDo=
X-Received: by 2002:a05:6830:3812:b0:7e4:230:96ca with SMTP id
 46e09a7af769-7e4fa05a5bfmr17807566a34.21.1779251862977; 
 Tue, 19 May 2026 21:37:42 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:18 -0600
Subject: [PATCH v10 24/45] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-24-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
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

Add the common architectural state needed by Octeon's selector-driven
COP2 crypto interfaces. This includes storage for the base hash, AES,
CRC, GFM, 3DES, KASUMI, and overlapping HSH/SHA512/SHA3/SNOW3G/ZUC
selector windows.

Keep selector values and helper-local aliasing logic out of the CPU state
header so the state definition remains limited to architectural storage.
Helper code uses the same register banks instead of adding
non-architectural shadow state.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models
do not grow migration data.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v9 -> v10:
  - Drop non-architectural shared-mode, AES input/result split, GFM XOR,
    and ZUC/SNOW3G shadow state.
  - Model HSH/SHA512/SHA3/SNOW3G/ZUC overlap with the architectural HSH
    DAT/IV register banks.
  - Store CRCLEN as the architectural 4-bit state.

Changes v8 -> v9:
  - Remove the MIPSOcteonCop2Sel enum; selector values are decoded by
    decodetree or kept local to helper plumbing.
  - Leave only COP2 state and migration data in this patch.

Changes v7 -> v8:
  - Split COP2 crypto state and migration coverage out of the combined
    COP2 crypto core patch.
---
 target/mips/cpu.h            | 23 +++++++++++++++++++++++
 target/mips/system/machine.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..890734556f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,27 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef struct MIPSOcteonCryptoState {
+    uint64_t hsh_dat[16];
+    uint64_t hsh_iv[8];
+    uint64_t sha3_dat24;
+    uint64_t gfm_reflect_mul[2];
+    uint64_t gfm_reflect_resinp[2];
+    uint64_t des3_key[3];
+    uint64_t des3_iv;
+    uint64_t des3_result;
+    uint64_t aes_resinp[2];
+    uint64_t aes_iv[2];
+    uint64_t aes_key[4];
+    uint32_t crc_poly;
+    uint32_t crc_iv;
+    uint64_t gfm_mul[2];
+    uint64_t gfm_resinp[2];
+    uint16_t gfm_poly;
+    uint8_t aes_keylen;
+    uint8_t crc_len;
+} MIPSOcteonCryptoState;
+
 typedef struct CPUArchState {
     TCState active_tc;
     CPUMIPSFPUContext active_fpu;
@@ -558,6 +579,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695b..2447915750 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,34 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_crypto = {
+    .name = "cpu/octeon_crypto",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_iv, MIPSCPU, 8),
+        VMSTATE_UINT64(env.octeon_crypto.sha3_dat24, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.des3_key, MIPSCPU, 3),
+        VMSTATE_UINT64(env.octeon_crypto.des3_iv, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.des3_result, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
+        VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -396,6 +424,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };

-- 
2.54.0



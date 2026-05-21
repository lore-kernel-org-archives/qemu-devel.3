Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944D1CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mx-0000Cb-2M; Thu, 21 May 2026 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mq-00009t-AE
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:24 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mn-00021b-4d
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:23 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479dd56d016so5151587b6e.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386779; x=1779991579; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EILNJa0yUe4vu/jVP2tQvk3t8HMPaGDQ29ybHk5m3Xw=;
 b=qC7b4LWSHU/quphDh+rYf1KgwtgLozwltk5nMEJSrV8BYOikyObK00lXDZIx/558sK
 Ei/zjXLEhZDrB/WDxjZQbpCW2c6OvKVXSfVqMVwmXhEVfTf6YMBOQ8cIaj5K0T56a1Pr
 8gLh8cgBF9XVRep0QQ5osMkdRmzD6FQsPQwfliXyhzrx7ZRzGpBzj7M3BYFqY7u9arCc
 /KCsE144/J2i+YYAyO8FOzATWwKWbUmJnFc/BQRD24TtfJiSC8vwze5wzFDhjOT40wR3
 XH7n3OR1Dkp+vbsZCB7kGSGfI4hfxe92maJoFzcFtz+lQgYlYO6t2A4nvdXTIMc5k1qf
 97bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386779; x=1779991579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EILNJa0yUe4vu/jVP2tQvk3t8HMPaGDQ29ybHk5m3Xw=;
 b=PjGt3eXzrvv2M1/VVx2raG15DoqvNORuLiLTsBrH2A0H7TMMM+Tpeh73V048Ew0TkZ
 8KxpShW04HeLrc3oeKHVKIa/tL/RvxQRP7qe5twfw3QqTrBK+AxzZjaZZaK29SmPgCJq
 aYE9M4OzenuKe2DO4mgSQZf9WvYba5QmbpABh9dCOume0vVCr+FqF6wDQWGcMeYkTXVK
 Vfmn99iaMsxSS+ubk8H4bXfBHyrXoUkiyEFV3aDSEn1DHgktWsPbnTM1SnfDp/ys/9cW
 GunGC87ihhri3kbLBkKLsyonfoCP2Uqf005TKBG+nSSMb3BJAg2020ufa1s268hFk1WB
 WeoQ==
X-Gm-Message-State: AOJu0YwoB0moD8zW4PsV5DF0NYLEJpjFqSC0vBnD3UM/QwTL+wWl/L2Z
 MXg7hYHDIBsLlnF0SQvtRJxNmAHYTa9uR65wcQImcLFdrdbV5q76vRBB
X-Gm-Gg: Acq92OG8w7S1JBeyzH6zDq9Ya4TaZbl2Xa2SbUWkRYHX7VmUXUgLY/2s0Amp9qwhiPt
 IuFBGaP+WBGDkQgWvEHOPfsk4Wx7ayKIkYOhvBIbAMLkwfZ1XWR6jl1CbfB84PhG07sbHuRdX8g
 umBALpnN/OsJJbwTs4eb9/3ABzEMYyRnC0+/0PKxnDbJo6DGOQOy9gROSDVzFJRDr484StU3C4E
 S3PVyL2TFN5v20clQGStR95MDw6lqR6mTaxEdzk5XCKLGGBsYG+CgXh6Z9UXbnHrRNaDS5RIZYd
 H1zUFbP+sNIz5XxM+tLWYakaaykNxgnRsqrRWysbOSyg+LO1nFsFGG3ZhjWvVKLLu7A4O0dIe+T
 1Dr88DPW/KrM+ai7XtrlnfEytqO5bX6k3P+kMY/ThNO331A1wu2T6oeHpOiB993SSk63bxE8MSF
 1GR350jsWL+efAqa+nUp2mws8tGkV41PAjIAFgNCabkK6c9MA0JMt4w9Z6cjHuB8wZQd05lqsar
 wd9pQFWPCkUMIN/nhzjdodYObc4IMUhS7q6NFqT6tq5hIAAKmIGcUVM2FPXOh4uv/sV
X-Received: by 2002:a05:6808:191d:b0:484:d5a3:996c with SMTP id
 5614622812f47-4854a15d51bmr42082b6e.17.1779386779289; 
 Thu, 21 May 2026 11:06:19 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:05:55 -0600
Subject: [PATCH v13 02/22] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-2-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
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
Changes v10 -> v13:
  - Keep reflected GFM selectors mapped onto the architectural GFM state
    from the start instead of adding temporary reflected shadow fields.

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
 target/mips/cpu.h            | 21 +++++++++++++++++++++
 target/mips/system/machine.c | 27 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..2dad7f538f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,25 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef struct MIPSOcteonCryptoState {
+    uint64_t hsh_dat[16];
+    uint64_t hsh_iv[8];
+    uint64_t sha3_dat24;
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
@@ -558,6 +577,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695b..77f576a25b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,32 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
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
@@ -396,6 +422,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };

-- 
2.54.0



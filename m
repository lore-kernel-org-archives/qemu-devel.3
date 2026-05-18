Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD680CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYU-00075a-19; Mon, 18 May 2026 01:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vN-S6
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0003WI-MT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:54 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479d9b155deso467551b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082188; x=1779686988; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ilGgTStdOtbIoqCSNJ0wXDoJ+k3RftoM37IGrsYD1f0=;
 b=YLazoZskt5cOzwLawDpEyyirr8Lo9rLUsEyFtan/03cQrRJ7XUjpW3hKJcfN1SfTkK
 zV/Pcmp9nGsx8cVdgdJcTMm217dZ3TC/Hz7EIoLn/WclxESsy49Li5plpDCilubb20g+
 AciBSS4oAsESKGNDaxCfo3NfA7YizBpHcIJHBB3bOhAVvZjlTu2orfvZlzC4j33tIrzv
 j9GNh3fzXW41WlB7I5NfN+ae76KV09+icNCmraFoRLysH5cVelT471NWuz4JHDAtRenT
 NXpJsuKtzJ/V/MHolrJ6Vvx9X6YlMdMMSJH6x1udTJ9ZuwUaGiG4gOvPdl7kReO3FjUB
 Vntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082188; x=1779686988;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ilGgTStdOtbIoqCSNJ0wXDoJ+k3RftoM37IGrsYD1f0=;
 b=Qzm77YjWtuCOPDvpo3MMK/4sChA1+EhfmE1h9owFPFkdohVa5Amp5jJQUEVTISetsU
 6rEMhI0RaWIS1iG/2X96b5AFOHlZmMg0xqwAbo3l3css+Qm31JimaadwhCWUB9olz3ub
 RgH39FRSgl4nHbifOP00xhxhQozIpLZbo7zYdOBAU/oMzaU6AEbAHwQvvXIU6b9J0SSe
 0Dk6PqsSZuhFKLko3QGc4qMg/SPES50IuYaon04tMBDeolrG/8Mq0FU2ShTMZYRHIutm
 kfVQaXUmy5PW7Hm/lPVZGa0qZUFS5F7YXRzbCRep1ws4AKNWGG/m35GM9ghJ0crhtdgz
 WzyA==
X-Gm-Message-State: AOJu0YydloMUWncG1v5MoiS7crvwQZjcbJFZiflDraAYustZkzj0DmL1
 8SMPAOYw6ekDb3dCtFnI28GwEur3ASpb9dPr6aAeBdSCvFGg+kI6UXel
X-Gm-Gg: Acq92OFXFq0fBxn0khm++IYb4D7u3PtOxK/rr7ybYQ8uAq3drnLTwmyzGs+aFC79iQO
 DScVR0Bnd4IcqpPFE7L88D0OdAeqqMX21lHBC3x0t75mMGkXKJUcrnHk+n54X+QtBTUpnuHntVx
 nlX0TAQ5Z15L7zjaed+7vvnalBKQVbLjXfyrV6CvbsF6YWak0Wbd1BVDJ8TjgTbKNpBXe/X0c3/
 uTSEC3bW2rj5MHusSIPpiim+8VrrUxY1igahH4XQIPHEHxJEyWS52tEo507AtWKVhtqTGpam0v5
 6MfGYYHh4tN8vC+jsI5ZYfGDCML23x7uxQqCIK1J6AC46JRDfAb/D9O1KrCMWY188rD1d2ggYSN
 2Xsglt3J061RU2mob4XzTvk3Rj/ZG7LaW0G3gJaW+l1crs2IVspSd+Bg3X23IE9Ow2tOb+Rqige
 u8HM5v4TwGl8PsoA9MDBu4jOAJQvlRW0row6UUJQoQ/JJ4vJemjcuPjNUg3RrUi8iSujRzftY79
 S8iCHFZWCYkAcG51mWnTKhxmAOq/IA2YsMzBPXWBJCDsw6CYP4Qp9PfTg/cvPLs9hqQgGw=
X-Received: by 2002:a05:6808:320f:b0:466:ff78:138f with SMTP id
 5614622812f47-482e5739928mr8606170b6e.29.1779082188479; 
 Sun, 17 May 2026 22:29:48 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:21 -0600
Subject: [PATCH v8 24/35] target/mips: add Octeon COP2 crypto state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-24-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

Add the common state needed by Octeon's selector-driven COP2 crypto
interfaces. This includes the selector constants and storage for the base
hash, AES, CRC, GFM, 3DES, KASUMI, and SNOW3G engines, plus the shared
selector-window mode used by overlapping hardware register banks.

Describe the shared HSH/SHA512, SHA3, SNOW3G, and ZUC selector window up
front so later engine patches only add their own selectors and state
instead of rewriting common comments.

Migrate the state in an Octeon-only subsection so non-Octeon CPU models do
not grow migration data. Later patches wire helpers and explicit selector
decode on top of this state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v7 -> v8:
  - Split COP2 crypto state and migration coverage out of the combined
    COP2 crypto core patch.
---
 target/mips/cpu.h            | 165 +++++++++++++++++++++++++++++++++++++++++++
 target/mips/system/machine.c |  37 ++++++++++
 2 files changed, 202 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 346713705a..1c552b8134 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -537,6 +537,169 @@ struct TCState {
 };
 
 struct MIPSITUState;
+typedef enum MIPSOcteonSharedMode {
+    OCTEON_SHARED_MODE_NONE = 0,
+    OCTEON_SHARED_MODE_SHA512,
+    OCTEON_SHARED_MODE_SNOW3G,
+} MIPSOcteonSharedMode;
+
+typedef enum MIPSOcteonCop2Sel {
+    OCTEON_COP2_SEL_HSH_DAT0 = 0x0040,
+    OCTEON_COP2_SEL_HSH_DAT1,
+    OCTEON_COP2_SEL_HSH_DAT2,
+    OCTEON_COP2_SEL_HSH_DAT3,
+    OCTEON_COP2_SEL_HSH_DAT4,
+    OCTEON_COP2_SEL_HSH_DAT5,
+    OCTEON_COP2_SEL_HSH_DAT6,
+    OCTEON_COP2_SEL_HSH_IV0 = 0x0048,
+    OCTEON_COP2_SEL_HSH_IV1,
+    OCTEON_COP2_SEL_HSH_IV2,
+    OCTEON_COP2_SEL_HSH_IV3,
+    OCTEON_COP2_SEL_SHA3_DAT24 = 0x0050,
+    OCTEON_COP2_SEL_SHA3_DAT15_MT = 0x0051,
+    OCTEON_COP2_SEL_HSH_STARTSHA_COMPAT = 0x0057,
+    OCTEON_COP2_SEL_GFM_MUL_REFLECT0 = 0x0058,
+    OCTEON_COP2_SEL_GFM_MUL_REFLECT1,
+    OCTEON_COP2_SEL_GFM_RESINP_REFLECT0 = 0x005a,
+    OCTEON_COP2_SEL_GFM_RESINP_REFLECT1,
+    OCTEON_COP2_SEL_GFM_XOR0_REFLECT = 0x005c,
+    OCTEON_COP2_SEL_3DES_KEY0 = 0x0080,
+    OCTEON_COP2_SEL_3DES_KEY1,
+    OCTEON_COP2_SEL_3DES_KEY2,
+    OCTEON_COP2_SEL_3DES_IV = 0x0084,
+    OCTEON_COP2_SEL_3DES_RESULT_MF = 0x0088,
+    OCTEON_COP2_SEL_3DES_RESULT_MT = 0x0098,
+    OCTEON_COP2_SEL_3DES_ENC_CBC = 0x4088,
+    /*
+     * Octeon reuses the 3DES key/result bank for KASUMI and only adds
+     * KASUMI-specific operation selectors.
+     */
+    OCTEON_COP2_SEL_KAS_ENC_CBC = 0x4089,
+    OCTEON_COP2_SEL_3DES_ENC = 0x408a,
+    OCTEON_COP2_SEL_KAS_ENC = 0x408b,
+    OCTEON_COP2_SEL_3DES_DEC_CBC = 0x408c,
+    OCTEON_COP2_SEL_3DES_DEC = 0x408e,
+    OCTEON_COP2_SEL_AES_RESINP0 = 0x0100,
+    OCTEON_COP2_SEL_AES_RESINP1,
+    OCTEON_COP2_SEL_AES_IV0,
+    OCTEON_COP2_SEL_AES_IV1,
+    OCTEON_COP2_SEL_AES_KEY0,
+    OCTEON_COP2_SEL_AES_KEY1,
+    OCTEON_COP2_SEL_AES_KEY2,
+    OCTEON_COP2_SEL_AES_KEY3,
+    OCTEON_COP2_SEL_AES_ENC_CBC0 = 0x0108,
+    OCTEON_COP2_SEL_AES_ENC0 = 0x010a,
+    OCTEON_COP2_SEL_AES_DEC_CBC0 = 0x010c,
+    OCTEON_COP2_SEL_AES_DEC0 = 0x010e,
+    OCTEON_COP2_SEL_AES_KEYLENGTH = 0x0110,
+    OCTEON_COP2_SEL_AES_INP0 = 0x0111,
+    OCTEON_COP2_SEL_CRC_POLYNOMIAL = 0x0200,
+    OCTEON_COP2_SEL_CRC_IV = 0x0201,
+    OCTEON_COP2_SEL_CRC_LEN = 0x0202,
+    OCTEON_COP2_SEL_CRC_IV_REFLECT = 0x0203,
+    OCTEON_COP2_SEL_CRC_WRITE_BYTE = 0x0204,
+    OCTEON_COP2_SEL_CRC_WRITE_HALF = 0x0205,
+    OCTEON_COP2_SEL_CRC_WRITE_WORD = 0x0206,
+    OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL = 0x4200,
+    OCTEON_COP2_SEL_CRC_WRITE_LEN = 0x1202,
+    OCTEON_COP2_SEL_CRC_WRITE_IV_REFLECT = 0x0211,
+    OCTEON_COP2_SEL_CRC_WRITE_BYTE_REFLECT = 0x0214,
+    OCTEON_COP2_SEL_CRC_WRITE_HALF_REFLECT = 0x0215,
+    OCTEON_COP2_SEL_CRC_WRITE_WORD_REFLECT = 0x0216,
+    OCTEON_COP2_SEL_CRC_WRITE_DWORD = 0x1207,
+    OCTEON_COP2_SEL_CRC_WRITE_VAR = 0x1208,
+    OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL_REFLECT = 0x4210,
+    OCTEON_COP2_SEL_CRC_WRITE_DWORD_REFLECT = 0x1217,
+    OCTEON_COP2_SEL_CRC_WRITE_VAR_REFLECT = 0x1218,
+    /*
+     * Octeon shares 0x0240..0x0257 across the HSH/SHA512, SHA3, SNOW3G,
+     * and ZUC selector windows.
+     */
+    OCTEON_COP2_SEL_HSH_DATW0 = 0x0240,
+    OCTEON_COP2_SEL_HSH_DATW1,
+    OCTEON_COP2_SEL_HSH_DATW2,
+    OCTEON_COP2_SEL_HSH_DATW3,
+    OCTEON_COP2_SEL_HSH_DATW4,
+    OCTEON_COP2_SEL_HSH_DATW5,
+    OCTEON_COP2_SEL_HSH_DATW6,
+    OCTEON_COP2_SEL_HSH_DATW7,
+    OCTEON_COP2_SEL_HSH_DATW8,
+    OCTEON_COP2_SEL_HSH_DATW9,
+    OCTEON_COP2_SEL_HSH_DATW10,
+    OCTEON_COP2_SEL_HSH_DATW11,
+    OCTEON_COP2_SEL_HSH_DATW12,
+    OCTEON_COP2_SEL_HSH_DATW13,
+    OCTEON_COP2_SEL_HSH_DATW14,
+    OCTEON_COP2_SEL_HSH_DATW15,
+    OCTEON_COP2_SEL_HSH_IVW0 = 0x0250,
+    OCTEON_COP2_SEL_HSH_IVW1,
+    OCTEON_COP2_SEL_HSH_IVW2,
+    OCTEON_COP2_SEL_HSH_IVW3,
+    OCTEON_COP2_SEL_HSH_IVW4,
+    OCTEON_COP2_SEL_HSH_IVW5,
+    OCTEON_COP2_SEL_HSH_IVW6,
+    OCTEON_COP2_SEL_HSH_IVW7,
+    OCTEON_COP2_SEL_SNOW3G_LFSR0 = 0x0240,
+    OCTEON_COP2_SEL_SNOW3G_LFSR1,
+    OCTEON_COP2_SEL_SNOW3G_LFSR2,
+    OCTEON_COP2_SEL_SNOW3G_LFSR3,
+    OCTEON_COP2_SEL_SNOW3G_LFSR4,
+    OCTEON_COP2_SEL_SNOW3G_LFSR5,
+    OCTEON_COP2_SEL_SNOW3G_LFSR6,
+    OCTEON_COP2_SEL_SNOW3G_LFSR7,
+    OCTEON_COP2_SEL_SNOW3G_RESULT = 0x0250,
+    OCTEON_COP2_SEL_SNOW3G_FSM0,
+    OCTEON_COP2_SEL_SNOW3G_FSM1,
+    OCTEON_COP2_SEL_SNOW3G_FSM2,
+    OCTEON_COP2_SEL_GFM_MUL0 = 0x0258,
+    OCTEON_COP2_SEL_GFM_MUL1,
+    OCTEON_COP2_SEL_GFM_RESINP0,
+    OCTEON_COP2_SEL_GFM_RESINP1,
+    OCTEON_COP2_SEL_GFM_XOR0,
+    OCTEON_COP2_SEL_GFM_POLY = 0x025e,
+    OCTEON_COP2_SEL_AES_ENC_CBC1 = 0x3109,
+    OCTEON_COP2_SEL_AES_ENC1 = 0x310b,
+    OCTEON_COP2_SEL_AES_DEC_CBC1 = 0x310d,
+    OCTEON_COP2_SEL_AES_DEC1 = 0x310f,
+    OCTEON_COP2_SEL_HSH_STARTMD5 = 0x4047,
+    OCTEON_COP2_SEL_SNOW3G_START = 0x404d,
+    OCTEON_COP2_SEL_SNOW3G_MORE = 0x404e,
+    OCTEON_COP2_SEL_HSH_STARTSHA256 = 0x404f,
+    OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT = 0x405d,
+    OCTEON_COP2_SEL_HSH_STARTSHA = 0x4057,
+    OCTEON_COP2_SEL_HSH_STARTSHA512 = 0x424f,
+    OCTEON_COP2_SEL_GFM_XORMUL1 = 0x425d,
+} MIPSOcteonCop2Sel;
+
+typedef struct MIPSOcteonCryptoState {
+    uint64_t des3_key[3];
+    uint64_t des3_iv;
+    uint64_t des3_result;
+    uint64_t hsh_iv[4];
+    uint64_t hsh_dat[8];
+    uint64_t hsh_ivw[8];
+    uint64_t hsh_datw[16];
+    uint64_t aes_iv[2];
+    uint64_t aes_key[4];
+    uint64_t aes_result[2];
+    uint64_t aes_input[2];
+    uint64_t gfm_mul[2];
+    uint64_t gfm_resinp[2];
+    uint64_t gfm_xor0;
+    uint64_t gfm_reflect_mul[2];
+    uint64_t gfm_reflect_resinp[2];
+    uint64_t gfm_reflect_xor0;
+    uint16_t gfm_poly;
+    uint8_t aes_keylen;
+    uint32_t shared_mode;
+    uint32_t crc_poly;
+    uint32_t crc_iv;
+    uint32_t crc_len;
+    uint32_t snow3g_fsm[3];
+    uint32_t snow3g_lfsr[16];
+    uint64_t snow3g_result;
+} MIPSOcteonCryptoState;
+
 typedef struct CPUArchState {
     TCState active_tc;
     CPUMIPSFPUContext active_fpu;
@@ -558,6 +721,8 @@ typedef struct CPUArchState {
 #define MSAIR_ProcID    8
 #define MSAIR_Rev       0
 
+    MIPSOcteonCryptoState octeon_crypto;
+
 /*
  * CP0 Register 0
  */
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index f988b3695b..ebfa0a9eb0 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -279,6 +279,42 @@ static const VMStateDescription mips_vmstate_octeon_multiplier = {
     }
 };
 
+static const VMStateDescription mips_vmstate_octeon_crypto = {
+    .name = "cpu/octeon_crypto",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.des3_key, MIPSCPU, 3),
+        VMSTATE_UINT64(env.octeon_crypto.des3_iv, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.des3_result, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_iv, MIPSCPU, 4),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_dat, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_ivw, MIPSCPU, 8),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.hsh_datw, MIPSCPU, 16),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_iv, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_key, MIPSCPU, 4),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_result, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.aes_input, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.gfm_xor0, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_mul, MIPSCPU, 2),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.gfm_reflect_resinp, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.gfm_reflect_xor0, MIPSCPU),
+        VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
+        VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.shared_mode, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_poly, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_iv, MIPSCPU),
+        VMSTATE_UINT32(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_fsm, MIPSCPU, 3),
+        VMSTATE_UINT32_ARRAY(env.octeon_crypto.snow3g_lfsr, MIPSCPU, 16),
+        VMSTATE_UINT64(env.octeon_crypto.snow3g_result, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -396,6 +432,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
         &mips_vmstate_octeon_multiplier,
+        &mips_vmstate_octeon_crypto,
         NULL
     }
 };

-- 
2.54.0



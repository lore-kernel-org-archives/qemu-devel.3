Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C075BCD5BAD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNE1-00070w-EJ; Tue, 19 May 2026 12:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDz-0006zs-Dc
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:19 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDt-0000qD-U5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:18 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-404254ffe8aso3212894fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207793; x=1779812593; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e70vAixV9F+yNzAASYBW3Tp0azLrWZjeK42ZgYoX254=;
 b=Hwboy2OBpX83IXgd4SrZ9edrBtJZK1+a8nuNi6/G8u8LE2ASLOFC7lqVxhOtPrFIlh
 lJBqOdaTi2g2X5hWeO1j8n7YNy0OgA34byulv1rW0nQ8+EPbmWUlkwRCXFRR4XIf8ntZ
 XW2A3L12fZouHeAVWAO9Z1LZO568MUPOEoVklZIRDznoJLUfhUeK2Q0dASVQb+q4odLB
 KCapuMSM0RmqTFx7EL6r8nVGJxs+QkP+aFdunMzt0ikiMUWOnEBsn6jAbelD2w20ynZe
 mTMmO8M+MAnZgu/RNHpRpp1aGnRxw1B3Y7M1w9kUYtEURlxr776frHMSCxI67sTTNRC0
 ZD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207793; x=1779812593;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e70vAixV9F+yNzAASYBW3Tp0azLrWZjeK42ZgYoX254=;
 b=nd0mavG2fy3gY+jSragVk4pKKeDqfabCrzn9aPSNweoXlW7ZxTuDVcp4VRRD76wuFK
 cy+Y8iQ5w2HryEoftLdF2MCSICQU3WVHbOyodz+zRiL331HjHi8U6R2/0GLjtsNgLHeF
 6SLo35vHsgP/DRPJgcv/IBNBRaFEw5xrmxUMea2bj5gHrzo0MbsT1c1/u82UXYJxNBg9
 YvwQRPlAtz2G1um5FUuaJRlC+TkbQhvTHL7Cy3ZccF6aPwi8s66R/dSRMU0WfLr3JrnJ
 JpldHbvLv/Fx9XplI0ktlLZnCJ5t8qwogOahWeqes7CqFboNYaJ0tWCOb3brks03K+YK
 y0fA==
X-Gm-Message-State: AOJu0Yy+3KS+7gSI1fCDgUzZU4q0UX+66qezEfcKBCA+4DRR7W9UEpjD
 1gX5IIOyCsPhfXh7F31EpZppo0/uSrSc9YNpQ4VC9y59+LBBDM3OndGZ
X-Gm-Gg: Acq92OEoiw1nz9Oqp8I6FBE2JwyKo1U8FxMNiXqwd9nM+WTaxT+gUHl2JrJcINTfCJ4
 jQBBKoeKstmYCfpylTIaD7CRN7RRMNVbDPUwPyAZIbidK3AucQHDUEdgRETTBweJimRtKDLpGbY
 hkgJm8lAHWN8VtjuXTbJmFAw0cOvq24STKBCPyDcjBPh+S/ZizcOzFFBjSnp+T4NsQ0Wl7X4dmg
 c8OGpCPgxhY4tvRQ5pedSP0y2/XX/Ijyh1uoYicYZ0UR5cceTuAYFBMeM88gX5aQsU6TGdK10sM
 JMksnuR8emyrgi0j6XH6mEbgtwJCmVvmePeDUTMLLkLrPZtrSgW0+xpk26IUfXJqxUiAhRdv2ha
 NYSLFMUlQalVZyQvZOc5bBcdB30K22Gy7dcz4TEe17pnfoBNfL1I3PTfWr4dKxeFhe6luwUa8Fw
 NjyL00VAOH8vzqYxvnFTLwzNz33KBZK2J3HUnkq/uPmmYtD7SBGsbcDisbr5imP0CmULa56qFYg
 WlQmgwa5UnJrDwI61sUqzfUO9wb2IBOfOY9+Us33YenkWPJRkPy8v7+KLL5Pp8/ACYH
X-Received: by 2002:a05:6871:ea12:b0:417:3930:1b93 with SMTP id
 586e51a60fabf-43a2d9b24ffmr10442850fac.6.1779207792622; 
 Tue, 19 May 2026 09:23:12 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:39 -0600
Subject: [PATCH v9 37/40] target/mips: decode Octeon COP2 selectors explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-37-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x31.google.com
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

Decode Octeon CP2 selector operations in octeon.decode instead of first
accepting generic CP2 opcodes and re-decoding the selector inside a
runtime helper.

Emit direct TCG loads and stores for simple COP2 register moves. Use
signed 32-bit loads for 32-bit DMFC2 readback, matching MIPS register
move semantics, and keep helper calls only for operation selectors and
shared-window state that require side effects. Unknown Octeon CP2
selectors hit an explicit CP2_Undef decoder entry.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Use signed direct loads for 32-bit DMFC2 register readback.
  - Replace the generic selector helper calls with per-operation helper
    calls.
  - Document the AESRESINP input latch and readback/result register split.

Changes v7 -> v8:
  - Decode Octeon COP2 selectors explicitly in decodetree.
  - Use direct TCG loads/stores for simple COP2 register transfers and
    preserve helper calls for operation selectors with side effects.
---
 target/mips/helper.h               |   1 +
 target/mips/tcg/octeon.decode      | 205 ++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 342 +++++++++++++++++++++++++++++++++++++
 3 files changed, 548 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index fafcca4151..fd57ebbf00 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -145,6 +145,7 @@ DEF_HELPER_2(octeon_cp2_mt_llm_write_addr1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr1, void, env, i64)
 
+
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
 DEF_HELPER_4(swm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1e44c588dd..0ff8c0d7cd 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -97,3 +97,208 @@ LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
+
+# Selector-driven DMFC2/DMTC2 interfaces for Octeon COP2 engines.
+&cp2          rt
+{
+  [
+    CVM_MF_HSH_IV0                       010010 00001 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MF_HSH_IV1                       010010 00001 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MF_HSH_IV2                       010010 00001 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MF_HSH_IV3                       010010 00001 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MF_SHA3_DAT24                    010010 00001 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MF_GFM_MUL_REFLECT0              010010 00001 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MF_GFM_MUL_REFLECT1              010010 00001 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MF_GFM_RESINP_REFLECT0           010010 00001 rt:5 0000 0000 0101 1010 &cp2
+    CVM_MF_GFM_RESINP_REFLECT1           010010 00001 rt:5 0000 0000 0101 1011 &cp2
+    CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MF_3DES_IV                       010010 00001 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MF_3DES_RESULT                   010010 00001 rt:5 0000 0000 1000 1000 &cp2
+    CVM_MF_3DES_RESULT_MT                010010 00001 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MF_AES_RESINP0                   010010 00001 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MF_AES_RESINP1                   010010 00001 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MF_AES_IV0                       010010 00001 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MF_AES_IV1                       010010 00001 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MF_AES_KEY0                      010010 00001 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MF_AES_KEY1                      010010 00001 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MF_AES_KEY2                      010010 00001 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MF_AES_KEY3                      010010 00001 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MF_AES_KEYLENGTH                 010010 00001 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MF_AES_INP0                      010010 00001 rt:5 0000 0001 0001 0001 &cp2
+    CVM_MF_CRC_POLYNOMIAL                010010 00001 rt:5 0000 0010 0000 0000 &cp2
+    CVM_MF_CRC_IV                        010010 00001 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MF_CRC_LEN                       010010 00001 rt:5 0000 0010 0000 0010 &cp2
+    CVM_MF_CRC_IV_REFLECT                010010 00001 rt:5 0000 0010 0000 0011 &cp2
+    CVM_MF_HSH_DATW0                     010010 00001 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MF_HSH_DATW1                     010010 00001 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MF_HSH_DATW2                     010010 00001 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MF_HSH_DATW3                     010010 00001 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MF_HSH_DATW4                     010010 00001 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MF_HSH_DATW5                     010010 00001 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MF_HSH_DATW6                     010010 00001 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MF_HSH_DATW7                     010010 00001 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MF_HSH_DATW8                     010010 00001 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MF_HSH_DATW9                     010010 00001 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MF_HSH_DATW10                    010010 00001 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MF_HSH_DATW11                    010010 00001 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MF_HSH_DATW12                    010010 00001 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MF_HSH_DATW13                    010010 00001 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MF_HSH_DATW14                    010010 00001 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MF_HSH_DATW15                    010010 00001 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MF_HSH_IVW0                      010010 00001 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MF_HSH_IVW1                      010010 00001 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MF_HSH_IVW2                      010010 00001 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MF_HSH_IVW3                      010010 00001 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MF_HSH_IVW4                      010010 00001 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MF_HSH_IVW5                      010010 00001 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MF_HSH_IVW6                      010010 00001 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MF_HSH_IVW7                      010010 00001 rt:5 0000 0010 0101 0111 &cp2
+    CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MF_CHORD                         010010 00001 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MF_LLM_DATA0                     010010 00001 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MF_LLM_DATA1                     010010 00001 rt:5 0000 0100 0000 1010 &cp2
+    CVM_MT_HSH_DAT0                      010010 00101 rt:5 0000 0000 0100 0000 &cp2
+    CVM_MT_HSH_DAT1                      010010 00101 rt:5 0000 0000 0100 0001 &cp2
+    CVM_MT_HSH_DAT2                      010010 00101 rt:5 0000 0000 0100 0010 &cp2
+    CVM_MT_HSH_DAT3                      010010 00101 rt:5 0000 0000 0100 0011 &cp2
+    CVM_MT_HSH_DAT4                      010010 00101 rt:5 0000 0000 0100 0100 &cp2
+    CVM_MT_HSH_DAT5                      010010 00101 rt:5 0000 0000 0100 0101 &cp2
+    CVM_MT_HSH_DAT6                      010010 00101 rt:5 0000 0000 0100 0110 &cp2
+    CVM_MT_HSH_IV0                       010010 00101 rt:5 0000 0000 0100 1000 &cp2
+    CVM_MT_HSH_IV1                       010010 00101 rt:5 0000 0000 0100 1001 &cp2
+    CVM_MT_HSH_IV2                       010010 00101 rt:5 0000 0000 0100 1010 &cp2
+    CVM_MT_HSH_IV3                       010010 00101 rt:5 0000 0000 0100 1011 &cp2
+    CVM_MT_SHA3_DAT24                    010010 00101 rt:5 0000 0000 0101 0000 &cp2
+    CVM_MT_SHA3_DAT15                    010010 00101 rt:5 0000 0000 0101 0001 &cp2
+    CVM_MT_HSH_STARTSHA_COMPAT           010010 00101 rt:5 0000 0000 0101 0111 &cp2
+    CVM_MT_GFM_MUL_REFLECT0              010010 00101 rt:5 0000 0000 0101 1000 &cp2
+    CVM_MT_GFM_MUL_REFLECT1              010010 00101 rt:5 0000 0000 0101 1001 &cp2
+    CVM_MT_GFM_XOR0_REFLECT              010010 00101 rt:5 0000 0000 0101 1100 &cp2
+    CVM_MT_3DES_KEY0                     010010 00101 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MT_3DES_KEY1                     010010 00101 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MT_3DES_KEY2                     010010 00101 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MT_3DES_IV                       010010 00101 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MT_3DES_RESULT                   010010 00101 rt:5 0000 0000 1001 1000 &cp2
+    CVM_MT_AES_RESINP0                   010010 00101 rt:5 0000 0001 0000 0000 &cp2
+    CVM_MT_AES_RESINP1                   010010 00101 rt:5 0000 0001 0000 0001 &cp2
+    CVM_MT_AES_IV0                       010010 00101 rt:5 0000 0001 0000 0010 &cp2
+    CVM_MT_AES_IV1                       010010 00101 rt:5 0000 0001 0000 0011 &cp2
+    CVM_MT_AES_KEY0                      010010 00101 rt:5 0000 0001 0000 0100 &cp2
+    CVM_MT_AES_KEY1                      010010 00101 rt:5 0000 0001 0000 0101 &cp2
+    CVM_MT_AES_KEY2                      010010 00101 rt:5 0000 0001 0000 0110 &cp2
+    CVM_MT_AES_KEY3                      010010 00101 rt:5 0000 0001 0000 0111 &cp2
+    CVM_MT_AES_ENC_CBC0                  010010 00101 rt:5 0000 0001 0000 1000 &cp2
+    CVM_MT_AES_ENC0                      010010 00101 rt:5 0000 0001 0000 1010 &cp2
+    CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
+    CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
+    CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
+    CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_CRC_WRITE_IV_REFLECT          010010 00101 rt:5 0000 0010 0001 0001 &cp2
+    CVM_MT_CRC_WRITE_BYTE                010010 00101 rt:5 0000 0010 0000 0100 &cp2
+    CVM_MT_CRC_WRITE_HALF                010010 00101 rt:5 0000 0010 0000 0101 &cp2
+    CVM_MT_CRC_WRITE_WORD                010010 00101 rt:5 0000 0010 0000 0110 &cp2
+    CVM_MT_CRC_WRITE_BYTE_REFLECT        010010 00101 rt:5 0000 0010 0001 0100 &cp2
+    CVM_MT_CRC_WRITE_HALF_REFLECT        010010 00101 rt:5 0000 0010 0001 0101 &cp2
+    CVM_MT_CRC_WRITE_WORD_REFLECT        010010 00101 rt:5 0000 0010 0001 0110 &cp2
+    CVM_MT_HSH_DATW0                     010010 00101 rt:5 0000 0010 0100 0000 &cp2
+    CVM_MT_HSH_DATW1                     010010 00101 rt:5 0000 0010 0100 0001 &cp2
+    CVM_MT_HSH_DATW2                     010010 00101 rt:5 0000 0010 0100 0010 &cp2
+    CVM_MT_HSH_DATW3                     010010 00101 rt:5 0000 0010 0100 0011 &cp2
+    CVM_MT_HSH_DATW4                     010010 00101 rt:5 0000 0010 0100 0100 &cp2
+    CVM_MT_HSH_DATW5                     010010 00101 rt:5 0000 0010 0100 0101 &cp2
+    CVM_MT_HSH_DATW6                     010010 00101 rt:5 0000 0010 0100 0110 &cp2
+    CVM_MT_HSH_DATW7                     010010 00101 rt:5 0000 0010 0100 0111 &cp2
+    CVM_MT_HSH_DATW8                     010010 00101 rt:5 0000 0010 0100 1000 &cp2
+    CVM_MT_HSH_DATW9                     010010 00101 rt:5 0000 0010 0100 1001 &cp2
+    CVM_MT_HSH_DATW10                    010010 00101 rt:5 0000 0010 0100 1010 &cp2
+    CVM_MT_HSH_DATW11                    010010 00101 rt:5 0000 0010 0100 1011 &cp2
+    CVM_MT_HSH_DATW12                    010010 00101 rt:5 0000 0010 0100 1100 &cp2
+    CVM_MT_HSH_DATW13                    010010 00101 rt:5 0000 0010 0100 1101 &cp2
+    CVM_MT_HSH_DATW14                    010010 00101 rt:5 0000 0010 0100 1110 &cp2
+    CVM_MT_HSH_DATW15                    010010 00101 rt:5 0000 0010 0100 1111 &cp2
+    CVM_MT_HSH_IVW0                      010010 00101 rt:5 0000 0010 0101 0000 &cp2
+    CVM_MT_HSH_IVW1                      010010 00101 rt:5 0000 0010 0101 0001 &cp2
+    CVM_MT_HSH_IVW2                      010010 00101 rt:5 0000 0010 0101 0010 &cp2
+    CVM_MT_HSH_IVW3                      010010 00101 rt:5 0000 0010 0101 0011 &cp2
+    CVM_MT_HSH_IVW4                      010010 00101 rt:5 0000 0010 0101 0100 &cp2
+    CVM_MT_HSH_IVW5                      010010 00101 rt:5 0000 0010 0101 0101 &cp2
+    CVM_MT_HSH_IVW6                      010010 00101 rt:5 0000 0010 0101 0110 &cp2
+    CVM_MT_HSH_IVW7                      010010 00101 rt:5 0000 0010 0101 0111 &cp2
+    CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_XOR0                      010010 00101 rt:5 0000 0010 0101 1100 &cp2
+    CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_SHA3_XORDAT0                  010010 00101 rt:5 0000 0010 1100 0000 &cp2
+    CVM_MT_SHA3_XORDAT1                  010010 00101 rt:5 0000 0010 1100 0001 &cp2
+    CVM_MT_SHA3_XORDAT2                  010010 00101 rt:5 0000 0010 1100 0010 &cp2
+    CVM_MT_SHA3_XORDAT3                  010010 00101 rt:5 0000 0010 1100 0011 &cp2
+    CVM_MT_SHA3_XORDAT4                  010010 00101 rt:5 0000 0010 1100 0100 &cp2
+    CVM_MT_SHA3_XORDAT5                  010010 00101 rt:5 0000 0010 1100 0101 &cp2
+    CVM_MT_SHA3_XORDAT6                  010010 00101 rt:5 0000 0010 1100 0110 &cp2
+    CVM_MT_SHA3_XORDAT7                  010010 00101 rt:5 0000 0010 1100 0111 &cp2
+    CVM_MT_SHA3_XORDAT8                  010010 00101 rt:5 0000 0010 1100 1000 &cp2
+    CVM_MT_SHA3_XORDAT9                  010010 00101 rt:5 0000 0010 1100 1001 &cp2
+    CVM_MT_SHA3_XORDAT10                 010010 00101 rt:5 0000 0010 1100 1010 &cp2
+    CVM_MT_SHA3_XORDAT11                 010010 00101 rt:5 0000 0010 1100 1011 &cp2
+    CVM_MT_SHA3_XORDAT12                 010010 00101 rt:5 0000 0010 1100 1100 &cp2
+    CVM_MT_SHA3_XORDAT13                 010010 00101 rt:5 0000 0010 1100 1101 &cp2
+    CVM_MT_SHA3_XORDAT14                 010010 00101 rt:5 0000 0010 1100 1110 &cp2
+    CVM_MT_SHA3_XORDAT15                 010010 00101 rt:5 0000 0010 1100 1111 &cp2
+    CVM_MT_SHA3_XORDAT16                 010010 00101 rt:5 0000 0010 1101 0000 &cp2
+    CVM_MT_SHA3_XORDAT17                 010010 00101 rt:5 0000 0010 1101 0001 &cp2
+    CVM_MT_LLM_READ_ADDR0                010010 00101 rt:5 0000 0100 0000 0000 &cp2
+    CVM_MT_LLM_WRITE_ADDR0               010010 00101 rt:5 0000 0100 0000 0001 &cp2
+    CVM_MT_LLM_DATA0                     010010 00101 rt:5 0000 0100 0000 0010 &cp2
+    CVM_MT_LLM_READ64_ADDR0              010010 00101 rt:5 0000 0100 0000 0100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR0             010010 00101 rt:5 0000 0100 0000 0101 &cp2
+    CVM_MT_LLM_READ_ADDR1                010010 00101 rt:5 0000 0100 0000 1000 &cp2
+    CVM_MT_LLM_WRITE_ADDR1               010010 00101 rt:5 0000 0100 0000 1001 &cp2
+    CVM_MT_LLM_DATA1                     010010 00101 rt:5 0000 0100 0000 1010 &cp2
+    CVM_MT_LLM_READ64_ADDR1              010010 00101 rt:5 0000 0100 0000 1100 &cp2
+    CVM_MT_LLM_WRITE64_ADDR1             010010 00101 rt:5 0000 0100 0000 1101 &cp2
+    CVM_MT_CRC_WRITE_LEN                 010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_WRITE_DWORD               010010 00101 rt:5 0001 0010 0000 0111 &cp2
+    CVM_MT_CRC_WRITE_VAR                 010010 00101 rt:5 0001 0010 0000 1000 &cp2
+    CVM_MT_CRC_WRITE_DWORD_REFLECT       010010 00101 rt:5 0001 0010 0001 0111 &cp2
+    CVM_MT_CRC_WRITE_VAR_REFLECT         010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_AES_ENC_CBC1                  010010 00101 rt:5 0011 0001 0000 1001 &cp2
+    CVM_MT_AES_ENC1                      010010 00101 rt:5 0011 0001 0000 1011 &cp2
+    CVM_MT_AES_DEC_CBC1                  010010 00101 rt:5 0011 0001 0000 1101 &cp2
+    CVM_MT_AES_DEC1                      010010 00101 rt:5 0011 0001 0000 1111 &cp2
+    CVM_MT_CAMELLIA_ROUND                010010 00101 rt:5 0011 0001 0001 0100 &cp2
+    CVM_MT_SMS4_ENC_CBC1                 010010 00101 rt:5 0011 0001 0001 1001 &cp2
+    CVM_MT_SMS4_ENC1                     010010 00101 rt:5 0011 0001 0001 1011 &cp2
+    CVM_MT_SMS4_DEC_CBC1                 010010 00101 rt:5 0011 0001 0001 1101 &cp2
+    CVM_MT_SMS4_DEC1                     010010 00101 rt:5 0011 0001 0001 1111 &cp2
+    CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
+    CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
+    CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
+    CVM_MT_HSH_STARTSHA256               010010 00101 rt:5 0100 0000 0100 1111 &cp2
+    CVM_MT_SHA3_STARTOP                  010010 00101 rt:5 0100 0000 0101 0010 &cp2
+    CVM_MT_ZUC_START                     010010 00101 rt:5 0100 0000 0101 0101 &cp2
+    CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
+    CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
+    CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
+    CVM_MT_3DES_ENC_CBC                  010010 00101 rt:5 0100 0000 1000 1000 &cp2
+    CVM_MT_KAS_ENC_CBC                   010010 00101 rt:5 0100 0000 1000 1001 &cp2
+    CVM_MT_3DES_ENC                      010010 00101 rt:5 0100 0000 1000 1010 &cp2
+    CVM_MT_KAS_ENC                       010010 00101 rt:5 0100 0000 1000 1011 &cp2
+    CVM_MT_3DES_DEC_CBC                  010010 00101 rt:5 0100 0000 1000 1100 &cp2
+    CVM_MT_3DES_DEC                      010010 00101 rt:5 0100 0000 1000 1110 &cp2
+    CVM_MT_CRC_WRITE_POLYNOMIAL          010010 00101 rt:5 0100 0010 0000 0000 &cp2
+    CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT  010010 00101 rt:5 0100 0010 0001 0000 &cp2
+    CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
+    CVM_MT_GFM_XORMUL1                   010010 00101 rt:5 0100 0010 0101 1101 &cp2
+  ]
+  CP2_Undef                              010010 ----- ----- ---- ---- ---- ----
+}
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5ab7b4d659..0373fb5328 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,348 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+#define OCTEON_CRYPTO_OFFSET(FIELD) \
+    offsetof(CPUMIPSState, octeon_crypto.FIELD)
+
+#define CP2_MF_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_S32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_s32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mf_helper, \
+          gen_helper_octeon_cp2_mf_ ## SUFFIX)
+#define CP2_MT_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_HELPER(NAME, SUFFIX) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper, \
+          gen_helper_octeon_cp2_mt_ ## SUFFIX)
+
+static bool trans_CP2_Undef(DisasContext *ctx, arg_CP2_Undef *a)
+{
+    generate_exception_err(ctx, EXCP_CpU, 2);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_s32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld32s_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld16u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_u8(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld8u_i64(value, tcg_env, offset);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mf_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_helper(value, tcg_env);
+    gen_store_gpr(value, a->rt);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_i64(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st32_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u16(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st16_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_u8(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st8_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_resinp(DisasContext *ctx, arg_cp2 *a,
+                                       unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    /*
+     * Writes to AESRESINP update both QEMU views: the operation input latch
+     * and the DMFC2 readback/result register bank.
+     */
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env,
+                   OCTEON_CRYPTO_OFFSET(aes_input[index]));
+    tcg_gen_st_i64(value, tcg_env,
+                   OCTEON_CRYPTO_OFFSET(aes_result[index]));
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
+                                       void (*gen_helper)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    gen_helper(tcg_env, value);
+    return true;
+}
+
+CP2_MF_I64(CVM_MF_HSH_IV0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IV1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IV2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IV3, hsh_iv[3]);
+CP2_MF_I64(CVM_MF_GFM_MUL_REFLECT0, gfm_reflect_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL_REFLECT1, gfm_reflect_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP_REFLECT0, gfm_reflect_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP_REFLECT1, gfm_reflect_resinp[1]);
+CP2_MF_I64(CVM_MF_3DES_KEY0, des3_key[0]);
+CP2_MF_I64(CVM_MF_3DES_KEY1, des3_key[1]);
+CP2_MF_I64(CVM_MF_3DES_KEY2, des3_key[2]);
+CP2_MF_I64(CVM_MF_3DES_IV, des3_iv);
+CP2_MF_I64(CVM_MF_3DES_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_3DES_RESULT_MT, des3_result);
+CP2_MF_I64(CVM_MF_AES_RESINP0, aes_result[0]);
+CP2_MF_I64(CVM_MF_AES_RESINP1, aes_result[1]);
+CP2_MF_I64(CVM_MF_AES_IV0, aes_iv[0]);
+CP2_MF_I64(CVM_MF_AES_IV1, aes_iv[1]);
+CP2_MF_I64(CVM_MF_AES_KEY0, aes_key[0]);
+CP2_MF_I64(CVM_MF_AES_KEY1, aes_key[1]);
+CP2_MF_I64(CVM_MF_AES_KEY2, aes_key[2]);
+CP2_MF_I64(CVM_MF_AES_KEY3, aes_key[3]);
+CP2_MF_U8(CVM_MF_AES_KEYLENGTH, aes_keylen);
+CP2_MF_I64(CVM_MF_AES_INP0, aes_input[0]);
+CP2_MF_S32(CVM_MF_CRC_POLYNOMIAL, crc_poly);
+CP2_MF_S32(CVM_MF_CRC_IV, crc_iv);
+CP2_MF_S32(CVM_MF_CRC_LEN, crc_len);
+CP2_MF_I64(CVM_MF_GFM_MUL0, gfm_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
+CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
+
+CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, crc_iv_reflect);
+CP2_MF_HELPER(CVM_MF_SHA3_DAT24, sha3_dat24);
+CP2_MF_HELPER(CVM_MF_HSH_DATW0, hsh_datw0);
+CP2_MF_HELPER(CVM_MF_HSH_DATW1, hsh_datw1);
+CP2_MF_HELPER(CVM_MF_HSH_DATW2, hsh_datw2);
+CP2_MF_HELPER(CVM_MF_HSH_DATW3, hsh_datw3);
+CP2_MF_HELPER(CVM_MF_HSH_DATW4, hsh_datw4);
+CP2_MF_HELPER(CVM_MF_HSH_DATW5, hsh_datw5);
+CP2_MF_HELPER(CVM_MF_HSH_DATW6, hsh_datw6);
+CP2_MF_HELPER(CVM_MF_HSH_DATW7, hsh_datw7);
+CP2_MF_HELPER(CVM_MF_HSH_DATW8, hsh_datw8);
+CP2_MF_HELPER(CVM_MF_HSH_DATW9, hsh_datw9);
+CP2_MF_HELPER(CVM_MF_HSH_DATW10, hsh_datw10);
+CP2_MF_HELPER(CVM_MF_HSH_DATW11, hsh_datw11);
+CP2_MF_HELPER(CVM_MF_HSH_DATW12, hsh_datw12);
+CP2_MF_HELPER(CVM_MF_HSH_DATW13, hsh_datw13);
+CP2_MF_HELPER(CVM_MF_HSH_DATW14, hsh_datw14);
+CP2_MF_HELPER(CVM_MF_HSH_DATW15, hsh_datw15);
+CP2_MF_HELPER(CVM_MF_HSH_IVW0, hsh_ivw0);
+CP2_MF_HELPER(CVM_MF_HSH_IVW1, hsh_ivw1);
+CP2_MF_HELPER(CVM_MF_HSH_IVW2, hsh_ivw2);
+CP2_MF_HELPER(CVM_MF_HSH_IVW3, hsh_ivw3);
+CP2_MF_HELPER(CVM_MF_HSH_IVW4, hsh_ivw4);
+CP2_MF_HELPER(CVM_MF_HSH_IVW5, hsh_ivw5);
+CP2_MF_HELPER(CVM_MF_HSH_IVW6, hsh_ivw6);
+CP2_MF_HELPER(CVM_MF_HSH_IVW7, hsh_ivw7);
+
+CP2_MT_I64(CVM_MT_HSH_DAT0, hsh_dat[0]);
+CP2_MT_I64(CVM_MT_HSH_DAT1, hsh_dat[1]);
+CP2_MT_I64(CVM_MT_HSH_DAT2, hsh_dat[2]);
+CP2_MT_I64(CVM_MT_HSH_DAT3, hsh_dat[3]);
+CP2_MT_I64(CVM_MT_HSH_DAT4, hsh_dat[4]);
+CP2_MT_I64(CVM_MT_HSH_DAT5, hsh_dat[5]);
+CP2_MT_I64(CVM_MT_HSH_DAT6, hsh_dat[6]);
+CP2_MT_I64(CVM_MT_HSH_IV0, hsh_iv[0]);
+CP2_MT_I64(CVM_MT_HSH_IV1, hsh_iv[1]);
+CP2_MT_I64(CVM_MT_HSH_IV2, hsh_iv[2]);
+CP2_MT_I64(CVM_MT_HSH_IV3, hsh_iv[3]);
+CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT0, gfm_reflect_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL_REFLECT1, gfm_reflect_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_XOR0_REFLECT, gfm_reflect_xor0);
+CP2_MT_I64(CVM_MT_3DES_KEY0, des3_key[0]);
+CP2_MT_I64(CVM_MT_3DES_KEY1, des3_key[1]);
+CP2_MT_I64(CVM_MT_3DES_KEY2, des3_key[2]);
+CP2_MT_I64(CVM_MT_3DES_IV, des3_iv);
+CP2_MT_I64(CVM_MT_3DES_RESULT, des3_result);
+TRANS(CVM_MT_AES_RESINP0, trans_octeon_cp2_mt_resinp, 0);
+TRANS(CVM_MT_AES_RESINP1, trans_octeon_cp2_mt_resinp, 1);
+CP2_MT_I64(CVM_MT_AES_IV0, aes_iv[0]);
+CP2_MT_I64(CVM_MT_AES_IV1, aes_iv[1]);
+CP2_MT_I64(CVM_MT_AES_KEY0, aes_key[0]);
+CP2_MT_I64(CVM_MT_AES_KEY1, aes_key[1]);
+CP2_MT_I64(CVM_MT_AES_KEY2, aes_key[2]);
+CP2_MT_I64(CVM_MT_AES_KEY3, aes_key[3]);
+CP2_MT_I64(CVM_MT_AES_ENC_CBC0, aes_input[0]);
+CP2_MT_I64(CVM_MT_AES_ENC0, aes_input[0]);
+CP2_MT_I64(CVM_MT_AES_DEC_CBC0, aes_input[0]);
+CP2_MT_I64(CVM_MT_AES_DEC0, aes_input[0]);
+CP2_MT_U8(CVM_MT_AES_KEYLENGTH, aes_keylen);
+CP2_MT_U32(CVM_MT_CRC_IV, crc_iv);
+CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
+CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_I64(CVM_MT_GFM_XOR0, gfm_xor0);
+CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
+CP2_MT_U32(CVM_MT_CRC_WRITE_LEN, crc_len);
+CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL, crc_poly);
+CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT, crc_poly);
+
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_IV_REFLECT, crc_write_iv_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE, crc_write_byte);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF, crc_write_half);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD, crc_write_word);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE_REFLECT, crc_write_byte_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF_REFLECT, crc_write_half_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD_REFLECT, crc_write_word_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD, crc_write_dword);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR, crc_write_var);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD_REFLECT, crc_write_dword_reflect);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR_REFLECT, crc_write_var_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT, gfm_xormul1_reflect);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, gfm_xormul1);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT24, sha3_dat24);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT15, sha3_dat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT0, sha3_xordat0);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT1, sha3_xordat1);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT2, sha3_xordat2);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT3, sha3_xordat3);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT4, sha3_xordat4);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT5, sha3_xordat5);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT6, sha3_xordat6);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT7, sha3_xordat7);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT8, sha3_xordat8);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT9, sha3_xordat9);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT10, sha3_xordat10);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT11, sha3_xordat11);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT12, sha3_xordat12);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT13, sha3_xordat13);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT14, sha3_xordat14);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, sha3_xordat15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, sha3_xordat16);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, sha3_xordat17);
+CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, sha3_startop);
+CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
+CP2_MT_HELPER(CVM_MT_AES_ENC_CBC1, aes_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_ENC1, aes_enc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC_CBC1, aes_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_AES_DEC1, aes_dec1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC_CBC1, sms4_enc_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC1, sms4_enc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC_CBC1, sms4_dec_cbc1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC1, sms4_dec1);
+CP2_MT_HELPER(CVM_MT_3DES_ENC_CBC, des3_enc_cbc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC_CBC, kas_enc_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_ENC, des3_enc);
+CP2_MT_HELPER(CVM_MT_KAS_ENC, kas_enc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC_CBC, des3_dec_cbc);
+CP2_MT_HELPER(CVM_MT_3DES_DEC, des3_dec);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FL, camellia_fl);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FLINV, camellia_flinv);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_ROUND, camellia_round);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, hsh_startsha_compat);
+CP2_MT_HELPER(CVM_MT_HSH_DATW0, hsh_datw0);
+CP2_MT_HELPER(CVM_MT_HSH_DATW1, hsh_datw1);
+CP2_MT_HELPER(CVM_MT_HSH_DATW2, hsh_datw2);
+CP2_MT_HELPER(CVM_MT_HSH_DATW3, hsh_datw3);
+CP2_MT_HELPER(CVM_MT_HSH_DATW4, hsh_datw4);
+CP2_MT_HELPER(CVM_MT_HSH_DATW5, hsh_datw5);
+CP2_MT_HELPER(CVM_MT_HSH_DATW6, hsh_datw6);
+CP2_MT_HELPER(CVM_MT_HSH_DATW7, hsh_datw7);
+CP2_MT_HELPER(CVM_MT_HSH_DATW8, hsh_datw8);
+CP2_MT_HELPER(CVM_MT_HSH_DATW9, hsh_datw9);
+CP2_MT_HELPER(CVM_MT_HSH_DATW10, hsh_datw10);
+CP2_MT_HELPER(CVM_MT_HSH_DATW11, hsh_datw11);
+CP2_MT_HELPER(CVM_MT_HSH_DATW12, hsh_datw12);
+CP2_MT_HELPER(CVM_MT_HSH_DATW13, hsh_datw13);
+CP2_MT_HELPER(CVM_MT_HSH_DATW14, hsh_datw14);
+CP2_MT_HELPER(CVM_MT_HSH_DATW15, hsh_datw15);
+CP2_MT_HELPER(CVM_MT_HSH_IVW0, hsh_ivw0);
+CP2_MT_HELPER(CVM_MT_HSH_IVW1, hsh_ivw1);
+CP2_MT_HELPER(CVM_MT_HSH_IVW2, hsh_ivw2);
+CP2_MT_HELPER(CVM_MT_HSH_IVW3, hsh_ivw3);
+CP2_MT_HELPER(CVM_MT_HSH_IVW4, hsh_ivw4);
+CP2_MT_HELPER(CVM_MT_HSH_IVW5, hsh_ivw5);
+CP2_MT_HELPER(CVM_MT_HSH_IVW6, hsh_ivw6);
+CP2_MT_HELPER(CVM_MT_HSH_IVW7, hsh_ivw7);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, hsh_startmd5);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, hsh_startsha256);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, hsh_startsha);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, hsh_startsha512);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, llm_read_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0, llm_write_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, llm_read64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0, llm_write64_addr0);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, llm_read_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1, llm_write_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, llm_read64_addr1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1, llm_write64_addr1);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;

-- 
2.54.0



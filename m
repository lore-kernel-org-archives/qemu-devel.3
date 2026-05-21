Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFFACD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nE-0000Iz-33; Thu, 21 May 2026 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n1-0000GK-UK
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:37 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mz-00024X-CH
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:35 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso5322116a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386792; x=1779991592; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qIRrTp8+jeMSXIjhMludDMd1iY7EsebKtfgmzMxolmY=;
 b=OBMnBt08VzwHIYiwRRkaUKiwgY4+QmdtX7Gw/B41pKWi0HYScFCHGUu63e+UQKdOpR
 uMYLSHcAlq51Dr1uoUsgNFGg7XrR7WQqXuu26EYBan3oJBAHxx+odIAz1EPlMB6HW5BT
 cldJCRVx3wpbZtqT36pBVFs3Wnz8FwXvmKcqi5/vfBp95k15jQorU9unNtgEhFMhfxfW
 h2dvjVbElxumAYS+z8/ujNEYA+XmfGEWIBFWwILDWkqX2qU+CNDPjU6vZSUhbGtlp85B
 qi6TR51oaj3+HGQlp5o71wfaIcVvopKNjma9Q1pOLgMjeMLRLlTje+8VEPqHaSFC7WKs
 nGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386792; x=1779991592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qIRrTp8+jeMSXIjhMludDMd1iY7EsebKtfgmzMxolmY=;
 b=Kd4TdB0N/9KP9kKwJX44Q7agx4bVuIC/XgFKi9TSU4QUbKO5pG5puPajS5H1I7pzCs
 9i5xG/bMu4NEO05R3qyQPs865K0oONm1un7EfyjSVV6O6P6ZY48hFcb/uRy2kFd0m9PO
 JnN8oeTw81riSsPDGuihwD7aDHJtKxAPhR0jGYJLSDbL5tyQ2aOKILP4B4GB2rAFNpN9
 nbY6JbMizRE+RFijdAHt0VOav+YS58r0NtKGQsnkkL9THsp7gObrjHhtCYOYh41FUM2n
 TQbA9Pu/y/CHd+ZPZAW55VpYckp5B05cg3VDXVRmonzI018B+hxHSzyDuPslGfB+TSAu
 pgUA==
X-Gm-Message-State: AOJu0YzXU336LRPoiGT0ieCM+lwlQfMGucUgsa0GOiwYJtAb3iDJIRQ4
 t2CGddPYgKOu+NluPcBQmwO8k60OaXODQoVRHcKEfgR38xfpFLPxvGDp
X-Gm-Gg: Acq92OF4v1JaBxx/WBrorWlsqZM7ewtiYsga59ztJwNghKE1TGZ9QRv4XSMltBQFJmD
 TxFpbQduwEoRgWb3TPaZ4vAj3vfIe03zt1Dp0k+FFGpv6P+EASFqvW4GUBFBP8YE+TVqrr2x2qO
 xLnVPYFhc2Gs6niX2b96mnCMfGqYqW74JgdKSc9ejnTDqfr9NHVLqtyOVimu2jwC16ie7CSsth7
 23Vap2Wau5euJWtURQs8oI7k3Ca9MHgTTJCn7tmh2D5Mv8k665L6YURbeC24qK1IdP9wlR6wTMF
 QF7SYq5OAW3EJJekhd815T54zoIRAQxG/rFRuynTLItszv21qCDWEcEl7K1bgJkwe/cgPVYZPhs
 8UqTF9iyImpoyCCzLWiFGCgz8JLWe0BjnH6yACt+XFuhHs3BmEOT0xVo2O68FglN3R4P18tusiv
 cWPx+++GH+HjC6PEYEHwf/Sic84WHtNG7paJEAjHwVYhfIkmLEf3ck88IDXilRKxoG5UJZ2sMPM
 64zbW0hQhOe+bYvsucA1uO9VVAVdRMXXaxyz6yhbqRdCOvWw6Ax6YAhMYDv5jOuHz1M
X-Received: by 2002:a05:6830:349f:b0:7e1:90a:97bd with SMTP id
 46e09a7af769-7e5fefa0749mr131654a34.17.1779386791992; 
 Thu, 21 May 2026 11:06:31 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:31 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:08 -0600
Subject: [PATCH v13 15/22] target/mips: decode Octeon COP2 register selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-15-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x332.google.com
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

Add explicit decodetree entries and translator bindings for Octeon
DMFC2/DMTC2 selectors that are simple COP2 register transfers.

Emit direct TCG loads and stores for register moves. Use signed 32-bit
loads for 32-bit DMFC2 readback and mask narrow writable fields such as
AESKEYLEN and CRCLEN on DMTC2.

Keep operation selectors with side effects in later functional decode
patches.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v10 -> v13:
  - Keep simple register moves in their own selector patch.
  - Use final KAS result naming and final CRC register selector names.
  - Mask AESKEYLEN and CRCLEN direct writes.
---
 target/mips/tcg/octeon.decode                 |  72 +++++++++++
 target/mips/tcg/octeon_translate.c            | 179 ++++++++++++++++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  71 ++++++++++
 3 files changed, 322 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 1e44c588dd..b7deb99f33 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -97,3 +97,75 @@ LBUX         011111 ..... ..... ..... 00110 001010 @lx
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
+    CVM_MF_3DES_KEY0                     010010 00001 rt:5 0000 0000 1000 0000 &cp2
+    CVM_MF_3DES_KEY1                     010010 00001 rt:5 0000 0000 1000 0001 &cp2
+    CVM_MF_3DES_KEY2                     010010 00001 rt:5 0000 0000 1000 0010 &cp2
+    CVM_MF_3DES_IV                       010010 00001 rt:5 0000 0000 1000 0100 &cp2
+    CVM_MF_3DES_RESULT                   010010 00001 rt:5 0000 0000 1000 1000 &cp2
+    CVM_MF_KAS_RESULT                    010010 00001 rt:5 0000 0000 1001 1000 &cp2
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
+    CVM_MF_GFM_MUL0                      010010 00001 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MF_GFM_MUL1                      010010 00001 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MF_GFM_RESINP0                   010010 00001 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MF_GFM_RESINP1                   010010 00001 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MF_GFM_POLY                      010010 00001 rt:5 0000 0010 0101 1110 &cp2
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
+    CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
+    CVM_MT_GFM_MUL0                      010010 00101 rt:5 0000 0010 0101 1000 &cp2
+    CVM_MT_GFM_MUL1                      010010 00101 rt:5 0000 0010 0101 1001 &cp2
+    CVM_MT_GFM_RESINP0                   010010 00101 rt:5 0000 0010 0101 1010 &cp2
+    CVM_MT_GFM_RESINP1                   010010 00101 rt:5 0000 0010 0101 1011 &cp2
+    CVM_MT_GFM_POLY                      010010 00101 rt:5 0000 0010 0101 1110 &cp2
+    CVM_MT_CRC_LEN                       010010 00101 rt:5 0001 0010 0000 0010 &cp2
+    CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
+  ]
+}
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b0af2f4838..910a18d64b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,185 @@
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
+#define CP2_MT_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U8_MASKED(NAME, FIELD, MASK) \
+    TRANS(NAME, trans_octeon_cp2_mt_u8_masked, \
+          OCTEON_CRYPTO_OFFSET(FIELD), MASK)
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
+static bool trans_octeon_cp2_mt_u8_masked(DisasContext *ctx, arg_cp2 *a,
+                                          int offset, uint8_t mask)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_andi_i64(value, value, mask);
+    tcg_gen_st8_i64(value, tcg_env, offset);
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_resinp(DisasContext *ctx, arg_cp2 *a,
+                                       unsigned int index)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env,
+                   OCTEON_CRYPTO_OFFSET(aes_resinp[index]));
+    return true;
+}
+
+CP2_MF_I64(CVM_MF_HSH_IV0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IV1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IV2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IV3, hsh_iv[3]);
+CP2_MF_I64(CVM_MF_3DES_KEY0, des3_key[0]);
+CP2_MF_I64(CVM_MF_3DES_KEY1, des3_key[1]);
+CP2_MF_I64(CVM_MF_3DES_KEY2, des3_key[2]);
+CP2_MF_I64(CVM_MF_3DES_IV, des3_iv);
+CP2_MF_I64(CVM_MF_3DES_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_KAS_RESULT, des3_result);
+CP2_MF_I64(CVM_MF_AES_RESINP0, aes_resinp[0]);
+CP2_MF_I64(CVM_MF_AES_RESINP1, aes_resinp[1]);
+CP2_MF_I64(CVM_MF_AES_IV0, aes_iv[0]);
+CP2_MF_I64(CVM_MF_AES_IV1, aes_iv[1]);
+CP2_MF_I64(CVM_MF_AES_KEY0, aes_key[0]);
+CP2_MF_I64(CVM_MF_AES_KEY1, aes_key[1]);
+CP2_MF_I64(CVM_MF_AES_KEY2, aes_key[2]);
+CP2_MF_I64(CVM_MF_AES_KEY3, aes_key[3]);
+CP2_MF_U8(CVM_MF_AES_KEYLENGTH, aes_keylen);
+CP2_MF_I64(CVM_MF_AES_INP0, aes_resinp[0]);
+CP2_MF_S32(CVM_MF_CRC_POLYNOMIAL, crc_poly);
+CP2_MF_S32(CVM_MF_CRC_IV, crc_iv);
+CP2_MF_U8(CVM_MF_CRC_LEN, crc_len);
+CP2_MF_I64(CVM_MF_GFM_MUL0, gfm_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
+CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
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
+CP2_MT_I64(CVM_MT_AES_ENC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_ENC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC_CBC0, aes_resinp[0]);
+CP2_MT_I64(CVM_MT_AES_DEC0, aes_resinp[0]);
+CP2_MT_U8_MASKED(CVM_MT_AES_KEYLENGTH, aes_keylen, 3);
+CP2_MT_U32(CVM_MT_CRC_IV, crc_iv);
+CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
+CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_U8_MASKED(CVM_MT_CRC_LEN, crc_len, 0xf);
+CP2_MT_U32(CVM_MT_CRC_POLYNOMIAL, crc_poly);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e..bb24b04375 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -186,6 +186,70 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
     return rd;
 }
 
+static uint64_t octeon_cop2_key0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80104\n\t" /* dmtc2 $8, AES_KEY0 selector */
+        ".word 0x482a0104\n\t" /* dmfc2 $10, AES_KEY0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key2_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80106\n\t" /* dmtc2 $8, AES_KEY2 selector */
+        ".word 0x482a0106\n\t" /* dmfc2 $10, AES_KEY2 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key3_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80107\n\t" /* dmtc2 $8, AES_KEY3 selector */
+        ".word 0x482a0107\n\t" /* dmfc2 $10, AES_KEY3 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_keylength_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80110\n\t" /* dmtc2 $8, AES_KEYLENGTH selector */
+        ".word 0x482a0110\n\t" /* dmfc2 $10, AES_KEYLENGTH selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -199,6 +263,13 @@ int main(void)
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
+    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+           0x1122334455667788ULL);
+    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+           0x8877665544332211ULL);
+    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
+    assert(octeon_cop2_keylength_readback(0xa5) == 1);
 
     return 0;
 }

-- 
2.54.0



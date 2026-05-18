Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F8ECD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYa-0007Ft-9T; Mon, 18 May 2026 01:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYI-0006wa-Ni
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:08 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYC-0003Yb-6R
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c918c62b4so1254871b6e.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082197; x=1779686997; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wnaY5LAWjvmngWaNR8ilqfsNpU27MDlzRq9OtHdJTlA=;
 b=T8Eyp0I9iV8iUXkHnGb+8YsDWueOrNJIF0qzpPB3pxoF5jfgYO0407dCHHxQ3sABsz
 v+xz30jr/jFNG4FZUp5A9XLoSTO5w1/pJvtuyxVPIp4LRGAaPYYQxq840QGzA4EGlMor
 Jz8d3bTFzZxla0lOr40XubJF1a6TZ35d4wxPWkQR4Ewz6vhC78MeFPTwh9UpmyOHj8Zb
 Py/QzPOpBddVWJw8ijjkJXzpGlBYJ0UIEQHrLt9HMi7EhRNO/UwG1gSAenttkSbRj8zt
 jMCQotvBLV84qzlj2PW/icFSxWwZysZH8ZZ7J+NCE70VOgBSZgoiqOz+T/VGql1aNWZZ
 Npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082197; x=1779686997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wnaY5LAWjvmngWaNR8ilqfsNpU27MDlzRq9OtHdJTlA=;
 b=sf2FgoQJSK+jY6dTkTW5cU8surwwH8lpxp7njpb3G/x15asr5icSfzX3tlfGNHVsMd
 EotMKakJTE3HaVlySTmZ7Bzp9ukWs4ykMe505nhbw4+Xmas2++w7ByPdFVzIuENX5HN9
 3j4nz3omyo0jeU6NscJXPrNuYN0tX6tLDzDhLINvjYB7fBacnsrj4rbeBssKyWXBU2Mu
 VcgMACIxUHeXWhe/nSINPyP2b/g6LnbQXSTnDbspxlEe+C8glfeFsookwmfZKRdvX/4x
 ixcziGxMuen4o0swg2GSJh8E81B4L1Ve9pGKbeUHwWGbcXfDN/xPgnO/ekXEFAhX0zGK
 40mg==
X-Gm-Message-State: AOJu0YyLNM78OpvMmzYKBC03LaBTFve4kox0XMwA0rXi2R1jx9sJrgE9
 3C7i6yqTVuNjMFFThco1lWsQvDq2ZvFeQCcGhTloaXGzSrckwehDVjCE
X-Gm-Gg: Acq92OE3JdsCLuu505dHxe3rA04asTvRPmgrsr5AamtVsyQ4wqHUFJWVLNsoJZd36VY
 CmS5z4M5fkJFkg3q7NeUDVPkqEEbaa07LvPYTGBadZaM6JXj+IIY5cfILG2hn3t6WhidSClaUQx
 EsVAIim+NnzX3oJodeM04wCQpcdOwAzBADLVe0AROIuxLxBfIhXtGm93SzcsnAHY4RpWNE5Xfn5
 fkY54L1rlmk/hsMI8HYLVussdfNBnr+PLIfjHiCNLmBU4wMUwLRomHF+1PXk+Z7ZoK4AJnmOhgs
 6v7NGiWujEc2BtosCu5IeSntOIjUIg8mW9Ju3MK1Pie3tB7XVLzHjEdtcnLcF2rNBQUfGZUN1P2
 byoi0afvFj+VwlBGr/pLp7T9+OTzvFa3Hzw1JaCs7+D3khAmPailx6Ywn7S1hVJUp0lfWl+jdld
 fzCBLMvAeel/wnMerUjBKCKEb7zQm721SMdp1YtvVgR3WZ7WUedX/btFCnr7D1lEyglGW+GnaTs
 Z3REm2gGWiVWiZ9rSYQ8QV8E+6GQbTVsOHKa+X9SdX25ni+4UGhHXdLRNUE/qiwqX0ztrPaFfGB
 M7lyvw==
X-Received: by 2002:a05:6808:d51:b0:472:b43a:3063 with SMTP id
 5614622812f47-482e592ff41mr8693329b6e.38.1779082197326; 
 Sun, 17 May 2026 22:29:57 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:28 -0600
Subject: [PATCH v8 31/35] target/mips: decode Octeon COP2 selectors explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-31-206151ee77ec@gmail.com>
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

Decode Octeon CP2 selector operations in octeon.decode instead of first
accepting generic CP2 opcodes and re-decoding the selector inside
gen_octeon_cop2().

Emit direct TCG loads and stores for simple COP2 register moves and keep
helper calls only for operation selectors and shared-window state that
require side effects. Unknown Octeon CP2 selectors now hit an explicit
CP2_Undef decoder entry.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v7 -> v8:
  - Decode Octeon COP2 selectors explicitly in decodetree.
  - Use direct TCG loads/stores for simple COP2 register transfers and
    preserve helper calls for operation selectors with side effects.
---
 target/mips/tcg/octeon.decode      | 205 ++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 344 +++++++++++++++++++++++++++++++++++++
 2 files changed, 549 insertions(+)

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
index 5a124b3c90..303489a9b9 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -13,6 +13,350 @@
 /* Include the auto-generated decoder.  */
 #include "decode-octeon.c.inc"
 
+#define OCTEON_CRYPTO_OFFSET(FIELD) \
+    offsetof(CPUMIPSState, octeon_crypto.FIELD)
+
+#define CP2_MF_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mf_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MF_HELPER(NAME, SEL) \
+    TRANS(NAME, trans_octeon_cp2_mf_helper, SEL)
+#define CP2_MT_I64(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_i64, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U32(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u32, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U16(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u16, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_U8(NAME, FIELD) \
+    TRANS(NAME, trans_octeon_cp2_mt_u8, OCTEON_CRYPTO_OFFSET(FIELD))
+#define CP2_MT_HELPER(NAME, SEL) \
+    TRANS(NAME, trans_octeon_cp2_mt_helper, SEL)
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
+static bool trans_octeon_cp2_mf_u32(DisasContext *ctx, arg_cp2 *a, int offset)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    tcg_gen_ld32u_i64(value, tcg_env, offset);
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
+                                       uint32_t sel)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_helper_octeon_cop2_dmfc2(value, tcg_env, tcg_constant_i32(sel));
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
+    gen_load_gpr(value, a->rt);
+    tcg_gen_st_i64(value, tcg_env,
+                   OCTEON_CRYPTO_OFFSET(aes_input[index]));
+    tcg_gen_st_i64(value, tcg_env,
+                   OCTEON_CRYPTO_OFFSET(aes_result[index]));
+    return true;
+}
+
+static bool trans_octeon_cp2_mt_helper(DisasContext *ctx, arg_cp2 *a,
+                                       uint32_t sel)
+{
+    TCGv_i64 value = tcg_temp_new_i64();
+
+    gen_load_gpr(value, a->rt);
+    gen_helper_octeon_cop2_dmtc2(tcg_env, value, tcg_constant_i32(sel));
+    return true;
+}
+
+CP2_MF_I64(CVM_MF_HSH_IV0, hsh_iv[0]);
+CP2_MF_I64(CVM_MF_HSH_IV1, hsh_iv[1]);
+CP2_MF_I64(CVM_MF_HSH_IV2, hsh_iv[2]);
+CP2_MF_I64(CVM_MF_HSH_IV3, hsh_iv[3]);
+CP2_MF_HELPER(CVM_MF_SHA3_DAT24, OCTEON_COP2_SEL_SHA3_DAT24);
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
+CP2_MF_U32(CVM_MF_CRC_POLYNOMIAL, crc_poly);
+CP2_MF_U32(CVM_MF_CRC_IV, crc_iv);
+CP2_MF_U32(CVM_MF_CRC_LEN, crc_len);
+CP2_MF_HELPER(CVM_MF_CRC_IV_REFLECT, OCTEON_COP2_SEL_CRC_IV_REFLECT);
+CP2_MF_HELPER(CVM_MF_HSH_DATW0, OCTEON_COP2_SEL_HSH_DATW0);
+CP2_MF_HELPER(CVM_MF_HSH_DATW1, OCTEON_COP2_SEL_HSH_DATW1);
+CP2_MF_HELPER(CVM_MF_HSH_DATW2, OCTEON_COP2_SEL_HSH_DATW2);
+CP2_MF_HELPER(CVM_MF_HSH_DATW3, OCTEON_COP2_SEL_HSH_DATW3);
+CP2_MF_HELPER(CVM_MF_HSH_DATW4, OCTEON_COP2_SEL_HSH_DATW4);
+CP2_MF_HELPER(CVM_MF_HSH_DATW5, OCTEON_COP2_SEL_HSH_DATW5);
+CP2_MF_HELPER(CVM_MF_HSH_DATW6, OCTEON_COP2_SEL_HSH_DATW6);
+CP2_MF_HELPER(CVM_MF_HSH_DATW7, OCTEON_COP2_SEL_HSH_DATW7);
+CP2_MF_HELPER(CVM_MF_HSH_DATW8, OCTEON_COP2_SEL_HSH_DATW8);
+CP2_MF_HELPER(CVM_MF_HSH_DATW9, OCTEON_COP2_SEL_HSH_DATW9);
+CP2_MF_HELPER(CVM_MF_HSH_DATW10, OCTEON_COP2_SEL_HSH_DATW10);
+CP2_MF_HELPER(CVM_MF_HSH_DATW11, OCTEON_COP2_SEL_HSH_DATW11);
+CP2_MF_HELPER(CVM_MF_HSH_DATW12, OCTEON_COP2_SEL_HSH_DATW12);
+CP2_MF_HELPER(CVM_MF_HSH_DATW13, OCTEON_COP2_SEL_HSH_DATW13);
+CP2_MF_HELPER(CVM_MF_HSH_DATW14, OCTEON_COP2_SEL_HSH_DATW14);
+CP2_MF_HELPER(CVM_MF_HSH_DATW15, OCTEON_COP2_SEL_HSH_DATW15);
+CP2_MF_HELPER(CVM_MF_HSH_IVW0, OCTEON_COP2_SEL_HSH_IVW0);
+CP2_MF_HELPER(CVM_MF_HSH_IVW1, OCTEON_COP2_SEL_HSH_IVW1);
+CP2_MF_HELPER(CVM_MF_HSH_IVW2, OCTEON_COP2_SEL_HSH_IVW2);
+CP2_MF_HELPER(CVM_MF_HSH_IVW3, OCTEON_COP2_SEL_HSH_IVW3);
+CP2_MF_HELPER(CVM_MF_HSH_IVW4, OCTEON_COP2_SEL_HSH_IVW4);
+CP2_MF_HELPER(CVM_MF_HSH_IVW5, OCTEON_COP2_SEL_HSH_IVW5);
+CP2_MF_HELPER(CVM_MF_HSH_IVW6, OCTEON_COP2_SEL_HSH_IVW6);
+CP2_MF_HELPER(CVM_MF_HSH_IVW7, OCTEON_COP2_SEL_HSH_IVW7);
+CP2_MF_I64(CVM_MF_GFM_MUL0, gfm_mul[0]);
+CP2_MF_I64(CVM_MF_GFM_MUL1, gfm_mul[1]);
+CP2_MF_I64(CVM_MF_GFM_RESINP0, gfm_resinp[0]);
+CP2_MF_I64(CVM_MF_GFM_RESINP1, gfm_resinp[1]);
+CP2_MF_U16(CVM_MF_GFM_POLY, gfm_poly);
+CP2_MF_I64(CVM_MF_CHORD, chord);
+CP2_MF_I64(CVM_MF_LLM_DATA0, llm_data[0]);
+CP2_MF_I64(CVM_MF_LLM_DATA1, llm_data[1]);
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
+CP2_MT_HELPER(CVM_MT_SHA3_DAT24, OCTEON_COP2_SEL_SHA3_DAT24);
+CP2_MT_HELPER(CVM_MT_SHA3_DAT15, OCTEON_COP2_SEL_SHA3_DAT15_MT);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, OCTEON_COP2_SEL_HSH_STARTSHA_COMPAT);
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
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FL, OCTEON_COP2_SEL_CAMELLIA_FL);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_FLINV, OCTEON_COP2_SEL_CAMELLIA_FLINV);
+CP2_MT_U32(CVM_MT_CRC_IV, crc_iv);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_IV_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_IV_REFLECT);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE, OCTEON_COP2_SEL_CRC_WRITE_BYTE);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF, OCTEON_COP2_SEL_CRC_WRITE_HALF);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD, OCTEON_COP2_SEL_CRC_WRITE_WORD);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_BYTE_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_BYTE_REFLECT);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_HALF_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_HALF_REFLECT);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_WORD_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_WORD_REFLECT);
+CP2_MT_HELPER(CVM_MT_HSH_DATW0, OCTEON_COP2_SEL_HSH_DATW0);
+CP2_MT_HELPER(CVM_MT_HSH_DATW1, OCTEON_COP2_SEL_HSH_DATW1);
+CP2_MT_HELPER(CVM_MT_HSH_DATW2, OCTEON_COP2_SEL_HSH_DATW2);
+CP2_MT_HELPER(CVM_MT_HSH_DATW3, OCTEON_COP2_SEL_HSH_DATW3);
+CP2_MT_HELPER(CVM_MT_HSH_DATW4, OCTEON_COP2_SEL_HSH_DATW4);
+CP2_MT_HELPER(CVM_MT_HSH_DATW5, OCTEON_COP2_SEL_HSH_DATW5);
+CP2_MT_HELPER(CVM_MT_HSH_DATW6, OCTEON_COP2_SEL_HSH_DATW6);
+CP2_MT_HELPER(CVM_MT_HSH_DATW7, OCTEON_COP2_SEL_HSH_DATW7);
+CP2_MT_HELPER(CVM_MT_HSH_DATW8, OCTEON_COP2_SEL_HSH_DATW8);
+CP2_MT_HELPER(CVM_MT_HSH_DATW9, OCTEON_COP2_SEL_HSH_DATW9);
+CP2_MT_HELPER(CVM_MT_HSH_DATW10, OCTEON_COP2_SEL_HSH_DATW10);
+CP2_MT_HELPER(CVM_MT_HSH_DATW11, OCTEON_COP2_SEL_HSH_DATW11);
+CP2_MT_HELPER(CVM_MT_HSH_DATW12, OCTEON_COP2_SEL_HSH_DATW12);
+CP2_MT_HELPER(CVM_MT_HSH_DATW13, OCTEON_COP2_SEL_HSH_DATW13);
+CP2_MT_HELPER(CVM_MT_HSH_DATW14, OCTEON_COP2_SEL_HSH_DATW14);
+CP2_MT_HELPER(CVM_MT_HSH_DATW15, OCTEON_COP2_SEL_HSH_DATW15);
+CP2_MT_HELPER(CVM_MT_HSH_IVW0, OCTEON_COP2_SEL_HSH_IVW0);
+CP2_MT_HELPER(CVM_MT_HSH_IVW1, OCTEON_COP2_SEL_HSH_IVW1);
+CP2_MT_HELPER(CVM_MT_HSH_IVW2, OCTEON_COP2_SEL_HSH_IVW2);
+CP2_MT_HELPER(CVM_MT_HSH_IVW3, OCTEON_COP2_SEL_HSH_IVW3);
+CP2_MT_HELPER(CVM_MT_HSH_IVW4, OCTEON_COP2_SEL_HSH_IVW4);
+CP2_MT_HELPER(CVM_MT_HSH_IVW5, OCTEON_COP2_SEL_HSH_IVW5);
+CP2_MT_HELPER(CVM_MT_HSH_IVW6, OCTEON_COP2_SEL_HSH_IVW6);
+CP2_MT_HELPER(CVM_MT_HSH_IVW7, OCTEON_COP2_SEL_HSH_IVW7);
+CP2_MT_I64(CVM_MT_GFM_MUL0, gfm_mul[0]);
+CP2_MT_I64(CVM_MT_GFM_MUL1, gfm_mul[1]);
+CP2_MT_I64(CVM_MT_GFM_RESINP0, gfm_resinp[0]);
+CP2_MT_I64(CVM_MT_GFM_RESINP1, gfm_resinp[1]);
+CP2_MT_I64(CVM_MT_GFM_XOR0, gfm_xor0);
+CP2_MT_U16(CVM_MT_GFM_POLY, gfm_poly);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT0, OCTEON_COP2_SEL_SHA3_XORDAT0);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT1, OCTEON_COP2_SEL_SHA3_XORDAT1);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT2, OCTEON_COP2_SEL_SHA3_XORDAT2);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT3, OCTEON_COP2_SEL_SHA3_XORDAT3);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT4, OCTEON_COP2_SEL_SHA3_XORDAT4);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT5, OCTEON_COP2_SEL_SHA3_XORDAT5);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT6, OCTEON_COP2_SEL_SHA3_XORDAT6);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT7, OCTEON_COP2_SEL_SHA3_XORDAT7);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT8, OCTEON_COP2_SEL_SHA3_XORDAT8);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT9, OCTEON_COP2_SEL_SHA3_XORDAT9);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT10, OCTEON_COP2_SEL_SHA3_XORDAT10);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT11, OCTEON_COP2_SEL_SHA3_XORDAT11);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT12, OCTEON_COP2_SEL_SHA3_XORDAT12);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT13, OCTEON_COP2_SEL_SHA3_XORDAT13);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT14, OCTEON_COP2_SEL_SHA3_XORDAT14);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT15, OCTEON_COP2_SEL_SHA3_XORDAT15);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT16, OCTEON_COP2_SEL_SHA3_XORDAT16);
+CP2_MT_HELPER(CVM_MT_SHA3_XORDAT17, OCTEON_COP2_SEL_SHA3_XORDAT17);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR0, OCTEON_COP2_SEL_LLM_READ_ADDR0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR0,
+              OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0);
+CP2_MT_I64(CVM_MT_LLM_DATA0, llm_data[0]);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR0, OCTEON_COP2_SEL_LLM_READ64_ADDR0);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR0,
+              OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0);
+CP2_MT_HELPER(CVM_MT_LLM_READ_ADDR1, OCTEON_COP2_SEL_LLM_READ_ADDR1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE_ADDR1,
+              OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1);
+CP2_MT_I64(CVM_MT_LLM_DATA1, llm_data[1]);
+CP2_MT_HELPER(CVM_MT_LLM_READ64_ADDR1, OCTEON_COP2_SEL_LLM_READ64_ADDR1);
+CP2_MT_HELPER(CVM_MT_LLM_WRITE64_ADDR1,
+              OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1);
+CP2_MT_U32(CVM_MT_CRC_WRITE_LEN, crc_len);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD, OCTEON_COP2_SEL_CRC_WRITE_DWORD);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR, OCTEON_COP2_SEL_CRC_WRITE_VAR);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_DWORD_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_DWORD_REFLECT);
+CP2_MT_HELPER(CVM_MT_CRC_WRITE_VAR_REFLECT,
+              OCTEON_COP2_SEL_CRC_WRITE_VAR_REFLECT);
+CP2_MT_HELPER(CVM_MT_AES_ENC_CBC1, OCTEON_COP2_SEL_AES_ENC_CBC1);
+CP2_MT_HELPER(CVM_MT_AES_ENC1, OCTEON_COP2_SEL_AES_ENC1);
+CP2_MT_HELPER(CVM_MT_AES_DEC_CBC1, OCTEON_COP2_SEL_AES_DEC_CBC1);
+CP2_MT_HELPER(CVM_MT_AES_DEC1, OCTEON_COP2_SEL_AES_DEC1);
+CP2_MT_HELPER(CVM_MT_CAMELLIA_ROUND, OCTEON_COP2_SEL_CAMELLIA_ROUND);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC_CBC1, OCTEON_COP2_SEL_SMS4_ENC_CBC1);
+CP2_MT_HELPER(CVM_MT_SMS4_ENC1, OCTEON_COP2_SEL_SMS4_ENC1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC_CBC1, OCTEON_COP2_SEL_SMS4_DEC_CBC1);
+CP2_MT_HELPER(CVM_MT_SMS4_DEC1, OCTEON_COP2_SEL_SMS4_DEC1);
+CP2_MT_HELPER(CVM_MT_HSH_STARTMD5, OCTEON_COP2_SEL_HSH_STARTMD5);
+CP2_MT_HELPER(CVM_MT_SNOW3G_START, OCTEON_COP2_SEL_SNOW3G_START);
+CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, OCTEON_COP2_SEL_SNOW3G_MORE);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA256, OCTEON_COP2_SEL_HSH_STARTSHA256);
+CP2_MT_HELPER(CVM_MT_SHA3_STARTOP, OCTEON_COP2_SEL_SHA3_STARTOP);
+CP2_MT_HELPER(CVM_MT_ZUC_START, OCTEON_COP2_SEL_ZUC_START);
+CP2_MT_HELPER(CVM_MT_ZUC_MORE, OCTEON_COP2_SEL_ZUC_MORE);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA, OCTEON_COP2_SEL_HSH_STARTSHA);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1_REFLECT,
+              OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT);
+CP2_MT_HELPER(CVM_MT_3DES_ENC_CBC, OCTEON_COP2_SEL_3DES_ENC_CBC);
+CP2_MT_HELPER(CVM_MT_KAS_ENC_CBC, OCTEON_COP2_SEL_KAS_ENC_CBC);
+CP2_MT_HELPER(CVM_MT_3DES_ENC, OCTEON_COP2_SEL_3DES_ENC);
+CP2_MT_HELPER(CVM_MT_KAS_ENC, OCTEON_COP2_SEL_KAS_ENC);
+CP2_MT_HELPER(CVM_MT_3DES_DEC_CBC, OCTEON_COP2_SEL_3DES_DEC_CBC);
+CP2_MT_HELPER(CVM_MT_3DES_DEC, OCTEON_COP2_SEL_3DES_DEC);
+CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL, crc_poly);
+CP2_MT_U32(CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT, crc_poly);
+CP2_MT_HELPER(CVM_MT_HSH_STARTSHA512, OCTEON_COP2_SEL_HSH_STARTSHA512);
+CP2_MT_HELPER(CVM_MT_GFM_XORMUL1, OCTEON_COP2_SEL_GFM_XORMUL1);
+
 static bool trans_BBIT(DisasContext *ctx, arg_BBIT *a)
 {
     TCGv_i64 p;

-- 
2.54.0



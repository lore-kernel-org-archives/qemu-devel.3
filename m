Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC82CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYh8-0001KX-Rs; Wed, 20 May 2026 00:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh7-0001JS-7M
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh4-0003va-4B
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:08 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbe437b072so2203854a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251883; x=1779856683; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mUwEfnAzApc6ZS4ZDncONZsXZqLoV9qEqnV3kPf1MLs=;
 b=qcy0UPmnpb3FWAAwWhHgrDbAElzXTMc+E5JjCEM0IGlI0gia9KWC6U8QagNUuUp2bV
 neTbhrCm4vBWniccprShnPl6TW1wGtsDhlr7MSmTUd85bG3bvKNWfKTzVrhibfoQcK9Q
 Nr1VL9pfXf8aWQUB1h8sFCHkoS94RAlNGYLMRAW6PsLRKEj7MMsXxcu/31OkCPtUP4nT
 x5vtlFJdcOWUYbAiSD7GN7EK+oygtv/Ib65EiFBJ+50KWQXJnP6bgbogiXp9BKoEG4Zi
 cvAdv8HJraQ84GgN6xcH5yFq0GPzMk2+l2XR/yxURsbwP1Iih6pppgAzxB65kFZn7jku
 de8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251883; x=1779856683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mUwEfnAzApc6ZS4ZDncONZsXZqLoV9qEqnV3kPf1MLs=;
 b=UHrodHwe8UL3hONZ0xT2xSGom/FXx4oJFWJUTTj0RrNMq4RpI3QIwn1/4Hu8aCxGrD
 TdtPy0ZT5xK63AbvokTA8WH4wKCih5C35TdACFJyrm41FdQu1z9BqSRPfb+55WeMa0mC
 a/MWwabT/rh3NWyrKaFFNlwRN8bAAbMquoF4PZs6iSWUNs+ChqhWZPZ7/aYcoTs2gAI+
 EEcNY0+SVZrGTH9w3E0QwkPEMX0/5Auz23h/cshnmk9G7fvw08aMndKAjlKQui5eCaPn
 5+hx29UkYjWDji0RUF84OERMBCWr/JP54zbVbu8rG+FqD5xYGdrXTeOi8Qc/9gNqmrfT
 m3hQ==
X-Gm-Message-State: AOJu0YyODwUEHoT+T+2mnPEyX1BUKQNWVU7uF/yOh0c1D5Pn+VC1W95H
 5RnQwUXp6AefOgCsS2Ns8bnQKCRuXFKEiXfgF2Cx915H6ZtEw1KYjXp9
X-Gm-Gg: Acq92OH0Yz+DHGQrhBReQ4GKXnXjfHmCe28T+ZoUtaikJg0NUftj37TTIiE+9BsEHPV
 dleKwYZXKuGeXUsL5IoGwh9smjr6geR897rtbs8xzJSHg3BUgzZJpt6gwSN4c/FM9TCYkx8pby5
 a3rDSbyGchiR8A/x3dOfuHQ7fnuBW/PMSbaCuNYSkmWtdR7VGANseQg39b9nhLxq3uK/opc9CMq
 afsq9Zzalqsljm1QkPwG4bZOphrnWifwwIwI3j5iC82pWB4DlROxDFbQq+/YLnOGdSQWXlGJB7P
 eggDXircwLTmiWn0EhxgXTKND+SZMio6rVPcmactZjOhTxp77rPy+MKtK/mDEd0IiftKgBgR2TK
 agw9SV5X544Id0+SQELmLu46xuHXAjpEYe9Js/mv6yzHKlqDCC971JkB95B7HK6h8BQjhYAPetv
 mJwzGm1L9J21DaH29CrzfEqUaaw5jgsGkHJRle7fQ8StSlN6myuwPYDBviqleBhc5gliKFyaFbK
 xf988IzZWKARBi4jFlcmjRfp13soxV5jgbXLpEzA1eH8yl/g/eLjMqtRUihZcrLmMuT
X-Received: by 2002:a9d:4c8f:0:b0:7e5:623a:63cd with SMTP id
 46e09a7af769-7e5623a9d70mr10059334a34.4.1779251883109; 
 Tue, 19 May 2026 21:38:03 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:35 -0600
Subject: [PATCH v10 41/45] target/mips: decode Octeon block-cipher COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-41-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
AES, SMS4, 3DES, KASUMI, and Camellia COP2 operation selectors.  These
selectors consume or update engine state, so keep them as per-operation
helper calls while the simple block-cipher register moves remain direct
TCG loads and stores from the earlier register-selector patch.

This completes the block-cipher selector coverage without reintroducing a
generic runtime selector dispatch path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/tcg/octeon.decode      | 17 +++++++++++++++++
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 662fa25321..cd4fc34d26 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -195,6 +195,8 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
     CVM_MT_CRC_WRITE_IV_REFLECT          010010 00101 rt:5 0000 0010 0001 0001 &cp2
     CVM_MT_CRC_WRITE_BYTE                010010 00101 rt:5 0000 0010 0000 0100 &cp2
@@ -256,6 +258,15 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_WRITE_VAR                 010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_WRITE_DWORD_REFLECT       010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_WRITE_VAR_REFLECT         010010 00101 rt:5 0001 0010 0001 1000 &cp2
+    CVM_MT_AES_ENC_CBC1                  010010 00101 rt:5 0011 0001 0000 1001 &cp2
+    CVM_MT_AES_ENC1                      010010 00101 rt:5 0011 0001 0000 1011 &cp2
+    CVM_MT_AES_DEC_CBC1                  010010 00101 rt:5 0011 0001 0000 1101 &cp2
+    CVM_MT_AES_DEC1                      010010 00101 rt:5 0011 0001 0000 1111 &cp2
+    CVM_MT_CAMELLIA_ROUND                010010 00101 rt:5 0011 0001 0001 0100 &cp2
+    CVM_MT_SMS4_ENC_CBC1                 010010 00101 rt:5 0011 0001 0001 1001 &cp2
+    CVM_MT_SMS4_ENC1                     010010 00101 rt:5 0011 0001 0001 1011 &cp2
+    CVM_MT_SMS4_DEC_CBC1                 010010 00101 rt:5 0011 0001 0001 1101 &cp2
+    CVM_MT_SMS4_DEC1                     010010 00101 rt:5 0011 0001 0001 1111 &cp2
     CVM_MT_HSH_STARTMD5                  010010 00101 rt:5 0100 0000 0100 0111 &cp2
     CVM_MT_SNOW3G_START                  010010 00101 rt:5 0100 0000 0100 1101 &cp2
     CVM_MT_SNOW3G_MORE                   010010 00101 rt:5 0100 0000 0100 1110 &cp2
@@ -265,6 +276,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
+    CVM_MT_3DES_ENC_CBC                  010010 00101 rt:5 0100 0000 1000 1000 &cp2
+    CVM_MT_KAS_ENC_CBC                   010010 00101 rt:5 0100 0000 1000 1001 &cp2
+    CVM_MT_3DES_ENC                      010010 00101 rt:5 0100 0000 1000 1010 &cp2
+    CVM_MT_KAS_ENC                       010010 00101 rt:5 0100 0000 1000 1011 &cp2
+    CVM_MT_3DES_DEC_CBC                  010010 00101 rt:5 0100 0000 1000 1100 &cp2
+    CVM_MT_3DES_DEC                      010010 00101 rt:5 0100 0000 1000 1110 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL          010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_WRITE_POLYNOMIAL_REFLECT  010010 00101 rt:5 0100 0010 0001 0000 &cp2
     CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 64f549f5ec..0037bd02a8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -289,6 +289,23 @@ CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
 CP2_MT_HELPER(CVM_MT_ZUC_MORE, zuc_more);
 CP2_MT_HELPER(CVM_MT_SNOW3G_START, snow3g_start);
 CP2_MT_HELPER(CVM_MT_SNOW3G_MORE, snow3g_more);
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
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA_COMPAT, hsh_startsha_compat);
 CP2_MT_HELPER(CVM_MT_HSH_DATW0, hsh_dat0);
 CP2_MT_HELPER(CVM_MT_HSH_DATW1, hsh_dat1);

-- 
2.54.0



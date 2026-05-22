Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F44CCD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJY-0003Ld-0N; Fri, 22 May 2026 01:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJM-0002yx-C1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:40 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJK-0002Cj-B4
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:39 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-484df1dce93so4314243b6e.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427237; x=1780032037; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n1K42f0gAukwwv6uNqW6nLYjU/l4j8XYoW2zZasuf0c=;
 b=eBovXL7hvd+ACXtSuVe6nvDle4CdfPk6gh+H+bC4/m3Nwg/TBWlCvjWBUQQc3c0s5G
 FFVAPFWsshqBQBCt0SrQDfXwaOgrEwK6JxFkt9EK+kf4hgKBEZuK99NwPe9Ynju9G+Wt
 AncXyukAZ5p+nyNhAFEnPpG6Fy8raZM5wJN8owtP4Xj9G2TTfpdaDWueuZCFc6J+yWFE
 Nu23K+GSP2UpsBGFJQqQpp9A6CnRM4GkpqdmegEolDyLVGEThNFgGgDAvfJGxEI+yzjt
 PmgkdOlQVv1+LJm5Re2S675L9OaxjWAcKydr32NSMtCZNewP5Bu4zLEVd9KVq6tRmGVv
 EUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427237; x=1780032037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n1K42f0gAukwwv6uNqW6nLYjU/l4j8XYoW2zZasuf0c=;
 b=VElQHb88Izwh2sKJZsS2iQ4lx8kJ/RfG+9G/x+w3F/bg4BtjGl7ZarnrDWRF7Fd1ES
 TDbR6tJxYRvsFpFTZ1wiL+phcRQdBWP6aCirsAObfwahJBc09GV1IU4ukRDnpNEp41bO
 VB7fnoiByMUAIDfjY4h5VLZLb/nNb/eVeL3nwl4/u2YWyj9am5DqH856bv7LU0m0TZHa
 lqxfKBimX5C7zhjQikdm1nSQC37MpoWh2m7J8uK9vlxug9Ti49PZbFsNefqKWWmJZXav
 IMhaE3aXd/TVragVTn95M1iSFWUupy4Y1ZB3ni0pXlEjiLVy5qMxas619YsPMQNSmYee
 VKuw==
X-Gm-Message-State: AOJu0YyRoIfHMCNvL27Dze039t3bGYRt6EHvP4emLEr1hXbNv0hJ9oTv
 8tV7FLTJ0TJD6RMqYrpupa4APCkrH9qV//M2Y6CmmkeP3ouVKeRvjmNh
X-Gm-Gg: Acq92OEnV3Adepsbp9yBx343xn45AugZ2z6mOVSpGRbW9kDSoP1BZq5iqU3+PT7YQZH
 u0p6FlIl6JJj32kxDAW3y2dslt6i14Ww8IxK/Yn/bGEGLsWAQOlK5dOX+v0KaBLnbVVfd/QsGR4
 0LXK3XemcgXag3WqUSCYKLW8OWqVbf19yWMc8cL4RwMCKMw8Dn9g3NjKEJ6IV3j09RB9p9W+oY8
 lbxdX7yOHl2KghHFcwPXwxncZfRpmzea2ptZ7pSYYOAvDKMtlfGcdS/OS/bmGF0f1dMeUNb+ed7
 OPvrIBXJCxOK87ERTuAP2mamJdtM09g1w7E4mcK5BGzJFdRrAwkt62m7uwHl6xHjYpV3kjEgV5c
 +8Yv0CjCRsPWDJSvJ0SBTUfnQP0/aJYnViLc8FqzwcPOV+WgWCGXukHJFMI2VkpWGWaOpi5M3nA
 toB0T7iAhV4FVBEBE+ud/dLMcfPkJjWizc69N0AldmRMgK+w7sVO3JOfdE/JKiSB2seXnmJf/Gq
 vyoLOGwuLchXr7Kqp4V2uggq+kVgF4uAZ7dDrUUO8llZ8/5400A0Q2enzhIKUyUZo9cFR1YOZ5n
 9ME=
X-Received: by 2002:a05:6808:238c:b0:479:2ef3:50a5 with SMTP id
 5614622812f47-48549ed043bmr1134851b6e.7.1779427236948; 
 Thu, 21 May 2026 22:20:36 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:20:01 -0600
Subject: [PATCH v14 19/22] target/mips: decode Octeon block-cipher COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-19-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
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

Add explicit decodetree entries and translator bindings for the Octeon
AES, SMS4, 3DES, KASUMI, and Camellia COP2 operation selectors.  These
selectors consume or update engine state, so keep them as per-operation
helper calls while the simple block-cipher register moves remain direct
TCG loads and stores from the earlier register-selector patch.

This completes the block-cipher selector coverage without reintroducing a
generic runtime selector dispatch path.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v9 -> v10:
  - Split AES, SMS4, 3DES, KASUMI, and Camellia selector decode out of
    the monolithic Octeon COP2 selector decode patch.
  - Kept block-cipher operation selectors helper-backed while simple
    register moves remain direct TCG transfers.
---
 target/mips/tcg/octeon.decode      | 17 +++++++++++++++++
 target/mips/tcg/octeon_translate.c | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 2b27fa205f..4ac38d264c 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -203,6 +203,8 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
     CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
     CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
@@ -264,6 +266,15 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_CRC_VAR                       010010 00101 rt:5 0001 0010 0000 1000 &cp2
     CVM_MT_CRC_DWORD_REFLECT             010010 00101 rt:5 0001 0010 0001 0111 &cp2
     CVM_MT_CRC_VAR_REFLECT               010010 00101 rt:5 0001 0010 0001 1000 &cp2
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
@@ -273,6 +284,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_ZUC_MORE                      010010 00101 rt:5 0100 0000 0101 0110 &cp2
     CVM_MT_HSH_STARTSHA                  010010 00101 rt:5 0100 0000 0101 0111 &cp2
     CVM_MT_GFM_XORMUL1_REFLECT           010010 00101 rt:5 0100 0000 0101 1101 &cp2
+    CVM_MT_3DES_ENC_CBC                  010010 00101 rt:5 0100 0000 1000 1000 &cp2
+    CVM_MT_KAS_ENC_CBC                   010010 00101 rt:5 0100 0000 1000 1001 &cp2
+    CVM_MT_3DES_ENC                      010010 00101 rt:5 0100 0000 1000 1010 &cp2
+    CVM_MT_KAS_ENC                       010010 00101 rt:5 0100 0000 1000 1011 &cp2
+    CVM_MT_3DES_DEC_CBC                  010010 00101 rt:5 0100 0000 1000 1100 &cp2
+    CVM_MT_3DES_DEC                      010010 00101 rt:5 0100 0000 1000 1110 &cp2
     CVM_MT_CRC_POLYNOMIAL                010010 00101 rt:5 0100 0010 0000 0000 &cp2
     CVM_MT_CRC_POLYNOMIAL_REFLECT        010010 00101 rt:5 0100 0010 0001 0000 &cp2
     CVM_MT_HSH_STARTSHA512               010010 00101 rt:5 0100 0010 0100 1111 &cp2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index cda9a0e0f5..ad71c0a8aa 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -324,6 +324,23 @@ CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
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
 CP2_MT_HELPER(CVM_MT_HSH_STARTSHA1_COMPAT, hsh_startsha1_compat);
 CP2_MT_I64(CVM_MT_HSH_DATW0, hsh_dat[0]);
 CP2_MT_I64(CVM_MT_HSH_DATW1, hsh_dat[1]);

-- 
2.54.0



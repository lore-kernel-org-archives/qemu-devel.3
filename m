Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4CACD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nF-0000Jl-IB; Thu, 21 May 2026 14:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n5-0000H9-Vg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:40 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n4-00026m-6A
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:39 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso5599434a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386796; x=1779991596; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YyAUIECeICv+rFq3df0wMc0ODSca22bLGZ+7lU79RDY=;
 b=Hxjz+9+yf6J6rzRzWyWi2nzl/983h86aGB79JS6kGZJmCNQVgOnh0HTtqhgSyuIHBf
 /BF4riF9y4RB6KlAlXagxfPd17RPdNwpQ1HHGWmSadd4ZBZj9V4pDmCgpf8FsNnDejax
 ZihP9cCBmOhXs40Cd3Q7wSCTYFXVt1tUjaUGnTi66ZQCmHvwC14SEaFu8OnGKS5XSoPs
 9sBd3awW1zdpxi3LY1nqO4RTqr5G5H5Ajxd3E0GsXDBhkdoN3fUCwbINe17oMeAZll33
 ETs0Qqe/2iNbaC89CWqeoNshnGQUMlDCklS+Euw9ygkzJpsUhdAbhqxBtf5MtRkcgYVp
 wrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386796; x=1779991596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YyAUIECeICv+rFq3df0wMc0ODSca22bLGZ+7lU79RDY=;
 b=R5dOt0TuoLdruRYMOxhEwa7vHoRdY2GBQvHREBid9+I6Zs/0BvN7zZsUKsNwRPhai2
 ButwXmf5ckJ3fcIkDqw+XnNKAjOmwYR2hZA7h0Lj/rIIjT9NtS4mt37NBUzli9wMHoHL
 UwptqtQohiL/YdFuaKbxOge9OrbW6a3MyWhqqRXwe57mm5CXwBNPJhWnBSEM8kcqK8q0
 y+sROD+qTfPbinEX6XhjsWub86WzmOfV3IIEJCm7jwdLmkTclv8Zr9OyLNDXS7EC5oVn
 i/vg/5xf0fUg0BZ4I9ael5kPwmpzFVWfp3ll3iQWP9HspgDKesNIdtD5mub8f02JbXxQ
 +R7A==
X-Gm-Message-State: AOJu0Yz4aLNp095QL5RR+xGaHTCAkR2n1e92saRa4gG9/u9/u3pRo2E1
 BpkeH6zgQAn7kWq6dSbuuVTHP1mzjXtBwHsiNCxsSBaBi9aL4sJ1KNfb
X-Gm-Gg: Acq92OFB4jPQwWPGsGzosScG8VqzbWBGh1ai91WapN8/q8ExfNwfCe2n7S3vvCgpSgS
 vWIq1YlIC/ZjcHMMRpaddriBJ0eFwvV+WBpViet2tkT7J/xSZXYfsYH7h/1DVueERMn8gCKrTbj
 TTSbAVHC+J+nFeoLQ6qrV+gK7r2e1f4+gjCQc8ZncJNOcRkMH44OpEPuEqdYCT02O3vg0jO7yY/
 TRIM4MDl6SPGCzWq1j5NkEXsXqgKXm+bBepvXnjnOsgQU4JWd6uV2oPmNdF/Oqh63Q69tZkbrb3
 KJIV0jKLyBvPWw/sYkOAHljo93h+rKdjGkxjmPp1jUUh2yAJDip79Jgew53bGCsPeTF8s1+x4Qo
 ABhXlyaaj527rHGgXEQNhs6zfpIe6C1OtIMOekPaii0OAXmmEcBslLwKuI9MHstddrncoy3PANu
 hhLZrd69z6w/1l7k1ZzD6+FywM95D49Sc9M0aJURKtv6oJeprAYK9gZZZzWV/KY1BrHlf+y4l/S
 71nPFS1thjyQm8GSoyY38sNMO/ENXawv70wlxq/3Ni14RAynJQTuUb+s5bN33E6gSmg
X-Received: by 2002:a05:6830:6d4d:b0:7e3:ef86:19f6 with SMTP id
 46e09a7af769-7e5fee50b9amr130032a34.8.1779386796296; 
 Thu, 21 May 2026 11:06:36 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:12 -0600
Subject: [PATCH v13 19/22] target/mips: decode Octeon block-cipher COP2
 selectors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-19-5a4cb8ec9cd3@gmail.com>
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
index 87d98673ba..9f2905795b 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -196,6 +196,8 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
     CVM_MT_AES_DEC_CBC0                  010010 00101 rt:5 0000 0001 0000 1100 &cp2
     CVM_MT_AES_DEC0                      010010 00101 rt:5 0000 0001 0000 1110 &cp2
     CVM_MT_AES_KEYLENGTH                 010010 00101 rt:5 0000 0001 0001 0000 &cp2
+    CVM_MT_CAMELLIA_FL                   010010 00101 rt:5 0000 0001 0001 0101 &cp2
+    CVM_MT_CAMELLIA_FLINV                010010 00101 rt:5 0000 0001 0001 0110 &cp2
     CVM_MT_CRC_IV                        010010 00101 rt:5 0000 0010 0000 0001 &cp2
     CVM_MT_CRC_IV_REFLECT                010010 00101 rt:5 0000 0010 0001 0001 &cp2
     CVM_MT_CRC_BYTE                      010010 00101 rt:5 0000 0010 0000 0100 &cp2
@@ -257,6 +259,15 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
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
@@ -266,6 +277,12 @@ LDX          011111 ..... ..... ..... 01000 001010 @lx
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
index d1db676c17..41bfcc47b3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -293,6 +293,23 @@ CP2_MT_HELPER(CVM_MT_ZUC_START, zuc_start);
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



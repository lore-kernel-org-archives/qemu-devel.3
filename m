Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD032C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jl-00010X-UQ; Fri, 28 Aug 2026 18:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jk-0000zZ-Gw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Ji-0004MK-KK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1028556a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957097; x=1788561897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOeZvVD9ayER5VsvPnM2GYqjFIb7dCUMmqokgi1BWGE=;
 b=Ga4FnOcMbcPXjWeMh2aqQssdEE918+ssJMll19ULRegI+2fnM5eruWu3zAaftoeR+3
 ysFwdlR0x/cwXMYh7dST2bSwSF14f9h8DI7s6zkCgllXK6GkSK8HS8Jr/j/p0wsuFCHF
 Z+JyEcg3sZMa5x0pi++vdBvCpPi3FX8YKKIYD/RcOSvrLV2iNi6w42ozmzkNSV/dm6PJ
 QT9Bi2PyJBKUlwUTzgGXwnkvc2ShWrjsGT6P82+zKnfeUQ2wMoa3Plxf/OuLA4lGDn+O
 cenAhO+COUA98+x9mBpVtmPZkRBcgfv9tkez35NmaLn7ZsEc2r4jhfEBPwslraOueFaI
 Yo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957097; x=1788561897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOeZvVD9ayER5VsvPnM2GYqjFIb7dCUMmqokgi1BWGE=;
 b=T91vBl8mf/SodA864809zxLRtiZdjF8Z+GIJBFiFZtfMAj20ukPPyFLJaQsm+ZFBEM
 r+Nk+LOWNgU0Rl6B2bnBRnwGOXndCHJWQW65HtzdAIMHN1VafF53J3V4v2UQ9gJrJClU
 2IR6l3rjIBF7X/Iv7W8A4W1tDreheKgfcw3D57kYz4gnsoHHWi3H3Eat7N/OBcMssfIQ
 AFvT6M37kHpL0unJ+IMxKbBc1IFRUFYfrXQrN/oCPYPG9beMyDDBJmk63PLYrfJcsfBB
 0t//xGkLjBOKrl+eC5hY9MlIyITWoq/p63go2yL2+4VstojSnG3S9Y5gy/rTGzqg14OA
 EPhw==
X-Gm-Message-State: AFuF++kcIVYOlZnKfwycnrfzi/z+oSz+8IMFTTo7YZkzHvRQhlKLSigX
 2VTn9PImyIUxFvJgvybjiddYcN+t8QD4dBXJKQ+xiYQAKqSRFGnmL9wxNmeUfDsV6y6/nclblJ/
 5+Z+/acw=
X-Gm-Gg: AYBFou1M86vOIGf6LuasA2PhRctb6qG9Gllw9x5XZ5+vO4DA7c4dl5AaEOhO4sECrao
 AIoduyzmhf9OugFpHO3pDAnkjRYN1calqzyHRDFpiDRkBs08yn0R+Qw5EiboqkGxttARuWfSAE4
 vBWhpX8kW1bk552mV6RxRNshieJe645LKtjKoZisP3perG4+OEZ3mqkt1/2IsL1maHtuS+Iwrkv
 nNay69risPoGhmMDKXrG1w5iNhJ1th6ePN9sTXHjCbnA0JG4+F5g3IeQBwxUT6c5wGpUr4GD43s
 1oHAos9n0D6OVm9uz8ZZ1A4k/2hJY9nyKKoTbdu0hvbBIGemoC3E4omnENWTtKQt1qHK91KTeLc
 KTQ+HbDfj6x7+rPGWXei+xaX+KeAPujNVO7NzRXWuBtGDUPF37AvZZOOPhCGN6kXE/QJ8rWz4ko
 sORRauiQSqT3ur+R6pFSJkPBVMU+fKopA6Kqvp6edT/HKflM9XK4F4XkmYbKsjbAIa3v9lxXk99
 GZ5pQ50b4SclVeswHsYrg==
X-Received: by 2002:a17:90b:54c5:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-396d0e5ccc7mr20314641a91.3.1787957097261; 
 Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 05/16] target/alpha: Use tcg_gen_lea_i64 for S{4,8}ADD{L,Q}
Date: Fri, 28 Aug 2026 15:44:40 -0700
Message-ID: <20260828224451.1564072-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c146..6f18b8d1af6 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1474,10 +1474,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x02:
             /* S4ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x09:
             /* SUBL */
@@ -1502,10 +1500,8 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x12:
             /* S8ADDL */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(tmp, tmp, vb);
-            tcg_gen_ext32s_i64(vc, tmp);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
+            tcg_gen_ext32s_i64(vc, vc);
             break;
         case 0x1B:
             /* S8SUBL */
@@ -1524,9 +1520,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x22:
             /* S4ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 2);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 2, 0);
             break;
         case 0x29:
             /* SUBQ */
@@ -1544,9 +1538,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x32:
             /* S8ADDQ */
-            tmp = tcg_temp_new_i64();
-            tcg_gen_shli_i64(tmp, va, 3);
-            tcg_gen_add_i64(vc, tmp, vb);
+            tcg_gen_lea_i64(vc, vb, va, 3, 0);
             break;
         case 0x3B:
             /* S8SUBQ */
-- 
2.53.0



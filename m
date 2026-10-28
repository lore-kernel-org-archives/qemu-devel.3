Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F6606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FpyyLctD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aA-0006SC-IR; Wed, 28 Oct 2026 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a7-0006QV-Ih
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:55 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6a5-0007W3-Uw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:32:55 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6d68de53053so662109eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205173; x=1793809973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pgqHmLtxUI+2J2wQe5DSkZKh5v8ZwaNLONboGey2duQ=;
 b=FpyyLctDBNnjXlTZQx9m49Pq3PCluIv6gmzUXqE5EuKPkn+VcxTKhqUDlxXcUqL+EX
 9C3Teig/6yDIFwntTL2NBs9pQJoMMv+oDtb3a1w+CUh0c7dTN5GioWSZWTL8QlSHmZqx
 w0IFaYW8PbZdSqdSQGB6iocOFAfJ1mSGJ+pau5hHsPyvfkRBaFgIyCs9O0cCVJEtx51R
 GplvPy0xLx64DEbhQO8/qPKJkF5NDXCieDBPUMkqtuLbFVCcMJSuz3pYEce4uxIOhrX7
 fCOSB9Gvm3X96JF4NyNNdJn66DaIkyFYdtqNR2a19Pb3XDvmISA9ldSFtR5rtaddj9fA
 Pexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205173; x=1793809973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgqHmLtxUI+2J2wQe5DSkZKh5v8ZwaNLONboGey2duQ=;
 b=a+7cwqmpJQrfi86WSzbMbi5/mlmI45lH4pkMnfzHwTgsIEhQaLmm6576wumOa5cEBO
 Q1Bi+G08S5K6wyPngnoJL24TL99H7X0iJ2BECgFxYmEXs1feDncExvwvtuE2feh44sCR
 JiQjWaM5nB9qKC4rhaYl3pJIIX1Itm+HaTwjd+td7KRYJM4CerGjxa16N9mk1UAle69T
 FW1bLzNux74ZW2yIAbnFHSYz6psh9rM3ce6CJJEPjIojjFYgjaMy0Qqtx7KyNkIVwm/a
 ge0EL5qjarggE2kPdi9aCLaNhFGVJ5wq1+3edAj5nKaJxKX1HkoBIEjcZRslHBPmDyoJ
 ocng==
X-Gm-Message-State: AFq9FYJkbDDYH03bx+nsS8UzwmSdn3lDeHIRERv8sNyg/E+JaOksy2ST
 J8eJcXtGhhLQ1ixidpcogOh94Dr6j/Fm33VohiyKI6r+HmqXFVjN6u2O4kPYIpAyY598itnCrAT
 x2fcO
X-Gm-Gg: AYBFou2CWYsrSg3QIcq2AEOmjNbFlmafCikCrpwMdffBnuXIPrb3XMP72++SrDhZIJu
 n6mFs5nK9VJY7gkdCkfthLVuubXaYwMmkvgRAPclJOZLuuB+xEkH1tjR5AKQNpQb+Wy5Q99GE3Y
 FOgPMJPSz/W8LotwdXRxRvp+W2TcOJ7b1JvNCLjjvlM8QRv29iNGjVfuW02h3PjSAmaelzrgwyo
 tzojaaiMCumbFsvBI6G62enRSItimcCyeeObPKB9s2SWgrjTiyWr2kJtnGXeio5WRVHsfxezvK9
 36KRqrtuK4xhxeGHfm1mxModVNnWxtF3PLLGTfijkDo8EH1yVz9enVsITnsFjjLlbirxhs3E2Ya
 9x4kGtskQT2Hl/qt2/f6QJz5uTbIBoPFbOy1NHBluXpfozcOsAB51wCg1EcYT15FM8rZLI/HHkk
 7fvsJoyyUbWv/YzNRPJTp1uWtTggKJCt48Q6jTzkwH8WNMsxJv9v2iiRlUK0wxbhkoaChIkr0yk
 PmgPsDGPHcjC2kC0er7eCZjI8B4B2NLYxcfOwwfG+IRPn3fyZZPgX8E68maZyUh2dpxOrOBMNK/
 lTnvQbAAZK7XBWk3QH8Ws1EeLCL2MHaqwQ==
X-Received: by 2002:a05:6820:814:b0:70c:b3c9:e413 with SMTP id
 006d021491bc7-713ec609c46mr1596542eaf.2.1793205172674; 
 Wed, 28 Oct 2026 09:32:52 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:32:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 04/16] target/alpha: Use tcg_gen_lea_i64 for S{4, 8}ADD{L,
 Q}
Date: Wed, 28 Oct 2026 11:32:33 -0500
Message-ID: <20261028163245.1031673-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c66e3f9c14..6f18b8d1af 100644
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



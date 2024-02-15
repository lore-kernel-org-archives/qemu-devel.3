Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E9C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYOI-00074b-Sm; Thu, 15 Feb 2024 04:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raYOH-00074I-MR; Thu, 15 Feb 2024 04:50:49 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raYOG-0000hI-6j; Thu, 15 Feb 2024 04:50:49 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1db562438e0so5292525ad.3; 
 Thu, 15 Feb 2024 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990646; x=1708595446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv3PHmgqVfkG8uzr9jgyQ4R6Dv3vpujqMroYjdaFpA4=;
 b=jSB0eKBZVOI3rjKupGnUdRu18DJXm5GsCbpelVQzEAtLH8vBMZTHmHQk+4cLsKI37A
 aMIlZifnQusMS8ruShaWYQvMi6f2pXfuoGbPkvsIKZB6uuoAP+cjWHiF2uXM4UzOV5Oj
 0yU1y+vowY1CB3xIKURW/Dj7+eGLfK9C8JeObKciquc+CqbiYyKF/tVAzdSLosbd2L4Q
 x4xofWpfymAHeemeiIwXAXqq4/9Q8/BXEiDttGAXyg/hZfyiGetDIx0wKXc0Nd2DUnJ7
 rm38WsR6+GTxzZqQaXYSAoLXcahuCCQ/3C92hgBLnYfJcDPMulAz23SVQjmFAjumpL+y
 LhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990646; x=1708595446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tv3PHmgqVfkG8uzr9jgyQ4R6Dv3vpujqMroYjdaFpA4=;
 b=pdqd6KNqcLlucm03krtzoTCqb1J+sCEmzVBgt1IE2Nj6dznGUyfRv9Ij0g2L/5nyzf
 DpeWt3D0Crcb8cQqmNB3A9G0EXxe/jdUelWbQjFT46d0Xl/TEUgGWEZVGQZ9wVFOBfGB
 EOcOG3doBbSn0+/OUy7EO6d/YAdKLW9vEWrND9VyvfwFdqtRmnWPpzAq9aTW3177/g/m
 xeYSk1o4G0IbHsYimoA1XdYCE9BCu1Brts41VAf7wnheY+ussh/aIOwKm+6s+QD0t2jG
 B3IQacRLqMb1uioy9+Z0yUgZlu4LhV8Lb+3g69REk/8g9YNYB9DQNssqHoxbaIjrLCap
 8tnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQb0FN6GwB+hV4pTJ1kI20SPrf2OswPzRXXP4P4uL3gBsduSiTswlmvgfLvBHPpRZ0FY0wAJ/BpVhafmSG+WGzjWGazA/Lkw==
X-Gm-Message-State: AOJu0YzEDMu3u+XORIUJHX2cMDWK4Vx1+LuLVSKbOQ6aIcerK7GReNTT
 j2DMGWUh/b4GmcEpFvkOqixL3HYOCVAoHDEeDnxvO5F+FBiWb5C4e0oHMfYrj1A=
X-Google-Smtp-Source: AGHT+IGShBYkHjz/BJIIVjoiM2ihjKOrUBsPSfr6Ystge7AwGQlNQ9uUYW/fZnweppLdI9c5jYy65A==
X-Received: by 2002:a17:902:76ca:b0:1d9:b739:a5aa with SMTP id
 j10-20020a17090276ca00b001d9b739a5aamr1137788plt.42.1707990646004; 
 Thu, 15 Feb 2024 01:50:46 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 a10-20020a170902b58a00b001db839b9e80sm863966pls.286.2024.02.15.01.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:50:45 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/1] target/i386: Generate an illegal opcode exception on cmp
 instructions with lock prefix
Date: Thu, 15 Feb 2024 17:50:17 +0800
Message-Id: <20240215095015.570748-2-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215095015.570748-1-ziqiaokong@gmail.com>
References: <20240215095015.570748-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

target/i386: As specified by Intel Manual Vol2 3-180, cmp instructions
are not allowed to have lock prefix and a `UD` should be raised. Without
this patch, s1->T0 will be uninitialized and used in the case OP_CMPL.

Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
---
 target/i386/tcg/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 10cba16256..07f642dc9e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1507,12 +1507,13 @@ static bool check_iopl(DisasContext *s)
 /* if d == OR_TMP0, it means memory operand (address in A0) */
 static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
 {
+    /* Invalid lock prefix when destination is not memory or OP_CMPL. */
+    if ((d != OR_TMP0 || op == OP_CMPL) && s1->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s1);
+        return;
+    }
+
     if (d != OR_TMP0) {
-        if (s1->prefix & PREFIX_LOCK) {
-            /* Lock prefix when destination is not memory.  */
-            gen_illegal_opcode(s1);
-            return;
-        }
         gen_op_mov_v_reg(s1, ot, s1->T0, d);
     } else if (!(s1->prefix & PREFIX_LOCK)) {
         gen_op_ld_v(s1, ot, s1->T0, s1->A0);
-- 
2.40.1



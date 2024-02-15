Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A6FC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabmc-0003i0-98; Thu, 15 Feb 2024 08:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raY7Q-0006BV-Kk; Thu, 15 Feb 2024 04:33:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1raY7O-00059M-PW; Thu, 15 Feb 2024 04:33:24 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1db6e0996ceso5359115ad.2; 
 Thu, 15 Feb 2024 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707989600; x=1708594400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv3PHmgqVfkG8uzr9jgyQ4R6Dv3vpujqMroYjdaFpA4=;
 b=kaf89E5dCTboMfiDCbvXWe7qwOwA25Bu/5UJlBADHWXQEABnhM7AK0RUa+3UxWeT4h
 FncN/aaStCQzzxhmu15XUE1O+BwX/QzdnzBNmtCWqGJ6XBwIWTfCDaTgpCYTnOfug2vb
 JHWZOXShIVhMGufDFRpe4QCSKgNMAveAT6bLwXwlDk1jg5gmlOrrHSV2G8a4KNjqOErx
 e7A0MN1Jc9qPtBMXRzexLf3xz20aMJoNzereC2IdDJAcwuTayeWPRuGGuT5VG+xmWJA3
 mynhKKHloWodMqmfdyf5ZIch/5ZPIpkbyczuop4YJQR6/z6wBLEQb7tfa5MUk18pPcHf
 F5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989600; x=1708594400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tv3PHmgqVfkG8uzr9jgyQ4R6Dv3vpujqMroYjdaFpA4=;
 b=S23gxJ9skcxGntTPDLr4pI5Y3PZzDeGsylNLh41UcJCJE1+wZwpWp0GnHknIiQIS0Y
 EnlEW2669hQtiTNzq0nY1UieRsRks1wL7vT6TkLK/6tYmUL1niHXsnbTvcTyLiI822T+
 s9PpkVlmoi+CW5j2eOjmVB32El/sWzDx8947AYvFlpWxXuQx969Doo2o8bodJeSBozl0
 iFwlpZZItcjb4QEtVq+BGtIKxRr/SsiyCoDhppkLLZfwRK7pJbXwKg/qRr2Wuetdex4c
 UlB42B9YDiQ9gXNa7m1bj+i3i3oPJMEwx82MeVVHUDDwpJM7OPWTqX8CRsN7PSfR4/OK
 seyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrCMdyAg70bfzpNQPGI0wrX6p1CXuyyhG7PZtpskwrfG5DSueWugLItdOxA1fBiukrbxGZp8bxUzMkek3fKa/NbL/1v2SWPA==
X-Gm-Message-State: AOJu0YzgbdIJLCRNx/eMJ6quQJ4ex77yBxaaxixj632B0GzTjSo1dI6g
 6Ck+blmduXYL97nWHwBDer98M52/nkWapglvWQx0XU2DKU6zCgSfo1BMvru/f3Q=
X-Google-Smtp-Source: AGHT+IGmGWm5jLDgBO4WN6v9j4eQY18Jn8o/gD92rvgUAIlcFUHEPpeljDJsr4OXsfcbdN9Mea4EJQ==
X-Received: by 2002:a17:902:ecc1:b0:1d9:bf01:165d with SMTP id
 a1-20020a170902ecc100b001d9bf01165dmr1443962plh.10.1707989600466; 
 Thu, 15 Feb 2024 01:33:20 -0800 (PST)
Received: from station.lan ([155.69.190.63]) by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001da105ddf65sm843936plk.232.2024.02.15.01.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 01:33:20 -0800 (PST)
From: Ziqiao Kong <ziqiaokong@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ziqiao Kong <ziqiaokong@gmail.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/1] target/i386: Generate an illegal opcode exception on cmp
 instructions with lock prefix
Date: Thu, 15 Feb 2024 17:33:00 +0800
Message-Id: <20240215093300.570141-1-ziqiaokong@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215092908.569947-1-ziqiaokong@gmail.com>
References: <20240215092908.569947-1-ziqiaokong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ziqiaokong@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 08:28:07 -0500
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



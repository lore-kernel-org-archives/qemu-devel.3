Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60DEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTgK-0000GA-GZ; Fri, 06 Feb 2026 16:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeD-0005Qb-RA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:58 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTeB-0002dC-HN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso29853495e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414349; x=1771019149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/R0Rm43UcqDxFYwh8NBoG1T+JArhkplFlAB9wCZ/B84=;
 b=xxJ9jLNZ7ooWL/axlEqQLsF5X3TZF1fKkA4RonzR2ayOXSrSrkR71714nbJBncLlmB
 eBmfTKCVmoVm/RKOLSmYBImBxv8bS7CmVxV/qh/OfR7k7ELn0MXHH5J3pTzlS47MgwfT
 Yvrun7coOiUePHT9nWCDi1orzzhme5zvphr0b5Mme16fXmSwp9zWfmN4yk5+6/Qt8f7h
 z5rlOjDlSWT//4uEd3NNya9smKP/0gvGu5vO3oYt+a1G3r7hRc7rYqgioXBAmjal7d52
 pDOb16BXEeJ2ncqetY/CVgQdNutWEJudnFTl6dfdswxYc4LJyElNw6rsqT6d0urRtO7e
 j1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414349; x=1771019149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/R0Rm43UcqDxFYwh8NBoG1T+JArhkplFlAB9wCZ/B84=;
 b=tPASvf4qnlV33UWtAVLKmtgit6rFc+P2H8vK7X4pFBSUVTuLabwAOfORSMfV0/xE6Q
 eRqS9XGy1KPJD5xu5m2gIy6+JQLiaaQ/Su6+CfSI/1jk3OEWSv+2mI8FvWl81Yj78L38
 +DS0OmTmUfdkUuOOjXFLfjvbprXB1Qc2UAUPqSua3f53PLVhRc6eG0B1mWTQCWvEmkNM
 WOHGVlP0hiLtMTTTAQDibnB3rBJGjTHiK50CigNgyypWkJcbKmxLw9VxLNI/DxShr64x
 X7Clx+22xOOm+aes/L1nuG0OO5oxyrQ7JNt6JXes0GkqlbQwJUX8v18ZbU7r7P0qIclk
 z1WQ==
X-Gm-Message-State: AOJu0Yxy9dzxL0as13QX5LMnBtCTI3ZD2SbnZ17u5k14UYiU83pYRqeC
 9i8rt5rrX35esYBRZMK1c64l7TA4vCqZdzSEIwcfOCmNKrFUaHgSDmCCn488EXHj7XeWJ1oeMFQ
 PBElBqcw=
X-Gm-Gg: AZuq6aJXgJjzDBXrZLzXzQlicKywyOJoMpDqi1pvpCJK2sk6M+U5ec9Ffb4FfBEPUP7
 ITqCFdNjQiCM5KIXHoRwcIvj8EAQbjjp9Mh25b3+rn2idJFE5L60ZUdCuyCzFUqCFeUOwQX+tIc
 uZ0bzellXRYoiTwW9le4u/PLq+rZ33HHVbfjW6z2Nw0i0SIOzZGAAWheSnh0KRAoq5IiHAI3tcw
 J3QAIAGBCEhRJQ1xNHnbneIi1/EYUwJLeKwR9G9BYLM7uj6D3+Vs9AxoEHD4201kDZ+kk1mNgdB
 jILglopnvuoh8mId+Ln8tHFPDNw97gGMTPXqp5Mo0ZVk7UnWOtmdZMuSf82cd7h2B5TQB3320XP
 vMTOWYWNN0Kc5dONMKIEt7tSzE9kYJV3tAPlGMiP+ZiMLY2CRBGPBZ2Fq0bKE5mtzKBrmIyNvsN
 iqc6la9idMqY8NNhBnq3CIsf+DMgLVuq2g/qOhdgq2vNnGQu1ouSDY0SSTeRfM
X-Received: by 2002:a05:6000:26c4:b0:435:9e32:2b85 with SMTP id
 ffacd0b85a97d-436209d1156mr13175730f8f.29.1770414349479; 
 Fri, 06 Feb 2026 13:45:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa41sm8595100f8f.23.2026.02.06.13.45.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:45:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 09/30] target/s390x: Expand TCGv type as 64-bit target
Date: Fri,  6 Feb 2026 22:44:27 +0100
Message-ID: <20260206214448.22008-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The s390x target is a 64-bit one, so TCGv expands to TCGv_i64.
Use the latter which is already used about a hundred times in
this file, and is also more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260206181953.18683-9-philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 540c5a569c0..437f5a4aeb7 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3142,7 +3142,7 @@ static DisasJumpType op_mov2(DisasContext *s, DisasOps *o)
 static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
-    TCGv ar1 = tcg_temp_new_i64();
+    TCGv_i64 ar1 = tcg_temp_new_i64();
     int r1 = get_field(s, r1);
 
     o->out = o->in2;
@@ -5743,9 +5743,9 @@ static void in2_a2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_a2 0
 
-static TCGv gen_ri2(DisasContext *s)
+static TCGv_i64 gen_ri2(DisasContext *s)
 {
-    TCGv ri2 = NULL;
+    TCGv_i64 ri2 = NULL;
     bool is_imm;
     int imm;
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EF1C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uerg8-00025N-80; Thu, 24 Jul 2025 04:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1uerg2-0001zG-JA; Thu, 24 Jul 2025 04:51:47 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1uerg0-0005g7-HU; Thu, 24 Jul 2025 04:51:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-553b3316160so727252e87.2; 
 Thu, 24 Jul 2025 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753347101; x=1753951901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OPIxdBYnhuclbLht9t6EtWZfDez/9GhRUEOFNKEfVP0=;
 b=TW3H2SY6iIbJHZGXSc2XTS75JjkKbqilwcWcW7wSR49wSHuL8blMhAfVqbLHoE5Ntj
 To7MUV59NeC5VVMy246yWKJPSbzmZ3ebdAa8Co7DKTyI7PM8LhU5w/8lH+7DTMY/m6l8
 ThTV6RR2NNq671Hu+WSK8M5sLvWukaZfL0FHIfGqJj8dvqYO77a1uYdEuFrCJ/ZgABlB
 zjPH9AVie1YCTeGr985qf9tHtukaaUmQkDU8Ci+XeqnEdaz6E2hAHUTrgOSV0A1Q+73e
 spzM2C7o6EowldhX86+BLjtPk/5pQqyBhZGA7yy/OoyFDXSl+Jul3KwOIMnqKMPnRZky
 Y/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347101; x=1753951901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPIxdBYnhuclbLht9t6EtWZfDez/9GhRUEOFNKEfVP0=;
 b=WoW6cur9C81xey2S+ARsjqTXSVfPYG61GdR1o+SWo1E7GhS43fAIZxjVqyrPQtYumV
 v3kVj6gc7vFGjYxA13x6n87MYr4Ik39txaYkAlM3tkTDd8MW88TBIVkxxIV7b94cTXPh
 vWtv7X3fXKrVpeZGlC2uYF8FgRh1h/o3PolYAGEy8aK9/xVIhw4wL/QYHQyUFganwrbr
 9ow/dHvVltKvk3DWRPe2kubsGt7+34sRTSLUcjlkq/NyhqhvgfJWDodzO/rIeQtQ7Hnu
 YjFo485VV0v3TowcahTuRbQhtdno+fMuXtSJIbInIpouk/FRvbQbR3VxA7qP0ir7LsEc
 pVTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFk7xx0/k8rPZWmlB+MyDgTJdmqEaiSZsZTDmXuD+0L+zijJ98CbzyrFzocOegjVjPLoWym0moeg==@nongnu.org
X-Gm-Message-State: AOJu0YyRLsYAFxqjT/tW7F1mW1t5t9XrJ+2h2cpfC+tfR/E2mr3XWm2h
 y+4KUsaDKLZzfYakBr6SJ5Th1LI6Ysn01evJercsaUTUEc7BoWWo9wRpxdTtAkfpMgY=
X-Gm-Gg: ASbGnculhaZI+JVeqj+3AwGC4/VJYmrTiujHgU7hh8A/FEqL3SGu3Oe9Ilb0KXUbt2n
 yVYOA46yxaUvhznk6D/e8rDwQD3+wN8oYUuBGuoNgsdwrv16wexQahG5kVK7ETebxB/e/GG+dJJ
 oBmEgO++7skw/Z2CS5TE/sgdTmKN8xQBHUBzne8stMT0M841Y9ZQPuq/L9WkfaH0yVFKkAveZOe
 SH40UclG+PtQhZXcmTv5wGUSg6mcJZcMjc+18UwakJjbi6tr4A90xqQyMB7zJX/cbYSwS7wSfrJ
 BIvbjf8JxU65jx1ZJyRVnv5Zjc7QHmMrbajWwZrmD5OqINS4GZlb6m+mVOQCjpy5kHavKmZiTS7
 X5B+rRkW6U/eFhufG6xtXBKw2Xjf4Ap6oe8PS2eD2Vxs5
X-Google-Smtp-Source: AGHT+IEHtrDV3Ln7HGYTOhAmtb1VBCFzgvZ7458RSnL4XMhwe65U/A8oFkSZbNSNqb/Z8c/yEs5s9A==
X-Received: by 2002:a05:6512:ea9:b0:553:3492:b712 with SMTP id
 2adb3069b0e04-55a51432ba9mr1781298e87.54.1753347100976; 
 Thu, 24 Jul 2025 01:51:40 -0700 (PDT)
Received: from rbta-msk-lt-106062.astralinux.ru ([81.9.21.4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b53b21f16sm254940e87.26.2025.07.24.01.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 01:51:40 -0700 (PDT)
From: Anastasia Belova <nabelova31@gmail.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Anastasia Belova <nabelova31@gmail.com>, qemu-arm@nongnu.org,
 sdl.qemu@linuxtesting.org, Anastasia Belova <abelova@astralinux.ru>
Subject: [PATCH] target/arm: add bounding a->imm assertion
Date: Thu, 24 Jul 2025 11:52:06 +0300
Message-Id: <20250724085206.22398-1-nabelova31@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=nabelova31@gmail.com; helo=mail-lf1-x12c.google.com
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

Add an assertion similar to that in the do_shr_narrow().
This will make sure that functions from sshll_ops
have correct arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
---
 target/arm/tcg/translate-sve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4..47ada85c92 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6250,6 +6250,7 @@ static bool do_shll_tb(DisasContext *s, arg_rri_esz *a,
     if (a->esz < 0 || a->esz > 2) {
         return false;
     }
+    assert(a->imm > 0 && a->imm <= (8 << a->esz));
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         tcg_gen_gvec_2i(vec_full_reg_offset(s, a->rd),
-- 
2.47.0


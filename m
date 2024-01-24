Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B5C47DDC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSY7g-0001WY-Ay; Wed, 24 Jan 2024 02:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7d-0001Vw-Mb
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:34 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSY7c-0005TA-4h
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:56:33 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cf205dc075so3504761fa.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082989; x=1706687789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UAFRNBO2Tg6jJU15Vu5X8vfpHirwIVtsoqw3WJyHnU=;
 b=TzhirdQcnd3OuB9y7bAlT+MuaM5EWgRbcLRBUxDPE9W2+XSsL8IkkHSDJ9Mgk6lZHd
 23lnLBbTBUwHjOaGbfhMjOu4cziJjCEVjquH5tK371NzqzV2ozRUIZdtUSc5KA8dwFir
 JwpnELd5SWP+PrrX3lhbHi25BjWNWJ033FIyjjR+QJBG/k5yCtMBdA3BvRhaS6/qodB4
 Bpa1KHFE5x1L3qVJKH78HDSiif7NQfRpoaeiE3DZnt+5NQ7VFOk1mbYxAk3KTd02Rgxh
 ffeQZwhvuh5Gc1iUGtQQAqjjlxHncuFHSQgWt8/qMRsFDyWHXxuMg9kHt5ri8Ei3wT3p
 Zd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082989; x=1706687789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UAFRNBO2Tg6jJU15Vu5X8vfpHirwIVtsoqw3WJyHnU=;
 b=kF33Oa4BrPDtMcXvj14KZ/QlW3cG7xYGYiKE8+GSA3exhyMWw9o9IHpA8Zf0viAi1x
 /Mv9cy2U7rxhabOXKhhg18tIFawgbHC5Hb8XRqKlOqFDtxxq35YaYCpXE8zoAg/0XJ0z
 m5p7YnzUznqGGXWk54pzRJM4iMm324gpYLfXJBQg1wkMv0Bvv2ql+B6Mgwub0Fe9aTBp
 vj6+WCxTavznErTezHH10XXStxZBEUqKnFW9fS9A4Sd9jd2jl0fGMHCFK4WWy84UOLBv
 MCOEs5SuoqAJWgblHoVGVFUgomNiEHTEudDiuiAKxux10caKoPX2D7MgUXYdYpMA2QTd
 Z3Vw==
X-Gm-Message-State: AOJu0YyL/JaGhtkmKxsm5TwbQvA3EX/4BtYKXEknErnPh7TtpI8pgZ2v
 RjavH/k3wvQMgGzoSLBTKwFGa4o84cWTtdw4YeTn2X2VSx2gnV0l/JV5qFawraMeyLoTb2E076u
 y
X-Google-Smtp-Source: AGHT+IFT2SHvkYnHPK08EOVgPygSmADRJc8DMUU/1G+eZfqI/dR2qCgCE/BsZQqrdX0h3kVYvvh/NA==
X-Received: by 2002:a2e:9f10:0:b0:2cf:1b2b:6a75 with SMTP id
 u16-20020a2e9f10000000b002cf1b2b6a75mr551515ljk.22.1706082989046; 
 Tue, 23 Jan 2024 23:56:29 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm5279952edb.48.2024.01.23.23.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:56:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Wed, 24 Jan 2024 08:56:08 +0100
Message-ID: <20240124075609.14756-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124075609.14756-1-philmd@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Preparation for moving perf.c to tcg/.

This affects only profiling guest code, which has code in a non-0 based
segment, e.g., 16-bit code, which is not particularly important.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20231208003754.3688038-4-iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index ba75c1bbe4..68a46b1b52 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
-        } else {
-#if defined(TARGET_I386)
-            q[insn].address -= tb->cs_base;
-#endif
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07680C7115D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT834-0004pR-U4; Sat, 21 Jun 2025 19:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82S-0002JG-4d
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:24 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Q-0005Ap-FW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso2302927b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550061; x=1751154861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dy0pFrjcrPImorTeOO8YBwX/NoIgEGH35FwoJ9o+55U=;
 b=tQDOjNC4cNAul00KswIQ2hU7fwrN55v01ee+i0OpuHEEWWHA+Q4k/9Ej6gPIHGxK/9
 zYu0+juPxQxZSnXEdxM4r7Yq+IfXL16ee/YzpjV4pon+wZjjfw9HhyzhfG8+Q4qr7JXw
 EKuCLvK4sX2McgjbeB2SpcgeX4dBJrK7fch7w7BU7YntkMIJTPkVf3KEZsRSxR7O/f0N
 xDZQLKlADXsTVi9sLqlgUKgqME6TU3Ibnn8ztLhBFrPBbgkT7Fo5q11OKBssg3W/Qup9
 bgsYxTM+3nZNnYConmRCPyrFoxkJgDwiWKRWKCvrACdiXo+IZKcUtxE9ofvkAJBPmTnO
 IRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550061; x=1751154861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dy0pFrjcrPImorTeOO8YBwX/NoIgEGH35FwoJ9o+55U=;
 b=jUMZ0WgF9WEt6PvEHYFnpwdpMeYylfVmvmtAMZmrenw8zOMqeDzzhFDhi8+VZU765J
 JorBhj9xlJvraczi2yDrKAT19SHw5gW2tDhXzVP3/e9dB2GkPeiue4slwIXtL25C/hp8
 GP6wqeth5Xsd4cq08wpvDf/3scnyvuhm6x/MMCgy+bBzLVaAPSU+wsmi7LemBl/z2MAN
 XTwL2Up37fK8zDHO4Tw5CSCLzaoIXpk75iJtEiz4Y1uGzY4yXxvLgKfSMz0ETMfRsW4u
 7fW3zj48QzC2zYQT4jDQrbwKohIg8yrIOJvLV7ATAGZ4K0V/6AHXfw30tIeYFda2fTrd
 KdYw==
X-Gm-Message-State: AOJu0YyfAKKsfAZL7uV8LleEfRUZfokbFe+qegc4b6BPw0Bx6JuXAkBg
 4KhWNbtAvyen6+Eg4s0KWyEsn7aO1apbp3PpdR8NSNJbpD4P2pdFc4izFPXwWcozTJd6WLCOD0T
 USN9h0iU=
X-Gm-Gg: ASbGnctfJifFLp7Air6Dn+QKjE6o1286nnFd6Ph0ecQOBr32r0NAbEpA6hSNwiKWJ3J
 u7b71xncEYR+5qvvJxmUIeoUOkP7aGPBq9A5zMVDiOeEQ/C8p11s/l09X8HDKq1pE6ZWPGONchq
 2zt/yHU6RK74SEDzocgftc40bPxQmNfLHW0jTbmuhwh2+gbZyfJH/b4M6BSTJCYEMLxN3StX7jX
 P0f5DA1yji3iDOjsCZN17z7VajZFLxX7YKeDhdMt62QDWPYw0cm0yfbejOZ+4SaYPcdU0/qx4vC
 P/m3nFoTJjW1OPlNmRC1ELkvDkj2rDwCB0aZyxOi2P/DGu0H9fRvddyJ1AabzMotU7fzyYeVZza
 AuwnRZRB97dEtdoVqJ14n
X-Google-Smtp-Source: AGHT+IG43ECHkRJG/8/FsD0LwOrEKYnY8GSrC/yN8DibF7cJiBY1iuDo8Q0DAkit3KE4pKOVE9Cv4g==
X-Received: by 2002:a05:6a00:2d09:b0:748:e8c7:5a38 with SMTP id
 d2e1a72fcca58-7490db75aa9mr11140183b3a.23.1750550061181; 
 Sat, 21 Jun 2025 16:54:21 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 066/101] target/arm: Enable SCLAMP, UCLAMP for SVE2p1
Date: Sat, 21 Jun 2025 16:50:02 -0700
Message-ID: <20250621235037.74091-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

These instructions are present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a854c40ea2..abdcafd952 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7328,7 +7328,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(SCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
+TRANS_FEAT(SCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
 
 static void gen_uclamp_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_i32 a)
 {
@@ -7379,7 +7379,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F64E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26m-0004wR-Dq; Tue, 10 Dec 2024 10:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Y-0004by-Ng
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:54 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26X-0008Pj-A2
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:54 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea68fc1a7cso2448301b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844292; x=1734449092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aaGiHH598Jl9FQV/d2zCwuAFTZLU17IFqMDcPvq6uL8=;
 b=FzVcsxy8JtWzb+YetDI7ycqUKM0SwBoDduwpEwMolupgmcDH2zcinzaSP3COGpy3z0
 c/JJby9XE7LKg+qJXzO2hoIpIJ6jo5rl3iXir3madMiQDd7dDVBeqoWcUcS2kjDpiF+N
 d1ACYMIvqwge+TzGdFqz/VuPNMjIGZYV22uEl3+Wh8hZlsYNgFeOO5vQ7E+QWlY2HIsH
 xYZxMQcwkp4qpb9P/5mKijrdxReRuzFZp002mAKiB9xJr42sDoLOm/00cAvuEKjrWUfd
 QtWhUFXVSs9w3cp0q5cjttO61efsoxtrA6Bx8qe2HUvks1o6dqd58sJjnWiSqCj/4noD
 aYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844292; x=1734449092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaGiHH598Jl9FQV/d2zCwuAFTZLU17IFqMDcPvq6uL8=;
 b=b0MDMxMoWUgFZ3FL0oiMANnvnD2Ea6YiU98eOh0DEKwvyWx5eLb9eTx1Q2aDE0/JQL
 niWwkZhGfKW1dg+wBN3k9EY9KAXI+8w8ygLKSV0VpLL7VE1BwdMY/u9Ed53V+7HDOu0N
 CBvlK/scDgyipETqKYg1PmWOJD9eM25IC0d1+nt2mTCrD3ovfADq077I+RD9jiWWW3Dt
 I6sCyFLE1XEsgMlJlWQ0I3b8do5WahNEsZbWd41VEIJIxSZxOghcTlfiKwYS2xI79kjl
 PUh4lzb0f7rGpFymBF8pqvRkPXOQJO486IKQMM+60m/YP/ZBaN2MXyZH9Jc4GDcUTJUy
 p//A==
X-Gm-Message-State: AOJu0YwisQXoNlJMdX8awpEPN283oADxjhYMuePzoFePMRfeit0w4to5
 jBJLob+Obvh52vOvvDtJo+RdttkqDD57z67NeLZeW3Ac+c5fCJw4RjR9u7x+AkrXzE/k3mXR/z9
 QOmcNVXVo
X-Gm-Gg: ASbGnctO8CRNJiyG6u/fYEKqLoAWWP9GYbvlLOcitYHC+XgJxUQ8h0v1atpXpOPmdeo
 Pxne7LRVPKDiOgj/7Y+rPpDCFmzyoIJXyYYeu3zPAWlxJ9jY+vZVXHyoBvpu+MIowcFCc4aeb6x
 c23Lc+db9pHF6oizFNGSGcqNLS7DiU5+2BiA+i4j5Is+WWpC7UCbUevyW/zDtu1TGDdGrqdmhBN
 Qwg1rpf5TgaHvZs2r3Ow6btENqwpl9iAJ8dy+XHqt0bDc8YTr6p68LpB9TAvA==
X-Google-Smtp-Source: AGHT+IFXRL2a1beAO4nUfZpYmul0PIccc+qBP7F06Nzc9qa2raba9bw6TVNy33tCX3NZpUfExOk/rA==
X-Received: by 2002:a05:6808:23cf:b0:3e6:2889:585e with SMTP id
 5614622812f47-3eb66f6960emr2299528b6e.38.1733844292076; 
 Tue, 10 Dec 2024 07:24:52 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/46] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Date: Tue, 10 Dec 2024 09:23:50 -0600
Message-ID: <20241210152401.1823648-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 30446baabd..c99e6f79d2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2483,7 +2483,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
-- 
2.43.0



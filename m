Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF5E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMa-00007Z-Vj; Thu, 19 Dec 2024 23:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMR-0008Tt-Fc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:35 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMQ-0006PB-13
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:35 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ef89dbd8eeso991730a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667892; x=1735272692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyALDr2SSgMlWiOhgKYyIJNrGLip7wIlDdGWsxU+U4Q=;
 b=DdUv2GFDSgcWEy4Vlz8F5x+VkFOLYT99Wq0rNbml40tuNJqbCDUJtHwqGHLMNJ1Wwe
 S+6oCqhj7iqh+iL3IRKjfWS+ENaC6P9MWSjh158X2Wc5OCmGKdHSS+Zip8S9Q5PiO8A0
 YEUiUhE8YF7tCK7+tTdl/xI6UmCQRWFgs3LJM6BxbDJG5NsEukQovGnG8lHmsV3HKx3J
 16iaYzlwRSCE7b9HpageL2dasvgSvSp8CHpF+DwMTKv/OUZyYIUeu4NQkLTSmtF0KRyp
 IddW6fcnWM3ealtDRAbY2JnqkfPb9+A0JNcrjHElFJS93XzmA3lA7cN7YA2IyGpEFDzx
 drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667892; x=1735272692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyALDr2SSgMlWiOhgKYyIJNrGLip7wIlDdGWsxU+U4Q=;
 b=bzDSQ3uMDiecm3hLBGej/E5c7a8xORs8rMq+ANQIS51pHC1Hy6CNV93Z8kvjjv8Af7
 JUJvTpRVOYh7NJagoxTmXlArIiUqYecTT6qezCbnwpjQiVJbsnxto0YyIqgxD0pTmztg
 4k6DYOO62Ja2e7J/S+1OHiNFSIZNPwX9QHKRx6eZ7f6PsymMer2w13CZ9hp3sTd4pi9Q
 LrbnZwCU9cTaPxvBU0GPhoAGjCRWAGR5tCbJmK9YbN8emhLyHhcfmO5x3Fxor0HTTXVO
 4OcKbESxDeam4+zeho33O0fny+wzZu89eqB6o23Q2Ekbaz7sQZh4P+LIdPNQX89sdZM4
 t91g==
X-Gm-Message-State: AOJu0YyU5htGblIzxQT121Q3TJrj4wWprL8elvyFsXX0oa9SwKpKOmry
 zxCu89CwtGwqRJNEGTL08PCOC10Twq61GcyXqgY8UH8bLrlhvgZM3nTQTr5DvPVUMG8bQ5i/qxK
 m
X-Gm-Gg: ASbGncurF9aRbkFFrO4nzt9qh1UOUvmAyj94Yn5n9x8pU71tcqqglQAmm5hoybfmIqd
 KqxNwYWtgO5AyeHFCtPkvXsfl/1fp6rMYsZt8hgxe5qxut6Vj54qorEuBA5Q5+NAnpQ38I7J8rX
 BFkCiJf/ePsoaEFM2z8rXU2cFKqrbRPexm5NmKZg7a5rtMpidV42HDRrlZoqOGQHe0jg92eJblE
 Sv6AWWGy/8ui8G8tkNWz7JDpyavDxdcZ3Gv/ig2541bw50LePezn9F6RI8k9OY=
X-Google-Smtp-Source: AGHT+IHtjW+xuZwdZxhbDNRhtgSUinLpwcfBprWo1TaXNHBd/lUB3xKgVwkSBgkVIlAnVXKhkUKJ4g==
X-Received: by 2002:a17:90b:54cb:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2f452e22555mr2825610a91.12.1734667891830; 
 Thu, 19 Dec 2024 20:11:31 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 36/51] tcg/optimize: Use fold_masks_z in fold_setcond2
Date: Thu, 19 Dec 2024 20:10:48 -0800
Message-ID: <20241220041104.53105-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 63f80efeec..a7f37a1e6e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2485,8 +2485,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
         return fold_setcond(ctx, op);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 
  do_setcond_const:
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
-- 
2.43.0



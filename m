Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D1DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 20:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg9h2-0001wO-Ah; Fri, 01 Mar 2024 15:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9h1-0001o9-0I
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:19 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rg9gz-0006wm-AN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 15:41:18 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so2958512a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709325675; x=1709930475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxuLBWXx0IJuL3Uf7q7zzjCB6UIN8ow8n3bSMH4FIK0=;
 b=vCQcxbCzb9IUDfgIJaUVxpiBWHdP6oUPwNrBihAGMHXywUU49zTpG38F5+Cq7CFkZl
 7J9Hy0l25G12FWSGODe5+wSr4LFr5nhQLxsn4/7F79PUclMKjuZG/GexJpH/Cs5l2nLD
 6NhVG+fhu69sgMDjnlPgWR+cj3ixqcEd1Vzxrezxgt8hJQ/PoCXGc2Z5GL+4whEiGLgU
 6Lqv/YqFWa7Zbc/9WKnDQKqxOpfM2QwgHzduiO7BaDX56odgncFVhiHBf3tHKqzmMJaq
 5ha0pcOJdk00vChV1b4M/6kLQgteyMWOuRGkB/vJZEWma3+dulB33BGRPadLWhH69U0Q
 px9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709325675; x=1709930475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxuLBWXx0IJuL3Uf7q7zzjCB6UIN8ow8n3bSMH4FIK0=;
 b=OQWlXFBwMu1Iq14cfGYkcdMvQS5fx6jzAWZlT5IP06wfB48vSKuse3Br/3iO6aNbhe
 0YvP2/UvuQXRr/jTFsV2c8EhzEt2GNIX7DHaMQGBN1Q5xv9IDd9gOGYgtuPM9rbIvBLp
 wTGT6Ms7H5XFIXV4Xqbqg5XyOacFg4WZ1/U6cT2tm4tagZ77DpM3NyNhUTkfIMl/vWAA
 AbYLLbpWkHe0f9gZm1wwZDAvpiI6baKcYfrrRgUtDAWKBo5QiLj49+9HFK/alCQvwic+
 sIXv1s2aAZZXF/XjE99om+MPFD5YiC5z1W3kyr1IDo0Iv8+D+5lc6iD7Ilo3ifK0RVIO
 bH6g==
X-Gm-Message-State: AOJu0YwkcFe+s3bS9chbnN6wXMbpHNt0seHofGI3SAjf6CMw/vy4YYqC
 obGgbGwRqgECid9v/Pdcz+nRXHgHDcwa2abUha244prUDvPzAD7EghTSz8SpF+Ert583WYYOfJ0
 D
X-Google-Smtp-Source: AGHT+IFjt518UjS1xlN8kWJTPyVg1gJMEfCWQH9UJamHZNlPA51TVw/NJwu0rkC6J16YKofIOXNnag==
X-Received: by 2002:a17:90a:4087:b0:29b:9e1:2fb0 with SMTP id
 l7-20020a17090a408700b0029b09e12fb0mr3841181pjg.0.1709325675031; 
 Fri, 01 Mar 2024 12:41:15 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a17090ac58300b0029b2e00359esm681947pjt.36.2024.03.01.12.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 12:41:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/6] target/arm: Support 32-byte alignment in pow2_align
Date: Fri,  1 Mar 2024 10:41:05 -1000
Message-Id: <20240301204110.656742-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301204110.656742-1-richard.henderson@linaro.org>
References: <20240301204110.656742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Now that we have removed TARGET_PAGE_BITS_MIN-6 from
TLB_FLAGS_MASK, we can test for 32-byte alignment.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f947c62c6b..c8a2470675 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -900,13 +900,7 @@ static inline void store_reg_from_load(DisasContext *s, int reg, TCGv_i32 var)
 MemOp pow2_align(unsigned i)
 {
     static const MemOp mop_align[] = {
-        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16,
-        /*
-         * FIXME: TARGET_PAGE_BITS_MIN affects TLB_FLAGS_MASK such
-         * that 256-bit alignment (MO_ALIGN_32) cannot be supported:
-         * see get_alignment_bits(). Enforce only 128-bit alignment for now.
-         */
-        MO_ALIGN_16
+        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16, MO_ALIGN_32
     };
     g_assert(i < ARRAY_SIZE(mop_align));
     return mop_align[i];
-- 
2.34.1



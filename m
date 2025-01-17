Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B077C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5j-0005Q8-6m; Fri, 17 Jan 2025 13:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5e-0004xe-AN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:06 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5c-0000FF-4k
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:06 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f78a4ca5deso1118782a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138543; x=1737743343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NPfmN7vMo+libG/5c+CuF6EQ8tBzjs2DEYBljqFu3U=;
 b=rySccsW3oRMJ2umc/HyGR/sQYRUKrBNxVjldTYe4eaaB131v8OcltddA8CKOnIjP54
 HNcGywq+gCrxbrwDF7F1hhIDkHQxNQ/uGjX5qyqE7sSs6lXBLQuRl/q6hUyiApoKbj4/
 fwTaY/0YtJEEwzu7QEtZrMZqOXtAm8nWfyYfsFM4MOz+4MjRyFeDL6rdOCbwQaaa/tVH
 3Y5+NoaFPdZmzS6aT3qU2Jg2D4DM6sslhZquURZEPr2s8DNOm3tB82u1onvaZy4SZzDa
 80ryaBVbYQ20ilqpcn9OJX8gOKpTAiJfbamF6Pmc87+eMM2EKWJeLTcuhwOc5RuVfI8Z
 W8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138543; x=1737743343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NPfmN7vMo+libG/5c+CuF6EQ8tBzjs2DEYBljqFu3U=;
 b=RWM1fkfdPMp+U6DcybMJSRtf+BhW3YuLFVXoLdvNdK3zrKTzDwU4sx7Sv6TawWRmU1
 FK8Z2eAGsuJ9Gol3sr3/1FBQb1iwBuUOgf3eNgRt5LnNBADsdXKXBGEYwKvZiWhRUB8I
 a1qELHHAqo1E+m76/4agfx43gDkcMB7owsf/us/MTH4SUkC2k2bdLEkxziht9k0zmFKA
 dqNE7QBJJsdQq/RlA4T0jhKLuTgTk2vKSmzV5eL3w6hWjQpTLYiNx7qH3BhxjslOg8Kt
 Lu02HZYYFzcZmo9x17mCtbv8H4TRdNi0f98RTLlptaXt9Xx/Wa2DrVWOfTwfxF5I6q2A
 bxag==
X-Gm-Message-State: AOJu0YyRlSztVlAY0YmNlL2W8xr4zT7y0I8rQJdsctM4HEw4mtJqcqsF
 6bf/YvQoT1ABz3T59vfwJFgvI+TcA4OOjgD3yndhpXI2fy2FaGQ2YEKeiEDtA79ohcLkT+FE93s
 B
X-Gm-Gg: ASbGncsGS+aeMNNISdZKvZyycC3h221fSLqUngwI2J4mo09CKvWTf9G0bIDVaeqS+nQ
 6us8yRrlzdUkyH4XXgmFJy28z1AX6WDHHlRLh1p6BYqOyLQJL79vnmL08IU5qqukmP5ldLlV15w
 jQPWxEbFMGxEEWwcNzTJHLYcn1oB1G+is2r19B0Pnwfe5URfDtECNMwKhJbafoRbLbvE/XCHxXn
 AmX3p4b+bvZt2OYKo6rzpo+4cmnmw1hTeuPq7rSAQiOHkIXrLZ1udzju2MUlvFdjB1IhO3QDNoT
 I1Gx0AzeWNvcIkc=
X-Google-Smtp-Source: AGHT+IEHyxMl16cxzxxsGA9PZtvlaRSLntZk+pQesmJPx7JyOt6yegUQiQKhexwDikQP/DVE0JFdrg==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dcf6:1c77 with SMTP id
 98e67ed59e1d1-2f782c9cb1emr5784504a91.16.1737138542916; 
 Fri, 17 Jan 2025 10:29:02 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 50/68] tcg/aarch64: Expand extract with offset 0 with andi
Date: Fri, 17 Jan 2025 10:24:38 -0800
Message-ID: <20250117182456.2077110-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

We're about to change canonicalization of masks as extract
instead of and.  Retain the andi expansion here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index ede6f47235..66eb4b73b5 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2450,7 +2450,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
 
     case INDEX_op_extract_i64:
     case INDEX_op_extract_i32:
-        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        if (a2 == 0) {
+            uint64_t mask = MAKE_64BIT_MASK(0, args[3]);
+            tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, mask);
+        } else {
+            tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
+        }
         break;
 
     case INDEX_op_sextract_i64:
-- 
2.43.0



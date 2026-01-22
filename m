Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D1DD6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oN-0003Ag-4N; Thu, 22 Jan 2026 16:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oK-00037v-FZ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:49 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oJ-0005I8-5c
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:01:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so10650165e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115705; x=1769720505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP/MTK8KNSVzyu6zuIe3MwXkpcWMuvGz5r3wnr6DkDY=;
 b=y9ydfgaKkNuku19Qf7HxyC0fAnVrRKnV/VMZos1WX9lJvJtfwwxdaf/ioa43q4UWvg
 yCuuAGIoS3YgQzo/Nv28m4cRlYXkZMeCiE935jUrOqTxlh0eMA16ANmZaZSdSGvb2zrz
 JbxYcijbVDH5L34fI43msstlPSEC/QCF/cTAWPq47/Pa3zQljZSP1Gpe3KK6h0yLw/oP
 p2im03CMOA3FAOEvAqbL//ASpPLtzZ7W1+SUmVc7oX88uZCna07w39JQgEBFPF7Dp6AO
 aVzJR0ADQuHw/OKsy4FXoBTqV3YwV+D2tFLBW/0ztlBw1oM7t9WQOA1Ep8HeI6zDDHjw
 9eJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115705; x=1769720505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RP/MTK8KNSVzyu6zuIe3MwXkpcWMuvGz5r3wnr6DkDY=;
 b=JZSHpgZ34WCcdoJ3NFuuDhYc33fFC7iLLxbygj0hc6GEhuOpVqQvgjeXGvWMJjMEok
 KbnbTF+vBhzwWgrp3xvtsr2y/n8Srf7zpvWLCwNvAk68uJPppEbix2BwzeTmP7TtLUAq
 HG8k/zRemG0zrYDaaT0eiYA0cvTbJAK5LS3mthJogyPIMhKHaJeabJO2yliQC9xQvlNa
 3qtiJ72rc9NFBvhhFnLO/VCSo2Bhbz8iL6UqZcz4fieXmq4HdwA0HsVaOCqTgW+uA8b6
 jMYyNqe91pIvLWcSGSwi84Aim0bp741h3aUy9i4MCYG0wUC4u1NbFNxVbuu3NLG2ojiO
 KsCQ==
X-Gm-Message-State: AOJu0Yy4Po5KLDZrWkuZkEf3mC0pXSok3Vkxq6aFLsyiHalCpbmSqbFb
 HZKVSk40lKmEe3z+OWUB6GYPWWhqHSvp0uu2pmcqN4KxFX20aIymdVx4dIhQerSf/GzbDwl+Xp8
 325m1wiM=
X-Gm-Gg: AZuq6aIqgtl+JYAc4wZLsYBPcsAitM+ky7zL9ulM3PNucM3d1tIv1HdHAXA0mGEr/aV
 rekrw1cPl0zmlBS9Jq7mDYK3jGZoNMA8h4ikSwssbQ4cHOGZGgnIFSTXVkAqYWxNvfjvoGjWPJk
 TrPe5p9lF/UQnmgAByVQqbN0ZgvpJZJRlx0QAMnZia9Eh0ihYXq9fOQX8hdeh6o/qzCpu0x5G6o
 RbUJTJ2h/t8dBO9S62KYoWDvSD7IIGQLmVMFn4Fui6QfN6WfHuEXKn5MADth28/sDfagylJLK/s
 lq0xvopy+Orwo6eu17GTpwrT5YyD9N87u2g0JgQNSNqj9+9IMUhgBTLqkV1nX+6rl30An9XYeyz
 vwjpFMKcFIUnY8pVhC0U75Re+NUYVoCOIERBfTvQ76oYrQBlkU6AH9qK30kEHrBcQuQ52++P8oR
 qXGTYUbAueGhKVtX+0n1B7eq/sRjHN7Sn2bJH7W5aiOMTQpY0+LTKc4uYBjlK7
X-Received: by 2002:a05:600c:8b77:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-4804c9c1352mr14543145e9.28.1769115705382; 
 Thu, 22 Jan 2026 13:01:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c9cesm1309415f8f.41.2026.01.22.13.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 06/11] target/ppc: Introduce ppc_code_endian() helper
Date: Thu, 22 Jan 2026 22:00:56 +0100
Message-ID: <20260122210101.55358-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Introduce the ppc_code_endian() helper which returns the
MemOp endianness for the CODE path.

Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/translate.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 17e6d07c8c2..4a9199a4473 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -214,14 +214,15 @@ static inline bool is_ppe(const DisasContext *ctx)
     return !!(ctx->flags & POWERPC_FLAG_PPE42);
 }
 
+static inline MemOp ppc_code_endian(const DisasContext *ctx)
+{
+    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
+}
+
 /* Return true iff byteswap is needed in a scalar memop */
 static inline bool need_byteswap(const DisasContext *ctx)
 {
-#if TARGET_BIG_ENDIAN
-     return ctx->le_mode;
-#else
-     return !ctx->le_mode;
-#endif
+    return ppc_code_endian(ctx) != MO_TE;
 }
 
 /* True when active word size < size of target_long.  */
-- 
2.52.0



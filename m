Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE9EC25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44Qe-00074c-BZ; Mon, 06 May 2024 15:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44Qc-00073Z-4u
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:55:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44QY-0002xt-Tl
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:55:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eb24e3a2d9so22743555ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715025308; x=1715630108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gCKDBZgmkxkw60aZ1JTPBVFXSTJpz/Y7AMgu8NmXySI=;
 b=nDhqmwT/LkzTo94CTnAFhjCQ9BGoPSgpaqYgSR4Sdbo5S0evYDt2x/yeYZVQ6LVX+X
 kYnTPmYNZpfNd1riFXNshi9/EdDqT6ApTDhh8w81UFSfTunIuy/PS5BQxSm0fNmDKcUP
 z0B+UNOQi4ZziBIYCrXCRSoBFbYe7j2Fh5RKmkvIiIipJLGE382eXXrA0Q/aA4yBpdD2
 2ARHVLHP2bAPSL4giiGVeXsrNIllIb3516I/5ygQsseORWNwIZIEf/Q8yLelkluiZEdh
 UOoh3oNTjU+DBfIzqCOftMI6rm9hHu15DDnguEh2g4PTw7QZ6XXbED8ygY8Y9wK5krHx
 EPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715025308; x=1715630108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gCKDBZgmkxkw60aZ1JTPBVFXSTJpz/Y7AMgu8NmXySI=;
 b=bJ/9rZX9AQkhEr69RAMUKxjCUB9FygAA2EwYY9xV3i/uLqmRKwqkumvwVC/M+H93Lk
 ev5nJSwfujKPnssn3OJRLM0c3NglpfSufxV2OrUMXtIk7Ujc7eRLUNSpaINg2pWa6HzA
 7+56MtfkWPiWNC5n1Tu4LZlb5QKPi1pM9+4Xcj2sh+udZ7F4fI0KEQH1F/ggE/Xk7NxG
 LeKwDPXVfKgcTJiYWx7REKQyVrJ3miXJIC8lkuGD8oCdwxiz8MTgVfltLZJ5qSdQ24kx
 16T8LagfuN4T4XenQa5/i7SZbRqi/30RhC7VaSgMgv5on2PfQPPpWaYqijpKHf7U5gfU
 IVXg==
X-Gm-Message-State: AOJu0YxLy8vfPD/4DzW6IQhU7rK+yijyt9IEDrSpW5kg5V9QyrVZEKtZ
 NKRQigpe6uxoE2UQYyBY/54GMoWkBVlPFHZlYKXUu28lDiwP3srFzrGmE9GMduIn8BUbJWF+Nub
 Q
X-Google-Smtp-Source: AGHT+IFLZnDVSNAUVfQwOw4MgWtpvtQ14ixh23bJhlDl9/6I6GaVjvZHk4di37fMp4X4cuKC7QxFOQ==
X-Received: by 2002:a17:902:d2cd:b0:1e3:e1d5:c680 with SMTP id
 n13-20020a170902d2cd00b001e3e1d5c680mr15821044plc.63.1715025308341; 
 Mon, 06 May 2024 12:55:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001ecb2179da6sm8638576plg.56.2024.05.06.12.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 12:55:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
Subject: [PATCH] target/sh4: Update DisasContextBase.insn_start
Date: Mon,  6 May 2024 12:55:06 -0700
Message-Id: <20240506195506.385921-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Match the extra inserts of INDEX_op_insn_start, fixing
the db->num_insns != 1 assert in translator_loop.

Fixes: dcd092a0636 ("accel/tcg: Improve can_do_io management")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index e599ab9d1a..b3282f3ac7 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2189,6 +2189,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
      */
     for (i = 1; i < max_insns; ++i) {
         tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+        ctx->base.insn_start = tcg_last_op();
     }
 }
 #endif
-- 
2.34.1



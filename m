Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB6FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznv-0005B9-0N; Sun, 30 Jun 2024 15:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznP-0004sY-TL
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:07 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznG-0007V2-0N
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-72ed1fbc5d9so1491061a12.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774055; x=1720378855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+1cYfmSMutOrFAkzzUKLrm39z58ASnq++T0AOOpk6g=;
 b=U7aX3bfDwAghZZN2+vPibkGoFG8GBHOolcFthgzMF8C532qz1i4HGfnylp1EmSpmEG
 Z10cARe0nhNqPBT8TsO+WWjmofXStuNNR8KS8SeCPYemHJMG79JShWvvRksBl0UGRl1J
 YwILhgTt107uNz2sMt6V8jVi7ieS5sxXFT+3TbJirpqBeK4qANF5s3LZRuaVjDd5hk1Q
 Os72wyLGtMq8F35H/H7BfYhwGW5lj/8+hS+s1CNY54Z9+G2P6RPkx9Nvi7ihJDmfuCMp
 ybNWfXTwqSGCiPCe5po0W6Hta+qPbE4JcLwJMk4P2BTYqB6eO4x0SdYXN5Ek5ffLZMKf
 Xemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774055; x=1720378855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+1cYfmSMutOrFAkzzUKLrm39z58ASnq++T0AOOpk6g=;
 b=TDbIrce6EB+iSnPC2l+Vlb5W6iAmY1ChqDIHE8H70XQvKXtSWuck54+08N7uxTSYJk
 K7+gZ7tiGWD6eT+63hl9T1OIjYGmrEizzXy81Tat34+AMt9A7AE7YAwVnaIh5acr9m97
 XYrHls4cn3inyXb5u9B6UOb8K6E1ky3pLqu0HEByINznoOp2IyFbbMX1dpne65jOxHoe
 58/xjtWFgaRAon9tWatJrGEymgb3xK7JepZ72+QTcb2KRJZZ0hTrNR4QRBSVMIAZ2Lf7
 bnQzlCbNCXgeIEfL2daJzNZo7jlEzvZfKcioQDZL19jCCX5npoQh0qvTzXenv6MBwbvn
 qwjw==
X-Gm-Message-State: AOJu0Yw+bvPBeH4bI5uDH9oTz7+HGjhUZ3RKltU+gkui7Kh/q9fW66jb
 946zj+dF8wI0gTT12k3tZeD3OgUkj5aPbzMh02UQlLPGlv/tJBfSK+AmmE8yAzKShMAMQDdafXc
 /
X-Google-Smtp-Source: AGHT+IG2B4Je/WhspfUwDslB/opXv1xJ49qrKfJXLO5CtdGqAD+mtkJz5qsM7LVb9pZmHN0VcDgv8Q==
X-Received: by 2002:a17:90a:7185:b0:2c8:1f30:4e04 with SMTP id
 98e67ed59e1d1-2c93d775c0cmr3473732a91.36.1719774055501; 
 Sun, 30 Jun 2024 12:00:55 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 03/14] tests/tcg/aarch64: Drop
 -fno-tree-loop-distribute-patterns
Date: Sun, 30 Jun 2024 12:00:39 -0700
Message-Id: <20240630190050.160642-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

This option is not supported by clang, and is not required
in order to get sve code generation with gcc 12.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 39d3f961c5..dd6d595830 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -39,7 +39,7 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3 -fno-tree-loop-distribute-patterns
+memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
 TESTS+=memory-sve
 
-- 
2.34.1



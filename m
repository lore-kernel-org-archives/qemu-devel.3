Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88BEC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglR-0006B0-K1; Fri, 05 Apr 2024 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglO-00068I-Ns
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:38 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglN-0004oh-29
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e74bd85f26so1768847b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312735; x=1712917535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tA0b/fSj8XfUCrgQgUfiUA7OwpX6731DGB+eq9CuhnA=;
 b=TXzJT5mU1jTutnVstrqZgjKzyYKhxgeJKH1pQoOjGRst2PbiqcEYfIptSndSKHVYjb
 m/7YXp2qgsOx0PFm2i7P5/PHBnkgu/9ldRa2E9wW4VJfXPc0Z3853OH/Yq6gUWq6ZQhH
 npF+J/ucxhFa9hw3Jl4UKJDtmu1coKQ4P59ld+7OV7m6/Jij/unC09hq8ymY9QdkmANu
 Jm89VEG2XpVdKCeAUMAAVl3pk+xBk5hR/lb/Rwnh5i5vxlQEdjkBLgP2ou9GsZvPXXh4
 9G3ZU0frR+pdhbne5SQPxutgE7PK2XtAEi+TjOEJRFfTxFovuEUj5wnupmnhkcbJG9i1
 OxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312735; x=1712917535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tA0b/fSj8XfUCrgQgUfiUA7OwpX6731DGB+eq9CuhnA=;
 b=ldKfToy62ODbHapaO/2shP/vK2pYlgkh/sDfENB9rMKzCn6Etw9CbEM14XVMGXLgKS
 weqitIORj6qXbFMRmSVJ3icVaHRe5PZwBjh7FJIV01F7P3AW161YpRxJUg0SvJGSCNqc
 7+HpKSdXnYMblYs/hKz8RNHzZM1adyrMP8BnN8ThG7sC5xXUhCPkApM49Km1mLerUQ6z
 fBwi8HjSHGS/u4i5TfqB8qFDqkOnyJIPbsjpc1n0Kl1JKNqVYC1DpxdtuNx4z5P3RbMi
 /YF8Gy9/8VvtD6SIDtygnV38/4OrPxBMSvmpwYUem2g99MJT85WmHTVwxP2l/2cNYCYF
 93Aw==
X-Gm-Message-State: AOJu0YzT++ETQjdLTZg5u0a9eC2Blhh57HA5xH0aoIod1o6R5Jus2EQ+
 wRlQtAtRYlz67wOMTpIQu1l+vbHf5Cz7dKImWUq/v/4aYuJgHHxHyY8HEtZAukDrCAlVMglDeFS
 6
X-Google-Smtp-Source: AGHT+IHV3F/mPK3Jmog3yvO/vV0r3VPNFqE9GaNxJB6E+snzY+yaPlBNX3+7vFauiO+9tQ+pZuE52g==
X-Received: by 2002:a05:6a00:23d1:b0:6ea:8e89:7faf with SMTP id
 g17-20020a056a0023d100b006ea8e897fafmr1086111pfc.28.1712312735300; 
 Fri, 05 Apr 2024 03:25:35 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 26/32] target/avr: Use translator_ldl
Date: Fri,  5 Apr 2024 00:24:53 -1000
Message-Id: <20240405102459.462551-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Cc: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 6df93d4c77..2d51892115 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -24,7 +24,6 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
-#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
@@ -173,7 +172,7 @@ static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
 
 static uint16_t next_word(DisasContext *ctx)
 {
-    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
+    return translator_lduw(ctx->env, &ctx->base, ctx->npc++ * 2);
 }
 
 static int append_16(DisasContext *ctx, int x)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327E4CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLI3-0002ur-QJ; Sun, 22 Sep 2024 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHJ-0000vj-Hb
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0002NR-I5
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:24 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso586408666b.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006480; x=1727611280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWl7Xv2JGXBckAdLaFuhNWtujP2/LH0xkeEqhVhx7Pk=;
 b=sTy8MLsqi0mWU5nbTQbtd5JfE418QSyKnvLNr3b3wQzk0M/n8tOSRa5K6OhBgxiseq
 iJQIdObHMCm9AK7DSTsQ/r9Me+CmqZJMi8aCrC0e4TgJ3Is/sFYszjHCnpUvGbKMOiy0
 BxuMSp0AaIHJTL93Mo176Wk2xRXjhG/L1O96Ikry/IED762pMQVQY0n9fbgHKJ9c59NX
 n4cZ/ySfzgc283dNY9myO+iE8mwnEwYP3j//XDbtP7u1jB/sDHN/+6v/HT9MiA2mBU26
 dhH02zthkc7L1W7pllgiTHFx/xlwuZVjYdq0DjCZNf7kVbj2dFCFGeRVTdixlgtPOOhI
 R35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006480; x=1727611280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWl7Xv2JGXBckAdLaFuhNWtujP2/LH0xkeEqhVhx7Pk=;
 b=RdiiC+uIpwyROzHIbwTcGm9Zlr0Z0+dKbWnbJJWDXuVZSpPHbZ22zWm1ASjURC5pWH
 NnbkMFTiJC6RcCjulHuBBUP3tyTEu/d39/ZFvSAuGvKFBdkz1S/LC4GVyxqlATkCA02A
 KusX62o18zG9LQDKju58cWh1UlbKe4RNf6SB1KDnnxKvKO9miNKSyBbnSrQJwsOeIqvv
 5VDE+e4BvMTbqD/At20TQbn7cvC3QwcyY645PS2r6o+2jbDSI9rFtynmC7zcTuQ/0F1l
 5DaXbaL2lHrq+SMNkstixTSaGF1GSoZKk6SCJwlLDR0SWLlQgLqK7ZHnyf51Da2LXgV3
 2AFg==
X-Gm-Message-State: AOJu0YxC8K24qYYIGSEGpOdDJdYebrxHIvIyuT5EujuIl+bqVPCFEEfI
 nWbF5JjfkPv18F45+/ISV2NlA1WuWMULWQx/LZfJNHu8t4wgnpUnYlBMnaFHLsoYypgIUqKI1G8
 xDqU=
X-Google-Smtp-Source: AGHT+IGHVeUPNl0TFOY+uxKxH/njikJMm/CIWn+hGm775xIqOjvieef69Wk3XVpclktxUb87I1vFrQ==
X-Received: by 2002:a17:907:9482:b0:a8a:85c7:8755 with SMTP id
 a640c23a62f3a-a90c1c747a4mr1385383466b.11.1727006479667; 
 Sun, 22 Sep 2024 05:01:19 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/31] tcg/optimize: Fold movcond with true and false values
 identical
Date: Sun, 22 Sep 2024 14:00:51 +0200
Message-ID: <20240922120112.5067-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

Fold "x = cond ? y : y" to "x = y".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ba16ec27e2..cf311790e0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1851,6 +1851,11 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
     int i;
 
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
     /*
      * Canonicalize the "false" input reg to match the destination reg so
      * that the tcg backend can implement a "move if true" operation.
-- 
2.43.0



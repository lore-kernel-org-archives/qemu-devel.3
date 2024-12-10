Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75588E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29h-0006sC-Sh; Tue, 10 Dec 2024 10:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29b-0006P1-3u
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:04 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29Z-0000JV-5c
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:02 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e0d4f2874so118822a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844480; x=1734449280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PkRBGiL4qFQ9PblYJoRzdxqhNIP/1epQ19VlxU5LaGM=;
 b=ape+9DPvK8dVNPOBzh8FSplSX6fzxsBBCOI67fc68q4je85yYL7mlC6HyswYwi+SB4
 DXKX2/LPJaxZqoII6qEfY8n5Ug2ArdmyiuJ7KIp2wbqn8qh3wxhsB8PhnTespKKlsZOu
 eXsR5D5xOQrhfQikYHBKiCjdU1x83KG4GeIj0dp6zMgPva4vW18Fc4jtK9dGo9uWMYUM
 Z63ByLTFj8Xw2L5VsoWlClS52eo9PqzVUBHzgvcxSKjOygi9NBSeqfBEwPChy+BQil44
 H059fFOqwgMjeF9PMWCewQV4kYsXWBEVYovG5OfS/kJVBYGNZCh9WzTc0SVxeG9Ba5Pb
 uxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844480; x=1734449280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkRBGiL4qFQ9PblYJoRzdxqhNIP/1epQ19VlxU5LaGM=;
 b=RjCoeHLmMz4ZPO+hk5yeTpOO40Jxq2IxNq47HKvT1/ZkvOE/S2s/yTyExZFnCAPJIK
 RvzyZTeq5e4C0wWNiyBQEWCfIrJJ04S2e/803XEI9dpGPVkZWTHePcSF60+OYxTfuGIv
 y+yDDpzK7dQnDxTBSzyrdCUp42waQBzVp3zOmgiOA2ZwgwGX2jQHwH0aefN17qcjbNI7
 ADKcrUBffvr+hNH/EXrlKFaKXyxq6f+4dDsxuVVH6genVcZ0TEcLdwG3y8h2F0Ev1Yth
 NjUMrRiHCgUGmDKFkb5Kah4Rg8rwXPI9YLDXovzr6/AZRMO79PfrLfxFQsvmM0690TV1
 xCEQ==
X-Gm-Message-State: AOJu0YxG8t0dExqbmGMFKkrdx1sSLADe5OgPArtx1onaMHbByf1dqsot
 w81g9K+JtrehGi7I1VFfAQPj9VVardSOHKuHsTEQoJrnQJCb5ehiWb6FTRQcx/Cc5ODRxjAodIP
 oZj4NC01i
X-Gm-Gg: ASbGnctbpbf68jF1gY1gfuJdRlRHrPK70MAWonU9asaswsBLSxqtElSM1R8PEJWQMx1
 JqjEfJL8mA7FsITDFjKElB3z1lWAZg0dNz3YrOc/moPgo8JCtk6teeHqDx1/PuOJTd9vUo9I0PN
 Q59E6cnf1e4EHe525wfRM2gz0O2Ah2lCxyreI1zQKs755r5xi5NQaPZLLC0Izc4aFrIhEHKXscM
 xVRRyktqSqau6S891tG5m6zukuqlNF3F4t8rUW628AVNk1gKEJu1MeZ1lm9vw==
X-Google-Smtp-Source: AGHT+IGzEqznHxkiADpqclObpFeFibRSVmg8IzvYoVIMDam2BAbFkK1cp0twzCXUhOJdeNUIHzqZPg==
X-Received: by 2002:a05:6830:912:b0:718:9b8b:429d with SMTP id
 46e09a7af769-71e021a99a8mr3067529a34.4.1733844479937; 
 Tue, 10 Dec 2024 07:27:59 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.27.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:27:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/46] tcg/optimize: Use finish_folding in fold_bitsel_vec
Date: Tue, 10 Dec 2024 09:23:57 -0600
Message-ID: <20241210152401.1823648-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
index fec46014be..24ec14f476 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2821,7 +2821,7 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_orc(ctx, op);
         }
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* Propagate constants and copies, fold constant expressions. */
-- 
2.43.0



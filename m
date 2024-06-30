Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C68C3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznP-0004rF-A2; Sun, 30 Jun 2024 15:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznN-0004p2-1c
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznH-0007Vl-NQ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c8e7553c9eso1643671a91.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774057; x=1720378857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSW9RBr/uXKbMiOwje1wrfrlZqFBsh4is9koj+Xbztg=;
 b=UXc3lXx/xJZ4WpRiG/t5jCqOdGUi34tIv5ckRuPkYlU+AKBsDs+J6CQgC4tRg/FU1R
 x1isBNABigmptVC+OO4MTLihHckIPlTPsY/0cNvPFPhEf6kY0g42Vhl2M0C2QAb2UJsH
 BaQSNLLOoRczP9OmHWms15N8Qq4i1l3Qk+ChnvYX1XTHBrBXZrdGFfw6LfWKkfBPYDi5
 SJcIz9mZzJzKuLReWoXTHx/NO/gVXF+0pQjV1I/E5ZkIABLCua9ocuVVoY7B5tIghX8p
 M55c10TFoknYYVUd+tivtfMnoKPHIOWNnEtdUIBfR6uy3lXxO+3pePaYT7Qje2ct7T7z
 nENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774057; x=1720378857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSW9RBr/uXKbMiOwje1wrfrlZqFBsh4is9koj+Xbztg=;
 b=hNBPFugeinsSVD0UrYphJ0K/XMvEM/NHDRM1JsdL52ZsIM+VUwTch/SsGywHqcfAx5
 OeyCE+ThPtpa8NlGJn4TK3MmvSs8EuughzmwKNZu0REXxfFofCzsB+3klJZucGD5cT5p
 SNXARw/kAlrgmsZF5IYXMLiSX4MpjtC32U9/K2XAcZwtEC65vabcggDnaEdEYeJIXQJK
 AWDPcXlX38ScBsJmPds/4nqR77joC9BVHpyupH8pog3SUXEb7TjZPyFjmJfHYNe6JXW9
 oHLqa0P75jAdLOcXa8dcs0bgpAnOc+0F7sh36bevxN747HjwyR48Ad06pxhzd2KiPqMw
 zDVw==
X-Gm-Message-State: AOJu0YyPvQ0D5KEt9fhAMrxOp7l6jyY2te6uErI3EZ7Nuxuhm1OBWvV0
 VyH34DmIoBKyNKcOUc14cQEWPs+da9pgB/ooD9P7ezAGB3B7p1PSnWFtl5Czyp8wKvop4k16ls0
 u
X-Google-Smtp-Source: AGHT+IGa3x/hA6JujaBuuvCzR3T8ldB2DGnYskd7N90qqB8m+DEmuxHJHxVf5u7cDTvBeIUAQ4OleQ==
X-Received: by 2002:a17:90a:e286:b0:2c7:c914:69 with SMTP id
 98e67ed59e1d1-2c93d78e298mr3261403a91.43.1719774057367; 
 Sun, 30 Jun 2024 12:00:57 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 05/14] tests/tcg/aarch64: Fix irg operand type
Date: Sun, 30 Jun 2024 12:00:41 -0700
Message-Id: <20240630190050.160642-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-tcg-v2-4-1690a813348e@daynix.com>
---
 tests/tcg/aarch64/mte-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617ad..146cad4a04 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);
-- 
2.34.1



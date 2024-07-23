Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA710C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHA9-0000kY-J6; Tue, 23 Jul 2024 11:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHA7-0000ar-4o
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:10:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHA5-0001Cv-It
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:10:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-427d2cc1c4eso40102905e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721747444; x=1722352244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E7tA8acdK/9lyUFqq7vEXa8PgCnGp+reT1bghch5Ilc=;
 b=TuX2Wo0K3+uuTuveRLnqfdhf66FlgTtRS6udS49Q+xuXum8VlmRxBvnzAmffsu7yoB
 rrI5QqJXEwRVs9o6wzktz+l2Vu1V3g6KRUfG/1QNj/2YPaw97pH25ud8CL3fMYNRpVq1
 3o5mXdTHVQ3e4VgsALqAg2GvJtC+P7K1hTI3tVHb7z/D1BQy783DLy944TicTo9gelNj
 DBIWA95reoNBmgrEW4RMU0I/xPuntsyjUM8ZRwLfdZjtK+R3TWPGZcN2WZWurlmLBjBY
 fxVXNo8kWw6UfGe40pY+EM8V/WPMWOyu/PGqRfURsh+I7b9P2ykog+/PNKgJGWCnEILB
 +GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747444; x=1722352244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7tA8acdK/9lyUFqq7vEXa8PgCnGp+reT1bghch5Ilc=;
 b=UXxohRbu773zdO0cHuokTTP1MBZLnq0xZkG52tExHXQAGqjWvUVPGfQPY6a1tev4pX
 ZrZ5hGhVo0mphsYKLOwQuX4w2wBpleAfzg8ZrCRRPhMV+YKAnT7LtdzesW97DCp+XrMO
 2COOQ0yYkoFQEpOBmYCdFY7dIbk9ZMKPqBSTmmS94vmsjOPKOgWjZghcVy6cMIj7rh7l
 WPppLttPMpHevDY9djsf7uk0v27wM68mgT2VMH35bWTmbjrIiO/1U4eIjKS03psH1aK4
 KM0/YSOvu/sQkWQn2MpyJ7fC6Zk/llW7p9ObA732ptfnVy+IO1A7hKz5umXjEWMHWW8H
 V8dQ==
X-Gm-Message-State: AOJu0YztVaJ7co45eYC8LBSra8MJDnTxyJz+6fR42ALMVbTooNjYypXr
 kE4MuQ/0JC+Ua9Mt6EdLZYiWcsMJ/6OUkwkqTFJYndk1RojYoz4Z8BNaqDJ5rki5cxwnFZMnPEt
 /
X-Google-Smtp-Source: AGHT+IFx1bEiTmY1+gEow3r2ZCNPGBwE/yZuFp8QZUhroyyYIZw4Y07c7/NrRy3zYxTmLB9lIiR1HQ==
X-Received: by 2002:a05:600c:4f89:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-427ed059c63mr22441005e9.30.1721747443827; 
 Tue, 23 Jul 2024 08:10:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm93113395e9.45.2024.07.23.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:10:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH] target/tricore: Use unsigned types for bitops in helper_eq_b()
Date: Tue, 23 Jul 2024 16:10:42 +0100
Message-Id: <20240723151042.1396610-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Coverity points out that in helper_eq_b() we have an int32_t 'msk'
and we end up shifting into its sign bit. This is OK for QEMU because
we use -fwrapv to give this well defined semantics, but when you look
at what this function is doing it's doing bit operations, so we
should be using an unsigned variable anyway. This also matches the
return type of the function.

Make 'ret' and 'msk' uint32_t.

Resolves: Coverity CID 1547758
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/tricore/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index ba9c4444b39..a0d5a0da1df 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -1505,8 +1505,8 @@ uint32_t helper_sub_h(CPUTriCoreState *env, target_ulong r1, target_ulong r2)
 
 uint32_t helper_eq_b(target_ulong r1, target_ulong r2)
 {
-    int32_t ret;
-    int32_t i, msk;
+    uint32_t ret, msk;
+    int32_t i;
 
     ret = 0;
     msk = 0xff;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE2CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JJ-0002L8-6b; Thu, 07 May 2026 12:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1If-0001kr-TS
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:11 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Id-00087L-R9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:09 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so530881a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170206; x=1778775006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uvxQVzD2NWrupoCz4G/8KaK0EyttZI+r4W+RC04wPrI=;
 b=m8eSwXJ+BLGbmekBK9gvFB9w5e9uBI8dLFDBiXGC7BcxykpYmMLpxmIsCChXY7MWxr
 qKm9pZis56tFdAdxjdm602d3gA0Z7dnIvrpUQt8LTi37QdnTeX8DA1EhavmLQQ2DhLJC
 3BUFY+7Q3e9DeJliTHYVcz9Sdks/wsygsSVNhwLRPHeh6SK59XsrWUeNOSobUzKCJsWj
 yMNAjzcz/5j3jJjzNMuYmTIdSPlMEAPpf5bV4SPAhCrqZja1UzRERFistbj+xvv4VsXY
 NWoJCad6KDAEQF+OTQNErBNcKl5trbtKFFAfXkqp1xoG4MWCTbt4sYMSakYvCeZo4thO
 ZkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170206; x=1778775006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uvxQVzD2NWrupoCz4G/8KaK0EyttZI+r4W+RC04wPrI=;
 b=gSWPImx7ru2FMhel7jAOXWs+6m8Tb6qod8dE0Qm/arHMdoptyHKqTZvoPKtvNSuYbQ
 gB/NZS/amy/4JhU4HZBbKHOr0gpKCDfbryzXcL8Jm2TRPVqWEsFPWR1vZbDTjauIKcin
 jh3MbKp64ZnNkR9fzDmUiUNVk2ZWfqou8Dn465Z55uU5JLK8Z5T0XZBNcCKd2OX66Pdf
 QREKD09gSUQTL8GITApfvOoriMva9TG9SpAKjJ6x/J9C5KHPT9xOHJqlwek2Fhzt0Bha
 TpjjRh9tgYAGDkEfM+p9KTWQu+quRcPjeiKJZ767C/mLSSEee9HBnDgGaSGVMMiaq2pH
 InvQ==
X-Gm-Message-State: AOJu0YzGGhctMAE3d2J3NFXGyYVjXmHlpR5l8gLNwJWBx1qlmq7hR65p
 +lALr+i/9wbZTymUeNDNrbLJW1aT2IKo2EuFs/9jsg/4lc6QnbZpamFWrUesaWW4QLywO/aLEW2
 +pAKm
X-Gm-Gg: AeBDieuYOQFgERUAhMo2rR+56kKFNwaVMuo9vcnOiieYLoy4EwRb2o3GN08caeW5qe+
 Y7rRxU7cY1M7+tsrS7Fjac/+yKYt6faMHnyz+ZWmCJoWIutl8ZbNXOKqoiGhWX38vTKTE8a0qW6
 zuoIX6B0+2lnk5o3kIADWa3kvEQSRuOZSn9Gcb1o1004v/xpMJW/Q6AZ5JBqB/3WilIGpjKfLMT
 aagFwXG+ADsp8zy6VbZa+sdFLhNyStuzs/zDgdEstGtCJ8MICSJYRSGHSkBxkwBP87sJNMTrXcw
 tOlQATsCX1HSHpeSOAG7EM6QbdSOIRvqMbzSCqkmDjNslyedlv3hF+EtIvrqgNKJBNG9GiD8uUH
 KD3JlQq7A0bHeo88uf7BkO6TrkQCLOn8exvv2DiveGcTmF8s0vPxNYPFkIjSATNgZr7rrhaqg4Z
 TmxdPxGF5Idi3/gIaev9QQmPCwXRaDRlLf5LRRv+BDF084Yw==
X-Received: by 2002:a05:6830:921:b0:7de:4fc6:a588 with SMTP id
 46e09a7af769-7e1df08a13bmr4830292a34.23.1778170206440; 
 Thu, 07 May 2026 09:10:06 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/11] fpu: Use parts64_round_to_int in
 parts_s390_divide_to_integer
Date: Thu,  7 May 2026 11:09:53 -0500
Message-ID: <20260507160959.449170-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
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

We will not expose parts_round_to_int_normal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 72ddb19fa0..cd03ace323 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5197,12 +5197,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
          * Rounding of partial quotient may be inexact. This is the whole point
          * of distinguishing partial quotients, so ignore the exception.
          */
-        *n = *q;
-        parts64_round_to_int_normal(n,
-                                    is_q_smallish
-                                    ? final_quotient_rounding_mode
-                                    : float_round_to_zero,
-                                    0, fmt->frac_size);
+        *n = parts64_round_to_int(q,
+                                  is_q_smallish
+                                  ? final_quotient_rounding_mode
+                                  : float_round_to_zero,
+                                  0, status, fmt);
 
         /* Compute precise remainder */
         r_precise = parts64_muladd(b, n, a,
-- 
2.43.0



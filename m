Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0307606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m5ILiU8x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3U-0003YL-Tp; Fri, 23 Oct 2026 10:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3P-0003SV-Cu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3M-0006lQ-IB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6732775e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764927; x=1793369727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ryjOKq0ORMIrTAz0dCiFKcUghn8LWL48JiFe7/Y/Quw=;
 b=m5ILiU8xVzM3r2fh2wqTGDi3InmUXhg2Z2JbOxPhRHh4FMnnIpNe5wOV4+VKKfDl9j
 wi2OUmLbUi0FVc0DfQ7D+W8ew5+SkG0FTvoc4O+tyfKENxwefUzO5IOuRATb4F8Gc8QC
 gN1I5dnO49ow56FbrRMcFGj7BBGRlruUgEWu308jmlwDBTMlXau3J6t9GsZHnu/7Piyz
 HprEk6Nj9t7CeDhxpZnkHZIvo0F44xYOiOnmQIIcG6Gex35bLfwMkCq6r3vgvozfg/uh
 pN402MAkbsuAlTxIuwb1R/zC82orkCxuY/Vdi2YaA7Ls4tiDTRSkJxdR0ikkud/etPdg
 I64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764927; x=1793369727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ryjOKq0ORMIrTAz0dCiFKcUghn8LWL48JiFe7/Y/Quw=;
 b=xHLjOivc18NsBpYfBT2FWPumR4B2fRDm8KJRcl0aGoEJj4rKbzlT3HzGY2E+VadeiS
 SiV/jg3C0bTvCdCVI2wVUf4/U2QpT/YF2n7hgzhlokl+RyzpmhCl41ff75QzT9jnzTPk
 TpPbMOrPObUeYvy/6QSquLdeHoo+ivPzC7+sLZF32q1rI/zn9lGbO5RWCFXtT97Y2wqh
 qM82NzEIMzNu7HQImzBjqZLm5vYsjk27wMLbvKXKFeXxsH+xrEG0JMzhG0R/hFd9IM+e
 U3r/WSyvoJsS6C+Wi8AiT4sW7OyFl7TSp+wSkQnl9yI4bTv4CyqeNHAZvjhiZvX4Hifw
 FnrQ==
X-Gm-Message-State: AFq9FYK1ClO4fZM1jXjhBfNXsYNQpyEdhexmhMeo7nAHe2SonpmPCMAs
 1+IWNsfv+vF/YPTNIiSLk5XxdvWjJBVpz+aHr61mKcMwGsiGVPGI08zssCl7uyrnMXf5g/T9cJI
 MLYCwEMA=
X-Gm-Gg: AYBFou1w+/980DOwn72ua9mHjV9kVt0j5fGmZsIqytmaqKOovjOTVHqE1R93IiEMVnz
 K2Gw44u0ZyMLdUmSGOAUVkzfo9MAnvJIyumsIhup+Po4W67jUpaoS25m6tb9YLZhwjV+GL6Zb5z
 tVgTsUuK/HwZpiSeUisE61JOEQI6jaBvhZlMm2qK5HsZwd1RdRgdr5u9Wsin8QubLNBkciqVol0
 gFrqsRqkAoYqXrChu6a/I4R0IxFvS7twh4LkKQWhG4VfXKwYGqfCopF2i082VJ0a0TG6V9Bxun4
 0TLvC7hQXzeKLer9p3dqHnx49xM/5OeHxDTc29qsOhwfperDM8DJW+MNhZbWlm3zFsqwUQqp0cw
 ia+ccftQ8y+yOsCgNcRF95E1jswXpGvn7gus74GlWbQVYO/Z0MzjUn+taWvvXaXUcQ8gR2HIqWS
 6vrzy59EV9gs0Pfz8WuqAoQFhvhK1OXgQS4KvAyl3+seK2mSKGQM6WrrZZ1d4FOUPfdzZ0CdkuQ
 8aIYb3IdPPV7NuYp1aXBI+SAUyO2hg3eB8uCzIvAdtWZ66rWY0XyymfXD0A4u+eKW6wsGq6cx/r
 34Qvd+UqgffArI1BfnKd1rlB6b7exXps8XKmJjCAbPceGTPZmAYbd7cIJwM1
X-Received: by 2002:a05:600c:3f07:b0:4a2:150f:1603 with SMTP id
 5b1f17b1804b1-4a2150f17b6mr31016245e9.25.1792764926406; 
 Fri, 23 Oct 2026 07:15:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] hw/intc/exynos4210_combiner: Clean up reg_set[] bounds
 checks
Date: Fri, 23 Oct 2026 15:15:00 +0100
Message-ID: <20261023141503.1397009-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the exynos420_combiner read and write functions, we check whether
offset >> 2 is too large for the s->reg_set[] array we're about to
access.  This is written to log a guest error if it happens, but in
fact the condition can't be true unless there's a QEMU bug:

 * we have already dealt with and returned early for registers
   beyond the "sets of 4" range, by checking grp_quad_base_n;
   this accounts for all offsets 0x100 and above
 * this means offset >> 2 is at most 0x3F
 * IIC_REGSET_SIZE is 0x41, which is in fact one larger than it
   needs to be, but in any case the offset can't be out of range

Use assert() checking against ARRAY_SIZE for this sanity check, as
failing it would be a QEMU bug, not a guest bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261019162217.3272337-3-peter.maydell@linaro.org
---
 hw/intc/exynos4210_combiner.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 4f079fedaff..2bdb9a0152c 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -119,12 +119,7 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
                 s->group[grp_quad_base_n + 3].src_pending) << 24;
         break;
     default:
-        if (offset >> 2 >= IIC_REGSET_SIZE) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "exynos4210.combiner: overflow of reg_set by 0x"
-                          HWADDR_FMT_plx "offset\n", offset);
-            return 0;
-        }
+        assert((offset >> 2) < ARRAY_SIZE(s->reg_set));
         val = s->reg_set[offset >> 2];
     }
     return val;
@@ -199,12 +194,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (offset >> 2 >= IIC_REGSET_SIZE) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "exynos4210.combiner: overflow of reg_set by 0x"
-                      HWADDR_FMT_plx "offset\n", offset);
-        return;
-    }
+    assert((offset >> 2) < ARRAY_SIZE(s->reg_set));
     s->reg_set[offset >> 2] = val;
 
     switch (reg_n) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D72CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXG-0007Yb-Kl; Wed, 10 Jun 2026 12:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXE-0007Y7-TA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXD-0005PX-0a
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490c1915793so49976395e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107925; x=1781712725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0ettYE4YQkH1grruhWe0pOVmQVBxQ8J2gpVklK+vhQ4=;
 b=RpnkZ5PFEZRlnwpxg3qJoWn97b1/9edHWlsDXJbr1r9hOv6/nLrC6d9m7j0Lffjovm
 O29lFwgBwqXGNp/WGfguXLdIAaErPhBqogQcVSTuldJTm0f2nKn0vdQJTScu9Pn7H3Ef
 ViHU7a+scnohZGtvyj7hasJhvG4BUa0v0YPmzePjeEKloCsJZFVZy3w507hRRXM29/z9
 o54K23CA0YsZR08IN0Gegl4hg3SrpH/kw8MYxmADZgD1OevmqqkECyysP0TU4R+cdr3y
 B0hUKdjfJap1FtNkeZE6ZHTOjjDJAvY5Spc61t9JPJAiFapMVSmzPTNEBaopY1KMZlX/
 GeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107925; x=1781712725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ettYE4YQkH1grruhWe0pOVmQVBxQ8J2gpVklK+vhQ4=;
 b=nfG1eXM2XkQBwrogUIZ6G09F4IJkrbS8VzYVC3A8ocfcJBvvQ7OTgcDN3zD8+kFIJm
 Kig29Hv9L3NCiiIhOHgyL23VBiF3R+u2wp6geYAdvn4Pd8dbHTd93sOeo3BBtLj8RFlL
 RWAL01d7Oo2vyq9KxbCZSVCPgC1WzIulV/VW4gptz2IsY4g/6EQfWvyJ5AXXBBbYPacX
 ADWAFVEovGNRBItbahFspqHoh3Z463fcS4J2hIiCiLaPzvv1LKlHCL4znLHf0sH3bpIM
 9JsLEWEPFrhZL3kmu9TvGUuyG/Sh0w5yz5bs7xJtO9+48gtqqFuMZbMGVkvBO2ixq846
 wnzQ==
X-Gm-Message-State: AOJu0YzyaSunuCpwBw/vKOUZObp/NoHiBUoRXo5jhfPHXvgQe6KOFqTf
 Fn3N5i+M65e5LoL2M9mvAIrLgEb9vRG5BVg7nToupc+mWmGxJ73tn6+D4DfoUsJNSI5WFZgdonx
 lxX4X
X-Gm-Gg: Acq92OEFqrs9T7zWeqZDaE2fXXMGcgQvAW4SV+dsHUolS64KmcG7ZnR6HYy5ZkxSSsj
 XEmUp5E8lbKiwWdnCHCM0dJ2li+gxhggWUk7BIm6JTj5qK3BmU5OkH7zx9Vb3qSdElLjUY+6czp
 x71R85rq9bYTtT7HuZfvINcQSxq1aS5IZ4KnWqqsImVH0uov1+m2ry7mLlM/pcJHcTPMjua+x9l
 J+SLnhXDNsRfzupO7RWZVODOiQprwx7LNq78tMs6qziGTygGLT/4Jb5flSVSKNxg0djdiHwmBsK
 10e+6sAEt/xu4KxENJaepLlGOjGSYzi7mVFhQnuyChZ9/O7pT3FIi/3U6gZCJsbB2k5JUScppW7
 sk5GFjbVrkZ0PxnSuA84Q+0lVQEPKpyF366O5mZi/qD9cjiZUj9DToboZS3Hhl697X9QqmtKyJR
 uS7yr5NaTQNFXbfUip9y2dniqWwuL/ilkvA1x5hAek2YlqHiyUjarnHXI3g6Zv02Z3MHN20Qkfi
 GH4F2OxK21qyvm5G03CtSsPpIvqD15SvekIIq3ZU80=
X-Received: by 2002:a05:600c:5246:b0:490:bad8:329c with SMTP id
 5b1f17b1804b1-490c25c8197mr396586385e9.12.1781107925497; 
 Wed, 10 Jun 2026 09:12:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/71] hw/core/qdev-clock: Fix potential null pointer
 dereference
Date: Wed, 10 Jun 2026 17:10:52 +0100
Message-ID: <20260610161202.2235298-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>

qdev_get_clocklist() function returns a pointer to the NamedClockList
struct. This function is called in qdev_alias_clock() and the returned
pointer is immediately dereferenced without a null check.

Passing a clock name that doesn't exist to qdev_get_clocklist() is a
programming error, and so this change is not fixing a bug, only making
the reporting of that programming error a bit more helpful and bringing
it in to line with qdev_get_clock_in() and qdev_get_clock_out().

Cc: luc@lmichel.fr
Cc: peter.maydell@linaro.org
Cc: hemanshu_dev@proton.me
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
Message-id: 20260531153354.88909-2-hemanshu.khilari.foss@gmail.com
Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev-clock.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6e2967e433..861f78f94c 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -157,7 +157,14 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
                         DeviceState *alias_dev, const char *alias_name)
 {
     NamedClockList *ncl = qdev_get_clocklist(dev, name);
-    Clock *clk = ncl->clock;
+    Clock *clk;
+
+    if (!ncl) {
+        error_report("Can not find clock '%s' for device type '%s'",
+                     name, object_get_typename(OBJECT(dev)));
+        abort();
+    }
+    clk = ncl->clock;
 
     ncl = qdev_init_clocklist(alias_dev, alias_name, true, ncl->output, clk);
 
-- 
2.43.0



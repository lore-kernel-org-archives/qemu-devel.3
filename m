Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392DF8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrz-0007mW-L4; Thu, 16 Apr 2026 05:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqh-0005Ik-78
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqf-0007qT-If
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso93513295e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331040; x=1776935840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/VJFwwdVT/k0cKypFtr28kMHVBcIvgVjB3u5V46fb1M=;
 b=GbS1NlZXq1HQoVR8Ax+SSfpLAOwZ3lm4xZK6R/f9GiSEO5hjjaqm1fawfs424g/fSp
 igZPtFHSdQih4Z4257Zhjpzbt3e3BV4Czv3rIwZDLWWqkjBq8xwidEt9FNQjA/ZtLGlM
 vay+WnIZrOTnVYR2Pzww67x4Y/VKQ2iVwD6uIEU/9k1rn7BH67k0iwDVuMOn8XsEtRjD
 q/9YPTP4DGC+MiSfNIh29CMN5BqjhLqvtxHYzQQOr+moOSMYOunrev557LZizEEJuRhk
 ixPmOZofnIoWOdjiA2KnqXyvESStTUHewneMkT89zHERFMzZilCj0YfZTa3+u52bq6Jx
 8oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331040; x=1776935840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/VJFwwdVT/k0cKypFtr28kMHVBcIvgVjB3u5V46fb1M=;
 b=W4fbZLUG4G7Wn0Q2zur8WDr7v+0pB+hovLFORU8fNs96JXs1/1lQTZzwNTb83pnVIe
 opXF+JypSrj7iQK2ur5R/DpAAk07TXUQA0tZBaStAu7nTjDpyLUhRhCEBlwFQz8UMDPw
 Q9mjIjoqhF75KDLFkGysc0Gox7dVG/yjR95Hbn2hKgBTv+8s0UG9jHFEitZe082yXPWG
 cdbeYHFMz0JBARpn5Qe3AnVeqL4NJLkB55Q4MnuhE178DC5C5xwVzFeWBpQb6qdTAHAR
 lWy/IihLaLjhbDYFSQ5dx/zU5jy3Gy7w9t52RJaeSj7YDUMw8feR3YMqmlE6k/PQ5cJh
 iwVQ==
X-Gm-Message-State: AOJu0YwmHRSaxsYHGzitIX/VUTPrqOzGrMCTrutksYmHUWIyy2TBkwdJ
 zK4t05YpGjPw/S6hn9XXqHTZljjtBoOBLViXRl5oRooEe7oT2kY0zfotKrhMtwFVpw5iTIkBg5w
 h8IYjQ4k=
X-Gm-Gg: AeBDievubsyl8EEvFchKUX0sizsSuuyufkK9W/FtvptZX7REwjtteY6ecxGkBLRbiyR
 aSXpVsnqjBiPKuCpvcuNZLhehRiKHLQ038mAUJ1+twaVwU172ksDxCEKxMNvvFGQfCVccGw8YpP
 XrGlMWSvxFcLAIfaoYwZT/bEhJVO085l/hwV0cw3TY0WisliQnQQkm/Oq68omAWQLM8/9oBlwOk
 YZWmG4OJ4zDpGxOGAY50FisqlRrfHKty8vgRIUFJ7VgBgRObB0s3D9/3Fw/mcLRzLaNw1hi8Tgo
 BZuPtKK5PacaQNMlAwfFscC3p3dvkp76B1axRynLSorrZ1FgkfuO6azqHccjf0eJ3VxmfvU3tDN
 xeZ3APP+ocy+bLcX2FzR0Xuy4jVIABBgQOQBCW8iaT7TbyG9kbNRrrK90biHIsiOOB8Yog/ou+X
 yckjrkOh8jHG3qIgN05P0KV8AGEWLQbHsTSwzusJoYAhLm2KKYpTLUNGWopDrO4IB6eIe4HsvUE
 5lQkqwM3YFQLcSjctDL3Eh6P20KhdRb6ripSyGy+g==
X-Received: by 2002:a05:600c:17d8:b0:488:9ed3:148f with SMTP id
 5b1f17b1804b1-488dd442b15mr172513695e9.21.1776331039900; 
 Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/28] MAINTAINERS: Remove Su Hang
Date: Thu, 16 Apr 2026 10:16:49 +0100
Message-ID: <20260416091654.316158-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Su Hang has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Intel Hexadecimal Object File Loader orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f50575083..9ef51955e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2716,8 +2716,7 @@ F: docs/system/guest-loader.rst
 F: tests/functional/aarch64/test_xen.py
 
 Intel Hexadecimal Object File Loader
-M: Su Hang <suhang16@mails.ucas.ac.cn>
-S: Maintained
+S: Orphan
 F: tests/qtest/hexloader-test.c
 F: tests/data/hex-loader/test.hex
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjX-0004l3-Mq; Thu, 23 Oct 2025 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjW-0004jx-Bf
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjU-0005YX-PP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso10431735e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231363; x=1761836163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sQyl4cLeHedDemKHaJUP3GoZkvBtZHXRHUJ6AnG9SQ=;
 b=p0Ye7Ou/JrWO7Bhub14b6ICMbAibpD63fT5+7lCvmxriaINhuzTK/oJBBRyzw+XfHH
 Q0GB3H44XsFr4F0gvZE4r14SOq9W9jJzM9steUMsklWYDOsgXqbkKP22xGRCBk/dqiX0
 qzVXyitNL9MgOe3hEyhUxbqUHR33bD0FjS3gevjHRMbPGC2NRpI5LgJw/wfqAxtk1gcX
 rKke5ijPdkndKTK7tSef25t3gDc6AXIlYqURUghBOM8fXNgZzmJ0WjbjVcDEcVMM23uE
 3/tDf5P6ER9fVmzu5GghqLB2wx2Fm/OaVFu6z9IQgSqLReE2nxrEv195pBj0qowaFpFN
 /ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231363; x=1761836163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sQyl4cLeHedDemKHaJUP3GoZkvBtZHXRHUJ6AnG9SQ=;
 b=D487ZAXeZBmkgXvzFR38MlHl4AFrFp4cSwjOsuxe3oz+bNHcQlwbHy03kNizCxCDvx
 49SXYXOb6dNjDmjDxRXSli+0kfkob+57fXbtYQ6/TJtpXrMZaxcJ9khcdfNnPHuoq4yi
 lQ71eIHv8XuPO28PMKiuuC2cZBNs95qsgAWGZVOURWC3iTvfvVpmz8OBkVlb2N9lYuGz
 /xFXff76b+HiGLIl6JozN5pEBZ/rN+W0zRFFarPi+4WWRw/ilSpDDvZfNrPNWurdkEab
 oZ3en+DGe/dFwgSw2AtV3RyAgvc/e2Mb7YvES+Vt0jbJm/2kzBCYUd6KTh/sUAASOpmm
 A3tw==
X-Gm-Message-State: AOJu0YzAF2GR2rIukNgcKpj3gR16AS6vG5M1RM/dw9LNmKwcRdzo1MdL
 IE7qsIbfXPY16TacOAbPsEkSMsbgbO2I/R3fZGSumb0gEW4DzQSu8W6ca9isZtLSTNuU1yLvHhj
 JnzRk
X-Gm-Gg: ASbGnctIrxR+i5Uj7Li4y6uEzIk4OZ9xcyIyh3iEKiIKDe1RgvrhwLs6KV+17urFEtv
 d1K4VN05a6RtZ8rIzd/KOyZn9VC0uzIim8tqVtNxST3WWhzMHWSKKlZc3m9BIi7Z+Zf8rYiK5Ur
 hCOPdHCR7I+dFbXzM2VNnlIzxMlNvWTSCgAyuhgA0jvhbnIzkD8Uexlo0dbDjN9QmWWuX3AmfMq
 Ayr+AlRGThmFhEAbuMjDeW142rxdaPQwFEM/OatBQ1PCZa+VWrLbx/EcRQTbavwa2JiR/3di8p3
 BGynJ9T1YkP0tZnHoZ+Sf+BU1aD6VpNkS1rTM5ZuEkftLUEcrUkXDen9Iv8PsGGLZA8lJY/LyB3
 PTyCsGt+QDgYZDKH3x6osF98lGfCR81e8KX0r7upSQr53YP3IELBnCcpVI8s+nH3R7hMJ+8McR9
 1QFA879A==
X-Google-Smtp-Source: AGHT+IGY+LLlvHHren1jOocvq4LuYLSJ8zUq31NR80RYcIG9fqGVn0NgfvgJZdhbJRWHmKispxfZGg==
X-Received: by 2002:a05:600c:871a:b0:46e:4882:94c7 with SMTP id
 5b1f17b1804b1-471179177camr197675805e9.28.1761231362679; 
 Thu, 23 Oct 2025 07:56:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] target/arm: Drop trivial assert vs attrindx
Date: Thu, 23 Oct 2025 15:55:44 +0100
Message-ID: <20251023145554.2062752-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

We just extracted 3 bits; the <= 7 test is trivially true.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d4386ede73e..54c45fc9feb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2320,7 +2320,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
         mair = env->cp15.mair_el[regime_el(mmu_idx)];
-        assert(attrindx <= 7);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0



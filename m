Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D395AF8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDKeY-0005pt-9Z; Thu, 16 Apr 2026 07:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDKeX-0005oz-0y
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:12:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDKeU-0004By-Oy
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:12:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso2875440f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776337973; x=1776942773; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVGzGoRJ05drDuKHfFYMYPcHhmNWrBssZ8qHB4Zhj5M=;
 b=crUIpbwLUVi1uAuvjPSXckVYLOHHXq2vr8zsQ2FJsezPtjhwh4NUL9MblJ4NJtnKOZ
 rnZBrIk1it36OG+/paAwUrRh6fxgsRnb/bLfH65v7R6+NmN8s8yfU8SeFDkRtTaTo1+M
 QucXvkPjjxcRjyrs0WjdpVQv6F9mwlKPDaNMBTsVuI40bwIJGAi5eJgD6Ftln6qk9I/Z
 DdmM+YZqh1GA4mutgCZfFktQe8SRNSheUAqEDL3roF2GpL6wul8XxOLJfxfpaBLmZ9a1
 hkATJZu++SREGoLUBds9da5bB/FwfR8GiYLSgb/v48mM5X3AQJVe46VsyMsw6oAcOmCg
 wnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776337973; x=1776942773;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eVGzGoRJ05drDuKHfFYMYPcHhmNWrBssZ8qHB4Zhj5M=;
 b=WKcIrB+zlohIYAgBXKbKiMZz7G8RzByorxShcj3SLW4VifJDS1d9ZQ4DssnSnFwjB3
 DIwxruE8MsXeqrzzhzeh4lNlXTwBQ5FhiPxiDQBMadpCR9stWPmSs1N241JqTjiNckH5
 LMyVqSkyyvqfM1GPAOyPSQK4CPe2Kjo5hwIB9PhjvtmYdA+RHnSSyFw70mxCUfZLs+s4
 kgZZpBWe1LJxL8sE/lVEW+hlgtlOozie8f3xeYUacm3cbgL2tWjRaObIkgCfKTHi7s63
 PNLX7j85mW8NgT1LFdOxRjurfuJcDPg85L8/QRAlbF5QU0sksHGr0mCTdO0hb7KbE07p
 lybw==
X-Gm-Message-State: AOJu0Ywcvyb0LYr2YWcOj3N2zy7r9DNRhFiHA8ajcNgAawqXOE6vgRj7
 c8Y30Bus/91Wmq2btxJkV8vfkKBqmqziwVa1rqJch81YXl/hnLYQSjfS3pF62kOsD+3dI9BHHPW
 4b1FO
X-Gm-Gg: AeBDieu4rVZGTiVWZD6PA0+LO+hFWTzQSdc52ajFIRZ92zLW/2/OK27wz2bJ7eY+HYa
 g4mH4w+XccNp2Yd+pHEgaJwUOyaDhbtn2Vnkc8Cazjqs04kbTwP9NNC/CAzGrNatemdULRP3dUJ
 XARsjoZxOmbCMQvo8Q75FN95etZ2LDEy/iWJAIDWcBrmKprcOVFv8+I1ofPGZ4GreQmDnIO6TOi
 dfV+rsv2DV3v8/eGeJ8Mk63oOAT6KUhlpNkJgE9RSSviQ7cJyOjwL9wflOa2PgwFZ/+TsVta5Hq
 PjYs71MMwQC9eBi0mmoOA6d90IP+vYohLxNvpVTuYuWpMKywAtLVw1CHRqmUM8pkIV0sC4SPX/c
 lIzxSaHtvFetKbheAmvlKdkR1H/f18wPdXZmpCM9XnweigsW6gUeGmhBU77ipk0MWg+bmEnRyhh
 3QoySiJbLIqhTcx9hqiybe5xBx7EYMa09mR3jt
X-Received: by 2002:a5d:6acb:0:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-43d71f48099mr20169433f8f.15.1776337973240; 
 Thu, 16 Apr 2026 04:12:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:8f74:d82:f9ec:90cd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead2decafsm11513078f8f.0.2026.04.16.04.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:12:53 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 16 Apr 2026 12:12:39 +0100
Subject: [PATCH 2/3] target/arm/ptw.c: Add two new spaces to the granule
 protection case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-jmac-feat_rme_gdi-v1-2-d9fa0781ed58@linaro.org>
References: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
In-Reply-To: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

This makes no functional difference, it just marks out two cases for
future use.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/ptw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b3..d4b63a365a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -510,6 +510,11 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         break;
     case 0b1111: /* all access */
         return true;
+    case 0b0100: /* system agent only */
+    case 0b0101: /* non-secure protected */
+        /* System Agent and Non-secure Protected are GDI extensions. */
+        /* No processing element should have access to these. */
+        goto fault_walk;
     case 0b1000: /* secure */
         if (!config.support_sel2) {
             goto fault_walk;

-- 
2.43.0



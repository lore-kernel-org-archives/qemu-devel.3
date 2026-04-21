Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24633F8FA78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBzz-0006DL-2c; Tue, 21 Apr 2026 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzv-0006Al-V9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzt-0007Om-Fq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso44407185e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776781360; x=1777386160; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dQM2HEP97233tEtaNH4+9B/jRgcZaPr8e0DRwAenRrQ=;
 b=dmP1FJQp+l4xcx5/Edhm1gXzc6PeAzeP+Atg8b1MyHkSz1CcF569HSoL+4ip/qzfMw
 e7PcmE5/ZgPAqHGtHHBvttaDC5SnjOxCf2ZwyZHhhcKda39T9eyu/uqyl0ppD+1Ak1iw
 A5ELt2gfXWK6zRaRNrcF4KYXyLXtpHwRW/ZRUzWAVj9B1uvwdosE0c0RvbkTjOmqAWuo
 mU0GFqSxBjcUKR8/GTRmO6fZUDqi/cUizR2NEu8OyCPzOvDBFeQD7h6PwcQGwosRLdee
 jXErvJu2C+PsN7Pfhex46ngvJYPA+8uXdxec5NxJXO1tEoWmTjwMyhv9YLGYjr5H+DmJ
 ZwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781360; x=1777386160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dQM2HEP97233tEtaNH4+9B/jRgcZaPr8e0DRwAenRrQ=;
 b=eN2bs4fXLElVA9UqWq7zyG2X9rV6z505ok41kw2z6JCGFZ7E7KMG0XWe9tj032XehP
 PiMO9Ys6PyRXyAn9nbtDCIdn0o40zzgzsDIm+1+CCd/st8l98SgvxcO16mtDq/ivB37h
 DAMljsSwFsJzi9jK8Ibw7vPlrRdHifMM6YQovXmtX0f7dOeNljexfFJm/qOGZ0NEA1in
 8bOzD6sZeGDTFhtdfpUGchrtlloe/bXpYr0n7LgDZSSnUv07d+1SotWKo/iatuXN+isd
 Xb+4KDgw36gPxl1rJpaDtsT8jINsY4Ix81dalRNsUW2bfYl6kRpgDc1vS+bxuNVfj6ba
 zAeA==
X-Gm-Message-State: AOJu0YxImDCaUnf3fptDEHn3zJTg+oVegDWNp8hNAAWtnLH9lIyb1/cW
 VGiqwt5MNwiKrWWU6PuF3YyrQACi0wYWBtNB6FWCPcy2HQjCNgIlSBiVYGYDArsZvXzZmySTJAI
 FkW4V
X-Gm-Gg: AeBDiev7iYLZ21wIcFnrweG6qzlAmIl0CKxAehjGbOp47TCwzXfAcimvjTrTxrBKmMH
 afKpiLw8qD+MeN+AeBYaEC/cZwSIJQRH7xMa38QzZUPLFZm2iuHN6RARE2pM1w9A0NHu+y45Vi9
 qcTY1f89PlGMQVfrF+Z1ebDlU5qQeFEo97EepV056vFK6g6SVHodYCL6vlgnmIDjdd51IXdD06p
 WX+9StawGmOFHwtIq07Q53HVqqIgqJ91yE1SFUk3UeXSGuZPC3I5cqjY/8pb8DNp9a68R6KUxLG
 eOvIXvFOpBReDQ+RYx+4xJgWyoQsW+CFEND6YiDkoY8jdRTdfnaIqYP/nPyndvXZbspwNia+oc6
 DF3VeJyzAmTUJ18syZYGHqFnFnJmhUkScA7BfgRM5LtFkMFlmzyn2+5Mmyefuqspm+THxsPTKpP
 /o+p8XS0m/4mFctyh4SXxg8ZBaYcdps6zbs0hhtg==
X-Received: by 2002:a05:600c:c090:b0:488:9e54:94c0 with SMTP id
 5b1f17b1804b1-488fb74e130mr189084085e9.8.1776781359688; 
 Tue, 21 Apr 2026 07:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5364:f814:f749:9bf5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm164250465e9.9.2026.04.21.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:22:39 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 21 Apr 2026 15:22:36 +0100
Subject: [PATCH v3 3/4] target/arm/ptw.c: Add GDI spaces to the granule
 protection case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-jmac-feat_rme_gdi-v3-3-ecd20c77eae1@linaro.org>
References: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
In-Reply-To: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

System Agent, Non-secure Protected and two other GPI field encodings.

These are explicitly denied access for any processing element when
the relevant GPCCR bit is set, and reserved values when the relevant
GPCCR bit is zero.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/ptw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7b993bb5b3..316e201cfe 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -510,6 +510,26 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
         break;
     case 0b1111: /* all access */
         return true;
+    case 0b0100: /* system agent only */
+        if (FIELD_EX64(gpccr, GPCCR, SA) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0101: /* non-secure protected */
+        if (FIELD_EX64(gpccr, GPCCR, NSP) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0110: /* reserved if NA6==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA6) == 0) {
+            goto fault_walk;
+        }
+        break;
+    case 0b0111: /* reserved if NA7==0, otherwise no access */
+        if (FIELD_EX64(gpccr, GPCCR, NA7) == 0) {
+            goto fault_walk;
+        }
+        break;
     case 0b1000: /* secure */
         if (!config.support_sel2) {
             goto fault_walk;

-- 
2.43.0



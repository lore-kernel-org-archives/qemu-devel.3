Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB5EC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvg-0001ro-UF; Mon, 23 Mar 2026 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvf-0001r0-Gb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cve-00064z-0V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso30331945e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263276; x=1774868076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oqhm3xyUZh+W31/fl248bBeWUOuk3wxGAOmgwD+wPOg=;
 b=XHffmujJbkKbi+8HsMWnEbn4YAqaXFF3FRUS5oyv+cDB17hePoYoAb2jXx0rbX+uIn
 sm9D4MtBa+arDeWZRKQu0LnsPZqFOY+NOJ9OoiAFDwupxEBN1eVLzNtGCHnVoStpa9zk
 WE97/RV3pb6HhLQHVrirT33iFbIhc3nqoUlB9JCtiMKzqHEUzbGC+i+OXBpzyyXGinhJ
 DrGWS6M+LFqg5M/XzKe8PyTP0FbPb6Z5mqWxGtGhSrMz31avBy0IFCIN1YVyO8BJa1dQ
 aiKDiRRN9DFAEvL3Og8fs7f+gnymZsnDTdprrPl9IJyZ6aWCFks0LsNBf9fIkCZKqDcW
 YkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263276; x=1774868076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Oqhm3xyUZh+W31/fl248bBeWUOuk3wxGAOmgwD+wPOg=;
 b=Y26umBYJilrK46ASAjMe98rbdURbUA5H9AtgMzmuHkjb33YpTuxrlixXZIdHQgAaEU
 jDT//gmG+UDNuWQgEs8YDGbHJcXo01+ixAVXAEG3+mVedKJbMeYYQPsH9eUAGxq24d8+
 4mWhW2qj+emDcqxy3FAOihilRpJXNYGna42PzBfc9DblnMnYBPZ/3LDKK7wOnw0BkfXC
 ZS1GwoInXhgZrzIs0Ud0L0ynsEPTD5h4LYnE5ilto9HSkmXj2nnodJxhL0ZSKoxUA7sN
 hqV7jhTzTYTmQ/R3te3fuApvhSmavSe6Ri6IvYWsjZ3hxbOCZMGN7MVf73/Q7EbOKkHt
 4gUg==
X-Gm-Message-State: AOJu0Yxy6mgWbe+clE7fbvgQjlFnTBqea7+cGs9dPKsjg8pFRTkkQU54
 i4yuIBnY+fWgayeK1DVpM8W1RR+DMi+9M6RLHckClgVf5MiHObBH8Veoa7q6/TaDZYD3+OIKVyp
 z3AiyhbY=
X-Gm-Gg: ATEYQzyrXRDxuqiDg6jQRkcgzKmQhO8om+Wy5yq9TfLzmIGPjAubwxPMRvMc6EepWFm
 x6d5ukqfq2HTLYHo5o6apOeHebBNVy7K1/OqmGE22EvCwSISjeUtEr6WspFckbKN3C8LR1/u3FN
 j3KypfTiG0tLOxmRWVBls6CWL4XVA0A9CodnsZngDto+ddltVrhas9pG3t6lSLuEoyd7t8AQoxf
 d40Fj0iqUxyVEuI/AitvhAxu0RRtNoakVFjj8sVw75a+hkdpCpHw3qEBZJOAtCI5jp1sm7nAfZv
 ejTElDzanHD8u92o5JHz0WTBfPgq/VjyeRn4dAy8UTKUMZMhIfiKDGDEbo6JbN8orUswS74riSh
 sp/mlR+4FOao0TnN85P2kDWXXFGC5rQCR6v99DJ6+qRnH7Nr0SX+9FYRRWNOYnjBSA0gBcXA71n
 JUgo9M2ma/y9Hm7hnVToSYgEC2Dkigb2lQwWfd/ZaiGEXSouMYXABJgR9sEoSNShXlHSnLwcpIC
 CuyTD7WRj+qWpmu4omyq4KWQY93yAo=
X-Received: by 2002:a05:600c:548c:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-486ff027176mr164670895e9.17.1774263276103; 
 Mon, 23 Mar 2026 03:54:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] whpx: arm: remove comment bit that is no longer accurate
Date: Mon, 23 Mar 2026 10:54:25 +0000
Message-ID: <20260323105429.4059580-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

As of Windows 11 version 26H1, SME support shipped.  However the
MIT-licensed headers aren't updated yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260314221529.47841-5-mohamed@unpredictable.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9e5bc03a21..8aa24f2adc 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -717,7 +717,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Work needed for SVE support:
      * - SVE state save/restore
      * - any potentially needed VL management
-     * Also disable SME at the same time. (not currently supported by Hyper-V)
+     * Also disable SME at the same time.
      */
     SET_IDREG(&ahcf->isar, ID_AA64PFR0,
               GET_IDREG(&ahcf->isar, ID_AA64PFR0) & ~R_ID_AA64PFR0_SVE_MASK);
-- 
2.43.0



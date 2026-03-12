Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C03106ACF3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omQ-0007DD-20; Thu, 12 Mar 2026 18:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omD-00072i-JN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omB-0003Hr-DI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aea41d4fbcso7274165ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355506; x=1773960306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydY86TmAe+pPLI175/rOgV0/f4nnjpoSuvgIKZX4zD8=;
 b=zGgSl66PVK5P9ZaU4h4lg5ZLIt6EpZUs/8X3OgHheHCZDKy0mKq73Ag3Du8oO0hWk+
 QxmBVfiBbm9yjASuMlnPayLLm8Udh7cqS9ZKkQHs5Wj41yrLrZSLnxVvtKSHPUiEKVmY
 qNuiQwHQLUiqUo8ziGSxTl9AI1yiicsj0d/equYn9s+MOT/UWhFvH1Hs0EjzVzuid51C
 nxl7Ba/6uoZQGPWrk+fTLca4HH+IqHXBh7NwYR0TU8kNEdczIJQ+m7PSJqqSjfxJFiEo
 fmhJ4cwGgIAGqV5rzaGfTvEt+glEEBCX92eNArM94aBtSyJ7zimdACKwgUjNRU2BmTCD
 7tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355506; x=1773960306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydY86TmAe+pPLI175/rOgV0/f4nnjpoSuvgIKZX4zD8=;
 b=eyoDfQeMTre8eYwsm8OqRylAuwDp7U6GjHGyvIw/0uuNOXPCIO0jGSudDmGJcF4ygi
 GZ2SVP3N9N5B1nw6weCTxooW+DNlddezomdJasTKvcZSy6WwiW/G17hn0foZ5Qn8Fv8Z
 ArRj5e1brFGtc9sTQgcyaSZbmg7JqVEiAs+1GEAvCPKdJyRhi1fzM4fhlZJNP6UDRWyo
 luFL3rkVZiFx+6rDioCM4AbTAB3vZpaVqMRXh0EY/QPuJxDjetZC32yX8xb91znafjWk
 KtCR4rtQlsn9GnGmD3j+1MykpmHf8xEMDj9khsxD3SGXUIkXnxSj8aYyvvf+S57qIeWY
 xaZA==
X-Gm-Message-State: AOJu0YwJwHBOFqvUoiJCZSEZNa8cDDfgUrH2NhVLCgfnugmLj3nDDivQ
 WzdYcl7B0hA9YziecE4NDYz8XDQ3laaXhhbrQWwWxlmBfDfDM7jE+XQfa7Uha9jg970Wu+JQ03c
 yIZGImOE=
X-Gm-Gg: ATEYQzz9c6pisjhg2wbeS4J6ubvThEwRV4Q0xf9+d6ypqhE8QrJ01L7gH5ii3ZNorHX
 /mEDtQQK5Gd1BtgZeSqU62aTrwJUtBEcyQp2AR/eEvrFHpgDf4pIb11ljVU2lwBueCra0UnuFWB
 LVGFpX2zfEktG/LsxRjLREFItCi1KwQsglnG4uo7Hfc04tBPspARFq6oLY+3yWaggc7q2Zo1EAF
 sEr10veW5+ldK9fdgLTOdqQ1oVI/YCzxn7a4oZUIRwIJfdMpxj/vFqINK8ltB/sR7HsB5th1WE5
 39uuRQZ8ptUJm6Zqa2y+clwQJ053O4g3OYT5/wyr2nr15+p82rDq2sTtSnKv9HZPR+MrsXr7jUp
 jZZXiSW8Bv4WOSSWxrwdVLM+4MsAavf0LcTnAABH6/BvtZDs+dhmTkFfWFX8tbcffVIsH7OkXZ2
 s/osU01YFeB9eYweIuG32EUr4Bo/s1YkLo9M0qt/JQIkBBbvIVOohhBOdl3SzmHKbqakZl17mCT
 7em
X-Received: by 2002:a17:903:230f:b0:2ae:3b36:23e7 with SMTP id
 d9443c01a7336-2aeca95fcebmr10982105ad.16.1773355505829; 
 Thu, 12 Mar 2026 15:45:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 6/8] hw/vfio/ap.c: use full path for target specific header
Date: Thu, 12 Mar 2026 15:44:47 -0700
Message-ID: <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/s390x/kvm/kvm_s390x.h | 2 +-
 hw/vfio/ap.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 649dae5948a..7b1cce3e60d 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -10,7 +10,7 @@
 #ifndef KVM_S390X_H
 #define KVM_S390X_H
 
-#include "cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
 
 struct kvm_s390_irq;
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 856fa2678cd..3fae9ae9814 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "kvm/kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/s390x/ap-bridge.h"
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1337C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6R5-0000PR-Ms; Sat, 20 Jul 2024 05:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6R3-0000FP-Kl
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6R2-00071j-4g
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso12049095ad.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467883; x=1722072683;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7Pn/awe7YFbUwLON8GOovUdtzCktNX5WHOGmuP4ywM=;
 b=CvlG0FrRD4PexjVmtliQMD5FslA62oaUO4eRSzscruNztd9aMynY4eNtddCnQOKkZP
 0uXR4eClo6u55jOQ6JLggszE3QCtx5TsCdE44yH0657Kqd63sSDrZvTeZxSKNAyvY3yS
 mPgRZzVr30ouSV8xzSTwBfTS+6bUVR+Q7yozPElAAZnpex9SQ5Ro2N7KUm9aVSzTX2aU
 WenW4DnDk0q12YPkasVoutS1T0qqaSrn5DxDQ5PrvaIjHQu1Qne3OzcEz4joRAA6wcIm
 sR6OEQ55svHGA0Z7992PlGsIlL/CTjPre87TD0zXbSD17BAO4sEeonkr379A6QWG75or
 Xwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467883; x=1722072683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7Pn/awe7YFbUwLON8GOovUdtzCktNX5WHOGmuP4ywM=;
 b=U4bKR5YGW43G/j6Ag/4feWWw+DZtEHEtn22Y6AeCRpSTeroKSrx1RiyS1E+BuynecQ
 pf/R9CCvSTsYts5PNkfneunZxtovgjtLrxd5eG9zl5lht33+9dX2SBkLvzD2vSI+Y+IV
 WFcqbOSkkIV4kED8lKqUTVxhlcTWVV3TPeGXcjD+4VKKFxsE0R0Nm7mBatIQXUedYAKc
 n3g75E9eYKQSBcwHfHpDfBk7raCDuu1WMajeSQxN4HjZpHbuMx3B+dfhaOwCCnQ8iSna
 Hv06VNgMnNmCfe9HrAY88QvCjtMFP6Bo5IwxmsgGLp7g2qLvFLx7TP9fXgzrVQcO8Cfk
 zSjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVujOoFOvHEpL0SAmfbG/EijXskKDk12dAeB3osNAAxqFIGK+Ehwf8d+KjNzO1qovAYLYp6D2BETA+hPNUkuCn5xJ3EnRg=
X-Gm-Message-State: AOJu0YwZOCy0hATKRtlW29g59vR/cTPIBHWtgOx6DBu1ur+TZapFZb9+
 rPjTFfjbgjdMZJvBPveZ5YL/BvpaZtkY46vIcRBg4iAXzTdpu/S6y6oZpxMXWcBevnPm7QSGBBb
 UU7s=
X-Google-Smtp-Source: AGHT+IFuUHFAzQo566bTzAMkFSDEqpnCRbmcEzn8TLq/DlebkV9YSGugyGdb6Hgs68lyvmeUqWCK3A==
X-Received: by 2002:a17:902:f682:b0:1fb:9cb0:3e2f with SMTP id
 d9443c01a7336-1fd74573c4bmr20335395ad.27.1721467882736; 
 Sat, 20 Jul 2024 02:31:22 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fd6f3181desm18119545ad.128.2024.07.20.02.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:51 +0900
Subject: [PATCH v4 3/6] target/arm: Always add pmu property for Armv7-A/R+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-3-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

kvm-steal-time and sve properties are added for KVM even if the
corresponding features are not available. Always add pmu property for
Armv8. Note that the property is added only for Armv7-A/R+ as QEMU
currently emulates PMU only for such versions, and a different
version may have a different definition of PMU or may not have one at
all.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c239181..c1955a82fb3c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1741,6 +1741,10 @@ void arm_cpu_post_init(Object *obj)
 
     if (!arm_feature(&cpu->env, ARM_FEATURE_M)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_hivecs_property);
+
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
+        }
     }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
@@ -1770,7 +1774,6 @@ void arm_cpu_post_init(Object *obj)
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
 
     /*

-- 
2.45.2



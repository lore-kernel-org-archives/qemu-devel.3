Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF73BC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3D-0003Qu-P0; Fri, 07 Mar 2025 13:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3A-0003Pu-8g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc37-0001M5-HH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39127512371so1309824f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370631; x=1741975431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k75P2fUqxCLcSZyEfoYQ2NgIkqW5yPRPNiO+LCjfzGI=;
 b=Oy9MGvdkiS4xtarc8151CKlH1mmy9cMDrMwKx5BB31Wh3UMUEfQ6/ZRyD+Tb9wtrPH
 2pFiLRl+uvN2xL8i2dqbWb7HBsseUe8qxME7978Et1bclHHjcMg4lyZ98gc80p3Tdx8m
 3CEzhMQ16D50wSxhKnLLmYc7jBE1uiBNktIVZIdYH45P5YWbCnRn1SRhIoewIsg7ICD+
 cY/TpqBjAoA4yEaWulhN3hmKXqmriXRDrwMgDMpHqWHB5jNKqN0egyrh36mcXikoWxuA
 DRtq9HiwOICh5N6VKeDRDsaSCjLfHfQkw2hCzsJm0SLHK0seKEQmbkTyG1cB9JCXPjzZ
 0JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370631; x=1741975431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k75P2fUqxCLcSZyEfoYQ2NgIkqW5yPRPNiO+LCjfzGI=;
 b=LBbzTl2jZR3f6AzAx7A6BIZZxs46HChELWifwnBMFXZTJXIS3zilEBcbeYWAvvV6T5
 EshnztT0gI9e1W9MN6IphzUOQ6PbZN6GUjngt+3Yox7zuQc2D9SgsBtMS8SmnYP9FrQ1
 /kkQ7fnEl9OsPW7IZQ0fXaWOEoAumYcH+2MhNWST+3fjXXlrbhEMKMTGOjwpE4GKqYq1
 CbFTWYU4gk+oZ9EbzuX6ktzcuMvLP0mwzd1DG3MWAS+qz5QKTbhToxynWsEUfb2dRNqB
 5yApLVWnrSWOorNzpSpaF3bxhJ8y6YxXqBan//ZwWQx6JNuCizdP8boXxL+UIRiqG1ZR
 Tmrg==
X-Gm-Message-State: AOJu0YzbeDJMCXIeoEljzQHi6Fvs49MEoRHkT05u0Lcp9+YaSXNCBlYs
 nDvqJDRELqsGEnDjcP2lyS3ycXn70BbDiGIiKweq1l1juHm8ZFpjCceydjXHA3GTwAm+ElE7i24
 lx5w=
X-Gm-Gg: ASbGncsbBFyNywpLx5Plc1TKxCwgrkfPGHKqpBPBdIpqVmoQz6rAhyHFuOG2iYnWQQT
 kOgkHAum2TrFmTvAz/xqCm3ZN2zWijUXsJr1EaSAdqs3WbDaqiS9n9Y4HFw86ima1opY9LN+u8X
 dUAOwjZKmvqBSUjvK08bh2FmbAZMjOSOsxYTdd6+jKj2xw2JOklPwWAo67H66HPSyqNZXDvSWgq
 BRDgsrCemcqz8Ga9vyBRZ3qdIjvMW09mPAq1IsQg4ZJal+R5LjzaDo+dy97IAoirEVmRt8bVR18
 4tEPHr/CRWi+lc23prVKabg8NLU1p7DrdRwJCWIskcFdgjsppGKQg5SxYTe5tJTf7EMCUYfD6M6
 Q0u4tGwaNC1v8ZQDjlpI=
X-Google-Smtp-Source: AGHT+IHYEmTztSGGumLd9aL/cX0/wZGEavdogLPn/DgZYSC1IJEj6byPpvVwnQkBQTNW86k9v9l5pQ==
X-Received: by 2002:a05:6000:178d:b0:390:df02:47f0 with SMTP id
 ffacd0b85a97d-39132dd6b75mr2573700f8f.42.1741370630655; 
 Fri, 07 Mar 2025 10:03:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c836sm87577545e9.37.2025.03.07.10.03.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:03:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 02/14] hw/vfio/spapr: Do not include <linux/kvm.h>
Date: Fri,  7 Mar 2025 19:03:25 +0100
Message-ID: <20250307180337.14811-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

<linux/kvm.h> is already include by "system/kvm.h" in the next line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/spapr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index ad4c499eafe..9b5ad05bb1c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -11,9 +11,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include "system/kvm.h"
 #include "exec/address-spaces.h"
 
-- 
2.47.1



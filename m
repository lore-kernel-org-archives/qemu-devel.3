Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B2C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 20:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44pB-0001bD-Nz; Mon, 06 May 2024 16:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44oz-0001Xl-Ny
 for qemu-devel@nongnu.org; Mon, 06 May 2024 16:20:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s44ox-00089G-P0
 for qemu-devel@nongnu.org; Mon, 06 May 2024 16:20:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ed904c2280so13373535ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715026822; x=1715631622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8A42D/lSthnPPSk+x6BhOVc3H7hbU6RH1OGnAQNJSCM=;
 b=z2J+GXCHSrOTZ+phY7o13Jsq1MPZgjtmqSGsV2+FR6jrGoKK3Np/L3L278i0K7GpUh
 z1K30HfUC6bHUrr9LZnAv+dUYoBM+z/nIYfdfb1pT+ELUfM4d0l2EL0kUFj20z1JYECn
 GMjH9dS0vuZv6CP3wB8M9VPBzfAriqHWcyVPXSi2gWxJ8ug+NUxy2clf6E3W0lVYxkez
 P44/vH7po4tAzcOivtq5nr2ZespATgKMRl1NDPvmjog6cMTCK7jr5wwyrENGNToKRNxZ
 l01FBUfhDuSr4v+60b/h34SU051W5Z2mCzmGtSrHmAeHWzu6ck+QdrTg6UC+NhtTdFLZ
 1C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715026822; x=1715631622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8A42D/lSthnPPSk+x6BhOVc3H7hbU6RH1OGnAQNJSCM=;
 b=cRdQxgHb6MTH9DQ+lXJTsb0WMyacvtz9D1WutwMFrnRnTujm68VopPO1H0PC2BgDti
 qTQ8x6+/KFbb6WgZbj2TevEs6HwvO3ZUXv2mKGKWfEfC+pNcmNeNC4oHazQY0y0hUSD/
 ftohRYcwGBu8ItirbtevfV/gqDOlUre8HTMMrKSNiH1S9OSyonR74Nb8yJEiftq7jlNa
 iFxyk8YIspBqhwf9BGPQraJS+KixkffSYOqIfzwCrnTz/LmRdrgiYxTcCbJ8ir5s7vQq
 vT3QhWs2DyU1SO750sf1mfTdmHiXeHcvA6M/4hvKydD+jEbntfJH3tnLZIwwEEHYkcMp
 VKTw==
X-Gm-Message-State: AOJu0Yw+7ttiuzRdi6CPQCSSPeo6LdcxVDiYIJZsi9XrZxxiKyE04Cqm
 Hw6FUTA9NavnGtH4nqnM51xsl6GyHumE4eHvQNNoJpeDd06s7gBGIi2HGvq59qJNlW6IliUn7vv
 6
X-Google-Smtp-Source: AGHT+IFqcK7gRxKEEbIifTN8haRoCSsgQX4y9TdGjrP0WUM07tjgZeFO2VzbCq6PD31aPM1+CN6ENw==
X-Received: by 2002:a17:902:d54f:b0:1ec:5f1f:364f with SMTP id
 z15-20020a170902d54f00b001ec5f1f364fmr13778078plf.26.1715026821828; 
 Mon, 06 May 2024 13:20:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a170903234400b001eb8fb27b59sm8669052plh.111.2024.05.06.13.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 13:20:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	thuth@redhat.com
Subject: [PATCH] gitlab: Drop --static from s390x linux-user build
Date: Mon,  6 May 2024 13:20:20 -0700
Message-Id: <20240506202020.422514-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The host does not have the correct libraries installed for static pie,
which causes host/guest address space interference for some tests.
There's no real gain from linking statically, so drop it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Per my suggestion in

https://lore.kernel.org/qemu-devel/50c27a9f-fd75-4f8e-9a2d-488d8df4f9b9@linaro.org


r~
---
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 105981879f..3a2b1e1d24 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -2,7 +2,7 @@
 # setup by the scripts/ci/setup/build-environment.yml task
 # "Install basic packages to build QEMU on Ubuntu 22.04"
 
-ubuntu-22.04-s390x-all-linux-static:
+ubuntu-22.04-s390x-all-linux:
  extends: .custom_runner_template
  needs: []
  stage: build
@@ -15,7 +15,7 @@ ubuntu-22.04-s390x-all-linux-static:
  script:
  - mkdir build
  - cd build
- - ../configure --enable-debug --static --disable-system
+ - ../configure --enable-debug-tcg --disable-system --disable-tools --disable-docs
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync check-tcg
-- 
2.34.1



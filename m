Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F4C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4W-0002q2-AM; Sun, 04 May 2025 21:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4H-0001d1-5z
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:29 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4F-00035c-Em
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:28 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so3138842a91.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410186; x=1747014986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwtW3h2lhmGSEKiIMjkXffP91aavJQ5GIexA+kWESbY=;
 b=u4uYnWzXq9o/aYLnvXrASJ43lteLXhF2aMQsMjGG7W/iR2qlGA1Mx/M6afv+bXfiQu
 wALskGCKNKVz6sZwbPyrESM7i7IHkxL/rBC2jSzadXRN6rto+au6ybgUy0CbPtM3GoJO
 tLc6OgO4/S9ht7wf/q0yEUoPAZ4xYKwJpwrQ7I1s7IjMSQN7j2ylDsDDfOJmwtfqbwxm
 icBx5HTvSsnVHhAtkbKBn/dtXltY8xmy+AFNkI2x+PLHIILbqH90sal2ibNLGyQW2WR5
 MnmnHtLwCMkdOery0HmxKAbzY6cDRBMeqisqBoMQkNPGsE7WIoGKfSWS7x/zIQpcqbKf
 Mdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410186; x=1747014986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwtW3h2lhmGSEKiIMjkXffP91aavJQ5GIexA+kWESbY=;
 b=H3GaCtIg1qLHfcC4D+9RC3CLUln8h/KDSGaQWqrIuPTGln/oe+R8CJWi+lQ/rVBiub
 CnwW7L+r7+MdmfDq0WlcISOnNMjLp4L9J9mRUNKmBFjQKhgZ81GTrciXq6XFZgkYa9qK
 5kCVotipYQAQTCZh63BIoB048w59SXOn6c3dYL50I4XMeoqFycRjfENdv2YX2jgPqrM/
 yaTcuGxN13z2hy+2GTZgeEwq+2PLngPSaNDkjkx3WGkGxYWBlOY5jrh/mu2w17QgsJ4Z
 yo7H2u7XCW2I3UFC1e+RGhjSB9NPDf+qtyJA66DccRw3OGpbUAIfexgFWovHxoGfQYeB
 k8qg==
X-Gm-Message-State: AOJu0YwN3vhI5ndc5MscFlCM/kg5cZ9vChNQKZYjcWGJZnxk45jjVGbO
 4nK7xq6ZycBsdQbdsBlOhScI66/3jrc3jGctyZVRzHyywlGYMV5IogCUQ5zomHgvPXZQO+dlU37
 5Xd8=
X-Gm-Gg: ASbGnctrxoheoKKnj+E8kZmqfHja31fjSU5VNtf5ddRIMM6rocpCCjg21TZnIf87mA6
 lvI2KhDcA5uUshqJba219URBCFpCJgMuLTlthRiGHwzOSNa4dpu3ppqcmbPWp2+5XtRq8LSvt/8
 xxhr//TH/3jVzoamzcLST1AcOan40vw5tR7QZ+/8PY9K3on0eLC0uh6lXjixwx9mRhR8BKdV21D
 3QVrMKKG37Mw3Wm8BoTSB7Ww+ca4bpHt7ZbUdp4dYXQTpvKH357njV5po8okduW+1upnaghH21X
 0sjyTEVK8DxWTcOCuKxEz1WKmsieilzwAbFmbUBu
X-Google-Smtp-Source: AGHT+IHKR+PswofdfKp0nxf06Jv71gPjzeL8y5qHvCFV+VW1IoKs729cDWlWpUQeBdcpCI9oplKMUw==
X-Received: by 2002:a17:90b:270b:b0:2fe:8a84:e033 with SMTP id
 98e67ed59e1d1-30a4e5626f4mr18713516a91.2.1746410186079; 
 Sun, 04 May 2025 18:56:26 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 42/48] target/arm/tcg/hflags: compile file twice (system,
 user)
Date: Sun,  4 May 2025 18:52:17 -0700
Message-ID: <20250505015223.3895275-43-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/hflags.c    | 4 +++-
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index e51d9f7b159..9fdc18d5ccb 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -9,9 +9,11 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 static inline bool fgt_svc(CPUARMState *env, int el)
 {
     /*
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index e3be0eb22b2..8623152a645 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'hflags.c',
   'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
@@ -65,7 +64,9 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_system_ss.add(files(
   'crypto_helper.c',
+  'hflags.c',
 ))
 arm_user_ss.add(files(
   'crypto_helper.c',
+  'hflags.c',
 ))
-- 
2.47.2



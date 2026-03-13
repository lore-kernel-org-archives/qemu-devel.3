Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73216106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwM-0000R5-QM; Fri, 13 Mar 2026 02:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwD-0000HI-TZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwC-0007FD-68
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so1319799f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383034; x=1773987834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+qQtMF7p2qJQOP6KNVbyTbfqwpnIfur08mXAwzwoRw=;
 b=RoegTEEWrhdjWEjsp+D9hZRDmceWwl8w5mZ958gJTcjSLsvEVh5PhClJAiB01bHb4L
 fu9oYrt9NrT0NPjHOhVdGi594SNV54pOUt2wdb4P6GdD9L9DN+OsaX0tNNIVqsVjgzD7
 kRF35+4s1TVCZSUU19Ronb4m/pR1wTKAPlCHpoGdVXYWreNvK+8j/sov33DSG5G/yhxZ
 ZPCEGnKi461+800du+wCXoMncPjpEzngYXTNapsA62x0kYs1tctMxHTtSvCBV7bLwmZn
 oW6Q2ZzH7xP8tW+U2d4o33AGNwdLAoPsRTGoo7mrM+UPujM++5tQ3Th0jJw9pkwpcGoX
 xPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383034; x=1773987834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+qQtMF7p2qJQOP6KNVbyTbfqwpnIfur08mXAwzwoRw=;
 b=KxzqXP2G19aV53Ux9zTjw4bkVrkpOMmeiTUj578ToVGwcbqq9950LJXNrgX66PhIgf
 7SH9ptZ2tx4Ald2EnICINT5C6+F6jAYtCU36b+DsAi270oRKZoT57/6e4iUbbtW+E63t
 onenQ4RbM2EClscz6g5FrqhhD9Fj973IrjeTnjjaMaDvXrJxo8kL+mpEcx5Mnr55a4Nk
 seCAMg3zenU0FWOedKDGWxGM2epn8F0AFKT99cz1im5c00E0aH4JGSflzlit/gwNbdWc
 TxC9PJK7jgjg2OG1Z7s9/ZymQf38BpN/aLzX0LsCJCBrtLw45Uvwd/rP/SfHLfaVdxka
 yBhg==
X-Gm-Message-State: AOJu0Yyn5AQf0bCKWk5dhmVY4rbvr7RcNuUoBaT3O+pY+DnlmnNnBmN9
 uE3IjYpVCimak5UnwmfiwyJgVMCLwOHEla+vvNQ36oVi0a+Z3w4tn8BXDTPVhrIopL7m8TBZPtP
 n45eMgEM=
X-Gm-Gg: ATEYQzz41GdGsH96dPstDqA/PiMR7+tUJDWlzleN6BTJVb7t5XSoNCT+ZRkDe6wijh6
 4NNOzk72B7mada0UqIp9oc00t9NT6edZn8JgQIbXIjlOwpT2ZKPaWpdgdX/SU/NrcUUV/Jp9ehb
 yJ14OcfyaOAE4sUez1qQAOWOuo78rGzwF2rNU30fCUFkVLCV0qRUWp4FqhNb//AQZQHMx+Dyi6c
 SDmo/RH6X9HTd7u2LRUGHihqSXxba9+w0WvWxDsuwyDAfXjmy9P5SWclp65hcZjYExRljjpA+oQ
 npzer9/RpaMH0TV21S//cuCHC3pZ5SCb7pDXbQ+JNPmh478XRX7glgtXa6QyuKwMveSfEP0XfuG
 aQG7rYoGtVbIF5xX2wEQNY9yc9mD1E7tkT+c6JsSh4+gnx0mNAJD3NEGjIa/g7ELssWGEYhVgDr
 1MlYZ8t/M3EQAh/lekGdlgwwRaC3hwVw/nlYmO2iEqFcCv+Iu9rfmT5N2wyuFEefjYk94lWHJhs
 fs7tWAMjE4e48NR
X-Received: by 2002:a05:6000:4205:b0:439:be04:13c4 with SMTP id
 ffacd0b85a97d-43a04d8679cmr3844766f8f.4.1773383034331; 
 Thu, 12 Mar 2026 23:23:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1abf84sm14054176f8f.14.2026.03.12.23.23.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 26/38] hw/microblaze: Include full path to target 'cpu.h'
 header
Date: Fri, 13 Mar 2026 07:20:42 +0100
Message-ID: <20260313062055.2188-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/boot.c                     | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index a6f9ebab90c..b4a80b042b8 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b3bdc4d65f2..8f9f54ff1e2 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 0c9a6bf2529..c5f64319009 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,7 +27,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index f4c55589b7f..00154236bf8 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "boot.h"
 
 #include "hw/intc/xlnx-zynqmp-ipi.h"
-- 
2.53.0



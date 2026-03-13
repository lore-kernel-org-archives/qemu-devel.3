Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8E106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvf-0007Fk-In; Fri, 13 Mar 2026 02:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvd-00078n-Tt
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvS-00075M-1C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so15225575e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382987; x=1773987787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLriJXjD0bDu8pB0rt6wy6KMigkuj8pagE13q+rOGHo=;
 b=MIXX6imct4OzUVmEamY4bz9kq/FJLgcLLSHV+yltWy+iDZKiYWeVW5ouHOmi0/SIgN
 61LWmYIFHnaV7gMLiKaOsjv4F/3FomW/nFUNv5cqdFAtbi51KKnrJiJ4vkN7P6ZyJgqI
 cnc5mHEgQhPBIGkkE6u7cgUIjNJd5AGXqqauDS4tosVrIQxzcZsv5iBPa8kuk/V4kS0v
 e1tHdF8J2JiVbt4ztDtsx6ywGKL7yU3j2qKehfmdHkTBUnJV5mbi16gGiCgKwgYjYoPF
 NJkvoBZE8/G69L5Eo5FYzYuc0EgeSQwZ52rjppXjCdQPB6MjD4O7NAeMUG4uDPdx3mLT
 BTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382987; x=1773987787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLriJXjD0bDu8pB0rt6wy6KMigkuj8pagE13q+rOGHo=;
 b=FwFm/felhOjjd5lssuUs9ObKxaZSY1701qeFAOAG3ktJibF7IL10v0ZHjkjcNaxZqv
 wD0M8VDuMVqTtDuVCQT9YZjP4rns0TIJF2rxBE3p5/AGHg4YwaA8rViv02y8bwbZ9t3G
 EJPr/05H+WEDBGGA+a1gj2B9+NpCtVMy9HPIBWwrC7Xc7UCR0yVY9xTzzCJ4PR3l3hTs
 nU3RAWhBwfjjK6Aw45ASSv83Ewq7Te/2DyWT6+1vRRz07+snTwi9j4JQfRHU2FX5WauQ
 lnesSjfb2GLJVxEI3ipS0Imw02GbR1+FY+oYStloP1VIjPXT+mQl4aGAha+QtIxygPNM
 Sh2Q==
X-Gm-Message-State: AOJu0Ywwg3ISe13qHEdhu+k/M4CxDBjS2rP/mhBFlNRDWvPuhUNAcRmB
 NtzCqbxVbw8OgOFsna2OiSyC7Rt4FHx+HB8J7/agjdN2bEyNiex/YQuDb6QDyWq6OIVG7s0zikU
 vDkYpCNs=
X-Gm-Gg: ATEYQzxLBP6b1brs1TdVmjnx/iinmXQ/uiKVhY9tcY1QcP+i4yPJKmaTwVcwCjgTzEJ
 mERYZyqCp5RySWBFmWJyHVOHQ+pboxt0v7ZnL6yynmCA+6hDhjzn++4QAfNYVqfFESd+F15Ikn3
 ZNhhe0tIBMGnnpbUgRcHc87mSWk5qFSJsoRDOu4JVGcJUTlSUSgcZZhn/OG02A0GwsyKM2fn9aW
 JtzYIg1ybkM43VHKNxrpDwYyjnAXvdhSBxD810iHp+rRTwP4kMNs6QBVVY0rfA4X2fWZnUxv3rS
 o3lYrIEcd7Q7jTDBoZTGolcpXkaPcWbmpP8MHI1Shohwe397Yipnrmtj8a5DVar7Bz+XbVQ2QRW
 snHIDFU9s3T1usGeyXG5n2H4xdFtcZmIkQa4L7t0QGBnSdbXEPua7jqlSeWNmUAznTe9HqOFrgv
 F//KvSPDazedYCnu8Dw5uR2uRMIk1d2JYuqewB6Lvz/OHR5mVuMh/mxnlZ3t0z9FkivCODT3PYb
 1cviw==
X-Received: by 2002:a05:600c:8486:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-48556702d64mr29589625e9.19.1773382986933; 
 Thu, 12 Mar 2026 23:23:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556395df4sm13984785e9.0.2026.03.12.23.23.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 19/38] target/cpu: Do not include 'exec/cpu-defs.h' anymore
Date: Fri, 13 Mar 2026 07:20:35 +0100
Message-ID: <20260313062055.2188-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Nothing in all our target "cpu.h" directly uses definitions
from "exec/cpu-defs.h": no need to include it there. This
remove a lot of target-specificities, simplifying inclusion
of target "cpu.h" by common code.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.h      | 1 -
 target/arm/cpu.h        | 1 -
 target/avr/cpu.h        | 1 -
 target/hexagon/cpu.h    | 1 -
 target/hppa/cpu.h       | 1 -
 target/i386/cpu.h       | 1 -
 target/loongarch/cpu.h  | 1 -
 target/m68k/cpu.h       | 1 -
 target/microblaze/cpu.h | 1 -
 target/mips/cpu.h       | 1 -
 target/or1k/cpu.h       | 1 -
 target/ppc/cpu.h        | 1 -
 target/riscv/cpu.h      | 1 -
 target/rx/cpu.h         | 1 -
 target/s390x/cpu.h      | 1 -
 target/sh4/cpu.h        | 1 -
 target/sparc/cpu.h      | 1 -
 target/tricore/cpu.h    | 1 -
 18 files changed, 18 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b54..bffa1da7ee6 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..445d5a8a31d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -25,7 +25,6 @@
 #include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 518e243d812..3da885c7ccb 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,7 +23,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "system/memory.h"
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7a91399fe02..800ef6305e6 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/target_long.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6ea4c9b6826..85f39401423 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "system/memory.h"
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6fad9571e25..e5ae29f8af1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,7 +24,6 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "exec/memop.h"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 4d333806ed8..096d7789285 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -10,7 +10,6 @@
 
 #include "qemu/int128.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 #include "hw/core/registerfields.h"
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7911ab9de30..d7f508a9e80 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -22,7 +22,6 @@
 #define M68K_CPU_H
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d26b933b6d0..7e7b024bd1e 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-interrupt.h"
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3517d2d42cf..17e9f6039ec 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -3,7 +3,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index c8e2827930b..5bb39b67519 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a0df7a467ed..aba8109bbba 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,7 +23,6 @@
 #include "qemu/int128.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "cpu-qom.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f30d3006166..633d5301f30 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,7 +24,6 @@
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/target_long.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index b3b1ecff5af..b500b7a2474 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,7 +24,6 @@
 #include "cpu-qom.h"
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 40bc1f0741d..3acbe83f0fc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -28,7 +28,6 @@
 #include "cpu-qom.h"
 #include "cpu_models.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "qapi/qapi-types-machine-common.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index b0759010c47..e36268b4256 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 155aa8ec637..ac0eb9f0faa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "qemu/cpu-float.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index ab46192e261..604fb7792c6 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -23,7 +23,6 @@
 #include "cpu-qom.h"
 #include "hw/core/registerfields.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
 
-- 
2.53.0



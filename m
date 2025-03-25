Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48558C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6P5-0003ps-O9; Tue, 25 Mar 2025 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6P0-0003om-Ss
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6Oz-00047A-0S
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3455279f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917275; x=1743522075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMYSIVb6yc31rz11SHW4h4aNXQhfD5IK5ryBRxbffZQ=;
 b=p+j1ZCDeFDXspfYMjvtXOyr2h97Qtd6ut45AgLHao5obGJ9Z7J2ieql4lptLT1WToi
 nJwj71MDj5yi8vMs3MRDztJp+TExZkX9tdFR6PVGq1/26b6uLnGY6DKjLtlOQjp4Uerl
 n8aW/gQFIr6MA5sj0jqVXYCVmaicgLlQk1vjwY1G5Uim3NHq+m9MUpgRgSzI77IeJmgB
 EuDzv/nQdrhdHbqyKvtUyBR95Hea9n59zTyisImjBqCH/98s7KT7Q8bN8FeFMNuLzEoB
 6V3clL9uqy/jSVHoCSIeiNfk8IfO3cROTClgRDv3+zqFAmHcgFO30FKOYHWDssdT02Jb
 BjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917275; x=1743522075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMYSIVb6yc31rz11SHW4h4aNXQhfD5IK5ryBRxbffZQ=;
 b=DLyRSI4Y6zOqyDwyrhaFemv3jqVAIKRA9w2SLzI5I8aiDtQc/CzZAY63Iz9H3obHY+
 0C2fQkpz17IcXEP6//4FZL+dj8wGFtlb6PLFzj3w5rewPVZPPFNXJ+2E/ZguIwxU29fX
 BdEIXhrl+V0bhX5/0r81ZCSPULRxzzfIdtEsVus4VLhPtikp1Rf6Q/BEdI0i/bVnZ//x
 Ip3z/T13P9CH7gVuNJj8yEDnjIxEOVi5jZ0RjNPiYA2vKC8Q8gmNlo77MsXP9PYHLV46
 TgkjK2pQO4gjQ0568A0JQynfRaQVdl9w2eH7wNQqJSOggc3R9NwA+d2UUc4oejLdxnPT
 z3+g==
X-Gm-Message-State: AOJu0Yy6SUwqGIWJMx/UmTvVZfLh3an1vFKpT0nKYxM3xd6zEvD6yZyD
 RQOvxKhb7lIHGIpaJQGFXoNOblU3QgKI65DwiiGcyIUefWgs8JDDL5ukqD55d/nTcn8kZk+M8xl
 q
X-Gm-Gg: ASbGncsDU83aKTsjq2qMIJjVt+pr5BPck77oaZy/cw6aVQDDmMS1zCQ8FVzkYHEt/0j
 mm4ZcNU2de2rfPk81YHQMH5CvGFu1TiGt85Ps4Rbb/QOKt4y9JivaTPGskrh+k7qAcv7iczOs8T
 ubLP+bZrLCQQIXc+v3x3zQzV/JmYxZlf/DXpQul+VJdJtLcoVrC0up8nTswx1UObrU/es6N+R17
 dJznnqCvY3PnbBl/oSOqzRto/K3SDmkLjNaM6++UY24PxOpK0aleHflTBILxbfvLcGMZivbwYhG
 uxizdngEMmPwS9M1amHgTFYtA1uahrzs9LL3KV6ptY2kH+0Aa4Yt3821m1KuKdIo2yad/MweUVj
 4B1/m/gCas4RRL14UbKk=
X-Google-Smtp-Source: AGHT+IGr/+G8hLgLiPRsAV6eVxAjpPCfHdtZUqdYh8qoYfJdWXswrLjL38I6OUf8jQ/RpkIzSOt27A==
X-Received: by 2002:a5d:47a4:0:b0:39a:ca40:7bfb with SMTP id
 ffacd0b85a97d-39aca407e6dmr1866909f8f.54.1742917274899; 
 Tue, 25 Mar 2025 08:41:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d6eab9d0fsm16161625e9.1.2025.03.25.08.41.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 3/8] target/mips: Make MIPS_CPU common to new
 MIPS32_CPU / MIPS64_CPU types
Date: Tue, 25 Mar 2025 16:40:53 +0100
Message-ID: <20250325154058.92735-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

"target/foo/cpu-qom.h" can not use any target specific definitions.

Currently "target/mips/cpu-qom.h" defines TYPE_MIPS_CPU depending
on the mips(32)/mips64 build type. This doesn't scale in a
heterogeneous context where we need to access both types concurrently.

In order to do that, introduce the new MIPS32_CPU / MIPS64_CPU types,
both inheriting a common TYPE_MIPS_CPU base type.

Keep the current CPU types registered in mips_register_cpudef_type()
as 32 or 64-bit, but instead of depending on the binary built being
targeting 32/64-bit, check whether the CPU is 64-bit by looking at
the CPU_MIPS64 bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-qom.h | 12 ++++++------
 target/mips/cpu.c     | 11 ++++++++++-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index 0eea2a2598e..9acf647420c 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU MIPS CPU
+ * QEMU MIPS CPU QOM header (target agnostic)
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -22,12 +22,12 @@
 
 #include "hw/core/cpu.h"
 
-#ifdef TARGET_MIPS64
-#define TYPE_MIPS_CPU "mips64-cpu"
-#else
-#define TYPE_MIPS_CPU "mips-cpu"
-#endif
+#define TYPE_MIPS32_CPU "mips32-cpu"
+#define TYPE_MIPS64_CPU "mips64-cpu"
+#define TYPE_MIPS_CPU   "mips-cpu"
 
+OBJECT_DECLARE_CPU_TYPE(MIPS32CPU, MIPSCPUClass, MIPS32_CPU)
+OBJECT_DECLARE_CPU_TYPE(MIPS64CPU, MIPSCPUClass, MIPS64_CPU)
 OBJECT_DECLARE_CPU_TYPE(MIPSCPU, MIPSCPUClass, MIPS_CPU)
 
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 097554fd8ae..5ed6b3402d3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -607,6 +607,14 @@ static const TypeInfo mips_cpu_types[] = {
         .abstract       = true,
         .class_size     = sizeof(MIPSCPUClass),
         .class_init     = mips_cpu_class_init,
+    }, {
+        .name           = TYPE_MIPS32_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_MIPS64_CPU,
+        .parent         = TYPE_MIPS_CPU,
+        .abstract       = true,
     }
 };
 
@@ -623,7 +631,8 @@ static void mips_register_cpudef_type(const struct mips_def_t *def)
     char *typename = mips_cpu_type_name(def->name);
     TypeInfo ti = {
         .name = typename,
-        .parent = TYPE_MIPS_CPU,
+        .parent = def->insn_flags & CPU_MIPS64
+                  ? TYPE_MIPS64_CPU : TYPE_MIPS32_CPU,
         .class_init = mips_cpu_cpudef_class_init,
         .class_data = (void *)def,
     };
-- 
2.47.1



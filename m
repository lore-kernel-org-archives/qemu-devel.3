Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6CCC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Lz-00035b-8P; Wed, 17 Jul 2024 06:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2Lx-00030g-U5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:45 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2Lw-0005di-6x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:45 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ea2ce7abaso10798137e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213862; x=1721818662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ou+CSdE+RsteI59EhF42GcubahUccwY83pILcCuYj94=;
 b=CM0u5MtwfXcnWbs3/CQInB6/zftJoFQfHgjXPa7CaQs4l2a/DuFq5Qnb7uWEXTj/w/
 2MLuDOTyHcnmR4cA484qmBlcT/3E192x5i+JchhqwN4LaID9nQd5yQIl0mGyjSwPTYoc
 5sDW7uI+NHfIkaDN4iSPWjXlMZ0Rt5vTgLMhhi0L2HX4EtowaqIcISO8fr2HBvvW3i2Q
 QCtXHtE5wnGq+ZHPQ9BubdiSu+VUx0BMnH1U9eGW+1t11P+JJ4vk9xRDUkSiV6wuqTIX
 HZI8NU2Xl7Fmqlb2yT8RAoSKzbLA2o8NcQ/yA+KzeG6PfIzMc75rGxdx+6OV01XRdL3E
 4L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213862; x=1721818662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ou+CSdE+RsteI59EhF42GcubahUccwY83pILcCuYj94=;
 b=GeD2qiG8+BzqeNFiY7sQobkeFWX9nQqJJ3DLjtDkDjaI1/6fx6sWIz4QZnp93mrZL+
 k9Jl6kKSRWqhRsjRJdTCrqrqMlWid6OZxF0SAlt5sJAjuwSdqaBmC8bu0waRYDQHBxDt
 61NC/3Q3VJlXoKzZj3OFGrGygnYW0KDOB4Jr7sGV9lXho3cJnNpSt/ZHS3jl1MymGq2A
 aXaepqc9SbZcSHQmGSX0nj0oakgF9H1yJGjrZIFf/2xP3+JBDnzVS8dZb9Mt8CmWv/rZ
 YkdlVXX6w1peaLXt5hdozUFXxHzTbILKBBWT8n5Ti/hp0Ohzb45BZDcQXcAoXnRX0tKK
 a28A==
X-Gm-Message-State: AOJu0Yw4YyIc2dFZ35gQ9O0syVRKFi1fwcg2n3B0ohX1c3GHw3VF/lZY
 RdRIiujEwGfyTbE+63ggB4rV9rYGl45KLOR40aeMxwE3MsRTZVrWq4+L2C8l9yx41dqNMt57esm
 H0uGfIQ==
X-Google-Smtp-Source: AGHT+IFPg+DItzAcEnxpiOtkR+wnPj14zG+bGUCK80yc79bIL8YTw7OIF1FlI5soLa5Ja4AryhUu4Q==
X-Received: by 2002:a05:6512:ac7:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-52ee5411e3dmr1222139e87.50.1721213862089; 
 Wed, 17 Jul 2024 03:57:42 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e81f0dsm165095375e9.12.2024.07.17.03.57.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:57:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/8] target/mips: Add semihosting stub
Date: Wed, 17 Jul 2024 12:57:18 +0200
Message-ID: <20240717105723.58965-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Since the SEMIHOSTING feature is optional, we need
a stub to link when it is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/semihosting-stub.c | 15 +++++++++++++++
 target/mips/tcg/sysemu/meson.build        |  6 ++++--
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 target/mips/tcg/sysemu/semihosting-stub.c

diff --git a/target/mips/tcg/sysemu/semihosting-stub.c b/target/mips/tcg/sysemu/semihosting-stub.c
new file mode 100644
index 0000000000..7ae27d746f
--- /dev/null
+++ b/target/mips/tcg/sysemu/semihosting-stub.c
@@ -0,0 +1,15 @@
+/*
+ *  MIPS semihosting stub
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "internal.h"
+
+void mips_semihosting(CPUMIPSState *env)
+{
+    g_assert_not_reached();
+}
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
index ec665a4b1e..911341ac37 100644
--- a/target/mips/tcg/sysemu/meson.build
+++ b/target/mips/tcg/sysemu/meson.build
@@ -1,10 +1,12 @@
 mips_system_ss.add(files(
   'cp0_helper.c',
-  'mips-semi.c',
   'special_helper.c',
   'tlb_helper.c',
 ))
-
+mips_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
+  if_true: files('mips-semi.c'),
+  if_false: files('semihosting-stub.c')
+)
 mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'lcsr_helper.c',
 ))
-- 
2.41.0



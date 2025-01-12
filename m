Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB9E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6K8-0004Hs-M2; Sun, 12 Jan 2025 17:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JO-0002hY-3k
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JL-0006ay-MX
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43635796b48so22731575e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720398; x=1737325198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNNKD3FB/GFpxFtn1SMHag0AGZZmeK3Dg8kU3DWDxRk=;
 b=FK9JQ7z6Wns1zd641kz5O0qr4jwS6oIPaaHus6oF2NUhUkOFeUfxz77c85orEeuQuT
 4/SjvwinyaLwv2S2YDVwN9Wo7Ud/n8Jp2NJ+XIk1vfYQFfsaftsEpUQ+ooRXZOqj1oA7
 SOVzOyuAqxuovQFD3ZManbCH7VT1lOLVw8Cfz2bYhQjVp1iWXCAeWIhbM3vSaK1RIi/Q
 /BHLhjdvhZM+H6K0WxxjlTe2MDfRweVx0VtTZzzAgwpuof5E7rxIQWGzhhI4HxsRtBah
 Zka9fJGou3A6xOuB785FgWO8ZQTwYls+CSfY04ITZpuAjOaUKS+zfDeN+ZmoBqq8EwAs
 AaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720398; x=1737325198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNNKD3FB/GFpxFtn1SMHag0AGZZmeK3Dg8kU3DWDxRk=;
 b=E/uYaF4QRcLjCMBRuvNTNy4Fhfv2mPKcqn8QWp0SQNuBcWAbd17UUMZ+oZiPdVqWf3
 sAkHk303zvQW7rxpcBlafOrCHF2GvEErcPOGNDs+RWX0+KiikpvTFy91tFR6P3Yk9vN1
 qHUf2RZX662YEztnNra8kSbqKf/jCNHoj30SypAp9CdB6L5ATB0CUsGDnrCmzw52psYQ
 dR6mRUqfuQNDjf77ZQQspLG+R7U5XOnzbmezX0K24cIWpoy1/BrkYG7kRSJiNndUk3o9
 p3X+zoXBHZVrN8NgtcuvwGzlFFlxVG9bOMMJnFep4UYqcNmv905o5WZJimrurjxAJEpy
 dVAQ==
X-Gm-Message-State: AOJu0YwMSilztwMVQEUEiucFBWSJ91iCom6wP2jl42nhdfSuXWf4rvFM
 HDCH0FMXh2mNbsboJPLqOeKAX6NS0jUi6dj3mOIl0cYkxSNwQwx3550+PhNwvkhrYQ+Q6j0ksOs
 6NxM=
X-Gm-Gg: ASbGncuwZbTtssVK54slvU+lrRleiPI3bQIIv8v/94AYhNK65Y9DbnRH8xvpPNBSdxR
 rZPgQ9wM3EMkFUvqITMHScazU6zihhU48wc0bdSv+DmVCQD+COdpU7i3HrArMgXNAScNc+Yxq/f
 /QnjT7zQYS/R48o1EXlj+YjH0MEVZ95B1K5PO/NmGR8W1c2yexegkQHZLunjRcl4U46loufDFz6
 9vGmiXBlapiLGqF99eLqLuWpi96udbWNqqY8CCnk1ln8WRxgRO54nfNre/x96aJ3Uw/8sicMssi
 le2IWMPjZO2HOILTj2R5dOPC1iRx5QY=
X-Google-Smtp-Source: AGHT+IFJ0M6M//ozghkApe6K0G9hUIFAed52tsDgWZLMjCiFxHGq+4EzJ3f9HsP+Em4Z/cI/hgDwjw==
X-Received: by 2002:a05:600c:83ca:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-436e9d7b51bmr119415385e9.10.1736720397797; 
 Sun, 12 Jan 2025 14:19:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7ff0sm10651711f8f.77.2025.01.12.14.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 30/49] tests/qtest/libqos: Reuse TYPE_IMX_I2C define
Date: Sun, 12 Jan 2025 23:17:06 +0100
Message-ID: <20250112221726.30206-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250108092538.11474-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/libqos/arm-imx25-pdk-machine.c | 5 +++--
 tests/qtest/libqos/i2c-imx.c               | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/arm-imx25-pdk-machine.c b/tests/qtest/libqos/arm-imx25-pdk-machine.c
index 8fe128fae86..2d8b7543439 100644
--- a/tests/qtest/libqos/arm-imx25-pdk-machine.c
+++ b/tests/qtest/libqos/arm-imx25-pdk-machine.c
@@ -23,6 +23,7 @@
 #include "libqos-malloc.h"
 #include "qgraph.h"
 #include "i2c.h"
+#include "hw/i2c/imx_i2c.h"
 
 #define ARM_PAGE_SIZE            4096
 #define IMX25_PDK_RAM_START      0x80000000
@@ -50,7 +51,7 @@ static void *imx25_pdk_get_driver(void *object, const char *interface)
 static QOSGraphObject *imx25_pdk_get_device(void *obj, const char *device)
 {
     QIMX25PDKMachine *machine = obj;
-    if (!g_strcmp0(device, "imx.i2c")) {
+    if (!g_strcmp0(device, TYPE_IMX_I2C)) {
         return &machine->i2c_1.obj;
     }
 
@@ -86,7 +87,7 @@ static void imx25_pdk_register_nodes(void)
         .extra_device_opts = "bus=i2c-bus.0"
     };
     qos_node_create_machine("arm/imx25-pdk", qos_create_machine_arm_imx25_pdk);
-    qos_node_contains("arm/imx25-pdk", "imx.i2c", &edge, NULL);
+    qos_node_contains("arm/imx25-pdk", TYPE_IMX_I2C, &edge, NULL);
 }
 
 libqos_init(imx25_pdk_register_nodes);
diff --git a/tests/qtest/libqos/i2c-imx.c b/tests/qtest/libqos/i2c-imx.c
index 710cb926d62..6d868e4cc4d 100644
--- a/tests/qtest/libqos/i2c-imx.c
+++ b/tests/qtest/libqos/i2c-imx.c
@@ -209,8 +209,8 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
 
 static void imx_i2c_register_nodes(void)
 {
-    qos_node_create_driver("imx.i2c", NULL);
-    qos_node_produces("imx.i2c", "i2c-bus");
+    qos_node_create_driver(TYPE_IMX_I2C, NULL);
+    qos_node_produces(TYPE_IMX_I2C, "i2c-bus");
 }
 
 libqos_init(imx_i2c_register_nodes);
-- 
2.47.1



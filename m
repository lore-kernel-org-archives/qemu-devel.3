Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F85C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zwz-0001k3-T4; Thu, 17 Apr 2025 20:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwy-0001jW-QJ
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwx-0005rm-8Z
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1301426f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937481; x=1745542281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXcKH0xxrTvGXKj1WGS/noBtY0dqyqmEMfZoCxBxxzk=;
 b=z6Sx9VHQZVW9Bt3yBfwHFBfmWXPMXN6QowbhOIhcbLHTfcj4Eq40RaY7YcoRAvDDCO
 aZ7dgNGYMyuhDS0l6N481stqzgd7QRX9peLvB2KgjV3EFZqaLuGD7r5SQkCvR+AVPELI
 kWHjDHGus4ihNj1mDnFYSrfAlk/Ju8t3ASW/DUN/4c8AEoIb3tt3JWpnT64DKM2jMaAN
 sND5U8K2xQpp9YX+zcGWWJnnm0o+xOUUxTj/CZjg5240eBi+WeNCFEQzHkmFuznj9NOR
 Fo4AUSN8NlUq04myeVdg3NOuy0SORoJLkJ0VFmmTA5s0sUYSiSTUMPzm+a1+aRqZPS40
 yiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937481; x=1745542281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXcKH0xxrTvGXKj1WGS/noBtY0dqyqmEMfZoCxBxxzk=;
 b=OseYy/nuIEXOqYantf0PwBB85wCtQh6dFgm2wKhf7pF6+/8fZb5j8LnomegZlB+kZj
 SSRLZgmU+29Xh4HKetvbfIPaiod66I+bMtizieUH42eHcy3IWkjrOMDF3qGLSxdQi60q
 EYlRe1jV9vouo5KF+pMxpSVwqt+lWC/mH9PVTO266PcfcormMPYGMiYg8VNVgSvKmjIT
 mdetGWPaYVr6xtjKs9BlyAqgp9Sc2jkBwKVEXCSwRzE873afzZvv5ssfSgn1juijed2u
 tziyEVlaa77LwPAv/KZlSDNdZdeszQTe9X0rXEGZitC8OtnmQp/y10+E/1XK5Wu02eM8
 39gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEoGsR0jA6XxCWkG4LtN9LdHA1KDq5qQ8ivjPpt3e2YTdhSMszEkElRHa5P6DLYy5bV2x1DXHFBFLF@nongnu.org
X-Gm-Message-State: AOJu0Yz8+d+g1BrzoaxitT26kdBlGtdjF6v8uU1UGcL7dM9+lKA+1jOI
 A0uIlx6Sg1Q77CDhJOeKfMbVr6zqunnnIIvvqTHE5SpEe5dxeYczonPBpGcpnQrgzBQrDKEuggq
 3
X-Gm-Gg: ASbGnctccblFgIuOByoF0dqS35tuRu2aMbIFiksYihP/4Ctm4vfq0DUZr22HoLLSkzj
 6y5GhJgXTx1m3H95Ymr+76Dq3vaeNvAn5XXfT2puusy8b+13fSkHxpS+RAP3I6gnnH9QqK6bD+5
 2/u/I4DoYCl/06McL5i1GpmHNNIx0EGjLh5fx1I/rCAQDgnLr0taA3oJUwA+cERDwo2K1UkQRH+
 YVa3R0rgjUMJBMsiUuYAHbqmwPr+GEvKY2ai0blleqJTtAQrqrJfqXU5JIsFEK6dSGRO8FcmEId
 /APiX6OY/Spv7CKd7Xqsm0uZKUVYBuqWXKvguMbBxkSQ3tnvITaMZFX6rsDKfc+ZQg6E1RmbcAP
 H10NVYyt29mz7FjpZ+LqF
X-Google-Smtp-Source: AGHT+IG9XUdq/ZgMV5TjkXcqjIYK3A4MrcsKw02GUFk0PeuxTwq3UpAun+YHG7Uz3/wA/Q1I60Uh6A==
X-Received: by 2002:a5d:47aa:0:b0:39c:1258:7e17 with SMTP id
 ffacd0b85a97d-39efbaf245amr634098f8f.56.1744937481115; 
 Thu, 17 Apr 2025 17:51:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ce6bsm1172056f8f.55.2025.04.17.17.51.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 04/11] hw/arm: Register TYPE_TARGET_ARM/AARCH64_CPU QOM
 interfaces
Date: Fri, 18 Apr 2025 02:50:52 +0200
Message-ID: <20250418005059.4436-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
QOM interface names to allow machines to implement them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                    |  1 +
 include/hw/boards.h            |  1 +
 include/qemu/target_info-qom.h | 18 ++++++++++++++++++
 target_info-qom.c              | 24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 include/qemu/target_info-qom.h
 create mode 100644 target_info-qom.c

diff --git a/meson.build b/meson.build
index 49a050a28a3..168b07b5887 100644
--- a/meson.build
+++ b/meson.build
@@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target_info.c'))
+system_ss.add(files('target_info-qom.c'))
 specific_ss.add(files('target_info-stub.c'))
 
 subdir('backends')
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f43ac5d4d..b1bbf3c34d4 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -7,6 +7,7 @@
 #include "system/hostmem.h"
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
+#include "qemu/target_info-qom.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
diff --git a/include/qemu/target_info-qom.h b/include/qemu/target_info-qom.h
new file mode 100644
index 00000000000..7eb9b6bd254
--- /dev/null
+++ b/include/qemu/target_info-qom.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU binary/target API (QOM types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_QOM_H
+#define QEMU_TARGET_INFO_QOM_H
+
+#define TYPE_TARGET_ARM_MACHINE \
+        "target-info-arm-machine"
+
+#define TYPE_TARGET_AARCH64_MACHINE \
+        "target-info-aarch64-machine"
+
+#endif
diff --git a/target_info-qom.c b/target_info-qom.c
new file mode 100644
index 00000000000..d3fee57361b
--- /dev/null
+++ b/target_info-qom.c
@@ -0,0 +1,24 @@
+/*
+ * QEMU binary/target API (QOM types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-qom.h"
+#include "qom/object.h"
+
+static const TypeInfo target_info_types[] = {
+    {
+        .name           = TYPE_TARGET_ARM_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_AARCH64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+};
+
+DEFINE_TYPES(target_info_types)
-- 
2.47.1



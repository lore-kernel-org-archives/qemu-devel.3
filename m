Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0222BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy52-0006aS-SL; Mon, 20 Oct 2025 18:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy51-0006ZV-6l
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy4z-0006HJ-9w
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so6598470f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998210; x=1761603010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lrAQwDz95GQqXWTWVIMmW6B1FdErbGMCTqSMKZ+Gno=;
 b=gp77rG/e4az8kCVXh3cp2sNN4WnjpbnuDUEN+3ysb6ygxnio+5L0R0s7ChsHG8OEdw
 HGv4gBT3lmLoCvjNoDb4P8eJ39nuyhMhXVPT72AiTu6htU2Phh8JBRmRjfOI/tZLDfNy
 FBOjiTNssZRemC/EbvSBScWp+cXyWs03kgatNc7szAkUV2DtE7khbgbOLoe3Z/GqCK62
 NGzO8CyoIQaF1ho6APFqo2zwpohW4L4TGem7OzlQAbemx4Gx/koV7F4pOXxBLneahHCq
 3fbHk2uX5jsXfue7rPgVdmaRFIms6mEoTcTXgUwv1WTtSfCDSEDW4tHsZpxzqoHfJnOX
 eUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998210; x=1761603010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lrAQwDz95GQqXWTWVIMmW6B1FdErbGMCTqSMKZ+Gno=;
 b=u9C7bmFkoQhTQpW8NVfQxLKu5Ue7hfZQON6zspRud9oXYIddMEvnXwqe2dstiRlr4g
 BFpGmmYqrXlFtA+LPX7JDO0r9yUzht4IiinnY7fbqKEjQKn4lDk6ZTVR5VDRNIslKMBn
 04Sm71PLdeI6OwfbIfGQHT30/6qhVoXw4AlGPcQrMpT+i1dnSPfqDYSIq3gLBWTX6Qmc
 sbgJIuheIj7BAU8FfZ2WjosAKQ3aiEBscQn/yVebuhP+lclQCuQjeB7xLGk5gOlqQjp3
 /aeSMRtCnD3uP8+nAGk9oCBJ8CAM+n5Aq9D2Qxs4UzRJ4U3nkII6d9cuQ4wzHPLpQ6dA
 B+TQ==
X-Gm-Message-State: AOJu0YxJnRfe2aLlVgbTq1CRW98WjssLUsvqxeCHBbfqEQm2LKd+5sQd
 4r5eCawRKY6ZhqviD3oed7jDgKPiJ6Nx6CfSh9DxnVzqj4JpayobPXkUPWMuKtd/d6mU9FC9XCO
 n4iGp/Ng=
X-Gm-Gg: ASbGncsKYQZyhRYNceOA/F8BWb/LFDJpHBzPeV0jqcicdUluaQggpP86Oo7UwZNtmFS
 ybWQLM4CiDQrQ+kici5slAMSaVaMQtuaGfrYpyeJq/nALmtJpZ0rKx8CTptgT2+GAnVPDEacxyB
 wM2SGtamLIbzy/RCogDSmR0an0ubnpjSmx4QWIfyVEMlp6D5Y7b9kRv8WviyGF7VP/QCVi+F3+h
 sRnRxDILe8GfWwaIkTICWjKx8SiVGvSianulc3nJRtPgwDHHm1BeaZRF2M8TzCZIqow3pnY8QD3
 66ZLTuf5XNlWzxmRiDI3z4rmMs7K+2BByfvtdt8ceNteQhvUZebaw2sFvmVk/Kz4FU9ujipGstU
 AmDRr0fCsAhuuLxLtoscHtm9zV/d7aBrHRmZVi0NzZ029J3wWD1p8wnCwN2Vgr82EggHppeE5jX
 sovvKtmzYqyuhhiuxdGnmLMcnGEGTRqxh5sDqzWPsEpb2vZauttg==
X-Google-Smtp-Source: AGHT+IE7jl+5OoelQ45gRLY7eU9Zi9ITtQbyLnKajxsW1hFsN4yUTU3ZGUOfIZX7Y7/JhPpNYoJH9Q==
X-Received: by 2002:a05:6000:250a:b0:428:3bb5:5813 with SMTP id
 ffacd0b85a97d-4283bb55a33mr6670199f8f.59.1760998210332; 
 Mon, 20 Oct 2025 15:10:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496be2eb6sm2667735e9.2.2025.10.20.15.10.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 05/30] hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM
 interfaces
Date: Tue, 21 Oct 2025 00:09:14 +0200
Message-ID: <20251020220941.65269-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Define the TYPE_TARGET_ARM_MACHINE and TYPE_TARGET_AARCH64_MACHINE
QOM interface names to allow machines to implement them.

Register these interfaces in common code in target_info-qom.c used
by all binaries because QOM interfaces must be registered before
being checked (see next commit with the 'none' machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build                   |  1 +
 include/hw/arm/machines-qom.h | 18 ++++++++++++++++++
 target-info-qom.c             | 24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 target-info-qom.c

diff --git a/meson.build b/meson.build
index c5710a6a47c..f4ac0a6e95b 100644
--- a/meson.build
+++ b/meson.build
@@ -3911,6 +3911,7 @@ common_ss.add(pagevary)
 specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
+system_ss.add(files('target-info-qom.c'))
 specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
new file mode 100644
index 00000000000..a17225f5f92
--- /dev/null
+++ b/include/hw/arm/machines-qom.h
@@ -0,0 +1,18 @@
+/*
+ * QOM type definitions for ARM / Aarch64 machines
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_ARM_MACHINES_QOM_H
+#define HW_ARM_MACHINES_QOM_H
+
+#define TYPE_TARGET_ARM_MACHINE \
+        "target-info-arm-machine"
+
+#define TYPE_TARGET_AARCH64_MACHINE \
+        "target-info-aarch64-machine"
+
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
new file mode 100644
index 00000000000..7fd58d24818
--- /dev/null
+++ b/target-info-qom.c
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
+#include "qom/object.h"
+#include "hw/arm/machines-qom.h"
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
2.51.0



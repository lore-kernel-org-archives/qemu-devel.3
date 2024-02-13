Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F21C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrWD-00081l-2s; Tue, 13 Feb 2024 07:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUr-0005Xs-Bi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:49 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUi-0001B5-VT
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:45 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so56623291fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825751; x=1708430551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DXeUhNBegKLVEEbNriXP0M30d34qp+psgJeRCEwOUo=;
 b=jvw0ArXVumvgMukunOELYqOpZTZG7ErChIPmdbM7QcYz5OdfO6pIG+5OKMIKqsJlVU
 tS+Zhxk3gSJSjcAeMy/j9uhfgeaesSu/RTrMw675AuaLaHJG5KIQtRxfwn40m6DWLCvD
 Wl8ZOS32cS6r/hImmf6ZeiFQRZ+h/oZ20ZvW1MXyJg1akKMW3zqrbIG/ZT+JSbf8+Jlm
 R/VyPjQN8weP8RVIrE3axX/qXMj4PO+Tgp+ZOpLnWoW6iS+C/BaiMXP2C4h5svDny63x
 f4/9ndpWckVFpPvnWqvpLMVHXOsb3vXj9PLafXEY6DN2Ull8y6kp3icb2qQPHNTIqEzP
 h/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825751; x=1708430551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DXeUhNBegKLVEEbNriXP0M30d34qp+psgJeRCEwOUo=;
 b=m9DCfMvSezB6K6180QeHx5s8LwFeHhxie3ub2zqfuwf/JbpBXNpH7igjguJLXLxxeq
 pJGsRfn1e6vF01HFrFCsIIzw8bn2wagM/xta4iqNqyN9Ep3wtH0uOlrDNNy+OF2Szx1i
 RNenm9vygK7NNFjRZzb9PT1xjkzRHnao133ePfxhb66YlOt+786o5nS7LhkVEZjplw6l
 6qqy22TpE9Y6cz8kkN4UegaqyqIxmKokBwa6GOKBS3zdsPfWKilaVNrXnMkg+YN/iMEB
 EekgabOdKZMyawyNHvDOzqaXs7336DpqN3I3wF09hK3BT7ydCdIO85cvQB+MPOUx/aXn
 h6Xg==
X-Gm-Message-State: AOJu0YxBjrF1cayQ2gzQnDmpbBppB4DYUcLoGrYNXqyWTy9nWA8LyQSQ
 B36bBsrE1KNrDcV+JorYUD52BcJGk+KeZYiajduDpdufOSi4IBHzEOVBfvFHoQLGPEY4/eLX1CM
 X
X-Google-Smtp-Source: AGHT+IHU2nOZBzOJiiwvB4NLtKxJFoQG8yRn3Zk8ihyzp3dcyIZLSsiUYCqCOQ4Gbk30iS91t9p+Ew==
X-Received: by 2002:a2e:a6a6:0:b0:2d0:e730:b7d5 with SMTP id
 q38-20020a2ea6a6000000b002d0e730b7d5mr4714847lje.1.1707825751449; 
 Tue, 13 Feb 2024 04:02:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUTgHRHVSpaiDt7jfmm6dHijKIlCbBc00EwR+Ml31drXthLr324tmsGVqDKspuzIeOLhckqnDgE4QeC9IMSZl0a4DwrcJSzhzf6PU2oiEp52SQ8cHBxZ47ZtDrmpEIscHUaj2E8ZQSNEEDY3cF1gGVk8y+NNx7vUBDlXasXcz5N1XiRz5QectFlfeGP9wnrzc1I3sg0pIWuWI1FpqgwxWJfN+McHEMSLIO1MfWqNncZXWdgs9zMXn0FueDwN/N4Su0I+GDmBBZdLSRwp+vpy//nWHJ5oDaOvHA7zsFMW8vqzJp0j7xoHsTW5U0i18yq3Zo8zBvuzHo=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 o39-20020a05600c512700b00411c3c2fc55sm1308184wms.45.2024.02.13.04.02.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:02:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of
 'pci.h'
Date: Tue, 13 Feb 2024 13:01:51 +0100
Message-ID: <20240213120153.90930-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

cpu_hotplug.c only needs the PCI *device* definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/cpu_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 6f78db0ccb..f7fe905e0a 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "hw/i386/pc.h"
-#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
 #define CPU_EJECT_METHOD "CPEJ"
-- 
2.41.0



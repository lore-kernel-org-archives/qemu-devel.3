Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136EDC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZTD-0006Xv-GH; Fri, 07 Mar 2025 10:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQx-0005ro-R3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZQu-00040z-UT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:16:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bcc04d4fcso12213985e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360565; x=1741965365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNl8UgOnANk9MlIZCbbjo+hTAONQ4gInW5Qx1vX0kuY=;
 b=y/Ht3ErJQIEPadWhmaSMCXE4IzRQelbF+Kgi0AU/e3jwBiCPWXD4y1b9HFqUJ9mq1t
 GJyGIIVUW4+C2eNrYJ4594gW18vrow6xJDKJ1910nmUFybkowLpVUDIRtiCuQPZ4fexX
 zjKeqWmhRn2xUSmwz1gLQnqEaK+/7dvJdAtOlgdyry+eAM9vBoK7Hnwy1GG3KvFfVkzF
 H/6zyDYwfWWfqTK7mvTdkAK17QKB7fK/dXkF02p22HhzaEN58k1hhgy0BeDDL0tk1dVK
 R+NLhR2zaagSHzLylwSsewJdXkXuqiquGETHy8Q90+2AOy7G1eTwTOQW+Axv17xrrR3m
 n74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360565; x=1741965365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNl8UgOnANk9MlIZCbbjo+hTAONQ4gInW5Qx1vX0kuY=;
 b=t46bI1R5HFbXoAgWIHF8ldcxEjPNHd9WvkvCkbgai7Vukhk/WgTI0omkw5xmDQDcbf
 gP0LBtWvp/x53Jo/HIysuFcISi5Vx8BLbrbtNn1gDH7hdUk6l8Crag3mZTa+mS6NKi1d
 0TGsJhuTNYcODJAeoRCONEL7TEFwoXBoHvhg/wwCA3gAh/awpiqC2w/+lQtfJDEkrbrY
 QiQFH39WE9LyZZGfTQKz1BRGoRjHf1JINDkY17CUpuA8VgOntdg4RmjzRdsZRFWaxMR/
 oEZr1Tbys0IyxTLvdEYsp7qDNQhW4jXWDLm2pG43nmpqOhHcFWq7spEP4SIBaGKhE38V
 tV3A==
X-Gm-Message-State: AOJu0YyqWrffYGHERkMm9jEuujAwl6vAAQUmzwe8FxqGtcIG1s8mF0Ax
 w6XtEmI5LTF3UT0sJ0dEIVbGMMeOOjHPkURAzWDmpLb9JE11l3WgCcr0bks+PWbg/ddEzzFmM4W
 5PWA=
X-Gm-Gg: ASbGncsih3F701GptxRkunvjcBxdy1QDzCSrggOlqRfS1aAQ/fhp+DVjl2tS9Da8/gP
 rlfrejexYR4QDghfGYu6Ke8JhEjuYzmbFJWlvSNvY8psZmAUyhMhOYQji4M0hWABRCi8OiBViZB
 upc4BQL5vXaTCz9xmp6c3I3Jdt0/BCzS9pW5HTlJ5N0U+Rr4y0f3KeQ5yQdA2RFs8n1PnnhisxC
 vwbJIyf5nMIhsXkk4QEUSX956dfV42RDGRgbUxvosjHkN+hbcuiXrObm7VvzhGFtmC3Yrr/33/0
 lv7a7dReT3MlrsBzOp6EihiebiecOVVVgqpXRcIXZLauyaMldZqURhAs0+dAlsX/bTgsop8nXPS
 uit1Y4zC9b1qaUNVlY4E=
X-Google-Smtp-Source: AGHT+IHNNMgnVDRwDCiLNtmYODq5h4evUDAvCPa10r6l4Vq5BNgyXNka2sDISKnOd6QFJlRDNO/WMA==
X-Received: by 2002:a05:600c:444c:b0:43b:c7ad:55f0 with SMTP id
 5b1f17b1804b1-43c601cfdf5mr33222165e9.5.1741360565544; 
 Fri, 07 Mar 2025 07:16:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c55f2sm84148105e9.20.2025.03.07.07.16.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 07:16:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
Date: Fri,  7 Mar 2025 16:15:40 +0100
Message-ID: <20250307151543.8156-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307151543.8156-1-philmd@linaro.org>
References: <20250307151543.8156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Rather than checking ACPI availability at compile time by
checking the CONFIG_ACPI definition from CONFIG_DEVICES,
check at runtime via acpi_builtin().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7b140add765..5f57eccbb66 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -28,7 +28,7 @@
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include CONFIG_DEVICES
+#include "hw/acpi/acpi.h"
 #include "trace.h"
 
 static const VMStateDescription vmstate_virtio_mem_device_early;
@@ -883,10 +883,8 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     MachineState *ms = MACHINE(qdev_get_machine());
     VirtIOMEM *vmem = VIRTIO_MEM(vdev);
 
-    if (ms->numa_state) {
-#if defined(CONFIG_ACPI)
+    if (ms->numa_state && acpi_builtin()) {
         virtio_add_feature(&features, VIRTIO_MEM_F_ACPI_PXM);
-#endif
     }
     assert(vmem->unplugged_inaccessible != ON_OFF_AUTO_AUTO);
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
-- 
2.47.1



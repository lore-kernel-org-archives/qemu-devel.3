Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE2BC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMp-0006QV-R1; Fri, 07 Mar 2025 17:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMd-0006HJ-Tx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMc-0003bS-41
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so1585896f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387216; x=1741992016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffnzgiNvC3uFpe+lcYwlOkxah8KhJcrF9JntmJhQznA=;
 b=gAKg4P0CKNf5qcLU4wGiWdZTGpffmk9cWwDWMNdRiBdeTQgi4jBVBKw80UkGcPgbv5
 8b2tQSyUWSIgGvn8Sz7AGmd56eLnIgfLGUa/ts9CYJf3Bc13cUjE0uhpI4BoRpLdjrbc
 wfy/Hvg3KFJopGn8IHTg3P/439yJsuY+SfJSSoQElwv0QQY5sixpX4UX91kl1rnRPH4S
 ezhpwwDyLIBQ1dEZE1Jp/h6AmRFatnK10gTh40d0TYtggxSpD8ZqofIeDN7BTpKdf3FQ
 UNexEVwXOBI0tLYsbMQCGp1dEcW4JBhh7DPjrKXtOyjX9wprddRSWC2kLKVZqL/XLymk
 os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387216; x=1741992016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffnzgiNvC3uFpe+lcYwlOkxah8KhJcrF9JntmJhQznA=;
 b=UYk3FdKoRUJfr7v9EwdwlaoHvMnFY0u/lOPqa0L3UiVM84SHp8KplrkbvRxBkFnhQh
 rbqTjy3K1y/wNSrhYIRFWf6wylpesix8l9IykM+V40Ab7VyrD/NH4ocG30T6qaNXV76R
 uyk03PBIv6YLT4rM3JK85PLHBN//R/X2hHGOaWIFKuTUBHkc312G7TY+0sat5z9KBonF
 VOnc+dXZw8nZlQ/ghAGueR60hs4n5eFnJtGGMY8SlrLuLRWnpaCqxJbGSUsHKuBVTHDc
 co6yiQgviZbgP1Nl6GYNV7ckhiSq8eg1g9g3/V7bSgYycJfgc72HhEpnqQQve7Bp7pSu
 RwjA==
X-Gm-Message-State: AOJu0YwwQRnuIrLyNpD8CaOeKhZ/vK/y/v3gS9RTX+YsjaWh1uDUUKt6
 gXDlq619Ec4iIOLLCZog1Kaq48440zP9L73FpWacESAEm9z0lyeUbH2qK+6M2P9K3uOp4Cn9Gny
 cNB0=
X-Gm-Gg: ASbGnctQdXYTsbiFpSnrmNsqvv71lKo/suRcsnhL2H3Mou3EyRdnSfusUDYjioT69F1
 7j1bQvZDGU9OBN3KYKz/I3eM6YfXaBzRpV8V7BL2Iak1fqh7ckMG/4atj018n7Nk+AKTap0f2VO
 OtVs+psrIpT1E8utZO4MiS8YA4r3mLRZU5qE4OONj8jCIRgO2tGx13W+07MlkxmNLymxd57LK2U
 MM3F0Z9cNtB22Hs5cLXRuvgAE9M7xOCh7P0FyuBUWhDa+5fA3XGrF21er+Wjb+piaAykUGUu05K
 JdSc+XI7VMWMOgh8fS1mK4rRaKvsh3X12ZqSh21Pe5XSVu6zedqaZ8ET/cTrhWYH/CC+sg4swRk
 zeAHx7FpjdqpNiaWLh9A=
X-Google-Smtp-Source: AGHT+IFKebrxsQ6T8+ctJmf1stduSmqw5IRD5+7Tfg/JHYWgbjX3Isp5eM32al4bK3y5K3u8at7/FA==
X-Received: by 2002:a5d:6c65:0:b0:390:e1d2:1dff with SMTP id
 ffacd0b85a97d-39132dcf7f4mr3366037f8f.52.1741387216052; 
 Fri, 07 Mar 2025 14:40:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8de4ffsm65306125e9.24.2025.03.07.14.40.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:40:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT
 to runtime
Date: Fri,  7 Mar 2025 23:39:47 +0100
Message-ID: <20250307223949.54040-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Use qemu_arch_available() to check at runtime if a target
architecture is built in.

Consider the maximum extent size of any architecture built in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 5f57eccbb66..6ff9dab0f66 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "system/arch_init.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/reset.h"
@@ -170,13 +171,24 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
-#elif defined(TARGET_ARM)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-#else
-#error VIRTIO_MEM_USABLE_EXTENT not defined
-#endif
+static uint64_t virtio_mem_usable_extent_size(void)
+{
+    uint64_t size = 0;
+
+    assert(qemu_arch_available(QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_S390X));
+    /*
+     * FIXME: We should use the maximum of instantiated vCPUs ARCH, but
+     *        for now it is easier to take the maximum of any ARCH built in.
+     */
+    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
+        size = MAX(size, 2 * 128 * MiB);
+    }
+    if (qemu_arch_available(QEMU_ARCH_ARM)) {
+        size = MAX(size, 2 * 512 * MiB);
+    }
+
+    return size;
+}
 
 static bool virtio_mem_is_busy(void)
 {
@@ -721,7 +733,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
                                             bool can_shrink)
 {
     uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
-                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
+                           requested_size + virtio_mem_usable_extent_size());
 
     /* The usable region size always has to be multiples of the block size. */
     newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
-- 
2.47.1



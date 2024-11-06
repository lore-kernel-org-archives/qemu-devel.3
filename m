Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD2DD59F62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l30-0008Ns-Cq; Wed, 06 Nov 2024 13:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2u-0008NC-Dj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:25 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2s-0000uc-Ls
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:24 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so307697a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918781; x=1731523581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkT1yg2VZs3DMTFUZrgUQwWp62WZ2rdU+E0+QzLt/pA=;
 b=WeN27aJ9rftVQ7AK8QiaSsU3/vxDQDoNUDm4A+B8uc5/1FdUl1mIwUTThIYFrl+oIj
 0y0ZzH1MfMN7zmTeMm4UQbiyFHnLv3pmzM+IYTUMQSvH2sNFNcMRwn08eqor92zy+X2l
 sPJq5VfdOVf08VHf39tQVx6v9a2uQljnV4rGOVPNBTJdPv3iRwIm+zLpaU1YJvxPWgZR
 dO2GQDaagWBZgy+dvoibzMIOJ2GW5BGSqVq8bMf1jYiw8x/Wp9UrWz5T699eZ7Tb+mpU
 n8zmYfe+Kb/rymvN+aYOG84QqNKCCDFoMB08kn8QQlGh8tvXLSRqXS7Ufk2Dwnd4YlNM
 hZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918781; x=1731523581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkT1yg2VZs3DMTFUZrgUQwWp62WZ2rdU+E0+QzLt/pA=;
 b=eTsG3z8yhdSGXMTqpFiexMfdV1xQ3wDg6qLHAsWeei94BrATGCpXZ0xCLv79QUisHJ
 MBKgJnU+kQsV8aRDteNz/QZfSbrNR6P3m9O2CKsydDmHZmbOrw05isSjZ2ZeTw4QKDci
 jMY+W8TcH4Admqr7jusnlrOCpZG8igbwuzWu/wX5KOT56z9YRGhlIvBOaOBug3tN3zDB
 CAn0VKFgsBUE2QFW6oJ+md++6uC8j1cci2yK03XvLBz+ETycQ6EjlMOiGhXKHiy9mrTe
 GkzKR1J6VhCDB6AEjqTIxfG7JF27qxVw14rqGKrsBqRcp/k41RIqoeBWxJYD9KUjsprj
 y7QA==
X-Gm-Message-State: AOJu0YxCqsJb/al/O95mncml4ut/iSLXzEQjas+JyxdpEoITwlSh8Jg+
 13RdJbzTM0qqPCpO5NUcYR/cAzPeC9mOC6M1tMoR4fSZy45U2gmlK64QLqsFWu3N4Py1qmdF+p6
 M
X-Google-Smtp-Source: AGHT+IFRztwwFzuqDMLCKe1HJL0VyN7UZW2IThAYmIBOBL/vYMjon6/glkSd1siXs1SQu1MAzFb96Q==
X-Received: by 2002:a05:6402:26c8:b0:5ce:e5be:d042 with SMTP id
 4fb4d7f45d1cf-5cefc66ec4amr296655a12.5.1730918780697; 
 Wed, 06 Nov 2024 10:46:20 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6b0fc4dsm3129846a12.84.2024.11.06.10.46.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] hw/i386: Mark devices as little-endian
Date: Wed,  6 Nov 2024 18:46:08 +0000
Message-ID: <20241106184612.71897-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

These devices are only used by the X86 targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/apic.c         | 2 +-
 hw/i386/pc.c               | 4 ++--
 hw/i386/vapic.c            | 2 +-
 hw/i386/xen/xen_apic.c     | 2 +-
 hw/i386/xen/xen_platform.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index a72c28e8a7..3a5d69e8d0 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -214,7 +214,7 @@ static void kvm_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps kvm_apic_io_ops = {
     .read = kvm_apic_mem_read,
     .write = kvm_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void kvm_apic_reset(APICCommonState *s)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 830614d930..2259589e0d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1064,7 +1064,7 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 static const MemoryRegionOps ioport80_io_ops = {
     .write = ioport80_write,
     .read = ioport80_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -1074,7 +1074,7 @@ static const MemoryRegionOps ioport80_io_ops = {
 static const MemoryRegionOps ioportF0_io_ops = {
     .write = ioportF0_write,
     .read = ioportF0_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index ef7f8b967f..fd906fdf78 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -718,7 +718,7 @@ static uint64_t vapic_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps vapic_ops = {
     .write = vapic_write,
     .read = vapic_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void vapic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
index 101e16a766..a94e9005cb 100644
--- a/hw/i386/xen/xen_apic.c
+++ b/hw/i386/xen/xen_apic.c
@@ -36,7 +36,7 @@ static void xen_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xen_apic_io_ops = {
     .read = xen_apic_mem_read,
     .write = xen_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void xen_apic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index ec0e536e85..3b3e745822 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -514,7 +514,7 @@ static void platform_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps platform_mmio_handler = {
     .read = &platform_mmio_read,
     .write = &platform_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void platform_mmio_setup(PCIXenPlatformState *d)
-- 
2.45.2



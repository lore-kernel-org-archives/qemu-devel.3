Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C40CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoTn-0005IZ-KD; Tue, 28 Oct 2025 14:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoSX-0004Sk-MU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:30:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoSK-0003gM-NX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:30:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so1048155e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676198; x=1762280998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HL7ij399tVGkPj9RDTG8sqr6pEwl1ZnFEvIaoIEp9eA=;
 b=SZQlqVPnwwzM/P1jLSUNQMXhMyhLjrYztVVsHIBXyP5Tv4mjXFrcsTM8pbicF5n50J
 8wAC0uNwl8wfr3wwcHKlUDHPgcIB6C5k/bUbyzHe8SpnfNni5okmCCoF225pw5FHs1Ip
 kc2ph8roKx8XyD8RDk9KYrdEQzVK2XbTO/fH7Z/PFkAqeNEin12fvYwqfiO3xNUp7gwr
 VcxCSONvCIPqyIhlWgVEfvWzou3l8aJL+aVD8YMjctG19OqortPrPz0NPXRFp8nnVDi7
 XL3VgHXJRb7/yUGPYl3e8J1fdXuoQoaffTP1pHCwjISW7oh16Rvn9cy2Nq45LsKbOqDf
 CxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676198; x=1762280998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HL7ij399tVGkPj9RDTG8sqr6pEwl1ZnFEvIaoIEp9eA=;
 b=UQNcxN7rvwQhUcUwet0+jzNapfDf1lYR6nN5pGia5HSgs6W9TSzH6sxSg9qKZyDnqN
 bX+UQj0r0v5FtszbEzAG+/QpjAehoUz3wrRLO3Y1C7wh4D058CWADEgVrFZF4BSevuYF
 RPpZK48WMf/vmVwDwpt2lVyrOGT/gaBGBkTr1qcmrK5Vrxt+V5Z0cAPZH6vf60P08lqE
 ufiDli7EQQUw9YoFqnkkCVRMMUsr7XlelUkeGsiND1Hrn2bnVuJ2I3h0vJVsuEcdcEp8
 4oH0Gp6rGDJvi48yiObwd94fDU1l091DCsKbaQwx7G0JzxSvX8ADX1nUi5SO4qcIe4VM
 M8AA==
X-Gm-Message-State: AOJu0Yzh5yP5BlFg8AgXVgtBHoBAN/30HmZYIxYX0Ar1xnWKUt+QV8tQ
 uTpip89j2m5f5ykkIQ1C26j6N22jGOmhQZZl2Se4/kdbP7sH4QPa2oo6p/8VyHv3s4P+NQ7QwSs
 9JI1aihE=
X-Gm-Gg: ASbGncuG+3s1ZgBZ/sE8/Bv4Evv1ZCEz+d7JWXSecwGg5yefHjGsrYH5ChCgvBc14Fd
 /P0NSHCynI0rqf9q/Cj8GVpBPSddY4taCJ5QCAB6l9S2CmJZvXhwgUEUe7QBAtukd/O5HzAgFeq
 VPOFb4/dndfgkTEX2WXnC6pDTHELTFY3VELOk5DO4ifHhNQDVWuBqMFpDtNvq2Z6k3rTes9NO97
 k0+RApjOcttEOv9rMZL4ElMPgrhWqXkmESWssu4nfu2IeVYURE5CbiXmDsM41DvQ7NUxCPMmA85
 BWCOEWUacWXPv1Ybh5HddNJMWMMiaWB+yPB9T8P9oyu3HQa7CPUq1XZzkPpo+7aeeGm/2ILbSm+
 0IFqP5xCJyAGBn5dYoRWeM14lRaMjYD80FiN5lSsLvZrj060vdJUAwna7oque79uDb5DDLK9QNb
 mN85w+hJ4FhaQRJ4Hv2YupV184LpO/QDmHGY20RlQHCPvubImumQ==
X-Google-Smtp-Source: AGHT+IG97QAQdAzX9j2A8+XMHl21id0uAywezIfpohf6gPFZ5+SmTTd/0RziLpMJdteJH8UW8U3PBQ==
X-Received: by 2002:a05:600c:8518:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-4771e5ec5b3mr2070435e9.7.1761676197953; 
 Tue, 28 Oct 2025 11:29:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e20205esm5286525e9.12.2025.10.28.11.29.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:29:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 14/25] hw/fdt: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:48 +0100
Message-ID: <20251028181300.41475-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/microvm-dt.c          | 4 ++--
 hw/loongarch/virt-fdt-build.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index d7f49bc1b5f..5b64f5b7f30 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -72,7 +72,7 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
     }
 
     MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
-    hwaddr base = mr->addr;
+    hwaddr base = memory_region_get_address(mr);
     hwaddr size = 512;
     unsigned index = (base - VIRTIO_MMIO_BASE) / size;
     uint32_t irq = mms->virtio_irq_base + index;
@@ -152,7 +152,7 @@ static void dt_add_pcie(MicrovmMachineState *mms)
 static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
 {
     MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
-    hwaddr base = mr->addr;
+    hwaddr base = memory_region_get_address(mr);
     char *nodename;
     uint32_t ph;
     int index;
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 1f0ba01f711..54524e5aca9 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -195,11 +195,11 @@ static void fdt_add_flash_node(LoongArchVirtMachineState *lvms)
     hwaddr flash1_size;
 
     flash_mem = pflash_cfi01_get_memory(lvms->flash[0]);
-    flash0_base = flash_mem->addr;
+    flash0_base = memory_region_get_address(flash_mem);
     flash0_size = memory_region_size(flash_mem);
 
     flash_mem = pflash_cfi01_get_memory(lvms->flash[1]);
-    flash1_base = flash_mem->addr;
+    flash1_base = memory_region_get_address(flash_mem);
     flash1_size = memory_region_size(flash_mem);
 
     nodename = g_strdup_printf("/flash@%" PRIx64, flash0_base);
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Zs-0005GP-PE; Thu, 08 May 2025 09:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Zp-00053j-Ll
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:46:17 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Zm-0005Iy-VS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:46:17 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so631098a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711972; x=1747316772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAEnpROpQK6DxM6uJJQ1bpWzbrmSzQalAkAVB3r0tgU=;
 b=KdqjNB3v2TPCkIeePrVgdcO+TaS/pmxH4S/VN+EWl6FW+iwYPIeTS/9DbO0I1cMNuT
 83WSZGtNDnAOGnGhgqCQQV26qbQA+M7cYtj9rSjEjnE/tgMbJbg+YSipsXdLABzbR+3V
 Cu14WErV7D4G2B4GzSrYrAHH21CDgOu4zbQf21ZGMhb7L+m1rLAYjfLbSz1sHY3e0vxj
 9ZQmYW/rwBo0VaatHNupxDyahJM9nc8hVUhgnAref1Xz5iEvqyuqviuTbpxjkcDi6GBx
 9filnkk70SP8l0Vvyz6gZ1DzbSl8jiX+aENC6uM7NcDA3EXgimTaRSsExWEOtxuFb/ic
 jSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711972; x=1747316772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAEnpROpQK6DxM6uJJQ1bpWzbrmSzQalAkAVB3r0tgU=;
 b=GtViSBTRLmy0V2P+nUJ+U/+Wsx0dC2i+hA1KxOtJvEx7zO1os+yMqjpUHmqyzUcSRY
 rusKooxXAVEy9Pqgs/F7nnLmDcWLQkiL8CzC6MoGY+/OYGZWudpl10DYo7DtLjP21Ji3
 /k32MEgl164C7KGT7bXNSRIA1M4hhMdcVKo0wgvvYkAIIo1HzQjyTN4E3Y41MIsTH67o
 eTUe7770lT8tQxx7TZMn7ywNJ+B5UbZma4QuhY7UN6VIsSW40wwexZOxBvGxB6EEICnY
 y9rqBaG8/OJ6MuE1giJn9vFoXN3oI00WGwHim0C8tJ4WW6OV+7UR1m+fhcCODhtpNDgQ
 ZwHA==
X-Gm-Message-State: AOJu0YyWyzWTpxcOtHrlRQVhxior4iueSF9s2ApjfYvZxHBU/du6NtXO
 zClqs/Olqzej8n7MY0sY02SFUzcjjhtz0af4EbQR/xviffcRzQKexs1WQWEi+ZQJYMonOUNHIfW
 5LV3UVw==
X-Gm-Gg: ASbGncvDyF2ivaHQGoYBcs9bQV1eEErK4MH5r/b0knod2DXQV0oPcY/ECxNK9PxpFpY
 vvrTDH7o3VKarS6Ew1iKoQwLaGYYOKA4C/m3EV3k8ik0uIGgh3HSNoZul7KwPUttyMAEh3JPTV3
 ORZJqmPUan/iEHybBftFITelY5rMrGUP2mGIGOHp5yuIwKM9fI9BRdfo2gb5U+CrkLLUGSW+M5s
 xAAkB3n2asnRWvh90Uj0a1OyRk+xeDiSdf+QmG6wwIcwOy5KicLCCOEVMacxSjz89rDRKTxbpRi
 XiPKD8XPqYzlnRquDLHfEeU28A3Agpy1r4p++DEWuLEGx37a8lYRiDh90o+PZKErTjV6Q5HUlvW
 1OpZxmn6mWLzVZw0=
X-Google-Smtp-Source: AGHT+IG9WzoCZnHzGx/rhe5MQGTbfwj2jk9eAlMQ107yUfErvTrwEaQ0R1H/OfqPr8whvcSNPiejCQ==
X-Received: by 2002:a05:6a20:9f8f:b0:1f5:5ca4:2744 with SMTP id
 adf61e73a8af0-2148ba256e3mr9499152637.17.1746711972638; 
 Thu, 08 May 2025 06:46:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a397sm13221110b3a.28.2025.05.08.06.45.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:46:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 27/27] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
Date: Thu,  8 May 2025 15:35:50 +0200
Message-ID: <20250508133550.81391-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x534.google.com
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

VIRTIO_PCI_FLAG_PAGE_PER_VQ was only used by the hw_compat_2_7[]
array, via the 'page-per-vq=on' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_PAGE_PER_VQ (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/virtio/virtio-pci.h |  1 -
 hw/display/virtio-vga.c        | 10 ----------
 hw/virtio/virtio-pci.c         |  7 +------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9838e8650a6..8abc5f8f20d 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -33,7 +33,6 @@ enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
-    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 40e60f70fcd..83d01f089b5 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -141,16 +141,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                                VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
     }
 
-    if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
-        /*
-         * with page-per-vq=off there is no padding space we can use
-         * for the stdvga registers.  Make the common and isr regions
-         * smaller then.
-         */
-        vpci_dev->common.size /= 2;
-        vpci_dev->isr.size /= 2;
-    }
-
     offset = memory_region_size(&vpci_dev->modern_bar);
     offset -= vpci_dev->notify.size;
     vpci_dev->notify.offset = offset;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7c965771907..4e0d4bda6ed 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -314,12 +314,9 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
     return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
 }
 
-#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
-
 static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
 {
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+    return 4;
 }
 
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
@@ -2348,8 +2345,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1



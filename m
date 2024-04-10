Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F913CD129A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1d-0005lv-SE; Wed, 10 Apr 2024 05:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1P-0005it-Pm
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1N-0005Xs-9L
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:13:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56fd7df9ea9so345059a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740411; x=1713345211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl65Et5THn+WU6N1r23t/my2YFDQcyKHCHoGccvL7sA=;
 b=j/1+OhJ9StncvIxlCAeOeBhp2QrZcDLZXQock1V680UUeo7FVSiIzrrAiwuvajowta
 tyLKGNoCsRk0CTBZNx9OUmrRW0x+dW2qtBWu7wDac3dOklxdjvi/69mt0ybqU02Vf9R8
 DuZWcOBbv+75PrYlrDyrLdXu78avdzW1oL+fS7e+BCqEV2bLDuPCjwb+ltHMVLJaU0Ar
 alECkI6vTNpd1xe2O7SJs1jwrB545OSrt/Ajqan5hrKdbOjyLpnDyUvDmUAocLrfNTDv
 lMQAPb7PyiVzT7vjzCTROxqYOSjcCNHVEsMlK1HAKCfXgTWuiGEZHtSXXSAogNqwqRzX
 JdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740411; x=1713345211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl65Et5THn+WU6N1r23t/my2YFDQcyKHCHoGccvL7sA=;
 b=ktKheo2m10XibNJJaBZRh54ATJ5dSXciL2eYswFEMQTo8s0GxrEeBbf7pHdYqfd57U
 JHL+b+z9yAMFKQ5q4xnDQagL2QIji+hy43o9ZtDmpwLNy0mzqT23qTdJs8zVLjGv6LEL
 IfQNCLEAy2eF2CHTG8Zpn0FUhVRiKK4bdby/T04mFf1gLQqs+JqhfzpNa+Hn3N/2WQhg
 RmCaOCpKJOxgd7FOjmJi7qo86aKggq/5G4PS+q1eTqs1ifk+LJrOaKDFBtSty0G1UcG7
 blrYfjiMqP0F7TVncqrhHkuP3MbFcnH3+AoEm7iYaWspGUQegCky9ZjK1ndy81jO77OS
 pA6Q==
X-Gm-Message-State: AOJu0YwG17FqlSd/jNFJZaFSqyFTZq5M8kLRwMe0kMjayr6tFYgrPxpq
 PoAyMoQxXhv7RiYr768drUvyF7oz6obdUaD48N6Ov6tJFIJsFrcNpPFb12/pKDIz5vgmuqF4dYC
 f
X-Google-Smtp-Source: AGHT+IEDqrcJAetXuhtfMpyrEEqesHYPWmkDUXvkVwexeHd8wq4AVh0UHN3KJkS0Ap2FQdJUVdAzPg==
X-Received: by 2002:a50:a686:0:b0:56b:f5ae:ae58 with SMTP id
 e6-20020a50a686000000b0056bf5aeae58mr1251069edc.29.1712740411313; 
 Wed, 10 Apr 2024 02:13:31 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 eh15-20020a0564020f8f00b0056e67f9f4c3sm2743207edb.72.2024.04.10.02.13.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:13:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Yongkang Jia <kangel@zju.edu.cn>, Xiao Lei <nop.leixiao@gmail.com>,
 Yiming Tao <taoym@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 02/16] hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
Date: Wed, 10 Apr 2024 11:13:01 +0200
Message-ID: <20240410091315.57241-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed:

  $ cat << EOF | qemu-system-i386 -display none -nodefaults \
                                  -machine q35,accel=qtest \
                                  -m 512M \
                                  -device virtio-gpu \
                                  -qtest stdio
  outl 0xcf8 0x80000820
  outl 0xcfc 0xe0004000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  write 0xe0004030 0x4 0x024000e0
  write 0xe0004028 0x1 0xff
  write 0xe0004020 0x4 0x00009300
  write 0xe000401c 0x1 0x01
  write 0x101 0x1 0x04
  write 0x103 0x1 0x1c
  write 0x9301c8 0x1 0x18
  write 0x105 0x1 0x1c
  write 0x107 0x1 0x1c
  write 0x109 0x1 0x1c
  write 0x10b 0x1 0x00
  write 0x10d 0x1 0x00
  write 0x10f 0x1 0x00
  write 0x111 0x1 0x00
  write 0x113 0x1 0x00
  write 0x115 0x1 0x00
  write 0x117 0x1 0x00
  write 0x119 0x1 0x00
  write 0x11b 0x1 0x00
  write 0x11d 0x1 0x00
  write 0x11f 0x1 0x00
  write 0x121 0x1 0x00
  write 0x123 0x1 0x00
  write 0x125 0x1 0x00
  write 0x127 0x1 0x00
  write 0x129 0x1 0x00
  write 0x12b 0x1 0x00
  write 0x12d 0x1 0x00
  write 0x12f 0x1 0x00
  write 0x131 0x1 0x00
  write 0x133 0x1 0x00
  write 0x135 0x1 0x00
  write 0x137 0x1 0x00
  write 0x139 0x1 0x00
  write 0xe0007003 0x1 0x00
  EOF
  ...
  =================================================================
  ==276099==ERROR: AddressSanitizer: heap-use-after-free on address 0x60d000011178
  at pc 0x562cc3b736c7 bp 0x7ffed49dee60 sp 0x7ffed49dee58
  READ of size 8 at 0x60d000011178 thread T0
      #0 0x562cc3b736c6 in virtio_gpu_ctrl_response hw/display/virtio-gpu.c:180:42
      #1 0x562cc3b7c40b in virtio_gpu_ctrl_response_nodata hw/display/virtio-gpu.c:192:5
      #2 0x562cc3b7c40b in virtio_gpu_simple_process_cmd hw/display/virtio-gpu.c:1015:13
      #3 0x562cc3b82873 in virtio_gpu_process_cmdq hw/display/virtio-gpu.c:1050:9
      #4 0x562cc4a85514 in aio_bh_call util/async.c:169:5
      #5 0x562cc4a85c52 in aio_bh_poll util/async.c:216:13
      #6 0x562cc4a1a79b in aio_dispatch util/aio-posix.c:423:5
      #7 0x562cc4a8a2da in aio_ctx_dispatch util/async.c:358:5
      #8 0x7f36840547a8 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x547a8)
      #9 0x562cc4a8b753 in glib_pollfds_poll util/main-loop.c:290:9
      #10 0x562cc4a8b753 in os_host_main_loop_wait util/main-loop.c:313:5
      #11 0x562cc4a8b753 in main_loop_wait util/main-loop.c:592:11
      #12 0x562cc3938186 in qemu_main_loop system/runstate.c:782:9
      #13 0x562cc43b7af5 in qemu_default_main system/main.c:37:14
      #14 0x7f3683a6c189 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
      #15 0x7f3683a6c244 in __libc_start_main csu/../csu/libc-start.c:381:3
      #16 0x562cc2a58ac0 in _start (qemu-system-i386+0x231bac0)

  0x60d000011178 is located 56 bytes inside of 136-byte region [0x60d000011140,0x60d0000111c8)
  freed by thread T0 here:
      #0 0x562cc2adb662 in __interceptor_free (qemu-system-i386+0x239e662)
      #1 0x562cc3b86b21 in virtio_gpu_reset hw/display/virtio-gpu.c:1524:9
      #2 0x562cc416e20e in virtio_reset hw/virtio/virtio.c:2145:9
      #3 0x562cc37c5644 in virtio_pci_reset hw/virtio/virtio-pci.c:2249:5
      #4 0x562cc4233758 in memory_region_write_accessor system/memory.c:497:5
      #5 0x562cc4232eea in access_with_adjusted_size system/memory.c:573:18

  previously allocated by thread T0 here:
      #0 0x562cc2adb90e in malloc (qemu-system-i386+0x239e90e)
      #1 0x7f368405a678 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5a678)
      #2 0x562cc4163ffc in virtqueue_split_pop hw/virtio/virtio.c:1612:12
      #3 0x562cc4163ffc in virtqueue_pop hw/virtio/virtio.c:1783:16
      #4 0x562cc3b91a95 in virtio_gpu_handle_ctrl hw/display/virtio-gpu.c:1112:15
      #5 0x562cc4a85514 in aio_bh_call util/async.c:169:5
      #6 0x562cc4a85c52 in aio_bh_poll util/async.c:216:13
      #7 0x562cc4a1a79b in aio_dispatch util/aio-posix.c:423:5

  SUMMARY: AddressSanitizer: heap-use-after-free hw/display/virtio-gpu.c:180:42 in virtio_gpu_ctrl_response

With this change, the same reproducer triggers:

  qemu-system-i386: warning: Blocked re-entrant IO on MemoryRegion: virtio-pci-common-virtio-gpu at addr: 0x6

Fixes: CVE-2024-3446
Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Reported-by: Yongkang Jia <kangel@zju.edu.cn>
Reported-by: Xiao Lei <nop.leixiao@gmail.com>
Reported-by: Yiming Tao <taoym@zju.edu.cn>
Buglink: https://bugs.launchpad.net/qemu/+bug/1888606
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240409105537.18308-3-philmd@linaro.org>
---
 hw/display/virtio-gpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 78d5a4f164..ae831b6b3e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1492,10 +1492,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     g->ctrl_vq = virtio_get_queue(vdev, 0);
     g->cursor_vq = virtio_get_queue(vdev, 1);
-    g->ctrl_bh = qemu_bh_new_guarded(virtio_gpu_ctrl_bh, g,
-                                     &qdev->mem_reentrancy_guard);
-    g->cursor_bh = qemu_bh_new_guarded(virtio_gpu_cursor_bh, g,
-                                       &qdev->mem_reentrancy_guard);
+    g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
+    g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
     g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
     qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
-- 
2.41.0



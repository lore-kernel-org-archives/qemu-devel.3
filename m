Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B83F4180D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcz7-0004AN-0u; Mon, 09 Mar 2026 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcy4-0002kr-Ou
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxx-0000k7-G4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso4105495e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071778; x=1773676578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IYwq/x5k8YzSo5nefHb2YOgR15RYyHxfIiTIwO06Ijw=;
 b=rkkyZkuhRPsS7UNbX1WJNeHURgdjDt9+kADXwixPY907TZUihNtLm790KZd8D2WJtw
 lCj1KSINZ89x5i948kXREIh4MK5G31MSCqUetMUHhnZmXMR+hfNEWgW7JwtoLRITZdOt
 /75+u0TIu/TobR/wP4L5oVZ6w4vXE/kD8g1EYrEiY/Ac/WfYlQQh5LwEb+aTd6A6mfkD
 J/NDm5LxInaSzoLnX15RWjxc04PXiAPVFZ/kQMdYVGjKn6RIDRxFeX9XZosv1+PBOJgJ
 Skdn13wxqgZSfwOrrMBLyUvPkjAKSmPHn6s5IFbAguYBYgYv/b7G+GF2lg8Kb9+ET46X
 Y2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071778; x=1773676578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IYwq/x5k8YzSo5nefHb2YOgR15RYyHxfIiTIwO06Ijw=;
 b=RnFXSo9Jyth+2YYf7yZJ3pIMGWsUFB/hDQgET+iAJtazaBhZW0g3OZLH4o46LL3H7d
 AZ8CJBNF450SrWiYwWb/pu6bWzhd/3kwhx4upLXxiPhWyTbuFun8Xs7tBpNLW4LuKEIR
 nKO3OtjUGmPodACFPRXtBS/wZZH63l9M6vOlSl1DaHVMxR1CrvktBf/fEqLFnAu2smhT
 XyKpJM+qWW+fEFCicosSahr+8V9Ho9mu2P72Eh3vSW9ig3ZTklpYDbqykKAo4at7XJD5
 +6f3NFqFGCXWrDQG85lXscVm11+BOOozTfOjZb8efiklGpasyH+9v4LtC0hWKnocDsdF
 nKtg==
X-Gm-Message-State: AOJu0YyDVl+qnX2Yf6l1cnXpZzlD5+Ct90LKGJ+TgSOcn0UIciysk5a1
 rPGcD47RBkQKNOQLNIN/i+s9tKhRqqooqhnwaNsrMkuoCMbUFBjG0wykABTrBD6mxQQMmF6ydxg
 hTZJvjBc=
X-Gm-Gg: ATEYQzwuSV962wHDXLUQREJjlncrxgOc0IHjtkA2zgVNWoIsMYRvGpcFxdiZxsr7OE4
 nJy8rRvsGmVMD/cSgvmWY1FPZcFdczTlEk9b410XG7/bibh9DnzTOxyuLB2IPz3ah8AHII0y2HC
 eLHGWpiDN7E16tkZl3zVLyCNK+bd3SKcJCq21D1V6x1LltWNXdLRE17Z4Ivmq3+fwbkBNjCu7dW
 Dh5/8XxABNeeXSFuD5rVqGzqaen4VqyOxaKVl4smFqfwKAu0qeyvidZqCrqnPSEylIduU52/U6i
 7vIVOqEuHTNsTBmaB4GIgu/O3y2n+/nQsRhCOSwl04f/vNDw4wZbAABsA4VRi4kWIx52uJDaikd
 /40gDk5qJJ8WNseTBwj6Vp5cv2orqezNbN67TllHNZmZFTUr+R166vHd0pZLmGcaW5gOPynqPsp
 hGlAncBhwJ86UXPTxSmQIY3b5n8kbI608rK01hK8IXq6iwn3fpxTwsDGa3N5A35gFzgPikmBB1
X-Received: by 2002:a05:600c:c8f:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-4852695b63emr201283305e9.19.1773071777730; 
 Mon, 09 Mar 2026 08:56:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853927825csm39166875e9.9.2026.03.09.08.56.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/49] hw: Make qdev_get_printable_name() consistently return
 freeable string
Date: Mon,  9 Mar 2026 16:52:05 +0100
Message-ID: <20260309155219.62400-36-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The current implementation of qdev_get_printable_name() sometimes
returns a string that must not be freed (vdev->id or the fixed
fallback string "<unknown device>" and sometimes returns a string
that must be freed (the return value of qdev_get_dev_path()). This
forces callers to leak the string in the "must be freed" case.

Make the function consistent that it always returns a string that
the caller must free, and make the three callsites free it.

This fixes leaks like this that show up when running "make check"
with the address sanitizer enabled:

Direct leak of 13 byte(s) in 1 object(s) allocated from:
    #0 0x5561de21f293 in malloc (/home/pm215/qemu/build/san/qemu-system-i386+0x1a2d293) (BuildId: 6d6fad7130fd5c8dbbc03401df554f68b8034936)
    #1 0x767ad7a82ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5561deaf34f2 in pcibus_get_dev_path /home/pm215/qemu/build/san/../../hw/pci/pci.c:2792:12
    #3 0x5561df9d8830 in qdev_get_printable_name /home/pm215/qemu/build/san/../../hw/core/qdev.c:431:24
    #4 0x5561deebdca2 in virtio_init_region_cache /home/pm215/qemu/build/san/../../hw/virtio/virtio.c:298:17
    #5 0x5561df05f842 in memory_region_write_accessor /home/pm215/qemu/build/san/../../system/memory.c:491:5
    #6 0x5561df05ed1b in access_with_adjusted_size /home/pm215/qemu/build/san/../../system/memory.c:567:18
    #7 0x5561df05e3fa in memory_region_dispatch_write /home/pm215/qemu/build/san/../../system/memory.c
    #8 0x5561df0aa805 in address_space_stm_internal /home/pm215/qemu/build/san/../../system/memory_ldst.c.inc:85:13
    #9 0x5561df0bcad3 in qtest_process_command /home/pm215/qemu/build/san/../../system/qtest.c:480:13

Cc: qemu-stable@nongnu.org
Fixes: e209d4d7a31b9 ("virtio: improve virtqueue mapping error messages")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260307155046.3940197-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/qdev.h | 16 ++++++++++++++++
 hw/core/qdev.c         |  4 ++--
 hw/virtio/virtio.c     | 12 +++++++++---
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 29083bc9078..f99a8979ccb 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1084,6 +1084,22 @@ extern bool qdev_hot_removed;
  * If @dev is NULL or not on a bus, returns NULL.
  */
 char *qdev_get_dev_path(DeviceState *dev);
+
+/**
+ * qdev_get_printable_name: Return human readable name for device
+ * @dev: Device to get name of
+ *
+ * Returns: A newly allocated string containing some human
+ * readable name for the device, suitable for printing in
+ * user-facing error messages. The function will never return NULL,
+ * so the name can be used without further checking or fallbacks.
+ *
+ * If the device has an explicitly set ID (e.g. by the user on the
+ * command line via "-device thisdev,id=myid") this is preferred.
+ * Otherwise we try the canonical QOM device path (which will be
+ * the PCI ID for PCI devices, for example). If all else fails
+ * we will return the placeholder "<unknown device">.
+ */
 const char *qdev_get_printable_name(DeviceState *dev);
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index fc3425a8fe1..e48616b2c6f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -420,7 +420,7 @@ const char *qdev_get_printable_name(DeviceState *vdev)
      * names.
      */
     if (vdev->id) {
-        return vdev->id;
+        return g_strdup(vdev->id);
     }
     /*
      * Fall back to the canonical QOM device path (eg. ID for PCI
@@ -437,7 +437,7 @@ const char *qdev_get_printable_name(DeviceState *vdev)
      * Final fallback: if all else fails, return a placeholder string.
      * This ensures the error message always contains a valid string.
      */
-    return "<unknown device>";
+    return g_strdup("<unknown device>");
 }
 
 void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4c5a4479bfa..0ba734d0bc6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -281,10 +281,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->desc, vdev->dma_as,
                                    addr, size, packed);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map descriptor ring for device %s: "
                 "invalid guest physical address or corrupted queue setup",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_desc;
     }
 
@@ -292,10 +294,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map used ring for device %s: "
                 "possible guest misconfiguration or insufficient memory",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_used;
     }
 
@@ -303,10 +307,12 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
     len = address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
+        g_autofree const char *devname = qdev_get_printable_name(DEVICE(vdev));
+
         virtio_error(vdev,
                 "Failed to map avalaible ring for device %s: "
                 "possible queue misconfiguration or overlapping memory region",
-                qdev_get_printable_name(DEVICE(vdev)));
+                devname);
         goto err_avail;
     }
 
-- 
2.53.0



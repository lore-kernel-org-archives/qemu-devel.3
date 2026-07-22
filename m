Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7BAC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVRd-000834-7a; Wed, 22 Jul 2026 07:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1wmVRb-00082q-6o
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:48:59 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1wmVRZ-0001yr-A6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:48:58 -0400
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c9452243cso86063481fa.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720935; x=1785325735;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r929VDd0OBeudSXQq231uucGybkSbgKjIMa8H49y/uA=;
 b=BkKfshdDlBiEr0ayKwOJTPs4e3oI10hoE+UlAN+RK5pn+NRpW+69lZ46pM4kuxJIzG
 lJjO86mrev7xeFvaQ7QqzhuoB07eYhHnAkPjQnvU9591sLPGYCXZsj94rZBWYveCcmUs
 g9stKR4DYngB/eTi9fWynbrK/FTGaRImhgeXOwEABR7ZAfH7wc/eE16x6MlvUmt+Uby7
 kViX/nERAM9IeDNR7QBwaN7LHqWM3TXDsI7BaCA8yOBCskpNX88IzEA3bt1m+qcf4+dL
 kuDCkMg0BuS/5spfIB238OI8ZUBLarwAXBH0IOUoBHkCbksv03yAY6IjtxdZHrKiDzLO
 P/Bw==
X-Gm-Message-State: AOJu0YzNTxukyryUYgJf4aHQY/n1tOyYWeVJE6SdLzH93EAL0hIQnv6T
 N8Tb0GWBhGMJJvOeUQmtpJNb7ek1RW1JC/4J162IFroFfnBuQMe5rFeiKdriWA==
X-Gm-Gg: AR+sD12t8fkYLDLAZFYyv1Xkb8xPHSPdpA3GT4rrvZxjgAZUNXYNOWpsPUHQX21mOWy
 cP6aEPyXke8uzB+ipQZVsZKZLGuPrJrMk70lIQFANFyGICyewA7kmD175zfOBKyO8vJstJ0UBoq
 29qK/8pzdQwSq34ElzTMZ0WzqPvUlkeXmoVm0M48v5mM+GSFU+KIP2IQl6DQSQAv9f3/LKnn0WS
 yjhXYT3wUc0FBV0T4kHm1ALeBJCkqW9yn1AAfDohcjsPGj/NR+UxSzOssP8YTLqO5nt6RbxJ8l1
 buX4Rs35wEw4kXVLoP2hYxW8N/D9X9zJuAzYptzAuPnlv7iTpQGo8MqRW7zxqDiWmKhrPEpltwP
 UFqB4ztotru8KVyf123ii5IGPZkYlUVu+7q8FmfUEaAbZDvX/+xGJtb+zCsT/O6NmJSRem/rMJV
 ccrmXztIpPbrbxqoPshtOJ/Mf2aI2E/ov6yEKDwDLx+ta875RhLiUt
X-Received: by 2002:a05:6512:39d4:b0:5b2:9a03:aa4d with SMTP id
 2adb3069b0e04-5b29a03aae0mr3508994e87.61.1784720934702; 
 Wed, 22 Jul 2026 04:48:54 -0700 (PDT)
Received: from [127.0.0.1] (ne8sisj88p8b9b0pu97-1.v6.elisa-laajakaista.fi.
 [2001:99a:d2f:d700:ac46:c65b:a307:c16b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9e4e965sm434280e87.71.2026.07.22.04.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:48:54 -0700 (PDT)
From: =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>
Date: Wed, 22 Jul 2026 14:48:47 +0300
Subject: [PATCH v2] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260722-usbhost-disconnect-v2-1-41f3d55b49f0@iki.fi>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQrCMBBFr1JmbaSJBI0r71G6SKcTMwiJZGJRS
 u9u7AFcvgf//RWECpPAtVuh0MLCOTUwhw4w+nQnxXNjML2xvdNGvWSKWaqaWTCnRFiVdobQ+0v
 AE0EbPgsFfu/RYWwcWWoun/1j0T/7N7dopZXDM9rg3WR7f+MHHwPDuG3bFwvSJgWxAAAA
X-Change-ID: 20250912-usbhost-disconnect-192ecaa8fc3e
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3786; i=timo.teras@iki.fi;
 h=from:subject:message-id; bh=zZ6djbiCSh9pExh6fOgbpTsIYcX6z7Yah+313GOEhzE=;
 b=owEBbAKT/ZANAwAKATOwYkvkZxGyAcsmYgBqYK4kvXuD8PnYS/Kbii2YXEWpTy7+j/72vC1qY
 pQK/IpVf1KJAjIEAAEKAB0WIQQp0ZrTIQvWyEgu8pwzsGJL5GcRsgUCamCuJAAKCRAzsGJL5GcR
 sn1pD/jPMCrT6+D5gziHLFw8TZucX3pY8AxMeFt3lhWaYfESJ2aP3pWqEU8LXGpEa4nWc3K72HD
 lWKtsvSU2567BDf9SnrauzkDjmDdAVBuTkESujeXRXKBRfX7is6H9U1dcEVVQHY4Vb7/KfA64Wa
 Pm1bBB2irwfJNIws2r1UyM6+B7vgbne7lPtTc/U+N/qqtZxtQdbOaGkBUxxetFqv34oMdrcuHkS
 XytPiHMpcoKz9yKBPtiOIJA+XsyN2LhX1pI0P4IVL8jUSSDilKFi9f20XTk8Iq4jMMogdbZg2XY
 5uThYQDj42Mzh3QoVeGwelp8nL+YJSizbYd/0on/BPiJX6os+xOVWSuJsb8T51RcXKYOU7+ORAl
 dRs3P0hLvWWnXwmlv8gwQ+wIB5UyffjXIWNYkjzWkmRVnBhaRhNLh9qb2tqGGcXO+SB5cV1iZJ3
 /Jjni6+p4gWM1h7PySebAOLALjAbIOZUYPueDJCWGGAnEj1yWm/5DzgZOx5+TvdFLhwRngcpwKv
 udVQHaRlIzq6wJyZKOIbBrDr8foRGmBP4JRisy332hzx54sVMGa8J16HBf7cCj7egyRAgwL3Ofl
 MGCIRa0GaW/U5Q/FcbVC+Hr/Gvju/tEFtmADYlJ4YsBzCAHi7H+hhqcxVG3+bC1aek7tQZs3sbZ
 UrqQXLXZSHX/m
X-Developer-Key: i=timo.teras@iki.fi; a=openpgp;
 fpr=D1744A523C66D469706CC05546700E8C628FA1CE
Received-SPF: pass client-ip=209.85.208.173; envelope-from=timo.teras@gmail.com;
 helo=mail-lj1-f173.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is partial revert of commit e058fa2dd599.

Add back and enable the autoscan functionality for bus+addr
selectors. This fixes a regression that USB device removal
was not propagated to the guest in all scenarios.

The exact behaviour likely depends on the host libusb
configuration and how the guest is using the USB device
(whether or not there is active URBs). The regression likely
concerns devices to which there is no active URBs all the time,
but the disconnection event is monitored: e.g. mass storage
devices to which URBs happen only during IO, but removal should
be seen even if there is no IO activity.

Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Timo Teräs <timo.teras@iki.fi>
---
Changes in v2:
- Contrary the the in-between mail, this probably does not affect
  hotplug insertion: the hostaddr/device file would not stay the same.
  Thinking further, the regression likely depends on the usage pattern
  and whether the device is actively accessed or not.
- Updated commit message accordingly, no code changes
- Added Acked-by: Gerd Hoffmann <kraxel@redhat.com>
- Link to v1: https://lore.kernel.org/qemu-devel/20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi

To: qemu-devel@nongnu.org
---
 hw/usb/host-libusb.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b74670ae25..f0baf6b2f2 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -90,7 +90,6 @@ struct USBHostDevice {
     uint32_t                         iso_urb_frames;
     uint32_t                         options;
     uint32_t                         loglevel;
-    bool                             needs_autoscan;
     bool                             allow_one_guest_reset;
     bool                             allow_all_guest_resets;
     bool                             suppress_remote_wake;
@@ -1211,7 +1210,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
 #if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
     if (s->hostdevice) {
         int fd;
-        s->needs_autoscan = false;
         fd = qemu_open(s->hostdevice, O_RDWR, errp);
         if (fd < 0) {
             return;
@@ -1227,7 +1225,6 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
         !s->match.vendor_id &&
         !s->match.product_id &&
         !s->match.port) {
-        s->needs_autoscan = false;
         ldev = usb_host_find_ref(s->match.bus_num,
                                  s->match.addr);
         if (!ldev) {
@@ -1242,14 +1239,13 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
                        s->match.bus_num, s->match.addr);
             return;
         }
-    } else {
-        s->needs_autoscan = true;
-        QTAILQ_INSERT_TAIL(&hostdevs, s, next);
-        usb_host_auto_check(NULL);
     }
 
     s->exit.notify = usb_host_exit_notifier;
     qemu_add_exit_notifier(&s->exit);
+
+    QTAILQ_INSERT_TAIL(&hostdevs, s, next);
+    usb_host_auto_check(NULL);
 }
 
 static void usb_host_instance_init(Object *obj)
@@ -1267,9 +1263,7 @@ static void usb_host_unrealize(USBDevice *udev)
     USBHostDevice *s = USB_HOST_DEVICE(udev);
 
     qemu_remove_exit_notifier(&s->exit);
-    if (s->needs_autoscan) {
-        QTAILQ_REMOVE(&hostdevs, s, next);
-    }
+    QTAILQ_REMOVE(&hostdevs, s, next);
     usb_host_close(s);
 }
 

---
base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
change-id: 20250912-usbhost-disconnect-192ecaa8fc3e

Best regards,
--  
Timo Teräs <timo.teras@iki.fi>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B76CAC594
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3lf-0006Kw-KO; Fri, 12 Sep 2025 09:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1ux1kB-0003OJ-Pz
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:15:07 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timo.teras@gmail.com>)
 id 1ux1k8-0004te-UT
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:15:07 -0400
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-55f76454f69so1781358e87.0
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757675700; x=1758280500;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p6JP8Pum99r5CoRhJu1jMy4fZ/96rMAfaqPJqZ97O4Y=;
 b=X+0ag4SFFBRPLXel0YMC5nIoC3ZukaRhdgmBsyjkwP69HgKKNaG48POc9TFZMXPL0T
 PKaHla0scnGydsDl1HD00QmtdOIbQiyVbUxZ7ai2nCNBm/fkctxDbM3Q6qo+wpmiByUP
 QQxqEF2lKpmSwEfypPXRPCMxjA2vZno0lmojbaVxj2EQIipkHVpgXKdqjcA+v3sBUq5R
 KUMXVH8k+3b5bvUQZ6sTTBmpObkxlGUqUjf8h3KVWzaAUgSRgeNQA6RHEYTEYat1LFM8
 v4ZFjeDLFfH6FMPzPC6Klm5mVwPgrcZRwF8WTlIylWMLAkwmwiZuDArd5NChGiO8ZY7K
 qaBA==
X-Gm-Message-State: AOJu0YzMYgA9S6jRsUm9RM0GoC5qTdXami1yDc/ZwzPDMIOAwjw6uOXi
 xykvLMlaPIn1Sd4qNcL49G8S9RgABrR+yOAzTJKqkhoeUra6860JF1JN
X-Gm-Gg: ASbGncutebWROSflM5ykefIyTNhbYnmISErvuKpt7vtmPNnGMhinRRz25Fs2X9SboZa
 X/y9LXSH3Hv2In5bJoauX35Ncl1/aBWM1k/9rUvxa6g6XMStP402nwsI2mBaWBo2Zvrrl3z7PTp
 X25KGQc00s9IfnXRrD6VjFgggE86AnWQHr3c8BRSzSJygkMoxLa9XGtTZyKsHna+dqaYzIk9R9J
 AMwGH+uupeZ1Jta5DkwOVIQ5S/hl3JqgoSv1nQg7mtt8YU8GtbNIcRR7JcaOaOFgoXyEnAfTp6/
 wYj93QGV4Qm2u426CUtN4PvblVu1CKDlSeD75zKzQxCT8lyVHTnFBU6ZZuJq/vevvcDnx3MVjVI
 7DTY5Dg0AbKZAtEyxalQ9OssL/bIyigS7xtatx9T+fjjLdpIMhV7LwNuu
X-Google-Smtp-Source: AGHT+IGwv5iKCgHISaqD9l+6BfffDDPDnCqb70WaUKKci+yoS1ZmoJXytHs9mVhyfoREntyBr4qhug==
X-Received: by 2002:a05:6512:350f:b0:569:28e5:d42 with SMTP id
 2adb3069b0e04-5704f7a377amr673128e87.29.1757675699802; 
 Fri, 12 Sep 2025 04:14:59 -0700 (PDT)
Received: from onyx.my.domain (91-159-30-98.elisa-laajakaista.fi.
 [91.159.30.98]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-56e5c3b6188sm1099903e87.3.2025.09.12.04.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 04:14:59 -0700 (PDT)
From: =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>
Date: Fri, 12 Sep 2025 14:14:46 +0300
Subject: [PATCH] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
X-B4-Tracking: v=1; b=H4sIAKUAxGgC/x3MQQqAIBBA0avErBPSCLKrRAsbp5yNhlMRSHdPW
 r7F/wWEMpPA1BTIdLNwihW6bQCDizsp9tVgOjN0Vht1yRqSnMqzYIqR8FTaGkLnxg17ghoemTZ
 +/um8vO8Hc0YyvmQAAAA=
X-Change-ID: 20250912-usbhost-disconnect-192ecaa8fc3e
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Timo_Ter=C3=A4s?= <timo.teras@iki.fi>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2888; i=timo.teras@iki.fi;
 h=from:subject:message-id; bh=BH8Px5alyO25aMCdJuahlCBuvr93ZN2zDT2SO/HzhOg=;
 b=owEBbQGS/pANAwAKAUZwDoxij6HOAcsmYgBoxACyakadGuPeumKvPvxBWaR4yfgaXrRino5l5
 vMgTAFi3w6JATMEAAEKAB0WIQTRdEpSPGbUaXBswFVGcA6MYo+hzgUCaMQAsgAKCRBGcA6MYo+h
 zkTCB/sEfw3RScOvyLmvZ+EeobBfJM86VM6Xm6A6OffyGmITx2rRA0ZhLPYHcJVHnXNe7dJTXYj
 yfjnVljVIYCS2omp2u4+vy9PluKQr0ykg16LgpYMDNansuz9HoFUaa72R8Y2QyoP/XWypsQ5YxH
 UGug1Ql8NhvO5B+7pnxBJ3cJdK5daMR/U1bYMzmfCyffDElYLYEO93EFP51LdnpxNu7zEvLVCvk
 OHp1I49NkB7HV1pfReBAkXlRZebu/YVRzc1afcWkkc/44SyLDRpi4HIdmOZmAIQOLosbB3BUfYY
 ad7S84Br8DgAJHm57ygM5oXzMsugr2Yh3jIJ85NtdyU8d+OB
X-Developer-Key: i=timo.teras@iki.fi; a=openpgp;
 fpr=D1744A523C66D469706CC05546700E8C628FA1CE
Received-SPF: pass client-ip=209.85.167.54; envelope-from=timo.teras@gmail.com;
 helo=mail-lf1-f54.google.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_PSBL=2.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Sep 2025 09:24:39 -0400
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

This is partial revert of commit e058fa2dd599.

The portion to immediately validate the device is kept, but this
adds and enables again the autoscan functionality. This is needed
to detect and relay USB device disconnect event to the guest.

Fixes: e058fa2dd599 ("usb-host: add special case for bus+addr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3111
Signed-off-by: Timo Teräs <timo.teras@iki.fi>
---
 hw/usb/host-libusb.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b74670ae25696b5252f0d034cb9b759e338a050f..f0baf6b2f2d12fbf8feb5b788b46d3187028df58 100644
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



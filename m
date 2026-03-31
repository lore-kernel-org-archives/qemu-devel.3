Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9462DFF60F4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ca6-0003ce-UN; Tue, 31 Mar 2026 13:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7ca6-0003c2-7x
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:46 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1w7ca4-0003Bp-8S
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:08:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so5683895b3a.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976922; x=1775581722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qK+TYXGeyXHMsmqfAHL+L670U9yf6uTftVNC0MvGN18=;
 b=U0afqVX533VURfpQkX6fUqKQA0AeAT7OdlFJFeels4z6dYYkQpMM2i6wiJCfsT8w/L
 NTGcyHy10wa0oaaMpdHPYtWsB+5UtfGUpqUkrWb4R9a4hJqWDHNBncFXXJDKxf0ZR7bj
 if/qbAQd9LOWzVL0Dj6+AoPoFnuUwM6wr7nl+yQl+IJ7N21DPyMgmiQsbv0/r8DZACnF
 lh7m/5kajZnLI24o1FcpvZRqS3t3I/UYCPGISSTv8rg8LDkpswnX+m9wS/Xbw/hDXG1F
 uGD7kfpHRGpfX1FUDApQ5avgjbBROqySn1bxlGj6BvKU2Dnx166jDzNVGyyLIxvQC1NP
 6+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976922; x=1775581722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qK+TYXGeyXHMsmqfAHL+L670U9yf6uTftVNC0MvGN18=;
 b=phOtZD+8RxKtXW7YPn7FON82btTAZtcM5CEOvbk3J7fxYuuCfQ+vyxcDtANNtZUIKr
 x1g872wBQpmYbICavKsXWtW34qKnHz8F5XC+JS1OYGryKpqOBteoqOlw5uXkvThIn3Jf
 t+0pMIU8Zfo2B8it8AXPUxtKZQiiBOcSxUEi32S6/rcaJsoqaDEHh53loa2RycXfV9Cq
 eLSrELm7u2swkutnD+OSBmp29U9bVDZmGfjPKUftLqFInTpdw5AYwx87Qx/+nfK2P7Oz
 Q7zuH8HFGgMzbItKIKUG1o8YA8QqM04sdU/lXTCb5bft73K9YUpasdMME/gpSGLei7ac
 YqPA==
X-Gm-Message-State: AOJu0YyA7yYOcJibXkSOMsSXHgXgJOdoU/lx643jPx34+DLgzm6SlqvV
 W9ro+AXWRkh6LuDbfzu10JHqCeXnJZTwmZu9IOYfA+sjM1T76WFJj+MJbaftG78M
X-Gm-Gg: ATEYQzzcF9z2SPrPIDRVWenGhmrsCjkAqqw0ffIlwZlfzXZphbWL5/0xvpiuLA/RsTj
 6WWCQXUC7s4JmoIOohv1ICTV3o9yY8wxZutyqKMViG4/+RkgELewoKDFbIGt/eNmM0tI7wcHkm/
 VCKdl0afMe/JL6ZU/y6y683UKLVlTNzVCxO+Ey4lRUAOl7sWp/iGQrPb5KwKyjRCZ7WJ9PZdOj5
 Dtta05AhnKHJi9zKlqfqGwAyGzkNC679IUhCEwyc8nMmI2LMmhkVE6fp2N0EVZ6kntptyc76G15
 mxRFSEsnf9EAssYq/PkXxZGKCECHfUnGnSfJU4KRztFvFGn5ywN2HKchmC+AiqZDZtfwQfAA0xd
 iEclG6ke874oqU/C6HqjsgLhYko6FhC6spUQCvQugdSWS/lVdtBxwRuOx2fTA5tW71YipzSw/Np
 bXE/qur5/VM431DRZw3rNu6TjBsAeNzAsx0UoC9Nn8zKlNMCbaYyrmSSgcePeyDmOSHsgGDII1c
 pKndeeSHJktOW1iofSV9Bj2x3YOwZlqrkg5jg2hUXhybLpHZh6zXUNbNv9dMOlSE+jAYIM11A==
X-Received: by 2002:a05:6a00:a228:b0:82a:17b6:53ca with SMTP id
 d2e1a72fcca58-82ce8ad21c2mr376006b3a.38.1774976922035; 
 Tue, 31 Mar 2026 10:08:42 -0700 (PDT)
Received: from fedora ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca843b818sm13647889b3a.6.2026.03.31.10.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:08:41 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [RFC PATCH 2/5] usb/hid: add enhanced wheel mouse report descriptor
 and packet size
Date: Tue, 31 Mar 2026 22:38:20 +0530
Message-ID: <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Build on top of the simple mouse HID report descriptor with an enhanced version
that supports report IDs and feature reports for high resolution mouse
wheel control. As per the documentation structure.

Check: https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-9f79ad7bb66e/wheel.docx

Changes:
- Increase HID descriptor length from 52 to 144 bytes
- Add report IDs (0x01 input, 0x02 feature)
- Implement feature reports for wheel/pan resolution multipliers
- Add AC Pan (horizontal scroll) usage
- Increase endpoint packet size from 4 to 6 bytes for pan byte

This enables guests to configure resolution multipliers (+-1, +-4, +-8, +-16)
to control scroll acceleration and precision.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/usb/dev-hid.c | 126 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 95 insertions(+), 31 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index ae19d60203..49e23c2319 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -93,7 +93,7 @@ static const USBDescIface desc_iface_mouse = {
                 0x00,          /*  u8  country_code */
                 0x01,          /*  u8  num_descriptors */
                 USB_DT_REPORT, /*  u8  type: Report */
-                52, 0,         /*  u16 len */
+                144, 0,        /*  u16 len */
             },
         },
     },
@@ -101,7 +101,7 @@ static const USBDescIface desc_iface_mouse = {
         {
             .bEndpointAddress      = USB_DIR_IN | 0x01,
             .bmAttributes          = USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        = 4,
+            .wMaxPacketSize        = 6,
             .bInterval             = 0x0a,
         },
     },
@@ -124,7 +124,7 @@ static const USBDescIface desc_iface_mouse2 = {
                 0x00,          /*  u8  country_code */
                 0x01,          /*  u8  num_descriptors */
                 USB_DT_REPORT, /*  u8  type: Report */
-                52, 0,         /*  u16 len */
+                144, 0,        /*  u16 len */
             },
         },
     },
@@ -132,7 +132,7 @@ static const USBDescIface desc_iface_mouse2 = {
         {
             .bEndpointAddress      = USB_DIR_IN | 0x01,
             .bmAttributes          = USB_ENDPOINT_XFER_INT,
-            .wMaxPacketSize        = 4,
+            .wMaxPacketSize        = 6,
             .bInterval             = 7, /* 2 ^ (8-1) * 125 usecs = 8 ms */
         },
     },
@@ -454,33 +454,97 @@ static const USBDesc desc_keyboard2 = {
 };

 static const uint8_t qemu_mouse_hid_report_descriptor[] = {
-    0x05, 0x01,		/* Usage Page (Generic Desktop) */
-    0x09, 0x02,		/* Usage (Mouse) */
-    0xa1, 0x01,		/* Collection (Application) */
-    0x09, 0x01,		/*   Usage (Pointer) */
-    0xa1, 0x00,		/*   Collection (Physical) */
-    0x05, 0x09,		/*     Usage Page (Button) */
-    0x19, 0x01,		/*     Usage Minimum (1) */
-    0x29, 0x05,		/*     Usage Maximum (5) */
-    0x15, 0x00,		/*     Logical Minimum (0) */
-    0x25, 0x01,		/*     Logical Maximum (1) */
-    0x95, 0x05,		/*     Report Count (5) */
-    0x75, 0x01,		/*     Report Size (1) */
-    0x81, 0x02,		/*     Input (Data, Variable, Absolute) */
-    0x95, 0x01,		/*     Report Count (1) */
-    0x75, 0x03,		/*     Report Size (3) */
-    0x81, 0x01,		/*     Input (Constant) */
-    0x05, 0x01,		/*     Usage Page (Generic Desktop) */
-    0x09, 0x30,		/*     Usage (X) */
-    0x09, 0x31,		/*     Usage (Y) */
-    0x09, 0x38,		/*     Usage (Wheel) */
-    0x15, 0x81,		/*     Logical Minimum (-0x7f) */
-    0x25, 0x7f,		/*     Logical Maximum (0x7f) */
-    0x75, 0x08,		/*     Report Size (8) */
-    0x95, 0x03,		/*     Report Count (3) */
-    0x81, 0x06,		/*     Input (Data, Variable, Relative) */
-    0xc0,		/*   End Collection */
-    0xc0,		/* End Collection */
+    0x05, 0x01,     /* Usage Page (Generic Desktop) */
+    0x09, 0x02,     /* Usage (Mouse) */
+    0xA1, 0x01,     /* Collection (Application) */
+
+    0x09, 0x02,     /* Usage (Mouse) */
+    0xA1, 0x02,     /* Collection (Logical) */
+
+    0x85, 0x01,     /* Report ID (0x01) */
+    0x09, 0x01,     /* Usage (Pointer) */
+    0xA1, 0x00,     /* Collection (Physical) */
+
+    0x05, 0x09,     /* Usage Page (Button) */
+    0x19, 0x01,     /* Usage Minimum (1) */
+    0x29, 0x05,     /* Usage Maximum (5) */
+    0x15, 0x00,     /* Logical Minimum (0) */
+    0x25, 0x01,     /* Logical Maximum (1) */
+    0x95, 0x05,     /* Report Count (5) */
+    0x75, 0x01,     /* Report Size (1) */
+    0x81, 0x02,     /* Input (Data,Var,Abs) */
+
+    0x95, 0x01,     /*  Report Count (1) */
+    0x75, 0x03,     /*  Report Size (3) */
+    0x81, 0x01,     /*  Input (Const) */
+
+    0x05, 0x01,     /*  Usage Page (Generic Desktop) */
+    0x09, 0x30,     /*  Usage (X) */
+    0x09, 0x31,     /*  Usage (Y) */
+    0x95, 0x02,     /*  Report Count (2) */
+    0x75, 0x08,     /*  Report Size (8) */
+    0x15, 0x81,     /*  Logical Minimum (-127) */
+    0x25, 0x7F,     /*  Logical Maximum (127) */
+    0x81, 0x06,     /*  Input (Data,Var,Rel) */
+
+    /* Vertical wheel logical collection */
+    0xA1, 0x02,     /*  Collection (Logical) */
+
+    0x85, 0x02,     /*  Report ID (0x02) */
+    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
+    0x15, 0x00,     /*  Logical Minimum (0) */
+    0x25, 0x01,     /*  Logical Maximum (1) */
+    0x35, 0x01,     /*  Physical Minimum (1) */
+    0x45, 0x04,     /*  Physical Maximum (4) */
+    0x75, 0x02,     /*  Report Size (2) */
+    0x95, 0x01,     /*  Report Count (1) */
+    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
+
+    0x85, 0x01,     /*  Report ID (0x01) */
+    0x09, 0x38,     /*  Usage (Wheel) */
+    0x35, 0x00,     /*  Physical Minimum (0) */
+    0x45, 0x00,     /*  Physical Maximum (0) */
+    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
+    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
+    0x75, 0x08,     /*  Report Size (8) */
+    0x95, 0x01,     /*  Report Count (1) */
+    0x81, 0x06,     /*  Input (Data,Var,Rel) */
+
+    0xC0,           /*  End Collection */
+
+    /* Horizontal wheel logical collection */
+    0xA1, 0x02,     /*  Collection (Logical) */
+
+    0x85, 0x02,     /*  Report ID (0x02) */
+    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
+    0x15, 0x00,     /*  Logical Minimum (0) */
+    0x25, 0x01,     /*  Logical Maximum (1) */
+    0x35, 0x01,     /*  Physical Minimum (1) */
+    0x45, 0x04,     /*  Physical Maximum (4) */
+    0x75, 0x02,     /*  Report Size (2) */
+    0x95, 0x01,     /*  Report Count (1) */
+    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
+
+    0x35, 0x00,     /*  Physical Minimum (0) */
+    0x45, 0x00,     /*  Physical Maximum (0) */
+    0x75, 0x04,     /*  Report Size (4) */
+    0x95, 0x01,     /*  Report Count (1) */
+    0xB1, 0x01,     /*  Feature (Const) */
+
+    0x85, 0x01,     /*  Report ID (0x01) */
+    0x05, 0x0C,     /*  Usage Page (Consumer Devices) */
+    0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
+    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
+    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
+    0x75, 0x08,     /*  Report Size (8) */
+    0x95, 0x01,     /*  Report Count (1) */
+    0x81, 0x06,     /*  Input (Data,Var,Rel) */
+
+    0xC0,           /*  End Collection */
+
+    0xC0,           /*  End Collection (Physical) */
+    0xC0,           /*  End Collection (Logical) */
+    0xC0            /*  End Collection (Application) */
 };

 static const uint8_t qemu_tablet_hid_report_descriptor[] = {
--
2.53.0



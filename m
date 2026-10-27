Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19A606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kKeN9fqe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmJm-0001Wd-Er; Tue, 27 Oct 2026 14:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJj-0001WM-Gj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:40 -0400
Received: from mail-dy2-x09.google.com ([2607:f8b0:4864:36::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJh-0007a0-Kv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:39 -0400
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso308682eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127276; x=1793732076; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cX5V84US+zTICcic6w/Bf6NpkwwVGlhctPrPs4SAGaU=;
 b=kKeN9fqeBBAFAsi/dP99UMmRMGmY7A18UoqS/4MqKGSJ1C5K1zJ2hqDzqKxAgIngmY
 9y6Hwidw+nomGXq1W/bqzp5wBXyAsP5u+/CcLaFF6kFUY6SDWOzfjqZkxDSVQd5zHdAh
 M2hvuUd3An3hWlWzDcSj57KzGHqqbsaSkkJzKIAofcW/cJPCKCt+VXo9XRwZhjff7wcA
 0KlTYK7b3DKmE7FD3q15ZjKrAgZMDmSM/0bV12B8nlWzPiK3mJLDpvsRIIzynuOVYN4N
 JtMtlx+QPHcSoZvRKbX92RGss2k1947QRULImdQJDtf7UlMdQrRdUOfCi+Cfa+XzW7Kv
 tLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127276; x=1793732076;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cX5V84US+zTICcic6w/Bf6NpkwwVGlhctPrPs4SAGaU=;
 b=tMm8p4RFuw9gUr6iSjQnIfYAv0j9LNmHFEEVnfYrfi9Wr2pPWCAYTuia8dd7WGv2Id
 vWtPU/b8eRWOzuzufLEItvQ0uh4O47oM65Kim/JWK/4q4gyqAhw1wmdTXf7AwRhIZgqS
 L7g6mzGcRehJ9uIg/wHv7/VmPBrK71T90aIsQUm0MR5pR3AF7diMFUnpU12T0eI8JWvM
 dysfzjDVfcIAzNBtOL3MiRYDpoGXDpd9RZLQuaQS7qSR598WlwPQY9bD5i3gMJD/6fGB
 N5sfJhhWkdoG2qfp+GJFNQlTCGTGlC+NsYVCvuLKI+w3+pUcy6qQal84NNDRB5zr506S
 RSPw==
X-Gm-Message-State: AFq9FYLuxSsEF9708R+I2CZId0Tgnj7qH8Mczq42sD2397ukEevcSRKn
 yAXay7EC/p4t5SmyLl58a6FDvY314elGtK0QCb5LhMxktPFHNL58wi1O4hbdGA36paU=
X-Gm-Gg: AYBFou31Jgam7fXnUizu/1occxtEsfX5uA4VmOD9j470XqoXQO/Iri6OwqYBvZZTkAb
 xtB0d+86iitosv4bYz0nT1NgHCHZTUggAToSLP+0nWXnzYmAg1DPHvTdu/ian/vkB8biWwyKUIw
 Tf6JzXOf3cYiIB6bhz408VsM4t5DPUsBJ2FFbKMxsGuSpuuIUO7YBOED5RokiovJ0O7gVyoEGqG
 aS3tmp3l1NTYvJPINLn+iUr35xjj6UBevfeWJwgQ2ijTzrTjAhsSjiVJSaD+OpP1pTGaMJG/GIk
 XeAfuWEBx650ht6HOP9JL3iDPYnGaqe/ikWJT5gX8vvJUyhYXw9TR+htIx1WqJOZ+JqDCUWzVCq
 xaV2fb1XwFM4NFx9ixhCnLv2lk00hZcWr3Vzl8bODoP3tLjA4E17Dg+5vWUwIoVNsvx40ALfCmb
 LsxsPQ2Yh3e33p3IoI9rwXKUZdumtN/D0K73hkWW1PC4uPy6BHoOTwr9eraW0ksn1NNcpt3PK1F
 X2ACBwkPaT3JKRW3dWY2aO6cBV5VZjswP9DS8igGh7nJAXXqXPJo0Mw/vNZrZ6DHTE5w1sdAtw9
 XoB0rl8bFUrvhNKbGi1+OXOrQeBpc6Dx8e0uzlV7CrXJa5iZJEppUjrFVgV1vBRx3hj+aIhT/sV
 e85El4EkkEpwl0Y4vl8Hijs3tmSqHp5WLH1yUyOsRtbTGKl2fXg==
X-Received: by 2002:a05:701b:2514:b0:196:d6e1:108b with SMTP id
 a92af1059eb24-1a6cbe7fa09mr152877c88.10.1793127275853; 
 Tue, 27 Oct 2026 11:54:35 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6da44c132sm75324c88.18.2026.10.27.11.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:54:35 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: qemu-devel@nongnu.org,
	sarkarsoumyajyoti23@gmail.com
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 4/8] hw/usb/dev-hid: derive the mouse report descriptor length
 with sizeof()
Date: Wed, 28 Oct 2026 00:18:53 +0530
Message-ID: <20261027184857.60775-5-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
References: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::9;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x09.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

The HID class descriptors of the mouse interfaces carry the length of
the report descriptor as a hard-coded 52.  Any change to the report
descriptor then has to update both copies by hand, and Windows stops
recognising the mouse if the advertised length does not match the
descriptor exactly.

Move qemu_mouse_hid_report_descriptor above the interface descriptors
and compute the length with sizeof().  While moving it, replace the
tabs in front of the comments with spaces so the moved lines pass
checkpatch; the comments stay in the same column.

No functional change.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 hw/usb/dev-hid.c | 74 +++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index ae19d60203..2c10e88c85 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -76,6 +76,42 @@ static const USBDescStrings desc_strings = {
     [STR_SERIAL_KEYBOARD]  = "68284",
 };
 
+/*
+ * The interface descriptors below advertise the length of this report
+ * descriptor.
+ * Note: Windows stops recognising the mouse if it does not match
+ * exactly.
+ */
+static const uint8_t qemu_mouse_hid_report_descriptor[] = {
+    0x05, 0x01,         /* Usage Page (Generic Desktop) */
+    0x09, 0x02,         /* Usage (Mouse) */
+    0xa1, 0x01,         /* Collection (Application) */
+    0x09, 0x01,         /*   Usage (Pointer) */
+    0xa1, 0x00,         /*   Collection (Physical) */
+    0x05, 0x09,         /*     Usage Page (Button) */
+    0x19, 0x01,         /*     Usage Minimum (1) */
+    0x29, 0x05,         /*     Usage Maximum (5) */
+    0x15, 0x00,         /*     Logical Minimum (0) */
+    0x25, 0x01,         /*     Logical Maximum (1) */
+    0x95, 0x05,         /*     Report Count (5) */
+    0x75, 0x01,         /*     Report Size (1) */
+    0x81, 0x02,         /*     Input (Data, Variable, Absolute) */
+    0x95, 0x01,         /*     Report Count (1) */
+    0x75, 0x03,         /*     Report Size (3) */
+    0x81, 0x01,         /*     Input (Constant) */
+    0x05, 0x01,         /*     Usage Page (Generic Desktop) */
+    0x09, 0x30,         /*     Usage (X) */
+    0x09, 0x31,         /*     Usage (Y) */
+    0x09, 0x38,         /*     Usage (Wheel) */
+    0x15, 0x81,         /*     Logical Minimum (-0x7f) */
+    0x25, 0x7f,         /*     Logical Maximum (0x7f) */
+    0x75, 0x08,         /*     Report Size (8) */
+    0x95, 0x03,         /*     Report Count (3) */
+    0x81, 0x06,         /*     Input (Data, Variable, Relative) */
+    0xc0,               /*   End Collection */
+    0xc0,               /* End Collection */
+};
+
 static const USBDescIface desc_iface_mouse = {
     .bInterfaceNumber              = 0,
     .bNumEndpoints                 = 1,
@@ -93,7 +129,9 @@ static const USBDescIface desc_iface_mouse = {
                 0x00,          /*  u8  country_code */
                 0x01,          /*  u8  num_descriptors */
                 USB_DT_REPORT, /*  u8  type: Report */
-                52, 0,         /*  u16 len */
+                /*  u16 len */
+                sizeof(qemu_mouse_hid_report_descriptor) & 0xff,
+                sizeof(qemu_mouse_hid_report_descriptor) >> 8,
             },
         },
     },
@@ -124,7 +162,9 @@ static const USBDescIface desc_iface_mouse2 = {
                 0x00,          /*  u8  country_code */
                 0x01,          /*  u8  num_descriptors */
                 USB_DT_REPORT, /*  u8  type: Report */
-                52, 0,         /*  u16 len */
+                /*  u16 len */
+                sizeof(qemu_mouse_hid_report_descriptor) & 0xff,
+                sizeof(qemu_mouse_hid_report_descriptor) >> 8,
             },
         },
     },
@@ -453,36 +493,6 @@ static const USBDesc desc_keyboard2 = {
     .msos = &desc_msos_suspend,
 };
 
-static const uint8_t qemu_mouse_hid_report_descriptor[] = {
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
-};
-
 static const uint8_t qemu_tablet_hid_report_descriptor[] = {
     0x05, 0x01,		/* Usage Page (Generic Desktop) */
     0x09, 0x02,		/* Usage (Mouse) */
-- 
2.56.0



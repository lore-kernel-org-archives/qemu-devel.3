Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB54D606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0oisvVMd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn51-0006p8-Kb; Tue, 27 Oct 2026 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4x-0006oW-1z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:27 -0400
Received: from mail-dy2-x0b.google.com ([2607:f8b0:4864:36::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4t-0003tK-TW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:25 -0400
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-36a1e794908so45730eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130202; x=1793735002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MqmKANFmF1KWHkD0zN0BNlsIh1qC7oBV5bQeH+b1K10=;
 b=0oisvVMdCRnSKaT7+BlT7He8mluZRL5wau4rKoE4/mMX9G+e6k4LyNqj2wOYKL3j8Z
 NQlMU0NFdki45JGDqkyRifToaL2MS5KVH4/WmKJ8FtY4Ni0Ca8bmRHqYdeAIv7zzQu9l
 asHoHrtiBq6FSb4OJg1UWyqz75uUAN36pZoB9tUUwsVQpmg5ntLfC96q9xKiBN6vPFfk
 dYyjMB1fRin/Xaw0wDVvf9/l037+Dtnf8lZGepvWP5nU3D3n1R6rUO4KkR9ChLiTcdYk
 K9s5v9Y1xReuvqdjbhnoUanSV5E6hmSZfSWGsWlHNFz9jcqwkCusVC9D6NFaczwq6GWv
 KIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130202; x=1793735002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MqmKANFmF1KWHkD0zN0BNlsIh1qC7oBV5bQeH+b1K10=;
 b=0599HysPBaJIzIcVSCAuBZyvb9Y5M1c+Iy0Vs8C3rNd2hqV+vNViH3XmXda16pUBTj
 fwhSZw/r02Ea0dpyLmyRk6Kas0VHf3Jaw8tEKoqBwDg6EGZ5WA3GFTRqH1rnUsRzu2/c
 01KMABdT8d2q67PIrKtXAacI29dsNHoVhpRDh7vxccG0gj/U+0UXGNEePw1RAit2nuze
 rkCu6evyQQce1Ypm4jWaazQRQ7ff9zQ2/pSjfDJje3Ts1Ctmjf3zXmxrPF9T2oUITzbq
 oZfbSY9FAbBkQXFgjOFj5xqVNBJb1ZGk8wkXpqaahYCXmhNoQjYRf49JxmAOVI2wvecU
 kPrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByry4zDd01adyxtPmsDQ/CWk+3Lk84tjuKoFAQAWuxUu1MtH9kP1N5YIUeq7O4wCIA1qnLwyoMDB5M+@nongnu.org
X-Gm-Message-State: AFq9FYIEULUUVzbp3Z0l8OoZL8Vft6fLQkCAL85SRoennOUnmDTs4iIg
 j8veioiz+fTJlViFzcW1rRCF4TIuUiRpd1oqBaFP9PIVpR3AWGzP2Jxc
X-Gm-Gg: AYBFou3j8BsUnpi3JG5Xi/fwA5MDZVVe/1DN+qFF6sruY98Iaij2FjO64Ln0ysMHL3Z
 Xg9b7GJil1ufN8JjWRm0f+z2eFbPQxgqu8TVkm1CjeqaUu7kZaBmYwuvpEEkq/GHV+E9RuwWOqL
 IKc1UOAIPYb5Ux3EG5BuFp2bkK9nzo8dGeuFdzLAt8RxZb8LWgx90yAFyH/o8MdqNFiQLwsC/x4
 aGpmtEGbVksC1sYWKYFgbCqbHUeu9py5YP85LmJ+ZTMmriIlOUBelSRqLPO1HjYF0F3ibuf/tDu
 lEGre1SS55/wfmQTKeNiVIajDKbjEnBqmWcSWJ1uq9ZEDofje90V22FGRTipuIMLp9t6D1pHtYR
 rZiQVVqqTvqr38R2OE2PinNwq23b2mlWhvYKR3lQFRdFTXlcrZQfzOYbsqGVvxcPRfchGyOgr58
 GfXpPw9rT3c0wxWNOgDp14sDm2w7XT6ouJIgnsWQRkiJMOivFugi+n9Qj+m2Rqoq3NYxGYCnHWf
 Y1gax9JY8lR6sLUOVf+++TCgcZzUA65klMvw4LrnRgqsXlG4jJOFOTQ1osFQtF+DmhHEbrqspg+
 dbcLLpZ1yYkFb1FtRy0iitfszUhPV1OO3DyU4WiwARLy/uE8vzwQNKIDvpezCXvJF/l65vsuBIt
 DxL1cEahauH4a91gGCZspTUZWivEnRbkT5EWIQXbjFqyaKFcnlCoV3Mjy5wMYECXtBSn/+jO781
 Iaxc5oDT+W8PuxkEtevIjQZvw=
X-Received: by 2002:a05:7300:d0a5:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-36a200bea37mr557271eec.16.1793130202415; 
 Tue, 27 Oct 2026 12:43:22 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:21 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 4/8] hw/usb/dev-hid: derive the mouse report descriptor
 length with sizeof()
Date: Wed, 28 Oct 2026 01:12:52 +0530
Message-ID: <20261027194256.76031-5-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::b;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x0b.google.com
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
the report descriptor as a hard-coded 52. Any change to the report
descriptor then has to update both copies by hand, and Windows stops
recognising the mouse if the advertised length does not match the
descriptor exactly.

Move qemu_mouse_hid_report_descriptor above the interface descriptors
and compute the length with sizeof(). 

No functional change.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Helge Deller <deller@gmx.de>
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



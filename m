Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF581C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9xC-0001JQ-P8; Tue, 25 Jun 2024 13:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yp-0003cB-Iq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yo-0003GF-0U
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:19 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00b97so5574308a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719327255; x=1719932055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gd1bnX5yMsLjKAf/zlmApEfZTYiMqAMKaFxN5Ze85Yc=;
 b=i3gBoxlrtqBamK0ytEM0RYFDW1E67Q08WQxMa9FsiHACz4RoB7x60IHfMTOGTHBw97
 4iLaAfynHRCzdKjXlIetMfFs8/M0Xv/ur8YACVuCItyGEwxuLFy1gfy3qPhI35w4WDXY
 Z0N9coGVi5iikR5A2wiNu4Ybq0kFqcZ90Ega4bTsqd47wfwY+KqgfTszhCYi5AAbj/Rn
 lpiWvVreDolD3YUYmpkEwKCdlFyJAo4qSppCz6Nl13AwMSZW276eCFwOfTj7Nnd4TtLD
 8smgBvMmcbiYic9YDppc6y8KTcUwoiekIEz5cBEDUl4sL2SSTxVO4vCJE6ga7HNVq3Fz
 MBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327255; x=1719932055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd1bnX5yMsLjKAf/zlmApEfZTYiMqAMKaFxN5Ze85Yc=;
 b=TienmJYXb+BFYhpTseUSPTnKilWXUySjOict4xfWiDiN8hB5oHmT4qVeQSu5Nx0i1u
 8a+HlXOKYPQeoHzZN1mBQHgBzA/C8dvNP2yQpF28S5RLe15pE0OEIy/Rtg5htq8JszyL
 cc30JZ7ujzepsxB1vuVPcOhTdbqleFnNLE4ps2OqH+LBdFHtpP9Pe47Nq6jj3FUo0+kE
 CI+lEbi3XzdDH7bxkl+RxHDswJ4zLYAMid/66exmmpl6wx9FdBnM2C+tmqETVemMWyhh
 QUvcsZq7D23TicdN+Laozu8AC5SRldzFXswxszCxUNP8jEHDptS2FNNjTJMvNmOdrV40
 ixBg==
X-Gm-Message-State: AOJu0Yz/pQlGDmLq10s7RRmjGX0oV9hfYjze4BrpYdHkL0NySG4a6nTU
 3aERC0xlARZIsPfRyTXYKWLjddHEyFUbIrEfah9FvecUox5cusdn4OSbbQ==
X-Google-Smtp-Source: AGHT+IGqX5yA+0k3VJ5/KXQ+ampjX9TzFY8KWbpglDZmONHaMBeigDL/BjTd77zUURHG4QynOlWREA==
X-Received: by 2002:a50:aa96:0:b0:57d:788:aaae with SMTP id
 4fb4d7f45d1cf-57d4bddfabamr6098598a12.35.1719327255483; 
 Tue, 25 Jun 2024 07:54:15 -0700 (PDT)
Received: from 41414141.home (84-82-177-210.fixed.kpn.net. [84.82.177.210])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d421sm6092740a12.42.2024.06.25.07.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:15 -0700 (PDT)
From: David Bouman <dbouman03@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Bouman <dbouman03@gmail.com>
Subject: [PATCH 1/4] hw/usb/u2f: Add `start` and `stop` callbacks to U2F key
 class
Date: Tue, 25 Jun 2024 16:53:47 +0200
Message-Id: <20240625145350.65978-2-dbouman03@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625145350.65978-1-dbouman03@gmail.com>
References: <20240625145350.65978-1-dbouman03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=dbouman03@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 13:25:46 -0400
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

Preparation for improved u2f-passthru hidraw handle lifetimes:

These callbacks can be implemented by the backing implementation,
i.e. u2f-passthru or u2f-emulated.

The start callback is invoked when the device receives an INTR IN, and
the stop callback is invoked when the endpoint has been unlinked/stopped.

For a Linux guest, the start callback corresponds to the `hid_hw_open` and
`hid_hw_close` routines, invoked whenever the first user opens, respectively
the last user closes the emulated hidraw device.

Signed-off-by: David Bouman <dbouman03@gmail.com>
---
 hw/usb/u2f.c | 23 +++++++++++++++++++++++
 hw/usb/u2f.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/hw/usb/u2f.c b/hw/usb/u2f.c
index 1fb59cf404..cc1abd6c7d 100644
--- a/hw/usb/u2f.c
+++ b/hw/usb/u2f.c
@@ -253,6 +253,12 @@ static void u2f_key_handle_data(USBDevice *dev, USBPacket *p)
     case USB_TOKEN_IN:
         packet_in = u2f_pending_in_get(key);
         if (packet_in == NULL) {
+            U2FKeyClass *kc = U2F_KEY_GET_CLASS(key);
+
+            /* An early INTR IN is sent to kick the device. */
+            if (!key->started) {
+                key->started = (kc->start ? kc->start(key) : true);
+            }
             p->status = USB_RET_NAK;
             return;
         }
@@ -317,6 +323,21 @@ const VMStateDescription vmstate_u2f_key = {
     }
 };
 
+static void u2f_ep_stopped(USBDevice *dev, USBEndpoint *ep)
+{
+    U2FKeyState *key = U2F_KEY(dev);
+    U2FKeyClass *kc = U2F_KEY_GET_CLASS(key);
+
+    if (!key->started) {
+        return;
+    }
+    if (kc->stop) {
+        kc->stop(key);
+    }
+    key->started = false;
+}
+
+
 static void u2f_key_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -332,6 +353,8 @@ static void u2f_key_class_init(ObjectClass *klass, void *data)
     uc->unrealize      = u2f_key_unrealize;
     dc->desc           = "QEMU U2F key";
     dc->vmsd           = &vmstate_u2f_key;
+
+    uc->ep_stopped     = u2f_ep_stopped;
 }
 
 static const TypeInfo u2f_key_info = {
diff --git a/hw/usb/u2f.h b/hw/usb/u2f.h
index 8bff13141a..56d989c783 100644
--- a/hw/usb/u2f.h
+++ b/hw/usb/u2f.h
@@ -49,6 +49,9 @@ struct U2FKeyClass {
                             const uint8_t packet[U2FHID_PACKET_SIZE]);
     void (*realize)(U2FKeyState *key, Error **errp);
     void (*unrealize)(U2FKeyState *key);
+
+    bool (*start)(U2FKeyState *key);
+    void (*stop)(U2FKeyState *key);
 };
 
 /*
@@ -64,6 +67,8 @@ struct U2FKeyState {
     uint8_t pending_in_start;
     uint8_t pending_in_end;
     uint8_t pending_in_num;
+
+    bool started;
 };
 
 /*
-- 
2.34.1



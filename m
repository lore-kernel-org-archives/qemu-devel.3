Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB58C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Wq-0003rM-8H; Mon, 17 Jun 2024 03:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wp-0003qr-8J
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wn-00028q-FE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57c76497cefso4679113a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608303; x=1719213103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lR07tpwHJFGsUZ//qiGP/Uf8TuKYiE2bQ0OYC/d3M2w=;
 b=HZhG4pEXXHBqje4MJXq8F7p8aatnPafClwnuUvvbL+kBjdfcj5tV1nlE2nGt55LJHQ
 mXtmo9ia+Jxz2kcnWgvQldAS/pTDGgMVQ9V4KJqx6cfZoJFeU+9227h5njk7fCFDzAjl
 FtfOkg+V09nXQiv1dA76AOQAiueHWfIr650/CNQMKQbGjGE2LvA7apI7m5/xp4AraNz+
 TCrfRlK3gBoWnCHXQUC1GrwaLMdnladWVuUEl1rjeM9I3AZOy2HdF7+bk+NChmo9AG7i
 o2Y9BYfY5q3vxG0Zp2T/QidGR/YcJFdHkjjtoZd4QAKrAJDU2jeFsZmnAjmfdA6Qf0QG
 txVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608303; x=1719213103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lR07tpwHJFGsUZ//qiGP/Uf8TuKYiE2bQ0OYC/d3M2w=;
 b=LxdkcRbmjw4MRVN0fbgYDco0pzyXu2Xln9V7wPJy0Y9ex+BhVsQ9vyPON7tcVsYS8L
 OslImE9bisbkLTxLshN87XWXE9eIENBy/M+MOBJ5RknX4PC3kE+VgkH7bXQklGWmvvsZ
 FmcFeQlBibsywNGOyMUTI6xg3VjeO8cQfBBW1LlHw1MpqCgHbh+jV0J3dIUXg/prFQSB
 z8KbAwVGwXD02K4kDzt9o68kU1b6bwThSwClrZNr978KVczAlwDoszJWvoba6Je0naH8
 qe5lRboFtRNSWuPr33w+fiZrcXxJSAw5Bxyj79IYP8qH2ZHTxqu8TEB85xWAUJjEITNE
 Aa4w==
X-Gm-Message-State: AOJu0Ywh6GQiGmCyusUhYb7Z+lnbwZ45tFN2Sg2Bn/4+Qk+UJwvzjN1F
 KGIgTmwnYQxQF+/AITwwYpyQivmy4EmjqCo5YRN3jww3vqK5OlXYlzvEVbLBVTbx3v7NVxys/ny
 z/pU=
X-Google-Smtp-Source: AGHT+IFO5jvNlZgsU2dmr6WVUk3p6RSJkVUJCf2RKeoUwid1ClxYOTl2YvniZX3uWSgxTDvu/eADzA==
X-Received: by 2002:a50:ccd9:0:b0:57c:6740:f47c with SMTP id
 4fb4d7f45d1cf-57cbd69c7e9mr5890358a12.27.1718608303506; 
 Mon, 17 Jun 2024 00:11:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdf52sm6047115a12.8.2024.06.17.00.11.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 04/23] hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST flag
Date: Mon, 17 Jun 2024 09:10:59 +0200
Message-ID: <20240617071118.60464-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

XHCI_FLAG_SS_FIRST was only used by the pc-i440fx-2.0 machine,
which got removed. Remove it and simplify various functions in
hcd-xhci.c.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/usb/hcd-xhci.h     |  3 +--
 hw/usb/hcd-xhci-nec.c |  2 --
 hw/usb/hcd-xhci-pci.c |  1 -
 hw/usb/hcd-xhci.c     | 42 ++++++++----------------------------------
 4 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 1efa4858fb..fe16d7ad05 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -36,8 +36,7 @@ typedef struct XHCIStreamContext XHCIStreamContext;
 typedef struct XHCIEPContext XHCIEPContext;
 
 enum xhci_flags {
-    XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_ENABLE_STREAMS,
+    XHCI_FLAG_ENABLE_STREAMS = 1,
 };
 
 typedef enum TRBType {
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 5d5b069cf9..0c063b3697 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -41,8 +41,6 @@ struct XHCINecState {
 static Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
-                    XHCI_FLAG_SS_FIRST, true),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index cbad96f393..264d7ebb77 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -242,7 +242,6 @@ static void qemu_xhci_instance_init(Object *obj)
     s->msix     = ON_OFF_AUTO_AUTO;
     xhci->numintrs = XHCI_MAXINTRS;
     xhci->numslots = XHCI_MAXSLOTS;
-    xhci_set_flag(xhci, XHCI_FLAG_SS_FIRST);
 }
 
 static const TypeInfo qemu_xhci_info = {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index ad40232eb6..b6411f0bda 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -541,18 +541,10 @@ static XHCIPort *xhci_lookup_port(XHCIState *xhci, struct USBPort *uport)
     case USB_SPEED_LOW:
     case USB_SPEED_FULL:
     case USB_SPEED_HIGH:
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            index = uport->index + xhci->numports_3;
-        } else {
-            index = uport->index;
-        }
+        index = uport->index + xhci->numports_3;
         break;
     case USB_SPEED_SUPER:
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            index = uport->index;
-        } else {
-            index = uport->index + xhci->numports_2;
-        }
+        index = uport->index;
         break;
     default:
         return NULL;
@@ -2779,11 +2771,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
         ret = 0x20425355; /* "USB " */
         break;
     case 0x28: /* Supported Protocol:08 */
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            ret = (xhci->numports_2<<8) | (xhci->numports_3+1);
-        } else {
-            ret = (xhci->numports_2<<8) | 1;
-        }
+        ret = (xhci->numports_2 << 8) | (xhci->numports_3 + 1);
         break;
     case 0x2c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
@@ -2795,11 +2783,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg, unsigned size)
         ret = 0x20425355; /* "USB " */
         break;
     case 0x38: /* Supported Protocol:08 */
-        if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-            ret = (xhci->numports_3<<8) | 1;
-        } else {
-            ret = (xhci->numports_3<<8) | (xhci->numports_2+1);
-        }
+        ret = (xhci->numports_3 << 8) | 1;
         break;
     case 0x3c: /* Supported Protocol:0c */
         ret = 0x00000000; /* reserved */
@@ -3349,13 +3333,8 @@ static void usb_xhci_init(XHCIState *xhci)
     for (i = 0; i < usbports; i++) {
         speedmask = 0;
         if (i < xhci->numports_2) {
-            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-                port = &xhci->ports[i + xhci->numports_3];
-                port->portnr = i + 1 + xhci->numports_3;
-            } else {
-                port = &xhci->ports[i];
-                port->portnr = i + 1;
-            }
+            port = &xhci->ports[i + xhci->numports_3];
+            port->portnr = i + 1 + xhci->numports_3;
             port->uport = &xhci->uports[i];
             port->speedmask =
                 USB_SPEED_MASK_LOW  |
@@ -3366,13 +3345,8 @@ static void usb_xhci_init(XHCIState *xhci)
             speedmask |= port->speedmask;
         }
         if (i < xhci->numports_3) {
-            if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
-                port = &xhci->ports[i];
-                port->portnr = i + 1;
-            } else {
-                port = &xhci->ports[i + xhci->numports_2];
-                port->portnr = i + 1 + xhci->numports_2;
-            }
+            port = &xhci->ports[i];
+            port->portnr = i + 1;
             port->uport = &xhci->uports[i];
             port->speedmask = USB_SPEED_MASK_SUPER;
             assert(i < XHCI_MAXPORTS);
-- 
2.41.0



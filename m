Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E53CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2Z-0001ek-0C; Fri, 06 Sep 2024 08:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2F-0000Y8-KY; Fri, 06 Sep 2024 08:25:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2C-00022t-85; Fri, 06 Sep 2024 08:25:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso769326b3a.2; 
 Fri, 06 Sep 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625550; x=1726230350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8cLM4lBHkF2f8gamUFmp8FRMLlHGlyVZYF1SucMdqs=;
 b=dPrOi/BTUyH6hBNRXql3JtXNVBVZWGxyMk1sgt5sp7ntH5v6uUhGtboWwpGG9rjkn9
 KWIRKr8QuQfbPp7o63+g0REKdTA1K//uqmFmePkiGeYvVTAtLFUaSM5eNDkH22DH1UEw
 jnU2j6QreEj0P1ioKmiDYe12cIPk4e9cmgAxtc0OB2O186a3Qz83WLMXLPTJg8b1fvbg
 uj3fyAGewIH5cJT1uL7ts0f6I0gc+LK6sQV9AP9wYTmDQQUMEt0S1iDRRr0zZZ+7z/8r
 rpQSCRdXSsb0sceP6k3CV7Qi70NVxQg2wH8/0l58fWHTTyRIgJUzWc8bZrQ9qdZM2gaq
 gciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625550; x=1726230350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8cLM4lBHkF2f8gamUFmp8FRMLlHGlyVZYF1SucMdqs=;
 b=JySF9bq6xmvFuef8Yb5f85KdobJldLnWMTC0IVjTm8y7ALo9DtgRepzwRJeuCzqtQK
 4Q1PKhJ0UisXDEYdZk1Mgf0TvgUdOCSb/QEAAjQsd6gHrwR6CJjz8q8Bm//fs2uDTP27
 MyPRo/1f0tlzg3rlTZ+ecefHcFjBXSI2/RRmSPyE7KBctk4Xl9eRjPgYi0zR1yeZyb3G
 1PAdK0hT6bZ+NCgJreYh1XSemzkjNAk31UaQLN/W1Bi7FZrSGQcErWp1CxqVnrJTFl/e
 7L9vUneatT2sGv2QZ5KQ9p/qtxnuyRdn7F0tYDm65dYf/MKWwOyZFlkTvWH2QOHU+fNe
 4Ldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcCeAbg7kueF3Wl91olns92SesbSsecTfbyX+6IJEjTRyH5obvwqsO1Xc+h/eTozP5Il9GBjCKjQ==@nongnu.org
X-Gm-Message-State: AOJu0YwLe1VAZKdCj80rybmR/wLhAtDRIrIx6xnyhpibHqRqtdCm+Paq
 TzpCVPJqMi8vYDI5/ebGR+4q6Y3OY/XuR5dFzhT2fKSSLgfIGiYjkmOfjw==
X-Google-Smtp-Source: AGHT+IErWrvOXwMtwUMnukPPKgk5oS/yK3Nx3SgH+V/KcsIAX/x/Bw9EYKiXlpRtacz/6nZr5qIoWw==
X-Received: by 2002:a05:6a20:4389:b0:1ce:ce51:4405 with SMTP id
 adf61e73a8af0-1cf1d1ddf8emr2154642637.42.1725625549838; 
 Fri, 06 Sep 2024 05:25:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71785cbf68fsm3449212b3a.129.2024.09.06.05.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:49 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/8] usb/uhci: Introduce and use register defines
Date: Fri,  6 Sep 2024 05:25:36 -0700
Message-ID: <20240906122542.3808997-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Introduce defines for UHCI registers to simplify adding register access
in subsequent patches of the series.

No functional change.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-uhci.c          | 32 ++++++++++++++++----------------
 include/hw/usb/uhci-regs.h | 11 +++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index dfcc3e05c0..8bc163f688 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -389,7 +389,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
     trace_usb_uhci_mmio_writew(addr, val);
 
     switch (addr) {
-    case 0x00:
+    case UHCI_USBCMD:
         if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
             /* start frame processing */
             trace_usb_uhci_schedule_start();
@@ -424,7 +424,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0x02:
+    case UHCI_USBSTS:
         s->status &= ~val;
         /*
          * XXX: the chip spec is not coherent, so we add a hidden
@@ -435,27 +435,27 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         }
         uhci_update_irq(s);
         break;
-    case 0x04:
+    case UHCI_USBINTR:
         s->intr = val;
         uhci_update_irq(s);
         break;
-    case 0x06:
+    case UHCI_USBFRNUM:
         if (s->status & UHCI_STS_HCHALTED) {
             s->frnum = val & 0x7ff;
         }
         break;
-    case 0x08:
+    case UHCI_USBFLBASEADD:
         s->fl_base_addr &= 0xffff0000;
         s->fl_base_addr |= val & ~0xfff;
         break;
-    case 0x0a:
+    case UHCI_USBFLBASEADD + 2:
         s->fl_base_addr &= 0x0000ffff;
         s->fl_base_addr |= (val << 16);
         break;
-    case 0x0c:
+    case UHCI_USBSOF:
         s->sof_timing = val & 0xff;
         break;
-    case 0x10 ... 0x1f:
+    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
         {
             UHCIPort *port;
             USBDevice *dev;
@@ -493,28 +493,28 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
     uint32_t val;
 
     switch (addr) {
-    case 0x00:
+    case UHCI_USBCMD:
         val = s->cmd;
         break;
-    case 0x02:
+    case UHCI_USBSTS:
         val = s->status;
         break;
-    case 0x04:
+    case UHCI_USBINTR:
         val = s->intr;
         break;
-    case 0x06:
+    case UHCI_USBFRNUM:
         val = s->frnum;
         break;
-    case 0x08:
+    case UHCI_USBFLBASEADD:
         val = s->fl_base_addr & 0xffff;
         break;
-    case 0x0a:
+    case UHCI_USBFLBASEADD + 2:
         val = (s->fl_base_addr >> 16) & 0xffff;
         break;
-    case 0x0c:
+    case UHCI_USBSOF:
         val = s->sof_timing;
         break;
-    case 0x10 ... 0x1f:
+    case UHCI_USBPORTSC1 ... UHCI_USBPORTSC4:
         {
             UHCIPort *port;
             int n;
diff --git a/include/hw/usb/uhci-regs.h b/include/hw/usb/uhci-regs.h
index fd45d29db0..5b81714e5c 100644
--- a/include/hw/usb/uhci-regs.h
+++ b/include/hw/usb/uhci-regs.h
@@ -1,6 +1,17 @@
 #ifndef HW_USB_UHCI_REGS_H
 #define HW_USB_UHCI_REGS_H
 
+#define UHCI_USBCMD       0
+#define UHCI_USBSTS       2
+#define UHCI_USBINTR      4
+#define UHCI_USBFRNUM     6
+#define UHCI_USBFLBASEADD 8
+#define UHCI_USBSOF       0x0c
+#define UHCI_USBPORTSC1   0x10
+#define UHCI_USBPORTSC2   0x12
+#define UHCI_USBPORTSC3   0x14
+#define UHCI_USBPORTSC4   0x16
+
 #define UHCI_CMD_FGR      (1 << 4)
 #define UHCI_CMD_EGSM     (1 << 3)
 #define UHCI_CMD_GRESET   (1 << 2)
-- 
2.45.2



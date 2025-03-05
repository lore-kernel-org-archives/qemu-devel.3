Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7E9C282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdU7-0001Rl-SF; Tue, 04 Mar 2025 20:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTB-0008ES-T6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdT8-0006yg-Bq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43996e95114so42446825e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137760; x=1741742560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzLF6WZxlhetZaZPRfOe7fKCtkMcxscueckYeAPjn3I=;
 b=M/PeVj4dw7tUxqzLOXL2zPIl9u7sLALOThyIPD6D6l8vWR3CLmFFwGQeqUkxOp6rmp
 1Cz2KVmkDuMjlHVkK/4f3bdBiYgodIn9VSM4oK4Ldurg4aNTA7f+hTFEuwIlVXKV5SaY
 KErEz+SEMv+3OSwsteYuHR+PQQhzEA2dsfis57IwK78u2+g4M62c8mUdU0mSYlD/I44y
 /F2+A9nSHF+RE6Xb2WCQF9Lk5vxaUYXmJ7hTXAP+elh8YxnXOMAzxUjtjGWHOAnlx2H9
 ByELEIF3ihDLB2nOHrcA1MSlKXqbF9a0XVhExj8qJNDxuSuONbjMztJu8FANgy1Y0JVT
 sdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137760; x=1741742560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzLF6WZxlhetZaZPRfOe7fKCtkMcxscueckYeAPjn3I=;
 b=PJjxcJRQ8b4pjdy/bHU/eblchp5ztsVDUzDuHH554WprZsXEyrPtxf3N+09MFxlm9I
 IcVUVHQEJRn+kwqFzwFgyWiw8TeTv9Im6exYM/4zyn5kl+pgEbic6ExWcpMOOJ99lgMw
 9HZWoIaM0Qu0pC/6cxYwIxC66CJSAOdlIL42oZ0wEYb+pqbdgbnmFqOXo1i42arzHFO/
 DhRFEjZbtSLeBEio81Mlpff/gFgN2MYPR4eEdxmJzfdNKrAkPLZr2gTYzwOvNEIhEPjy
 mVOg+VV5HfK2F+Rjy4xqQLPUhhW3RvHHephEu30e68qOLLtwKe2xoejldeKQGGHbBC0+
 s5zg==
X-Gm-Message-State: AOJu0Yyqr+hbdG8ICDkh+UPbEXOqEg/mUSjTn+Yrt6BUczjkqs6wsgV8
 gJ730FX1gSd0w6oQQO7xSTmFWlBcinaMhSSDftY003VgvHXJHkiNRIh9kV3ixi4h/Dw0ccffu+A
 n7Mg=
X-Gm-Gg: ASbGncsN2imeQRSTvGdyxBx/JFFo/Au+0OFAEJmv1vnsacB0LGNhLYVd/M70RSsxsmg
 pjvopAqILgSxYQCufkPYKOT7tbYR1yD9g2yu/TZB3MloSEkkMIzUiHwM2t9FbxFaVeS4CnczxIo
 QsVO4lwqoJQXfUa6Ritl8YGr2/cqpDd5LFrrUBLFNntJXdHYIbjfAh40gNRr2D7hwFChGW2pS6x
 j/IlzrXBKDvBlIGYa+EXKiT6Ox1ChLufMPV4Eittv9RbE3dcW3nucBisufPfNygraNzkjn6isVt
 F8DtKbQkaGd6fAqkbeL+k+TfZFATICCCPPuAjBiifV1gH7N41q7x/aLsaDHsquFOx1rUaqyUG6q
 6yuUmrnSNPYjoiqfGEz8=
X-Google-Smtp-Source: AGHT+IEshfpKkA6ikGZVQ2k/+H4mv6GdpJjA6UmTKWZ4vejNzlDt6uAN+kXZj1c8ZkU+E4m8Ki+8AQ==
X-Received: by 2002:a05:6000:2c6:b0:385:f249:c336 with SMTP id
 ffacd0b85a97d-3911f7c4703mr616891f8f.45.1741137760367; 
 Tue, 04 Mar 2025 17:22:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485dbe7sm19453481f8f.93.2025.03.04.17.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/41] hw/usb/hcd-xhci-pci: Adds property for disabling mapping
 in IRQ mode
Date: Wed,  5 Mar 2025 02:21:23 +0100
Message-ID: <20250305012157.96463-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This change addresses an edge case that trips up macOS guest drivers
for PCI based XHCI controllers. The guest driver would attempt to
schedule events to XHCI event rings 1 and 2 even when using PCI
pin-based interrupts. Interrupts would therefore be dropped, and events
only handled on timeout.

So, in addition to disabling interrupter mapping if numintrs is 1, a
callback is added to xhci to check whether interrupter mapping should be
enabled. The PCI XHCI device type now provides an implementation of
this callback if the new "conditional-intr-mapping" property is enabled.
(default: disabled) When enabled, interrupter mapping is only enabled
when MSI-X or MSI is active.

This means that when using pin-based interrupts, events are only
submitted to interrupter 0 regardless of selected target. This allows
the macOS guest drivers to work with the device in those configurations.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2705
Message-ID: <20241227121336.25838-6-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-pci.h |  1 +
 hw/usb/hcd-xhci.h     |  5 +++++
 hw/usb/hcd-xhci-pci.c | 24 ++++++++++++++++++++++++
 hw/usb/hcd-xhci.c     |  3 ++-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.h b/hw/usb/hcd-xhci-pci.h
index 08f70ce97cc..5b61ae84555 100644
--- a/hw/usb/hcd-xhci-pci.h
+++ b/hw/usb/hcd-xhci-pci.h
@@ -40,6 +40,7 @@ typedef struct XHCIPciState {
     XHCIState xhci;
     OnOffAuto msi;
     OnOffAuto msix;
+    bool conditional_intr_mapping;
 } XHCIPciState;
 
 #endif
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 9609b835141..9c3974f1489 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -193,6 +193,11 @@ typedef struct XHCIState {
     uint32_t max_pstreams_mask;
     void (*intr_update)(XHCIState *s, int n, bool enable);
     bool (*intr_raise)(XHCIState *s, int n, bool level);
+    /*
+     * Callback for special-casing interrupter mapping support. NULL for most
+     * implementations, for defaulting to enabled mapping unless numintrs == 1.
+     */
+    bool (*intr_mapping_supported)(XHCIState *s);
     DeviceState *hostOpaque;
 
     /* Operational Registers */
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 49642aab58e..d908eb787d3 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -82,6 +82,21 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     return false;
 }
 
+static bool xhci_pci_intr_mapping_conditional(XHCIState *xhci)
+{
+    XHCIPciState *s = container_of(xhci, XHCIPciState, xhci);
+    PCIDevice *pci_dev = PCI_DEVICE(s);
+
+    /*
+     * Implementation of the "conditional-intr-mapping" property, which only
+     * enables interrupter mapping if MSI or MSI-X is available and active.
+     * Forces all events onto interrupter/event ring 0 in pin-based IRQ mode.
+     * Provides compatibility with macOS guests on machine types where MSI(-X)
+     * is not available.
+     */
+    return msix_enabled(pci_dev) || msi_enabled(pci_dev);
+}
+
 static void xhci_pci_reset(DeviceState *dev)
 {
     XHCIPciState *s = XHCI_PCI(dev);
@@ -119,6 +134,9 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
     s->xhci.intr_update = xhci_pci_intr_update;
     s->xhci.intr_raise = xhci_pci_intr_raise;
+    if (s->conditional_intr_mapping) {
+        s->xhci.intr_mapping_supported = xhci_pci_intr_mapping_conditional;
+    }
     if (!qdev_realize(DEVICE(&s->xhci), NULL, errp)) {
         return;
     }
@@ -201,6 +219,8 @@ static void xhci_instance_init(Object *obj)
 static const Property xhci_pci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BOOL("conditional-intr-mapping", XHCIPciState,
+                     conditional_intr_mapping, false),
 };
 
 static void xhci_class_init(ObjectClass *klass, void *data)
@@ -215,6 +235,10 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->exit         = usb_xhci_pci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
     device_class_set_props(dc, xhci_pci_properties);
+    object_class_property_set_description(klass, "conditional-intr-mapping",
+        "When true, disables interrupter mapping for pin-based IRQ mode. "
+        "Intended to be used with guest drivers with questionable behaviour, "
+        "such as macOS's.");
 }
 
 static const TypeInfo xhci_pci_info = {
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 00d5bc37792..64c3a23b9b7 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -644,7 +644,8 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
     dma_addr_t erdp;
     unsigned int dp_idx;
 
-    if (xhci->numintrs == 1) {
+    if (xhci->numintrs == 1 ||
+        (xhci->intr_mapping_supported && !xhci->intr_mapping_supported(xhci))) {
         v = 0;
     }
 
-- 
2.47.1



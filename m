Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF833C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Wl-0003qG-Sf; Mon, 17 Jun 2024 03:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wk-0003q4-3g
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6Wi-00028P-E3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:11:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f1c4800easo494320666b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608298; x=1719213098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL+tD80S/5grtus7ELDC5qbksAsgVoY0z5aww6Z0nK4=;
 b=CSmR0PavGJObMMCtwZM8K1KxnPpyM66R9Ty7KfAVhlQkWaMhz1P5mXWn+uUoNvRKB9
 meoQWX6Vc/E5Ph69Gp+Ygo4EeAWDrNw0cuKXq8kE5fYV04/s5l2DDttJqoUfcJ8uBoO3
 w8nWyMwE0k2Iv1bhls2AX3nEEAkFgR+gdvqX9Bu7nL6WQDjI3RcSpvPrNa++nSbNQyyh
 9p2+St0hSz9fZo9S1QhcZc30thkkbIoW6h8R2U57HbiK/KR3qTH2+Gg7BM211v7r4Uae
 DelS+CiheAYutPrpWaXu3i/gCTgpBI62TYrxQrrYGgzufYquJgaOZVi0XpxDnMk+NT6n
 l4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608298; x=1719213098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL+tD80S/5grtus7ELDC5qbksAsgVoY0z5aww6Z0nK4=;
 b=BVr8vbdEJKK8t9ikTfKEpiIFRu3CrfZdOMVROZzN3TX7/76YIy7KNbKIHJMkxTSaF7
 DHLd5Q68NTBYvgqXh8wee5pDdf9GqwMqfMjT5hR2TnDLrCp4GdPEZrNTSlBEq2nAfZq8
 ucHVClZ/NqeTrmJsstUl7UT20HWrOhu7KM+u71kblPa5+aG8lVkOfxr0NwVa8pfHAPH2
 FdIuhJXDP1M25AfKNQPnstTwRgcrgysgEJAuMBa+XT8MFRAIkogCXUHU5epwuMqyyxpD
 +j51WcNA2Yr6Z2AgNDCnri634cpDntACgeeyC2XUAD1SebUCCzT/fYkj6TIlZD3bAGbW
 1tNQ==
X-Gm-Message-State: AOJu0Yx5kK9b34Gt0c0Jzg1qsezsaHk2y8gsfZyBWzyKFTM0BsvRYDw2
 sKvhX5tJO7m2mkPRZGbsH69LMJzlZJ3M/sXTVC0GDmUWHUye+0wrJDUBnrqdtYN71vzv+BBl6Sq
 U6z8=
X-Google-Smtp-Source: AGHT+IFC6uy2XYyQWlsDy8caIXDN1QzxZQHkZq49vPzfe9Gk2pPjU+wW0tz6ItIWUQaTpBaNNcTi+A==
X-Received: by 2002:a17:906:607:b0:a6f:39e3:3265 with SMTP id
 a640c23a62f3a-a6f60dc56ccmr556700866b.62.1718608297951; 
 Mon, 17 Jun 2024 00:11:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da4136sm487229166b.36.2024.06.17.00.11.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:11:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 03/23] hw/usb/hcd-xhci: Remove XHCI_FLAG_FORCE_PCIE_ENDCAP
 flag
Date: Mon, 17 Jun 2024 09:10:58 +0200
Message-ID: <20240617071118.60464-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

XHCI_FLAG_FORCE_PCIE_ENDCAP was only used by the
pc-i440fx-2.0 machine, which got removed. Remove it
and simplify usb_xhci_pci_realize().

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/usb/hcd-xhci.h     | 1 -
 hw/usb/hcd-xhci-nec.c | 2 --
 hw/usb/hcd-xhci-pci.c | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 98f598382a..1efa4858fb 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -37,7 +37,6 @@ typedef struct XHCIEPContext XHCIEPContext;
 
 enum xhci_flags {
     XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_FORCE_PCIE_ENDCAP,
     XHCI_FLAG_ENABLE_STREAMS,
 };
 
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 328e5bfe7c..5d5b069cf9 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -43,8 +43,6 @@ static Property nec_xhci_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("superspeed-ports-first", XHCINecState, flags,
                     XHCI_FLAG_SS_FIRST, true),
-    DEFINE_PROP_BIT("force-pcie-endcap", XHCINecState, flags,
-                    XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
     DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
     DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index 4423983308..cbad96f393 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -148,8 +148,7 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &s->xhci.mem);
 
-    if (pci_bus_is_express(pci_get_bus(dev)) ||
-        xhci_get_flag(&s->xhci, XHCI_FLAG_FORCE_PCIE_ENDCAP)) {
+    if (pci_bus_is_express(pci_get_bus(dev))) {
         ret = pcie_endpoint_cap_init(dev, 0xa0);
         assert(ret > 0);
     }
-- 
2.41.0



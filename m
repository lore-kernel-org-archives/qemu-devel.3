Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F98EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2E-0000KA-7w; Tue, 27 Feb 2024 03:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1u-0007rx-Mz
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:41 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1s-00087y-8O
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:38 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512d19e2cb8so5964325e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023291; x=1709628091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q16/BH7ujul6MroAh0WIw+sirhkolVXk4q/90kZo96k=;
 b=KTWu26fHP0wTOJh9MM66SSaXjjfeNYcssJKm9OSWZHqNZAil6Qb0M/dehxehj8c7aw
 58kKBDpE2WlaB0//H9n+slMzDotrqJz3xJCRlJheSXvhU0TqfLrfsA64/FQBdcZiCC3Z
 VtQIII2+EsKFnQL8Xa9otpAG4xevwNyHbLDwBV7wccmZEARUbC9SHIduRBJeUCtpGKbG
 AoEYMg6DGVnHKD2NtKv6CelvvMCz0eAGXTg6YbcA2FjKfBm3fKfaowQtGiSON3sP9Ukx
 XTEdoajbemzwaBkF8bztuHcBE5P7nZ5bY0E2euu9DOYffvndwOxcx4vAKPmfyLS9ziZ1
 VHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023291; x=1709628091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q16/BH7ujul6MroAh0WIw+sirhkolVXk4q/90kZo96k=;
 b=Ik40PbD+sj+OM1RI2RCq/2nWuNQOfPJvm27f2E3fNa1+B7FQYdcmpxYn/1khhhDhcM
 ymwsdoX6AkPMeTSLB+VObEUbBfgy05bKSnz0C1WgRsG2l4IvtzWu6L5s7LWeOfPi5SIm
 ASH6eMGEKHBi1EW3rkFwsB2CdM/3biqwMbXqdgKLRpRZTHSpsfKIDyD0dE1fBlKmE2FK
 wDgPoCZaTWO29jGP+G5WpFC8GsADWY0V8si/Rr65mhZHqS6d/OczQJGTmNDF8oitNtVO
 CoM607yPP3SBb+0fhzXToq5x3lNVP75dlzOyjrHfqNKu4l1YjoxajZr2TPolnXOXhmSQ
 EM5Q==
X-Gm-Message-State: AOJu0Yx6oD7VXDoAmCKK04kWBwamPLGTs5k+GVe3gF1HPgPGEgtCUApQ
 58Q/bBVQx6pHG8MOuIOI0D6kyik2D8qw0aCShLfxQ3q0zbnA+XmPc67h8Z2lgoq94+LSUh5CZIs
 P
X-Google-Smtp-Source: AGHT+IHg9w67z4u/F09JeatGg8K0Tbdq/enXZAp+R6BMkqVsRN1eOvEg9paicoiW2FsUDJTkyUHQyA==
X-Received: by 2002:ac2:424a:0:b0:512:8ac0:1f76 with SMTP id
 m10-20020ac2424a000000b005128ac01f76mr4813228lfl.66.1709023291132; 
 Tue, 27 Feb 2024 00:41:31 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 c18-20020ac24152000000b00512ab050435sm1121123lfi.100.2024.02.27.00.41.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 16/30] hw/ppc/pseries: do not require CONFIG_USB
Date: Tue, 27 Feb 2024 09:39:32 +0100
Message-ID: <20240227083948.5427-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

With --without-default-devices it is possible to build a binary that
does not include any USB host controller and therefore that does not
include the code guarded by CONFIG_USB.  While the simpler creation
functions such as usb_create_simple can be inlined, this is not true
of usb_bus_find().  Remove it, replacing it with a search of the single
USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-8-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 4 +++-
 hw/ppc/Kconfig | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d1c6d70d8d..55263f0815 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3024,8 +3024,10 @@ static void spapr_machine_init(MachineState *machine)
         }
 
         if (has_vga) {
-            USBBus *usb_bus = usb_bus_find(-1);
+            USBBus *usb_bus;
 
+            usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                              &error_abort));
             usb_create_simple(usb_bus, "usb-kbd");
             usb_create_simple(usb_bus, "usb-mouse");
         }
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index c5aeb6b3f2..b664d0eb37 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,5 +1,6 @@
 config PSERIES
     bool
+    imply USB_OHCI_PCI
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
-- 
2.41.0



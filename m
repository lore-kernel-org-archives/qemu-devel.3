Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2D5C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2F-0000SH-Fy; Tue, 27 Feb 2024 03:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret23-00084N-AR
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:47 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1j-00084N-Qc
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:46 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512cc3ea7a5so4084887e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023284; x=1709628084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrAS4uF/4VkX4b6o0R6cH2vfMrmpv4t1vXliE0xdsAk=;
 b=FaKhxFRvxohk1iXNJNWrC7T4XESLVOkiWWkvtOqwNvX3hVJXkD0p2SPGSBZa0mBTH4
 7lxorQMUKqRwN7fccSoVbxHnFcj2P6PRBMyHORZbq5m0vsjFVVDinzSEpk6CGA28GYeO
 vtN5/E5HjeLN4/CJwkynnrWM9l5bP1E9lGxH8lEK8td7hMN1ZZ0oBJ6ibH0Hd9thkQ/z
 2iLBW7x5Htv2E9fYBTn6ZH0uiosVZEn4qY4G1ZOInF8Hnf3CvgES7QmHlbEzizeN4ofG
 d2WdOy2OPttl/JIjJ9TulQJgYsxySll7HODvqad2W6vSkO2M453A6f2viZEmKNDuoh7L
 k1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023284; x=1709628084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrAS4uF/4VkX4b6o0R6cH2vfMrmpv4t1vXliE0xdsAk=;
 b=DLl02HKqtP92iBCwzkZ0fpLfFjKhAKZ+yIYOwHehxL08LizQPN8Ujz+HyopShhMXeV
 pAvRaFMsQvNGATJCspkkWBOrKhRpAQ9/pndYIafgsLG52ThjvoPVb1jVybR49GlJ7qLZ
 mITb7lWULCr5Vo283cPx2ye6EPU/edwl0R6eSvOW27mpyHtHdRWmlnoiTXTkMwiNy4SJ
 1aUZuoumXe0ci1QjBXYk7qYtQVYpxC+WfLhNs1rHy2la8WO2xtwRkQy0VxzlAdXmIhy/
 IHsnHPM4i3+MwBZbrSw6RBIakZ2Rh9cDFZDXUGwsLw3PEEKPRTD6XuuitBluYX3fyUaL
 BGbg==
X-Gm-Message-State: AOJu0YyV1lh07VEIQ/sq7PFwtGn3FVoHNyXuIZVqr7MdCRgX+mnBGb+6
 A68bjMOoI5tzOxD0zo9A9mcDGqbSD8bpT6/K6U8fKvuLjR/CfuJm4sqLjppB49JcSU5YrGdKwd/
 H
X-Google-Smtp-Source: AGHT+IGmzA352zWrHeoC7ubRalFfI4h0DhI58g+xJw81JMNJjqMdWvZENgLJH5fbFkVqSFZBaunTwA==
X-Received: by 2002:a05:6512:15a2:b0:512:ed89:7152 with SMTP id
 bp34-20020a05651215a200b00512ed897152mr6532027lfb.55.1709023284258; 
 Tue, 27 Feb 2024 00:41:24 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 o26-20020ac25b9a000000b00512e1361dacsm1112097lfn.299.2024.02.27.00.41.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 15/30] hw/ppc/mac_newworld: do not require CONFIG_USB
Date: Tue, 27 Feb 2024 09:39:31 +0100
Message-ID: <20240227083948.5427-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

With --without-default-devices it should not be required to have
devices in the binary that are removed by -nodefaults.  It should be
therefore possible to build a binary that does not include any USB
host controller or any of the code guarded by CONFIG_USB.  While the
simpler creation functions such as usb_create_simple can be inlined,
this is not true of usb_bus_find().  Remove it, replacing it with a
search of the single USB bus on the machine.

With this change, it is possible to change "select USB_OHCI_PCI" into
an "imply" directive.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240223124406.234509-7-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c | 4 +++-
 hw/ppc/Kconfig        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index b36dbaf2b6..3e796d2f6d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -431,8 +431,10 @@ static void ppc_core99_init(MachineState *machine)
         /* U3 needs to use USB for input because Linux doesn't support via-cuda
         on PPC64 */
         if (!has_adb || machine_arch == ARCH_MAC99_U3) {
-            USBBus *usb_bus = usb_bus_find(-1);
+            USBBus *usb_bus;
 
+            usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                              &error_abort));
             usb_create_simple(usb_bus, "usb-kbd");
             usb_create_simple(usb_bus, "usb-mouse");
         }
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index a890699082..c5aeb6b3f2 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -119,13 +119,13 @@ config MAC_NEWWORLD
     imply PCI_DEVICES
     imply SUNGEM
     imply TEST_DEVICES
+    imply USB_OHCI_PCI
     select ADB
     select MACIO
     select MACIO_GPIO
     select MAC_PMU
     select UNIN_PCI
     select FW_CFG_PPC
-    select USB_OHCI_PCI
 
 config E500
     bool
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989C6C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret21-0007u4-IK; Tue, 27 Feb 2024 03:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1c-0007U2-R0
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:21 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1X-0007yj-HG
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:19 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d21cdbc85bso62627591fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023271; x=1709628071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLHfM0e3DYucUBGQJ+x+1h4RF1QPnXlDRfnIizT5lrk=;
 b=y+f9hwJzX+n2Lg28oMAbyj+MKGZD5ToNb95fsT6Loz5OZod9gfoKn7tQWf/WQAgw//
 CO6LvhBtTuv23iZI1MJPEUYczT66Ym7bGTncFr+G/TBcJUst2yzQJt3qVA+9xd/T2GRH
 vOUDGfar+85ADxnLmDTA95ITbQaPc8B56equQLrDXtE2N1oI0Q1aQFkVH9Fy5pyvgBdX
 tvA8kHK15D4PY1VxUMpbbNPKAdg5GI92mC/Nr1XKsKvoy/eeEMeEn9bFMxVQvUAISF7Z
 wuYo/oIBU82XbtGNldbhaWQlghnaKcjBqQYq40zteHVM+rKBKxnp4+f2ixYT0iS/WY59
 S7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023271; x=1709628071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLHfM0e3DYucUBGQJ+x+1h4RF1QPnXlDRfnIizT5lrk=;
 b=RfMthKOsdjQMgcWj7QZwgg0NEGPDuc0uYCRW0KuEw0Qd3A/pxJcd1E+2e5B/YZ9042
 TNkBLb3i1+z24XDWn6owxT7aitwAMuYOk4Qr1PPj2qpXOVGhRxOUsgZcWryfjuSATTtL
 g8f9jCRtIel2lhW2jaZZgCXKSwGh5nEvLlbsLWXUBxIcfLS9YGs3Ee9EsXi+1bsHdBqD
 Rz3OSy7q6Tj+fahRO0I9j7EHT+wWGR+qqXW5fMc/cmMr7xodE557cn4YcR9QzPwMDlcD
 doBilUskT0QQREblmjCfYg3F+TYYYsqxef5XMXu6hHTEpSMV3CcqIp9RW4Qxj5gYqWVc
 NXmg==
X-Gm-Message-State: AOJu0Yy2OxPUcq65gcfXl17pv3TeUTBsRJp18nAn3fGL5uIFgoJFfgo3
 IIs2D5QF5zqfKnlVvzbmwPvj5rUNdfwAmTVVf2sWNTA3hg5dhEl/ScrW8BM7G4RpOD10kU31caY
 h
X-Google-Smtp-Source: AGHT+IGtyeEMCP0NS/yqy4ixkdyjU3NN1AxwsEFgT2vXa2DCiu4YYjC9N2Bp854rnk/rPTx01EVi8g==
X-Received: by 2002:a2e:9547:0:b0:2d0:f258:df02 with SMTP id
 t7-20020a2e9547000000b002d0f258df02mr4874682ljh.51.1709023271120; 
 Tue, 27 Feb 2024 00:41:11 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 s23-20020a2e81d7000000b002d29faf0466sm106051ljg.104.2024.02.27.00.41.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 13/30] hw/mips/loongson3_virt: do not require CONFIG_USB
Date: Tue, 27 Feb 2024 09:39:29 +0100
Message-ID: <20240227083948.5427-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Once the Kconfig for hw/mips is cleaned up, it will be possible to build a
binary that does not include any USB host controller and therefore that
does not include the code guarded by CONFIG_USB.  While the simpler
creation functions such as usb_create_simple can be inlined, this is not
true of usb_bus_find().  Remove it, replacing it with a search of the
single USB bus created by loongson3_virt_devices_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240223124406.234509-5-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index caedde2df0..b10a611a98 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -446,9 +446,13 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     pci_vga_init(pci_bus);
 
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
+        USBBus *usb_bus;
+
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                          &error_abort));
+        usb_create_simple(usb_bus, "usb-kbd");
+        usb_create_simple(usb_bus, "usb-tablet");
     }
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
-- 
2.41.0



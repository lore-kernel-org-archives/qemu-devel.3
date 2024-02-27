Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C85C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret1o-0007Wt-9h; Tue, 27 Feb 2024 03:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1X-0007Pq-OD
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:18 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret1P-0007xX-HV
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:41:12 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3e72ec566aso505139666b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023264; x=1709628064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHGNJ1XUlxhgdMpKga7hKHkmc9UPr7ny3TDpRoUFz4k=;
 b=ScGUZdQ+xhNJsXb9uZijJaVK7ZxRWmkvdWfUa5hpz5lg8ELpZqoI9pSpqp+tX2qkko
 0zUx8vv7IxOkCCLgmb6qYCcYvi5ge+roO+vZL9+oqspwXJ4doWXmLT59tdvts9v8OdrT
 mwXj1ymQxs1UQ/Clqfohsfz/9fDIdwVN4Sd48JFe7r/938fE6wwgQMur21XAmsHRj1EN
 escNXI0nlBDnM5G2TX0r5Uhd/8KdI9uuakmey+TGtLQ8uCHKevBeMB/Q/sPiXLRhfruv
 I4EHrUSXkfcHheJiLoxH7KhqlLvOgtAwJyLw5dPbLayt2k6NkO60neVZZK24IlP3WhaP
 lYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023264; x=1709628064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHGNJ1XUlxhgdMpKga7hKHkmc9UPr7ny3TDpRoUFz4k=;
 b=ScL5gXsUnWM/k1VJrgQ4D7YZXs/FGo7qMwRZpuWxwZ+WK0lUdVjCCvOFSCN+cWUKxj
 BPaDz3Ujgnz0B7YqIHYD09Clq797jElWsr9xMmmMtWWkAEVofS33XDqyIctjqHrRwxV/
 S73kpsWRgD+X+QCZOhlDf0UFhGe1ha7WL+esSDMIyK1R7yfkKPUHjTKV9YR6ltwXLNht
 pBD5TbJkTKGKbJeXrWB7DflNgz5WzymgQePtTo1i1vNLt3RBTLQbnepOSD7+zq0QnYVS
 fLW2ZM3YSfHBYrRFZ37PuGpJm3WjAdiL8AcMduSGwNTyWyQKQbRV6tH4Z/7Nuhz29fwC
 s4zQ==
X-Gm-Message-State: AOJu0Yw+Y2phVNl2jZCdAvP3CjeWm7etH1APKwT91XHPy0CembzT70Gq
 6TDcvcHpJMZN9WSjU4EXavc7pr2E0fk8VWEK/VEEZdvK/sHfyoqNEWNXvWkW0WwPtmacewcnsrD
 7
X-Google-Smtp-Source: AGHT+IG6YZ+TarG1eefUcbisnXuu9W8bdUaNMxsC3j10s6+mgL1Rx0WQC/S8yHTKAB81PRbS/Je+NA==
X-Received: by 2002:a17:906:7f89:b0:a43:5840:b8ac with SMTP id
 f9-20020a1709067f8900b00a435840b8acmr2968766ejr.42.1709023264502; 
 Tue, 27 Feb 2024 00:41:04 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 lt16-20020a170906fa9000b00a3d99415705sm538091ejb.73.2024.02.27.00.41.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PULL 12/30] hw/sh4/r2d: do not use usb_bus_find()
Date: Tue, 27 Feb 2024 09:39:28 +0100
Message-ID: <20240227083948.5427-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

usb_bus_find() is always used with argument -1; it can be replaced with
a search of the single USB bus on the machine.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240223124406.234509-4-pbonzini@redhat.com>
[PMD: Fixed style]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index c73e8f49b8..e5ac6751bd 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -244,6 +244,7 @@ static void r2d_init(MachineState *machine)
     SysBusDevice *busdev;
     MemoryRegion *address_space_mem = get_system_memory();
     PCIBus *pci_bus;
+    USBBus *usb_bus;
 
     cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
     env = &cpu->env;
@@ -312,7 +313,9 @@ static void r2d_init(MachineState *machine)
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* USB keyboard */
-    usb_create_simple(usb_bus_find(-1), "usb-kbd");
+    usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
+                                                      &error_abort));
+    usb_create_simple(usb_bus, "usb-kbd");
 
     /* Todo: register on board registers */
     memset(&boot_params, 0, sizeof(boot_params));
-- 
2.41.0



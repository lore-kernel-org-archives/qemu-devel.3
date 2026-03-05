Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB40AF513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGsx-000156-7B; Thu, 05 Mar 2026 17:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsp-0000zk-IO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsn-0002Dy-5Q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48374014a77so103425115e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748563; x=1773353363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zwrmPpb2MBMovII3IbF2clfBEwlzxPfQXORImB3zwE=;
 b=TNHES+mNy+TYV+BjU7et/XBvk7AduNXsJWLlau5XBo+uzkOgMQpkAsbKImUTiG+5Mw
 hS3KMfGf/HlfsuS+Ipx0A4S0QkKwNUYUmOyeNSw7lHN23Nfu1QXdf2JBsfJzVtfQE9ch
 91s0lhXqMF1+lP6/GTcZSViHDn9FqQdmCNjH6cqJ8ow5GY/xsK8SmF1xAU0lmgpKra5I
 zduS8IJ0bvW7hYIr78JR+SjL113rGPkY0EQ/UCBqqUn6tJNJ+qzVcMziLYzoX16IlqQU
 qDovT5NkpIS6wkVA5hkGJpDLIrW8rh/scUMvl2a5MDftTtMJqZoXyMzQMi4Cts/gTVQm
 JPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748563; x=1773353363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zwrmPpb2MBMovII3IbF2clfBEwlzxPfQXORImB3zwE=;
 b=e7y6jlMyny7CWq1JgLJZBAhTGmw6ULDTM4yJDELwh5a+XzPDRuNh1p6P4o+3nTeGPm
 atwnjrBK8n+xBaCS5i0+0ixGSeNwxwFQ+gS6+keVWITldSifXMd/qg5pX57cnGUFTpiF
 wOc6KTf5eWM21I6l/JJkPSGNM0Vc9aCAy4KGxYKngMWsjGOrjcY8PQQgktXiR+NY9ybn
 L+UXqzFs2VEJGdwTPLn+vy2tqJhOminVnFlhdLVMkqCl0dfvgHleHbFopDRbPhDxtj29
 h9FBe9vvK1oH5C2GSgCa/NRLwAwMbVwqQL+TFOP0uU3RXKeRH6gIDvCGIIzVP2dpUUyt
 yTqw==
X-Gm-Message-State: AOJu0Yykht02RcFyNdyowBYxFD9i+w3rR5HEtBHfySbH9LqQctsSnYuA
 A3Wu2B2k8Uwre3tERZ2qp7E0uTiLbE1zE9ofzvygt4tZ4RHy4/31mWNhvRQiNA==
X-Gm-Gg: ATEYQzwiQrq1ebH+t8zAJ7uUD5/KIpgSxCkOyZlM+sdX2MEbjc1saxj5W3YlpGj4KrU
 YNTcgz41nfTYVosbrDi+MZ0jWty8yHcXmRar9diSZeB6KCumx6KBDMzovC9dyyhm0PEtYHXjz+f
 UQO2aufBp2XEGUip+MIGwEqDgrKekC37rIds9hLyE+91tIdtIwVoZlfBZXYkF8tZvWl8y2FALbo
 nSI8LxQKARtlUgbUIfryrDvZ9v9657MSYN8HWa+rK99oqaVLIBLF1I3ryWf57cGHeY+ul2q8hU2
 yr/2ygVZvVxckdtj78hrP9PhYp5SUW0H9z8U22GuYCaZyrIqZvwCQOIiBLLWIXKCAKpq1U05YlT
 A+QBURqx7Rf9nhh61dn08E0fsrUZMtyhCJt0c8z0z6cGGkksDNYN+i7Hr5m5sboz7vUYKx8L2HB
 BcAHixXlyFD0AX4p19VwfBVtPD+A6Mf/h4EDwes9mqGZ1lDH5dOLRoQBxIyCHxnwnD7zpL2HQdQ
 ALY5FpZNBDncgYgswbCZWkptz9GKA344vOMPkNDzBjWkuL1iDcgXtLo/w==
X-Received: by 2002:a05:600c:a51:b0:47e:e20e:bbbe with SMTP id
 5b1f17b1804b1-48519889928mr122885855e9.25.1772748562947; 
 Thu, 05 Mar 2026 14:09:22 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:22 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 03/14] hw/arm/aspeed_ast27x0-{ssp,
 tsp}: Do not access SerialMM internals directly
Date: Thu,  5 Mar 2026 23:09:00 +0100
Message-ID: <20260305220911.131508-4-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SerialMM inherits from SysBusDevice and exposes the memory region by
means of sysbus_mmio_get_region(). Use that in order to avoid accessing
implementation details of SerialMM.

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 7 ++++---
 hw/arm/aspeed_ast27x0-tsp.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 9b12ba6743..8b84300e0f 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index e39d1dc171..e7c7b74491 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
+    MemoryRegion *mr;
     g_autofree char *sdram_name = NULL;
     int i;
 
@@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* UART */
-    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
-                             &s->uart->serial.io, 0,
-                             memory_region_size(&s->uart->serial.io));
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
+    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr, 0,
+                             memory_region_size(mr));
     memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
                                 &s->uart_alias);
     /*
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302BFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5yz-0005JD-R0; Sun, 12 Jan 2025 16:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yy-0005Im-H1
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5yw-0003m7-Uk
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:58:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so25956525e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719133; x=1737323933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhawxe7kLiUXklv8T3b+XEpZj2QiLlR+X7Tpyy5GJaE=;
 b=R8yfK8teJhnb7sWHLczVyFmitDUylbWV2rWVRv51XsC1oqA/VNNkHqVpkLHVbATEAz
 G9pDMHu2rBMO65QvOEJMiE8DSZt9x01Bp4Nn/NLJ95Z+xfBlDchR8BWz+dmHzHTA7Jt3
 dQz6zUdqm2BkfwM7q7J8rK2HC8hgqWs/XolSEOsWxa3s//K4oDet/w4IxY9QUf5hNw4O
 ZIl+MSTlAF9TcgoHg2TyR+WqXgpICCPz29PXzHFEGkjaJ+Hlfg7wrTRSNR/nWaNXctqn
 bDun8lwDwm7PIAkxNx+F0e2+H+/58FeCPSNl8d7dsonBdTa9rPSSLb5xUQQtpIPKhgWs
 jWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719133; x=1737323933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhawxe7kLiUXklv8T3b+XEpZj2QiLlR+X7Tpyy5GJaE=;
 b=cAc4D/hNd2iSHwtWk17P6Njqbb8nQI9O3hggiPjZ7q2P/X8iP7LniQjWYVozyyc9zv
 LgULDZRfbTDgMFQR+NiywKAOfrkQwS/zjgQE2P4Kgum6+dX0wmjo0qwBAnLHwcLniLzI
 WtkscjOWVAZDz59C7F7ZCjyA6NRhTe1mKPgyT3TdUug0k+RStnXqKlRHqxRLHvn5bNy9
 z1a3Ak681Nkqh4KTwbjcpHbb8MZwjTD4KKzgJLzPayYDfEU2hag02fDzlTP9kk05aBCe
 Wl1euk4kmEAT6TezNgbZv8IjRE72yleVj+sDeSg8wBr6qQLCdbUdTrtXCPuQKyZJfucE
 Zjag==
X-Gm-Message-State: AOJu0YwZo0bTeka7kcK1n8QoH7OXrn0WtBsKmQB6Rg/1uWbFF6qt/8kG
 hG9wdwpKlvjT2p40+VZXO6vUXKaoSpVnpCvbcP8nduHd+IqmPGNVtNkUko55nKrPRZLpZSRudZP
 HMIY=
X-Gm-Gg: ASbGncsuw/JD0iZXiOUH6RYSb+rDjQuAmj9X9gkQf1X8gzUoZ1jjvpYWTni3/+fUfle
 7uNZ+8K+M7FcB+PhmXFZ5onUEaySlqCSIj0EJwKPCJ+R1xY2Y6dBUOa66Vos8XkAL3Sw04xsQlp
 azhVyGnFjXUiH7264mnbO6YhUb1kpKlSYYMpMqrtDibV8+1XjPYJp5TGC6edf9pCXwWkaTC/UvY
 y7UvL0LbNFczvjAlllU/ZxLlUnBQDGXU7quWAiYONJsAcpypo+WtR0w4xeojQ3Y5FR45iSMJnZS
 kujujYlHrSxUJWvgb00Gme+9/UG4aHE=
X-Google-Smtp-Source: AGHT+IH2g4raouoi1cvfLl/orGkbtVC6BMYkntlWPt5DAksxXt+BYzVms0+VU0Ruz7TJi4HdYKm9Dw==
X-Received: by 2002:a05:6000:1a8d:b0:385:ed1e:2105 with SMTP id
 ffacd0b85a97d-38a8730ae10mr17016510f8f.26.1736719132532; 
 Sun, 12 Jan 2025 13:58:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm10731523f8f.30.2025.01.12.13.58.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:58:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 03/11] hw/mips/loongson3_virt: Have fw_conf_init() access
 local loaderparams
Date: Sun, 12 Jan 2025 22:58:27 +0100
Message-ID: <20250112215835.29320-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

'loaderparams' is declared statically. Let fw_conf_init()
access its 'cpu_freq' and 'ram_size' fields.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4b19941c1dc..032ff92383e 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -280,7 +280,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
-static void fw_conf_init(unsigned long ram_size)
+static void fw_conf_init(void)
 {
     static const uint8_t suspend[6] = {128, 0, 0, 129, 128, 128};
     FWCfgState *fw_cfg;
@@ -289,9 +289,9 @@ static void fw_conf_init(unsigned long ram_size)
     fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
-    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq_hz());
+    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, loaderparams.cpu_freq);
 
     fw_cfg_add_file(fw_cfg, "etc/system-states",
                     g_memdup2(suspend, sizeof(suspend)), sizeof(suspend));
@@ -635,9 +635,9 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * Please use -L to set the BIOS path and -bios to set bios name.
      */
 
+    loaderparams.cpu_freq = get_cpu_freq_hz();
+    loaderparams.ram_size = ram_size;
     if (kernel_filename) {
-        loaderparams.cpu_freq = get_cpu_freq_hz();
-        loaderparams.ram_size = ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
@@ -663,7 +663,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
             exit(1);
         }
 
-        fw_conf_init(ram_size);
+        fw_conf_init();
     }
 
     loongson3_virt_devices_init(machine, liointc);
-- 
2.47.1



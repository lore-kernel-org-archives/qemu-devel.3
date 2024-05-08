Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD010C25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lMk-0000PK-0n; Wed, 08 May 2024 13:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMD-0000Kz-6q
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:34 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMB-0007Kc-Bj
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:45:32 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59ad344f7dso2301066b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190329; x=1715795129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OH+OdSI3NRi6kwuyf3vIVlVnfRZUW2MUDqdsivDFuU=;
 b=pE8Tg3XzkDRBNFc/Gbh6fHTM/R5yf5Bz3y02Sz75FzBChxpvmgD3koGUjqvRqAFVU4
 AwcLKl6sFriFUkuWHL/+zsMOLU1g5+KSAJzn6+S8wAbsidilNTE4KYVDfVLLxIXhD6FW
 G9FnLjlbgu2qej2vbONp0aqFTpOMAHfiCjvxy62EiTfocjGNQ5XnoNZLYtEREeGpNjAG
 7Fmhs40Lw6O/st8GBP8h76fbWntzuxCIbFUJel2RGJNL2UQFNxzRe1jN2AjgR1kIoe+q
 gxjuwJ9PwKXXxC8zhPBrYG3NFZUeMRzuror701smBBmUyqGg41g2WezHECXkXj+t0n70
 61kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190329; x=1715795129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OH+OdSI3NRi6kwuyf3vIVlVnfRZUW2MUDqdsivDFuU=;
 b=qk7Z14NBS9/TAbdWIp4z+kx8/8lI8IfsikIneVXTxIlXBE/J6OI04ZPEF9xA6Xt5jD
 rCcQGOAZMR6s3zioNGcTHddbC4nLQ55RgKsEcrf7twIPyE5RZJjpEnGYNdTuZhEve9/Q
 ZOmu9WyUMWzFd5yhmbPdFM0x1OmQoSoPCFXZi2h407bUajVOeCdvI0Z6EJSGCqD9cu7h
 SuGu+UP47FZhOWEjsWxqTkds8q82KQyxRRWxuoVR1iETfO1MmLNJ6gHnmQtI3TX1orZB
 v+jKuN7k9Gfo9/nh+I+dPe8IcxoxewarLXa6j7ce0XR/NFYosy5tEh9lMEbZwjjOEkGM
 1RBw==
X-Gm-Message-State: AOJu0YzuVNizcE6KrQwUjlh2vnbWsvTNuZk7Gox91e8Em6Ygkbwr0WWY
 DtM/vvvsD4gCWJVGIYsLQKnuV9Qvsqp0qZ4SE8ABrI7blDtcgslebF+Ydfb+Jp+gJtAGsSdROmX
 h
X-Google-Smtp-Source: AGHT+IFiXTQ3xsWokvC+U2OW2s2TLDWVueDDmiEoj8wM4ynYT11xOqgmWHh7sZ+QSRNXfazggVIilg==
X-Received: by 2002:a17:906:c802:b0:a59:9a68:7327 with SMTP id
 a640c23a62f3a-a59fb9ce261mr175867066b.54.1715190329529; 
 Wed, 08 May 2024 10:45:29 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 g17-20020a170906395100b00a59c3db0c50sm4608038eje.199.2024.05.08.10.45.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:45:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/26] hw/hppa/machine: Replace g_memdup() by g_memdup2()
Date: Wed,  8 May 2024 19:44:47 +0200
Message-ID: <20240508174510.60470-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Per https://discourse.gnome.org/t/port-your-module-from-g-memdup-to-g-memdup2-now/5538

  The old API took the size of the memory to duplicate as a guint,
  whereas most memory functions take memory sizes as a gsize. This
  made it easy to accidentally pass a gsize to g_memdup(). For large
  values, that would lead to a silent truncation of the size from 64
  to 32 bits, and result in a heap area being returned which is
  significantly smaller than what the caller expects. This can likely
  be exploited in various modules to cause a heap buffer overflow.

Replace g_memdup() by the safer g_memdup2() wrapper.

Trivially safe because the argument was directly from sizeof.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20210903174510.751630-12-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 37ee6387e0..5d0a8739de 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -207,37 +207,37 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
 
     val = cpu_to_le64(MIN_SEABIOS_HPPA_VERSION);
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     val = cpu_to_le64(HPPA_TLB_ENTRIES - btlb_entries);
     fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     val = cpu_to_le64(btlb_entries);
     fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     len = strlen(mc->name) + 1;
     fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
-                    g_memdup(mc->name, len), len);
+                    g_memdup2(mc->name, len), len);
 
     val = cpu_to_le64(soft_power_reg);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     val = cpu_to_le64(CPU_HPA + 16);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/rtc-addr",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     val = cpu_to_le64(CPU_HPA + 24);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
-                    g_memdup(&val, sizeof(val)), sizeof(val));
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
 
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_config.order[0]);
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 
     fw_cfg_add_file(fw_cfg, "/etc/qemu-version",
-                    g_memdup(qemu_version, sizeof(qemu_version)),
+                    g_memdup2(qemu_version, sizeof(qemu_version)),
                     sizeof(qemu_version));
 
     fw_cfg_add_extra_pci_roots(pci_bus, fw_cfg);
-- 
2.41.0



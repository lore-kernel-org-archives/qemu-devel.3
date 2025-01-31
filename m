Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C053C02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyCy-00062k-OW; Fri, 31 Jan 2025 16:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCv-00062G-6K
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:46 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCt-0007nL-IW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso17367705e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357542; x=1738962342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujxDD2sHsagbBA/qRpPrMUaFSLbGQVTGtRFXtuxkUAM=;
 b=T8CX0MkrL3GXGVl4pGvB6YjFglnNqRqc6OiV7V5EdGuTNZAtp+u3471qYB2Ar4XlLK
 GSKP7MEP73jV36sBONqUtW8Fqo75HT2snF4NmPqzskkD1OcmkHZO/kFGTJHkzqn7fS7Z
 kQuLaxhZQISty1RXOGUF74T1VKN4GjEJWmUuP4vYG0/211G3ATRTJw3+6W/+9uSS6+Nd
 3Q7G9OdRjPZZHunGAUL5qLUUcjQrYW5mxZEO5RUkL4cqF+sm6J0SJ4CPS6DkWkXlhrNC
 8h4moXvI+ahqyn8hvMZenIxIcbuX7rytCLwqRvfc/QsrDAj/JGfLwMOgBYeWFwQ1EzoB
 CMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357542; x=1738962342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujxDD2sHsagbBA/qRpPrMUaFSLbGQVTGtRFXtuxkUAM=;
 b=nZRmuOg1iY4IFpOz9i2bvEg626uxQhzqIn+mO/afoqEFBKz4okP3PTuG56Axyae91P
 Bn7sVrHIpBsQALUy61i82yZg3uqr4TkcW3qhbk8hilHzWh/xshkAh/ajhD/B2ANKqVPJ
 rL5UBZDJkpM5te1Pn3cjN3J3cWig5FKTxhtbm6vV4YsWteqZ4A2Y2j+Nl0BtJXobesP/
 CSIJgjah+DW0yanJ1xXAyPpLWwBxNlH/sjdS0J/dgcmu2N0Ts4uXFdGHG5fT0T5IKsdP
 bbkJBk3T/j2mODhxxuKBVKZYU0wuTm1mo6bK7jxml2N+XmRB7TqM3bLZG5CQhbDAbTEd
 jY4Q==
X-Gm-Message-State: AOJu0Yy7hhhLhrF/yRJpokJXam8qiYXuN1vqykvtacYxsLUU1v0z/7HK
 BKnPyYDdncpUR9ZwY3wPMOi0ipEeiZb+Y8ypQjwxwAuhL4lZl6scWDh5Fs3XNgEWESGOdqLGjrB
 CBQ8=
X-Gm-Gg: ASbGncueXdnz7Wqnt42R1l6HJAioO3MK8nJDHpHlz85hrW7Y8cKHeYGMesi8txmxjFH
 Nn/bfNrwKRDf7jkKp9ptgG37bS/43ZTho1k/9G7fYMpn9QluyEA+tO8tIho4z/acvGNRtIXvz1W
 nPzPTndLIwgFOl5pl+pjNarZ6W2E6Jg+6jOQDz4lyobGu1NAGpOqwSfb80iEw2f4FhiNaUs4bjk
 5TjmasiSHfoveweW+byVcCQ4AC6Um3pErRw7TLvTa2TRi96eO1xhphdzOSNKFMF5IIwtpSxcdlO
 m23pw5oG0CEQC0q+x7adX08Y2KeL/8V7TmGZVND54pfUIrixaW24FDr3yNLZLmySKQ==
X-Google-Smtp-Source: AGHT+IHMgG6vDUt+qINylqb6d84sYOjuWDM5FymNdsgcOLg4QuglJSA2afVDJ6PsYejo+rn/Q2fr+g==
X-Received: by 2002:a05:6000:1849:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-38c52097553mr11435996f8f.49.1738357541694; 
 Fri, 31 Jan 2025 13:05:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2e239sm100925545e9.18.2025.01.31.13.05.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/36] hw/mips/loongson3_virt: Have fw_conf_init() access local
 loaderparams
Date: Fri, 31 Jan 2025 22:04:47 +0100
Message-ID: <20250131210520.85874-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-4-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 28d4eaf1e59..45a524cca89 100644
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
@@ -633,9 +633,9 @@ static void mips_loongson3_virt_init(MachineState *machine)
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
@@ -661,7 +661,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
             exit(1);
         }
 
-        fw_conf_init(ram_size);
+        fw_conf_init();
     }
 
     loongson3_virt_devices_init(machine, liointc);
-- 
2.47.1



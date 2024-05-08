Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173C6C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lO4-00040J-AQ; Wed, 08 May 2024 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNt-0003aV-FV
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:19 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNq-0000ho-L5
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so207222466b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190432; x=1715795232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtqJ/HpVTKlat1filTS1A2oaNsIBTtDSWzDDsWKSNIM=;
 b=cqA4pbQuySvqH9/N0uaqeHCLIPf1X9tjNJrsxqIkAMmltNG2JXC32oh0f3HSxYUUv7
 GCAfTmQ0Dmv6lOW0sYtMl1an2ozJqI7Pxe8AUWXSl5yvtJxYL3keQX5WYoFteZYALZY5
 0+Ldhu+IHXxQ8X6o/4NcWumgUbJghcor3sUg+o2hJU4OPEFDdc1elZZkAsYwlZIdsWnu
 FrW9qjz3irkiNCaHx2EXM7hsseJu1VS1sn1L5r+TyAcYblsJ7QMOt1A1uGdzUOC3UoFK
 oATCIolrArlJ1FqAz4LAycrxquAFZgahTkbM/4xSbwf4j06gog5H4I8Rs5MBl5JPowhN
 r7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190432; x=1715795232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtqJ/HpVTKlat1filTS1A2oaNsIBTtDSWzDDsWKSNIM=;
 b=L9qMUq8Yv6jmawywzIvKCCoqTvFC/+SdxUweq2Ps5KkjoVXXEsBJ3Mj7rEqsat86m2
 sGlCkHwtHnh6m06UkQHWlCYOSgtHjAg/nMJpRx44ZwaUC7HVPIbB3MC/AfLkbfNqt3xX
 gayb/NpnSrjhETNFAFPrMU7PDevdKTLZGKWTrqmgH3/SRKHoypKxSSDPWWybcOAZXM7N
 j/AyC54V2O+3Dky7/N+zV5q6a5iXBgEI4FTcg2KZQEl1/BtaHiq46SUTB64uu1GbMAYE
 miVodEA1IbjHW9vsqXdg0yUA+XjsTQ0NDejEJg+HXJ2uRlP2809WLW5KY+jAvHOZRRyp
 dUTQ==
X-Gm-Message-State: AOJu0YwvTlb/l+6/p5dHzMwA4pC4o42Q4sMZDiMUHJaNfXomkwjEzH9U
 wDZ2tk7zhWSq7BJcN8KvZbKIJA8u5OX/vt76ngtKiuLs94Ot8Xg3Cl3sL28Hej0620+b/jFLcRE
 q
X-Google-Smtp-Source: AGHT+IH4P0DMaCD7q38szteqC+S2ARW6D8EJMvnwI+EKI7jPSa49h+o/OOvITzYE5daOe+zTPiN/0w==
X-Received: by 2002:a17:906:2bd3:b0:a59:a1b1:2978 with SMTP id
 a640c23a62f3a-a5a116ece99mr27068166b.20.1715190432235; 
 Wed, 08 May 2024 10:47:12 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 g23-20020a1709067c5700b00a5a0b34110dsm560178ejp.1.2024.05.08.10.47.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/26] hw/mips/loongson3_virt: Emulate suspend function
Date: Wed,  8 May 2024 19:45:06 +0200
Message-ID: <20240508174510.60470-23-philmd@linaro.org>
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Suspend function is emulated as what hardware actually do.
Doorbell register fields are updates to include suspend value,
suspend vector is encoded in firmware blob and fw_cfg is updated
to include S3 bits as what x86 did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
[PMD: Use g_memdup2(), constify suspend array]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.c |  1 +
 hw/mips/loongson3_virt.c  | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index f99af22932..03a10b63c1 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -148,4 +148,5 @@ void init_reset_system(struct efi_reset_system_t *reset)
     reset->Shutdown = cpu_to_le64(0xffffffffbfc000a8);
     reset->ResetCold = cpu_to_le64(0xffffffffbfc00080);
     reset->ResetWarm = cpu_to_le64(0xffffffffbfc00080);
+    reset->DoSuspend = cpu_to_le64(0xffffffffbfc000d0);
 }
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index b10a611a98..440268a074 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -127,6 +127,9 @@ static void loongson3_pm_write(void *opaque, hwaddr addr,
     case 0x00:
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return;
+    case 0x01:
+        qemu_system_suspend_request();
+        return;
     case 0xff:
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         return;
@@ -250,6 +253,17 @@ static void init_boot_rom(void)
         0x240D00FF,   /* li      t1, 0xff                                     */
         0xA18D0000,   /* sb      t1, (t0)                                     */
         0x1000FFFF,   /* 1:  b   1b                                           */
+        0x00000000,   /* nop                                                  */
+                      /* Suspend                                              */
+        0x3C0C9000,   /* dli     t0, 0x9000000010080010                       */
+        0x358C0000,
+        0x000C6438,
+        0x358C1008,
+        0x000C6438,
+        0x358C0010,
+        0x240D0001,   /* li      t1, 0x01                                     */
+        0xA18D0000,   /* sb      t1, (t0)                                     */
+        0x03e00008,   /* jr      ra                                           */
         0x00000000    /* nop                                                  */
     };
 
@@ -265,6 +279,7 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
 
 static void fw_conf_init(unsigned long ram_size)
 {
+    static const uint8_t suspend[6] = {128, 0, 0, 129, 128, 128};
     FWCfgState *fw_cfg;
     hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
 
@@ -274,6 +289,10 @@ static void fw_conf_init(unsigned long ram_size)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
     fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq_hz());
+
+    fw_cfg_add_file(fw_cfg, "etc/system-states",
+                    g_memdup2(suspend, sizeof(suspend)), sizeof(suspend));
+
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
@@ -553,6 +572,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                            machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
     memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
                            NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
+    qemu_register_wakeup_support();
 
     memory_region_add_subregion(address_space_mem,
                       virt_memmap[VIRT_LOWMEM].base, ram);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB7f-0007kb-1s; Fri, 13 Dec 2024 14:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB72-0006ID-Ek
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:08 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6v-0007W2-8S
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:07 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29ff039dab2so1026455fac.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117240; x=1734722040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFwnVaMVK9pfiO5zNGncf7wC5DNSQZHLJ7Ggx4d/5SQ=;
 b=sKnlxahX6wqEJSFG+WnvlZQUoJWj744b+1YJAqBpY08GBHLUHnB2YDrMTpNMT257/B
 Hohe6oxbUDraKwcrTFUWedkiDgN20miNn04AJ8SZ/yt3gZhrwPM+FgOKFWl9i2i0P7u/
 1Ypp5SXVMWjKNhmkzKQm0brP/ys1vY3yBVS9vqIN3Z7//r5SbfYOZkQiFe70+o0HxJ7K
 cGXcidnw5A2plafY6Slb6T1L8ddn1v0WWvqUjuG+mKfD68lgUZtYYc+UucLD0gT3SjJT
 vYWB4ETPL4KrxVqq6e/cLUthj8/wg/adKdG16hwQ+HnKzqnOBYJqn+oLe83Ts/TWSPqQ
 /Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117240; x=1734722040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFwnVaMVK9pfiO5zNGncf7wC5DNSQZHLJ7Ggx4d/5SQ=;
 b=OG6PI9YnJWwm5Vkkp7D1OkolZLzbePdrTbPWlB6f80AYaS20QPwWRxh2hpKWaMEP8I
 GIJ6fEFBhrr896D0tPF60nN/d6FmnNMqysHW6I/r7hYeIQkAgrVzI3KYxbvt6Mp1IGnY
 7vf09VA7XbBH7bGAS3k5TYlkWNmFO04JrETL2oPfwGtZsUbAq6LfA3FBj9HPMk6EXxve
 pvehnZdt1D4X/ChQcP61yRIXDK74MoD3zZilssgmOvU2Fmks+RJJgG8eoyOKYwS/q8kJ
 aFIz9pSQqZoA3lGjCZvOHX+BiIs5oOUAo7Vs0RfOl7GofS7aLyeFZDADRgt+D2jRrUxt
 wZSQ==
X-Gm-Message-State: AOJu0YwJAw6OuHAgey2FMyPFo4jdZsMvJCMZzj36Qa6aYJBBgro7PV4f
 QSimROsCRkrVXfsqWoe7+5gVKpGmNAVvaRaeDCzuCSKtWJxzwrTimh8mfrr9wFlpSYH8RJgn/BN
 dVvCPgtbC
X-Gm-Gg: ASbGncuagcM7tXM0KVWArAOj8Wk5Y9jbFjpWGuOfhzA6wSk/GOVnQB4Mmw48p9HQ8pl
 FHMBlm+NItxhQjM1X3J7lPRN2tanotGU42nJ7iDTfVgVfOpvC0Ze1857yODxex8vFgi6RuzXx56
 ia3tmo0EUHfIpRHYK7rwqSVMrEJ8vv/QnSDR/6ACS7l88OuS2Gv6MzR+OE9rlMT7tdhp1KZm00F
 fEwnTOjS0EFOgVAsGCh71gcT3eZbc4ito8YBDUEiTb9fqSeMGYNv8+MocDqtCib
X-Google-Smtp-Source: AGHT+IGqbJHKwR3XfiX8fkYpkN766Cseq6zg4jbpalzyWy9fydQG4CS8AxMkLM3yrrvqR9RZLM/PMA==
X-Received: by 2002:a05:6808:1596:b0:3ea:37a7:394 with SMTP id
 5614622812f47-3eba6955bd8mr1970139b6e.34.1734117240023; 
 Fri, 13 Dec 2024 11:14:00 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org (open list:New World (mac99)),
 qemu-arm@nongnu.org (open list:NRF51)
Subject: [PATCH 44/71] hw/nvram: Constify all Property
Date: Fri, 13 Dec 2024 13:07:18 -0600
Message-ID: <20241213190750.2513964-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nvram/ds1225y.c                 | 2 +-
 hw/nvram/eeprom_at24c.c            | 2 +-
 hw/nvram/fw_cfg.c                  | 6 +++---
 hw/nvram/mac_nvram.c               | 2 +-
 hw/nvram/nrf51_nvm.c               | 2 +-
 hw/nvram/spapr_nvram.c             | 2 +-
 hw/nvram/xlnx-bbram.c              | 2 +-
 hw/nvram/xlnx-efuse.c              | 2 +-
 hw/nvram/xlnx-versal-efuse-cache.c | 2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c  | 2 +-
 hw/nvram/xlnx-zynqmp-efuse.c       | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 6d510dcc68..19bf8d2091 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -142,7 +142,7 @@ static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
     nvram_post_load(s, 0);
 }
 
-static Property nvram_sysbus_properties[] = {
+static const Property nvram_sysbus_properties[] = {
     DEFINE_PROP_UINT32("size", SysBusNvRamState, nvram.chip_size, 0x2000),
     DEFINE_PROP_STRING("filename", SysBusNvRamState, nvram.filename),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index ec748e58e7..669920b2b9 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -234,7 +234,7 @@ void at24c_eeprom_reset(DeviceState *state)
     ee->haveaddr = 0;
 }
 
-static Property at24c_eeprom_props[] = {
+static const Property at24c_eeprom_props[] = {
     DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
     DEFINE_PROP_UINT8("address-size", EEPROMState, asize, 0),
     DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b644577734..fe73a2c1ef 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1103,7 +1103,7 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
 
-static Property fw_cfg_properties[] = {
+static const Property fw_cfg_properties[] = {
     DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1294,7 +1294,7 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
     s->entry_order = g_new0(int, fw_cfg_max_entry(s));
 }
 
-static Property fw_cfg_io_properties[] = {
+static const Property fw_cfg_io_properties[] = {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
@@ -1343,7 +1343,7 @@ static const TypeInfo fw_cfg_io_info = {
 };
 
 
-static Property fw_cfg_mem_properties[] = {
+static const Property fw_cfg_mem_properties[] = {
     DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
                      true),
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index e47e52a677..d62ad719c8 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -134,7 +134,7 @@ static void macio_nvram_unrealizefn(DeviceState *dev)
     g_free(s->data);
 }
 
-static Property macio_nvram_properties[] = {
+static const Property macio_nvram_properties[] = {
     DEFINE_PROP_UINT32("size", MacIONVRAMState, size, 0),
     DEFINE_PROP_UINT32("it_shift", MacIONVRAMState, it_shift, 0),
     DEFINE_PROP_DRIVE("drive", MacIONVRAMState, blk),
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index b1f81752a3..236049462b 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -354,7 +354,7 @@ static void nrf51_nvm_reset(DeviceState *dev)
     memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
 }
 
-static Property nrf51_nvm_properties[] = {
+static const Property nrf51_nvm_properties[] = {
     DEFINE_PROP_UINT32("flash-size", NRF51NVMState, flash_size, 0x40000),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bfd8aa367e..2251ff2f4c 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_spapr_nvram = {
     },
 };
 
-static Property spapr_nvram_properties[] = {
+static const Property spapr_nvram_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprNvram, sdev),
     DEFINE_PROP_DRIVE("drive", SpaprNvram, blk),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 1bc58e90ad..4fa528f048 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -520,7 +520,7 @@ static const VMStateDescription vmstate_bbram_ctrl = {
     }
 };
 
-static Property bbram_ctrl_props[] = {
+static const Property bbram_ctrl_props[] = {
     DEFINE_PROP("drive", XlnxBBRam, blk, bbram_prop_drive, BlockBackend *),
     DEFINE_PROP_UINT32("crc-zpads", XlnxBBRam, crc_zpads, 1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index f7b849f7de..5dae9e8e9a 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -265,7 +265,7 @@ static const PropertyInfo efuse_prop_drive = {
     .release = efuse_prop_release_drive,
 };
 
-static Property efuse_properties[] = {
+static const Property efuse_properties[] = {
     DEFINE_PROP("drive", XlnxEFuse, blk, efuse_prop_drive, BlockBackend *),
     DEFINE_PROP_UINT8("efuse-nr", XlnxEFuse, efuse_nr, 3),
     DEFINE_PROP_UINT32("efuse-size", XlnxEFuse, efuse_size, 64 * 32),
diff --git a/hw/nvram/xlnx-versal-efuse-cache.c b/hw/nvram/xlnx-versal-efuse-cache.c
index eaec64d785..1aea27afd3 100644
--- a/hw/nvram/xlnx-versal-efuse-cache.c
+++ b/hw/nvram/xlnx-versal-efuse-cache.c
@@ -83,7 +83,7 @@ static void efuse_cache_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property efuse_cache_props[] = {
+static const Property efuse_cache_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxVersalEFuseCache, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 8252a5cabe..599aa126fb 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -743,7 +743,7 @@ static const VMStateDescription vmstate_efuse_ctrl = {
     }
 };
 
-static Property efuse_ctrl_props[] = {
+static const Property efuse_ctrl_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxVersalEFuseCtrl, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 4e2d1b9d1e..af53187905 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -833,7 +833,7 @@ static const VMStateDescription vmstate_efuse = {
     }
 };
 
-static Property zynqmp_efuse_props[] = {
+static const Property zynqmp_efuse_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxZynqMPEFuse, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
-- 
2.43.0



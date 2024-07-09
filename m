Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF23C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCkl-0001W1-Vs; Tue, 09 Jul 2024 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkj-0001IY-AC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkh-0006SF-CM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso37251885e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538852; x=1721143652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9uxsmCdFdNFYJS/BApUCrJ5ayaONfYjrqqyp7Nd2Kk=;
 b=DrscL89fF8J5/9XZLjKneAKdukn+47qS33xmqionyZeilCJUhXrVKuYW1+eG69wV8Y
 zMfcGO5ZhWujkXifkSx+yXxV6jDcD1Ijs83Pjy3+8qHoLNJSshJGbXVrxuUs3e5kYHtz
 uP+dGkPUe9Lifkg74PPy1eu62f0aiwyJe1n0b623eRiASPe+O1w+9+4z+ko43s8irVBX
 H9HcGI0z0rHuJegHi/VEuTYYhGYj7DD4u+ibr1OgizuFFG4lbCVr/yXAZtmMvnoMSCcn
 zSLemHTIbv9Secu31ssVi1wCsHCYIR9fiB1OV5C52kaWWUh+JoED6iZka6sihQNtMqpJ
 0JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538852; x=1721143652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9uxsmCdFdNFYJS/BApUCrJ5ayaONfYjrqqyp7Nd2Kk=;
 b=RCYlZBX7J5NctmDIwxup5vF52Okwy1Gyf9zuvOuPcxSvYQCKFJrf1CvA5FHPFlkP5I
 zEp8BlpHs7dErX6jLp6EkWbbQqX+85kY2J5bwNGDV4M+peKLg+CfbvYwcyxauIfmX1Rx
 gLHsYjT8iz7BY3C+gFcOvaS2pqH/W56TMtBgIu/AGLKFRPWQiWyRsyG82czMR+7Evo0R
 Z9fvSvQeYqEyypoksV/ZO9CJNB6bDQwsMTiIEdaX64aAes01rThqzyy1ODVEMStH2Oxn
 E5K6MYMBqDox4RfrKvWJMLtMAPOqv77r0Tam0+4vinTDU13KnCgrc8NlypffJiNlUIYl
 kiFg==
X-Gm-Message-State: AOJu0YwYIjoRgps8lHMo8iLfNLdd3jY5K4hxqf8NhD9g5h74rLSOWSmZ
 Umni26uFUAn7Zeeu55OAUuMr3YX6YUY/2Z7AaAl9rvC/KcihIl0MFgty6RAAZalhL0mjS/QGnQk
 m
X-Google-Smtp-Source: AGHT+IG4ruetcFzXiBq/2dXI9M9rrE2v/u03PkeUeT/cCHNWC7TAgNWhJPaZtZ5Q36FNAaIr85TT8g==
X-Received: by 2002:a05:600c:2207:b0:426:5b3b:88b0 with SMTP id
 5b1f17b1804b1-426707db78fmr18982815e9.14.1720538852166; 
 Tue, 09 Jul 2024 08:27:32 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fca8bsm212580165e9.47.2024.07.09.08.27.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [PATCH v47 15/19] hw/sd/sdcard: Implement eMMC 'boot-mode'
Date: Tue,  9 Jul 2024 17:25:52 +0200
Message-ID: <20240709152556.52896-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Spec v4.3 chapter 7.2.2 "Boot operation":

  If the CMD line is held LOW for 74 clock cycles and more
  after power-up before the first command is issued, the
  slave recognizes that boot mode is being initiated and
  starts preparing boot data internally.

Track uptime since last reset, add the sd_uptime_ns() helper.

When the first command is received, check at least 74 clocks
are elapsed (during the identification phase, at a 10kHz rate)
then enable BOOT_MODE in the Ext_CSD register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c         | 38 ++++++++++++++++++++++++++++++++++++++
 hw/sd/trace-events |  1 +
 2 files changed, 39 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index beb8e2730a..c7f8ea11c1 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -163,6 +163,8 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+    int64_t reset_time_ns;
+    uint32_t cmd_count;
 
     uint64_t data_start;
     uint32_t data_offset;
@@ -352,6 +354,11 @@ static uint8_t sd_crc7(const void *message, size_t width)
     return shift_reg;
 }
 
+static int64_t sd_uptime_ns(SDState *sd)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sd->reset_time_ns;
+}
+
 /* Operation Conditions register */
 
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
@@ -479,6 +486,10 @@ static void emmc_set_cid(SDState *sd)
 #define CMULT_SHIFT     9        /* 512 times HWBLOCK_SIZE */
 #define WPGROUP_SIZE    (1 << (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT))
 
+#define OD_FREQ_MIN_HZ   10000
+#define OD_FREQ_MAX_HZ  400000
+#define BOOT_MODE_DELAY_CYCLES_MIN 74
+
 static const uint8_t sd_csd_rw_mask[16] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xfe,
@@ -798,6 +809,8 @@ static void sd_reset(DeviceState *dev)
 
     sect = sd_addr_to_wpnum(size) + 1;
 
+    sd->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    sd->cmd_count = 0;
     sd->state = sd_idle_state;
 
     /* card registers */
@@ -906,6 +919,18 @@ static const VMStateDescription emmc_extcsd_vmstate = {
     },
 };
 
+static const VMStateDescription sdmmc_uptime_cmdcnt_vmstate = {
+    .name = "sd-card/uptime-command_count-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_needed_for_emmc,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT64(reset_time_ns, SDState),
+        VMSTATE_UINT32(cmd_count, SDState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int sd_vmstate_pre_load(void *opaque)
 {
     SDState *sd = opaque;
@@ -954,6 +979,7 @@ static const VMStateDescription sd_vmstate = {
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
         &emmc_extcsd_vmstate,
+        &sdmmc_uptime_cmdcnt_vmstate,
         NULL
     },
 };
@@ -1980,6 +2006,16 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         sd->state = sd_ready_state;
     }
 
+    if (sd_is_emmc(sd) && sd->cmd_count == 1) {
+        int64_t clk_cycles = sd_uptime_ns(sd) / OD_FREQ_MIN_HZ;
+
+        trace_sdcard_ext_csd_bootmode(sd_uptime_ns(sd), clk_cycles,
+                                      clk_cycles > BOOT_MODE_DELAY_CYCLES_MIN);
+        if (clk_cycles > BOOT_MODE_DELAY_CYCLES_MIN) {
+            sd->ext_csd[EXT_CSD_PART_CONFIG] |= (1 << 3);
+        }
+    }
+
     return sd_r3;
 }
 
@@ -2162,6 +2198,8 @@ int sd_do_command(SDState *sd, SDRequest *req,
         return 0;
     }
 
+    ++sd->cmd_count;
+
     if (sd->state == sd_inactive_state) {
         rtype = sd_illegal;
         goto send_response;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 43671dc791..5454e55077 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -57,6 +57,7 @@ sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d ofs %"PRIu32" value 0x%02x"
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
+sdcard_ext_csd_bootmode(int64_t uptime_ns, int64_t clk_cycles, unsigned enabled) "%"PRId64" ns, %"PRId64" cycles, boot mode: %u"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
 sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
 
-- 
2.41.0



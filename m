Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44D7C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5d2-0008Sy-Kw; Fri, 28 Jun 2024 03:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5d0-0008R8-Ni
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5cy-0006cB-ID
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42565697036so8309185e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558154; x=1720162954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IJEAX/bFYJE8abBHAC9lGeH6fM4rczNBP33ZEV8FrPw=;
 b=lY6AscQSNN2A7oWWJjiUoAX6C9QG3kDzbTtSd1lZ7bFqM6u/bhRwJ8AtjtUKrQpEfY
 1tWSBJBPTmKWXCpGkxxjytwFtSt/kHy3o+ejWdsH0akC6cMsMTmpHUj1Gg6OMVE/qzbm
 8b6tyct3oFo4tqdBpwBOJpGh5i0/JA1iCUIPO3ijR8BEK0uqSn6u43+Vac9L8oxvCHN5
 lbZz22WcCuXiIBu4m91NEySAaYHNGIE1PU2+cBEB9pWx7fl3F1EKFWC9RH9S1T8f7K15
 VjHsH7rF/OXGRXR51HsBuLb3PQVfm+PWkIpm0tP6D/9nVkk/QbF479BmBHbSfXBraXcX
 Fc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558154; x=1720162954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJEAX/bFYJE8abBHAC9lGeH6fM4rczNBP33ZEV8FrPw=;
 b=iE2ZF9Wnh3h9D0kObCufQSIxJBEwiP/SUWLHltepjpO3NYhdTpzdrJe1oKi+eI6knB
 nA3oGShyw8eHGH5GMat/Fg+RmgLDDkObEIMgp+bLzR9TDaa4E7MJhV4pzb229MM0fotm
 q/YPjTDLIJJfzg4eS+sGyjW3vKqrtI1oPYfCVwqGdrhQP6j3PFuyxkmCChQtdE9x1npz
 mi646zo8kvOhNABbNkd841yWIn2M+wMvLWaeMLWhAo5xYFevr/2D7KSvdJIO8jNftOsl
 O8kn+Ox0aB2ywCYmD9E52MBt69da1PmOGybOPtkyk35pNS6S+fFTxMnPZHdMqhMRrIjA
 xajA==
X-Gm-Message-State: AOJu0Yy/DTZqhAxjG1c6aX88/HzSzfNFsQrTcISrLr/3IaPluFUNA5ty
 RoECY8o7873FeZQwKizIdFMMRtzZY45r299OPiAqcr8lY7PNMo95qvsrgdNNiVLYGoNR2TKUeoF
 VO+4=
X-Google-Smtp-Source: AGHT+IG8AChb1iaAnGMy1AeS8ANRMvlRKNOTl9JpTzdZkr3h3CYuBryZsfgRnx3F/Wm23krMKhpaSg==
X-Received: by 2002:a05:600c:4ecf:b0:421:347a:f0a6 with SMTP id
 5b1f17b1804b1-4256d4c1d7cmr5222785e9.3.1719558154671; 
 Fri, 28 Jun 2024 00:02:34 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b099c7dsm21584795e9.38.2024.06.28.00.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 03/98] hw/sd/sdcard: Track last command used to help
 logging
Date: Fri, 28 Jun 2024 09:00:39 +0200
Message-ID: <20240628070216.92609-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

The command is selected on the I/O lines, and further
processing might be done on the DAT lines via the
sd_read_byte() and sd_write_byte() handlers. Since
these methods can't distinct between normal and APP
commands, keep the name of the current command in
the SDState and use it in the DAT handlers. This
fixes a bug that all normal commands were displayed
as APP commands.

Fixes: 2ed61fb57b ("sdcard: Display command name when tracing CMD/ACMD")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d0a1d5db18..bc87807793 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -133,6 +133,7 @@ struct SDState {
     uint32_t pwd_len;
     uint8_t function_group[6];
     uint8_t current_cmd;
+    const char *last_cmd_name;
     /* True if we will handle the next command as an ACMD. Note that this does
      * *not* track the APP_CMD status bit!
      */
@@ -1154,12 +1155,13 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     uint16_t rca;
     uint64_t addr;
 
+    sd->last_cmd_name = sd_cmd_name(req.cmd);
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
      */
     if (req.cmd != 55 || sd->expecting_acmd) {
         trace_sdcard_normal_command(sd_proto(sd)->name,
-                                    sd_cmd_name(req.cmd), req.cmd,
+                                    sd->last_cmd_name, req.cmd,
                                     req.arg, sd_state_name(sd->state));
     }
 
@@ -1620,7 +1622,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_app_command(SDState *sd,
                                     SDRequest req)
 {
-    trace_sdcard_app_command(sd_proto(sd)->name, sd_acmd_name(req.cmd),
+    sd->last_cmd_name = sd_acmd_name(req.cmd);
+    trace_sdcard_app_command(sd_proto(sd)->name, sd->last_cmd_name,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
@@ -1913,7 +1916,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd_proto(sd)->name,
-                            sd_acmd_name(sd->current_cmd),
+                            sd->last_cmd_name,
                             sd->current_cmd, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
@@ -2069,7 +2072,7 @@ uint8_t sd_read_byte(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd_proto(sd)->name,
-                           sd_acmd_name(sd->current_cmd),
+                           sd->last_cmd_name,
                            sd->current_cmd, io_len);
     switch (sd->current_cmd) {
     case 6:  /* CMD6:   SWITCH_FUNCTION */
@@ -2214,6 +2217,7 @@ static void sd_instance_init(Object *obj)
 {
     SDState *sd = SD_CARD(obj);
 
+    sd->last_cmd_name = "UNSET";
     sd->enable = true;
     sd->ocr_power_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sd_ocr_powerup, sd);
 }
-- 
2.41.0



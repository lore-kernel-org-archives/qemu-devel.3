Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17655C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjC-0005uJ-PN; Tue, 02 Jul 2024 05:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjB-0005jZ-48
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZj7-0006lx-9u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-424ad289949so28603775e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912183; x=1720516983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/eRkmwGVDEETYZdTpz1AxWYEJ+R0hQ9lI4q9Qx8IeM=;
 b=bujLOGO6y3pOJon/NskHK0VJLzT29GButuLECZqVMX+ClFlDBMau/JS/2rHh2dNXtE
 Syrmqo9vMHp6XFOzCaQ5q1fKwWlvWFZHpHUIxFhWKwNUH+SuFdP8cSFwYoWba8B92zVZ
 N1UfBrHnDx/ebXR5hJNBGpRAKxMueSwa8B0dv00FqM/0AgUWB9sICZXAQXRLXRIq6bya
 Gh+a9y3MD0kv4UuDus3y1mn34NxheoLl/3tuPhMaAUyt22QJI4L0WeyGMhZldL2xWkVl
 lcrvpFacDB0/EUny50u3msOLSTOmXJIOw8msuB5WXjrB3wSN/76jA3ycQAxgxoD6TY8G
 RFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912183; x=1720516983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/eRkmwGVDEETYZdTpz1AxWYEJ+R0hQ9lI4q9Qx8IeM=;
 b=AITvhuP6AG1MEpBdjb0rBohurLSAkgCQAXmd3sHt4mJmm6try/bI3ksn2xpiJxveMk
 xDpZvH85efCp82mNS1+b0MfGvkVW1+N5pXWhWo1+s/dyphSt+scsm1Stg1icMRM6/3NQ
 y3TCs9LOjzLbsqrmnzt9QsekBM7k1lhsVTHYCEzS/nMqd477xFufTMSMx8vVE8xjMHDv
 NjhTqCAxn02UpZOAZvLY3WsJQmvEuOnMTY9Bjgsrz8hOUiklNuS/dvvTzm+qf6p0RLmn
 NoxT9KvbofO9BXOJ5x1IW9OpQXVFsHQB0BNnlbabQcdktsghf/2RmtKGmfEQOXz6Zq58
 MO5A==
X-Gm-Message-State: AOJu0Yx9VJCZ0IkZuUzRErWm2mTEakE2Lvgrk/9Fje7y5XB+1hjYtVBu
 bwsPIe+0YmyDe201S/NfbG2zMt0HCpXVqaTNRPkOXkdmNCNeHg7bCt42272lAoFRXX2o8NH5CWO
 U
X-Google-Smtp-Source: AGHT+IFgmHbwPPAtCQpy4pVQlM9+GYDwv/JQakQykG7kCUc/5qQlGPsMIxIGo++bQ6aekOmaFlV1mQ==
X-Received: by 2002:a05:600c:3510:b0:422:384e:4365 with SMTP id
 5b1f17b1804b1-42579fff40dmr53861195e9.2.1719912182993; 
 Tue, 02 Jul 2024 02:23:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256aed237dsm191953365e9.0.2024.07.02.02.23.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/67] hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to
 generic_read_byte (ACMD22)
Date: Tue,  2 Jul 2024 11:20:05 +0200
Message-ID: <20240702092051.45754-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-28-philmd@linaro.org>
---
 hw/sd/sd.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0a65bd5a76..5d5e55243e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1705,11 +1705,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
-            stl_be_p(sd->data, sd->blk_written);
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         &sd->blk_written,
+                                         sizeof(sd->blk_written));
 
         default:
             break;
@@ -2129,6 +2127,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
+    case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
         sd_generic_read_byte(sd, &ret);
         break;
@@ -2157,13 +2156,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= 4)
-            sd->state = sd_transfer_state;
-        break;
-
     case 51:  /* ACMD51: SEND_SCR */
         ret = sd->scr[sd->data_offset ++];
 
-- 
2.41.0



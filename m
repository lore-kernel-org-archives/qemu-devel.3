Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BBDC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs5Z-0002WB-0F; Thu, 27 Jun 2024 12:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5W-0002HB-6T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:35:10 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs5T-0004mo-TO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:35:09 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so95851901fa.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506105; x=1720110905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+swjnqxsHD9ZmAL3ZynjQXwZx/kNtJr6qmfanG6zVA=;
 b=Emeu5zSIabq4XP6eST5d8z1OaaeWQi7dkn1RV409IFizg3EGbun0HUQd0TxAYyDLud
 QTuuVcMkHaxlVG0fE0F8Us7ZjkBtwZjIFHc4c5Fbx4981j5fKnffzGO5qKRnU9s+BX4M
 /sBr0OwsQJLGyQBgZ59Y4s9F8NO9wzdBBZQD23ANuf2mvu9zwhWQI2MbCnwFpNWUs5L0
 QW686wJXvR31oa/XwO5Zqz/g9hpVcLHnxuFq0NPtqw78PfgYITzJT6dO0dEksMmNt+Nl
 dXB7qLXBZikxVlfrpjEpIiHuN5xtc2Tl+IUyGkymRhXvyez1cCnPSAgDsnSxqaQ27foM
 ka7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506105; x=1720110905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+swjnqxsHD9ZmAL3ZynjQXwZx/kNtJr6qmfanG6zVA=;
 b=NPO03oFtlUz7WRJrwR1P/NzOa7ZGDbCpHymxdpSpBrc3jkqZSgN76hHAVCzQHUvn65
 MS+w1vGbAYkWIho9MjoQkwOY4hDDXwLGa7Dn6HS3PCaOnwUDgNFVm6NHUqHOv4Wg5+X5
 YnyqwOKMO0nogz97UuO6Wt/crsFQRRkK/O5xPoiQn7+aZek2rlB7E+LHXYBMjP/qAor3
 PzMAcG89iS0sesAZF90DIxaXt/5zydZC5v65N0FJnVbq4WyrCZRRoMntL2PVFPXTbS+u
 nTOTGlgQDSt3gxQuW31DlJ25MNqod5xLfKfncQrZ8nI0U/xqGXyZ8LDdAUqR1Han8tTi
 SISw==
X-Gm-Message-State: AOJu0YxkBH09KdZFRLButoXBz/nq/S2eQAW6gwahD1eft+e89KOXmiGm
 z6tzOzm5PPOKGxkocGUbS+JNrlNg92p3M7fuKfQ2T1nUNwBYGtCr294b7R3Pz01F9l30v5aUz6S
 v22Q=
X-Google-Smtp-Source: AGHT+IGWuHlIIZhNOn6Hh7/HE7qxG6JlUCUkhBL/XICXQ4brt02t/hs7OglGXPwY23XUEHfj80Roog==
X-Received: by 2002:a2e:b0f5:0:b0:2ec:419b:429e with SMTP id
 38308e7fff4ca-2ec5b3180abmr84573371fa.2.1719506104865; 
 Thu, 27 Jun 2024 09:35:04 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8251149sm72609445e9.11.2024.06.27.09.35.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:35:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 6/7] hw/sd/sdcard: Convert LOCK_UNLOCK to
 generic_write_byte (CMD42)
Date: Thu, 27 Jun 2024 18:34:02 +0200
Message-ID: <20240627163403.81220-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627163403.81220-1-philmd@linaro.org>
References: <20240627163403.81220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bdd5f3486a..0cb528b0b2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1628,17 +1628,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Lock card commands (Class 7) */
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, 0);
 
     /* Application specific commands (Class 8) */
     case 55:  /* CMD55:  APP_CMD */
@@ -2109,8 +2099,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 42:  /* CMD42:  LOCK_UNLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_lock_command(sd);
-- 
2.41.0



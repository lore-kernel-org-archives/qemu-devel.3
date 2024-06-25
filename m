Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213A8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOM-0000Xh-VV; Tue, 25 Jun 2024 02:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOJ-0000M8-5M
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:55 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOG-0005dd-VS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:54 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52cdd893e5cso3030702e87.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295849; x=1719900649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NaCEUe06tl61OBfIHTaSsFr8m9A3Vd4SzjwSutNDx7I=;
 b=S2pfJpHV+X9pSnPinj3hyf+z9NkMANKrMb1Uo0prf1ww3eE+yg4D0xIOw2JAu0iani
 Su/2Cap/ITjj8YyVSnpyM3cCqoVHrOOcbCHK+XQG+r6tVCncOG/U8iEOZOvPZpiCMN1a
 TV25utjgCWrytau9+Sp4Ou1ZLWoYyVJIyQfODxWMXlUeNNuPqtFL1h3pojefvG1RUnE9
 RZzDWMSp8+gm0X6ri3ygPIGJin7iLXytt86BnHrFDBXthLdEE9vaAnMW4FjknUFZ5RlD
 C9PYUSbTNhMfS982xiT2wM2Uen/vCvvjVuaDLNkArpX+sppygQrdGBhMmDDRW0UFm9DJ
 B7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295849; x=1719900649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NaCEUe06tl61OBfIHTaSsFr8m9A3Vd4SzjwSutNDx7I=;
 b=mQA55KY2sCqzcxAxvR1qMSMcE8Ci3ZdVbQr7cTlZIsBG6vN9nKhHqXtqUQO5m54ysh
 BWp8OxA/3JMkwgw2loSuYHoZqdOoe4uZlocHuSVm4eygD+U1QoTjks8ndQebdSUt79zb
 D6o+bK/0jkVKUlofqM/V71/8mt7bnezsZktQ/f4TcPs15aAYijHIUQCiEFHrf7lRizjn
 YmRhOx1aD1HRGO4thFXz1J90Xxlskok1cytxXIykLqtL6+UfZkm7E0+kKiv/9Jhv/BSQ
 QH7tQ2KlTPxNs+Hk/vS3yhKPNz2AAwrctxKnTBhTBFBfOj2g5T3MBZpwbOWhYCABKo9i
 ml+Q==
X-Gm-Message-State: AOJu0YwLWXD+cgnXNnMcBz8mHE+ZTVZjavAV8X+LSO+N4HLokTsjXIyT
 JYm1VJ6dXw3Q6vrhXSY1+hWNQFyI8xNQ9t5GzxUlSXkPGl1d6zFs3QETmZfz3AdEg06lOLJOsRc
 i
X-Google-Smtp-Source: AGHT+IFRC0rvG46dCrbUCOBRSqImSD5i7273SBjM5Han1cOUGURWWZagIJ6Xae1tlr9BFLJHRvO1Eg==
X-Received: by 2002:a05:6512:2254:b0:52c:df55:e11a with SMTP id
 2adb3069b0e04-52ce18325f3mr6040195e87.9.1719295849686; 
 Mon, 24 Jun 2024 23:10:49 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366388c4282sm11956753f8f.31.2024.06.24.23.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/11] hw/sd/sdcard: Convert READ_SINGLE_BLOCK to
 generic_read_byte (CMD17)
Date: Tue, 25 Jun 2024 08:10:09 +0200
Message-ID: <20240625061015.24095-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9aaa78a334..6af7b3f034 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1383,11 +1383,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             if (!address_in_range(sd, "READ_SINGLE_BLOCK", addr, sd->blk_len)) {
                 return sd_r1;
             }
-
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-            return sd_r1;
+            sd_blk_read(sd, addr, sd->blk_len);
+            return sd_cmd_to_sendingdata(sd, req, addr, NULL, sd->blk_len);
 
         default:
             break;
@@ -2122,6 +2119,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 17: /* CMD17:  READ_SINGLE_BLOCK */
         sd_generic_read_byte(sd, &ret);
         break;
 
@@ -2132,16 +2130,6 @@ uint8_t sd_read_byte(SDState *sd)
             sd->state = sd_transfer_state;
         break;
 
-    case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0) {
-            sd_blk_read(sd, sd->data_start, io_len);
-        }
-        ret = sd->data[sd->data_offset ++];
-
-        if (sd->data_offset >= io_len)
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0



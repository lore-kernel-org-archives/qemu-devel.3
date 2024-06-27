Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D56C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrzg-0004yX-6M; Thu, 27 Jun 2024 12:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrze-0004sE-Uz
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrzd-0003ZC-7C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:29:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424720e73e1so65536935e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505743; x=1720110543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1KciARHbIYi2vnj7HB8fhMsqIK9cJrPhhDCahh6cG1M=;
 b=qvke0LxHfA+oPmBvXwOWvEECPBfNBGeoJPSfT13JCrK0MbyDQAWGiVpCvPwqkQnBpy
 gdyMcIQMh2vo8xCEz8Gq7tJ3s7aUdXN2UkC9/6Q9dWXcMhSH69WfHTY8FLEuypzWudM8
 zfwtzMDF5slvINtAAV/nZj1bUTb/2NRF/uLHqv9YbYNqPr3OMi0TU3OlId8V6pgkEAXY
 qUNyopUNeH8XUieIu/SrjFyR10DvZgNQGU+UDrsgPYin8CCCLtXQi/Kyvnbb2n/YABde
 Yf1mnIl076USdpYDqgSzp5vR9JrEZtWI0o760f/+RvpzmqRzxiXNiSqCEbytrple5YBt
 Paow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505743; x=1720110543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1KciARHbIYi2vnj7HB8fhMsqIK9cJrPhhDCahh6cG1M=;
 b=b0vmKCK8y89errjVjrzMdS4s6IFzcq50o6+1Dv/6CntCEXD0QxHff/fuBmcTfBTKTK
 RKrcmjNi58I1hm26MnLnFAjoIXTT0njxpilLCuUQ5g4rl8pAoueBLBUeSxoXYOzDydPe
 9Gf/npzeL7GnzjiASNk3WYm6R4KNarkTlb7HHTiMec7UBaGbC5IvKIAteILZXF4YlBBW
 ESo9MN7G7oxnnwBEpGG6ZvuNhie1jtndl1vQxoegx3FJ0ylUvnuNMDFtVB4HyuOB+Upr
 zYq4QExkEDZ1JA7bpe94B/ahvshgqo9DarXTQBpx0AXE3QBbeolXTRdywM20wuFFB5kE
 9+OQ==
X-Gm-Message-State: AOJu0YzV71LhTxNQG1jCA9yJbtcsCbKR8sNxNcpEkgMmGjzqhT5oeFpJ
 yvSHJcBKYF/76yeUwlDh+kHZ8BRy86AJvdSOZBAGR8812v0tPipkPZghouWtaexbOu7M4Ua6mlD
 /S/8=
X-Google-Smtp-Source: AGHT+IELHvFW1v2c51jkk/RXNS2D976Wv3sjgb1oJRMwcKe7jcEHwhDP/QkL0XSPsXDAPYJB3OW6aA==
X-Received: by 2002:a05:600c:a:b0:424:ad14:6b79 with SMTP id
 5b1f17b1804b1-424ad146e41mr34288125e9.8.1719505743684; 
 Thu, 27 Jun 2024 09:29:03 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436998fbsm2359860f8f.84.2024.06.27.09.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:29:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 09/11] hw/sd/sdcard: Convert SD_STATUS to generic_read_byte
 (ACMD13)
Date: Thu, 27 Jun 2024 18:27:27 +0200
Message-ID: <20240627162729.80909-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162729.80909-1-philmd@linaro.org>
References: <20240627162729.80909-1-philmd@linaro.org>
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
 hw/sd/sd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ccf81b9e59..1c4811f410 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1703,10 +1703,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 13:  /* ACMD13: SD_STATUS */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0,
+                                         sd->sd_status,
+                                         sizeof(sd->sd_status));
 
         default:
             break;
@@ -2136,6 +2135,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
@@ -2143,13 +2143,6 @@ uint8_t sd_read_byte(SDState *sd)
         sd_generic_read_byte(sd, &ret);
         break;
 
-    case 13:  /* ACMD13: SD_STATUS */
-        ret = sd->sd_status[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->sd_status))
-            sd->state = sd_transfer_state;
-        break;
-
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
-- 
2.41.0



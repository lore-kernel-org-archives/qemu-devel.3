Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A8C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8A-0001cL-CF; Tue, 25 Jun 2024 01:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz88-0001bY-0N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:12 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz86-0001Yw-El
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:11 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cdd03d6aaso2934485e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294848; x=1719899648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsF8niTdQH3Vk+tuBHzzhdAif0xIcoOBVyM8lpmJF7M=;
 b=Ons9rj7YfM1tfAl1ZK0cfaA9xpYUfWSjT13aoDvi/whcoiglKyLplYWCtNgMXKj8df
 fpU+4XJzmpjfSpsDUNlnBONaP1Rbwcz652iJxLjlC8US9PWi/MLxvUHQyZIyg4m/cCwq
 HknRNt7TPytOZFvQttx8m6NgOCIeemxO9A5juuzLGzcjBKiFiCSlpMSq6xNwIi2ebnBI
 Cq2phsfgluMSh5htyZHGlruBYd5rAQNCn+0J5TNAeUQj45KC4ZnM067ZMkLPbvh14tLz
 Nxx9hrHBbP17+lxHVgpIdTSCmuApPGoNoWsfH1zFx7e+R7pZymBHGVa9gl7c6Sl8Bjop
 yfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294848; x=1719899648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsF8niTdQH3Vk+tuBHzzhdAif0xIcoOBVyM8lpmJF7M=;
 b=JO8tK69Bqra2pEGviOp+iE2jWzlKXL214+K2BVWkMjEvD4no/MX76KoVKSt9xFJxwL
 VEcN+AZ20qlDs3zXPSTXmSUDwmPDDTdcaPMCwHmXhIkAnz4EDNEUaCETdqic4G6L90gl
 P7Shpcdz43uL33xXHvXn4u0FLYlW8xpufnhqZ2kAgeuHHPvtD1dr0K/Spn/zGV8hwsps
 PSG0D/QXqPQ9VNwzQBLU1remeDl4yR7y2DohKPtjLHU0kATnk5s+jBaRlJ44KHYYrq2b
 +jHTpVw9uBcTipjrVXLgiUqa23PGjtNyGflx2T4guprhh446StIYDWI256kNlY+N4Srw
 R2MQ==
X-Gm-Message-State: AOJu0YyQTRD0X5EnlVyfCwK+Gujjxx/EU960VRw8fT7Ew8dMAuGWcFj3
 zUcCNVkUNYqRcE+zhYrc0laMKq+C5yfM0kzDPkzZR/+1Bbw/WMVc/DrerC+0BVxsYRVyCgAo6ZY
 e
X-Google-Smtp-Source: AGHT+IGvqlpcBAAgPCq2HKYN0WZCmyEAd/sYOAR+YRP8vYT3iViMv0GadfmQ5K+XVux0OqzR+kR1Tg==
X-Received: by 2002:a05:6512:3e0c:b0:52c:89b5:27bc with SMTP id
 2adb3069b0e04-52ce0673582mr4629523e87.42.1719294848316; 
 Mon, 24 Jun 2024 22:54:08 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191fac8sm156993215e9.42.2024.06.24.22.54.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 02/12] hw/sd/sdcard: Generate random RCA value
Date: Tue, 25 Jun 2024 07:53:43 +0200
Message-ID: <20240625055354.23273-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Rather than using the obscure 0x4567 magic value,
use a real random one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a48010cfc1..ec58c5e2a6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -46,6 +46,7 @@
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
+#include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "sdmmc-internal.h"
 #include "trace.h"
@@ -490,11 +491,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
 
 /* Relative Card Address register */
 
-static void sd_set_rca(SDState *sd)
-{
-    sd->rca += 0x4567;
-}
-
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
     if (sd_cmd_type[req.cmd] == sd_ac || sd_cmd_type[req.cmd] == sd_adtc) {
@@ -1107,7 +1103,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     case sd_identification_state:
     case sd_standby_state:
         sd->state = sd_standby_state;
-        sd_set_rca(sd);
+        qemu_guest_getrandom_nofail(&sd->rca, sizeof(sd->rca));
         return sd_r6;
 
     default:
-- 
2.41.0



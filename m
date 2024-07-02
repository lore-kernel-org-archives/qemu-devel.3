Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C031C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZj4-0004uE-Us; Tue, 02 Jul 2024 05:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZj3-0004hr-19
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZj1-0006lc-6q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42574064b16so24374425e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912177; x=1720516977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imXLEvTuUF3KqVtejnZ3cyv6qmJ2G3srjMrqU8EXbpg=;
 b=ZDQprPED1gDgkUIuGnn6mnkir1X20xYVHunxECPgqZ+7RbkJtirLZjWtD5hSnDtcqC
 odXC/kOnw0fpINPSWxRwz+sLwg1F+8mVpSvIDN2xEGi2VaxJw/pGFYpJ/327AN4V0VsG
 SvyomzWD6DbmWZsT2ggCntTOPLOLch4WugED9XkSXVG7EtYll4oVjy80IlrmwVbelXL2
 d0VYGKbWIKAfvGAYFcEl8uptrZCDJQ4pZGRijb4p+oqdkaoCoExzDhxnC30MedfdVdZn
 pSXJIZjPk02Soex04PDEJ8MmGnL/GaNZx+LNVMjfTjzdWckAa1MPJSvjMlBIsZ2KJdql
 zJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912177; x=1720516977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imXLEvTuUF3KqVtejnZ3cyv6qmJ2G3srjMrqU8EXbpg=;
 b=e0I4eV4YgIASUlXTyaEjesY36qertH+uoeBj3dETrT/NAW0+adlrKk1EjVrT4SzbsU
 CZ/NW1PAvAkYBdNt28FWYBTbpw9Gu99neBwU+Ax0GMUBOhgpaqjp5YmmPUlUsl4PLdOq
 JhtbwhAfz7I7HJTTI83uSToslLV2fwhtJSOmBYM4ECouJRtlKEW+HwzOV0Mf5NcPi3jd
 8waLVpH650wTYcMSqH6uOi0mHXKwWsDGnOQCGBu0yicDS9BmHbH5mmjzkAF/I0q1L14Z
 rb0dV2XRKcylZt9gXv4WobdPfMNyEKRSJsXAJvZ8Tko3vURLAqdlFprPNJnZ7e90pWSA
 3T5A==
X-Gm-Message-State: AOJu0YzwWsu3WslE8fXg+tNSaB/U2G+qdvRPOhjUpKMc0kM+KFHwXC5i
 cvqp5Kp29MerhGCIpDqbRJrlTni8/xqBQhvxdHS1v4e3kuezZIeJDqK0Kh9p+5tCphI0vR39sgk
 Q
X-Google-Smtp-Source: AGHT+IECFom1IuSHPEJ4t21gxJ3NlhLrzRKnyuELE3Fl/c3Zc09fZ7OLrIG9KPCciMjrnLPqaFYTSg==
X-Received: by 2002:a5d:5f8e:0:b0:364:4b4e:9310 with SMTP id
 ffacd0b85a97d-367756a333amr7635174f8f.1.1719912177249; 
 Tue, 02 Jul 2024 02:22:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10302fsm12588472f8f.93.2024.07.02.02.22.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:22:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/67] hw/sd/sdcard: Convert SD_STATUS to generic_read_byte
 (ACMD13)
Date: Tue,  2 Jul 2024 11:20:04 +0200
Message-ID: <20240702092051.45754-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-27-philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1d6bacf885..0a65bd5a76 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1693,10 +1693,9 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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
@@ -2127,19 +2126,13 @@ uint8_t sd_read_byte(SDState *sd)
     case 6:  /* CMD6:   SWITCH_FUNCTION */
     case 9:  /* CMD9:   SEND_CSD */
     case 10: /* CMD10:  SEND_CID */
+    case 13: /* ACMD13: SD_STATUS */
     case 17: /* CMD17:  READ_SINGLE_BLOCK */
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 30: /* CMD30:  SEND_WRITE_PROT */
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



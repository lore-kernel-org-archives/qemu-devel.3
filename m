Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564F7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 04:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3dM-0000bw-2i; Fri, 28 Jun 2024 00:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3d3-0008WB-QE
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN3cz-00013i-AV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 00:54:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so1751335e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 21:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719550467; x=1720155267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t05HoVB9l7/y3jswyRpww8YiOUTnZmazAh4RttVAsxI=;
 b=XSCbUt99pRUHV2PB23piMtX6CxmHJAARni9MDY3d1X7vkcd/e0LBjV7SoQyhicXGG0
 DxJ6atxvemE7EBMTng36R70nQIf21DMRgLFxgtvywqEx1jJhP/gzXNwI3qujKLDruOEE
 5/oGoqgVH6bgy2lkmb+/JzaNXfLtn7LymNR2MAj6uzvkgFSeJ8jXujsHiqUvok14zykX
 bk5F8j1AWT7jrzgQeKe6RxdH6iy/Sz2PefPI4TKOCXywwmba85VeU04qbxAgGIWfwDgF
 uI8IB619Yoluu3i2cNnsDTSHyfJ5loq6CRB4wUthCaeYAoOxD+DYU9/xMCGBQT1qY4TU
 arRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719550467; x=1720155267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t05HoVB9l7/y3jswyRpww8YiOUTnZmazAh4RttVAsxI=;
 b=lJcBOiWG0cwML7aJ32hiHEzg9t4k/CwM5Kq5kgyRgnLkcroctZneQHe4MTmr26TSUV
 r/V7O19LxEyiUwtOMJj5XT3j8JrNlOc6tfZtPSp+0dV2Mam2OAwVys31WmX4TZHPyvwl
 RvUh46y0uLrsCF+pEvmYfZup2eQcq8WVnWat6LSTI0Kgkb4iajX0EmWC1wno1iRA6Dhf
 OOeSNduMZmE+kd8LYcHWQlAzmF1SM976uvPXpHWwrT1TkXpLWxQWBIUGx/mmVDBoC4jh
 /6OGxMLDx+mc7pggzhN6fep6IhwYsmB2uiNQcLbUFudmzP/iA0Wdu83Z4CMlqKJ49+o/
 Kr7w==
X-Gm-Message-State: AOJu0YwuwBUJI76wZ6unXaiizeX6cMNR4aG9+QDYXHQXStkYrqq0HE72
 +fCyjpgQTxLTGFRTcIYSukVO4eCSr8Lo7L/FNsiNjkU03aHDYoTiXeQgp6PrUsHQqqg79E8gWNZ
 +IdQzpQ==
X-Google-Smtp-Source: AGHT+IFFZV82gn2R5E+XeFgXRHfMeLpy8h1fvx7x9HN/YzKD/iJl6QsSsTULJJ4ZEgFCXpz9tWWqRg==
X-Received: by 2002:a05:600c:138e:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-42489e3708fmr106929975e9.4.1719550467159; 
 Thu, 27 Jun 2024 21:54:27 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5a3b0sm17938285e9.13.2024.06.27.21.54.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 21:54:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/12] hw/sd/sdcard: Remove default case in read/write on DAT
 lines
Date: Fri, 28 Jun 2024 06:53:22 +0200
Message-ID: <20240628045323.86308-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627164815.82606-1-philmd@linaro.org>
References: <20240627164815.82606-1-philmd@linaro.org>
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

All read/write on DAT lines are explicitly handled.
Reaching this point would be a programming error:
replace by an assertion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0a7b422b2c..64621d4340 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1951,7 +1951,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status = FIELD_DP32(sd->card_status, CSR,
                                      CURRENT_STATE, last_state);
     }
@@ -2016,6 +2015,8 @@ send_response:
     qemu_hexdump(stderr, "Response", response, rsplen);
 #endif
 
+    sd->current_cmd = rtype == sd_illegal ? 0 : req->cmd;
+
     return rsplen;
 }
 
@@ -2171,8 +2172,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -2238,8 +2238,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        return 0x00;
+        g_assert_not_reached();
     }
 
     return ret;
-- 
2.41.0



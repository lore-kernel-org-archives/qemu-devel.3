Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B5BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzOt-0002XP-7Z; Tue, 25 Jun 2024 02:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOq-0002F8-1s
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:28 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzOo-0005ns-8j
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:11:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so42133505e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295884; x=1719900684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JtzAqyOt7dnHFt5cCK1r6A59kYlBOq6vAwEqcU/vdY=;
 b=I+IhfaEzs5oBXlat9JgwpDVqyQ7r/sRQ3LpHvKw01dIG5TwQ5ehpPP2gp5VuT2Okni
 5nJ9esPi5MESBfw+LuAw4bqwXzTIx+rVVCmipCgyJIq4cu5UExjRhp1NkHpqtOlTKJ2P
 3mKoUqYuCNNX61lUgJ+Rz2QNlW1Y+Gh9aoB+Q7IUw7zEWd5CuEUKU//JxL+MqRT8Rrhe
 cC576jvY0JJqh8GdVuuNuSngZZLReg5BxWn5IuzQyFaQcMJmfRz4ul3etAvnv5SwNmBp
 ok3gUBIWOqNFmbyLoRw4nbY+WwyKhKuQP6C7mH2n0yyid9VO06Hzji54OkoQDrSK+Bm4
 XrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295884; x=1719900684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JtzAqyOt7dnHFt5cCK1r6A59kYlBOq6vAwEqcU/vdY=;
 b=e/kveKD/iWiFQla4HZXhm9RT+Ijrv8F0yuJ5bTEwxLkvKr9WLxNM2mdABJABjWVvzX
 qzlbUnRt6L5ruS2m6YAWZ69rdwuDhnjsbPPisW/4AM5oB/besi3GnRViNiVzM2gtjy1b
 Gg2H7Nu9tX3EolkCcnuJ9hfW5fy99zTe9ehMiZFo+z3Se6vjUoNmbje0HO7v6jGQa1pO
 SjnvI8rr4apHCJQTyNn/GocTDGl8GxzMj/vnI9fpRAgS5XXMHQjSId2DcbrbBA+hTexB
 jKyjSO0rp6jLWNh/fvxK8YbUdghY/unDelCZDXzigFsTwb28begPJGYO3wE5rIAaYAcN
 6Vdg==
X-Gm-Message-State: AOJu0Yxv8F4yCmpIBC5HufaBAAPmu0Rn06WAZqhpXEcyHoz1DfNNoXqV
 N75sy58b3hGcHUtvCvSUUt62u/1ohYCk7SrraP7UbtmE8aMCp4mYK6jwC6/PaIo5UHb4G9BT7MU
 d
X-Google-Smtp-Source: AGHT+IFvL3ixVF4UFjA5YF78NvtiW1Ri+HpogKeHGEI1CPbDCdMgUUmfYnqbQ5l35YSJRuGYEoqEqw==
X-Received: by 2002:a05:600c:2212:b0:424:a2d9:67c5 with SMTP id
 5b1f17b1804b1-424a2d96a8emr4220655e9.16.1719295884588; 
 Mon, 24 Jun 2024 23:11:24 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424a5a2683csm1746045e9.28.2024.06.24.23.11.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:11:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/11] hw/sd/sdcard: Convert SEND_SCR to generic_read_byte
 (ACMD51)
Date: Tue, 25 Jun 2024 08:10:15 +0200
Message-ID: <20240625061015.24095-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 hw/sd/sd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 023fcc63ac..af3a46373f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1763,10 +1763,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 51:  /* ACMD51: SEND_SCR */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
+            return sd_cmd_to_sendingdata(sd, req, 0, sd->scr, sizeof(sd->scr));
 
         default:
             break;
@@ -2116,6 +2113,7 @@ uint8_t sd_read_byte(SDState *sd)
     case 19: /* CMD19:  SEND_TUNING_BLOCK (SD) */
     case 22: /* ACMD22: SEND_NUM_WR_BLOCKS */
     case 30: /* CMD30:  SEND_WRITE_PROT */
+    case 51: /* ACMD51: SEND_SCR */
     case 56: /* CMD56:  GEN_CMD */
         sd_generic_read_byte(sd, &ret);
         break;
@@ -2144,13 +2142,6 @@ uint8_t sd_read_byte(SDState *sd)
         }
         break;
 
-    case 51:  /* ACMD51: SEND_SCR */
-        ret = sd->scr[sd->data_offset ++];
-
-        if (sd->data_offset >= sizeof(sd->scr))
-            sd->state = sd_transfer_state;
-        break;
-
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
-- 
2.41.0



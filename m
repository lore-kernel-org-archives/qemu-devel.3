Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74C1C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv5M-0001Za-TM; Tue, 13 Feb 2024 10:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv5K-0001N7-L7
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv5J-0005o9-1h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:52:38 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33cda3dfa06so453920f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839555; x=1708444355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AxD+0YCMVgkroYfQziax4Z5o2Tig0RRdRnoJR3JtkY=;
 b=WmMbxwwonlhXPXVoekbf0Gz8IYqfGC/hytzH7JhqLkDLtZwPxxrVqDB3ZHv4Ijdb2h
 qL6NDcDnF7iOW0SuiVqm119vVL4YqbWbbQViZ9qOl/Y0yfn2YQWGMgTxOdGxK7IJIC+b
 scVJLUh3hdPFdKSnGK4G6d2BBHfeHZGCd177YB7kCpZuN1WuXGp53g4+8vQnOGKBtoyd
 GCjGqjvs7gQTskKAdEJemk/mCoY6lG2pf1hQSDIDi51ztBeqJfzMS9ZYBEEgb8MBZcvT
 rNxtqIYq+pOOCcDN6FO5fHYdKNYo/JEotXHYxBMuqmThIhR/tV8hSwyNHTppmvqeoXxi
 WH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839555; x=1708444355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5AxD+0YCMVgkroYfQziax4Z5o2Tig0RRdRnoJR3JtkY=;
 b=NCFNjUR45yL2pGiBv4HSRoJjnol5AN9ozp8kyknN22ZbKSwf4I1n2/G88VggXhUgPC
 +rpBk6lRXUNusgYmegM8HrFnRvtwuMgvnHA1TQJpWraFOq2UUijB5sng3ISYmTzIttMi
 g6qyAwQOm+rfgI8A/cs66ubmiZKQIJD5i/u4R10uZDdDfNgP5ZI4b9vCMZ2PwDrom4RN
 MAUpshcSdPYqdhlzUEjT3EnKZl9pJbnjbDXlcJAqzRbjwckT2WxBjAsqoWvVOIFFJOqM
 91w/iudiNYd8JwbVnbW2uf74oUPWZsPaIpLtjXoUn/J2drUAEUorqksCd7Cfjr440j8F
 4iDA==
X-Gm-Message-State: AOJu0YwpU6KDVQDYD2KodsSq+lZFz8Mm39gcIEDMT4CPSjFPxtNy+eZZ
 BqWmqKESwoUyc0tSMKds3Tggzk2zNvjf2sq3SVDc/Xej0mUbN6UhJelB0SC0EtowCA79n1bF/1/
 I
X-Google-Smtp-Source: AGHT+IHa22S3sJLcemZtEQryKbspcIyw9oRwRWTzoCHKqmgahUGJYvJE8r0ivKuYkMbkkKH/+RkA1Q==
X-Received: by 2002:adf:f890:0:b0:33a:efe0:5a37 with SMTP id
 u16-20020adff890000000b0033aefe05a37mr6590934wrp.6.1707839555340; 
 Tue, 13 Feb 2024 07:52:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXKjmc1SZJV2956P8PE/PBTQFBMsL/I6B51CYt00/z6NkHA8dPuLoMTxxUAlxZ5JadBoGgrTkUki2f4ZOuZGU4GyguZTh8vpyqdlVFG+bhRx9jhJ79t0szDdH4CT+7QuOuwBlQTD+NaGeFMFYrDMygRMw==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 q1-20020adfb181000000b0033b68556c38sm10041274wra.70.2024.02.13.07.52.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 07:52:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] hw/arm/stellaris: Add missing QOM 'machine' parent
Date: Tue, 13 Feb 2024 16:52:13 +0100
Message-ID: <20240213155214.13619-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213155214.13619-1-philmd@linaro.org>
References: <20240213155214.13619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

This commit plug the devices which aren't part of the SoC;
they will be plugged into a SoC container in the next one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index d3a12fe51c..d9884286b3 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1271,10 +1271,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                                    &error_fatal);
 
             ssddev = qdev_new("ssd0323");
+            object_property_add_child(OBJECT(ms), "oled", OBJECT(ssddev));
             qdev_prop_set_uint8(ssddev, "cs", 1);
             qdev_realize_and_unref(ssddev, bus, &error_fatal);
 
             gpio_d_splitter = qdev_new(TYPE_SPLIT_IRQ);
+            object_property_add_child(OBJECT(ms), "splitter",
+                                      OBJECT(gpio_d_splitter));
             qdev_prop_set_uint32(gpio_d_splitter, "num-lines", 2);
             qdev_realize_and_unref(gpio_d_splitter, NULL, &error_fatal);
             qdev_connect_gpio_out(
@@ -1314,6 +1317,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         DeviceState *gpad;
 
         gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
+        object_property_add_child(OBJECT(ms), "gamepad", OBJECT(gpad));
         for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
             qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
         }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6648C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMryJ-0000UY-TS; Thu, 27 Jun 2024 12:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryH-0000Tr-DR
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:27:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMryF-0003KZ-Je
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:27:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4255fa23f7bso14816125e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505657; x=1720110457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vXiC8orAe6La4+LQIvlh6QX1/q5+gdW481yF4dB9Uzo=;
 b=u7elxhLA631YCon5fX0twt/JsfIUAT0UxjNGa3A/g8zF5vnPE4dZm5Tq2P9GxTzfva
 O9DOe3AFUss2lh5tXH8ZtF9CJsOAwwLvLK1G14fP23taC5QDeBFJI2BHGxLlTo44zwYN
 Dg8ESOatE7864SdUhxVxdVWRn4ULbvNCiX1BWml5uMBe1WcGPSJ5361eLGC57om9mJud
 ybMq92QeVcyV5psmJUssg8B96S2GHz4R2L2qD13v1ITZDz2BjJvDPjetrw3UpfF7/XRY
 PV2/3+8BWDUQFruLdw3AuficlzzqpLNkRK4JRFKWxWYwV8sL0M/TGV21LkvmD91I9/90
 5uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505657; x=1720110457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXiC8orAe6La4+LQIvlh6QX1/q5+gdW481yF4dB9Uzo=;
 b=Xct42PDeGGNEVEYQCSe05gNB1jtImtiQKpTVGDZc0gUDom7nMOcEoQrpu1DCCLscxK
 BFJ4J0WFUSMc/pbhr3F1BelIoKfuPGop7R1agFdl0zCUSlDYgq497Tt9xOZ/yOCWWZ9T
 tg3Fk7yjwVvAKPltKcqnlZ8hQ9ZnXL1IiB8FUBHItedvjc7ZKmQHMvwt2yLLA5zPC6dZ
 pN+Q/mRSWoQOBvOOG+0uQfI1zIGMM4RgRRz4DtLWvZLMxNjKWIzPvSGfiCkakDb0q6Ts
 4P/6hZ+KwTsW/UAkdAjetyMu7r2Rzxyy6YziC6BalmDGVAdQEboAJZJFqqRcnNHf9uzR
 tG0Q==
X-Gm-Message-State: AOJu0Yyw4YnZwj9PiZ9GrowEp+TsKj9bKaBpGozqhlb5zCs82U5pxku0
 mwC0mVPOr5LRDFkaBHLAy4qpxeyOCzTb44mDoa+hKpYosRlJhCubLhLbgXBEvX/ZKAbGEg8TP1e
 a5dA=
X-Google-Smtp-Source: AGHT+IEUrBdIltwQTA4HzaBcvOCD623cQ2+D3ly7Lwlqt5O3KRK6LtoRMUTg5qRIDh0BgzAEK+6zeg==
X-Received: by 2002:a05:600c:3c8d:b0:421:a575:99c9 with SMTP id
 5b1f17b1804b1-4248fe3fa35mr85096135e9.20.1719505656760; 
 Thu, 27 Jun 2024 09:27:36 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c84248afsm72667675e9.31.2024.06.27.09.27.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:27:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Subject: [PATCH v2 00/11] hw/sd/sd: Introduce sd_cmd_to_sendingdata() and
 sd_generic_read_byte()
Date: Thu, 27 Jun 2024 18:27:18 +0200
Message-ID: <20240627162729.80909-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Consolitate reading bytes on the DAT lines by introducing
a pair of helpers to reuse in all commands sending data.

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Based-on: <20240627162232.80428-1-philmd@linaro.org>

Philippe Mathieu-Daudé (11):
  hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte
  hw/sd/sdcard: Convert SWITCH_FUNCTION to generic_read_byte (CMD6)
  hw/sd/sdcard: Convert SEND_CSD/SEND_CID to generic_read_byte (CMD9 &
    10)
  hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK / READ_MULTIPLE_BLOCK cases
  hw/sd/sdcard: Convert READ_SINGLE_BLOCK to generic_read_byte (CMD17)
  hw/sd/sdcard: Convert SEND_TUNING_BLOCK to generic_read_byte (CMD19)
  hw/sd/sdcard: Convert SEND_WRITE_PROT to generic_read_byte (CMD30)
  hw/sd/sdcard: Convert GEN_CMD to generic_read_byte (CMD56)
  hw/sd/sdcard: Convert SD_STATUS to generic_read_byte (ACMD13)
  hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to generic_read_byte (ACMD22)
  hw/sd/sdcard: Convert SEND_SCR to generic_read_byte (ACMD51)

 hw/sd/sd.c | 223 ++++++++++++++++++++++++-----------------------------
 1 file changed, 100 insertions(+), 123 deletions(-)

-- 
2.41.0



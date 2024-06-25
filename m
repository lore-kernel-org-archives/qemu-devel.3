Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AF4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzNt-0007r3-6s; Tue, 25 Jun 2024 02:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNo-0007k2-Mv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:24 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNl-0005Vh-E4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:23 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ec408c6d94so58881761fa.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295819; x=1719900619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOXFsLpSPLofRD0Jmvs9SG5wPUgCX8BKUuO9YF3zklc=;
 b=iATWOa5ql23tTfL0+JTMPQJb1sAn0DsTaa1RPgbRKSmY6CTFYNu/64C5deoBwIYD5g
 XlvuGEsTFNMRaNDv4ArHFzsXwLO7gPNVNHfE4u3jUrQOnWGptWjgCx3sjOQW93V20zam
 RV6RXL9L1QnK8gWKDef9lAugU7t7/B4NNy7nUNnVsDBi5QOkAHSHkbBzSx9PJFJIq223
 yzbVRxpp2/hpqS288VWw3ZIIgj8jGgbZPkane4EYp38kINuyQgcXwOZd3lc/8rpVCuJh
 kvEnnZI/LJQFUjsy37EINZ+NlgkXn781BD5IU8ujVUTcxnTUwDyuvajthdw3rRdCX5ko
 fQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295819; x=1719900619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOXFsLpSPLofRD0Jmvs9SG5wPUgCX8BKUuO9YF3zklc=;
 b=eDaA4qSt4Z3dMsrcArkmAE9AZPKrssb+eFFjKmj/H2z8wy0MU3SWX0PRIbs36/FpUI
 bxqwgIL8R/APVKeV6ffWse8dxIdTyyRaiy8nD13UQmEzuGav0vDL+Q+avt65dxkWUEV3
 znafC0ng/RdwC00L7ARd2Q+gvwaMx70KXmk2bB9M3rjD+rvodbixrgc9lbyZc6ObRCMi
 z39pSvzpL/r6uQ2eEh4601a0TFL6KZNVSACawUzYrVQYS6YL/wmxMcwVBqiv2xC9cquW
 FPEVy9bwEa7nPLEEDRXCs/Zj7MqeDrDM+WpqnjI/aM6xDe5Dq0ASW/lBHUskYh07APve
 hjeg==
X-Gm-Message-State: AOJu0YyxFdCB6Wsjb51FBmDOKhExoEC3haOKN4WBAL8PwZ0919+NBh/4
 GFdQhoMyRTUlZeITSyV7e8aWUbS7vqITf62sgj/b1p6kW/TNCdK+XMt6PDW1hEQRK4FoYYoT3Ra
 X
X-Google-Smtp-Source: AGHT+IHpqW7HH4fYnn3lac7QLbYxjp/hyXbHypprvzGSXLYYn4aick7X/I0IBcYC8f0tHeVyeIGZTw==
X-Received: by 2002:a2e:a546:0:b0:2ec:6cbe:5e4c with SMTP id
 38308e7fff4ca-2ec6cbe606amr8161451fa.26.1719295818627; 
 Mon, 24 Jun 2024 23:10:18 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366389b8ad2sm11859573f8f.33.2024.06.24.23.10.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/11] hw/sd/sd: Introduce sd_cmd_to_sendingdata() and
 sd_generic_read_byte()
Date: Tue, 25 Jun 2024 08:10:04 +0200
Message-ID: <20240625061015.24095-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Based-on: <20240625055354.23273-1-philmd@linaro.org>

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



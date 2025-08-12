Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED87C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpNe-0002SJ-4m; Tue, 12 Aug 2025 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpNY-0002RJ-R4
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:49:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpNR-0005D5-1T
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:49:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b914a9c77dso373588f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755006557; x=1755611357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=sZ/it/ib4l4w+mGLGkiYEeIrZBveOb2YSfV2ffrev1XD7hF9F8qq1hYCOw5VfIIJwn
 zfZ3vg9Eu9tsHtHIU5UvjRfdWgWe5WGq/8jfQN/mS8LH1iGQFaGiixWQZWvBK5mY5kE5
 tyzZ2ccy38A0W0Bmc+G1yvKjyuAdToQIBMTT0CSVT/vQtV32qeJVTCM/K2K4sB4NHadB
 23VVBUgR0S0e5rpEzzQKLRkEYn6bdM9jzZzckLuipjT4C2kKyziGHKW+wiKvaR2RIK7K
 aYu8uDfv6goPvM4mjqYz3u0V84Q+2Gt/I4A0N3z5mGoWXOISJDDlrisxJJUsK1zn4Ita
 2cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755006557; x=1755611357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=ZfFY1EoLZUsEJdzIKDqgqbkTKZTKXE2T76P3vU0IXcqAlS+COmyQYIopyxhp5DMuSQ
 JptkxPRvnTV8T/glkKsG9dlczSOD1JgVFYsznA3MoPMEkQPGeHwtyjpHsFHtivb9pjcj
 r3C4VOVSRX0RNfC31aWClZb4yorhcYaPtWh39DV1UNN4iNXd7sCFPH/OuZ6ksLBonK/Q
 M2IUp+lvAj2RtSewEw+wzv058SNaRUALAMb1uEZhbNpMg6MkXPzJFVKVyz/m24admyZQ
 MCF4xqp30iy0UwAHQSyJSuF/2aKWsgM11M5E7fshyrrB8RzMFDofJyYFlW9hCU74YYCU
 Vgjg==
X-Gm-Message-State: AOJu0YxArxO9EuooC47WAFKA+w7JG3In//mTsFJ7eMkpXmV1copoxsHl
 6GvezF6cQ80tuCpofLad0DfB6NYl0+kUKC4plPGunb92rkMn6bKDAPNZlYJKXmTVlomW0rnU3PW
 mavGw
X-Gm-Gg: ASbGncuKfyLEtfJAA+Dbr1CiCVtgJBozCHWmGUUwgc/u+iFnX1i5h7+EfmWTHFeD59+
 RMNm89OPhT3bhslKwoQ0XaW1MmgO1J1Zs22bssn+Q+rOLxTMsgT2XSGLnfV7NpapFvNlMVutBMx
 /W04KfI/twoi+3I2UCtbnnLWGYGrximPNf1wktjn5IzV4AAOlDxaAbvx0WXysadI97ZqfFQ2N/B
 ccizA92ZtOxtZC28Ik5UOYM0d9heCi2o570seAYjhzMZrIR3T/aNFzDqxbO5ZhvgKBtnLTmtmhh
 9xV+JhXHylVhj3uvWsZ2B4MBlNctd0L4sjbTCgnAml6Y/PBlTmIjcJd/NPy84FRWZVUJZocyJ2O
 g6OK9/NhsBVXkfM7MvGlTuZngEzo0hGheKg3l90zfvW4OpyHv8yjt/a/W0sDozILwCmUtyxFv
X-Google-Smtp-Source: AGHT+IE8pu3OXbeG+jBBuMKXuDz/4BnMWqDYUQjlDIS+PqeYTGB7oKj7J3/KJN/C/WOp93Ycp4Y0+A==
X-Received: by 2002:a5d:5f45:0:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3b900b55170mr12238385f8f.48.1755006557198; 
 Tue, 12 Aug 2025 06:49:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5869cccsm327936025e9.17.2025.08.12.06.49.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 06:49:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair@alistair23.me>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH-for-10.1 v2 1/3] hw/sd/ssi-sd: Return noise (dummy byte) when
 no card connected
Date: Tue, 12 Aug 2025 15:49:07 +0200
Message-ID: <20250812134909.69531-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812134909.69531-1-philmd@linaro.org>
References: <20250812134909.69531-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
code") exposed a bug in the SPI adapter: if no SD card is plugged,
we are returning "there is a card with an error". This is wrong,
we shouldn't return any particular packet response, but the noise
shifted on the MISO line. Return the dummy byte, otherwise we get:

  qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/sd/ssi-sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 594dead19ee..3aacbd03871 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
     SDRequest request;
     uint8_t longresp[5];
 
+    if (!sdbus_get_inserted(&s->sdbus)) {
+        return SSI_DUMMY;
+    }
+
     /*
      * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
      *
-- 
2.49.0



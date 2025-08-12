Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61919CA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpYs-0005fl-3t; Tue, 12 Aug 2025 10:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpYp-0005ea-DK
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:01:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpYh-0007Cg-T8
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:01:07 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b77b8750acso3457081f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755007254; x=1755612054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=NQjUGsutjjDwPi0Eu//8ITfH+zgI9gvFT0bm8J3qj1PU+RkbOutlmBe76omacAuzQj
 o9IbYePa3+yeqi6vbWMf3dI5pdNrrieqXglPrkrBNN8qwOUGiRXy+LtDJsJKwuhLkuQp
 NVc98xMSO0BLekapHDQVkUV2dguyBiVWsa0Og9xYR4kyi1LmNvIaG5evh67XYppIrr4f
 dG0Td55/VYfGK9pqxzr0F5cEFJkfBbPvGdFYOrsh6k4HH31TVRQc7d/Bo/GSIqBghF/m
 OnBfvl1VbzkQXR3W1vB6XZSEWSZC4XE8OsKgIkcgzA8RQbhPkssRfqpW9QUwUMnlcIP4
 wR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007254; x=1755612054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=phyw59QCEKv9qR0aHfjulRQ2cVn5qPE2TlI3ga14qbkF/thL1NJcXr1d9bCav0ea+u
 k2cRUhyxHbYCBmqJqTOY5mFhDLehDGdaByalawhmQ0J30syIHNLtxQRM71lBXfBGFDZ2
 Tg+NI3dNQfeOeS0ir0m6wZm9iNVD/Vxoae5IErNxTdenxItbnCRXUVk6OgTFMYEY+uBS
 YNOurospVc6XdraDpSzXLu47RwzWUmrGC3VUBo/XZQxMIxbVK+9YCOPjLmHg0s/+vDII
 5oxXFfRjr9Yc6hMcjY+yNwVnFDk/DQZwD1RqhmPOpaE8Ir5PcA67u1g0CEm+DmYlJfrI
 DzvQ==
X-Gm-Message-State: AOJu0YxNJ45rO3Ho4amqwuINxM2NyGmtOoMtC+DOwOANiB6KF/OQuhsc
 T1wxT/hYUHj1izXZi+UwYn+ug7XnxH2HOleTkRLcwVQ1gXizKa2GeBXa5JwKHwe3C9aSF5F+Ckl
 QALJr
X-Gm-Gg: ASbGncudo3tcToUyL2KtTr5CwbtiRPadQ9x8rFZylV6vTerkxiMV4SsxziflR9ylWlh
 01XEO6P5RqBQqvlQ76gVMuTMTDBXgjU5c/DM+ao2IM++GoszovsXaNwGILq1RbcJCYC4ujV7UUX
 HYftnc/XpJ+nvdc8P2avL2vY51DkqcF/o0OVIHBFYlkdPD17jhvLdU64O7cz56W6Y6Wfkx90OWb
 YCQBrTGGi3jKc3TKWFW3S2zp8kRuZptzUS2A1LUIrxn3ZbFfWxBdtia6sT0pNjYWHU1IXE+DQmi
 ROAgX2EeCp7i2D9oYWZGW67byAvwcguslnBX9MpNnEUxyU4QkCMIp8ZiHgpbHy1HtJ3VTb6ANNk
 8kev4Pz281B5Fz9SWHofrL0pzHeir1GQ9aOQ2OzotUU2fx0naQDLIQxOwT/lGXk6lCcFH5mKaBP
 OBfAHhrOw=
X-Google-Smtp-Source: AGHT+IGNhGKlo9hz2PgGT9ESQgIjCEZR5KYxSMryDJgg0aFZlcpy6+fpWgOaMQN4yYfsATMUqbaBgA==
X-Received: by 2002:a05:6000:25c7:b0:3b7:915c:5fa3 with SMTP id
 ffacd0b85a97d-3b9111b5187mr3588348f8f.24.1755007254167; 
 Tue, 12 Aug 2025 07:00:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c338c7dsm44599553f8f.0.2025.08.12.07.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 07:00:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH-for-10.1 RESEND v2 1/3] hw/sd/ssi-sd: Return noise (dummy
 byte) when no card connected
Date: Tue, 12 Aug 2025 16:00:45 +0200
Message-ID: <20250812140047.69834-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812140047.69834-1-philmd@linaro.org>
References: <20250812140047.69834-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE3ECCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIqhM-0007Vx-Tk; Fri, 01 May 2026 12:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIqhL-0007VY-1P
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:26:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIqhJ-00081Z-EZ
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:26:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so20025815e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777652796; x=1778257596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmiMA9qK8lid2+4XBA9PvoBX50ox7NRv+ljhQLzau9w=;
 b=kf3+wbzTdaTIX4D2Jgr8+fL4IgHqUrqgt7CGQv2+FwtOYRtA8Ksmj4ZNVebAtsrHs8
 S3qB2zUBiV9kxIs/t7V+6nUz2QH/vWSBnqfZTDSzapfdPlcqB6b7PnXFjcZDDuuSpsaI
 R1dTkc9h5P2gMnbeYC+4qK0D/XKDpitAEilUNHMPqBCgsaII0cA3iwBahswC/XFNjeyU
 /qayJJAR+MlSMirvPuv9pNQ7/OrOXS3DavinsM98BxFs76CkDoeOer0RU6ncl2504rNx
 DhXTw4QN593I0eXqJg1Nt9I64KgyzYGDXuI0EUm0RyGhlbZ/1hfG5FiYqJ7aAaayhU7W
 pJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777652796; x=1778257596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmiMA9qK8lid2+4XBA9PvoBX50ox7NRv+ljhQLzau9w=;
 b=kPtuIIpxip2FccMY5Po7IK7u/u6CRothEO+ZxTCtG7Km7OwOkCfKGo9URWbHT2oEnx
 AxjKanGslz2HkYz86qemjpgN+pQ1SLOtGs8HQkOAn5V3TS68FwG9ZFvKqdwQLEs38AJ8
 dsl7LPyNI2OANr/JrReQGZWfsTMDPQdfjo7Yp6RzANLqPn61ZmH7JZ7kUG86T6IPKtGB
 nuaZsksvpS5VwgVqXn7AlEP75UuCY++CYngrWwF5ydAFzrC6RUGVYcPJl9yR9bymCbJ3
 yzeH0f6TI0DgVdW5HaMKc8uOUHdQQZ6+IneE5mdQ8p5TPgwCXIbTufRfpYJmUQ9E0rRC
 +njA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ye7rWE7qbvpuFKI3mpdbtuB1CUW9N6Qe7gTBp5wN08ma6eX1nEVLYnhF9U1PIrfT0lM6HLvy9GEoj@nongnu.org
X-Gm-Message-State: AOJu0YyP5mFyCcl9kl+xDy2yHV4xzQ20UKkCpgQIsO6RB5sSwT3nbM2p
 xOKMysGxEocsrE7V4mFVPAh9GFlshRfGAZf3cr1WCrDrvUY0iG/jRbGbxGLlC+biS7k=
X-Gm-Gg: AeBDievyfDrfmaPCIoeQNsKqzaFXKySRLFlKBIjiXWTtSko9OoZ5bn1ZmygzLJm4THu
 qTY+EBzGHcXLhS8eSs6rvAygPvKep/7EfbloioliWtqZ97SF0MMChM1R3Th2ortb/NrkIXcgqO4
 YMUqkY+KfzUbiJK3ykHzDxGbI0sRc5Ybp6PajutNduI4udSwkSA97GFYEAfy4vDJP45Q7bG8rWg
 ojRX6Yy3s3bSl+XsGhzN5dohImsgEuncuA9EqgB8A8TdDjs91q2HEqPYCH17DJgvC8AOdcpdhx7
 98lIJ2DMCRoaQLyOScA/BvqQlXpW9dm83Lg+hM89oAHIADg0nxscs9v+HFaV4IpWEagEj7IlOjC
 dqncd5Ga7hQilAwl4aoBpQic5ctv0zv/ZryUGbbAmm0AmbIqD7lT2qPABYniZCZEkpnluHc2oJq
 /1BmhsehVZySjmJabhpV0/juJxa22SipMR8tTt4x1eAqJb57/hg2NkdctSYXXRz62OqdaoDKIkr
 GebPcko2vQtTBdCT6nHbDkDn2D6WIisMqp8v4tmJg==
X-Received: by 2002:a05:600c:6285:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-48a84485623mr137002515e9.28.1777652795666; 
 Fri, 01 May 2026 09:26:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c865esm129172755e9.5.2026.05.01.09.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:26:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>
Subject: [PATCH] hw/i2c/microbit_i2c: Don't index off end of
 twi_read_sequence[]
Date: Fri,  1 May 2026 17:26:34 +0100
Message-ID: <20260501162634.4092394-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If the guest tries to read more bytes from our fake stub I2C device
than we have provided, we incorrectly read one byte beyond the end of
this array. Avoid this, and instead keep reporting the RXD register
as containing the last byte of the "data transfer".

Cc: qemu-stable@nongnu.org
Fixes: 9d68bf564ec ("arm: Stub out NRF51 TWI magnetometer/accelerometer detection")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3408
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/microbit_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 2291d6370e..d9689b6f1a 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -41,8 +41,13 @@ static uint64_t microbit_i2c_read(void *opaque, hwaddr addr, unsigned int size)
         data = 0x01;
         break;
     case NRF51_TWI_REG_RXD:
+        /*
+         * Return the next byte from our fake data sequence. If
+         * the guest keeps reading the register after that, keep
+         * returning the same last byte value.
+         */
         data = twi_read_sequence[s->read_idx];
-        if (s->read_idx < G_N_ELEMENTS(twi_read_sequence)) {
+        if (s->read_idx + 1 < G_N_ELEMENTS(twi_read_sequence)) {
             s->read_idx++;
         }
         break;
-- 
2.43.0



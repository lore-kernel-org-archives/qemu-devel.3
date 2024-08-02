Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnnX-00048Q-0u; Fri, 02 Aug 2024 04:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZnnV-00044O-U6
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:38:01 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZnnU-0007it-31
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:38:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc566ac769so58208465ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722587878; x=1723192678;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WJIpyRy6I81yiihct6rsczqT9e/JyDXswHZw9OWSliA=;
 b=xOuGTjDAUG7mZCmI882j8j0fFdxQ2OnfkvxmIga5eOJoK5/TWsDvM32rYUIpxW+dA6
 vPzJy9c+q7b/BX5IvGNb5aHRd/9gdUfqgWTmtqbmskek6IFyWyOX4SvWHxm2HJA/67E0
 lQBUp5MapL1UFAbaipJhj3HPBKXYDYieh4wZGhiE9andw4z18hgKBxIAYJ2rI3bs5VG/
 8+W0U9f1yexqpc5Iyr6dTOtsKjnA+X8HFJcb5NONaPbH+hDbaRTWUsVRgqXbfYFd/jNt
 RN2m3ixmQjcaFRYWYCKF/Xnobm0VJh1xhUlKWM21ygDIZRAuWrSKWRxpDgIoAgNjcoh2
 X0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587878; x=1723192678;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJIpyRy6I81yiihct6rsczqT9e/JyDXswHZw9OWSliA=;
 b=M6bQpgsIO3B+DMnUxI3nvP47pFVpx2LREeqSSBiKj5jQh+wa7bg3lrfitcp98jKWkS
 8Pi0TSGRRVXzuJ2hxoVZGvzIGcFImOUfKsMZ6hyaR+STo7EXt3GUSXAJ9S2NygzTEKlJ
 kYAUGbT6jlgxArEXcUVydMdOfuN81fq5ZiztHcKTxnVEesONFewG7YNW1xkblkznieov
 9e50DaO3Sy2Hp9IJXTdtm9WotehikmRQYZIrgSiIB++BDW0Qnr9IjSHwIGkcbcZ/Gt1t
 jmUjSp2DZIZt7P46ejhBNHZAc7Y/DAjoRNwhKPUg+4dB20G0g721/Vy1JwhMcARbENVE
 7+nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk3wwCyrUsndsmGfXimyADzFZ10xo3bK/pJlWndsUeqW5yZeoB46TwCzynuWYWbWAfCtHZlvS1BG1e85IeDOGtHw3ykq0=
X-Gm-Message-State: AOJu0Yy2JmONCVPTlHcTqxHvab714eKTb4LoGI68UcBngKoSlcp3vZ0U
 yNSzoV4KM6Hky1hzchpR21E7kAGMQSed4nhceXJ4CtczOLMjB6KTMOQEjYdJyGM=
X-Google-Smtp-Source: AGHT+IHBu7VrMfwxBriL69FaXJr60emKRrnFuW8SoViaV4xCP/8NwXbK0j4S/SB+Y7Xzqq0FFEUDNA==
X-Received: by 2002:a17:902:cf01:b0:1fb:4a57:7cba with SMTP id
 d9443c01a7336-1ff572f812bmr33603635ad.34.1722587878557; 
 Fri, 02 Aug 2024 01:37:58 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff5929ad84sm11703835ad.270.2024.08.02.01.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 01:37:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 17:37:52 +0900
Subject: [PATCH] hvf: arm: Fix hvf_sysreg_read_cp() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
X-B4-Tracking: v=1; b=H4sIAN+arGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMj3YyyNF0TA0tzw2RTk9Tk5DQloMqCotS0zAqwKdGxtbUAd0rl3VU
 AAAA=
To: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Commit 05b8d7249109 ("hvf: arm: Do not advance PC when raising an
exception") changed val from uint64_t to a pointer to uint64_t in
hvf_sysreg_read(), but didn't change its hvf_sysreg_read_cp() call.

Fixes: 05b8d7249109 ("hvf: arm: Do not advance PC when raising an exception")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c1496ad5be9b..ace83671b594 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1280,7 +1280,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
-        if (hvf_sysreg_read_cp(cpu, reg, &val)) {
+        if (hvf_sysreg_read_cp(cpu, reg, val)) {
             return 0;
         }
         break;

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240802-hvf-40971c54eccf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



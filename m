Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF7FE87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI0R-0000yA-63; Tue, 03 Feb 2026 10:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0N-0000ll-BZ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI0J-0002T5-D9
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so44397425e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131266; x=1770736066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nc0B+uW3ETyKEu5nC1EKxxR26qikxyzqNn3rfro40aA=;
 b=NrI53almzVsK0yBgzYbpia9O6NPWyLM5B8yqbcodMNu3cv0DPrQuFl30bNdCjbSHqA
 12nw3bp50DobvbdqHN1kdNazG9JUeUduL+BIeIJ6CjvERwNMTyuJrCdlBSvgidRdSd3C
 t6nuwL/jT5z8+SSPPBZOJDTBgvre3dWYJ/GAMSelf6NK6X8yXMQxTuIDWBR7A5i2owYL
 Iri2uRWyPrwDtS4raaszjTNU137lfAzfPiB4yHlx43RTphxFC23MTpjUp8tftpSGbsnu
 AI+6XMYwCzdfZ2OzOBW2qOt5DmMO6SGCbL+6FEhLwhtHDadgEOaLz186MevtIv9LFeL0
 Fmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131266; x=1770736066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nc0B+uW3ETyKEu5nC1EKxxR26qikxyzqNn3rfro40aA=;
 b=hvCbDASP8T5YWEF1pr7PKecSb401G5nVKAT7SlRrRElmJSY1BF+upP+q5PGyxie3H/
 s/fd4RXJ8l3uPPfNdtI3Hh8VFBAsGOqq3uOXqCHrv0K/ziiXL5pBozFcfuIzTOmGavug
 hdm+6FKN8c77aOZR8zLcU65KLckNTbCZN//owKFRKHVNXFcLq07ibWlCdxpsHvBwVxbT
 k0NLOLEQBlq4GNomNTTBdPP+iZrT5glbhBWRDKXqludvbz4f5j7d6ndR6vqZ97kb/v3S
 Q4J1DB6cijsfKtgPBjljWDidwtqCXQfM5BTmkTgKVEvMJYQX4hT3inLHWOKVYJZ0Qwdn
 lKVw==
X-Gm-Message-State: AOJu0YwE9Rgk8Ews1W6JyCLFj8CzqGKkdAwkTRotTMTYRLM4IP950k0b
 Pg1IcXPrg1gIbOrXFXD0qhqbFcAZ7mZ0QvhosjOIfN2IIwfN43lsY7JvFVTdjnNjer7rPAo/j6q
 e+L6KbbM=
X-Gm-Gg: AZuq6aJc1onykh9mo0FC1PVTfmQOOQ0nbyb+KxzzhTyxtDA55BZaVyNJyx/Y6iVhPxl
 Hl/GW04p7C5TcbaUWNG9QPRsfJ0AFPClp7e8CrnWl0olaIlfL5JXPSjwIHdMuajclbJ8DJBQPZp
 hA0qaMxhrHqDUp1Eu6476qQTqHkWY1oBKRVOEOqVG2V0r778Vh0AIHrFbFuwxC1VRv6m6jKXMf2
 XSOvR2ejb15AAZOIjhBmb6WLZ4OloU03wDSJ1snxYwCvfON5xVlD113Dud9uJ2SyQ7J5/5rlEBm
 O/IFWT6c2zENDEfJs3tLnwTktDBOZzwV2RjP/Vk3dCQwu5CQjmhtYHAzwkohaAyOhQx24IMqc7I
 qoKSmP8s9xqHnbxq+ETCCqztWTbu0dzetL7K51UTa/YXjmQ2EqTtV8rG0r4mShIwWvW/D/p+7hF
 5ugCIm9DawWA5F2SKAgYazQ9OBjPaDfEMTi8ACZyA6zM2LkqAnT2UL1XkBCicN
X-Received: by 2002:a05:600c:680a:b0:47e:e20e:bbb0 with SMTP id
 5b1f17b1804b1-482db452201mr235159165e9.6.1770131265565; 
 Tue, 03 Feb 2026 07:07:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e256482esm119389345e9.12.2026.02.03.07.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] target/arm: Have arm_sctlr_b() take a const @env argument
Date: Tue,  3 Feb 2026 16:04:32 +0100
Message-ID: <20260203150436.71907-28-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

arm_sctlr_b() only access @env read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-5-philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 40237168419..e146f7e6c41 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2385,7 +2385,7 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
     return (GET_IDREG(&cpu->isar, CLIDR) & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
 }
 
-static inline bool arm_sctlr_b(CPUARMState *env)
+static inline bool arm_sctlr_b(const CPUARMState *env)
 {
     return
         /* We need not implement SCTLR.ITD in user-mode emulation, so
-- 
2.52.0



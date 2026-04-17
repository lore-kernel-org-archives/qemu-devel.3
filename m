Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D6F4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgyc-0005qC-K7; Fri, 17 Apr 2026 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyb-0005ov-8k
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyZ-0002o0-1N
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so959408f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423785; x=1777028585; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qJ2AQaxAlhqc69Sli55vinppxUwsyZJgPbn1fvffd60=;
 b=sfejDpwukzc/hf5ZfG+ZkIsH7lLll4cwU5mBLeFwdGGVJ6s6XcjWcgSDrwGO+xT6mG
 0/9o3XmfevusnVlu01ZKX/9i3zR/OFKqRuAxuY7omn/w7oxkJJyWBjd3DhEkGw9ux5dQ
 AqGNvbSp1R6EoLM5Qp5oN6Kuo9+u6TSfMDa4WBz12xEbbO9gDjZYGkIA8OHLFx+HB7sD
 BwqeyAwhc6FXBYqXs3M24XHvQOJLjFznq+vqdbN+bKHFEoVq+wHpoCVUkP17kn0OzmEA
 q92jc8N23IF0D2RqVqo/YrLHLuO8AE298A5IliJxouJd06QnHJ9vwUmEH6Kd+szjTQSk
 4LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423785; x=1777028585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qJ2AQaxAlhqc69Sli55vinppxUwsyZJgPbn1fvffd60=;
 b=NRrXVOwF0nqCHSY17ha1NWX/xlKOBAz8dzpjl/SyIdNnVTJADU6tAORcrgp4oHpHoc
 xjNgCwUCeDkMhExNtxAE69cIwBGj6xtxHvH1rV3WFjk0gv8r7f33ofgUt5uhf6Yu/LME
 6nl5bxUFqWoi/nQSuQwk3xIbx/piW7qsCkYTYoq3pUrO++5gV0ZBROlTlGo4PNpKwBvQ
 9rVgrKqtFjuKcLltSuttL/0le/S6PFHJ8O0OE23Ho8ZSsvq0f7JQDKWj4Ec7a6wdrRaM
 PodKmoZ1qzPk04/TNtE5q4GAzlKiNkjs7R9yr6+MBV9+KpxssDA7DCWqmX+ppLJwajiE
 0bEQ==
X-Gm-Message-State: AOJu0Yyx+q6HK/jnf5XOG7zFzuaU4ISsPXTtaNEYalPoUcx35OJ4FDhU
 OFPWYyqs+swAX+mLtSksufWbaiozxsLryrme6xOGWADOJcUalTCsNfoyFG92LO6LmmG2ViQyMN6
 Vw2E9
X-Gm-Gg: AeBDiesbv3JSq32B1lTzaxIesjil9eZS4wVqYITNEQdqpekArSR9gAEWNK2skdYnOHY
 uVbM3ojsQri58hNU60FwknXXoltb8Ebc/AO4ksY5kxjU1dIbb5ihTYTsChy6aRybhD8jSgTq27U
 6WH5oj191AwmfYbIyn9S/7vs2Ntmg3ancqjIQzUU72nAdWIUNOhX0NoGeznodrXke7oZC4jtjmE
 ++49nUsgrhFfb+DIbx9PR3Z07dvmPPJ/jflAgLFzljlcWbc61pcN1WJpTKSQVsJzIODCDwBOqoQ
 +S6KLvKHteyOnD594LHxf/KRoYyzZzEAkOqa3HmAsewQB169EjhqxlBdh/WhR96feZLk9gg6Eyg
 lnndbTbQkGgZLkXpFmY43qyUFbxXCrlsnRchd9gjcnbQkZUzrrE65oW5VoNVj44vvVUYykpRWzl
 gzOHch8BJg9FH4pezbJgUPjCCz4YXEqh8rXP9/4w==
X-Received: by 2002:a5d:5848:0:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43fe4073758mr3653908f8f.12.1776423785232; 
 Fri, 17 Apr 2026 04:03:05 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d023:c0db:d3ea:590d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm3811934f8f.37.2026.04.17.04.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:03:03 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 17 Apr 2026 12:02:54 +0100
Subject: [PATCH v2 2/4] target/arm/cpu.h: New GPCCR fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-jmac-feat_rme_gdi-v2-2-7cf5131aeb60@linaro.org>
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x433.google.com
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

Add SA, NSP, NA6, NA7 for GDI and GPCBW for good measure.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20..1cfef02dc0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2089,6 +2089,11 @@ FIELD(GPCCR, TBGPCD, 18, 1)
 FIELD(GPCCR, NSO, 19, 1)
 FIELD(GPCCR, L0GPTSZ, 20, 4)
 FIELD(GPCCR, APPSAA, 24, 1)
+FIELD(GPCCR, SA, 25, 1)
+FIELD(GPCCR, NSP, 26, 1)
+FIELD(GPCCR, NA6, 27, 1)
+FIELD(GPCCR, NA7, 28, 1)
+FIELD(GPCCR, GPCBW, 29, 1)
 
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)

-- 
2.43.0



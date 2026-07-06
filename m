Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E163C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggid-0007BY-2P; Mon, 06 Jul 2026 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiD-0006zl-Cy
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiA-0003Fq-4N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b1710405so17300365e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334281; x=1783939081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ODf57zRkHDHd0Db6mUb52CYFhVg4YiM5UomsMwkvL+I=;
 b=uMcpQXg0IVBWs91kWboxsOZdey8xCgcO3aq+o7HGc79tz2IkneRPvQzL9z/G7DLKMF
 +ArpyQaYd57KZsuC3GXPxHiziqbE+zgIKqanFw5BqTlUfncE1j3mP9lwb1hNdcy/wW7O
 k6ZKfXdrIHDwo9LQ+8wbwO+I5JuNPfeT0/+IsV6wfgwEIseSNNkXbZ7gWfAw5IwLEMET
 drkUKXhaR12Eiglc/tj656fAo2xtmW2CYeAmGbtxThjkLiZvf5zxkNi97f0Uw5dNCBCS
 U+QsGGtZi8MwrP3i8JSFqTJMG2ex+w8vh+eYuJBU3AIVMDVUdLxL2eRM5t7tIMpXZhzd
 Y5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334281; x=1783939081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ODf57zRkHDHd0Db6mUb52CYFhVg4YiM5UomsMwkvL+I=;
 b=fQaXD4x/bh9FEZKdOBht0XcQ0loD7csqPGXimUw7VA/pLeQQk2c7Fs82CzLHl8G/NV
 By5S+1vVuucux19F+7NXlimCq7CcWHLEDd2pC/oMuxHCjo/57ZImWm1DsmfkvoLRHH6D
 1G72W+LzW/2Z/2O5OFdR/o7jGXhZ0lglV8KRROlE0+LGxpYgsi1/mjeAJMWRDNze9x7Q
 7vO80Gmsv+nTZIhmejht1uqFn2MiSCWAIJeSj8aakjkSaAgiRnRYV+abqeHaVcah83j6
 DcoqYkLs93aKtTkAQ/48cq74bEN+DH4KmAuQL0eGInGSxC93IegukbO0ONmdMCpNJaPQ
 CSQA==
X-Gm-Message-State: AOJu0YzLi/LxQbuIw6rQHBsj0aqsBFerXcuEWnoFzHezGQcB/mYC/68Q
 oEElEZs33WhUShLC6OHEpS+S5QnVJgYBPcHF+Vz0BX0qTI805yNT/oLCaqS2iRcdeWAiEfUcNRC
 9qRd5BuUisQ==
X-Gm-Gg: AfdE7clPZpBm4sgZoS+pxnqMKn6t044U07AEdklay/2SWlulbhzfdfnGRA4svNFPVwY
 dBCPb5HjxunA4iPD+C7qF0P4bAC9RRKufECrCtbVPZERCcLBq3LedA1f4zRV2ShF4mtPU/kk6fq
 phBcAZ0XtZvhRQ3uvsEv5bDfk6YdaSTbMeO6FSj1dDW4G9MWm2gOq9dk++zWzi37DhI4eipjIrH
 lcrhgY/cOEyg9JFnwqDE4aY44d36OL0EdbGaNaDrgEUYoWLZ08CHtAqEpWB3XqDFtYW7SW9Jb6X
 22g4qI6AjdI7eyttL9Uot6DwkxxzrccqRXAgMExBNO5VQ5sDxm4lhhws0FR85luN4wKtmZdC0Ji
 6vfbFjqfUocjf7MWQWKm0Eq6nrS86yRpt6a8GjHGSm8I7B+C/ngyRCJV7ZGxZAqhuKNvI4aFz/F
 LHb7D4lj78ovyhwvNxq7ySawcaPL7Ufl0q3Izjd0pblqMpYfstr8tccYCjFZ7xvf0Wwj0yj9dFI
 Dde0kGNCVUuOs7OTD/sPA==
X-Received: by 2002:a05:600c:c166:b0:492:63c3:8eeb with SMTP id
 5b1f17b1804b1-493d11fe04cmr111773225e9.35.1783334280743; 
 Mon, 06 Jul 2026 03:38:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/49] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
Date: Mon,  6 Jul 2026 11:37:09 +0100
Message-ID: <20260706103752.320511-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-3-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ae3952a1ed..1f9eb56a94 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1269,6 +1269,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ISAR3);
     t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
     SET_IDREG(isar, ID_AA64ISAR3, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);
-- 
2.43.0



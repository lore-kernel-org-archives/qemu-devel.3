Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E20FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYp-0006UL-3y; Mon, 21 Jul 2025 09:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYO-0000oA-1S
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYL-0005La-Sn
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4561607166aso33175555e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104456; x=1753709256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PJkBRMoOzj+DWFocUGZgXAN9NSStCVAuKc8pVOqbkQ4=;
 b=U33EbtRAWraA5pT55XxcLNlZeA4roVXaEcH/ey6ex45tc36xxeYyRHBozuUJdP43ek
 1/mQ3fZZpMedG3PTNEwDVLSD1Vlt7ITTV2kKHbAiCHrNizmAxOiYeTQkKRWZNPOhCdMb
 6PxkZww0G53mT1L6FM0evKscG++ZKLkqujvqIqD5+fTz5QIH/yfcOP9x2ILiOy4JeSyH
 0LHdn6N+QIjCRt9JH3HCIao0ME3Nbg8n550SvQNJt8AeMO9jRb2upWm1fMwDaUtgGSQJ
 FMvKbvIgyY3/37C2oasLUg1UbFLJwAbwgoO0O0+tQF4HwXa3xT75axfx4EXkrN89OJeV
 C3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104456; x=1753709256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJkBRMoOzj+DWFocUGZgXAN9NSStCVAuKc8pVOqbkQ4=;
 b=xU590/IcAuIKYTLeavFFDmsfVOQJRtTgzV+D3lMUfRB3xYu3S8MztPKBv1uAAwmI6i
 jA6dz5aqbkXjosl28ZBINaAt8SRbF14he4mF4kylBdCNr/bxczJyjDQaCK7JibBV6LTh
 vCzT3RtFoLaRUCkJ7oNsf7/iKsOpuSJfUORBQ+yFyyyAI4ea2RDQdvkRWNOkHaWnncWB
 q/EEqD9DsKP1OaAlGcRZ77dGd9z+Ke6VpldLa1Hd5b7NZVXZLV47FkB1eAaXwLuobFPr
 c53NCOtx/SxZXbQ/CFj4e9y150l6Xhyt/laTK5ODvY0xTGMWlhFIxSjB+UzQBrbGUB+6
 PhjA==
X-Gm-Message-State: AOJu0Yx+njZa0je1T+UEPW4TF6ySCVIhvXDoMirsnPIXYqrLiGZXhOCG
 TBFnieNSA0eOGXggS56EpvXky3BzYTQ2KZqY5XutJ1PquosNw6kgX7Xelli4XdULp6kSXhgxIQc
 VIMen
X-Gm-Gg: ASbGncvD9ufzhD9I1rEYjET/gwWrAYc8FfdrxYo7W9JuyapUJc5Pi1BuEkTLshYo+94
 Zk3S3VUOfgC8yD9CCv915e4M+WAy3hUgfZdyvTmC2zhADsCZUNuhI13D7KYq4XaFb8XSLLmADPd
 EMs3Q1vMJ0I2ZdqOjTnGWcuVgl4MfW5bZ8oCm5TaqPIZlt56oobfs5huTh971dHT8fxCBgnfDga
 K+mOCbZVji/RqQwiuElLgglXpKBrSkKqb6fRiTLpT/BX/SUqnNZH71P6XZLNJOH/dA0t3/7c42G
 AdXw8TsGypwsqNsgOd6hupO8Dwm/BDeCju4krokCRGVkGZunloYKcEnKqw0jZfRQJUlB6N7OIPP
 r4JdhcvhNW51zhmxNumCMglJHRkQsqcUt8hOjiAM=
X-Google-Smtp-Source: AGHT+IFetPnWGzSKV4+iOWwtFyL+4Vp390skbgBi5wB6ETHV9r+7A6TvPRwHWz5S/YdkyA+bVk5ghg==
X-Received: by 2002:a05:600c:198e:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-4562e031e7amr182363415e9.1.1753104456135; 
 Mon, 21 Jul 2025 06:27:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] target/arm: Make LD1Q decode and trans fn agree about
 a->u
Date: Mon, 21 Jul 2025 14:27:14 +0100
Message-ID: <20250721132718.2835729-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

For the LD1Q instruction (gather load of quadwords) we use the
LD1_zprz pattern with MO_128 elements.  At this element size there is
no signed vs unsigned distinction, and we only set the 'u' bit in the
arg_LD1_zprz struct because we share the code and decode struct with
smaller element sizes.

However, we set u=0 in the decode pattern line but then accidentally
asserted that it was 1 in the trans function.  Since our usual convention
is that the "default" is unsigned and we only mark operations as signed
when they really do need to extend, change the decode pattern line to
set u=1 to match the assert.

Fixes: d2aa9a804ee6 ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-11-peter.maydell@linaro.org
---
 target/arm/tcg/sve.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a77b725c876..aea7f519730 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1345,7 +1345,7 @@ LD1_zprz        1100010 11 1. ..... 11. ... ..... ..... \
 
 # LD1Q
 LD1_zprz        1100 0100 000 rm:5 101 pg:3 rn:5 rd:5 \
-                &rprr_gather_load u=0 ff=0 xs=2 esz=4 msz=4 scale=0
+                &rprr_gather_load u=1 ff=0 xs=2 esz=4 msz=4 scale=0
 
 # SVE 64-bit gather load (vector plus immediate)
 LD1_zpiz        1100010 .. 01 ..... 1.. ... ..... ..... \
-- 
2.43.0



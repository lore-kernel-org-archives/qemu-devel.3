Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA079C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 11:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufGog-0000b4-D5; Fri, 25 Jul 2025 07:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoX-0005pQ-VI
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufGoV-0000NT-Jz
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 07:42:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso21610875e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753443729; x=1754048529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sy3GkHHO6LLMK4u+dTHrbts4rqpX7n8XXc8OUmNGqkk=;
 b=bTV8JQvwZ9/M8xrFWJegNSU3qgmjucyYhERDV9y7AbN5+Umwj/l+oWMPs2iUMfhfEu
 tR2HMjoZP5EjRNV5/sR5daxvTxZO1f1g6abgedF7EsKeiFQUg8fQA3wP0ftI8RT8KihQ
 9y/zQcSr9d/ryDp18TuxYMW055v4XZ/5iY74cEPxbXcy6ikvUwEjkCGhtr3kwjPYEk48
 YIonlqqzBnUrxhDVrlpqxvw4j2fIIehTxuhk2KYX0OQgSMcLjyuzMEro+MnHIXZN9Vk7
 kb0MTrLqbwfuUhz+8rB2ITDtoHd343pzdBzvmBTk4Dnf6qPIYFxUP7HlBds8HAG5pZhw
 urOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753443729; x=1754048529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sy3GkHHO6LLMK4u+dTHrbts4rqpX7n8XXc8OUmNGqkk=;
 b=rlq0dGqf+E3/jBheal0n7XFia9V+5kPwhWRXpvmE68FKL83CfYeUjdjvFkkzFxfxGq
 6AvjG+ALAJXh4taGvQ7g8Tt3CIRUzUQv4EMKMy/guarWT0rc4Mqj7GC6dZ/FGKDhFl10
 8a+mefe8Ep6+Lixr54dOSr+xMY690A2aGsZCql0R0FAPP0JjF3rPbrIsFLmF1eFQGE8/
 Y/uj6gXg1MEZpnWI8ZTheIaetLwAaviD0W3em7WiKSriWtdCJ8C1jkxbkIT9eU2BHvYP
 4qiWTTSy7gT4yieOL4Eo0nWqU1DyJ0kgZ4CnJ7WWkqdEw+T5r4kt6MfLWU4wnFv3wSXN
 +/nw==
X-Gm-Message-State: AOJu0YyvW3++7gRVydlLz0ePfWY82iN3Yqm1GBuTrwLNM57oOdZrc13m
 BPCXk9egESG6vwavKjY7Re1phR9Ei6h317tkoVMRnRezBZ0YANGlDQkXCIiJWOCvhtNdgAXQlG2
 ig/1r
X-Gm-Gg: ASbGncv55ga/4Ylm0iG3qCICv7xWpSgWodbbHRGKHNPyc8B7FnMxb1ygJ3+5sxp6H2h
 pWpS6qpE08HMi7tRU5mG7YE2w+N1VkT0LV0QxZlFe4WoKG0fuQE3jpzsHrxthinNNbvAWFd2D0G
 UUHF9OZcL4VHzSW3cjVDqTCuQX1yVf507b5GwpruzhoO9mS4xTZzrHDkhcS1/HuzFS86LU/rHs/
 Wj3I6ixnUzm91IAn1CGx2J+MW1aWnko+3aATlu2RdvridXwurX5W9qDErUv/6Gzl0JflH/wXB4Z
 gLb4PDNbYk5AtZKo3+ni7ybYBPld0rSwp3mxSxfBmbk6u3z1aO63XEDQMbh5QvMPLbw6ZHNxrXi
 CoNzJwKzHSrsOZHR1qM+FN9l23BQa
X-Google-Smtp-Source: AGHT+IHKSvxCzeWlx2NyQoXWlsnrElYySlb0c5UpjXZPR3WbhtDMC66CXrZQGEyyNKphsddFL+adxg==
X-Received: by 2002:a05:600c:528e:b0:456:1a69:950b with SMTP id
 5b1f17b1804b1-45876547700mr12499835e9.22.1753443728580; 
 Fri, 25 Jul 2025 04:42:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870568fb1sm51230105e9.27.2025.07.25.04.42.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:42:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] target/arm: Fix LD1W, LD1D to 128-bit elements
Date: Fri, 25 Jul 2025 12:41:56 +0100
Message-ID: <20250725114158.3703254-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725114158.3703254-1-peter.maydell@linaro.org>
References: <20250725114158.3703254-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In our implementation of the SVE2p1 contiguous load to 128-bit
element insns such as LD1D (scalar plus scalar, single register), we
got the order of the arguments to the DO_LD1_2() macro wrong.  Here
the first argument is the element size and the second is the memory
size, and the element size is always the same size or larger than
the memory size.

For the 128-bit versions, we want to load either 32-bit or 64-bit
values from memory and extend them to the 128-bit vector element, but
were trying to load 128 bit values and then stuff them into 32-bit or
64-bit vector elements.  Correct the macro ordering.

Fixes: fc5f060bcb7b ("target/arm: Implement {LD1, ST1}{W, D} (128-bit element) for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250723165458.3509150-7-peter.maydell@linaro.org
---
 target/arm/tcg/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c4aaf0cc45f..c442fcb540d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6439,8 +6439,8 @@ DO_LD1_2(ld1sds, MO_64, MO_32)
 
 DO_LD1_2(ld1dd,  MO_64, MO_64)
 
-DO_LD1_2(ld1squ, MO_32, MO_128)
-DO_LD1_2(ld1dqu, MO_64, MO_128)
+DO_LD1_2(ld1squ, MO_128, MO_32)
+DO_LD1_2(ld1dqu, MO_128, MO_64)
 
 #undef DO_LD1_1
 #undef DO_LD1_2
-- 
2.43.0



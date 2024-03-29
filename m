Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF011CD128A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKan-00059G-8u; Fri, 29 Mar 2024 18:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKak-000588-Gg
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKai-0001qU-CW
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:20:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e704078860so2085719b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711750851; x=1712355651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aXBZFu2s4VI4gx6Rv0AU3SgCaeiACnYHqJQpFd1hK8k=;
 b=CoDIdmARNX9vqrG7PCuHKbASUQSfwM8lwRwiE/l49KUiSqt3+NTdLTBCUxsQpEOMXX
 8U6fLY/qdG3vG1LJeyHEVb51MPFVmcYO6SOXWXPv743Em3DgAcZ70WbAc9aYiHGqRaKH
 0F6uFQ+5RkjZkiWEzsCEDeSQJX6RHtnxy++BQ1gqHT3tdFP1EcUFVE1w3dbiANTMm526
 W2duqXeBG5vpOPAIZOGV+hIPa+62zVx+LFPqBQnOW+UK9lDfs3Ndmu5W+62KMj4e3xgG
 n+CI1cn01JPMUH+uR9yh32hDHXzI8JlO4gC0gKH+Nukv64bLGOzUoXaIgaUWw2tVs2p7
 xcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711750851; x=1712355651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXBZFu2s4VI4gx6Rv0AU3SgCaeiACnYHqJQpFd1hK8k=;
 b=HTgm1ud5c0FeRA74Qwwdjg9hqo2I6gqAGPwBYbbynG3pP2cLhWOK+LYkF/zK3F0qeV
 aVVpTmLZTUqXfaY5ekPDHMekvqglAMq2RVHA4sJ1phvYUX0DfjmYxcPXB4ARmqPLjKoz
 BFEdJe2YEuCH0i7v3zCNJMwE5+F2bY75J9Yzi1Srs1iiK/YD+CcVSjGWdkaahVLo1enf
 h5lyHIUP5Z+yqbwy46qZFUtlzguDWvgzo+OuA44cESXCeCDZI2AGWHetNaWsjyukir9r
 bIVkj0LN052c3C/xnuHul46t3rjTTNPDzYPyOm6DKZf6+3OoZYCd/l1lrvJyR7YMhm7h
 lQ9g==
X-Gm-Message-State: AOJu0YwEysyjLq5WDotDLGMyVwmhXaJNjjGe/XTSMbiP/JElyZf5zQKQ
 k6x78ood7d4djLiylvK33Z5VbPOT2Vn9Ip4cDsEFdDyI1qaDL/FYxaLQ0f5beuFDnYS7W6v3eIb
 /
X-Google-Smtp-Source: AGHT+IFHV3WfRDx95GuCPsok8RbFGkoAr/OZwyT+oyYoeU1rML6qNe/YHyD5EOhCiFujBlWbD1b6Cw==
X-Received: by 2002:a05:6a00:4f82:b0:6e6:970f:a809 with SMTP id
 ld2-20020a056a004f8200b006e6970fa809mr4312957pfb.20.1711750850944; 
 Fri, 29 Mar 2024 15:20:50 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lc24-20020a056a004f5800b006eaacc63435sm3579811pfb.173.2024.03.29.15.20.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:20:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] accel/tcg: Use CPUState.get_pc in cpu_io_recompile
Date: Fri, 29 Mar 2024 12:20:37 -1000
Message-Id: <20240329222037.1735350-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329222037.1735350-1-richard.henderson@linaro.org>
References: <20240329222037.1735350-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Using log_pc produces the pc at the beginning of TB,
not the actual pc installed by cpu_restore_state_from_tb,
which could be any of the guest instructions within TB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c1f57e894a..83cc14fbde 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -634,7 +634,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-        vaddr pc = log_pc(cpu, tb);
+        vaddr pc = cpu->cc->get_pc(cpu);
         if (qemu_log_in_addr_range(pc)) {
             qemu_log("cpu_io_recompile: rewound execution of TB to %016"
                      VADDR_PRIx "\n", pc);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D90AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPh-00071D-5k; Thu, 01 May 2025 17:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOs-00052F-QZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOq-0002DY-ET
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso1599699b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134695; x=1746739495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amMbIE3MgXWFQc6lqx2Am7OVt3Xrarb0bolyFSXxa5E=;
 b=iFaFqk3m+KNe8s+XT4E0To77ROBN6FFH7ryf3jZiugRqRHIi4resb4FsxNF04zVepY
 B5DFzCYw4ebeIVblNs0iOakLYkp7WpbwJatiJ5CTFPPxnLJ8LpH/9zOQN9Vc4OlHWQQ2
 Gpudy/UPyeM1/eTDkQ9tTgE7BQiS4CdUmxyQucxuSPOQkuM3heu98U4HwSuWABcpuAB2
 2RwBfnOBaOaD3Tmfnctl1RQwlm1Z+H8wfcUUkOO2vWIzdgwWuE7XXiOx8MtSqBf0fFks
 pIHJZJWDGgySm3W1Vm7ooC76YB8kbB1ZixCPa1dgWko2d1G6vXmrPjrybwDSKlLzJ/Jy
 qsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134695; x=1746739495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amMbIE3MgXWFQc6lqx2Am7OVt3Xrarb0bolyFSXxa5E=;
 b=DIAMKd8mYEAlPHboZib8bMqzcNsM27RPSZ3dEIWpS7wJe4gYSFIbdpjM6KQ6fFdcGp
 Tjq7F+JvB17rUnEDH5nEnuFQkGAHA3MIMAurN7hSUjIapxXtky5RToV8PRgrLau7HXkk
 dt5UtfU2uulXednt/awUtGhLMoMVVsNjPb9GowVulq3DnoVn+Ec+Uae0qiqX6YPexatb
 ylXqvR2IbMQVcWHQfIbzAEl2DSbF2tCRmB+Iwj4RZTAeE/zxTEF/Lz/aUfT8uWuKdUfI
 zAgwMWak+dNvWxmg9BFbuC4bFxpUHwJuEU/B3qlyPf6XHqvIRgIb9aIG5CyqTaggI5+j
 ZiYQ==
X-Gm-Message-State: AOJu0YwhsgSqN1GL+iHDg2IsRVqXmuWeHawz1Ijot2UnKmrYg449TWKo
 9ClsQhbc64ZrP18dBUzV3pL3iP9w8I3slqtofrJbFnr0timFUHapD3FvDIOHqfCTI+w/4G01NX7
 o
X-Gm-Gg: ASbGncvjHeWiI+K1+84zc5PtHqMu87yE7QQbo0egn3pulyf+dvMM3kCfo4S5Wm4J9JX
 Bntz7Yf2oS2W277aVLXt2hbIuUGNNqAoHdUVDThFLKP/AzHuU1L2HzqcJAx0UVdw0a/peFI5EqB
 xYO9EVipVrmVd8fj1OVNWP/C4soxt3aMRhaOC7Ck382NOlbedUb/I2Wfe6q2cFfpmiF3nLMLO6/
 JwM2cNHOkh6RsnkXZMiKP7cbaIIJWUt3PD2m4rtLMSYxG1ok72ghZ4rpih5902dpgwUiyL/nuS2
 2BntxnyBVIPABa95pkaACQO2tDGgUR2Y7ECYlbqdQw/kn6gaudT84mmPHP1+n+115uT1l121xMs
 =
X-Google-Smtp-Source: AGHT+IH3CZiJrRCfeNBuqlafLbp1OLELbAOmRMadByF4HD65Cz4lvruJ2E60qaHtQKP24i4VrOUrKg==
X-Received: by 2002:a05:6a00:440e:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-74057beac3fmr1014589b3a.8.1746134694985; 
 Thu, 01 May 2025 14:24:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 52/59] accel/tcg: Use vaddr for plugin_{load,store}_cb
Date: Thu,  1 May 2025 14:21:06 -0700
Message-ID: <20250501212113.2961531-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Avoid the use of abi_ptr within ldst_common.c.inc.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_common.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 9791a4e9ef..57f3e06192 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -123,7 +123,7 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
  * Load helpers for cpu_ldst.h
  */
 
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
+static void plugin_load_cb(CPUArchState *env, vaddr addr,
                            uint64_t value_low,
                            uint64_t value_high,
                            MemOpIdx oi)
@@ -193,7 +193,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr,
  * Store helpers for cpu_ldst.h
  */
 
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
+static void plugin_store_cb(CPUArchState *env, vaddr addr,
                             uint64_t value_low,
                             uint64_t value_high,
                             MemOpIdx oi)
-- 
2.43.0



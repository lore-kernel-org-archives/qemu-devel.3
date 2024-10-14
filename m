Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD4CD18158
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 23:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0UOk-0001Wn-C7; Mon, 14 Oct 2024 19:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0UOi-0001R6-8J
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:22:44 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0UOg-0006rr-LX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 19:22:44 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7e9fd82f1a5so3043727a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728948160; x=1729552960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y1u+ZvgIQjZ6JDHGe3izzZSLU+rKVxyWULrWHBsrCDg=;
 b=R2GmFrMj941mt+xo1eaWsKgcYzbZQnDsaGxZszZd7TBuXu2GVl1WsqdU3vFELIqmj0
 iw21FZogPpIo1scWzOxNYrHHWOrgEx8gEg56M0liH//Xua9kSf6y8kdRZxyunxwlH5Dw
 5XdwFjv6M4QdGjAx02t3+fMqYfxYL9DFkEFGVZE6Y/AwhWG4XmlGnhlzNC3DW7RBGu9Z
 x7mcGkgWCRtSzwfttlVssLI/+f55Uc5q/hYPDO2C/rYaeGD/K0tqZBC8hYNSyc2b6juq
 o6T2nJrUVYxVFuxeF7YRJFZJQ5aqhlsyZGeoordhVI2RTUHvyb3q8qq/iRUSeiTRDIyN
 7wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728948160; x=1729552960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y1u+ZvgIQjZ6JDHGe3izzZSLU+rKVxyWULrWHBsrCDg=;
 b=km0gRYZun5SwPmWrbx7adP0CwlHsfBqkAVRraak1rs7saSdBd+xNQ/r3xKzBbcDyFJ
 zrkobfin+VAxENPKF6bZQutQhv6ZEf8dTjULoME3CT/guIUGvuT5U/yMC54ZuP1a7gKL
 SpzWgztWCZDzKDwfA5TdoKAI0WB6sEpMxHspkBMBRBo+F6/b8+1r6BSw9dCpPZaYJVD+
 XOwLI2tYlXQtrPBLuwgEtRvu6wig1ICDN7wjpwImXnQducmMLAjeh733fSApdBTvq74+
 2u/zd+DP0pd6ivRsTAV/rPw3ES0etT1FMHaglY+3X8z7idFNS2Ow+yAEP0b5BLxnyMW2
 MI+g==
X-Gm-Message-State: AOJu0YxcAjsjvzQ/38OjBslxDE2tojLcOokMcmiHRxXMizIdAuHlKWDs
 WkRQwZsJLlAEgmG/6etlLwVhvxhYs9YXnC1XTGhlY0Ibw+lzJU7ZUPEWrilsFP9c9trL3S/2TQi
 Y
X-Google-Smtp-Source: AGHT+IF6Y5vuU9oT/tw5IuHD2QAF4pUj0CwEW1iHVRB117oZYrER9v3aD5mxKLUpxncAnliUhWcP+w==
X-Received: by 2002:a05:6a20:9f96:b0:1d6:d5c1:e504 with SMTP id
 adf61e73a8af0-1d8c95a8a23mr16873299637.26.1728948160394; 
 Mon, 14 Oct 2024 16:22:40 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e774a431bsm75071b3a.137.2024.10.14.16.22.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Oct 2024 16:22:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] target/mips: Remove unused MEMOP_IDX() macro
Date: Mon, 14 Oct 2024 20:22:35 -0300
Message-ID: <20241014232235.51988-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

MEMOP_IDX() is unused since commit 948f88661c6 ("target/mips:
Use cpu_*_data_ra for msa load/store"), remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index d2181763e72..1d40383ca4f 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8211,14 +8211,6 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 /* Element-by-element access macros */
 #define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
 
-#if !defined(CONFIG_USER_ONLY)
-#define MEMOP_IDX(DF)                                                   \
-    MemOpIdx oi = make_memop_idx(MO_TE | DF | MO_UNALN,                 \
-                                 mips_env_mmu_index(env));
-#else
-#define MEMOP_IDX(DF)
-#endif
-
 #if TARGET_BIG_ENDIAN
 static inline uint64_t bswap16x4(uint64_t x)
 {
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52744D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jm2-0007Tp-Qh; Tue, 15 Oct 2024 11:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlz-00075x-6u
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jlx-00013Q-EU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-208cf673b8dso58407425ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007264; x=1729612064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYXizewLL7ilBr1Rp+xOggMM2d6Y9oiIIvLHYNQfqQw=;
 b=x41xV7DTaoM2zY3/4Ud01/O6eacrikT+Q6C+CTNcRjfugEtiAZyEHeC+lTfNPwPbBi
 1dpWJr4DTNHlIuCCt8gAh/BoH5OhVqfDI6VjUQ5UQlQHXq/nD/xSZ18msl/8+c4y51v9
 WSifYhda8AZv6b8AEtlUviY2qJbNcjugu7HYxDpW4YSkoX9mLqnIilN51XAzuaQtPB61
 etvDpGzKgWN6pU8hVzJFv42rxEOhNIbAtY9Rv1HixfjZIBUQqKwO6lyxtPgWcpA7Qejt
 2HI47O5BLyzBqjmSi4LRhJCQFVWsvSygx61qkch8YAILOA6TifDU6DDeQ89sotqxGAxQ
 xyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007264; x=1729612064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYXizewLL7ilBr1Rp+xOggMM2d6Y9oiIIvLHYNQfqQw=;
 b=hP89Za9yfp1FxbIqMo9R+YvX7tZ+6gbXLgAY1NaX2OS2rsg6OBE8DOISWDK6i9v8pr
 A5tYI3qQoc3kwZx/WfgTwdx+deM454VtTH+kodo7pooPnsT2W0/cR/LBDHDohj2/3tTv
 6Hrp6oO8dW4ikveHQYLMO2xaoNvF0CNFi7LKtdcNawFEdKc/pjVeAH3VE84i/ZjGSj37
 ObTJXRgtXisP9YB0zHGPbB+PhxtenP2Ftp//f1r9PYkQtalOqqFVgQOyQyKVIevimShM
 HhDOafoQHSMa5jElBB7vZj/UObk2lsZRVLYlh371QTv31h5EEQIjRCnh1sYIIMBm+AiF
 lMkw==
X-Gm-Message-State: AOJu0YwBOgx6izToHBGDO4Q4XR3VFQaOomt8EqB4/XefCEFCefcjUj/B
 pyt0Z8V3Wl0nFX9S39J48KHCc3YMkvZC3zSXxfpaF7IfCLd1/gv3qDK3psjl5FEmh9gMkD6gHiC
 l
X-Google-Smtp-Source: AGHT+IGqQhLi7dQ4HbQJlSiDRI9jBRrGCC06AFCm1HbYQiBGP6ghDXTPSmL3g3zM6lT2bPijwL3J/g==
X-Received: by 2002:a17:902:f78b:b0:206:aac4:b844 with SMTP id
 d9443c01a7336-20d27e59c0bmr12439765ad.6.1729007263737; 
 Tue, 15 Oct 2024 08:47:43 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1807100asm13470765ad.304.2024.10.15.08.47.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/33] target/mips: Remove unused MEMOP_IDX() macro
Date: Tue, 15 Oct 2024 12:44:34 -0300
Message-ID: <20241015154443.71763-26-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241014232235.51988-1-philmd@linaro.org>
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



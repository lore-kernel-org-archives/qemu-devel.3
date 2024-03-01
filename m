Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1865EC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2e-0005tM-Fb; Fri, 01 Mar 2024 18:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1j-0003z0-5z
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:57 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1g-0005zZ-G5
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:50 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7bf7e37dc60so153737639f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334647; x=1709939447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYpmvWcDo9XJ8PEub2Zz6TVzblWCi4U6QK1BUlbCzJU=;
 b=rz0l0CRPD52P1/IiZ2iwz4hGlImpScXr9Tb4XpejrLboRmqleCCLcLPRynWoL+gP4P
 HEw6CqhqlxRivCm3xzmnZ73DzQzicuLGDrmCNLVkwXSYhw1nIBUrLiqrQQWOoZr+k+5G
 V1jz5FUmimXUqvc7Ohnhx4woSKqzQv4mx8qr5767gMKTcGv05qkB2b+pV0jXd3f7Hu54
 oBKQ+tIJWk6/zOs7dXP9/62zhU8PzAJTHX+I805H1FFJHJiD9TrHJdyJWFrSil4u6U3b
 r89c3Y1Br9pfJJbbgE1jGO9kwfvcYzv49D57LNOmWCInyEdXXFqgxUvHyoySQb/ne10b
 0sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334647; x=1709939447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYpmvWcDo9XJ8PEub2Zz6TVzblWCi4U6QK1BUlbCzJU=;
 b=SkmxainzSjWl5tGPtNW9yPjF3gXS5/QjWRLVGpjmGyTG5ox3c8zWk1axgUdY51Q/QK
 G1j7n+cv6+Q80MAOIVHfN684Nah8SYwY2ZsKFLc7iOtYuKkQnRlujzF0+QGL5r2e4LJR
 uKzmhrEnLgd/MrrDlOCeRgHXrZI8JaUuxcjznsV7uFJF9wOd2MKMBpHKcZApjPfTduL8
 4XDTRVAEO3SD0+o1jDzPtLI0C0W7thaJ6DLfQ7Tnjf+UXgUn0HY0htiTBcfHxjWJolF4
 eQTePNDDdkBe5uhlQT5byFiojUiVyhRpSPh6KoDwA06rg/YQu7WbJtmiOg3necp7+Mwf
 9g6w==
X-Gm-Message-State: AOJu0Yx8mbT1ONniHlmBecUDpPGK92lu4Uosb6JPAcNcUxWPmmt4J9yr
 b1eLbPQzJHu/38pU42+DRwkM4Ku13LFYYQMrnYbLIWP+HI2tLil6auXbg38y5ernsv7d+wvxjmV
 p
X-Google-Smtp-Source: AGHT+IGGH/WBnFl85+77p4ZFwydJXf7fR1m/tFQO56IckGlZ5SXUZ+ydF7C4tidKFC7F7pg4eKPXjA==
X-Received: by 2002:a6b:c988:0:b0:7c7:fd10:ddf3 with SMTP id
 z130-20020a6bc988000000b007c7fd10ddf3mr3060461iof.18.1709334647317; 
 Fri, 01 Mar 2024 15:10:47 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PATCH 57/60] linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
Date: Fri,  1 Mar 2024 13:06:16 -1000
Message-Id: <20240301230619.661008-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The kernel abi was changed with

    commit d23b77953f5a4fbf94c05157b186aac2a247ae32
    Author: Huacai Chen <chenhuacai@kernel.org>
    Date:   Wed Jan 17 12:43:08 2024 +0800

        LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE

during the v6.8 cycle.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loongarch64/target_syscall.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/loongarch64/target_syscall.h b/linux-user/loongarch64/target_syscall.h
index 8b5de52124..39f229bb9c 100644
--- a/linux-user/loongarch64/target_syscall.h
+++ b/linux-user/loongarch64/target_syscall.h
@@ -38,11 +38,4 @@ struct target_pt_regs {
 #define TARGET_MCL_FUTURE  2
 #define TARGET_MCL_ONFAULT 4
 
-#define TARGET_FORCE_SHMLBA
-
-static inline abi_ulong target_shmlba(CPULoongArchState *env)
-{
-    return 64 * KiB;
-}
-
 #endif
-- 
2.34.1



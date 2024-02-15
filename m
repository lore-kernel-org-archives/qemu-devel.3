Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E66C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWlU-00043l-R4; Thu, 15 Feb 2024 03:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raWlS-00043M-64
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:06:38 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raWlQ-0007ww-Mi
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:06:37 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d07ee22eeso107412f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984394; x=1708589194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C53i8aoECZxAQUhEcs1ov5dXnWrxI3PIB+Zd3u3RLrc=;
 b=mf0qNUiwhIN2Nvprcs7mvLWYSPQ7S/BqKqgkypWnbXoyQSIEq9sucrknwJVts1mode
 g4N4VcCARSyG8VXAyeiWtuWQ9jMz380GuixYZuEFRHdS7jmqwYCDELtSBuNDymg6khzk
 9Wtn0oKMUwKEdOVMW5rTyhA1jxqGUHv/eIbYnHGJZvZuggfdKDWkJCfxwlyagl4D/WHj
 TqMK7t2Xf+9zQP28Q5muZr89X1nsI2G8V1kaFEvN4skebdT0+Xclor+JU3Yty7/o9p2f
 nOOQM2dH30S/NC4OcA4G8xynPJ+fk5TDo+xU8vdeblazPMhHjnIRBJ7fnAlw/g5UeT/X
 MMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984394; x=1708589194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C53i8aoECZxAQUhEcs1ov5dXnWrxI3PIB+Zd3u3RLrc=;
 b=PmvONFsvqjcbE+BPirKezWP0cCkw5+MTJmssqcJeihDmFDjcxb4kYGQVGVnRJ53Own
 x8kNusHMiUCPsEboxmhzrFhK5T/V4VGLeVEKVr2bd0wChPvJyIl3L0phdKacF6bCPGlQ
 0JxVOG3w3EGJF2nqHabdtnU6YuUx+aqwU7z7YBolPst+/V3DCGRu31oZmMRngHLjWzme
 KVeViVrnSC9T2FnZLg/AU5eux/p09GMYH96a/nt3zFVYxQLU+8BFZDCyR5wwvyZTunc1
 597WvyrZkFb5AgNpzfelQ1lv4dUEeeGK+pi6PkyzZdTo8FDWw74cenZPpS5r/HBxjV3/
 NgYg==
X-Gm-Message-State: AOJu0Yzo00y92V/Y7ZgA3ggLnNRgwbMUzUGa4iG+X2IaLozT8zTB8sMC
 a2vHxjd2ikyLyHML9XLEfs/mDleDQQsK8RqNr+Gsoyu4qA3/VilBqddWJL8cY5mJaHNf0vjojqW
 cuLk=
X-Google-Smtp-Source: AGHT+IGsVkUMUGPiMFvQ/eqqH+DcHZtjmCx5lUP75BXkIIWhOzYajxvpVEad7/Z3tdDHTRpr46dWWg==
X-Received: by 2002:a5d:6303:0:b0:337:c729:454c with SMTP id
 i3-20020a5d6303000000b00337c729454cmr871001wru.18.1707984394450; 
 Thu, 15 Feb 2024 00:06:34 -0800 (PST)
Received: from localhost.localdomain (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 k18-20020a056000005200b0033ce727e728sm996977wrx.94.2024.02.15.00.06.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 00:06:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH] target/mips: Remove mips_def_t::SAARP field
Date: Thu, 15 Feb 2024 09:06:29 +0100
Message-ID: <20240215080629.51190-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The SAARP field added in commit 5fb2dcd179 ("target/mips: Provide
R/W access to SAARI and SAAR CP0 registers") has never been used,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1d0c026c7d..a9a22ea00e 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -83,7 +83,6 @@ struct mips_def_t {
     uint32_t lcsr_cpucfg2;
     uint64_t insn_flags;
     enum mips_mmu_types mmu_type;
-    int32_t SAARP;
 };
 
 extern const char regnames[32][3];
-- 
2.41.0



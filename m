Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0320EC25B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm7-0000EV-M9; Sun, 26 May 2024 15:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm4-00006l-Mq
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:20 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm2-0007kK-5r
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-681a4422f49so1768727a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752597; x=1717357397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEc4KP3uZvO6wOyhGM6ZesqZxEK0BedjSL132wzrDtA=;
 b=faDNAr/JUlaqxWf1o/wW0T8u8WV63oQ2fFcObkkNMnnYqKpR/y0IKKwG1Tis0debMP
 79uxu6cZNmh4VinBPTvUNbQDpg3LSBAVawRLcCS3TBkqooCsG6qwhmuEAHJF2ROAgRtx
 5DvTOfuAL18gJFZemo4Fv+BU1IzcvRMlbFDTh3GUGwmdqk4cgqJYoIplPt+EqspFTKSc
 W7PNYKMod2LkCVEVNppCmfhImqa5rKTxIp3YtpcCgSwff1luB9SNMB6e3xKkmA7fRy2D
 ikiGWoe8AuXDtbgUrI18M3RG3bEj9TPRjmLy1s5nu/EUjrSoGRzTdPKoNq1kqSTvXL7X
 p1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752597; x=1717357397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEc4KP3uZvO6wOyhGM6ZesqZxEK0BedjSL132wzrDtA=;
 b=RzmFCiey1w+MQw6O8jJ8YQG4gFKSJXyc3eKFdBWBJ4ekfdXdtS7xMh0XXOpsa7UwPe
 PLk1xffBMEPAaWK/OHFuW6ZTqSeRrKkYliHtRUnU0d2w5wO0J6J1sz2GIImMT5N5VMhw
 RDs94p3mGBA3O+q1+oFfI/+rUoPEtXoFIJbEd1IGL1waQ+u9sX1QJNcpqJrugqq9H3Ru
 jD5gjosaTPVo45Cf2seeZhnzqF/S0A2wvweELGDhkK4vS13FRX9DCFjkOPFEURu3GAFp
 nWd9MC37doe7abkicPIl8uTzbq2fh2qee2nRq1K4875AzTfwcbyCvw3H/Iq8YKGB4zKE
 vgYw==
X-Gm-Message-State: AOJu0YxiB8biRoUOhDWXmDNg81xzcCdgtbWL9KRwpl7fwe3c5+hezPBw
 39NmlXdwG6yH+Y9QdlwAVnL0FI11yboIO6CDPhnxgI5prG63pE8reQBfx0kfvzYb4WfbTNc0b1j
 4
X-Google-Smtp-Source: AGHT+IHKlaFVk+g52xNULxBSjuTL9grownHGDrkvFfsj92kqsZMFw/4RWfagM5TsMLnzoVxae4mcNw==
X-Received: by 2002:a17:903:22d2:b0:1f4:64d9:5cfd with SMTP id
 d9443c01a7336-1f464d96071mr60181705ad.42.1716752596796; 
 Sun, 26 May 2024 12:43:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 27/37] target/sparc: Enable VIS3 feature bit
Date: Sun, 26 May 2024 12:42:44 -0700
Message-Id: <20240526194254.459395-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 target/sparc/cpu.c   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6a1457346a..cb79580431 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1004,6 +1004,7 @@ static uint32_t get_elf_hwcap(void)
     r |= features & CPU_FEATURE_VIS1 ? HWCAP_SPARC_VIS : 0;
     r |= features & CPU_FEATURE_VIS2 ? HWCAP_SPARC_VIS2 : 0;
     r |= features & CPU_FEATURE_FMAF ? HWCAP_SPARC_FMAF : 0;
+    r |= features & CPU_FEATURE_VIS3 ? HWCAP_SPARC_VIS3 : 0;
 #endif
 
     return r;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ed9238a69d..8ea977b49f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -550,6 +550,7 @@ static const char * const feature_name[] = {
     [CPU_FEATURE_BIT_VIS1] = "vis1",
     [CPU_FEATURE_BIT_VIS2] = "vis2",
     [CPU_FEATURE_BIT_FMAF] = "fmaf",
+    [CPU_FEATURE_BIT_VIS3] = "vis3",
 #else
     [CPU_FEATURE_BIT_MUL] = "mul",
     [CPU_FEATURE_BIT_DIV] = "div",
@@ -880,6 +881,8 @@ static Property sparc_cpu_properties[] = {
                     CPU_FEATURE_BIT_VIS2, false),
     DEFINE_PROP_BIT("fmaf",     SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_FMAF, false),
+    DEFINE_PROP_BIT("vis3",     SPARCCPU, env.def.features,
+                    CPU_FEATURE_BIT_VIS3, false),
 #else
     DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
                     CPU_FEATURE_BIT_MUL, false),
-- 
2.34.1



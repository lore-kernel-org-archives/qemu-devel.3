Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BD4C54E55
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHk8-00032r-OC; Sat, 02 Mar 2024 00:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk6-00031v-9Q
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:02 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHk3-0007ba-9b
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:02 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so296728b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356616; x=1709961416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsIJr6QEnw4W2YvjzGDYdqQcqjL5PLIBf0yL49rbXJU=;
 b=FoJLqy5XVz9JIkzfG4sDjxEN0SxtXefwPgH22QXSYR5oGI5Cn0gsILDlBE8IjBxAoN
 ZpskAm0JhtalfUYHTBTgr/E8nWWYk/pqzcVowCciZ7XedrJx1Iv6jLhls2AOiWO45PpK
 96qtUkfSDM2EvumkI3hOsPrtDO250cZxxLska+9zPZienSD5IDsZQf0R7L23bLh9YdOB
 Z5O2S82VYyccrTtlM1gLY5Xn6FcoSn0vaoyIMZ2KJpHF/JpvzfM49b1wz9MIqRpBHYU5
 GKcdD7PUznprKErPXTw5QpRrLMCvYL5RqRmoyJDoUnFc1f4+ZN6SfdOCCCGi2WV+U2K3
 yxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356616; x=1709961416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsIJr6QEnw4W2YvjzGDYdqQcqjL5PLIBf0yL49rbXJU=;
 b=r1INtZejZEndV++cJGwMjxnmByR9hyXQKHEFZiHg/EONA2gLGPB1KxD7r/g/rP9zMC
 oY7J+uBQFuDUTGO+iO/CISX1TG6HiIr0vmNrMHDihrKwG4vRHJxNcsGxewGolcKu+6nf
 aYFMYU4URuZXjaOOEsUhIvkltKDPoc0HNdxpbEmhCfqqlhd1cM6jZ8Jyu8jehvc5jzGY
 WXj55GSxb1KjOui8jmuT7Ksov2MMYTSgHRgqAoHCsxZrRmlPTIbZji5FUETKfk2LjO2c
 ApbdZe0xGvF0aKL2fp6XhsqqDJEjKmO/2fgX/JwrrS0ZWHCx0yH+VD84/vKz4/L7OQQV
 tijQ==
X-Gm-Message-State: AOJu0Yx2Xlggx7lh16K6AGuTr9HjnvHkjuznaBRGcPrqcg7MCIW3JPXG
 omEYGPyfhndey8G5iPX6GJ15wVxx4xTffBSV6Ru0xjP1ni6SL4c/ZjRHZfWoRNmFYfL7r2AkMEA
 R
X-Google-Smtp-Source: AGHT+IEVhDktlnrdfQKspxKxy4mVdMQKj4TAT2bRwX+kYajLNyB3xZYbTHpCWKvYV1L1nHMt+rMx0g==
X-Received: by 2002:a17:90a:de8c:b0:296:530:996e with SMTP id
 n12-20020a17090ade8c00b002960530996emr5028429pjv.20.1709356616645; 
 Fri, 01 Mar 2024 21:16:56 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 33/41] target/sparc: Add feature bit for VIS4
Date: Fri,  1 Mar 2024 19:15:53 -1000
Message-Id: <20240302051601.53649-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/sparc/translate.c       | 2 ++
 target/sparc/cpu-feature.h.inc | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 56ee3927af..77b53cbf3b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2402,6 +2402,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
 # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
 # define avail_VIS3B(C)   avail_VIS3(C)
+# define avail_VIS4(C)    ((C)->def->features & CPU_FEATURE_VIS4)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2418,6 +2419,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS2(C)    false
 # define avail_VIS3(C)    false
 # define avail_VIS3B(C)   false
+# define avail_VIS4(C)    false
 #endif
 
 /* Default case for non jump instructions. */
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index e2e6de9144..be81005237 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -15,3 +15,4 @@ FEATURE(CASA)
 FEATURE(FMAF)
 FEATURE(VIS3)
 FEATURE(IMA)
+FEATURE(VIS4)
-- 
2.34.1



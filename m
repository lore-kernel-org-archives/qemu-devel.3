Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7089606A6AD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rfjokCia
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSN-0000Ym-PL; Fri, 20 Nov 2026 17:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSM-0000Y1-1R
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:46 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSK-00052U-EA
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2f03920c477so12404755ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215103; x=1795819903; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wq0qjLrYzSXWIP5OEFINrmSzraKFTFGM5Tej26WHttQ=;
 b=rfjokCiava8iRSeXUHltKKvkLyaRGHzHvotF76fkrbmEVc5uPkdgUuda2MwnyLx92X
 ASpzNoAT3JpZ8N5rna5oOvJo6XGEqlGofcHND5KYBvunI/GaTLKMy96iB3YLoskiz3X1
 IvgDfy+FaHGOXtRgArsCx0JHVm+2kY6UjKGrTMTVsHx3I6fIWVicKJcQvoA3x2rtozeg
 CD6POO0hxjzOvT1uWSBkAjiTrBTDjRvnwU1ic8x6ky1YXHHvu7Sr/z/nKAQiMq7N6jXp
 nMJQNz5CrBE08KYbxt1ZbLBZgpPPkcCx3TwsA2pXZcyJE5ubDu+jWnVSuVf47WacH0z4
 vDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215103; x=1795819903;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wq0qjLrYzSXWIP5OEFINrmSzraKFTFGM5Tej26WHttQ=;
 b=HgvT5JtuG+qC4lkCPrft8zeYMUcp4+Ydrvf54dZuwaiEMn+HmKsn8+W9bKSGyqsR8o
 9AA+EUhjc6QJRXwhljgOb25RS3XRGhyQNdY5DeqBduQMsPoTEGFHH1qp9oItffpPK6Va
 Zuu38wq//7N7GMAVkFq4lFS7mUFHEbZtuSeVVeFJEMDRstP1qp/xLxvs1gmYiy48jdvX
 6jZZq/nX8mw8sMxagoxuxsR25qgKSGllMY2qtvUJz8m/voYwtuObr0plSbJ81enCVqul
 YyxyhTKXPWMOiJ/D+S14RM8DotU+fNrmZJOUs0h8RC89EwZbbx291yzQRQwLhHj2LQBd
 /ySg==
X-Gm-Message-State: APuU4Z+5ZSsmTzJB6/az5XreEyLFfnH2+s9zuaEklG1fos7yEBCHzFgU
 Q/geaYy2mKesomMHUGjTHvktCJXk8OBxTbcsAgcCQUp/G9LownOP+TMgRi8ggvcv7LW5mUaUUaa
 1kwRi
X-Gm-Gg: AZFdTZcO6xKsk+rQpIXEtAFCd5IWS8OuAbu13VkRm6OebLOJpSktDP9k8+ZWmm3fdZE
 NMnIQrDQM8YekEypnVFW96zqF0urCzQKumG4G42TwzVOhJBO0p1x+PmkBrWp4r8x4rmYee/tK1b
 V8t+Sjy0Ec0rlkYf+UXsCKg+KKMVZLXpLT8oOVmoNBsy2ntqLWRTo+S7mt+QYwG+XwfatJCXEXD
 Gpa7OxyO1oj2h2zgF6KYhSQ77oyVt4EuNE141kUi7qRr124Pvtd85lDoo3QkUhp84KwTaQ752t+
 PIKglu2cpNQw9Ig6tfkTD3tuj1MNXcMI6B0K9mNmQczDEk4NApQSR0kWaYAAXmHtXuj5AaoE0KF
 DvnaYu+9D5WUlm1/q9my0TOMKVdujUCtrq9OY8zInZ2nQ0nVyBRJ9aiVVJWXYOlt/W1clOuftg/
 9zMmcXonLe09N6pF258e4zz5zDkTyj+UC49gynq1zSi2QUSvtIewIDfl5IyGN36l3weHc55v4qX
 bpDKcVV6Qtnzu90fgsfQBa5F4dM1wNgNDV08EnWsCgyw+fCahXtO824oVWTkvW9jsEeLrcQvwb1
 u0syn7WGoGMk1/BT70ceCKo0V1dKZGAUlxZT0H5LjYWxD9MMnDZhB6re6Vml
X-Received: by 2002:a17:902:eccf:b0:2e9:77c0:c7ab with SMTP id
 d9443c01a7336-2f03f1277f8mr47930245ad.29.1795215102743; 
 Fri, 20 Nov 2026 14:51:42 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 5/5] docs/tcg-ops: Rename cpu_env to tcg_env
Date: Fri, 20 Nov 2026 14:51:38 -0800
Message-ID: <20261120225138.7198-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120225138.7198-1-richard.henderson@linaro.org>
References: <20261120225138.7198-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chinmay Rath <rathc@linux.ibm.com>

Commit ad75a51e (tcg: Rename cpu_env to tcg_env) from 2023, renamed
cpu_env to tcg_env. However the same was never done in the docs.
Updating docs with the necessary renaming.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261119102319.2618086-1-rathc@linux.ibm.com>
---
 docs/devel/tcg-ops.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 51fa183e91..7ee419f959 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -66,7 +66,7 @@ Variables
 
 * ``TEMP_FIXED``
 
-  There is one TCG *fixed global* variable, ``cpu_env``, which is
+  There is one TCG *fixed global* variable, ``tcg_env``, which is
   live in all translation blocks, and holds a pointer to ``CPUArchState``.
   This variable is held in a host cpu register at all times in all
   translation blocks.
@@ -75,7 +75,7 @@ Variables
 
   A TCG *global* is a variable which is live in all translation blocks,
   and corresponds to memory location that is within ``CPUArchState``.
-  These may be specified as an offset from ``cpu_env``, in which case
+  These may be specified as an offset from ``tcg_env``, in which case
   they are called *direct globals*, or may be specified as an offset
   from a direct global, in which case they are called *indirect globals*.
   Even indirect globals should still reference memory within
-- 
2.53.0



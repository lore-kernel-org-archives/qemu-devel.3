Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45910C5AE59
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoB-0001t0-DQ; Sun, 25 May 2025 12:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo7-0001mg-5V
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo5-00036h-LJ
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-44b1f5b917fso8607945e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188956; x=1748793756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrsiPPIKs9uqNggfC2fgEnSDXqetMhiV3VJ4jE1p+tM=;
 b=ryuA5q0fwezoJBOiwpAJaQmFW/bwFzh9E4oszvF4qe4+uOQC147/XstAE81Xu1/W4v
 xujnGOLEON2A+sS5ePIEZrmnowQRSUannXW4wUEnZYRN7vjBbjNRmCikUVKmKlfE4rQR
 77XNMsYL4THGqOdt3Qs0Ty0BJJusOGe0GX/6v55hX7NsTnxlBrXMShtwppuCRQeicqUk
 /w7KZvxziQH/FQZ0zzovNgu10AmnBDPUI0btodw3jAbGOSfbsvrFbPQNByyou5cL5OsR
 c3tLIpuLsPhCLpjtfwOyPWVwr5aiIuDKuZrIaYR8fBdZ9YTblDGZ+lQnWuFOchWo6OK3
 Hxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188956; x=1748793756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrsiPPIKs9uqNggfC2fgEnSDXqetMhiV3VJ4jE1p+tM=;
 b=w8TSilZj62e8Fmk0IPW5qbpIjuwEZLtAjNjm+IIjZKTvFYXs1IhqTwjqy1VEy4GPmW
 7HrpZ5Z5o0XAazg4kFUVRqX5nlMokjNhkHZxFTT/L0npmwESTdk5eTPJ5QE0+0vvC74r
 VaWbU0OHpSWeJnIk5fD4Qj6n9FFzyEvL3bIh5aupYfB0TKZ9ytM8/XM7VfyJUY9qgZXy
 lrhe8N7vwhxQ1fwNFp+aVFWd3nAI+uxHQhQxMiAsVi3NPyVhZhBxu0T50Gzdi8N1dCt7
 vbBah/uA2cTe1wWVU+B68NFgu2khK3mfGSFbwx0QiPY3UZPJuoq8X7rpUATOUeIRHuc4
 Gx/Q==
X-Gm-Message-State: AOJu0YwnQN/lyf2pEJnR2cedddUYV8cVtxPNKCWwGVc7jK+PX8/VegcF
 P4Eg0kHYkP9wGoI7CTisOrArsp8bzEMhoncPgTarJzV+gokua6NjA436QyPPKbZu/u0uqSB/zwM
 fGmmO8a0=
X-Gm-Gg: ASbGncvBNfbftvF7IDy9gSiFxnlHtikOiftLiW4/RsjvjNi86aaRbLdZaLfmvPnXZ1H
 vm5Qpss64VGpkVK8LtvbPW7AEzKkqRsC+u0Ul8QVkhmgYHFDVl19NxQ5opiKx0CVqaw/MQXta5i
 uCu6DW7RPwQnKNHH1b477xm4XLRaVScCc7Iyrkk15yN9VjEZ1yrm5IivvWejcSmPUTqbEJKJ3h8
 o1VRIpZaQ2CyVK6uieqgrONfEgLik7KIjJO3XEtWzzp2ZJES7BybbrVQjEbay8LuTEQaqbOEc6x
 bsllF6KkBGIGo7oKFcgDbpbfAm6nbwCmYCyYkrZMWai/A63Qrzvw4mBu
X-Google-Smtp-Source: AGHT+IFMEunXKctrHeJnpbl6Fx4vn8IPv32kFL1QL1JZIhk1CTBV9DMLZoa99IRwbrb0+Y1pdSI7ow==
X-Received: by 2002:adf:e381:0:b0:3a4:cbbd:6345 with SMTP id
 ffacd0b85a97d-3a4cbbd64bcmr3397468f8f.13.1748188956001; 
 Sun, 25 May 2025 09:02:36 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 07/10] target/microblaze: Fix printf format in mmu_translate
Date: Sun, 25 May 2025 17:02:17 +0100
Message-ID: <20250525160220.222154-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Use TARGET_FMT_lx to match the target_ulong type of vaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 95a12e16f8..8703ff5c65 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -172,7 +172,8 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
+                  "MMU vaddr=0x" TARGET_FMT_lx
+                  " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
 }
-- 
2.43.0



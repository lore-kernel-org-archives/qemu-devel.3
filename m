Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FCC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOJ-0004Fo-1B; Tue, 25 Mar 2025 00:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNv-0003nK-OJ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNs-0005p0-JL
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso9525309a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878767; x=1743483567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u9igk3DJeYNJ4kHlFRAOur7C++4prjQF3K5i5oOOhU=;
 b=q/bl66CvooQrDt4rLP4tOGdqXj3/AfslP6o2U+azpuBWSkDE66Eih/yAYCu58zyIHq
 5bV+IKBipTrUHV9aBDukxzDakSiahB1fzx8CKmlTFj2587uNDV7JnlEfk8V22DXpYG19
 6veQPKTvFhFwycc4Mb4+9fuphB7ODWKxqo2fXgB00v01TbOTW+lh6o7AhGYw1IWdy6si
 GYi8H2qIESMNafKgYH4T3Dxkmt9u50Le5gOYSgR6nq9dRLUD9gTn4ZonVBehVMER0xwi
 sbFDDynY03GbCwnSmPYnSCCmrSlXNUxo6NIcQ7X+iFJCfxVUXZYTojxqYzL8guuX0D4a
 1Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878767; x=1743483567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7u9igk3DJeYNJ4kHlFRAOur7C++4prjQF3K5i5oOOhU=;
 b=bIH8yGqmOvJDBKkwdUg+GvranY+bk2lyXvU8WSVzJUaSVjEGsbL1O+5RT6VdZSVttg
 806L/dDaGLuikoNQRKZwqg2msSFP0KTX3O2200vrjpazNdJ5RB6P5MX1gYbLxEFp+mY7
 U2eoyZTn+jmqaofcxCAzd/u/N2XBPfqEfHSjFPLFhAE2fJg1djdj+XDLDvof0m+k9Q6k
 aO9MLBSY+u1SFI6NAz8ZBIA+62j1HLHI0rl4rNxH4BZLqYzin+zlW89ZFKWRkTisr5Ia
 XKfcvcgHDepWC7hv6vKkQDiVGvmZIu34wCJ4Cbx6EBRRXCJslmJ8gZwauVM3tWM+90pw
 /KcQ==
X-Gm-Message-State: AOJu0YwgzzFbCj0UxlZO3WjeFHLdpXju+qHHcEWzQzR26yzpdIkajE1g
 0fpAWX1sWaAJ4WPpb6K+8nfRGqdYhXiVNE4O1suy0xYGrrITaxxO5JkL73JWa3RD9wRp4ztR+Ng
 a
X-Gm-Gg: ASbGnctBrke5qLnoFcZj85RMgYfD2wgpajBLkTGR9VydASkXTvuYu9JFsfFZGmNziSR
 Rxg2RqJj4Vm2+67ddSnwiMd3pRZVNWchRHw4dS5MDmjYgQJu188QyUjFzXqEaDIRbzp2xxn8SUr
 tFRU24rVJ4qVhttEQA/JSaYX+BEL18wjyTNV3VB8XjfL38WLsjwb9+NnwFXl0V61E/O6b9Ie3oj
 mPjWgcr40d4J9y3eBkuZ/rlllJ1TuvQA6pkylaKR7kh3ZfeAFNBM99htH5bOj8N9wXiFaHW4p8M
 yfOp21dLzfUJwvmRo1CZk9u5b5U1WWzeQRT4HjYCU70Z
X-Google-Smtp-Source: AGHT+IEiLeBzJzC5jt8zA/2EUNgz/WuF2tstB2sh/pCZJeNAww/EeI683sYhypnoorCiSk/JT+KeeQ==
X-Received: by 2002:a17:90b:5108:b0:2ff:7b28:a519 with SMTP id
 98e67ed59e1d1-3030ff24236mr23516938a91.30.1742878767084; 
 Mon, 24 Mar 2025 21:59:27 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/29] exec/cpu-all: remove tswap include
Date: Mon, 24 Mar 2025 21:58:51 -0700
Message-Id: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h               | 1 -
 target/ppc/mmu-hash64.h              | 2 ++
 target/i386/tcg/system/excp_helper.c | 1 +
 target/i386/xsave_helper.c           | 1 +
 target/riscv/vector_helper.c         | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4a2cac1252d..1539574a22a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,7 +21,6 @@
 
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
-#include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
 /* page related stuff */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37aed..b8fb12a9705 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,6 +1,8 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
+#include "exec/tswap.h"
+
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index b0b74df72fd..4badd739432 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef..24ab7be8e9a 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -5,6 +5,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "exec/tswap.h"
 
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83978be0603..7fffa23bc8d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
-- 
2.39.5



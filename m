Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8624AD6552E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxP-0007IB-Ki; Tue, 26 Nov 2024 12:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxN-0007GK-DV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxL-00020U-Tw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so17073155e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640549; x=1733245349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZuYGPOKErQ71Qclb0HLqWioAIBy53u4/hFcO1bYVA+o=;
 b=uDcPfJgPOR4Z2te8RcovSj5TmaIZnA7WmvGoEl5KQsMaW9tpL1rHsXi1LHVQUwzFh+
 2f1wrBgRGq93VwRhC1pjj4kEPAoBK/1tWc8S8ykTF0D2YoDFqvylr+9KayGcekhy5HPP
 n08qrqyvW+mXABZ3WHNlWOFRzKBFos5OEhbRJXoOA0sIZ/gzrLc43oD5o3pqVE+fakH6
 xCSYU0wm1dX0UkPAV+AlHZeSCqSI8dbymrJrzQ5QoaobBGYM4vUySLNv3ROR+Iy3YRjm
 0W3JUOO4KUV1zbco0M0zWpqRMCZJ4N6yWkcTcML4cLGPRf2/MyyU9Qp5zI+Me30AhDwF
 w6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640549; x=1733245349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuYGPOKErQ71Qclb0HLqWioAIBy53u4/hFcO1bYVA+o=;
 b=TC/kO63ucKjgm0buZc5VWbhb1nvPPmHZov+nMr1CGkUJK1+PZuCbVHoFwIyxTt6FEL
 zzciNc2cO5vWPzoCpwKIiRiTW7PPkOqKTjhR4Mo3m/OHK2uqI/GlMBdJvgDde148wCvR
 ZzGOVHp9mPn4qs8IHZkeCdZEe53mBWV6nC2wElEWPt3yrVdBBCJgOltrGgXbpxvRyonr
 qnQ5gai2AEDvVO9VcxyOZ/IUVXmAOg6UlQkHuXWrzmYabRmnrxAiKAvhud6ovFIoNY6/
 gjUeu4O8yjw9wYrO6hnBpS45VF+G2RTdfBcrBiwW7UnchN5oJGftqRAkdUeMiEyNSXA8
 6jSQ==
X-Gm-Message-State: AOJu0YzNvF/poYb/L++tSF+PRTViiGHhUt2MgfwYJvHM3z7P1r3HIKJM
 v1hYnLdJCjik3Ambbp82Ga2/DgrfgeXu0i/hhEzYqwRZNELPiMjzmBz7stoM28CY3svANO6TNts
 w
X-Gm-Gg: ASbGnct2IKuxWwsZnRO2k9guhwE1MUxdemztrHq83MAiTlwSdbcftSNk8oFKgTg4XQV
 2dnScn0EbcbWTtGn1fv4ykSJ2/6D9RH3tGMqLXoqp8sESuIqnlOXLaJlKV/0M7YyZfajy0rPT3d
 9IgsVnEqRtrdVtQrHpyIdsqzfX74G8/zKgH+LcqMRwnmZ++IQ4FtlzRAgsdEAHtIShzObzHMiMk
 gmAc5AAgn2diD/sf8+gOeb+XoWbMtJ1RbwjP5qXs9/+vmsG6GHCHMTa
X-Google-Smtp-Source: AGHT+IGvASr3ekA2gPhMil5SbFA4o4rfjWum5nD+K6mBdtufd03hnCfrBLBTb1R8kc9r3rjUbFbvQg==
X-Received: by 2002:a05:600c:154d:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-434a9dc3dcfmr308805e9.12.1732640549413; 
 Tue, 26 Nov 2024 09:02:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] target/arm/tcg/cpu32.c: swap ATCM and BTCM register names
Date: Tue, 26 Nov 2024 17:02:16 +0000
Message-Id: <20241126170224.2926917-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

According to Cortex-R5 r1p2 manual, register with opcode2=0 is
BTCM and with opcode2=1 is ATCM, - exactly the opposite from how
qemu labels them.  Just swap the labels to avoid confusion, -
both registers are implemented as always-zero.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241121171602.3273252-1-mjt@tls.msk.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 20c2737f17b..2a77701f8dc 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -574,9 +574,9 @@ static void cortex_a15_initfn(Object *obj)
 
 static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
     /* Dummy the TCM region regs for the moment */
-    { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
+    { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
       .access = PL1_RW, .type = ARM_CP_CONST },
-    { .name = "BTCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
+    { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 1,
       .access = PL1_RW, .type = ARM_CP_CONST },
     { .name = "DCACHE_INVAL", .cp = 15, .opc1 = 0, .crn = 15, .crm = 5,
       .opc2 = 0, .access = PL1_W, .type = ARM_CP_NOP },
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DFB106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ooF-0002b4-KB; Thu, 12 Mar 2026 18:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0ooD-0002ZZ-63
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:47:13 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0ooB-0003Zd-7n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:47:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-829b2019b39so907080b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355630; x=1773960430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4R+PfrpTL44BdQWmTJI+2BTLyEiS96HpVxYoD8sVcg=;
 b=PYSQLBZFIZOV17TPOGEVo9odIFTBddu4Wm8j2HmZLlGlv1VD6sDmWA7HaXUbs1EBr3
 gvtILFzY5x/wQbOiAa4hMJrk+7fwmfY/Psld7CcAs38odKzUzPy404tHWgFMKPqgNIm7
 E2QuFGDd102rE6755xXMDDcK56AXYVN+Fiio+5TDGSpx2kQddWO2Z4lI68kJKYqEgNdh
 d3DNwqHyxvbbOR9kDiQ8864/tmQomqxunk3R+p6O0XHkiLfrVsOOJUsBSvK5ls3KoCK6
 uE7f9EbMZKhacr6OKBulADn1KAiBpU4Xt9qF8d/6uEbeLpyWc5l8LGTrrkRXCKAzd00G
 kQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355630; x=1773960430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4R+PfrpTL44BdQWmTJI+2BTLyEiS96HpVxYoD8sVcg=;
 b=FnoUEL40Y+LMoUxRMwsqf5ff5V3T1B9MQTY4vj5JfEjM6o06YudoS5THcNjfn6psLS
 0rL3g60kon3SLGo9yrhWMLKdh4wNJ5b2GzDQntvt62bY+15iKukcCT7KCxc3GxgSqU8p
 qNHsZcOwLnQ8kShr/vIK2rWdbKDsXT+CWqR2f1x3RpvLHpX7q6n54JtJUDfIGjTmCSqm
 Iacgs6+6AJDbOiUyMRtKbU0odzHUdaEJFXzv54Pjk4fumfV94+6VgwAFDyY+G3REEt+G
 rxT2AS1YHRrospT1UJVidM2kLMpOE7KvoInbGaHu9tOjeff5TarQkPLPzoSz37P8kh5O
 F3Zw==
X-Gm-Message-State: AOJu0YzRku7g1KLBUqRIpqxzLqxvOWSxJCooGY8486ZuCrrS0KiNKVw6
 LGb8fvpLfgPN2XUBF/VEtKbW01ww11F+Bmy6PMao6GU598CiTF6bvyOHxVZAYqmHuYSh5OnZfmS
 LU++JP78=
X-Gm-Gg: ATEYQzx/qGfYgfN2uY5DHNO9p+MbVZh0Bk6S7wCyxzgy/FP0ufWI69Ym8zdOyUJoGXX
 cBAKm7BdKNJp+v+WQICiiGsZTrZn84Ohr3C8p6kfyuqjl/KVgMkRp15MZANDxceG/y6oREw7aAu
 Kk+usRgAfk+Wo/9w9z+HB3biMS0gGKU/qa9EadtWAJY0359/omPMz8+2xo0JTi0U5HVS3F4029I
 U+fBR+aBGVbflxWBO82TzzWuToV3Nu4f9LbQIn6CShG6AA/JZhOOjonmvANRxSx0Qn1V2/QXfP3
 oLJV4BFVU5wgtfx8fVzXKDyBgZcna1oUSIwdc4FuFwLlivFQVKVh5iSNHw3rIwnS/uRxjRCxSU5
 2a4MemrsPhv+DR9ssr1lD7TGg/FnLmwCw2PZUmFrdOT41Z37VZ16cxtRlWkSuGxwlwryPKOPWtq
 Fu9VzI1mvMYtADAHReR4TUBF4gkdK/2CeQppkvj1ctCnxwInP4muIx9aVKiXwtoX+UtM1xEbCnh
 7vp
X-Received: by 2002:a05:6a00:1c9c:b0:81f:50ea:5d96 with SMTP id
 d2e1a72fcca58-82a19701820mr929747b3a.18.1773355629849; 
 Thu, 12 Mar 2026 15:47:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725be23sm3992698b3a.15.2026.03.12.15.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:47:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] target/arm/cpu.h: restrict cpu-defs.h to target specific
 code
Date: Thu, 12 Mar 2026 15:47:01 -0700
Message-ID: <20260312224702.1608408-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
References: <20260312224702.1608408-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow to use this header from common code, which we do in next commit.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..b8042f65bb4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -25,7 +25,9 @@
 #include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
+#ifdef COMPILING_PER_TARGET
 #include "exec/cpu-defs.h"
+#endif
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
-- 
2.47.3



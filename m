Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBFw-0005Ly-3Z; Mon, 19 Aug 2024 18:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEa-00010C-QU
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBER-0000js-Je
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42817bee9e8so37480995e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107930; x=1724712730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgKEfpdnr3u1IGXLtsU83x2uUd6qWPUEdCyP1ZB8Zys=;
 b=l6V1S+N4+OlIlH46fA580k7re6wCpFSSmdoaaaV6CX8zz13svKfoPSsvlS4SJGVj8n
 ODk6mNETHGfexhPCL1Kf3AVPOBOdPDPlq/a3PWdtO27bk8v7/9PnbMJT299O9ro1B1Sq
 DILBdBy1lINSuQrRm5Y7G/53UJDk+JggbxRJ+3ooOI+zQfvqWWAOfrEjAPmHiqo0m1MK
 G4zKyoONN7iBP9URkIkWR1uG+rLmoZhyN9UEcJ3XTSpCyDbTtiSa8rVNcpYqtjzYRxCz
 JxmaXeg9AcsLTvw6hJ8I5sQtk+sDFM+KaEQzCEwMxgEXbzZq7gEJQD0s41g7+UIs2yLN
 02ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107930; x=1724712730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgKEfpdnr3u1IGXLtsU83x2uUd6qWPUEdCyP1ZB8Zys=;
 b=rWeKAL29JBaSbJjDc2dD7hEFW5/mKGa7pGxpHtTIE6FsFqGCluLp7RVqBibO+6EJjS
 RXi3JXyRk3aErOYXn2upGjRiPnRG8Wtgad2PrpCbC03WX6Fhkh6oC1WjMUb3HNZT73bh
 +qKe4Ydvgmp9fWGFOFeQmSf1/GLHxB//KRv7pWjk53ZyvWj6VcDtMK9X960SqNqFu+i1
 OVKE2qUcTPoNty9NB5CIK+2VVBtPV3DdskVUasy6uiXElQlXUCHEtPPaewYZ/LwbfCpJ
 BpFqxoKe8oFnNJh1viAZE0+FX9m4XU525NWNhDBFWyfefltPmJI8kN/HhwnuWFp3tK1W
 nBDw==
X-Gm-Message-State: AOJu0YxgqPcDrReP1PfJOxorcKKdm0hfSeniY/9iZTb5LAVD6k/mSDKd
 rbsHmfcBZq1fO35XCG9JJLwFt1+ndogpR+gh9G94HYK6ZVwMWLljjRQ7hxdFVWx4L/Fh8FXApsO
 Mqj8=
X-Google-Smtp-Source: AGHT+IHO05bBYLBKnHwEwyBYs0v3AMbbgTHCiEVHRdk7MoRJIL53irnGQ7wxhyZUbz5td4hHz9dTFA==
X-Received: by 2002:a7b:c4d3:0:b0:428:e820:37ae with SMTP id
 5b1f17b1804b1-429ed785f4dmr82092565e9.1.1724107929919; 
 Mon, 19 Aug 2024 15:52:09 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed794640sm122901125e9.41.2024.08.19.15.52.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 YunQiang Su <syq@debian.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/20] linux-user/mips: Select MIPS64R2-generic for Rel2
 binaries
Date: Tue, 20 Aug 2024 00:51:07 +0200
Message-ID: <20240819225116.17928-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc: YunQiang Su <syq@debian.org>
Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240814133928.6746-4-philmd@linaro.org>
---
 linux-user/mips64/target_elf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ce6fb6541e..a3a8b2e385 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -17,8 +17,13 @@ static inline const char *cpu_get_model(uint32_t eflags)
     default:
         break;
     }
-    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
+    switch (eflags & EF_MIPS_ARCH) {
+    case EF_MIPS_ARCH_64R6:
         return "I6400";
+    case EF_MIPS_ARCH_64R2:
+        return "MIPS64R2-generic";
+    default:
+        break;
     }
     return "5KEf";
 }
-- 
2.45.2



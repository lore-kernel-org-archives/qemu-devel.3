Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F558C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1wP-0004qr-7I; Thu, 06 Aug 2026 13:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wL-0004nQ-D0
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:33 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1wI-0001gU-Fc
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:31:33 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so2471159a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037489; x=1786642289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VcydMAWQ11xuCL+EJ2Fa8fC0ZfigrS7o8S5cYAFbDts=;
 b=SQ/6RFTXzS/bZiWFJ81Re6gaXNHibqoaO+fu1M0/IdxFReyuJyKw0PykfGt1Si8Z4z
 ODHwKl/nfCnHI8KuMkovfPZFlmEt8egEcABz435Vd98qowEFU6qA95vLs1+aYvTNDKGe
 BB9auMEkXJi/tIbdT7WeVDSRimIvtJZoIII+E9vzjKe0ndrh/PU3S219Apn7Ko34jICG
 1BKNZoVAaCFPlRJ8l6vsCsh+5qtwSeHAVMvgZepnA+FwutgW0fx5LINqBnBeYY8umW8M
 WS6s2dujziTyXV+66m38+oC6uaGce5Io9wNSToCs5HwnWBdxV2bZq8jB2LYA+YdI2cO/
 x7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037489; x=1786642289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VcydMAWQ11xuCL+EJ2Fa8fC0ZfigrS7o8S5cYAFbDts=;
 b=Ti5PNsK7ktNRY2GMT7PuhpFGegRLvF1p8lHB9K25o3afGF5wP2ckQ82k9+mrUtJsMl
 lYjaZwStkpNH5gc5Yi2BLkRmWShMrPR4LcfrLuH5+chs4HiEc1rTEC98eSiF0LsddOdy
 ZyjagULs+g+Ix6S9q44aPBmYWIhJddcGwnEA8bNggqeokHtYp0CQQvyXIxBc+8Icl8N3
 6qGKxh8i13/VGl5HW4t1Y2UckWq1nBqaAgVA14ibpYAK9ZyHgNyuPtT2nCZj1ee43PZm
 GAkgfm0+W+tu4q4B7iVNTJlGQEEGSzir2/bfIzK921A5zHYr3K3H/gNOuWXMidfaM+eb
 P8YQ==
X-Gm-Message-State: AOJu0YzVOeQDghLk0j4Jam9gwdvaC7C2wMI4EmGard+dcGW1uVj3vqc/
 fpG7RE+aA7LT17oM74UepNudqWHfF0ukHFSG3+F62WC8OXYxWfp77JBeyf4qRAbIZe8ly8NHSO/
 aP1Xs
X-Gm-Gg: AR+sD11kek/GkjQrskr1rl8RiYX6vDZpbWnq/bg2TpU3FWKCiANxxWTRy/N+JZpsG0I
 XiZK7BvJC9cQByDUjnSQbg5uMBr0FRlhr0A5dAhWRZkGAhcqMokbdeQ2DzBhcU8ciabSL7o8DyL
 m3cvF7AF7KdP0Q2ldYZNzIMQKUIyU8Sd6996DpT5ZxMVaJ9ukedAy4QJ1/EldKvoTnwzkyEeSEy
 9JAYG7ApAvpIgRkfIHZuN7imNFRqDdvGVA+9Ccy7N0BH+2dPibDMlNAB3xMyrUM8j9Hm8Dju9fZ
 Y6KGzjt/EG7mA+mEPz7zREY2d/0nJHJxuZBVAbuqQVpF+H/I7HU3H12DlP/S6WdW3oD8GiN/vWw
 usDtESO6P+Z3GnP/ACjMxJZqgn5W//M0kW15uQIX2tSeXoAIfkyLLlowib7yWCE1LKpoScI/G0l
 qB/nAf3LgaGVseaP80SKgozRsrmYAgPVBN7ZACjrGnRSg6zHakNl+R75XQ2fdKjY4SILpzu4Jq+
 tLYKhUwnelM0d0/KWZT
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3903c544f17mr13934520a91.6.1786037489021; 
 Thu, 06 Aug 2026 10:31:29 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085e4a2a5sm1983711a91.14.2026.08.06.10.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:31:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/6] target/arm: Implement SCR_EL3.TID5
Date: Thu,  6 Aug 2026 10:31:22 -0700
Message-ID: <20260806173123.333423-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806173123.333423-1-richard.henderson@linaro.org>
References: <20260806173123.333423-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 854c8902b8..71c655ac07 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5485,8 +5485,21 @@ static const ARMCPRegInfo dcpodp_reg[] = {
 static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
                                   bool isread)
 {
-    if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
-        return CP_ACCESS_TRAP_EL2;
+    switch (arm_current_el(env)) {
+    case 1:
+        if (arm_hcr_el2_eff(env) & HCR_TID5) {
+            return CP_ACCESS_TRAP_EL2;
+        }
+        /* fall through */
+    case 2:
+        if (env->cp15.scr_el3 & SCR_TID5) {
+            return CP_ACCESS_TRAP_EL3;
+        }
+        break;
+    case 3:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     return CP_ACCESS_OK;
-- 
2.43.0



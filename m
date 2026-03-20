Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F131098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYZ-0002xv-3F; Fri, 20 Mar 2026 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYU-0002uF-Of
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:22 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYS-00062X-5W
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b982d56dac4so9347966b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011978; x=1774616778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IIfuVNShSCGAnkztFExkrOnzU+0t+GNCxgKlZY4IitI=;
 b=vfqyPK5O46edz9OxU7rDChyk5vHQSGSU4kK4Keg87N4XCcGOZTIRh53A8AcpTYem1d
 UyOQ0O6X6a3oFYJbwIrzoOikO03M2hCBnEK/6epNfFxkqf/dYpTE4JVg3O6nWC0x20X8
 Li6D24By2XVUn6enLFg76oJ2bzfISWsqbiaACgjXleLk5RI5hV9WFB/MhcP/TYN6B88g
 o57RS7D+RC9xFX7ti0edNxXLlBSYqJmOagId9b2K2o4LjovzouMyGqJK6IVCkLDzfqNm
 ju1DP67fC8GChI77WDX9G2er+S0FHhthVGc4s/HBxM3AUQUby3zD/o1T0z/V777WKfcz
 YXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011978; x=1774616778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IIfuVNShSCGAnkztFExkrOnzU+0t+GNCxgKlZY4IitI=;
 b=fyKUo9EaE6+CWJlMuubd4U9PH5V5WkBAvNjdvYeumwFR/2iv9cg1JO8eBwRqB2bE+z
 xwGrmYRZeJrOsSQY5myLDV7QmlIzrAMasIZx4VyC9jMgEyryfOXAMClwNQoe/+/7uqx3
 Z+G2YB1E03K/eYyk0HllpewAxtwgq1ka2lEG5nu/X4fLYpYh2oyGfjyul9+H9JrfPo+i
 K+7Kd+5gvqj4j6R8RstgJq9Bh1m6bvGyMwub5W9Gnu9XdnN1sDK6xojOlVZblxtfoehm
 mLodapSOZWjxvtQCMjnWLJusyYN6IWBLp+xcZGsf1eNkROccIlg5/nyCNxaWnhukIxl0
 pSQw==
X-Gm-Message-State: AOJu0YxAaW7H8yZsl2xYjEg/ytT9R/agXLBl0Ylqsy8amQ7k4THsNEEq
 cydENPPJmjR8yDRBOdSbw4lI8am4+3gTXFrACQcXDf3rqpMRlD0Y8Olr6VLXuRFj/bc=
X-Gm-Gg: ATEYQzzag28V+4GiwZGczmcITYMtdIr8W0gsdZ8z/9jOhU5xZp+JV7dTeiRsvkqvC5E
 zTrnoAA0lRVYD1vFuRlXPhWdNrpbnqQED+6X5WkOPU+wnmwEoMu35/T9ZXWgLwlbNCV02rwfK6p
 0Ri794kyKLRzIrcHaaujTV4SnVY0w6Qf1ztD/dF3f2xjZnGuOk7gfdePD3H6zPWFI7s4O8CeLC6
 keYztK8AeddKWO+iisysM82bQlmsCyilG03lzV1XqBALBWauqVLG30P3eewco6zRhE61iC/vQYk
 UUnnBYnETScGHpE1N9ApKesm0+URzn0PXIcpXvXvxbFlF391zrd13pX+jUBMZbvRAHAEowBexM1
 9uAiHmvXgx9PPXtc0sFS9q+0EiRzsW5JUmKRK7nXtA87Bp59ji205mDYy5ulckdhCuFp6jMGsHT
 4Yd5Xz/gQNADJvWZAzP4xtRQo=
X-Received: by 2002:a17:907:1805:b0:b98:13a:c92e with SMTP id
 a640c23a62f3a-b982f20c399mr201165266b.2.1774011978327; 
 Fri, 20 Mar 2026 06:06:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43c3bsm156892166b.2.2026.03.20.06.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E5795F94F;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 12/35] target/arm: migrate wfx syndromes to registerfields
Date: Fri, 20 Mar 2026 13:05:43 +0000
Message-ID: <20260320130607.2071996-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

This will help later when we expand the fields we report.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3bd98a30367..503b19b5d02 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -655,11 +655,25 @@ static inline uint32_t syn_breakpoint(int same_el)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a WF* instruction
+ */
+FIELD(WFX_ISS, TI, 0, 2)
+FIELD(WFX_ISS, RV, 2, 1)
+FIELD(WFX_ISS, RN, 5, 5)
+FIELD(WFX_ISS, COND, 20, 4)
+FIELD(WFX_ISS, CV, 24, 1)
+
 static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
 {
-    return (EC_WFX_TRAP << ARM_EL_EC_SHIFT) |
-           (is_16bit ? 0 : (1 << ARM_EL_IL_SHIFT)) |
-           (cv << 24) | (cond << 20) | ti;
+    uint32_t res = syn_set_ec(0, EC_WFX_TRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+
+    res = FIELD_DP32(res, WFX_ISS, CV, cv);
+    res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, TI, ti);
+
+    return res;
 }
 
 static inline uint32_t syn_illegalstate(void)
-- 
2.47.3



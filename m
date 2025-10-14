Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3531CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2e-0001cB-7x; Tue, 14 Oct 2025 15:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2U-0001Zy-Q3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2R-0003Po-Cq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:30 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-78af743c232so5271912b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471424; x=1761076224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2Xy9FdJMIc8NV80GYudnI9XDnoteebZK7GGC8hP3Zs=;
 b=QN8XHLi4MtJc0y9wqdeahgH6pWtux4nFIw7yLzH37DSRzNciB2T9JZMfZAofp5eE+u
 3AGIsiI8I1u918vLws5CoCsxCfYd+eqJ7i6sxaQ7/YCAUedZG+vtaozqu+hyzZAWmopB
 XTCx1neVtgPi71fAXfqe2BTsWouayYHQoXs7ziC3JtExt5nDncZLT+sbvymYVe9crllR
 0UG7VKTx7ItsKZsTlxxxTchJIDGGue7lraJcdN6xey4fNT4/kb3k3IovBhUHdU0abcag
 VmN/uKNU2IjMh9vPHkaQ5uK3ull+0n03lbJ9HqpCnK0IPbHmfbSa6QueE3cn+yigq0Ym
 wuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471424; x=1761076224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2Xy9FdJMIc8NV80GYudnI9XDnoteebZK7GGC8hP3Zs=;
 b=PSlbfYWRXgESJRJDVdj1f9McrD2Rb/wi7X538ov/UAxgD94d2IUd25fmm1lKP2N1tJ
 mQHG68nyW0M9WqwPjmGQf/yBX+tt7qtGuC8dfxowCXc64luWgp1OZnAmENsnkxA1us8s
 2EqpEU1lhk/kdnJRvWl+EvDDr2ZcP5kVTk1FyZXixcxp9iHj0GG2WpNAZyfSVlsnkhXB
 oCUP3xyS4fUF3vGZCsziKZ8gMSybGaaA6Eo26fJKso63BIGxJr/pIohnk8ZtPrjYh7hD
 0Ef87921ys5HKyIU2W4IRbJQtaDqFwcX5hStuPqYcWJqGWkeTVpbvT6pus6l1Vit8dMk
 x0WA==
X-Gm-Message-State: AOJu0YxodybEJamuKwogb8lBzXMUZycq5+ga4Q/0OLg3G6KYhtPKwqcX
 szPTsyCvSFxNGfrwmsd0RetyazTpHmH79nNic5FWeM7nSVISltJko4u7ySeFkCp+7lMote7/gvV
 62FI/lY8=
X-Gm-Gg: ASbGnctOqssCaFSL93WZCL/xmU3q8LeoU8GIaZSEg6SuhTdFAMX9LKDs4Bx6MF/g0rF
 Ppo85zI9C17y+76Lyp8Yq+qSx2u7oInxfigEqUCIbWrosu65/NAj1GgD27gz/7DSDiJZ/RMvzIp
 +q1LPel5xIgtqO8C0F2/hRlZ1oj7wF1rj/n85licGhoFI4Va9v8RFWthUzl/F7ksNMlq2HrZ93g
 gm6BXVrSjOl1cEhz4AlErRmdlW7FK5wdSa0xCFwbn2ohwj8yv1O+PyBR7s583LcoEgpzEHOFvFW
 Yc+wDjXzxi6XQuZkgqoye3AiSReb3UI8UuXpzy7o9p+rHXKprw1vn660Vni1Q8Ibg0mLOcLwPji
 vJGx3DAW+zSpRfbEEdTRk3iNwJ62MMyi22i64LyJsFPTGEVSVtc8=
X-Google-Smtp-Source: AGHT+IH8/s9RQFwZ1jyjGBMNBf0m/XQQIUmyOTE6Xxz7hy3qpf9H3m2oUtfcG7b6eqaSxLmYjMQ2pA==
X-Received: by 2002:a05:6a00:14ca:b0:781:c54:4d24 with SMTP id
 d2e1a72fcca58-79387052554mr28867034b3a.21.1760471424148; 
 Tue, 14 Oct 2025 12:50:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 5/7] target/arm: Use el local indexing mair_el
Date: Tue, 14 Oct 2025 12:50:15 -0700
Message-ID: <20251014195017.421681-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014195017.421681-1-richard.henderson@linaro.org>
References: <20251014195017.421681-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

We already have regime_el() computed to a local.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 54c45fc9fe..5fcf104272 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2319,7 +2319,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[regime_el(mmu_idx)];
+        mair = env->cp15.mair_el[el];
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0



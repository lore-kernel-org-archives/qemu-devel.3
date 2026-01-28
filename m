Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33813D35664
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vku23-0005cp-BD; Tue, 27 Jan 2026 20:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1o-0005PV-P2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku1m-0004jV-Op
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:07:27 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so2805578b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769562444; x=1770167244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ci4W1tTKlIqWO9VPthw/j0kWq/5WvkmB0VNMUaFTDc0=;
 b=JSpne0nGXq/r2YM18h7AwJtr++DHSdUVmYlHz/r9pizRy4jdiCXIfTJ2djwks9KCvw
 9eSHBJVj3/Ykz4wRTrmerMbufyUrv/QVEqI3/3SqjXK1EV8S+4WR2pmcMjuhU7Xnh4+N
 ZFN9ilhUmt9541NQsC0gJcGsQh10fp1OyymUc/XzjCJUL7sS+CsbMHMJKmZxFrtjmu1R
 8oOkZ3K9lu0kB04PvXdKBqASG4GA78ns6WOIXcDo7wwYPIuJvjOY49hhktFbYT7LgP9t
 dKywo67GK9xAILZsmCnMye57rNdJ0SdTMNNGJ1B1Nt5TXRpoa4DehY/YaNit0bd7W8rj
 ue8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769562444; x=1770167244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ci4W1tTKlIqWO9VPthw/j0kWq/5WvkmB0VNMUaFTDc0=;
 b=oXGXJGtSPtT2UV2P27FPo69J83QftKPxuEzUuOEFlRAANLSn3XVD9Pw/s6Klv1q7cZ
 hGZR15j+6hS7ZT0fQ/Dr2v9uQJSS430f72AJFRDYQEnJGyMuxQ/sLvzZhPrv1ZrSCDoZ
 8MVzaR2eU1uGF66//oRPIm3vjmzl2rCrcE8gktraEATG7YMZDq2vBPLPrOBKfd9Rhac7
 IEzvKfoleHEgIdCcfcfoyQm33YGVMX8h/JXEiFfdKT+u1NwGHhZFlGZTiUmvL4eVnTBy
 oqVN2CMg8tnbm3D9kB3dy6RnShqN8tUfnpalOA3pdjt5DfDq5bY32Bb6X+yR3CgGrS+v
 ZAgg==
X-Gm-Message-State: AOJu0YyK5ymdXmxUQaq53vS4V16/Reg/rmebXscD4dsFvrxMrWsilC0y
 hdWndS/IRQmbFtjQc0Os5qv5BWU/NFmdEuIjzswTSsX4WvS+z2tAQXkg914NdTxo4bSbX5TrTj8
 /u2hslRrmaOyd
X-Gm-Gg: AZuq6aJJn6Kt9JGlaTEkbmZ7ENxP217GlalPZVgZvN3PEIU0NbitOIaRC/C+bLQWYUB
 mfJ3OrvM/dCOWyF5a/HWBKo0nZOG8EpkTL3oEcaeVDxKEsV0vSQIPM7/aIb6c4kS7WzhR8ZdBoD
 L/EPDeVomBbnfJqNAKC6taXu5H/aQ6Tw1mLwCUclsljPdhEkzFAlzBQGTEnxVB8B/DMJLwBE9W5
 Gw9/Y1O0BwDMo21pJ1KUGY/bYyn6in4CjfvGMHtPlBUHMeXSqeIQcea2l0C+C+R4FYrb7HBuGSC
 Aqp6ZOA8CISkFxauyDauF/Z08mOKYy41Zu2NHyigYdqUSBzdDEckXP/95iMplPzPozlQ8gd3GAu
 c62lzbvhyXie8sZKbYtpgavZUC5nUsledpMDnKwILiP0wOlx9PQG64WDyCVbWra25OaSGGXhqyx
 vrRu8ropbrvqUNQLWFoQ==
X-Received: by 2002:a05:6a00:348c:b0:81f:4e0b:324d with SMTP id
 d2e1a72fcca58-82369311128mr3092303b3a.69.1769562444002; 
 Tue, 27 Jan 2026 17:07:24 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c53f6bsm719407b3a.63.2026.01.27.17.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 17:07:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 3160104094@zju.edu.cn
Subject: [PATCH 1/2] accel/tcg: Don't pass NULL to get_page_addr_code_hostp
Date: Wed, 28 Jan 2026 12:07:14 +1100
Message-ID: <20260128010715.347776-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128010715.347776-1-richard.henderson@linaro.org>
References: <20260128010715.347776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

Pass a dummy variable instead to let the value be discarded,
in preparation for making the argument mandatory.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 6adfeefe13..0ca13750f9 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -105,7 +105,8 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
                                                 vaddr addr)
 {
-    return get_page_addr_code_hostp(env, addr, NULL);
+    void *discard;
+    return get_page_addr_code_hostp(env, addr, &discard);
 }
 
 /*
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C049910F2855
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6APJ-0006kc-8f; Fri, 27 Mar 2026 12:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOg-0006A3-Kl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOe-0005Gj-TJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82a07738118so1462599b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630255; x=1775235055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76pt2dDyK109O4DclIsLAZjjAPxT8fp7+YkgIE/RghQ=;
 b=Fl2pjyWKlOTp6OwDxKVidOVTebyxawgm2EdBbPHvdhmyVU6ZF+OkXs8vzdRrHtQAUK
 pXqOeHXdzwiqvMpKJNYS2z7VQ8+n68Pghc1GHjxeOkuw9Q159E1jO5iXrIyVBaqj7wy1
 dpXYmw6KndXwOAAWc7Ki6WWbzCcs53uZkY8TdwaRNcKjuGT37M4k34hDA0wRilcNJNyn
 7NfYrktRef4GiWSAtyo4lL554cdWrVPnYblAsrMMBXVrHOqCPp0/dd29ajr9IPP3+m3/
 AFzkSDWBGJBQpRqgHg8uhCZTqH1bngPBty2A4Pe7CG/naJ41DUJeV9w2dYJlRPjK8PrX
 +1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630255; x=1775235055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=76pt2dDyK109O4DclIsLAZjjAPxT8fp7+YkgIE/RghQ=;
 b=jYrm8clbZAGkyb0C2gAahASjbip3z7H58YEWJwsKmDvI842IgLprvtB4mA4bP4Lqgs
 dT2Ip1Bp8aDVfrYupYyqeBT5HWmuJeo/vTh8fvLq6R/JztkhMtOwEV5r7ZKMykLKhm1C
 x16ivRBc/ljYsKZMUC7yc1XMpXxO2SqC0CxSKdY8fJCiXMXeZPyrDt67EUt1YCvjAZkw
 /3ytlgOTjVuPyQc/FK8iPJo08zuriycVT+nzFMq/rOyXXLZZySiOlYnENIa+AsgTU1Qt
 DT9/6DCpDSHFEV2CY9SRc8BhsrB1bbq4+NPiEORkJwKUl4GzHxl8x9EdVpM2IhPSiBU4
 HhTg==
X-Gm-Message-State: AOJu0Ywl0vGqN3gsDC7BHks765OczqaP64+DkrI6LYGrUHyWp3VyEVCb
 Q8kKmxzrW71OgiCGbHVrcRvI5xf9RS1r8Z/FDmOypbcguELd1iOlqY6V3KdFHxNPNk3uQFwaxOq
 cQ/R7sXc=
X-Gm-Gg: ATEYQzyz6/s0edOdUs0tSq1apMOEB5nPSkrM0Z7g/tCNvePzk6HirHSaYjWzVbo27C/
 rUIZLtOC0at/gJpbePQrEQAcYih27UmLTLo7VU9mSlyyERCUEKqgFnKsthkeceANHrhnm+gzjaS
 LYx37W/Un0uVdn/dSqroo0Lkj+firuP975dpuoXuDBNBB/WEHIZRkwfU464cdtEpdZnGQFQTxmY
 jKuVPAgdldY1pSalDfkRiePh0A6EW0IrtxfNa9krtMB4zyiFp34QCYcWah3/6OFUKnFE9XCf2+q
 ZICEAVPjS8yHnJ5F0zdoaCTeBRoA19woG6HzSl6B1eXLxwEh0guDfUI8NBFUzpgiU8c6cOr9ltT
 qncsXlq4SoUUWj3GQqtIFnHytzKdWSZlQZPNZTPuBNtnMQIfEIaehOHMy7FfxO1tk/R7vLjM/n0
 +CnPuy9GYne9MvIbsyKIXlufWI6mUc/0YKDETe3ebkanmEb1mO2UHd+9qVjhZZDR9WDy7pAfcDg
 ALcvnDi0zcU3nM=
X-Received: by 2002:a05:6a20:7485:b0:398:9466:2eda with SMTP id
 adf61e73a8af0-39c878c4986mr3546479637.19.1774630255404; 
 Fri, 27 Mar 2026 09:50:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 08/12] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Fri, 27 Mar 2026 09:50:38 -0700
Message-ID: <20260327165042.604105-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1e9c147e4d2..eb87eb63c1b 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -27,7 +27,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -58,6 +57,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
@@ -72,6 +72,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +84,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3



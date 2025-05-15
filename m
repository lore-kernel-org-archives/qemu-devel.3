Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50825C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoO-0006QV-T9; Thu, 15 May 2025 06:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnT-0005HX-E0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnN-0008DQ-CV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so669572f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304790; x=1747909590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sFij1h3veGtKhSTyxyyf2bRq4SfQA6FXNfG9cnrUTkY=;
 b=K6+h+9Jskp2qOdvxZk97L7wBZB/LtXXZca0K84tqOYnsYbznuRFQFO8QYX2docrVaN
 ejl5DMVXgKSCMQ6Kdqc6f9IZ9P6O0JhJmmj9b1Fp0aovBu9eBS+GzqEII6159mThNZL4
 DLfR1xGoNhmCHd53ggdcbvToDnC8ytK4rT2dX9ocSnZtvXmmDI12+K9Q4coGyo17DStN
 SxQ2FVzBdzu9YG5jb7+u5ifPVr+EukdqupNOpZOw+HS5mYBsfHGqvs0uK28s5eiHFm52
 NrafIiNNIsrg9KmfjZ48JRay7okNnZ0h9UOsVlkqSvxc+BmQ9Up+a5iZCNrkCh/4ayGR
 2BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304790; x=1747909590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFij1h3veGtKhSTyxyyf2bRq4SfQA6FXNfG9cnrUTkY=;
 b=O3sQcU+cWojHgN8PUXCix13wb7vmGWlPnzV3BKf+E12Zs4bJdVhqEHGU5pKRUSZMho
 ItjD+aq3HaQCn5SGtaPLCBtJQAxKi65KfFpz7ykITcLn3yRpKci8lImwoDvU7GHcVp9y
 jXdYBcTxCV7lhVcWqcEdb987lsbCci+EefDbZ5kJWntERXuD0DGEoWXdc9DFL3jLXTPh
 ui5CWdgINe3d8yB15RvUNZR07DE4Z8yWyAz3OQHWRmqqhX8fn4+lmiWHXvuFoK4QV0P9
 d1LSAJKyGIVnMKVnO6GRguYHKUD1NjVyMaYrgzTVE4wqcBXEQrX1jXj7DJest/NtFYkZ
 aKdg==
X-Gm-Message-State: AOJu0YxBqIC7sZLOZRbs/FOCXDq2+7B4YKNJicJM8MPUrF+yogFSO6nk
 fWC3Dcsah0i+Nfuhj1N2OuxTAHB2tfExY16I5FFqkYhCTRWaZxTei2aLEfI8GiGeK8ixHTsI2xs
 soh8=
X-Gm-Gg: ASbGncvH7gIdvjmz36zff8cCaB+1FubfRlHXAECmAadIIwT2Oe2q7hKRqa/E4ggERqK
 CY841x/te1tDsx41NoKdIgAhLSbh9novvhzXS2QmK88Bx4mtgfao6+BOZVnSMv4T9j8BBw5JG+l
 cVFztKGzmbGTGJfJq4SWBWBB8SoyHjgisafCy4xpMPV34V2E0/HV1mhy3or+Sh9F1cu0TBen04n
 9IDBhU853v3tTlpTTOBxtibKH4gdhVDn3mmxYqZfr1mgnMFcOxSK99jT99xYgHCSr51D7x0iFNG
 B0IeeJE5Ydrh4Wuh6ENTZuEAsL6ZhGArwFhhMAnhU7tUUJz1PrkSKDoo4w==
X-Google-Smtp-Source: AGHT+IHRyXMSwYfDhHga5wPTdxeVIcP7wHyvoPOwzpUNT9kl1ISc5IUJPq6ZDfUHwoA4dsXfssgQnw==
X-Received: by 2002:a05:6000:381:b0:3a2:229:2a4d with SMTP id
 ffacd0b85a97d-3a3496a49fdmr5513537f8f.22.1747304790042; 
 Thu, 15 May 2025 03:26:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/58] target/arm/helper: remove remaining TARGET_AARCH64
Date: Thu, 15 May 2025 11:25:20 +0100
Message-ID: <20250515102546.2149601-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
we can expose safely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-23-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 92a975bbf78..aae8554e8f2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -29,6 +29,7 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "accel/tcg/getpc.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
@@ -6565,9 +6566,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10625,9 +10624,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11418,7 +11415,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11530,12 +11526,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 ARMSecuritySpace arm_security_space(CPUARMState *env)
-- 
2.43.0



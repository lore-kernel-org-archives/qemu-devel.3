Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC666E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4cX-0004UM-DK; Thu, 19 Feb 2026 09:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vt4cA-0004RW-Iz
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:02:49 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vt4c8-0008KT-Ju
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:02:46 -0500
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-5fdb47d6131so284618137.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771509763; x=1772114563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZNyPTPn/rVQB3CIZ0lj+N2kFtusV6S7CF2vv/Tsbpc=;
 b=caFUskrfRqSChYv+7pohGpZ9T1KLZAWQKd+J2BnR7e4+B70AN/teA67JNwSRYvy1cB
 tShK+Zti9imvhwxsf69/d4xB++axGA4OKPbdUbEI6D2W5oDe8YJpbMfl/qu3PSJbugG+
 nb5mJJtV/1A0OQrGh2ntSPZbp2gj2MRPmQow0NNfqPpWAZfxZDqcUwAVxJaQmdBJMGqu
 7we6UFSbqb4iXj9ELYQp8DQVrCHpbAP1Ci4tSUKdruczFzKpII6kDz2XoWr0i5+RUwCb
 6CON+woQQIcTSaI4Yyh8U4+o8dKetI0MiyVY2YdKeThGaOqseniIXf2O+KdM+/eaYrSV
 UJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771509763; x=1772114563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZNyPTPn/rVQB3CIZ0lj+N2kFtusV6S7CF2vv/Tsbpc=;
 b=ofRrhcrq84UVxSF0LM8jFgudqNNUcECO0jMzFxZXJYatJ9q2EVLRbS90ndc1Hl/kYX
 tAkCgwrLru5DtdjbUttvBE4/LuXCUQ8Sr3J66UHuxsRG0ByOTszLfH2BoP8mg44G4qHE
 iPjYuLXHzjGC8N1D+qaPnC10GS5fqGOvdvn6xYrZ/ZhQxI6b8QZvZ4vx01hrkrnE+19r
 zWIhjFtX6USJuwiiBDq2v6yvFobDHQxvnSvsLgPvOSwvweB5MC5lkqzb70HB/nWTgFHW
 cIqPJBlsYY3rlVIV0LTJfY3Mm8lzIJnWhciY8xKsMRxmM8LXJL72nAfACM21ZK4N4Wkc
 k2bw==
X-Gm-Message-State: AOJu0YzlnxBOiNIjSVtoHHc25qHWylGW07an1zv9HvhtRLYdjqHsG87g
 rdHicMBFKfJ0bHnqGjBDtIlWaTJmCRsToK+Mtuj9r6RXqkOn/SVB1Ci0j0d7+SRf0uGlYfZ8QA5
 sb+iG
X-Gm-Gg: AZuq6aK02oGkUuyAHAeik35vQ8etkIMt420twmdG+zy826UhAoZNzagpeUu/a+MqLJu
 8VyZ++38aD4fqB2UO9kN2j6SrFTz0tCkgLMmw57ku9XJ1TOTars4bGtzMQ51QsK9xlpckSy8RHR
 xB1mvf7PVmAdiFgKATt12TIC6EqvP7tq6mPnG0WPA3j+gRLkezrVxG4A+FWJ5MWFGKIA3+dILhf
 sdWjCmIURsg+xK/Rquq4tzVZ9ojY5CYCUpY9O+pOhIuBhD3ISqbuhjXwwjj9a+zYyHyvONyKSms
 9nTDsbY97H09yhQ5XT6UJ2inmJJ3cf0FS1Ptl+4kyKFxBj+jJAvwE2wR49dLsyXvNEqZQEX53k5
 CfrZdW5x9rhiEBjmjRaosH1ivAmYBAriDVYEJI+4uUK65gpruF2jxsOXWl7NQvkj+lNWNQyGzHl
 D+IlIkcd37lDrzoihZ14KxgQnQF1NILr0MCsebMEllWz6D9JPYfG4EsOYcHKNp2HwhSew/
X-Received: by 2002:a05:6102:3587:b0:5f5:40e5:24c7 with SMTP id
 ada2fe7eead31-5fe8c7bf451mr912682137.7.1771509761069; 
 Thu, 19 Feb 2026 06:02:41 -0800 (PST)
Received: from gromero0.. (200-100-75-206.dial-up.telesp.net.br.
 [200.100.75.206]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5fe902db070sm1656931137.3.2026.02.19.06.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:02:40 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH] target/arm/ptw: Clean up unused ARMMMUIdx
Date: Thu, 19 Feb 2026 11:02:28 -0300
Message-Id: <20260219140228.407513-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe33.google.com
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

get_phys_addr_disabled() is called from only one function,
get_phys_addr_nogpc(), and from two locations within it.

The first call to get_phys_addr_disabled() occurs when mmu_idx is one of
the following: ARMMMUIdx_Phys_S, ARMMMUIdx_Phys_NS, ARMMMUIdx_Phys_Root,
or ARMMMUIdx_Phys_Realm. So, handling ARMMMUIdx_Stage2 or
ARMMMUIdx_Stage2_S is not required in get_phys_addr_disabled() for this
case.

The second call to get_phys_addr_disabled(), with mmu_idx ==
ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S), only would occur if
regime_translation_disabled() returns
true for these mmu indexes. However, mmu_idx == ARMMMUIdx_Stage2 (or
ARMMMUIdx_Stage2_S) can only occur if get_phys_addr_twostage() was
called, since it's the only place where ptw->in_mmu_idx is set to
ARMMMUIdx_Stage2 (or ARMMMUIdx_Stage2_S) and that only happens if
regime_translation_disabled() returns false.

Therefore, at this second call site, get_phys_addr_disabled() is
never invoked with mmu_idx == ARMMMUIdx_Stage2 or ARMMMUIdx_Stage2_S.

Hence, since get_phys_addr_disabled() can never be called with
mmu_idx == ARMMMUIdx_Stage2 or ARMMMUIdx_Stage2_S, removed these two
cases from this function.

CI: https://gitlab.com/gusbromero/qemu/-/pipelines/2335353022

The failure in the "migration-compat-aarch64" test is also observed on
"master", so the chance it's caused by this cleanup is very low. Also,
it's a test marked as "allowed to fail".

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/ptw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b8dc09e72..b8a3150f14 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3449,8 +3449,6 @@ static bool get_phys_addr_disabled(CPUARMState *env,
     int r_el;
 
     switch (mmu_idx) {
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_Stage2_S:
     case ARMMMUIdx_Phys_S:
     case ARMMMUIdx_Phys_NS:
     case ARMMMUIdx_Phys_Root:
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C251CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUg-0006DU-A1; Fri, 15 May 2026 10:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU9-0005jF-O2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtU6-0000vf-Ps
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso4770233f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855148; x=1779459948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iMeESVfxoQL4XM+HmSKggMAQZr6iHvyZ6SpMkCmyMlQ=;
 b=xxr4DHVjwldXXkWJzo/oYmfRlyJhob6KnbOcbisSzF0VfsumVe+yujXVMrKPt/2W2h
 6XpUfeufdG0G28Bdf7mGPQNTGxO0xqq0W2qN6vHoQYHAYBnDluujhx/7V7VNbsGM8Ukn
 BUl45xc4Y9DaYzgxc7o4LzaqfB0vS0nInuKCP7hDb3md0JUq5/rzXp2e/krEFOBpKmxJ
 n8s3mCAUj8ykqdVmUI8XT7V82tRufW6FP0MXxDrC5B+xdyOryOe7XHCNmXhwijjS2ZWZ
 k/IMd4L+fE9v/SPXza6ie+iD3JA86QG9ioZaUM/K4FT3B2c/Fm5JvFk0+ViULDsjir24
 rHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855148; x=1779459948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iMeESVfxoQL4XM+HmSKggMAQZr6iHvyZ6SpMkCmyMlQ=;
 b=CZTb0rqAtWS3auZQViWOX44hxZh3LtBf9AqIPnZYpwvS9+NTpCWut4XZN84lK8zCh7
 W9z+6aTDD9nyKzwjwmAB2RmmUeccglYlVVwrjisZMlzlMBWOoD8B85HWZKks9A7sMRMj
 HjKxWxXu5YlqACLOXen/2jtbsm+SFJ+Vb2fCrJsAUA4gCK16hvvXRc8Fvb1ktx8NZGaQ
 pJWZLdT7xEeiRUZ8Jah/RSNfhg0H0cz1JR6LRwU18WmEpxP1+2Ly2OCvQIVhzGkZKcJk
 V6f6RYYtkPjmK729iH8TCAKZPYKzNnKAkd4iTfJ8PHBPRuTrpmi+E35oq/B+EEJoG08J
 zyxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99Z1OBdHzRlxu1Br5unXiFeZ88fTsAWhNvdh0ayDcHBrTd+djkqshwoDvo+daj/hKxsbXUDDqpwORL@nongnu.org
X-Gm-Message-State: AOJu0YxYmxFNIfVEnTdgaRjtd5PXYfVYvebK3oppjlNL483gScbK3ZcH
 8kG1oYJjJE53eltMWLvJwvw7am1MdWemZU5QMbCEnA2Imf8ZvoFHgdCaKKdx1YtIDt1mV16opr1
 +dzwP
X-Gm-Gg: Acq92OE/dBNpWVOdKmMuPSR1gNojaRkIvSNf1wZ4kV9l4yTYPP+dvHC51PwtyqqLQy3
 Sq91YgTAaEFYJx0eexnaCs8L99EP/kVxylcGyZiDjkc25hIMdKxf1NpSN9MbhjwsV4KqHxUIqQl
 30mYpsgkt7JFoXTOlv33OQGv/U3bXd04yk759pBtLhyBbCMDwvekajmzMi1E6Cr4ovBbyhBQxtz
 CNT/PGTXITAahLEaoIM1P4m9KupMnUebx2cmUQiDHAO/c6NkAhmGvbHQf3t7lhm5HO7tt9NdHE2
 gHBlHRzg1whz6RybCUXOi6HRbHKn8gnYdnFSlGJlD9wGqh5+3Dls6yZQ33wVv9lkCgkgscVPPm5
 Vkt82FxH2wtQjEgEQvZxgGxZYoW09q8VAAILkdw0JqJNjXPU9ZRRIH43cMnRPN2tZuzN+i9p18E
 cD/uCqxZBV3HDNGjJpx7HjHVTZNu4ZWnS6A3yUjYe5zcvcQM+0XNOafzRUC2N3WRY17TRvMNqjm
 mx3LQxyBUjQdx1Jf8SpfPppUBvvSx4oHxQzkdWENYMUv/MTNDu/
X-Received: by 2002:a05:6000:2502:b0:43d:7e34:889c with SMTP id
 ffacd0b85a97d-45e5c5e68b7mr5918628f8f.39.1778855147705; 
 Fri, 15 May 2026 07:25:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 04/14] target/arm/ptw: Flip sense of get_phys_addr_v5
 return value
Date: Fri, 15 May 2026 15:25:31 +0100
Message-ID: <20260515142541.571911-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fa251f5b5c..1730caf180 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1169,11 +1169,11 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
     result->f.phys_addr = phys_addr;
-    return false;
+    return true;
 do_fault:
     fi->domain = domain;
     fi->level = level;
-    return true;
+    return false;
 }
 
 static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
@@ -3793,7 +3793,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return !get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
-        return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
+        return !get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A1C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPY-0002T4-7Q; Sun, 27 Jul 2025 04:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPE-0000Pe-LK
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:53 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPC-0004hS-2e
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-236377f00a1so30196225ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603609; x=1754208409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9Mg6ErdWdTHwLMXbslXCxCUWg4H1dPmwKDtcENgOd0=;
 b=Euhaa4ztM3bztRpBGFnOGvS3y5vht3IePEPIfMA+14D6tcamLP6dyGQd9jXi3Xn5xM
 lyUwb0S+MXDNLugT1SlecpIcqKN9qohCKr7oiNsS0b9y7vD+pA3T1F4fMohAUPF0wbYA
 t9dob8Hv52P9EgQcWGObJbL2R2YEKtztFipVWqk2JbxB/y9NTQSFHUGmRPIU1jp5tOX0
 2AKp482e8bO8OUF4a3wP8b8lT3Gpmlz+NkWNZjgyX5Ymm3H1d5U5XQtb2maIoTmcPJhG
 c3aB6nkDRpDkJWLvAlfLBYoWvvO9O1u4HiZblfocEWtFji6I55ZOt7XdrBpPy8zekdFS
 aHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603609; x=1754208409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9Mg6ErdWdTHwLMXbslXCxCUWg4H1dPmwKDtcENgOd0=;
 b=KvvFE/mo8Miv896BMwoD05bD3NZhYa7xe55thR8YLipMeiMCb8dPRU3bLvQFzm9xJ/
 mxuQyIcGV+bYInZfAa3lLh07nPBk9gA+lxNkR7nOl8nw4eVC0o5g6JLu4SZPkOpPQT1G
 Yi1ZplrGuz9jlfrXLPmVRFEUh8peK2qvnvc8GHCozpEzE8+BfFPixP6r4NmBlWBkI41z
 bt1LPtayTMupJHELt+I5DgroR6JcXNyxvneWXu661XQEPvqWRuDqAKcAMOIG/qg99dMj
 vZQUmkhyrKMfcZo9ypmo0S7TVuq7WIdXmE03sgOKraYvwE8BCqmG49FaeFUSkPWb3946
 vetw==
X-Gm-Message-State: AOJu0Yzcd+CWpVgKDSZXMK1d2IWW/OmGO0y1R1dbpB1NTyX6YpHeV+db
 DDo9yRo+F/Nn45RfoHN+L8W9z34QADKOuzLqONPjO/IN+ptr/1gBQo5C6NFkEuUmeiso9Ir8azS
 seKMw
X-Gm-Gg: ASbGncujuiYTSwYJl/BhNpNql2NAmy5LIKE8/d5ry4P0ZGkdrZJnO5M8DO0sJn/B+CA
 3q7f6z1//JKuX0Z+vuJbZ3/7OQQsUyY21ik8PSqTNSITkNFIc3Ck7MbNbkvDlfGiT1kuJmv4jvl
 oKaIkODItbnYC0PECPFxu/3j0J2jrv8bBvQyqK7jZSDS+0lRHfjjM0U0YeW2dPvTGX5JeY98eT6
 BaJDuOMcktgaf/PyNDy2Eoe9pVcgWK1I0gXWDogu2NNWB5lgKQ7YW8dAcj4D2odh8sw+SUb/Etr
 wJSEVFwJYc7u7Ou1nzVUr6qvdjXAjRRxU38BJUCdberfFzKvzPRA+RJ9TMglpN9pTGEnnLB+HU5
 XviHjbik3KbESaFra0YfoFMFmqYXWXUndn4JzvclBqbmEN6ObZ9r7YiMdleUeeotsMdqm8bJK2h
 GtunWxXn8lEQ==
X-Google-Smtp-Source: AGHT+IGsxest7+gb1/FyQmtoZFg4V0fwMcuLCzviNMseBbxSRmqj+IzNHrhJZLN7tGq3VYb69mVJ1w==
X-Received: by 2002:a17:902:ce8e:b0:23f:6fa4:1567 with SMTP id
 d9443c01a7336-23fb2fefd31mr102730265ad.8.1753603608781; 
 Sun, 27 Jul 2025 01:06:48 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 42/82] target/arm: Support page protections for GCS mmu indexes
Date: Sat, 26 Jul 2025 22:02:14 -1000
Message-ID: <20250727080254.83840-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ee887d9a02..3c84f0f024 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1584,12 +1584,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2236,6 +2240,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0



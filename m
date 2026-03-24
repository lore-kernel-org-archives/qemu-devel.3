Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE1FF54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pn-0000mm-6q; Tue, 24 Mar 2026 11:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pb-0000bO-EZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53PY-0005Bj-IJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so1102928f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365075; x=1774969875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ErylgoX7rGE2MPVTc4vGOkn7Dc6WAKHtKwRhn5S4AVo=;
 b=bTpInedDvaJq6S2mpiFeeED3lHQ42LBoqkiNUDlKqkLam1LRy8YhpddzftR4HYyZJG
 +AeZvSkR8SbQj29xU2iFS8TKVskX1mrxCgp58w7gfHeyCaP/F22n9ZKFl/VDNMGVPGPK
 hMvZ730JDaR6iDEKubaAta8Q18OksMi5MoVgF9xtJ4bE0SRhM/mDAw4KA8oTeyOQPNbg
 aMMdTaV6OTLuYqrbCxAaxQcpdITHE/ZpRs83KwC2sTeBrlTfmoq6jApYa9hltkzXwKVE
 rqnmEGI0hfTC0aw4Bw4GCBaNRYml6lUV6jSpwN5mH6BQBWCMAwD4Mjyzv4OwVq1VAAKS
 lpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365075; x=1774969875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ErylgoX7rGE2MPVTc4vGOkn7Dc6WAKHtKwRhn5S4AVo=;
 b=VgKYsEVIo9KI/FxrfOhxesxGUtpXw+BUiwt48J+ZMrUWKrCr6PyH9E3GBumSDi03gK
 8XE+X0vwRKlP9eU4cyKJ+pWeV2CYbe1ziWM9Su8C5DQRPXvKJ5oizxNb1tLUZsftfLcx
 1a+YV1NpI2LHtJtpoPgseNzzIkgxfzhH+x3HGjntp6OTyOTrb/inuWD8ZCiyEY07VlRS
 08zxvwCBUojyY5eRjmwZ7FusbaWwiUehRU5TjUmwPMevx7kwXrtZaxAT7gqySmmN0DHx
 zStUgDyLPlPA+2Ms80Sa/HvpwVMxgQAZKh3e9C/df3g3TXzwUopKItu1Ny+2duQK8bmW
 6NLA==
X-Gm-Message-State: AOJu0YyM76VXjQTWEWMJWU7bkd/Yrw6JIOvMFfN34ThrEZEFZUgV0O8t
 Fw1dDkovrau4RLgGizy3LAohiS/xY9dGo0uJS+iFUI4j5FDCMozmopPM186Zt94Ntv/9qj+QHtQ
 oqT972tA=
X-Gm-Gg: ATEYQzzXFungrCjnVRDId4mR7cYxWLdodGmbKQi+emIwANcFvKEW8LOXRroy3FUG2Jo
 J8wn8LOth+9jUGpxcSVb1K1+bT+9gITOE3i5HS3E+UfZyrtLY2xKeIRCwjSOF3D7OTxqRYQl3zs
 EIqtTi4uHFTicii3XPqkvnSa+o08K8FeifAKOd7bVA8FyB9zHEVFTBHmadtCjG9qpAtfIK7ndVE
 h/Q0mCdwsnY8bIWZVF78JamdH4DWS8hzAyjSnA8fOgoCUMh+i+DyNkgH0cGaiUY+x6Rdi9/V5Yk
 8C76d7zh+v5Bfr30O20LQ1W3lE9yftfhvFqOMN7Hntctb9n+96KvYhBsoC80cCeer9KAYAXEfq1
 vWdiE30O9l1jnXZ2SVpiKOkwUfkvg8PF5ZiWVqQRzsu53mC8BZWRxu6ndrYQdsRVSq6maGolupz
 Z9+n0YYvyMeLBhf5Ch/8nt3X6QbysjI/ugba73vooSTzKfDafkHCKoROb4tWaZI2mw26x+/CQoR
 u9ri+rSnfQjt1UIp+GICtkNKaKiqGg=
X-Received: by 2002:a5d:5d82:0:b0:439:b3ff:9ab9 with SMTP id
 ffacd0b85a97d-43b642919b2mr26523385f8f.48.1774365074750; 
 Tue, 24 Mar 2026 08:11:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] target/arm: fix s2prot not set for two-stage PMSA
 translations
Date: Tue, 24 Mar 2026 15:11:01 +0000
Message-ID: <20260324151111.237411-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Jose Martins <josemartins90@gmail.com>

Commit a811c5dafb7 ("target/arm: Implement get_S2prot_indirect")
changed get_phys_addr_twostage() to combine stage 1 and stage 2
permissions using the new s2prot field:

  result->f.prot = s1_prot & result->s2prot;

The LPAE stage 2 path sets result->s2prot explicitly, but the PMSA
stage 2 path (get_phys_addr_pmsav8) only sets result->f.prot, leaving
s2prot at zero. This causes the combined permission to be zero,
resulting in addr_read being set to -1 in the TLB entry and triggering
an assertion in atomic_mmu_lookup() when the guest executes an atomic
instruction on a two-stage PMSA platform (e.g. Cortex-R52 with EL2).

Set s2prot from f.prot after the PMSA stage 2 lookup, consistent with
what the LPAE path does.

Cc: qemu-stable@nongnu.org
Fixes: a811c5dafb7 ("target/arm: Implement get_S2prot_indirect")
Signed-off-by: Jose Martins <josemartins90@gmail.com>
[PMM: refer to the right commit in the commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260321231916.2852653-1-josemartins90@gmail.com
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b8dc09e72..e289f88124 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3200,6 +3200,13 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
 
     ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
+    /*
+     * For two-stage PMSA translations, s2prot holds the stage 2
+     * permissions to be combined with stage 1 in get_phys_addr_twostage().
+     */
+    if (regime_is_stage2(mmu_idx)) {
+        result->s2prot = result->f.prot;
+    }
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
     }
-- 
2.43.0



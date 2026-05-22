Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7781CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQy-0006fY-E1; Thu, 21 May 2026 20:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOo-0003HW-Bl
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:06:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOm-0004qk-LT
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36936dcf19dso3219651a91.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408354; x=1780013154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ICLYVNxO73L0Y6kSbIFxEW4dOu8dhoB1R4KVrmpGMY=;
 b=OWOzbZEHxX3sLbEdJkv0CoqZrsvPkhJ54KTb5yksQfMXBjMGGPoeGv48n8b41hq8Kb
 FboO0rXrv6EUpbazeCCRdgEap5ik4H+2r03x+tCr56wf1v5F1IvFe4AL9OBm0j7PTh9R
 m6XGvGVxjcBHx2INk9Zc7dfY4VS4rCkHAmU0LM2N+hU3e/2kXTLTcCOSAIC6BDwNfnOa
 QxD3OvEt/51WsZ1nS8vqdnMc+jSCiasBWW9LMGDhdCqzBlgsygH9gQ1MT+BwuRjk14W2
 cTMVU2NOyrAJZ7Q7WKeeZpXxVAktZp9OZQ7olsTUU225DpweH8AjJq/sS3eaQxWdBC/y
 JciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408354; x=1780013154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ICLYVNxO73L0Y6kSbIFxEW4dOu8dhoB1R4KVrmpGMY=;
 b=A0xIaFeINf1ysiyR776uSLvk/ZaY85K5rhsXcRmTrF6oSS6rDKP/DdAdaFhKAw7ezU
 bE6aYSCismuon5/vYHFEJB34SgVLbSZ2QOMmsL2ap7tMBApy2Kes/J+Yj2OA79rIsXPx
 Syg98Q1eRbVQaHTtP7d15xYZ6HZCkCw9Nk/jScXUvSxHpefupU0JM8ap8bxH03tx9iRv
 8ZbsccmNtTl+YNQT0dThM5EN5K+uHXqq6grgnqsbgVeOQu/mRw2nnI22Shywhyrezvbu
 O1WQl9c2e62wcVXXRiGi8xRh93ZfTdffhM+5l1v9LQBMGJRkl9/etuOaae+T4bvnk/oY
 Sj8Q==
X-Gm-Message-State: AOJu0YwYqwG3Z5kJ59pOe6pPE4W7Pgpo5viFn/nF6VHTLIzDN1EtKZ0q
 IfZRBBEZYJbRPabMlDQbrLEhGi0P6omWKGvo1IQJvZNytwYXOptQavO+JVl17uE8
X-Gm-Gg: Acq92OHjkxgBf4DnPrab4F6g1D/3RFka/sJICrdTuEoj58pQbVLi48tQokfNUxvvast
 XqnvcFTBY+pvhTzuH9dcJeq97KOIrnKMyX1m6JPol4lUgn9IUT9YVilZQJI5t4BeUx3J28Fc7OK
 oPoOpe1x7qRI0wQ0wnxtVbRuuEjHVElCtbDQF9cb3/5AEDuPcyFlgHCIlbCaOl5ELUHNMye0bBa
 fZf6kyf+HVsR3134phsh7RdxzCRjto0pTmu19ff4y/kJIaqKXJpM+NE91jZuVJWmoSpF1N9jYqq
 oaVNQJbrZ5+WjBy6/JgTn0MykDljmgakQpJ3Oxk7N3poELzkY9FRkmwTNIjgvV2yUybssZKg52q
 R/FGfR6mtq+EcKNewrbk8WUZQC/3GFVIF/Q+wcFBudCVe7UErSBNLMdDzQBlJ0q3iCWKkbwa0wF
 HvDA1A9n9blAWYJc30eE60/s7GUbeF7eoo5ULITyw65LGC8HNsBq5E
X-Received: by 2002:a17:902:e548:b0:2bd:4d97:b5bb with SMTP id
 d9443c01a7336-2beb0385f86mr11684355ad.12.1779408354110; 
 Thu, 21 May 2026 17:05:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Portia Stephens <portias@oss.tenstorrent.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/48] target/riscv: Make hpmcounterh return the upper 32-bits
Date: Fri, 22 May 2026 10:03:19 +1000
Message-ID: <20260522000324.23255-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Portia Stephens <portias@oss.tenstorrent.com>

The counter value was not being bitshifted for a hpmcounterh read
resulting in hpmcounterh returning the bottom 32-bits.

Fixes:  cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3498
Cc: qemu-stable@nongnu.org
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260519043352.3685866-1-stephensportia@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e4163b56b..5514e0f455 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1409,8 +1409,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
      */
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        *val = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                    ctr_prev + ctr_val;
+        uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
+                                                             ctr_prev + ctr_val;
+        *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
     }
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1798CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Mv-0004E3-CX; Thu, 25 Jul 2024 19:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mi-00031k-Rx; Thu, 25 Jul 2024 19:59:20 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mh-0001iv-3s; Thu, 25 Jul 2024 19:59:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7669d62b5bfso279653a12.1; 
 Thu, 25 Jul 2024 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951957; x=1722556757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb+fFEEKtH1DSgcPzE8tW5FAXaKFsAWNZ1dFyG4aN78=;
 b=E6xY7kg7CP5y6K88ssM8jVj3d6TLhDB68+fehMkXPoqrJTfXVq97hjS1dsmm9As04x
 DQd8jZyS4kCktUAP/kzkndZDTY/QbVUAib1LhlbW4zJ06DVg6rJByy0tyhuNpzuxxaKQ
 kHphqzeaSTbyhfbMSKYf105jckGa7y4HysTr7P+b3+nnj7Dj4Pzcp7k9tbDz/FmB5BYU
 OWD5/OoevMZMcOPx7RfT45TPbO326k5EyZuwfXUMU2/OtIzPTw+l/0nQuCRCk0QHgzU4
 rAowVs31qXSqkx144+/ovXpQ5XrqmSxauk6kW7oSy7ef7vS8Q8tecx22fiIiQftQTUhx
 rRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951957; x=1722556757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb+fFEEKtH1DSgcPzE8tW5FAXaKFsAWNZ1dFyG4aN78=;
 b=jnNnGnkqztrcubJIz1hNnPvrtKBtxdT+WYriJz9EdPH2ILnsy49G3oUmcSA0mWzX0U
 hOOBwWXTMhTX84n/fsBor8SaohLaDhboqtDgA8VZx2aCTvlo9vlylcvmKWsWZpva46dP
 m6Lji9qHu1ofGgi3DruIBMZWWXPSGq3+Q3rajW9Hpp/YnGkRMzTHlEfl3HP6z70yXcRp
 +yy0GBp39oTQbpeqOcuCF6ewZmBoDLgWo18pMqJkrrEWlZkDvFmpClAU43IBFfIGU0jK
 y3KYKi6DZ3yhHJ70CPo2t/rHv6n15pQ7AXwCVJRwG+ecZhvjHJbRZ02P1uFC4djanmtY
 W0Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUipMtFNXsMPT439dFeup/d+TqirUOnLJVWUC+4aWPH3whsso9OGHZ0p3MEVjGq1HIEPfTLpCASZTT8fjJwHhH+n81j
X-Gm-Message-State: AOJu0YwBmWdbYdPu3ihdzJIaQKFxRN0LFbw1tl6WQsUL6ndJ4SR7amNd
 OHcBezlqUKbpAEdDMYF4AbrQx6HCt8blMlT39FQ0z+KYfi7hUK+QaQtRLQ==
X-Google-Smtp-Source: AGHT+IEFuaZ5GkOsykvd5ZP0t5lmoNgMTO1mjhi/cMq8JTcdIRpDmcwyACGn5cEbiqQIJ1dJuEHLIQ==
X-Received: by 2002:a05:6a21:99a4:b0:1c0:f23c:28a7 with SMTP id
 adf61e73a8af0-1c472cd22f7mr5975949637.44.1721951957295; 
 Thu, 25 Jul 2024 16:59:17 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 84/96] target/ppc/mmu_common.c: Init variable in function that
 relies on it
Date: Fri, 26 Jul 2024 09:53:57 +1000
Message-ID: <20240725235410.451624-85-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The ppc6xx_tlb_check() relies on the caller to initialise raddr field
in ctx. Move this init from the only caller into the function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 1ed2f45ac7..fe321ab49c 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -102,6 +102,8 @@ static int ppc6xx_tlb_check(CPUPPCState *env,
     int nr, best, way, ret;
     bool is_code = (access_type == MMU_INST_FETCH);
 
+    /* Initialize real address with an invalid value */
+    ctx->raddr = (hwaddr)-1ULL;
     best = -1;
     ret = -1; /* No TLB found */
     for (way = 0; way < env->nb_ways; way++) {
@@ -340,8 +342,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
                       ppc_hash32_hpt_base(cpu), ppc_hash32_hpt_mask(cpu), hash);
         *hashp = hash;
 
-        /* Initialize real address with an invalid value */
-        ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
         return ppc6xx_tlb_check(env, ctx, eaddr, access_type, ptem, nx);
     }
-- 
2.45.2



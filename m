Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A44C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHb5-0000J9-6E; Thu, 23 May 2024 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaC-0005XS-2s; Thu, 23 May 2024 19:10:51 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHaA-0006FB-7r; Thu, 23 May 2024 19:10:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2bd9284dd31so2326809a91.3; 
 Thu, 23 May 2024 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505843; x=1717110643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGzek4BgVUiOZX20Ziz09caCuLwvQXep/6WVLrtOBek=;
 b=CZkiJomJsdF0ZZta8eCGWFH1aXY9xFGV6UOL9luXIqK9Jw40XUytwyRysXHzF+xNE7
 G9qyLBoaoVgnkHy39s3WvJIkxKg9QG5M7fpSni1f27Vy3O5u7dNXCW1hy05NvO7JRK+8
 DLbG9FM+aEnrgKfyEiCtRjVuDGssfDaUe6ZJAJG4JfHHIQez7tOZIHTiXQqVqiOX8XCJ
 3EWOT9fL3pIs8laN3NJ2ZhqBVzlYfA7mozKaJDmma1NAD2i55JapaGlga9htD+WTja9l
 6TSFpKhinfGKrh4XXeCQrkuPMlR5CFBK/BSsyDSINlNpwPCpXd31HQJOSI4kJ4xI2atM
 l91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505843; x=1717110643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGzek4BgVUiOZX20Ziz09caCuLwvQXep/6WVLrtOBek=;
 b=pqBJqr7GBPmN/EFVwUuOYS1dpUb4eoOrl1Kj56OxwnYMmEkBBtoZbKB1UB5YCNSNGw
 sZ5HVXxswUfoOSa0HoXkiIbtBvQzLS2pi9WoAwBgsSKly8fpTHRd1Wm5ltuR56YmiK7p
 rOxMaZK+M3SgJQQK9LdeGDc69I1m1RyZn+c0UJN7Kq2oQU4wXouLJk8azeV27WgdoYgw
 b3WrWSF5+r1SSKrUm3P9DjoUEzQbxsROdPs9mC3c3MKoKdZ1bl1pO6XcS+3Yc6CvXBLN
 lLuXnmScxgNUg44qrcJyf+OdqcYmbSy/Oz6cxyxcxtFXqxfsVUMEQKEju7orIsuHZwrR
 YfYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjPjuM063jIZ1HAHuRUYxYtPSnJJDrTeuRlVGfch7vq22G4o4pAw/Wlm6idXqagnPpm0BiG+oPBVgT3liyShsQMIF2
X-Gm-Message-State: AOJu0YwfL8t0VwcgNSz6UPdREi1QPgu91/DG4hftlZlfPNdUzErwSxu6
 byJyec8RabTGmJLfiDdcBLISho1TkSDtnriPn/EYRDGq9HopNQ5l8ErAQw==
X-Google-Smtp-Source: AGHT+IHrziDOOcmeGIKLary+h1JFMJtkTcg8owOng+fhX7UbPoBhn9R3k91x4qxUBkav/lL+V87iWQ==
X-Received: by 2002:a17:90a:17cf:b0:2bd:9dab:a7b0 with SMTP id
 98e67ed59e1d1-2bf5ee1981bmr611035a91.13.1716505842998; 
 Thu, 23 May 2024 16:10:42 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 54/72] target/ppc/mmu_common.c: Replace hard coded constants in
 ppc_jumbo_xlate()
Date: Fri, 24 May 2024 09:07:27 +1000
Message-ID: <20240523230747.45703-55-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

The "2" in booke206_update_mas_tlb_miss() call corresponds to
MMU_INST_FETCH which is the value of access_type in this branch;
mmubooke206_esr() only checks for MMU_DATA_STORE and it's called from
code access so using MMU_DATA_LOAD here seems wrong so replace it with
access_type here as well that yields the same result. This also makes
these calls the same as the data access branch further down.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f40481b4b1..6570b280ca 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1287,13 +1287,13 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
             case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
                 /* fall through */
             case POWERPC_MMU_BOOKE:
                 cs->exception_index = POWERPC_EXCP_ITLB;
                 env->error_code = 0;
                 env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
                 break;
             case POWERPC_MMU_REAL:
                 cpu_abort(cs, "PowerPC in real mode should never raise "
-- 
2.43.0



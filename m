Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4677C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nr-0001bM-Aj; Thu, 25 Jul 2024 20:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8NB-0005yr-24; Thu, 25 Jul 2024 19:59:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N9-000204-DG; Thu, 25 Jul 2024 19:59:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso251356b3a.0; 
 Thu, 25 Jul 2024 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951985; x=1722556785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSiLxWDKshk0YREcVW5HCex8in/AdqlYXKlWD5yMiVw=;
 b=TdXC7mGEvmerbGAc0sERQEXZiYYpAbeGPJ7WdRyt6Sl3SfCnSdKSuyZouxttHWkXR3
 3m4PPxJFI/cTQe/RqnoGqPmzqH8yzuevTpv+qBYQOqh5vY46VNc/SFTn8yzNwzfvYOaZ
 1YLHeCCWkerIflD19kELH/RVkvGEm04Kn4k/cGsmO0qLW1KKhEMJHxQK1z0my8mujKOT
 2b3tOZFpFzuN+EA/B8KdhCwplB45p3zYZip3HYoKeLC55OCwOUneUSGjSStNdVyBvHBg
 Z5DkqA3fNDgiiSIdMyfgaYG3zXDnPoBC3PBDnIdXf/p6rdhQYsBprYKeqBKOFWWqW7YK
 cH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951985; x=1722556785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSiLxWDKshk0YREcVW5HCex8in/AdqlYXKlWD5yMiVw=;
 b=ILBulpb/zwwZIcd0Lb/o14pfU3fqz6/+14umFblqHUUBzoRjEtywCoKxl8QxbhwVE2
 NQ+7OxvONd0mAgnG34fa8XuLOJugacSrZc2QtsdM+4piXMQnzf3kNyM5klerfgZG7iZQ
 WDuRQggfzatemnDhdGDw8XL0ccrgNc/h7jnFAtWUjhg6PRGmLtyypXvklE0S1L7jdV8p
 6CGimpu17syXCm41fFcLKurJRXuHnoxP7kEKfYZaVH31h67TsnbTfIZvS5VolB7xmM4L
 m3EHdekscbi8wPoeHdNKJRKOLAotdq5UhPY6zXUOdEFHrCRTJlZQ9urYVy4uEJUc37KK
 NW2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH7ybTQ8sLxgwHwVGEFTk2pRfLz3p3kAXTFxb8Ve00awkS4eKLPtXBYvREayfgnMjZuzZUzAQihGZ0G0NL3B6l3OUW
X-Gm-Message-State: AOJu0YwnY/rMNOsqbGLABGvhd7FaR94xDY/mADz6bqAcftDTP5fRVCXD
 QYdhyDKDKLb5zv0sdDZhYRBvsXmQNwsSb7zEdRBl4qyQG+0lf52eWbl3zw==
X-Google-Smtp-Source: AGHT+IH0bK3e9Dxxso1o4rcGwcnYtthFhFWYg9bSY9b0EPGu758Fs0wiOehlAidcsHNq3EmYoy+9mA==
X-Received: by 2002:a17:90a:fa01:b0:2cb:5883:8fb0 with SMTP id
 98e67ed59e1d1-2cdb9442ae1mr11106638a91.14.1721951985250; 
 Thu, 25 Jul 2024 16:59:45 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 93/96] target/ppc/mmu-hash32.c: Move get_pteg_offset32() to the
 header
Date: Fri, 26 Jul 2024 09:54:06 +1000
Message-ID: <20240725235410.451624-94-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

This function is a simple shared function, move it to other similar
static inline functions in the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 7 -------
 target/ppc/mmu-hash32.h | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index c4de1647e2..44b16142ab 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -201,13 +201,6 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     return false;
 }
 
-hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
-{
-    target_ulong mask = ppc_hash32_hpt_mask(cpu);
-
-    return (hash * HASH_PTEG_SIZE_32) & mask;
-}
-
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index bd75f7d647..2838de031c 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -3,7 +3,6 @@
 
 #ifndef CONFIG_USER_ONLY
 
-hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash);
 bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp, int mmu_idx,
                       bool guest_visible);
@@ -102,6 +101,11 @@ static inline void ppc_hash32_store_hpte1(PowerPCCPU *cpu,
     stl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2, pte1);
 }
 
+static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
+{
+    return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
+}
+
 static inline bool ppc_hash32_key(bool pr, target_ulong sr)
 {
     return pr ? (sr & SR32_KP) : (sr & SR32_KS);
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHaU-0006LU-Ad; Thu, 23 May 2024 19:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZb-0002Tq-5t; Thu, 23 May 2024 19:10:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZY-00064T-1u; Thu, 23 May 2024 19:10:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f33d84eaefso10375425ad.3; 
 Thu, 23 May 2024 16:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505805; x=1717110605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xV/OOVxWsS3ja1Em0QI6JyY32EBBBDkiguccIgQftMc=;
 b=iNsjyvD5Ns4Jdh7ukWTmT+P29H+Axy80/4oh3on5o8aLd2kKbMvlIVhsF4uKs6gsiZ
 m7MB4sDq3dOWIu2sNo21wk//N6tcW24R8XygbYsYywEAuEgF9dh6aIjuzgFMYNYpEf2e
 5mosva56Rql3vlV4ecyXBpOPLXzkaBG12NiPhC+o32iXhr6wTgGNaGpiLW6W4CUEyP0j
 PpWKPesa2FGPMU8sjFxdtq7PxYX0PGPogZx55AwrNKMeeTjctqQc3fc8xfDWpav2uspr
 NR46fC9GRtftBuSJrTM5CVeT4hrbMLibLzuAnQ1psC3dhfFtFrr5+IbCdpIcyzXp63gQ
 PEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505805; x=1717110605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xV/OOVxWsS3ja1Em0QI6JyY32EBBBDkiguccIgQftMc=;
 b=ae75Yyr0zyNe72EXXROdB3/ZuL+xM7wBRtJPVYD0JSAoQbUDzkvB7JepzbSEBVyxDe
 u7arDEUb8vtw7bGBIGOAFZqEfw5NHkiMTvykVNyVYfh9OX90T5o1XCs+bIhJjwGM2Rwf
 KBIopKPKXA6+bxhiMHD1ZdFTZIMn5yVZEUucbdsKl8+JXz2P/xPhymERAz/ikh1VWlXb
 m+9dylFm2lew3PxBoke75uIIGVXI8nZKgvg7N8WrsqJ7q1v0PmJpI8PW3FidQ45N0SW0
 hD9+1ffTYD7amMMKW2ah9AFMucqkhJSR77gdcG3VlFKlPyqTbMaQNndfZZBapR6WfeCf
 bl9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiEKRg3BjYZK2Xyep5hzWKDjLUf6WwH5ITZLJ0GhHUn+N3Xn77JCYAU3/z0hJw6/ir3kWOxfvVjyJ+OFVNRwQxqwTz
X-Gm-Message-State: AOJu0YyabkTjybhqc69Zt/hCYUoGOZfRiejOw2MgaPXcjxuP3csnC9ks
 +NGbBGngQw5rIOnffM1kDZEGjdeBiXN88YMeVi+LobmrOMb2HeJ4ZbFjbw==
X-Google-Smtp-Source: AGHT+IER3z/Cbykh2IjYXjm8nnj6r7elADTJPWhhCgHjGrh92SeMxzxR0OT/YgCgoHzjc5LUhlEv4Q==
X-Received: by 2002:a17:902:d50e:b0:1e2:9066:4a8b with SMTP id
 d9443c01a7336-1f448701704mr11430175ad.26.1716505804693; 
 Thu, 23 May 2024 16:10:04 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 41/72] target/ppc/mmu_common.c: Move calculation of a value
 closer to its usage
Date: Fri, 24 May 2024 09:07:14 +1000
Message-ID: <20240523230747.45703-42-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

In mmubooke_check_tlb() and mmubooke206_check_tlb() prot2 is
calculated first but only used after an unrelated check that can
return before tha value is used. Move the calculation after the check,
closer to where it is used, to keep them together and avoid computing
it when not needed.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 4fde7fd3bf..f79e390306 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -635,12 +635,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
 
-    if (FIELD_EX64(env->msr, MSR, PR)) {
-        prot2 = tlb->prot & 0xF;
-    } else {
-        prot2 = (tlb->prot >> 4) & 0xF;
-    }
-
     /* Check the address space */
     if ((access_type == MMU_INST_FETCH ?
         FIELD_EX64(env->msr, MSR, IR) :
@@ -649,6 +643,11 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcemb_tlb_t *tlb,
         return -1;
     }
 
+    if (FIELD_EX64(env->msr, MSR, PR)) {
+        prot2 = tlb->prot & 0xF;
+    } else {
+        prot2 = (tlb->prot >> 4) & 0xF;
+    }
     *prot = prot2;
     if (prot2 & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
@@ -830,6 +829,18 @@ static int mmubooke206_check_tlb(CPUPPCState *env, ppcmas_tlb_t *tlb,
 
 found_tlb:
 
+    /* Check the address space and permissions */
+    if (access_type == MMU_INST_FETCH) {
+        /* There is no way to fetch code using epid load */
+        assert(!use_epid);
+        as = FIELD_EX64(env->msr, MSR, IR);
+    }
+
+    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
+        return -1;
+    }
+
     if (pr) {
         if (tlb->mas7_3 & MAS3_UR) {
             prot2 |= PAGE_READ;
@@ -851,19 +862,6 @@ found_tlb:
             prot2 |= PAGE_EXEC;
         }
     }
-
-    /* Check the address space and permissions */
-    if (access_type == MMU_INST_FETCH) {
-        /* There is no way to fetch code using epid load */
-        assert(!use_epid);
-        as = FIELD_EX64(env->msr, MSR, IR);
-    }
-
-    if (as != ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
-        return -1;
-    }
-
     *prot = prot2;
     if (prot2 & prot_for_access_type(access_type)) {
         qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
-- 
2.43.0



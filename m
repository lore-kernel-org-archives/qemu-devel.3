Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32C6C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHbb-0002S3-Es; Thu, 23 May 2024 19:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHas-0007S2-NI; Thu, 23 May 2024 19:11:31 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHah-0006K6-D8; Thu, 23 May 2024 19:11:30 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b283d2b1b4so3930099eaf.0; 
 Thu, 23 May 2024 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505877; x=1717110677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FOJAB5EdrbumZGGef/tt1skcNUadBwwAxjMmp2B2Vw=;
 b=PnDj2SOFcHN628GeGI1c5tAqY0mC3RTkaZpt6UOCW6sbFmaif1FNSYQStT6OCWa5uB
 ZysydX7cJRDNKtgZCaJHiTSyD+fTboDop4/dxoj6qUdqPiQjLTyvacu/SfYZwx0pd2Ny
 D0bA/FpSsOAifY6UCMmWcQHu5mOXo1g2pRDSLPbF+Q1JaEVreK7XBFJnb/NaDuTWWlrM
 jwN9wSod8vsLy91wRhs7Yt2ho5nGSPCtKbK3PjnSkop7ImIH2g/YrLBu3HoyawoFvO2q
 HDJ3upkT+uEyQ8ucVz6iVTsU65xWeEq93OeY/nx4r1ScCLNW675AxLVEuzsUSO7clkDK
 vjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505877; x=1717110677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FOJAB5EdrbumZGGef/tt1skcNUadBwwAxjMmp2B2Vw=;
 b=HBKFseZtKahUuAX35j+Q8lv7wbMapStMBRxmgFhNk7tHTfus2s2tGNVH3dg42rxzIb
 S5ej+1esxR60DVhY485E8r4KQzVuvmoAexaKbaLqS8E3Vbk8qBoAR+p9MKmoIOlyqK9U
 9IMBNBg/8DazgA5YGtw8L46zcxzx+j6JdhENcOc4/JXaEJ5DP/inlspUrLG/ZAZK4PQ6
 CYAHPuXVeJDxGhX2DUsK9oSpWXZsTLlICe7++cSJzIRlV3J9gsVXbHL93ShgwCGv7fKB
 sApBhqXD17wtSjmMTUWzlHfJoAs0UDPadlCehyjX6zmOKMjxysRaBba+VQQMSkhkoSQU
 MHRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqsMa0p7VyKGODv+j6CQkP82vJsPeOWhH9Pq6HWeeqD0voAJcUMAcN3VR9/tgRTPm3HD1eradT68aomsNfL5ItudGC
X-Gm-Message-State: AOJu0YwkGPLBfLJ8UcjMyHhbD6eWm+wNvb2SXzm3rFNdH5SQX4Ax03iU
 LU/JmuAgnKsby+xf5tW6BYEvrsC02HFCz3mFLfRSevZHuqverqxjp+YJ6g==
X-Google-Smtp-Source: AGHT+IGiSEmFW3oPxmeAfu+VW+j318AixAApjhdcLdsx075s06p3fKc33//X4EGG5eQApDkdLkr+sg==
X-Received: by 2002:a05:6359:4c1d:b0:191:96d4:b14d with SMTP id
 e5c5f4694b2df-197e566557emr90524755d.30.1716505876520; 
 Thu, 23 May 2024 16:11:16 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:11:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 65/72] target/ppc/mmu_common.c: Move mmu_ctx_t type to
 mmu_common.c
Date: Fri, 24 May 2024 09:07:38 +1000
Message-ID: <20240523230747.45703-66-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2b.google.com
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

Remove mmu_ctx_t definition from internal.h as this type is only used
within mmu_common.c.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/internal.h   | 12 ------------
 target/ppc/mmu_common.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 4a4f9b9ec8..4a90dd2584 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -257,8 +257,6 @@ static inline int prot_for_access_type(MMUAccessType access_type)
 
 /* PowerPC MMU emulation */
 
-typedef struct mmu_ctx_t mmu_ctx_t;
-
 bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                       hwaddr *raddrp, int *psizep, int *protp,
                       int mmu_idx, bool guest_visible);
@@ -266,16 +264,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
 /* Software driven TLB helpers */
 int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
                                     int way, int is_code);
-/* Context used internally during MMU translations */
-struct mmu_ctx_t {
-    hwaddr raddr;      /* Real address              */
-    hwaddr eaddr;      /* Effective address         */
-    int prot;                      /* Protection bits           */
-    hwaddr hash[2];    /* Pagetable hash values     */
-    target_ulong ptem;             /* Virtual segment ID | API  */
-    int key;                       /* Access key                */
-    int nx;                        /* Non-execute area          */
-};
 
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 961062bca1..34200d9cb1 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -36,6 +36,17 @@
 
 /* #define DUMP_PAGE_TABLES */
 
+/* Context used internally during MMU translations */
+typedef struct {
+    hwaddr raddr;      /* Real address             */
+    hwaddr eaddr;      /* Effective address        */
+    int prot;          /* Protection bits          */
+    hwaddr hash[2];    /* Pagetable hash values    */
+    target_ulong ptem; /* Virtual segment ID | API */
+    int key;           /* Access key               */
+    int nx;            /* Non-execute area         */
+} mmu_ctx_t;
+
 void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-- 
2.43.0



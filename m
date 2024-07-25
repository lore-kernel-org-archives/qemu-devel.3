Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4610C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Nn-0000zW-EN; Thu, 25 Jul 2024 20:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N2-0005KK-2J; Thu, 25 Jul 2024 19:59:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8N0-0001nE-Af; Thu, 25 Jul 2024 19:59:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso850315ad.2; 
 Thu, 25 Jul 2024 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951976; x=1722556776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6k2qzcWLWNIdpDa+Nl/FfE5YNWcPZbMDYvXLJ2XW+Ew=;
 b=hDlrZ+tGuDuyALFOtoGiHYbbYaACJ9NUnvkcjrel+eBgBrBLpp4vVwJCS4Oz6BXeCu
 kvktk7kzMWwsuaQ2osscsh4GSelvSNH79y70xvPEUc7vGrQF5NYlNrpprO4wUKh5Omdj
 TOvW1/lZMtrPz9U1c7WYdBGnpUMXLMFvCPK6k7PdZfZjaiXaUzjQDtbOT/pt4Jlm6SDj
 btuH906ZxkisAYde/cw5JwwLZEq95wExPexZ+T6kgSZ++P1qIsirD8xtFkvbO8znpVZi
 uos3yD6Q+8gqSaeJC5pzGNMxlZg9VY8ySgvZicieDT8l29XiStHCLl0CIShTQVtIZG01
 Oc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951976; x=1722556776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6k2qzcWLWNIdpDa+Nl/FfE5YNWcPZbMDYvXLJ2XW+Ew=;
 b=DZrQxo93kCXnWYYNngBxB9NaPP5l76vhjklu958bqC6PE8xNdW/xKRkb4hiPjs+XEa
 vHoKMdEpr+la1dOaeoRk3ec5XakrN4e0J/fZ2emjp1aN7V4SXDLK37mQ/803T3mxc/LP
 jtQ9bQ9lTBhvxPQ92qRr4gEL3noJUhHos15Ee1wTa9Qyheyi2ZAyzvQkutYFbC4esOdR
 fDX12FxzuZb/JPuX0OD5OuFYfj+AfqSJFLvztOxW6GaOoVPV2D5aGWXnzwb1yPoBS+41
 FR6EM01u6G9Ff5mDlIT0Rr77eM3ZI1JpdXiKYZOQ1WxTywocu1li9FdhC6MoH15sJndE
 vu6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVvlJjeQOapl4eACVuvno3tzJPE17yWMADoX6ugFWYh9MXnqDjss2pR+k9HAljfC7qpjBI9A1UpnQ98v1woiAPGqs4
X-Gm-Message-State: AOJu0Yyesuj7KYYZTFdWymBUqxf+Ww1J+7mRJ4pG4zyiqh47cNC/aYJt
 pywznspy6qY5mX4uoVvCRzN03aVY+BBWWTU31d1wmr3LYtodWKqmSrgadQ==
X-Google-Smtp-Source: AGHT+IE0zosEt05kk5W3yR+O4FVUDk5d7Te2GxrXj7W1psE3AeqtpwUY87oV/ze/yDW1U+aJcrG6wQ==
X-Received: by 2002:a17:90a:bcf:b0:2c9:9b16:e004 with SMTP id
 98e67ed59e1d1-2cf2ec35e56mr3319041a91.43.1721951975967; 
 Thu, 25 Jul 2024 16:59:35 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 90/96] target/ppc/mmu_common.c: Stop using ctx in
 get_bat_6xx_tlb()
Date: Fri, 26 Jul 2024 09:54:03 +1000
Message-ID: <20240725235410.451624-91-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Pass raddr and prot in function parameters instead

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 624ed51a92..4770b43630 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -193,7 +193,7 @@ static int ppc6xx_tlb_check(CPUPPCState *env, hwaddr *raddr, int *prot,
     return ret;
 }
 
-static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
+static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *raddr, int *prot,
                            target_ulong eaddr, MMUAccessType access_type,
                            bool pr)
 {
@@ -224,16 +224,16 @@ static int get_bat_6xx_tlb(CPUPPCState *env, mmu_ctx_t *ctx,
             if ((eaddr & BATU32_BEPIU) == BEPIu &&
                 ((eaddr & BATU32_BEPIL) & ~bl) == BEPIl) {
                 /* Get physical address */
-                ctx->raddr = (*BATl & BATU32_BEPIU) |
+                *raddr = (*BATl & BATU32_BEPIU) |
                     ((eaddr & BATU32_BEPIL & bl) | (*BATl & BATU32_BEPIL)) |
                     (eaddr & 0x0001F000);
                 /* Compute access rights */
-                ctx->prot = ppc_hash32_bat_prot(*BATu, *BATl);
-                if (check_prot_access_type(ctx->prot, access_type)) {
+                *prot = ppc_hash32_bat_prot(*BATu, *BATl);
+                if (check_prot_access_type(*prot, access_type)) {
                     qemu_log_mask(CPU_LOG_MMU, "BAT %d match: r " HWADDR_FMT_plx
-                                  " prot=%c%c\n", i, ctx->raddr,
-                                  ctx->prot & PAGE_READ ? 'R' : '-',
-                                  ctx->prot & PAGE_WRITE ? 'W' : '-');
+                                  " prot=%c%c\n", i, *raddr,
+                                  *prot & PAGE_READ ? 'R' : '-',
+                                  *prot & PAGE_WRITE ? 'W' : '-');
                     ret = 0;
                 } else {
                     ret = -2;
@@ -277,7 +277,8 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs &&
-        get_bat_6xx_tlb(env, ctx, eaddr, access_type, pr) == 0) {
+        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
+                        access_type, pr) == 0) {
         return 0;
     }
 
-- 
2.45.2



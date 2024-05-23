Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C12BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHae-0006yy-5Y; Thu, 23 May 2024 19:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHa2-0004oX-Fa; Thu, 23 May 2024 19:10:38 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHa0-0006EW-M9; Thu, 23 May 2024 19:10:38 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-36db3304053so35722235ab.2; 
 Thu, 23 May 2024 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505834; x=1717110634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSy1rTzhnBd69DOyzNO/phkY+jMKCnUg19aFikdmjao=;
 b=cUkxjSCUIXATiSi2Rf3xR42IgLDeVXdP9IKVVirTLeMucwHHVkV7DsNRC0bPE1yp0D
 bpjb90azFCNXkgLS24GdAj88mozuEsBq+wNzjNb3opKQEGgEUkVwwxrMaeop4SyfewJi
 0Pr7+x9S+mnodmw7ukyjmpfCdMHepjV1ZXK9GKfJVvIhNUMUV8hs1J2q81qiKW7+VZqw
 I8MOu7ZuaOXvEaIHV28xoRSs8xGxMPn8gOmtWEEMBUDmXpxAp/wu4tQJNTOt4AoM7kHA
 KdNQGWoTYzJLfH2ckOHoK0BFON6HulUxQhoHw4TNymiTf51cxKzM123njRoUQARVA9wR
 ZY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505834; x=1717110634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSy1rTzhnBd69DOyzNO/phkY+jMKCnUg19aFikdmjao=;
 b=Xairt6ILb60e8/AN/3Ouv3MxL5PE7o2r5RymFoiD79cG7M52BMcAWHP+UBInutWHYE
 74A5nYLqpsU98yc51CUZ6zu1LJ7qYRivHPpwUAHLfodATqtIN8lp4kUf7b2EWdZmlTS4
 UFozMAZtc0aAws2Nm/PtUyrAz2Klxp+kJIcd8jJzcm1aZursr0dhl74xjhf4PbdweUHl
 +9mDED6F7cgt9blWqtzHaj1Ze0Sx//Oj3+feSC8gSVbrAbsRA+hiNpKuxoYuMssID34x
 8Un6ildlpwLEtvZMLV4rOAMHUh8Sw4nfGKqfBRB9CyCFJxF/VWuleNWLh98zCrZ8Azv2
 vw1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLx0jEUoskYLkRgx2kB8b00uJd8kMaKyRNAhGCFEk7STp1FvEbiqbc/r5yDjSbdTIx492nMkg+mGDnm8KCm7CIY95v
X-Gm-Message-State: AOJu0YxN1HInhK481BqyDpTZHvZbY7Pp2z6YAIExTiOp13jCEXsRVeC+
 7MNTqZMwX/ed1hxaHCWVAj7pV5hrMsoNZg8wmO0d66Q7vb2MfrfU0GCrJA==
X-Google-Smtp-Source: AGHT+IEuMvTa9pN/5dsDFQEm32F/msXuT8jtHdfGK4BXWvm+TmQuRbp8aDt7F/4GFjcPHYGCGvc04A==
X-Received: by 2002:a05:6e02:1fec:b0:36a:1725:e123 with SMTP id
 e9e14a558f8ab-3737b301dcdmr8237845ab.14.1716505833740; 
 Thu, 23 May 2024 16:10:33 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 51/72] target/ppc/mmu_common.c: Inline and remove
 check_physical()
Date: Fri, 24 May 2024 09:07:24 +1000
Message-ID: <20240523230747.45703-52-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x130.google.com
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

This function just does two assignments and and unnecessary check that
is always true so inline it in the only caller left and remove it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index b13150ce23..2f412dd7c5 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1145,28 +1145,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-static int check_physical(CPUPPCState *env, mmu_ctx_t *ctx, target_ulong eaddr,
-                          MMUAccessType access_type)
-{
-    ctx->raddr = eaddr;
-    ctx->prot = PAGE_READ | PAGE_EXEC;
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-    case POWERPC_MMU_SOFT_4xx:
-    case POWERPC_MMU_REAL:
-    case POWERPC_MMU_BOOKE:
-        ctx->prot |= PAGE_WRITE;
-        break;
-
-    default:
-        /* Caller's checks mean we should never get here for other models */
-        g_assert_not_reached();
-    }
-
-    return 0;
-}
-
 int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      target_ulong eaddr,
                                      MMUAccessType access_type, int type,
@@ -1186,7 +1164,9 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
                       env->mmu_model == POWERPC_MMU_SOFT_4xx ||
                       env->mmu_model == POWERPC_MMU_REAL)) {
-        return check_physical(env, ctx, eaddr, access_type);
+        ctx->raddr = eaddr;
+        ctx->prot = PAGE_RWX;
+        return 0;
     }
 
     switch (env->mmu_model) {
-- 
2.43.0



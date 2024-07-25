Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC78BC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MW-0002H6-0i; Thu, 25 Jul 2024 19:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MT-00027q-O2; Thu, 25 Jul 2024 19:59:05 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MS-0001gw-0v; Thu, 25 Jul 2024 19:59:05 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2cd1661174cso333630a91.0; 
 Thu, 25 Jul 2024 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951942; x=1722556742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKRPGBmRnbNiPvs2erSAGInevUpGEmgofL60Ya+Yjt4=;
 b=iE4OKuzKRGTv0dHOBoV9TaVtuBVypSAAn4h6oEYOODhWs9rx36bUi6DB2DVaw/2ysj
 k2dA+VhHxRB9VVLh6Es5mJG9/hL6fLgIBc+JgRX7MSR80lkl6e3HJTjugzh8j/9jsztz
 VsclTj/+mTt3XLbg6cJI6K5jmsWCKJxbo8rsLjN2nrwT6EW5ZmBjkCLHEqu7u2DsJYWa
 R2ygt59J2bW6ETUx8FuZypxjLGGa3sFZ6EgsGtyHa3my0ayCk6IIGuwUoP4f4RfU6oaU
 bPmHxaEy2nrSM8za8/Gv8+4C1N3/ME04gO+a0Zz+j+SqI9I/gShlymDzYr2YT0YqPG0i
 T4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951942; x=1722556742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKRPGBmRnbNiPvs2erSAGInevUpGEmgofL60Ya+Yjt4=;
 b=S9peN+Iu7vPjs2Qe5zdTbyB8PgmDMMlAXOU69nUJ4ZZf2f3uOrwicrWToUVXBPlGR/
 /yt42pVk0MtZJnz06A8nP/FFapo00nnL8fzoyrkQPnfE7awgv1N8opYeFBLcax/nSox2
 wXXjuzI8W2TlFdLpR0XqLcsk+REjPWABq8zGaso0Puy4t6yfrLbS2brIykC86z+einVR
 QxKS2txf5UNQTgEt4yQb4TPfcT5uCNbxC+XlD+I80W0+nEhUS+HbH1XUVIfqRbYGEkgn
 9nsLLTrCEdU13VlGDPjLbLqlOFx8Qe/BXpQTRLqvhooSpUiZdZ782KGBpZLMjJlZRggI
 vuCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVweK460ZJCeXKfVISstjghPBcCS/q8OW2gOOC0YH0fS28yDA6TUQ31hn0FQ9ACl8K5mEkMeVVX0Bwn4Ibo2GyiuHtu
X-Gm-Message-State: AOJu0YxDCIfuHJFfMxubgKAno6/th460dicsZ0dHkFlsMyZBHDRMyAIe
 KDKVMccOqmv1ureckpm4upR6NIMvzzdN5rEVacm9JaSuzO34TOYBK/mmDg==
X-Google-Smtp-Source: AGHT+IH3eFVuSJNco5LBdn/FMBy41iP/DZ4rmSWO5CrzFU63e5SivWSu+PDKfHX3OUbGStS8YMqMoA==
X-Received: by 2002:a17:90a:4dcf:b0:2c9:5ecd:e3c5 with SMTP id
 98e67ed59e1d1-2cf238ccaabmr4759827a91.33.1721951941944; 
 Thu, 25 Jul 2024 16:59:01 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 79/96] target/ppc/mmu_common.c: Simplify a switch statement
Date: Fri, 26 Jul 2024 09:53:52 +1000
Message-ID: <20240725235410.451624-80-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

In mmu6xx_get_physical_address() the switch handles all cases so the
default is never reached and can be dropped. Also group together cases
which just return -4.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 0152e8d875..b2993e8563 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -375,15 +375,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     case ACCESS_INT:
         /* Integer load/store : only access allowed */
         break;
-    case ACCESS_CODE:
-        /* No code fetch is allowed in direct-store areas */
-        return -4;
-    case ACCESS_FLOAT:
-        /* Floating point load/store */
-        return -4;
-    case ACCESS_RES:
-        /* lwarx, ldarx or srwcx. */
-        return -4;
     case ACCESS_CACHE:
         /*
          * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
@@ -393,12 +384,10 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
          */
         ctx->raddr = eaddr;
         return 0;
-    case ACCESS_EXT:
-        /* eciwx or ecowx */
-        return -4;
-    default:
-        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need address"
-                                   " translation\n");
+    case ACCESS_CODE: /* No code fetch is allowed in direct-store areas */
+    case ACCESS_FLOAT: /* Floating point load/store */
+    case ACCESS_RES: /* lwarx, ldarx or srwcx. */
+    case ACCESS_EXT: /* eciwx or ecowx */
         return -4;
     }
     if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FD9C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5WX-0001NC-QB; Tue, 12 Mar 2024 13:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UQ-0006BS-8C; Tue, 12 Mar 2024 13:00:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5UM-0008Km-49; Tue, 12 Mar 2024 13:00:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso4815347b3a.2; 
 Tue, 12 Mar 2024 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262826; x=1710867626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwlNJSycCuQXF9GnhGarIkq0/MrxOBJJLSGiFZLu6m4=;
 b=bIsPOcmLDhu/FOTYFwzsJOc5q7qoUo0Y+BXwEN7OuIyPqDbm+mjeJq7Bcp2SKnBmus
 QBAEb5R/xjoIqAXRm62kbcYFqPuMrikXsiON/AB72dzm08I11NGuicL9ctIGiPy5hfFr
 n7dzMTlN9heiASLbdt0lOhco3hNfHABDm4BIUpyj3yUwJEfsRXlgiY0AmEzoX3zjqHzj
 FBmR/ffa6PBsI/q0AcjWkvaa4xkae6Z8l9n2+ETgTMCKT/h4d57n4ylFNE5Q+/6Ft0h/
 bJjZSOB2W5FLVp2gin3GixleIKeqawFYIZyJnfPHvpfpxyvHIdwmUfOPC5NmfOlhpmbp
 nE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262826; x=1710867626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwlNJSycCuQXF9GnhGarIkq0/MrxOBJJLSGiFZLu6m4=;
 b=KK+EjEhV20zXO5toJAu135qbUpBwDkDoLPl680KscGHgEjgn0d/+Rpyo8VILPrD5zj
 X4mJndE4+cwQ7WIXDZE/lS3r/Hya3kvmy1q4zUC1pjVvtxl62CBSNAB3BISftkTHI7KM
 0pTdvGffX/zL67OLOhaEuOKWatdDW9ajkqxs0lPFrEBBlHqkgUvW3Z+AlmyoS2ktATR3
 g1yi3jXlnFwWp7OLFCKzyvIIuV5WIH4wTvGBnI+8XNQyTGSnCX4SQQEsUD5QPzD4/8H1
 EKUKLohlOXsGjoG/m//z9/5Ymg1o2jM+IMEB2SZzZQiCG+WP4qjKZqKRNW81s9xwKPQd
 Xh+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5TVjergH9eH3pZgZ57AvX0V7oHP+MU2YfoaLBZl4glFaeEcO/VAYUHZozJYExW9uUw55ujvaaeQP3FPyo7HRkhGd8
X-Gm-Message-State: AOJu0YyQt3GnZyA0qx/G9Yj/uNQei7xdIk0y8shRAy9YPG6CGINl0gRt
 boNuYtSRpr/yo2q0NR1XezOQNbhm0l8+OLUrLo+oSAIci5OeFzHtSflyEcDQ858=
X-Google-Smtp-Source: AGHT+IGY9IQgl1QOqIcJKz09O9XKRjAsJTorakRxfgtwTIbj8Ii7ybOBFGH6UOdQGw8o/HxLka4/aA==
X-Received: by 2002:a05:6a00:21ce:b0:6e6:4946:93e7 with SMTP id
 t14-20020a056a0021ce00b006e6494693e7mr25802pfj.27.1710262826018; 
 Tue, 12 Mar 2024 10:00:26 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.10.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 10:00:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 23/38] target/ppc: Clean up ifdefs in excp_helper.c, part 3
Date: Wed, 13 Mar 2024 02:58:34 +1000
Message-ID: <20240312165851.2240242-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Concatenate #if blocks that are ending then beginning on the next line
again.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 148b0c3a19..a9efda7626 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2553,10 +2553,8 @@ void helper_raise_exception(CPUPPCState *env, uint32_t exception)
 {
     raise_exception_err_ra(env, exception, 0, 0);
 }
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
 void helper_store_msr(CPUPPCState *env, target_ulong val)
 {
     uint32_t excp = hreg_store_msr(env, val, 0);
@@ -2661,9 +2659,7 @@ void helper_hrfid(CPUPPCState *env)
 {
     do_rfi(env, env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
 }
-#endif /* TARGET_PPC64 */
 
-#ifdef TARGET_PPC64
 void helper_rfebb(CPUPPCState *env, target_ulong s)
 {
     target_ulong msr = env->msr;
@@ -2763,10 +2759,8 @@ void helper_rfmci(CPUPPCState *env)
     /* FIXME: choose CSRR1 or MCSRR1 based on cpu type */
     do_rfi(env, env->spr[SPR_BOOKE_MCSRR0], env->spr[SPR_BOOKE_MCSRR1]);
 }
-#endif /* CONFIG_TCG */
-#endif /* !defined(CONFIG_USER_ONLY) */
+#endif /* !CONFIG_USER_ONLY */
 
-#ifdef CONFIG_TCG
 void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
@@ -2794,9 +2788,7 @@ void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
     }
 }
 #endif /* TARGET_PPC64 */
-#endif /* CONFIG_TCG */
 
-#ifdef CONFIG_TCG
 static uint32_t helper_SIMON_LIKE_32_64(uint32_t x, uint64_t key, uint32_t lane)
 {
     const uint16_t c = 0xfffc;
@@ -2907,11 +2899,8 @@ HELPER_HASH(HASHST, env->spr[SPR_HASHKEYR], true, NPHIE)
 HELPER_HASH(HASHCHK, env->spr[SPR_HASHKEYR], false, NPHIE)
 HELPER_HASH(HASHSTP, env->spr[SPR_HASHPKEYR], true, PHIE)
 HELPER_HASH(HASHCHKP, env->spr[SPR_HASHPKEYR], false, PHIE)
-#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-#ifdef CONFIG_TCG
-
 /* Embedded.Processor Control */
 static int dbell2irq(target_ulong rb)
 {
@@ -3258,5 +3247,5 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return false;
 }
 
-#endif /* CONFIG_TCG */
 #endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
-- 
2.42.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C923C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklT-0005NP-5j; Mon, 11 Mar 2024 14:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklP-0005MS-J5; Mon, 11 Mar 2024 14:52:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklO-00056Q-1j; Mon, 11 Mar 2024 14:52:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc09556599so39013825ad.1; 
 Mon, 11 Mar 2024 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183160; x=1710787960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z09svf28Z0llAd2gDy+oDdnr0RjElQioiML8sz0N9IA=;
 b=HQNsrq8ZsXskl/t5jZEHtq2a/M9V3FWUI91YUPk6m7gAIdm2usDrki+pGJMoDP6xP9
 KEaAR4UfKHSYcJjWGsub+Y7brUxE4lMSiy7a0l+k4IlAYuGRhWcTl7uJVS00Hd/6/R2P
 7ugbXDLwmLqC0T3UkYz0zLvuj5SiLRCHDYMubQfc6v1ckjTRuYShEHPrQJq4j6GdCu1x
 5V7pWOC+UsGaI3cA8W8qzvoGMTmftfvKlfF1O/mmHFp+yF/xt0UNtuJRKLEyCdKxpToK
 ehItwPpjPxgDYbQNwVVtBcQfqAMn7sgPp96VS5yyhqmMBg5m2UfybzLxMkUsKna7VB3t
 Cm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183160; x=1710787960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z09svf28Z0llAd2gDy+oDdnr0RjElQioiML8sz0N9IA=;
 b=QGenPgYa78QIMK1HuVBSR+1J6jfBc3MR5vM00l0T4QdSGlZhS4DQ9J8ZQiFfyqT293
 yYqAK7mTK2WYbhEGxfIB1+4nA7QXEuIUYpA3605xWL5b5JgdG0JuMKaWhF33Q1beUc78
 Z/EhXrMYs+4M1LvEXKiY51Pj0xuCQAm1AQXZxjSNjawxhO9PAruZmA7hxY6PBzMxxnju
 OU+QEv0pNUETypQO+SlZNhgx1k2GURK0DdQ9OXxupMOujo7Ddyq/9mfX91L9vtj4u+5R
 Lhooe4w5nS10NHaXoPadCMbeEYC+5P8IsoaWN+L/2i0WpShCXlV8EBZ97FH2o2Ctj8qU
 OahQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUloLvzCcwIIcw0I8NFPEIiVMpF/YuvinbVHSuViuHriom4EoZmNaJE5BcbykN37esmhGSXUZG9EAbTi+U5wVOUcG9fWvw=
X-Gm-Message-State: AOJu0YzvoWXy0DR1RIxWnnis8sguq9A2IoZrsUCOF0mlH3BMIuUoN9IK
 UdVOCOUaeX/uC7ghiG9wWWqwip332GHBD1TpPLpaia+Q7u2hF3cBBOnzcHBdklU=
X-Google-Smtp-Source: AGHT+IGEGHMotarG6JJ8S3FrE+dcI4Naq359Pf2ibu6LQ+R9gnAB5gxHW0K9xDkCUywi+Bx+pq8Xqg==
X-Received: by 2002:a17:903:24d:b0:1dc:affb:1f50 with SMTP id
 j13-20020a170903024d00b001dcaffb1f50mr10497345plh.47.1710183160060; 
 Mon, 11 Mar 2024 11:52:40 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 09/13] target/ppc: Prevent supervisor from modifying MSR[ME]
Date: Tue, 12 Mar 2024 04:51:51 +1000
Message-ID: <20240311185200.2185753-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Prevent guest state modifying the MSR[ME] bit. Per ISA:

  An attempt to modify MSRME in privileged but non-hypervisor state is
  ignored (i.e., the bit is not changed).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 410b39c231..25258986e3 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -264,6 +264,11 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         value &= ~MSR_HVB;
         value |= env->msr & MSR_HVB;
     }
+    /* Attempt to modify MSR[ME] in guest state is ignored */
+    if (is_book3s_arch2x(env) && !(env->msr & MSR_HVB)) {
+        value &= ~(1 << MSR_ME);
+        value |= env->msr & (1 << MSR_ME);
+    }
     if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
         cpu_interrupt_exittb(cs);
     }
-- 
2.42.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623F1C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TM-0004gy-Id; Tue, 12 Mar 2024 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TD-0004a8-AS; Tue, 12 Mar 2024 12:59:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5T9-0007v9-JZ; Tue, 12 Mar 2024 12:59:19 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e617b39877so4232495b3a.3; 
 Tue, 12 Mar 2024 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262751; x=1710867551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmKs3OLijRDjxbbgFJRC36Pyehi0EZh4ofDu2FesM1g=;
 b=ZGhyanoRt226wX03Gwg1rwK8CUiVrh9X/HSwjE7fMGt0ZOkdCAlHYBEsAueFc8DuHn
 sXy+HDcyGQLa9loHdxlfIije4+ax+Gm0+ELw1qdqR1/gzQzraJPBCgTqE3jF2YA1qlJ/
 vOrG6/Ot71lYSBrcHAy2uxhz1LxnAkIYFWK6Fag5M0dDtZJc3ljiLJKsINWwtohR4hTe
 ukVrSW85E+TSe1NNdoBAbj1yxlERMa8CzpBZleGXhw4/j5oOmUdTllbwfDEq9C2xTfu+
 mJtFG8NiIy3/nXLnzZht0gFEJPwoxtBmDMy0J9utgZCO1QwjJaAUSqzwRxJLSR4XDVec
 qokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262751; x=1710867551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmKs3OLijRDjxbbgFJRC36Pyehi0EZh4ofDu2FesM1g=;
 b=XWDW+r6tu7/ufmwlS0qfeMyl07kQMhFyI1yy8l+k59SfXVxbGaGIdygmX7ZZ2dtxi8
 5Mb+KKfRKK1HAOtLcWv3YWhyxjQd7K514aVBPZd2HyOSFcUbqYkUhsGGhS4fciV9XPw4
 alDEre8CXd6cRqRGeFWc3WWsqmSPzYjqSY4bBS6xyYbLudOyPW1KJJZFpbaY0cpeQJo1
 HSRgmzyxQF5umRWVsRkcVjS5HjYyuPxJHc4aZ0lk25BXFZzVFsQVEXBmGT4Rt3Aa/kvI
 KwQ+6FT7lJmoXG9aHxQZu62ekJ1+DXSj7wZuA1Fx7vHGK4UYX14BzwXxrf77Ua/KwB/D
 PYUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2EQcWM0YJsERGIUlwjtmD1uRkIoizVGKT0ta64MvOgeXfzntco1Ky+ujh23UL9IjsQ2/5wOHfJFGQZGwQQnGzqmcV
X-Gm-Message-State: AOJu0YxSwUrhGjyypBXJKgj6PdeXT5LQ0SEUUcSd9iD4DPAreQmRWAyG
 RFuLJZ3gLY5ndl7zs0DnHcBL798VQLFU1DgXBnfzbg33eHpZFOw9WWlXDOKmWXQ=
X-Google-Smtp-Source: AGHT+IF2mKu9LkEIW1Hxx++Bm0ctDSuSyujbEp9m1DagvhBvp5GJ3iOjoUb1qZR09taMdDQ758WynA==
X-Received: by 2002:a05:6a00:23d2:b0:6e6:9f47:38c6 with SMTP id
 g18-20020a056a0023d200b006e69f4738c6mr5169pfc.27.1710262751462; 
 Tue, 12 Mar 2024 09:59:11 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 02/38] target/ppc: Prevent supervisor from modifying MSR[ME]
Date: Wed, 13 Mar 2024 02:58:13 +1000
Message-ID: <20240312165851.2240242-3-npiggin@gmail.com>
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

Prevent guest state modifying the MSR[ME] bit. Per ISA:

  An attempt to modify MSR[ME] in privileged but non-hypervisor state
  is ignored (i.e., the bit is not changed).

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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



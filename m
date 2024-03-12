Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FE5C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5TN-0004it-Uu; Tue, 12 Mar 2024 12:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TK-0004d5-GF; Tue, 12 Mar 2024 12:59:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TH-0007xM-Ay; Tue, 12 Mar 2024 12:59:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5c0be115aso80380b3a.3; 
 Tue, 12 Mar 2024 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262761; x=1710867561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hIrP+GOO7mqBVQBlneIZNaQyZ+Zlpvjob7t6Cp/ux0=;
 b=HJb7wkV9Xory+0sMHc5wcGXZUAuE9AA20v5f9E42YDlGDOFcZ0KxfYgt24000iVf7R
 Av80iu8tiohxNHnuPSXINxChS/O2UvCDtSVNjwMYP2GDu9B6fmnzagQbpaRpVGEJKB5R
 aDdVb6o9GEGEs5utkDr8jyhsw1kiOAzrTPw1uX6A1YjOBs5XWzRPu/amikCkgwmlYNNc
 z0ZLGgLS2mTAZyap6RHx2LdJNqdLeWLzqHkpSFkB09XajlRhCSp1B3EZ2VJxbDwdhC6m
 IbEDkVRZFtVzAV3qz035J3MEHAx/mBVzAICNObMCMRTHE7XJeWJt5Q5bgfP4oFQsc8j0
 USCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262761; x=1710867561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hIrP+GOO7mqBVQBlneIZNaQyZ+Zlpvjob7t6Cp/ux0=;
 b=jhYinOvoUP4wERzaomNTvInqyuceSTA/K0jRAiosCwPQkKV/YnnAvA8ihMkaaY9u/6
 otf9U2mdTZ6OsjeWaJErYMQwLZKrcm1+TO+Fq3VWzgD66ibj0kN0PpK+uT5T/P6NGT1L
 iQorI+IaJzE0ac14lf//b6KgPk19j8RJAQ0ybCyj6Errdk7vY3vFa+eZlf0scGDOpAfB
 xGdN47oyJwAULhtH5VqWd9AU1/+Nfr2UO83m94bIvEODAh0YupUeOTJYLB8XRT3GfjgK
 kbfHRMoLqT1XRK4AJJLLf+XKgYTcsluI1PuFMm6nWj32JYqK7KkAOJ9ihtOuk/iT2F+w
 jcpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYP+ji8EOQLL58UDjMta6P39xxtsN+Qfzugrs1mQIyuduNI+uTXUEjph2RmncYpbTi9SpXxfsGO4wHRzD03Ggk2dX3
X-Gm-Message-State: AOJu0YxmHCVqo4tSzVFz9exLXTuef0eObU0vEf8aRsWNwGViiZMwnRy1
 DC7lSudNmTTUqObq/Cv8AhwR2u0DGQeOzKTuBB+NkfBUzoDSApnRDbA9L1+IHMA=
X-Google-Smtp-Source: AGHT+IG5cDMQmDShI4v5/qJWIFcWmnXg36TxA1wPQkWCdPcpo+/gYQqwvMMo7rTJSCGOjkTsYkPGwg==
X-Received: by 2002:a05:6a00:2d0a:b0:6e2:de02:598e with SMTP id
 fa10-20020a056a002d0a00b006e2de02598emr14132pfb.33.1710262761034; 
 Tue, 12 Mar 2024 09:59:21 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 05/38] target/ppc: POWER10 does not have transactional memory
Date: Wed, 13 Mar 2024 02:58:16 +1000
Message-ID: <20240312165851.2240242-6-npiggin@gmail.com>
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

POWER10 hardware implements a degenerate transactional memory facility
in POWER8/9 PCR compatibility modes to permit migration from older
CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
should not support it.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 572cbdf25f..b160926a93 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6573,11 +6573,10 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
                         PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
                         PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                         PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
-                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
+                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
                         PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
                     (1ull << MSR_HV) |
-                    (1ull << MSR_TM) |
                     (1ull << MSR_VR) |
                     (1ull << MSR_VSX) |
                     (1ull << MSR_EE) |
@@ -6617,7 +6616,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
                  POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
                  POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
-                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV;
+                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
     pcc->l1_dcache_size = 0x8000;
     pcc->l1_icache_size = 0x8000;
 }
-- 
2.42.0



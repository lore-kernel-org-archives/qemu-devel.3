Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBA4C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3k-0001qY-22; Mon, 19 Feb 2024 03:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3i-0001YZ-4y; Mon, 19 Feb 2024 03:31:30 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3e-0002LU-5W; Mon, 19 Feb 2024 03:31:28 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d7881b1843so34365225ad.3; 
 Mon, 19 Feb 2024 00:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331482; x=1708936282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBzaOnIszF4oJ7jbud6LzrAGJBdBmoK8UT2ZMh/vfDg=;
 b=jCGTfnaU5dlkEttZjr44upsAHFcibAkTUBHSjQ4iG8IqCeyTAopZMgOlK1fZxy1+mi
 ur7RRGcKVXkMf7chNhRNlDiEIsgi/GoOaU2Iofietp3EJdxAkKlN1oL7z6YbB865EO00
 UoSoTLxtYnaVZKp5IJZ+EQs80cw692R3h546AKzx7kYAy0AYZ+uXarok6DGszUisD5aQ
 hzCHCYm5YofoJohU36BYhIIxLd+V+BJAJvdmhNABRBUZKE2EqW1JxHws+3tSFYNOzFKY
 yz140wltPWDN9GXsJWw5RidAJvCo/CR4vkY9pZVoLW61kY/ZEz9CNDUKFcneXlfmAvwi
 eL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331482; x=1708936282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBzaOnIszF4oJ7jbud6LzrAGJBdBmoK8UT2ZMh/vfDg=;
 b=GKDGQq2hOCKXryVldU6Z9VD+q0K3wYX+me25FFFltKCSWh5CeEP7u2N5GhJiDkJxUH
 SpLH1XxjEpLn18w4wupaWil611TgAYZ45LVX/xnSLJayLYapBClftagK03OE5SHQqWwF
 2dP1/M7d/PUAGrKsdw2d54WV2w2Pm6XRyMZJfO7nbmIwloIuJUHhChnzMj6+zHPFAgF2
 ELIR//F7isEA8z/+IV6NxdR768U9jRWHCIDrHdgEuDg6nOcGzciVKIK/z2XjNnGN7rfw
 7GrBK/KKEBfhRp/a6emQ8qxDCVOIiF49aCupmNKpQxnidL7Og303BPG0h0evGp3tSeNI
 BlJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEL2vYF9yfsV5mnr7J3QWQmteGJ7qPgy3yonb9tCSsgYitfFK3eHIIlxwrM6rBoDPhGHg+l3feUfWjLHBu0myagKGL
X-Gm-Message-State: AOJu0Ywrr/HbpjLOlvpQFpnFc0tHvVbUgOFmcV0/oiCxImGH8UYgXVDo
 Q03w7ztwoPcY6bq3hr5SBEo0c8s5lipV277is3DFisC8ZKmBo/1P+Ih6JaW6
X-Google-Smtp-Source: AGHT+IGjE4Aaf9vlw8Xwe93jMOvdXyOwJsOrCHDRw5mchS0jw0X70KQnNixe0e8mzlOKfE8ywNtqlA==
X-Received: by 2002:a17:902:b705:b0:1d9:7729:2a6f with SMTP id
 d5-20020a170902b70500b001d977292a6fmr11572302pls.61.1708331482311; 
 Mon, 19 Feb 2024 00:31:22 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:22 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 18/49] ppc/spapr: Initialize max_cpus limit to
 SPAPR_IRQ_NR_IPIS.
Date: Mon, 19 Feb 2024 18:29:07 +1000
Message-ID: <20240219082938.238302-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Initialize the machine specific max_cpus limit as per the maximum range
of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
assert in tcg_region_init or spapr_xive_claim_irq.

Logs:

Without patch fix:

[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: IRQ 4096 is not free
[root@host build]#

On LPAR:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
**
ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Aborted (core dumped)
[root@host build]#

On x86:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
Assertion `lisn < xive->nr_irqs' failed.
Aborted (core dumped)
[root@host build]#

With patch fix:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
machine 'pseries-8.2' is 4096
[root@host build]#

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d72d286d8..0028ce0b67 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4639,13 +4639,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
 
     /*
-     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
-     * should be limited by the host capability instead of hardcoded.
-     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
-     * guests are welcome to have as many CPUs as the host are capable
-     * of emulate.
+     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
+     * In TCG the limit is restricted by the range of CPU IPIs available.
      */
-    mc->max_cpus = INT32_MAX;
+    mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
     mc->default_boot_order = "";
-- 
2.42.0



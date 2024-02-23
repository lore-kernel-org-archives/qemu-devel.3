Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9B4C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXu7-0003cj-Hr; Fri, 23 Feb 2024 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXip-0005bk-To; Fri, 23 Feb 2024 10:44:23 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXio-0006KQ-Dg; Fri, 23 Feb 2024 10:44:23 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dbf1fe91fcso7847665ad.3; 
 Fri, 23 Feb 2024 07:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703060; x=1709307860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xN8nmdXHN5XCjfxtSnns0I9puDQ9du3yvTk36PUt1SI=;
 b=GdGZHgMBxxq4A9yiaGw9J+JGo9rU+FO1zr0sRRsVChL1hFz/Hyp1MmL40rFReezgzg
 TeTjk2Ncs7d2UznMlM9a3j4BD1liMz9uqVgDznDtqS+Hil4zO2j1fIa59STcwdgZJuTI
 scZSbOUoUBfrV2OjkCiYxMA5msH/LZUWnZKJzpGt3WsW7goYiR4uSpEtT7bBhWwKGdG8
 mARO4RsyunxzuPTIDNacI3tVzrtxWETUtXzISx2vlBZANyIXVIMQmsycixyrm5nNy1SJ
 OgMFuApc1fElxaPKvw29iTuWqJOOseJMeiExopfAMwQBpL+ldBptD9rZgIQmp9x3igGa
 fIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703060; x=1709307860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xN8nmdXHN5XCjfxtSnns0I9puDQ9du3yvTk36PUt1SI=;
 b=PBsgygKpxn9Sb7tCcj9SAIa0gVv+ff+kDYpYnEKIZWtu42yjR/rtQNWwZuQSsKXKnU
 w3Uw+Gguo6KXjfAAdXxUmZEPlplzojJXIbsogvTayqPeminOvJH4/enBf0MpWaLqMuBi
 9UnC1CJcJzGIwfMOko2GPC82Uf+SD4qhYxyDBuOcJ8EbLlKmK0/iOtlvncJIlC36+G9L
 Jie0wcaMxZzNMNU1VokA1Xzm6V+3E2M6OpZ9Llc+HwkrvHOQAuCOWrAx1YyYejTse+Pc
 aJP3qFQEZyW0ZJ9+t6JPZT0/AXGYtQnlX0D2mUaGf9EgPLnVO2+8bGKefazxhd8J588f
 ceIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAuRs7fTRlyf56XRkacYTUiV57ZDbUgcfZH1SrVR5QqE6E8NcKuX8rbsA/mHgv+CUqLgtotzWiwgoAVvNVE4+lKdkI
X-Gm-Message-State: AOJu0YxiXlOqWyfzcD1isusvPEzhXG0jVGkVOxzeKwj0S+i+A+Yb3n32
 +cq5Ptb8lQUIHKlIaaUULSF7jHPtUCjfWx/bTzLrxaXQmDVGbkz8AoPh0cxA
X-Google-Smtp-Source: AGHT+IG1slZUNN/KG6bEXQ1IX0ZFFEz2pKF8n6J4d0lEjjW6SxOut4QvVKYAthQgHtLwqQUUZ5sp1w==
X-Received: by 2002:a17:902:6942:b0:1db:8eae:b98e with SMTP id
 k2-20020a170902694200b001db8eaeb98emr156227plt.38.1708703060364; 
 Fri, 23 Feb 2024 07:44:20 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:44:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Kowshik Jois <kowsjois@linux.ibm.com>
Subject: [PULL 17/47] ppc/spapr: Initialize max_cpus limit to
 SPAPR_IRQ_NR_IPIS.
Date: Sat, 24 Feb 2024 01:41:36 +1000
Message-ID: <20240223154211.1001692-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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


Reported-by: Kowshik Jois <kowsjois@linux.ibm.com>
Tested-by: Kowshik Jois <kowsjois@linux.ibm.com>
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



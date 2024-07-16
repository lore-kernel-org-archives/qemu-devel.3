Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B803C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2P-0002bL-IC; Tue, 16 Jul 2024 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1i-0007WI-5Q; Tue, 16 Jul 2024 12:27:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1d-0006eH-6H; Tue, 16 Jul 2024 12:27:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70b3c0a00f2so3564031b3a.3; 
 Tue, 16 Jul 2024 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147249; x=1721752049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUzOrDcz1AGLPLWjWXyXaCj3TBotsysZNYHGdl2IwIE=;
 b=HmaadkDt3OJnZ6PeBjPEXm+pIQqn0EQNPUJ9zXZTWXhHkxgAO5LTimL5BR0oPdJbCE
 bTY8ih6+fTnJds//XqgTEZ+KkqMBs/RXKbyHCyluViQ0VMdVeCDnRuQo21e8TeCjouG1
 y2wmB1/z5pOVLCBrHOtH5BXmZ1vz/PC6Woht+gkKl8hiSrTccu0jFA0WvMpRM7SY8C3Y
 6SKTdHqXN+cSm+rBcqObHXCSXvqppOXVQJgqlR1IXax7PQcw9XXr46lhj6STDy5yikzw
 a4EBDyXQfh07YhdnaRNLp7Ag9MOcWfL0b3TZeRaAcEJSrVpts1FaYpaYsw7xmh0W4oeP
 WYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147249; x=1721752049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUzOrDcz1AGLPLWjWXyXaCj3TBotsysZNYHGdl2IwIE=;
 b=limZgmeqLjaNzdb7rXm+YwgGJ3kWMHM3J+70kijkATj+tZblJSQocxVQS+TpK9j6WJ
 5LFNjJBqe67Z/xRDFsSiKsD7KLidMpt2pzc7HaQ9Mb5qYOoQYdDh4QySa7rfKNLXvTHX
 b8D+EWBQozsiF7t2WgaNRGCLsLh7agN63zff8ENQeBmz21jYGMBzhOMlew32cBQEfPjH
 o3V0MCD5JpRTTFcEG5aioaYAXh6WvAzKV9xeTLdsdY1pFjJFAYeVMce/4WWkV8fOHJJG
 uWdeFYhaaFAqVWn3wECj8YB3F5g/K52pzZhMM8JC/OOjXK99lrspJ7ft0CkgLFzFR+1T
 xuEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/SwT3JuDp7qmLbHYnQho1ckQ5iAqOGgIHDB5LydSWi8uJdIYZ+v1j0Pk+LaMwRfvNTQysiuqoN8BA/I6dgtx8wev8XfU=
X-Gm-Message-State: AOJu0YycQQC830MSQcVQEdVrSHZdqLqo5qhwoiklEm9AQ72Y9Oj5XrEp
 vPw2sj8V1XgCN1NmHUcEBMuJ8x0D71Mj0yknnwPfDweMDv/6ZXJ79FhLqw==
X-Google-Smtp-Source: AGHT+IGisbjoUBY8Bi/ZzYpmwNxJIj1gJ96cZDU2Ndw8B+sWdrDvbw8sz7oAc7HR3TFGAdSgKYOu6Q==
X-Received: by 2002:a05:6a20:7f93:b0:1c2:a6ad:d23e with SMTP id
 adf61e73a8af0-1c3f1256149mr2853498637.30.1721147248836; 
 Tue, 16 Jul 2024 09:27:28 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 17/19] ppc/pnv: Add a CPU nmi and resume function
Date: Wed, 17 Jul 2024 02:26:13 +1000
Message-ID: <20240716162617.32161-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

Power CPUs have an execution control facility that can pause, resume,
and cause NMIs, among other things. Add a function that will nmi a CPU
and resume it if it was paused, in preparation for implementing the
control facility.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index c56d152889..b7858d310d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -112,6 +112,8 @@ PnvChip *pnv_chip_add_phb(PnvChip *chip, PnvPHB *phb);
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
 
+void pnv_cpu_do_nmi_resume(CPUState *cs);
+
 /*
  * BMC helpers
  */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 08aaac359b..f7580947ed 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2751,11 +2751,23 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
          */
         env->spr[SPR_SRR1] |= SRR1_WAKESCOM;
     }
+    if (arg.host_int == 1) {
+        cpu_resume(cs);
+    }
+}
+
+/*
+ * Send a SRESET (NMI) interrupt to the CPU, and resume execution if it was
+ * paused.
+ */
+void pnv_cpu_do_nmi_resume(CPUState *cs)
+{
+    async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(1));
 }
 
 static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
 {
-    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.45.1



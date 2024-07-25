Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DAEC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8IU-0003l4-3m; Thu, 25 Jul 2024 19:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IS-0003dU-Ap; Thu, 25 Jul 2024 19:54:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IQ-0000a5-Pp; Thu, 25 Jul 2024 19:54:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d1c655141so397118b3a.1; 
 Thu, 25 Jul 2024 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951692; x=1722556492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvWrzrnQVMo86cmX8a3zehjixqrcjJKeO5PkRaLW3bM=;
 b=JRpvwiezIunYLbXPTgYzRKnYlEUakAZhtCMNdiiTVTZgdZwoAxYNIsyj3LJyhdKF95
 EUp+LN098sX2aRy0nkwBcPW4yzh+vFXqcyDaKzyZkAJdS5Bhy8tGgCmBPi4V9LcfDMta
 2zE7K8kQs34mLkn8TF7zZgGk7mGyRrtBrmTBmu6Mn3Lurq+Dm7T9EYSLHsIl2pVJQSv8
 e6HCgc+DGewNQUSZDRd3eKtY0uKTj1HV5C1tDKqF/r1l7ea6uFuUitV6jQfSqs+Mn/gP
 p49KP9UHktBTcs5z4iryoYeMehgCLwev2KvSlOJJbiCDYP+4YxUowWMqiv1TXkckwIX/
 y7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951692; x=1722556492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvWrzrnQVMo86cmX8a3zehjixqrcjJKeO5PkRaLW3bM=;
 b=qo8Q9dpad2D33q0K+57NiWolBPemzVvwYGMYxr2xqc9ALyTGjTfqHiemc+GpwtkWIU
 rLJeVoIrESY7zhhMaqbntTwuXt4IVuS32a5TQLgNw2zUfEesWUEoKn/yAsbPFqm40lyU
 0qM7yV1KvUT736OM9EvFGyHYZuqDkRGhJ++M2iHnnDjiMFCM98EBdsiMJHrWOKtXabTO
 Fg8vb+kik3oYlT912GEayfHE/OVNYxhKw7/ck4IKeJkGQKftSt+2Ps7iOUHwWldR7QtI
 3gNSGrRg3Wr+TOWVLQaMj+t0K17IU64enKePfJq1D4K2ZX7ZqB+8T8XHcy26Qh34Gvl5
 bWGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV79NHXNXHRYPojK+LBEiteUEwAdd5wUuUx2lockalqYxyubT04x4g1dQcCgZO46lW6bqm6aifi+b+78p8AKpeMbPsr
X-Gm-Message-State: AOJu0YwHirlEUNWPlFWppsOj8h+5B+D+GfAtjZZuqtQAmYw5PKypOfSK
 +YDJVOTiPa4VAwHlfGIhqafTju1CU0YyykXutOzdks0FE0DuPk09lhL20Q==
X-Google-Smtp-Source: AGHT+IFtH28YYuRWTMtS00hU0UIdGjwRsbCgE6bmShxvreWot4A+fSsDBa7fe1VfUC6915d/qQJ65w==
X-Received: by 2002:a05:6a21:32aa:b0:1c2:8dd5:71d9 with SMTP id
 adf61e73a8af0-1c47b17afffmr4360188637.4.1721951692444; 
 Thu, 25 Jul 2024 16:54:52 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 06/96] cpu-common.c: export cpu_get_free_index to be reused
 later
Date: Fri, 26 Jul 2024 09:52:39 +1000
Message-ID: <20240725235410.451624-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

This helper provides an easy way to identify the next available free cpu
index which can be used for vcpu creation. Until now, this is being
called at a very later stage and there is a need to be able to call it
earlier (for now, with ppc64) hence the need to export.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 cpu-common.c              | 7 ++++---
 include/exec/cpu-common.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cpu-common.c b/cpu-common.c
index 7ae136f98c..6b262233a3 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -57,14 +57,12 @@ void cpu_list_unlock(void)
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
-static bool cpu_index_auto_assigned;
 
-static int cpu_get_free_index(void)
+int cpu_get_free_index(void)
 {
     CPUState *some_cpu;
     int max_cpu_index = 0;
 
-    cpu_index_auto_assigned = true;
     CPU_FOREACH(some_cpu) {
         if (some_cpu->cpu_index >= max_cpu_index) {
             max_cpu_index = some_cpu->cpu_index + 1;
@@ -83,8 +81,11 @@ unsigned int cpu_list_generation_id_get(void)
 
 void cpu_list_add(CPUState *cpu)
 {
+    static bool cpu_index_auto_assigned;
+
     QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
     if (cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
+        cpu_index_auto_assigned = true;
         cpu->cpu_index = cpu_get_free_index();
         assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
     } else {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 240ee04369..2e1b499cb7 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -35,6 +35,8 @@ void cpu_list_lock(void);
 void cpu_list_unlock(void);
 unsigned int cpu_list_generation_id_get(void);
 
+int cpu_get_free_index(void);
+
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-- 
2.45.2



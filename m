Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C40E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4p-000626-Gx; Fri, 10 Jan 2025 13:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK32-0001SY-7T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2z-0001Ez-Ni
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTFKgODEFPxb1Rk0GJF65qhyFgCjbUlVyAYk2qcRkJ8=;
 b=HijdWrKS8o/VmQYHyFYcPcjS5v0DJbks91+1/Pb39VE8VwBW+v4YZ82ckGeD6bS+ndFFgN
 HM5ekbTacBpc96WPk0X+F1Z/Hkvbhr/B8424Cc94EF1fKQftmO+SQ9uky8Ap2cbzxZ9D8v
 Gto7VD9JTGhtw5srsQK5ml9QcW3cA6w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-bxlRSeUDPJKGInhb95j1KQ-1; Fri, 10 Jan 2025 13:47:51 -0500
X-MC-Unique: bxlRSeUDPJKGInhb95j1KQ-1
X-Mimecast-MFC-AGG-ID: bxlRSeUDPJKGInhb95j1KQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa6a87f324cso211710966b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534870; x=1737139670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTFKgODEFPxb1Rk0GJF65qhyFgCjbUlVyAYk2qcRkJ8=;
 b=aXmTty6bgCoNMxiR6wYd57xHVhoNIvjKC1UcdNh48MHx6xTPJAem6fTFyDgueVH3c0
 Y7AdBTxUCAoMgJ6fZnV+h1SSGasNzZ5q+GdQfh651v+elGP1b8hy8I0tCkMetTGt8sMz
 ZmkySrxAl31kcn2OIBkFVwF8U2iPyDCCq2UpqOFMWOoqZzDZ/ail9aNCnm9/2Mqhyww/
 tqykx2ae9jz8wGeXHwAxW0XsMFN5pAdTSb8L4WHtVsu9h0YhqicsmEadvonxtH+RpSHM
 VxZiRoPiMDRiCD02P8Rl35orjuzaKLW08qumvzQQ4hFkOg/l93tFaBH6FciZHeRy1eXU
 Otcg==
X-Gm-Message-State: AOJu0YxpNyN3pEEWiOyoEB/D1BkvCuGC1J9tljmr1WGFccg+RDy4NKFl
 yC65Yqo+4GM23xe9dME8JeelQQO78dUHBfwMk+BxiYo2ThyZsNBbTyWA76xJ+9zyBfKSn1eOxWJ
 nU32CCXH47NKQYOUSiAv3RlP6kFAkHfKOIJWRxgAC2wJSFsQErkx9cUMTvwZKxRaIOKrDS2Jku9
 lXvHU03rjtL1X0VDuKicY5btra9UOtWUHqv/UIcxY=
X-Gm-Gg: ASbGncur6JuhH4h3nNOEAUlvergIrGJoh8iD5yaE22oHFYU9B7ZJTKljv9cf8MiQLkF
 QL0xLiZRpwfHSkLxlYmKaXWTFIsmDAUjoI4Tlh5pl/Rl9Zg014E96LHzjIt87tq6MRgznAC9OS6
 mKJfiXmxAtG8e3PyQqdnq9DBJF4VuFWOAlfnR1juTJ2cMpT60PATVlt3pbWtO2x3cqfeYwJEdWH
 9wF/1rYDj2FRSy2Hh9UmJEZOC4WtYEwKXHmiMSeayduNPnCzpdOttPAjh0=
X-Received: by 2002:a17:907:a0cf:b0:ab2:b77e:f421 with SMTP id
 a640c23a62f3a-ab2b77ef683mr944977166b.23.1736534869653; 
 Fri, 10 Jan 2025 10:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbWzlDo6ABCULYQ3HbbqUBaIWyRM+E2vNUe/ywyNxFncIrLZi8ztJhNHx1J4l8pon4+aTp+Q==
X-Received: by 2002:a17:907:a0cf:b0:ab2:b77e:f421 with SMTP id
 a640c23a62f3a-ab2b77ef683mr944974866b.23.1736534869138; 
 Fri, 10 Jan 2025 10:47:49 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d81c4sm194760666b.64.2025.01.10.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 36/38] cpu: Remove nr_cores from struct CPUState
Date: Fri, 10 Jan 2025 19:46:17 +0100
Message-ID: <20250110184620.408302-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

There is no user of it now, remove it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-9-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h | 2 --
 hw/core/cpu-common.c  | 1 -
 system/cpus.c         | 1 -
 3 files changed, 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..fb397cdfc53 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -407,7 +407,6 @@ struct qemu_work_item;
  *   Under TCG this value is propagated to @tcg_cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
- * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
  * @sem: WIN32 only semaphore used only for qtest
@@ -466,7 +465,6 @@ struct CPUState {
     CPUClass *cc;
     /*< public >*/
 
-    int nr_cores;
     int nr_threads;
 
     struct QemuThread *thread;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 1edc16f65c8..cb79566cc51 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -243,7 +243,6 @@ static void cpu_common_initfn(Object *obj)
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
-    cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
 
diff --git a/system/cpus.c b/system/cpus.c
index 99f83806c16..37e5892c240 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -687,7 +687,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
-- 
2.47.1



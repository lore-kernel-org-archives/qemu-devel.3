Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF75FC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YlP-0001RH-GK; Thu, 02 May 2024 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YlB-00013G-CU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl8-0002Oj-I3
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFofCkIX6ZCOAYjcqWsduwPTtWRGt+ZtQlacHrjsajI=;
 b=Tnk7fnQu57LGF+YF34g3/ux9JVCVdjTuuLlmaEE7PBv59p/dms+RB1vrfUxFc7uU34+W4+
 xjz58Z4uDYiNIEd2of3ibUkGthnYf2eWVP0LngbvUDngrZAkr2yhYczkoHQgzkJ1aJvFqp
 lQHr5wy2pF/T+apZormEoyqJavPSGtQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-H09UaJtrOLW_JDS5E0CiLQ-1; Thu, 02 May 2024 11:54:07 -0400
X-MC-Unique: H09UaJtrOLW_JDS5E0CiLQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a58bca80981so439737166b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665246; x=1715270046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFofCkIX6ZCOAYjcqWsduwPTtWRGt+ZtQlacHrjsajI=;
 b=YmFh9rmgrT0q/Ut2K/J//Hu1wJIz2iABO3kzrtpu5wYNMzBpvmu/JYLVABAmdTKKuR
 306cSOC0J94aKykiHBbU1Wt1GjnaYRspb4fhOw5wNKKOcKPCkiKiQIyzxF5/7SzjeZoJ
 ckEomehJspHF38/JAel45JOIJ2wP/Fk2TzGxIKtCfoRO8BN0J85m8GXmJqdHZ0MVRiVg
 UIdXLm7qVtzepCiE2TmQqQX6pIzeD1VUE91mF3009CTj5O3wcZT0fSqpgzpvX8oL3iUk
 dgJUsjl0/7s6BuLvZvg74fGI2eiu6RKOdK/BJey8bCsrX/ChnIdeKIhR6cL+3FF7rUah
 vSVA==
X-Gm-Message-State: AOJu0YwhPaR+5heB4c2Jzzbe6Ph9CjScAvX+ZofekOvaKoAGtXYRh6gI
 CChNlXKAuwQpcliVUuGjNUN/pO+YJYgsH3pqfo2eqfGmhz5qfIKidciUBMHffVJz7p37yn3JR8S
 4RA3egNkktOrsQu3Rl5yj97xNEEKfmK5Na3nuwXr6WG1QHTPhGPxGU/r2vpI/w+7JGk6FTliCzL
 +zdtVHdn5ylIjtHi/F5rDnrUws1bq3ZTiGbM7W
X-Received: by 2002:a17:906:37c8:b0:a58:849f:4d18 with SMTP id
 o8-20020a17090637c800b00a58849f4d18mr4304485ejc.35.1714665245944; 
 Thu, 02 May 2024 08:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy2xl4oXlR5Uy/S1LKZDYXexegjbuDZq6qyaXqbSNnWvLJNEoK1oNy43kalRgsPt0Sipp5tw==
X-Received: by 2002:a17:906:37c8:b0:a58:849f:4d18 with SMTP id
 o8-20020a17090637c800b00a58849f4d18mr4304476ejc.35.1714665245563; 
 Thu, 02 May 2024 08:54:05 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 mj17-20020a170906af9100b00a58f1eff266sm690173ejb.189.2024.05.02.08.54.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:54:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] tcg: remove CPU* types from typedefs.h
Date: Thu,  2 May 2024 17:53:30 +0200
Message-ID: <20240502155331.109297-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hw/core/cpu.h is already using struct forward declarations in some cases
to avoid inclusions, and otherwise CPUAddressSpace and CPUJumpCache
are only used together with their definition.  CPUTLBEntryFull is
always used when their definition is available.  Remove all three
from typedefs.h.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tb-jmp-cache.h |  4 ++--
 include/hw/core/cpu.h    | 10 ++++++++--
 include/qemu/typedefs.h  |  3 ---
 system/physmem.c         |  4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index 184bb3e3e2e..c3a505e394a 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -22,12 +22,12 @@
  * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
  * CF_PCREL, but it's used always for simplicity.
  */
-struct CPUJumpCache {
+typedef struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
         vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
-};
+} CPUJumpCache;
 
 #endif /* ACCEL_TCG_TB_JMP_CACHE_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a23d39f6a0c..1382a986158 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -85,6 +85,12 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
 
 typedef struct CPUWatchpoint CPUWatchpoint;
 
+/* see physmem.c */
+struct CPUAddressSpace;
+
+/* see accel/tcg/tb-jmp-cache.h */
+struct CPUJumpCache;
+
 /* see accel-cpu.h */
 struct AccelCPUClass;
 
@@ -473,12 +479,12 @@ struct CPUState {
     QemuMutex work_mutex;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
-    CPUAddressSpace *cpu_ases;
+    struct CPUAddressSpace *cpu_ases;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
 
-    CPUJumpCache *tb_jmp_cache;
+    struct CPUJumpCache *tb_jmp_cache;
 
     GArray *gdb_regs;
     int gdb_num_regs;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 7e3597e94c5..d23020ed232 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -38,12 +38,9 @@ typedef struct BusState BusState;
 typedef struct Chardev Chardev;
 typedef struct Clock Clock;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
-typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
-typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
-typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisplayChangeListener DisplayChangeListener;
diff --git a/system/physmem.c b/system/physmem.c
index 1a81c226bae..6dc58b34bbb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -158,12 +158,12 @@ static void tcg_commit(MemoryListener *listener);
  * @memory_dispatch: its dispatch pointer (cached, RCU protected)
  * @tcg_as_listener: listener for tracking changes to the AddressSpace
  */
-struct CPUAddressSpace {
+typedef struct CPUAddressSpace {
     CPUState *cpu;
     AddressSpace *as;
     struct AddressSpaceDispatch *memory_dispatch;
     MemoryListener tcg_as_listener;
-};
+} CPUAddressSpace;
 
 struct DirtyBitmapSnapshot {
     ram_addr_t start;
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E1DC10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66md-0003Gl-Ut; Sun, 12 May 2024 06:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mY-0003F9-Qq
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mW-0005u0-VB
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16FC5lp67uehiw7i+v0tZwBGhuHhyMS3WmvcfffWhrM=;
 b=bhRna411v0RgaY8KIblhINAbfq4xZpAJJvjnKHrGKtqYGWa0yEz/6aOsmjRxj4jjnGPwAd
 0ac42de3ruuYgztGBTnzGQT7LdrBKLuOX4KUIj1dQn0fiFxGuw25WZxnE/SkbKwduR7qei
 lpedvJv4wZFQF3OnlmkVy+KSsSW2wWA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-qdpJ33xZPUyfyEvn7wJrDA-1; Sun, 12 May 2024 06:50:14 -0400
X-MC-Unique: qdpJ33xZPUyfyEvn7wJrDA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a0d2280cso269980266b.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511013; x=1716115813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16FC5lp67uehiw7i+v0tZwBGhuHhyMS3WmvcfffWhrM=;
 b=bl6i1I7PExC0biRbSXtdmTYtzp/UaOi/wJea/QOA7ymrDcTNuTDwPkriqvt357q94l
 m1zT38cF/KBoJJuKzyjevlcGp99PfR7ft34BiuhiPBeWSf+ADGbRpmS3tpKXV+sXfZMV
 yGCuxAwKEMVyMo4zpSztyjoxPjo8T3zLrNQ3KA0FJ5ntKKIZGgqhr6VHcg3Qkh8qjLqb
 sGmiOrG9pjJUCFvEnTq1YpKwp1KAhnsRiRYbO06JYZVNsE8Ae2oFonsNKt60BrweF5MV
 cL2FySB3gtoqIx/OgbiEBKwX9gf6SnM0Cui/cbKc6igF2AisE6ym06Lyxcj4o+fkcYvB
 YVmw==
X-Gm-Message-State: AOJu0YyvDjOH3mfywxUgDWhzVNos+2MBXRiei2y2Lh8oPzzhrYG0O3U3
 3Kv9hky4y7OMKjj67LnMJjURe1LUyeSxAvGnpu7UZo3f727X4c6+W/zRRe9xmfoeGlhALbcMirK
 G4kxkBf7azdcqZH0ACAITJrOuhR+BA3ROcgeu1nXikcrZ/H3hOR/yu7plK7UZ1pHEmtY2wlVGmh
 C5EXLi16xos3QXzZRrzM7S1qiUBLZOrSUJBd7y
X-Received: by 2002:a17:906:a28c:b0:a59:e5ca:db31 with SMTP id
 a640c23a62f3a-a5a2d54c743mr441517866b.16.1715511012849; 
 Sun, 12 May 2024 03:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbq7l9MYqBEUTYZaw//UmYJM1odEY1ZffePHiZBloA/aC+52xGNrjVy2GINHZIq5c0BYlRCA==
X-Received: by 2002:a17:906:a28c:b0:a59:e5ca:db31 with SMTP id
 a640c23a62f3a-a5a2d54c743mr441516766b.16.1715511012486; 
 Sun, 12 May 2024 03:50:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0195dsm441401966b.184.2024.05.12.03.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 09/27] s390x: move s390_cpu_addr2state to target/s390x/sigp.c
Date: Sun, 12 May 2024 12:49:27 +0200
Message-ID: <20240512104945.130198-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

This function has no dependency on the virtio-ccw machine type, though it
assumes that the CPU address corresponds to the core_id and the index.

If there is any need of something different or more fancy (unlikely)
S390 can include a MachineClass subclass and implement it there.  For
now, move it to sigp.c for simplicity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240509170044.190795-2-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 16 ----------------
 target/s390x/sigp.c        | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2afaf45ce60..42628fc45d2 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -50,22 +50,6 @@
 
 static Error *pv_mig_blocker;
 
-S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
-{
-    static MachineState *ms;
-
-    if (!ms) {
-        ms = MACHINE(qdev_get_machine());
-        g_assert(ms->possible_cpus);
-    }
-
-    /* CPU address corresponds to the core_id and the index */
-    if (cpu_addr >= ms->possible_cpus->len) {
-        return NULL;
-    }
-    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
-}
-
 static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 9dd977349ab..ad0ad61177d 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
+#include "hw/boards.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "exec/address-spaces.h"
@@ -435,6 +436,22 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
     return SIGP_CC_STATUS_STORED;
 }
 
+S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
+{
+    static MachineState *ms;
+
+    if (!ms) {
+        ms = MACHINE(qdev_get_machine());
+        g_assert(ms->possible_cpus);
+    }
+
+    /* CPU address corresponds to the core_id and the index */
+    if (cpu_addr >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    return S390_CPU(ms->possible_cpus->cpus[cpu_addr].cpu);
+}
+
 int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3)
 {
     uint64_t *status_reg = &env->regs[r1];
-- 
2.45.0



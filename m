Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3847C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578Z-0002D0-U1; Thu, 09 May 2024 13:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578Y-0002Bu-2t
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578V-0003UR-P6
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSdbbijnqqu6Q0jIu+Qkk/Gmy2abee1VL3NL5PRrhBA=;
 b=LmOsU/dOeHaBGR6KF1+Vzn135yS0WVs/Xa+C002GCVhvUDLu3G79VwPIgoLHBilvQVMBtb
 5oHwXE3WS3z8GpJDc6fSr5knc70MbfPKUbSnR7ppsog3Exir1h0oPdOjGNT+RHih6V9bI1
 QdCcPjkT7U+hqia1wY9arBH+4ncf2Hg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-XQXVVISGMwGRnXM6zyidXA-1; Thu, 09 May 2024 13:00:49 -0400
X-MC-Unique: XQXVVISGMwGRnXM6zyidXA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a5966e85bf6so191860666b.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274047; x=1715878847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSdbbijnqqu6Q0jIu+Qkk/Gmy2abee1VL3NL5PRrhBA=;
 b=EjK5W5WZwABhwOKcZKkHA/iPPqIz2YodlQOcSaXZo2pUR8L1a1fWm5O4Bt1TUNpw0M
 RKyafDMR0gMROMNSXHu9ItPB7EzFJPXJPbfjJhSo0YoyKfKXJfVfdOxCP8IjCoVTm54P
 Ow0bd9bbF92zbdI6RFuHS6Ah6JHUnXpwXblesHAjpfKr9cpzCJCsnMmt8DHhZaDdvSVx
 ZnebBgiYILvdL2O4yAYytJ84dtIxVAOr5nY6YOx5sxMjO/SLCwFlQoatAoE4AaqKg4Si
 nXnREX7Evi1ek0+mTKI97HbSwK+sRbJE4PJsT+06LrikV3FwgDp/WcPnxR+bH79OBeln
 yadw==
X-Gm-Message-State: AOJu0YxmrGE4JCFRis0OXfX4HG1+Jg1YJXG/voqS9jPnNZ/qya2EVlU4
 iZVz7d+GA9ZQKb81phnpEodRGayigqdsxd6feD+apf5hh46LOw/3GrLoxd+7X03hlv1qUiFuA2g
 kagVwAHcDxUg85mrt9RUXz6QYJuNBd3RwVeGZOYYqKges19NJFcDSg+mhgwcUf4ZYRON1ryIC9i
 KiOBpc/u7IM7YwwLmWP19chz5S/cPaNVcvAqOm
X-Received: by 2002:a17:906:308b:b0:a58:9a67:967b with SMTP id
 a640c23a62f3a-a5a11844720mr261523066b.27.1715274047016; 
 Thu, 09 May 2024 10:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9w7WUbqsGUYP9TFk+LYI8lDiO+u2ZSHR2NmcOcxtMBWkBS8hpZkMnI/0Qf3m6oIbjlQ/R8w==
X-Received: by 2002:a17:906:308b:b0:a58:9a67:967b with SMTP id
 a640c23a62f3a-a5a11844720mr261519966b.27.1715274046408; 
 Thu, 09 May 2024 10:00:46 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cd90sm92868066b.20.2024.05.09.10.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:00:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 01/13] s390x: move s390_cpu_addr2state to target/s390x/sigp.c
Date: Thu,  9 May 2024 19:00:32 +0200
Message-ID: <20240509170044.190795-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509170044.190795-1-pbonzini@redhat.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
---
 hw/s390x/s390-virtio-ccw.c | 16 ----------------
 target/s390x/sigp.c        | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4dcc2138200..feabc173eb3 100644
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



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCA606A332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=ea7423Vh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Ax-00073Q-R4; Thu, 05 Nov 2026 12:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Av-00072h-B6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1At-0007fm-8G
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso17476315e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899374; x=1794504174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eI9HPtQC+pcKKIYpVEiubZEEEhj4+2GZLfw7sUEK1YA=;
 b=ea7423VhXpCPKKrLf6Bv/EdkQmCXRb7k7M/2dEOYHBIKkwxHs7zN99uRzDoqapVHdO
 7jzHs/GXjj0CQzslAZY+O52LgAVI4qiEJTi57rCYBt1w0ApADPEFYraS7hnwlyhhk5Hp
 whqflITN48bk2WnOjhe27QDdHDcCy0dse6UTk1Bou+vcLaLe7NwLbZ34TxQ/tyHsMC3j
 nupGJUEzknEvIyyQHhwVxXUMTCHwgPHduSJ1Phe3+HfJHC/RLECabmQLGTeFQZhEbpar
 MQU0uoq1vMVwyEs7qZgigKfDSuuU/xSuniglwsX+DBkj4LraJ10s/qJ+WoFyENHCfWEs
 7MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899374; x=1794504174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eI9HPtQC+pcKKIYpVEiubZEEEhj4+2GZLfw7sUEK1YA=;
 b=1lq8qsoxWHrQAGNZt9EzUw+zMj2VlvEXXj37QjHarFuRMIOV4bIPqB0bdCrCAgnrSF
 ixHnCzXBTB1+adhf6PEF+7AvjHdKm1drgonZt3Lq/pkhCPLUrAQ+GF/GuKmv5Eld5xhP
 lKyfEcgiCYwneKvDrPyqL4IQmmVnxAHFSb2lWllk4ZwxLUxfedkN8qoFdG58n0Pvt/ld
 OZ7Ltfqj3qkso7Rn4jtMQn5GQgJiRL7ajKukDAm8yJLdk8VfUXerop8fAtiy8fKV7Sa4
 FsGN7qXjTAIzrSkYDk+He3ufzhtsrVR5MnyeMdGcNpDnrgkV70ARfUexd9iOQvPSiHdR
 Azdw==
X-Gm-Message-State: APuU4Z/KyEv2MvmDMqlsUXv/E0EnZGARraecSO2Bs5P8p/EfWjbT3FDt
 /5N89muF82i56pmpb1B4e82rqaNobcmGakkOltD3IM4me35gnWqNfJ5Vflcs9ec3QWN4vp4QkJe
 th/kS
X-Gm-Gg: AYBFou0WLlkIgrih2P4SAZpy+NqSQMMY+t/LVsfKZuoyseStEgBDGCgD082cEL1pgnp
 nsZnENePbcvewzKyhwNAuEMtsY5SaSCBiytVdN1jcDTezTAXmo5CF6JYfC5yxyeZHiE3qhpSnci
 7a4qgVWw2zZwoGpbQjqhJH0kgWizk5EOT9m/i8dyhH3AngjAqmLf7Gv1ojKZ9ou8o+gHKaO5jib
 nv7KdZLDRnuo9NYo6exPoMCSmSBNgajFqXswXoPh9tQ/W05FZZpRJVGPwBKbV5zsF5hHyI7Rrhi
 VhVxyT0py+SlLZpaLzwoaLIDvf/ZoB4os5Yu6DISbAtjTU/9kdun508uygxX94WwdW/0aHMQhad
 5rv+OJaP0Qhhz188UBi1v5O4gw6/DzhYZ42HatpHVi3Kj81uTSddsoF0F8/nQ3Vbey120q8gn5V
 6cTpgx5cCM2br/QhZED7E5oTEOtGgkmt1mH3hw0pUEUZgPP4ho8QCedgD9lzAk9Tu3P5MC3afhI
 1bSO8GuebIjWb6sn0zHT6shLa6ibdeZrDXKFwhoMdSlUKsdW2RG/KHNUVSCWfZTiwZBkgRV5eph
 WRIrv/f+Kqf6d8EzoNi6ndr8rMA=
X-Received: by 2002:a05:600d:84ca:10b0:4b4:49d7:bc25 with SMTP id
 5b1f17b1804b1-4b449d7be7fmr68546075e9.21.1793899373779; 
 Thu, 05 Nov 2026 09:22:53 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:53 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 5/6] hw/hyperv: split the SynIC page mapping from its state
 update
Date: Thu,  5 Nov 2026 18:22:43 +0100
Message-ID: <20261105172244.2804598-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

synic_update() records the SynIC control bit and page addresses and maps
the message and event pages at those addresses in one go. Loading the
SynIC wants the two apart: VMBus creates its SINT routes from the
control bit in its own post_load, so the state must be restored with
the CPU section, while the mapping can wait.

Add hyperv_synic_update_state() and hyperv_synic_update_mr(), with x86
wrappers. hyperv_synic_update() keeps doing both. The mapping now
compares where the page is mapped with the recorded address, rather
than the old recorded address with the new one, which is the same
thing while both are updated together.

No functional change.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 hw/hyperv/hyperv.c            | 70 ++++++++++++++++++++++++-----------
 include/hw/hyperv/hyperv.h    |  3 ++
 target/i386/kvm/hyperv-stub.c |  8 ++++
 target/i386/kvm/hyperv.c      | 16 +++++++-
 target/i386/kvm/hyperv.h      |  2 +
 5 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 900ff80213..307e7a40ad 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -65,33 +65,61 @@ bool hyperv_is_synic_present(CPUState *cs)
     return get_synic(cs);
 }
 
+static void synic_map_page(MemoryRegion *mr, hwaddr addr)
+{
+    if (memory_region_is_mapped(mr)) {
+        if (mr->addr == addr) {
+            return;
+        }
+        memory_region_del_subregion(get_system_memory(), mr);
+    }
+    if (addr) {
+        memory_region_add_subregion(get_system_memory(), addr, mr);
+    }
+}
+
+static void synic_update_mr(SynICState *synic)
+{
+    synic_map_page(&synic->msg_page_mr, synic->msg_page_addr);
+    synic_map_page(&synic->event_page_mr, synic->event_page_addr);
+}
+
+static void synic_set_state(SynICState *synic, bool sctl_enable,
+                            hwaddr msg_page_addr, hwaddr event_page_addr)
+{
+    synic->sctl_enabled = sctl_enable;
+    synic->msg_page_addr = msg_page_addr;
+    synic->event_page_addr = event_page_addr;
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
+    synic_set_state(synic, sctl_enable, msg_page_addr, event_page_addr);
+    synic_update_mr(synic);
+}
 
-    synic->sctl_enabled = sctl_enable;
-    if (synic->msg_page_addr != msg_page_addr) {
-        if (synic->msg_page_addr) {
-            memory_region_del_subregion(get_system_memory(),
-                                        &synic->msg_page_mr);
-        }
-        if (msg_page_addr) {
-            memory_region_add_subregion(get_system_memory(), msg_page_addr,
-                                        &synic->msg_page_mr);
-        }
-        synic->msg_page_addr = msg_page_addr;
+void hyperv_synic_update_state(CPUState *cs, bool sctl_enable,
+                               hwaddr msg_page_addr, hwaddr event_page_addr)
+{
+    SynICState *synic = get_synic(cs);
+
+    if (!synic) {
+        return;
     }
-    if (synic->event_page_addr != event_page_addr) {
-        if (synic->event_page_addr) {
-            memory_region_del_subregion(get_system_memory(),
-                                        &synic->event_page_mr);
-        }
-        if (event_page_addr) {
-            memory_region_add_subregion(get_system_memory(), event_page_addr,
-                                        &synic->event_page_mr);
-        }
-        synic->event_page_addr = event_page_addr;
+
+    synic_set_state(synic, sctl_enable, msg_page_addr, event_page_addr);
+}
+
+void hyperv_synic_update_mr(CPUState *cs)
+{
+    SynICState *synic = get_synic(cs);
+
+    if (!synic) {
+        return;
     }
+
+    synic_update_mr(synic);
 }
 
 void hyperv_synic_update(CPUState *cs, bool sctl_enable,
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 23091301d0..fcad9efb5b 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -80,6 +80,9 @@ void hyperv_synic_add(CPUState *cs);
 void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
+void hyperv_synic_update_state(CPUState *cs, bool enable,
+                               hwaddr msg_page_addr, hwaddr event_page_addr);
+void hyperv_synic_update_mr(CPUState *cs);
 bool hyperv_is_synic_enabled(void);
 bool hyperv_is_synic_present(CPUState *cs);
 
diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 767a4c7e1a..c4d18f2cf5 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -53,6 +53,14 @@ void hyperv_x86_synic_update(X86CPU *cpu)
 {
 }
 
+void hyperv_x86_synic_update_state(X86CPU *cpu)
+{
+}
+
+void hyperv_x86_synic_update_mr(X86CPU *cpu)
+{
+}
+
 void hyperv_x86_set_vmbus_recommended_features_enabled(void)
 {
 }
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 420c76b5ff..08001b26c5 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -42,7 +42,7 @@ void hyperv_x86_synic_reset(X86CPU *cpu)
     hyperv_synic_reset(CPU(cpu));
 }
 
-void hyperv_x86_synic_update(X86CPU *cpu)
+void hyperv_x86_synic_update_state(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     bool enable = env->msr_hv_synic_control & HV_SYNIC_ENABLE;
@@ -50,7 +50,19 @@ void hyperv_x86_synic_update(X86CPU *cpu)
         (env->msr_hv_synic_msg_page & TARGET_PAGE_MASK) : 0;
     hwaddr event_page_addr = (env->msr_hv_synic_evt_page & HV_SIEFP_ENABLE) ?
         (env->msr_hv_synic_evt_page & TARGET_PAGE_MASK) : 0;
-    hyperv_synic_update(CPU(cpu), enable, msg_page_addr, event_page_addr);
+    hyperv_synic_update_state(CPU(cpu), enable, msg_page_addr,
+                              event_page_addr);
+}
+
+void hyperv_x86_synic_update_mr(X86CPU *cpu)
+{
+    hyperv_synic_update_mr(CPU(cpu));
+}
+
+void hyperv_x86_synic_update(X86CPU *cpu)
+{
+    hyperv_x86_synic_update_state(cpu);
+    hyperv_x86_synic_update_mr(cpu);
 }
 
 static void async_synic_update(CPUState *cs, run_on_cpu_data data)
diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index a393a5d428..a0aee0cff3 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -26,6 +26,8 @@ int hyperv_x86_synic_add(X86CPU *cpu);
 int hyperv_enable_synic(X86CPU *cpu);
 void hyperv_x86_synic_reset(X86CPU *cpu);
 void hyperv_x86_synic_update(X86CPU *cpu);
+void hyperv_x86_synic_update_state(X86CPU *cpu);
+void hyperv_x86_synic_update_mr(X86CPU *cpu);
 
 void hyperv_x86_set_vmbus_recommended_features_enabled(void);
 
-- 
2.53.0



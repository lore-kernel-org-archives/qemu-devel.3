Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A6E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4a-0004yV-4U; Fri, 10 Jan 2025 13:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2j-0000RT-G3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2g-0001Cu-AJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yAqjTt2W/272b7bDml1UKHxI7+gCBOSOR6mlAaYf50=;
 b=a4+hJs2TcVMdJiUIr3p1erFyn/MWtVBv8oMjJ8p2FHH9KJCxWsPCL3KoHNlZpf0e21bIaL
 pkAOsGOa28+vNHhYuVrJVTXhyrQ7MeTSbLt0ksBYduk2RjCk2YcMkgXwed2BU8EPmwJzOS
 eDM2lDEITFxi1U5GwznaxGmC0O3bOW0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-iFtRjx6lNl-iFgIK_48ERQ-1; Fri, 10 Jan 2025 13:47:32 -0500
X-MC-Unique: iFtRjx6lNl-iFgIK_48ERQ-1
X-Mimecast-MFC-AGG-ID: iFtRjx6lNl-iFgIK_48ERQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa691c09772so216185366b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534850; x=1737139650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yAqjTt2W/272b7bDml1UKHxI7+gCBOSOR6mlAaYf50=;
 b=Kzfsk/TInSwtqM12GUPveC6qC8vOfGqH0vJnXuCHst6xDuOvBoqrL29QtWMQDF2heH
 sKz6oFEvV2CT7MTFgwIaNG44fU2UT7WOD7QIunrcPYevJuo+ekV5z5IdXp6Jvppu95Bo
 XGn8UwBrZaW37iaL6oRa/w/HpL5s8+7/QWhtWd2LKpkWVO1c+9ngMBMeQ9ZzqCF2VRv7
 nnY4pg/oXqaZI91xGVBc7DrkLPW6QdzI9YZ5DfvFVc8bn4aaxreTjKT7hb/jt6xlwDPj
 Ce2/4ZGbpH77fN4Kj4Bi0JqqjlETH4AriF1hxK8G97v1ht0TtZupuXnciAkXJMNvsxGb
 HJsQ==
X-Gm-Message-State: AOJu0YyZBOSRmAXO/74PdKuJi77PLaprJAxRpg0+AO+maF88qflZ9eSZ
 dSg+dxjg1grKjQmOEhSTWQc5JtLdxdERDRUIjrsnENxPOrza9y6lWtIt2gPtDE3TjhruWJdlYTV
 R0i1KU6GV2nCUkkMYRn09HndYJ6+WaY3zYzq1uet1uBuvLpphGgH5AgKpIywnzAKskxBdmGYMm0
 vW1F5fMGk2WVV/aUv1RasXcUBw6YtQ2uLYip0fOE8=
X-Gm-Gg: ASbGncuLFyi8sxhTwbyBglA1lGIht6oWDGxhccfD5ozEhnlWQyFvT5tMeBjCyp6NNg0
 vjLyUXSdg4b0/uQxPqGZhpru4FAvJrLOadSgrf2Ry56ryjWRVwOcDprdJELk2dMUV9EroqPDKoz
 EVIZvHqa2nuND2LAbTYb5W5lJ2jN/uah+jS9pUDuRu2dWqVOGmpOOASHJxu0klAe4mEMFFwQvMl
 +xsevhKRk1bktEvByWCFTVhUNcQxBQ4Vd01NF2MIldFfmgDsGacw2MOLdA=
X-Received: by 2002:a17:906:c106:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-ab2abc91217mr1012730266b.54.1736534849695; 
 Fri, 10 Jan 2025 10:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2HeeieMfsxgWtHVTCcYPf4OIH1KPZaVR31h1wJvzTFkdegDKEtvoRei+tPTeEFoeQOBjHgg==
X-Received: by 2002:a17:906:c106:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-ab2abc91217mr1012728766b.54.1736534849271; 
 Fri, 10 Jan 2025 10:47:29 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060badsm193246066b.29.2025.01.10.10.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/38] i386/cpu: Extract a common fucntion to setup value of
 MSR_CORE_THREAD_COUNT
Date: Fri, 10 Jan 2025 19:46:10 +0100
Message-ID: <20250110184620.408302-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
Extract a common function for it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    |  2 ++
 target/i386/cpu-system.c             | 11 +++++++++++
 target/i386/hvf/x86_emu.c            |  3 +--
 target/i386/kvm/kvm.c                |  5 +----
 target/i386/tcg/system/misc_helper.c |  3 +--
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f41462d8c19..e8c46d877e0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2413,6 +2413,8 @@ static inline void cpu_x86_load_seg_cache_sipi(X86CPU *cpu,
     cs->halted = 0;
 }
 
+uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu);
+
 int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
                             target_ulong *base, unsigned int *limit,
                             unsigned int *flags);
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index 9d007afdab5..eb38cca68ff 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -309,3 +309,14 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+
+uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    uint64_t val;
+
+    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
+    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+
+    return val;
+}
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 015f760acb3..69c61c9c073 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -765,8 +765,7 @@ void simulate_rdmsr(CPUX86State *env)
         val = env->mtrr_deftype;
         break;
     case MSR_CORE_THREAD_COUNT:
-        val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
-        val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+        val = cpu_x86_get_msr_core_thread_count(cpu);
         break;
     default:
         /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1d7214b6a65..6c749d4ee81 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2614,10 +2614,7 @@ static bool kvm_rdmsr_core_thread_count(X86CPU *cpu,
                                         uint32_t msr,
                                         uint64_t *val)
 {
-    CPUState *cs = CPU(cpu);
-
-    *val = cs->nr_threads * cs->nr_cores; /* thread count, bits 15..0 */
-    *val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+    *val = cpu_x86_get_msr_core_thread_count(cpu);
 
     return true;
 }
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index ffed8a3215e..c9c4d42f844 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -468,8 +468,7 @@ void helper_rdmsr(CPUX86State *env)
         val = x86_cpu->ucode_rev;
         break;
     case MSR_CORE_THREAD_COUNT: {
-        CPUState *cs = CPU(x86_cpu);
-        val = (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
+        val = cpu_x86_get_msr_core_thread_count(x86_cpu);
         break;
     }
     case MSR_APIC_START ... MSR_APIC_END: {
-- 
2.47.1



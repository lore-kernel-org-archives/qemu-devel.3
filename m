Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A6C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wq-0007gO-74; Thu, 23 May 2024 11:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wg-000735-29
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wc-0004tR-TD
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeOVCrLphL6KpiNtfPym2iwG3G4C1sib1Ufn4kxPCy8=;
 b=jPviiTmlds7JLoCq2BvJF/sESLVrAqQIR899mlr6glKFtFSrEQB++LMTCOTkuLGL7cUp56
 X6+zbRrPDeVyKj9zuljnpgCLwVgpP8hr/5pE7RcmasjG/F1R7o1ZvN8vQEIJvDn6GCy755
 ljk8UtZrcWEJRRGe/qmM/c3GiPwjZjI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-GwnDJr8JN3WIyBP2vp1xug-1; Thu, 23 May 2024 11:01:23 -0400
X-MC-Unique: GwnDJr8JN3WIyBP2vp1xug-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c942611bso119374866b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476482; x=1717081282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeOVCrLphL6KpiNtfPym2iwG3G4C1sib1Ufn4kxPCy8=;
 b=NQYLgcS22hfRyXGzktsGS2jssKEaKbeBsEOCBXSe/8pUGbjy+tov3NgJhdAoQ9B2Dz
 TW6A44nPXBOJB7gOsDvD/qF47fCLC48F2jR9Im6BIFLE+zEOr3Brop9ZUd9DtcDFnid7
 OfgA73xmspzvo7UFDVMVAhf6gisRgoAd9slsqYZAlZAcjSSFoiM0BdST9cMy1mWAoBCW
 pzumfk9aXMR0fuZ/fgKQ+ZOySta6MlAyMJ1w3OhkweRazX5wvugIAU4b5qlDScNpyZqB
 bo7CU+YnrDNzgR7jM1gSwQNyMJCVlaj15FoOCrYKuKV4XMGPEmnzZJkp4AF8tpE48Jb9
 Ux0w==
X-Gm-Message-State: AOJu0YwX5G1Ov/Ikk6mPNWYI5xFx3IRiIjcJKGjwsHiJgs8LO5c3SIrg
 STl0lxsZhism8oCeUL/ssWDaxYtJjmcL6kO/v376io5v0MZiALPAzXuIysPcLyfM2tbdzyX5/E7
 e22g21muJbQ6CfcQG4RTekEzmxrCg82x5fqdNSIkOMdwSxuTqCZxLOCtrM44IgdI3ouY45G4Wdo
 0VfHpTwVPtxWqmL7dKVy/2+VaC8XfGp0lwngI0
X-Received: by 2002:a17:906:b46:b0:a62:c5f:e34a with SMTP id
 a640c23a62f3a-a62280a275cmr330835866b.39.1716476481768; 
 Thu, 23 May 2024 08:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJXKVwSFB9axrqTFDAmqI+yuO8z6TV9uALWcFZpU1QN5b33tY7urW+LzJWkG2d4JKYfP0u8g==
X-Received: by 2002:a17:906:b46:b0:a62:c5f:e34a with SMTP id
 a640c23a62f3a-a62280a275cmr330833966b.39.1716476481390; 
 Thu, 23 May 2024 08:01:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7f78sm1939073066b.133.2024.05.23.08.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 17/23] i386/cpu: Introduce module-id to X86CPU
Date: Thu, 23 May 2024 17:00:30 +0200
Message-ID: <20240523150036.1050011-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Introduce module-id to be consistent with the module-id field in
CpuInstanceProperties.

Following the legacy smp check rules, also add the module_id validity
into x86_cpu_pre_plug().

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-17-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h    |  1 +
 hw/i386/x86-common.c | 33 +++++++++++++++++++++++++--------
 target/i386/cpu.c    |  2 ++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 196b068614c..269c30c291b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2064,6 +2064,7 @@ struct ArchCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t die_id;
+    int32_t module_id;
     int32_t core_id;
     int32_t thread_id;
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 4d27279901c..ee9046d9a80 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -294,6 +294,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
             cpu->die_id = 0;
         }
 
+        /*
+         * module-id was optional in QEMU 9.0 and older, so keep it optional
+         * if there's only one module per die.
+         */
+        if (cpu->module_id < 0 && ms->smp.modules == 1) {
+            cpu->module_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
@@ -310,6 +318,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                        cpu->die_id, ms->smp.dies - 1);
             return;
         }
+        if (cpu->module_id < 0) {
+            error_setg(errp, "CPU module-id is not set");
+            return;
+        } else if (cpu->module_id > ms->smp.modules - 1) {
+            error_setg(errp, "Invalid CPU module-id: %u must be in range 0:%u",
+                       cpu->module_id, ms->smp.modules - 1);
+            return;
+        }
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
             return;
@@ -329,16 +345,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
         topo_ids.pkg_id = cpu->socket_id;
         topo_ids.die_id = cpu->die_id;
+        topo_ids.module_id = cpu->module_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-
-        /*
-         * TODO: This is the temporary initialization for topo_ids.module_id to
-         * avoid "maybe-uninitialized" compilation errors. Will remove when
-         * X86CPU supports module_id.
-         */
-        topo_ids.module_id = 0;
-
         cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
@@ -383,6 +392,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->die_id = topo_ids.die_id;
 
+    if (cpu->module_id != -1 && cpu->module_id != topo_ids.module_id) {
+        error_setg(errp, "property module-id: %u doesn't match set apic-id:"
+            " 0x%x (module-id: %u)", cpu->module_id, cpu->apic_id,
+            topo_ids.module_id);
+        return;
+    }
+    cpu->module_id = topo_ids.module_id;
+
     if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
             " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4aea6e3dd24..4d811130b1e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8118,12 +8118,14 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, 0),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
 #else
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
+    DEFINE_PROP_INT32("module-id", X86CPU, module_id, -1),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
-- 
2.45.1



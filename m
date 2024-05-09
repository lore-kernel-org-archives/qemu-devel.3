Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF68C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 17:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s578t-0002He-0h; Thu, 09 May 2024 13:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578q-0002H0-Ii
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s578o-0003YX-QY
 for qemu-devel@nongnu.org; Thu, 09 May 2024 13:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715274069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVIFiD89QhCcDd/5PLOQqXkqJ//w22v0cKCzdxBuTYI=;
 b=Fz5yOeZm/bgHlt67vJ6CK3Z0zcN5GzIAjj84e8R/BvCBOxWtgoaOSbbtoW0Crx2d5N7hxZ
 FW2kuj60o8FJPGibvWMzQFxonwDfnYFfEV1OiHu6cLNFXJXOgyuE432gvuK+zv1edAA0GS
 YKc/FibNUxW8rcWqdycR7t/bzR2qX+o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-lp0BVV2tOQGQgNbJ8A2kTA-1; Thu, 09 May 2024 13:01:08 -0400
X-MC-Unique: lp0BVV2tOQGQgNbJ8A2kTA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572cbbdb450so552937a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 10:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715274066; x=1715878866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVIFiD89QhCcDd/5PLOQqXkqJ//w22v0cKCzdxBuTYI=;
 b=qeLUIehD5oiLnMefOQHNIjK97AKY9oCogK6GzmIkJSmZOk6LXvhEQ0wtq7mzX7ZD0+
 MXE+3YWvIoeItiYsh6ww2luedIKm0Tf+7fZHvo2n+iXsHAUUn2FVNFk9+ivpKWp8CKlQ
 dzdsGSsbHPzintnpgEfwXoGwr1pMuAgVZh8eRRC05npBkM9OCl3c5rxKEeiNP53l33i3
 2rmNPuTB8weZr6iZhw2lkqp1YZ93iXHj8LpK7Z64CypucO0H/bMfLFoVtRx7r4HXrRmd
 jLA9nQf1OiJ/Tl57qbzy1SuWDy8LpTx+txv/HeeYlFQOw3772xUZ4b5pfMcnw3RjwJHT
 nbXg==
X-Gm-Message-State: AOJu0Ywxc7OvWgchsP3Zy3ywT1Zrg44GRJvHI3Ld7gG0r5cDNFRTxdnt
 uGyRwrsh/D6/K/DoCxRxnBQ7VjKlaDRQzF2cz8ihy/yPcmr6nSNcG3pESI7He8+FParIGZgYtsB
 QFKwhYxMnmmmiiKV+zzNtgzXhTTUMNPXlUj2Yo24P8qRhK72CxITW8JRu/iJYvgGkVRNEB6ITTm
 kYapcVpxJt72tCibteCgx66celP/C90VsxmnQF
X-Received: by 2002:a50:ab05:0:b0:570:5b3d:91f with SMTP id
 4fb4d7f45d1cf-5734d5ceb5emr197384a12.23.1715274066206; 
 Thu, 09 May 2024 10:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb8A6sgQ+MbhQHdnzOlhWhAhzTxAFxIX9acXMl9AuIGc2QA5bXTpO3yKD+XUoHTB/N9MMblQ==
X-Received: by 2002:a50:ab05:0:b0:570:5b3d:91f with SMTP id
 4fb4d7f45d1cf-5734d5ceb5emr197366a12.23.1715274065865; 
 Thu, 09 May 2024 10:01:05 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bbbfcfesm891663a12.0.2024.05.09.10.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 10:01:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH 09/13] i386: pc: remove unnecessary MachineClass overrides
Date: Thu,  9 May 2024 19:00:40 +0200
Message-ID: <20240509170044.190795-10-pbonzini@redhat.com>
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

There is no need to override these fields of MachineClass because they are
already set to the right value in the superclass.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h | 4 ----
 hw/i386/pc.c          | 3 ---
 hw/i386/x86.c         | 6 +++---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d7b7d3f3ce0..c2062db13f5 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -114,10 +114,6 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
 
 void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
 void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
-CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
-                                             unsigned cpu_index);
-int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
-const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
 CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx);
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 19f21953b4a..bfb46e9b548 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1826,9 +1826,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
-    mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
-    mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
-    mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c61f4ebfa6a..fcef652c1e3 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -443,7 +443,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
-CpuInstanceProperties
+static CpuInstanceProperties
 x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -453,7 +453,7 @@ x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
     return possible_cpus->cpus[cpu_index].props;
 }
 
-int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
+static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms = X86_MACHINE(ms);
@@ -467,7 +467,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
-const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
+static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     X86MachineState *x86ms = X86_MACHINE(ms);
     unsigned int max_cpus = ms->smp.max_cpus;
-- 
2.45.0



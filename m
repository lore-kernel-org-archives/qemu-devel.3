Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E912FC1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelZ-0000Wc-PX; Thu, 27 Feb 2025 09:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnel2-0007ib-Oj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneky-0003q9-Qz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gh0j8ufLlOEegSjJktfQdEiBAdxSKXYPacngKO6YrfQ=;
 b=XLE5RkBjQNWh7rdqMZ6jMIE3k9ARe1yOR19G5aUc+YiA55BOUE9lEc2H1PYlEN+G+BGUI0
 KCh020KCBQj1IdRLQisGr/FVXy+FfHHbEAtaz1dLb4iUMDLANwdgaZHBhBYyNPt7qpIK+T
 lyPP99zTVkLMTfrEiw3HcZKKC9nNEMc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-IjFlgM1JODamjTXTiufiMw-1; Thu, 27 Feb 2025 09:20:53 -0500
X-MC-Unique: IjFlgM1JODamjTXTiufiMw-1
X-Mimecast-MFC-AGG-ID: IjFlgM1JODamjTXTiufiMw_1740666052
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab76f438dddso41007066b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666051; x=1741270851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gh0j8ufLlOEegSjJktfQdEiBAdxSKXYPacngKO6YrfQ=;
 b=Y7S9Gz2G7AioDRa7+iSnL87r1cKGXkA8j09nUNpQR17E4iRCxvfqxa93Hhlbheq7ES
 h121yoVWl0pOi4bOhTpRDw7ULji/CnvHwleJAFBr0un6kzwRmI0+eKq+k0QLj+I9G48k
 D9jkMmEq84XeOtY3f8XXgclzeT08sBddQ01ddTdNc0bv05lIoB92cYTIirhdaiJtc9HS
 0OrZy8GmpSPonD/DlJh9/4l4xEwBrJ5HhGtOerc4azoNQbYmyNmEDEhDpFMzj48Bt10w
 HxdbUmRWp8VcjUf7jhJQ4r3e712x1M+YsoCleyIB6z91T1V6nAkudVNdKyft1QzSm3l0
 CfSg==
X-Gm-Message-State: AOJu0YzSP1o/2PBFQJVkoSwhvynTUP0dHJmMafFDAmEt0+FgBdu6SD06
 aZ88PU3p44mn+J2mzlPOEh4c8Rs3S9K9qaJsKsakuzNXwHtIUKiD85q4HCSSapGrC+rRSzwMJt1
 oJ2pYyTrA2cTK1FjGyJdEK5NIjKhO2DI62oDjS4kj7SPxCwKowN/zBMhuaPPZkFyLLu7cHZoIP3
 sjZrAE802JXwSwgr7a8iN0FEvTD/iSNdnC/t6M+BA=
X-Gm-Gg: ASbGncvDXhP7klIk9rs1ylGUBkUsvpWVyiNlsVrSwyw2VHdRuafK7zGU8estQEU5o3Q
 IvvvucK5/0jYwItocV4hYBOGNU/5OgaSi8IZiiBs5hee27JrfYjUpg4HQd/pIoZww9epoWk6+an
 Y2djvQi3pvN8gRw23Gkq3T+ijxudh5fwG9P/qYvGI3cTMckFL1dYwGvcp8MsuA/MgJkvZuEyHy1
 edf+xh0tHGQXQzJ1LWPYuqob6BAxsDxEf8ixkIyJZyRBTfDZX+NgciLo30TuWOFtfjHFSBiSgwz
 mJ1jNyO142V2wPZdkzoh
X-Received: by 2002:a17:906:3155:b0:ab7:c6a2:7a43 with SMTP id
 a640c23a62f3a-abc0db35941mr2366717066b.31.1740666051264; 
 Thu, 27 Feb 2025 06:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLlWQ6QD1ZDDBu4ot/1NZFk2nnvmD0s6fqyXTudnZBPEAQfDfIX2y8kxCKr/w45fxh1mKsMg==
X-Received: by 2002:a17:906:3155:b0:ab7:c6a2:7a43 with SMTP id
 a640c23a62f3a-abc0db35941mr2366713966b.31.1740666050819; 
 Thu, 27 Feb 2025 06:20:50 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6dbbbsm1179991a12.22.2025.02.27.06.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 26/34] i386/cpu: Update cache topology with machine's
 configuration
Date: Thu, 27 Feb 2025 15:19:44 +0100
Message-ID: <20250227141952.811410-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

User will configure smp cache topology via -machine smp-cache.

For this case, update the x86 CPUs' cache topology with user's
configuration in MachineState.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/r/20250110145115.1574345-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8799e22ed45..005ca4235df 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7906,6 +7906,64 @@ static void x86_cpu_hyperv_realize(X86CPU *cpu)
     cpu->hyperv_limits[2] = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
+                                          Error **errp)
+{
+    CPUX86State *env = &cpu->env;
+    CpuTopologyLevel level;
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l1d_cache->share_level = level;
+        env->cache_info_amd.l1d_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
+            env->cache_info_cpuid4.l1d_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
+            env->cache_info_amd.l1d_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l1i_cache->share_level = level;
+        env->cache_info_amd.l1i_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
+            env->cache_info_cpuid4.l1i_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
+            env->cache_info_amd.l1i_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l2_cache->share_level = level;
+        env->cache_info_amd.l2_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
+            env->cache_info_cpuid4.l2_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
+            env->cache_info_amd.l2_cache->share_level);
+    }
+
+    level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
+    if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
+        env->cache_info_cpuid4.l3_cache->share_level = level;
+        env->cache_info_amd.l3_cache->share_level = level;
+    } else {
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
+            env->cache_info_cpuid4.l3_cache->share_level);
+        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
+            env->cache_info_amd.l3_cache->share_level);
+    }
+
+    if (!machine_check_smp_cache(ms, errp)) {
+        return false;
+    }
+    return true;
+}
+#endif
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -8145,6 +8203,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
+
+    /*
+     * TODO: Add a SMPCompatProps.has_caches flag to avoid useless updates
+     * if user didn't set smp_cache.
+     */
+    if (!x86_cpu_update_smp_cache_topo(ms, cpu, errp)) {
+        return;
+    }
+
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-- 
2.48.1



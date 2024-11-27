Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9105D6ACD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIY6-0003fR-SB; Wed, 27 Nov 2024 08:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIY3-0003em-DX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIY1-0007iI-N6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3wEkJJcev47yGejLPspLgvfrlRtXLqP/wDtBuhCwFs=;
 b=SgZgwPorDo6dOKUaG6FgfuQU9b97b5a+jC3IWyJzyO7WWzdRACIZCRDicRHI7cNGryeObu
 y9T7XPhcqLl1QnbU7kp6TLnp9kQu+z2hZM8dZgOVCH7rYTQagy0HjtVPXrkbTsmWgoybA1
 HtU+v3wha3TN+DGW63HGKkYrCOhT4U0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aJiqfwVIOvKZfVwO0TSo_w-1; Wed, 27 Nov 2024 08:57:39 -0500
X-MC-Unique: aJiqfwVIOvKZfVwO0TSo_w-1
X-Mimecast-MFC-AGG-ID: aJiqfwVIOvKZfVwO0TSo_w
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-382450d158fso3295797f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715858; x=1733320658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3wEkJJcev47yGejLPspLgvfrlRtXLqP/wDtBuhCwFs=;
 b=UWC1fbFJdx6YJVW5cNtWvz6WH0TVLq2YLa977NDPD56iuqlU9/0gisTquY0AYncK9V
 lcIxnwRNrGYBu2VPAl+M/QDvmWWCKBNfAgdDQN7mGI+7SY+yqW6qZgVbuum8oAiSNF1f
 jK14j2FI9bWAKkE3tYzwsT4n0HLq9KEnBIrLIawvopr0bp3MkHygy/bGeE6h1f9j20O9
 BpGQimVdbPD6BFIniaTFgSrvsIVr3hq5c6iXNPBvdPX2Gteuqj0SKp9WStHZb5XhyeOX
 c3uDHB1M2yiny0A0j4nvPzCu6xzuDOMYuSwHLa7FRPlAIXp0CgS/EFfAx0yh4RZ9GGr/
 K+zg==
X-Gm-Message-State: AOJu0Yx3KrbZRSyoLP7aaR5L8nOUVkGJBTfz7+T3LkUOBNokY6i3qRA8
 i4LVIUNXMDjR7VaNix7VFJMYSS/wJqBosLm7HvfOq2bBkSxM+iSpNQSOV33k8Cjj38+Tt+qTIac
 Qf6hDimnnt2Jow/AOAqUseceuCtqLPK7Fm0E/UfmN9cEqX5LdM8Qk/GnPXpk8ewnP2DytlBR+bP
 BsVWZm2bwjy0dsT7fl33RLRCykgoPmPGEM
X-Gm-Gg: ASbGncv9OsYvuFkuJv1/5uLhHuNq6kEpX/ON8ziA3KVPh7ekX+jgO7uK0WQVyNVr/l1
 kA+SU73hqfqO0VW2LNGCs+ZwiT552R9GOgu5cKNiMpMG76qFXeT07aeFJa0830bosMMYxKnGV7d
 XpckJAPzG+MmrthJ/QggHA4g1f4LJZ0DIPhjrT/22raxUbkS6xregnZ2hXl2HlfGjvr7KvvpNyG
 5slaKGE9XJXEOy9az3mX4FrhnssCGHTjBULONSmKKUn
X-Received: by 2002:a05:6000:2ae:b0:382:49f3:4f8d with SMTP id
 ffacd0b85a97d-385c6eb698cmr2800773f8f.15.1732715858131; 
 Wed, 27 Nov 2024 05:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8tAWAPAhc356fDV5VV3PpkJqaXk52M8jmEOqJ6EaO1ogjfR/59gUpnWqKc/JcER2BuPSoAg==
X-Received: by 2002:a05:6000:2ae:b0:382:49f3:4f8d with SMTP id
 ffacd0b85a97d-385c6eb698cmr2800737f8f.15.1732715857676; 
 Wed, 27 Nov 2024 05:57:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbeddf4sm16221472f8f.93.2024.11.27.05.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:37 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/13] Revert "hw/acpi: Update ACPI `_STA` method with QOM
 vCPU ACPI Hotplug states"
Message-ID: <cb36e2573a02da2a4d95bae71e4d2f1a746d8ee2.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

This reverts commit bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d
which broke cpu hotplug in x86 after migration to older QEMU

Fixes: bf1ecc8dad606 (w/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20241112170258.2996640-3-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/acpi/cpu.c         | 38 ++++----------------------------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..e7de77dc6d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -159,7 +159,6 @@ struct CPUClass {
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
     bool (*cpu_persistent_status)(CPUState *cpu);
-    bool (*cpu_enabled_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 23443f09a5..9b03b4292e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -50,18 +50,6 @@ void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
     }
 }
 
-static bool check_cpu_enabled_status(DeviceState *dev)
-{
-    CPUClass *k = dev ? CPU_GET_CLASS(dev) : NULL;
-    CPUState *cpu = CPU(dev);
-
-    if (cpu && (!k->cpu_enabled_status || k->cpu_enabled_status(cpu))) {
-        return true;
-    }
-
-    return false;
-}
-
 static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
 {
     uint64_t val = 0;
@@ -75,11 +63,10 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
     cdev = &cpu_st->devs[cpu_st->selector];
     switch (addr) {
     case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
-        val |= check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : 0;
+        val |= cdev->cpu ? 1 : 0;
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
         val |= cdev->fw_remove  ? 16 : 0;
-        val |= cdev->cpu ? 32 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -362,7 +349,6 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
 #define CPU_FW_EJECT_EVENT "CEJF"
-#define CPU_PRESENT       "CPRS"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
@@ -423,9 +409,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
         /* tell firmware to do device eject, write only */
         aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
-        /* 1 if present, read only */
-        aml_append(field, aml_named_field(CPU_PRESENT, 1));
-        aml_append(field, aml_reserved_field(2));
+        aml_append(field, aml_reserved_field(3));
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -455,7 +439,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ctrl_lock = aml_name("%s.%s", cphp_res_path, CPU_LOCK);
         Aml *cpu_selector = aml_name("%s.%s", cphp_res_path, CPU_SELECTOR);
         Aml *is_enabled = aml_name("%s.%s", cphp_res_path, CPU_ENABLED);
-        Aml *is_present = aml_name("%s.%s", cphp_res_path, CPU_PRESENT);
         Aml *cpu_cmd = aml_name("%s.%s", cphp_res_path, CPU_COMMAND);
         Aml *cpu_data = aml_name("%s.%s", cphp_res_path, CPU_DATA);
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
@@ -484,26 +467,13 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         {
             Aml *idx = aml_arg(0);
             Aml *sta = aml_local(0);
-            Aml *ifctx2;
-            Aml *else_ctx;
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
-            ifctx = aml_if(aml_equal(is_present, one));
+            ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                ifctx2 = aml_if(aml_equal(is_enabled, one));
-                {
-                    /* cpu is present and enabled */
-                    aml_append(ifctx2, aml_store(aml_int(0xF), sta));
-                }
-                aml_append(ifctx, ifctx2);
-                else_ctx = aml_else();
-                {
-                    /* cpu is present but disabled */
-                    aml_append(else_ctx, aml_store(aml_int(0xD), sta));
-                }
-                aml_append(ifctx, else_ctx);
+                aml_append(ifctx, aml_store(aml_int(0xF), sta));
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock));
-- 
MST



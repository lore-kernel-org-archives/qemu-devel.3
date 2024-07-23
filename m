Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAC6C52CD8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDFG-0002F9-GU; Tue, 23 Jul 2024 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDF9-0001Rv-7F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDF5-0002OI-4f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QIRNn3AfY79eXuLLx4aGJnafHez/N0jAHeOHCZXedWo=;
 b=iTZAHSVJi+5ETWRGyVkPmBUonF840jWqNMNGOOU3gN9fSZnRUzQVELV/15/cPw/4Hb5IMx
 Cij1td2o56kpkJHSrJMC2FST6ZXtVXzERElf15EMPVbkakBZgO7aKUGh0KLTG0c5Yl04Ng
 LaFsPRHIODC5E1M1eTkSKE0sGO4JB3Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-LrPQlfsLPwWUrdA-6Z3mPw-1; Tue, 23 Jul 2024 06:59:34 -0400
X-MC-Unique: LrPQlfsLPwWUrdA-6Z3mPw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso55069395e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732372; x=1722337172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIRNn3AfY79eXuLLx4aGJnafHez/N0jAHeOHCZXedWo=;
 b=dvcSNJeMxLgMImOAoZhHMgi0h48fNk12PqpL5yuowNMWlpSO93OPt5Iw+K6KhG/g5l
 NptruYCyQfubPeggKLsThh4nBv6FRYOOx6haQpsM70e18K10YTvojsVfsJXyLpXeOW1C
 VlHbGqucJ84TaWGRAlGG278PJtARFqOb9WqlrfYYjy0Kh0A+UfLfDnqzeEpG+ecD4J70
 nO0eZjxi9FBtnCH1lm9HrkdDX8hMZjK8nRBJbJ2+R8SM42hqyfzbbOwVWO5W8Q4SeWM+
 UzSp475YXEXTN9cdfjVcJJaYeYzmaZjEj1er1DrL22KJBneCEqbbRnqtzCrmir4pmyC4
 JiVw==
X-Gm-Message-State: AOJu0Yy1i5dXmJs97wPXEKiADMssJXMIvJyecFVrPmfmJsdSXkp3Ng34
 V7tsZpEvHX6vdymYJagptRICLKKES1kAmgyW6niq3HxgjSmNNLqfquTl3+C+U1wzwpYGiGdKVRd
 rksx700bJtHOQzCRru+81tCUl51ZH9otHgH3E+PUUYm1CDAymF2N6fDgIl/jb5cohEfhCbKn6iK
 poKpt4h2UlXPNbm4B9jcPnP9cBOMiD6A==
X-Received: by 2002:a05:600c:470d:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-427dc52910amr90650355e9.22.1721732372615; 
 Tue, 23 Jul 2024 03:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGecRMxkjpR4Sccdyo7KnsP9n3mM6TbmRpleA3HN3P8Qlb/bddI5UAMH4LbfAI6PL472xf4JQ==
X-Received: by 2002:a05:600c:470d:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-427dc52910amr90649825e9.22.1721732371979; 
 Tue, 23 Jul 2024 03:59:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f1f4c274sm14744815e9.1.2024.07.23.03.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:31 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:59:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Keqian Zhu <zhukeqian1@huawei.com>, Gavin Shan <gshan@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Shaoqin Huang <shahuang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 41/61] hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <efdb43b831efa5e0c8da3d062a1a37325b4a7708.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

CPUs Control device(\\_SB.PCI0) register interface for the x86 arch is IO port
based and existing CPUs AML code assumes _CRS objects would evaluate to a system
resource which describes IO Port address. But on ARM arch CPUs control
device(\\_SB.PRES) register interface is memory-mapped hence _CRS object should
evaluate to system resource which describes memory-mapped base address. Update
build CPUs AML function to accept both IO/MEMORY region spaces and accordingly
update the _CRS object.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-6-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cpu.h |  5 +++--
 hw/acpi/cpu.c         | 17 +++++++++++++----
 hw/i386/acpi-build.c  |  3 ++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index df87b15997..32654dc274 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -63,9 +63,10 @@ typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
                                   GArray *entry, bool force_enabled);
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
-                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
+                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
                     const char *res_root,
-                    const char *event_handler_method);
+                    const char *event_handler_method,
+                    AmlRegionSpace rs);
 
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index cf5e9183e4..5cb60ca8bc 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -338,9 +338,10 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_FW_EJECT_EVENT "CEJF"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
-                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
+                    build_madt_cpu_fn build_madt_cpu, hwaddr base_addr,
                     const char *res_root,
-                    const char *event_handler_method)
+                    const char *event_handler_method,
+                    AmlRegionSpace rs)
 {
     Aml *ifctx;
     Aml *field;
@@ -364,14 +365,22 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_name_decl("_UID", aml_string("CPU Hotplug resources")));
         aml_append(cpu_ctrl_dev, aml_mutex(CPU_LOCK, 0));
 
+        assert((rs == AML_SYSTEM_IO) || (rs == AML_SYSTEM_MEMORY));
+
         crs = aml_resource_template();
-        aml_append(crs, aml_io(AML_DECODE16, io_base, io_base, 1,
+        if (rs == AML_SYSTEM_IO) {
+            aml_append(crs, aml_io(AML_DECODE16, base_addr, base_addr, 1,
                                ACPI_CPU_HOTPLUG_REG_LEN));
+        } else if (rs == AML_SYSTEM_MEMORY) {
+            aml_append(crs, aml_memory32_fixed(base_addr,
+                               ACPI_CPU_HOTPLUG_REG_LEN, AML_READ_WRITE));
+        }
+
         aml_append(cpu_ctrl_dev, aml_name_decl("_CRS", crs));
 
         /* declare CPU hotplug MMIO region with related access fields */
         aml_append(cpu_ctrl_dev,
-            aml_operation_region("PRST", AML_SYSTEM_IO, aml_int(io_base),
+            aml_operation_region("PRST", rs, aml_int(base_addr),
                                  ACPI_CPU_HOTPLUG_REG_LEN));
 
         field = aml_field("PRST", AML_BYTE_ACC, AML_NOLOCK,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f4e366f64f..5d4bd2b710 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1536,7 +1536,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
         };
         build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
-                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
+                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02",
+                       AML_SYSTEM_IO);
     }
 
     if (pcms->memhp_io_base && nr_mem) {
-- 
MST



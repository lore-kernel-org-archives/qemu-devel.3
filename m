Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D4BD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84KI-0001oS-8D; Mon, 04 Nov 2024 16:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KF-0001Vc-K0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84KD-0005Xr-QY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLaTzrMhNeOuVYzVJLMqDji715fEATJsG7TwuJVQHzY=;
 b=IlnawCeRB+Y2V+dPw3+O2Y6hOIVdPNAVqF/iMmauKoCwiux8gQlyZoqAbxfMeybPb947Qz
 on1U5+gYNKvxV+N0AY1FO7cnB3lj8t4eXWunvlTRQG+Ryskpn3g9yEN53IG0W6LeqezKQo
 VowwsnUEagKlxwxeN62Dwj6UY+CVpOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-FFsV4wD_NXqn86kzP5_LUA-1; Mon, 04 Nov 2024 16:09:24 -0500
X-MC-Unique: FFsV4wD_NXqn86kzP5_LUA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso2149642f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754562; x=1731359362;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLaTzrMhNeOuVYzVJLMqDji715fEATJsG7TwuJVQHzY=;
 b=SgzVXRYpr24srfiYvwc9VcAXp+g7nwX5GyD93L9syVQknTN1GpY8BaJktUgcoAwr3j
 ZwWKGyyO6g3YLSzyloQjWQYXFLeNI6qMQfJeL4KLMdzVdljXDSWsLP2EI19pcnLPvWV3
 KgD0J7SRTW+BfsE3IuWz/lkO4I+b4UBWSu/5CQyeKbXQvCrx+E1UKHx8/dyinxDAivEl
 RPjOj2/3sYKLmnPbWtXhvKm47dkZJfOqElQwNI6gjg6yUlct5dFTzJQPyyA8vI0ddjLn
 +kJ409zY9Yh6Dr4VBCqcxZouS0rgXTZ1XIHceBbWZhlkPlDngplj9OHGkF1ukYUob5RW
 MJmQ==
X-Gm-Message-State: AOJu0YyCgHI0nd3QWYKfErHIGjnkTpH3wJHek/YQ/Qimv4b99lUpP1bR
 KyKVafNEGDbT/uPokWtDN+hyoSoTC3pbLAHg/XzBMy1fa7PEPQXwSsHDtemYgGTD4ozx51ZV+Ax
 Qs24ZLQUD2+ljfZkJ4vJ9JW5rBUWtgTjUIYFE4QSOsYt8SLjIlyeHDpynbR2aNPH5g3KPvqO1d9
 34iCjCHmTI9Rd8m8MNFfBdnb7eM4AQow==
X-Received: by 2002:adf:e5c4:0:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-38061137468mr22927333f8f.22.1730754562330; 
 Mon, 04 Nov 2024 13:09:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh6uGQg4sQjiRH2nm7vI8Z5aVu33rNI9xMT59ovapS4OR54xYyDqW4DhCGdADN62lWtWNDXQ==
X-Received: by 2002:adf:e5c4:0:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-38061137468mr22927311f8f.22.1730754561836; 
 Mon, 04 Nov 2024 13:09:21 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49dfsm14197412f8f.46.2024.11.04.13.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:21 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 58/65] hw/acpi: Make CPUs ACPI `presence` conditional during
 vCPU hot-unplug
Message-ID: <2d6cfbaf174b91dfa9a50065f7494634afb39c23.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Salil Mehta <salil.mehta@huawei.com>

On most architectures, during vCPU hot-plug and hot-unplug actions, the
firmware or VMM/QEMU can update the OS on vCPU status by toggling the
ACPI method `_STA.Present` bit. However, certain CPU architectures
prohibit [1] modifications to a CPU’s `presence` status after the kernel
has booted.

This limitation [2][3] exists because many per-CPU components, such as
interrupt controllers and various per-CPU features tightly integrated
with CPUs, may not support reconfiguration once the kernel is
initialized. Often, these components cannot be powered down, as they may
belong to an `always-on` power domain. As a result, some architectures
require all CPUs to remain `_STA.Present` after system initialization.

Therefore, it is essential to mirror the exact QOM vCPU status through
ACPI for the Guest kernel. For this, we should determine—via
architecture-specific code[4]—whether vCPUs must always remain present
and whether the associated `AcpiCpuStatus::cpu` object should remain
valid, even following a vCPU hot-unplug operation.

References:
[1] Check comment 5 in the bugzilla entry
    Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
[2] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
    architectures that don’t Support CPU Hotplug (like ARM64)
    a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
    b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
[3] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
    SoC Based Systems (like ARM64)
    Link: https://kvmforum2020.sched.com/event/eE4m
[4] Example implementation of architecture-specific CPU persistence hook
    Link: https://github.com/salil-mehta/qemu/commit/c0b416b11e5af6505e558866f0eb6c9f3709173e

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Message-Id: <20241103102419.202225-2-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/core/cpu.h |  1 +
 hw/acpi/cpu.c         | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb..e7de77dc6d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -158,6 +158,7 @@ struct CPUClass {
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
+    bool (*cpu_persistent_status)(CPUState *cpu);
     void (*set_pc)(CPUState *cpu, vaddr value);
     vaddr (*get_pc)(CPUState *cpu);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..9b03b4292e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -233,6 +233,17 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
 }
 
+static bool should_remain_acpi_present(DeviceState *dev)
+{
+    CPUClass *k = CPU_GET_CLASS(dev);
+    /*
+     * A system may contain CPUs that are always present on one die, NUMA node,
+     * or socket, yet may be non-present on another simultaneously. Check from
+     * architecture specific code.
+     */
+    return k->cpu_persistent_status && k->cpu_persistent_status(CPU(dev));
+}
+
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
     CPUClass *k = CPU_GET_CLASS(dev);
@@ -289,7 +300,9 @@ void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
         return;
     }
 
-    cdev->cpu = NULL;
+    if (!should_remain_acpi_present(dev)) {
+        cdev->cpu = NULL;
+    }
 }
 
 static const VMStateDescription vmstate_cpuhp_sts = {
-- 
MST



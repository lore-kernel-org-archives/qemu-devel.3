Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BD5FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80b-0003W6-I1; Fri, 13 Sep 2024 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp807-0001zm-Ho
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp805-0007n0-Er
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so20056285e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240460; x=1726845260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B84tOEz4iH8LzYCOElAIMYy1A32McFCI6tkMUnYQHUs=;
 b=CKy+JZUhmxtRlXHTpGSy8oO67eNKil+lS5mKBg1JGkmsVmgmL5j67h+3SirnGDgf/E
 w6FeJ4ctPFLm+taWCO4qvNwhgMYTZAjrW3N2FQQb6LSWUQgUmhXKdX9ch3+Sz5jyjimP
 zykRIaY0v6/iDW9vZmwdCM7fonybaOkeq8fXkd6UFnbBi1jm5UClgVgCUL9XE/wBhDmA
 5oqiZ0KbIOlFXz4LAYKRU3/BLbXqgA0XWNh+IAmqHkjYVdXMHjgTN/YUgQSqh523NYTU
 QdRIr4wEkptamXs6WpYOsJ7yEShUWmgsCmgfCLpa4z9fgrru8FDseOVQrvEQL2LLoWR8
 xb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240460; x=1726845260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B84tOEz4iH8LzYCOElAIMYy1A32McFCI6tkMUnYQHUs=;
 b=OjknKdbm79uUge+01tVsu95a3QvXU3HmWPSS3Mz7zKK0s47gPYOoxcTSxH9/uYf8GL
 4eMNGCYpDzM/iPFXttYOrJTj55s6wUGXEL1WkWJUYsWarLH3vg3AlOGLPed/r1xwptVY
 C+XbTphlUaoDhH5q6Bcmdjmem6sQktTS1zEDyf/jPJVjS6sJWE7i5xaCrWQfUWangkrK
 tpHIJ9gDVOwa6KlQacBIrdeehawf4MiI5dK4726QZExGyo0yyhiazoH3BJPibU7tVp7I
 +kLXSkne2c8PK7yREfhECKpeuiynMkufXWT1QUAST2OfiiHGfXsmPLFXeeqxvL6NlUka
 1DBw==
X-Gm-Message-State: AOJu0YwojZmZ4lmQRvqB3xGbLWlucMkL0Gdc2UC89hbrx1aHTjG5DRCX
 oFgKKV9w5Zmi+5KpuOJhQdNxv2BcQHle04sHa9RH9JCxfh09ckC4rPOzkoX52AsNsLCaAYzVtyz
 K
X-Google-Smtp-Source: AGHT+IEnnqptfmbNcUW3PsqlmGUjyPzKjI7BZzVGu2otH22KYdljGPDpY9kaDeNBfYYebpqvYWUMpw==
X-Received: by 2002:a05:600c:1d1c:b0:42c:b22e:fc3e with SMTP id
 5b1f17b1804b1-42cdb54c2f3mr57650205e9.15.1726240459821; 
 Fri, 13 Sep 2024 08:14:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/27] hw/boards: Add hvf_get_physical_address_range to
 MachineClass
Date: Fri, 13 Sep 2024 16:13:57 +0100
Message-Id: <20240913151411.2167922-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Danny Canter <danny_canter@apple.com>

This addition will be necessary for some HVF related work to follow.
For HVF on ARM there exists a set of APIs in macOS 13 to be able to
adjust the IPA size for a given VM. This is useful as by default HVF
uses 36 bits as the IPA size, so to support guests with > 64GB of RAM
we'll need to reach for this.

To have all the info necessary to carry this out however, we need some
plumbing to be able to grab the memory map and compute the highest GPA
prior to creating the VM. This is almost exactly like what kvm_type is
used for on ARM today, and is also what this will be used for. We will
compute the highest GPA and find what IPA size we'd need to satisfy this,
and if it's valid (macOS today caps at 40b) we'll set this to be the IPA
size in coming patches. This new method is only needed (today at least)
on ARM, and obviously only for HVF/macOS, so admittedly it is much less
generic than kvm_type today, but it seemed a somewhat sane way to get
the information we need from the memmap at VM creation time.

Signed-off-by: Danny Canter <danny_canter@apple.com>
Message-id: 20240828111552.93482-2-danny_canter@apple.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: removed explicit setting of field to NULL on x86]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h | 5 +++++
 hw/arm/virt.c       | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9a492770cbb..ff25c53671f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -215,6 +215,10 @@ typedef struct {
  *    Return the type of KVM corresponding to the kvm-type string option or
  *    computed based on other criteria such as the host kernel capabilities.
  *    kvm-type may be NULL if it is not needed.
+ * @hvf_get_physical_address_range:
+ *    Returns the physical address range in bits to use for the HVF virtual
+ *    machine based on the current boards memory map. This may be NULL if it
+ *    is not needed.
  * @numa_mem_supported:
  *    true if '--numa node.mem' option is supported and false otherwise
  * @hotplug_allowed:
@@ -256,6 +260,7 @@ struct MachineClass {
     void (*reset)(MachineState *state, ShutdownCause reason);
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
+    int (*hvf_get_physical_address_range)(MachineState *machine);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7934b236516..d284a602e82 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2111,7 +2111,8 @@ static void machvirt_init(MachineState *machine)
 
     /*
      * In accelerated mode, the memory map is computed earlier in kvm_type()
-     * to create a VM with the right number of IPA bits.
+     * for Linux, or hvf_get_physical_address_range() for macOS to create a
+     * VM with the right number of IPA bits.
      */
     if (!vms->memmap) {
         Object *cpuobj;
@@ -3031,6 +3032,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     return fixed_ipa ? 0 : requested_pa_size;
 }
 
+static int virt_hvf_get_physical_address_range(MachineState *ms)
+{
+    return 0;
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -3090,6 +3096,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->valid_cpu_types = valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
+    mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
-- 
2.34.1



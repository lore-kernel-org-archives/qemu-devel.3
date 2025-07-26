Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5057AC87FCA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 17:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufiJf-0002zc-TW; Sat, 26 Jul 2025 13:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ufiHD-0001nU-P3
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 13:01:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ufiHB-0000pT-Eo
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 13:01:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so4195105ad.2
 for <qemu-devel@nongnu.org>; Sat, 26 Jul 2025 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753549294; x=1754154094; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8o/hDLEr8mUgOt0ZGZLmOGoGk0JwTQovCF4wYoVGLuk=;
 b=mHME8T6jaeLI585ZbimMYLrPHR/BOU7p0piQfubAiU7xBFNXtpPc+bRNl+gBNRbWwq
 CW6xHXTtmb1rfmw7N5DK8pREyg5M9XCDJ5NZO0TFvlWAInEDYBnt4lNOxPNcAcGhhIX0
 YlG+hKdQQFG7DGnMABW1uetbjRms50FOtRz05f2XV6neBOHs5oYGTmJFoIPhtZzWewx9
 o5FxiGt4XzMMULe0V8D0a4BAm/YYgpsSuWfEShsPDSq+Xse5efw7Ak4sIh5cbw/GOdif
 7qCQKq/vFb1Nbl9vuqGDyMBBQ9RiU5/kczc5TRfp/TiTjhLpfOOhvnEaYyGge2FcDTCP
 xLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753549294; x=1754154094;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8o/hDLEr8mUgOt0ZGZLmOGoGk0JwTQovCF4wYoVGLuk=;
 b=dQD5SXZmyAIqvo7c5aK13jvfWcnf7JaHjynwaImTxFONIR1+7OUN25eUFTv4qctkyg
 58GA1vCmA+4EqHBbQ1wGgJFuKNEUwG79V3Ib4JXiE3MiU/bVUOucvG51xXleWjT+1DEb
 ildLKYY8fDVIt7+9jgt5h83wp8zDP4kiC96bUp7SVeJNN9rjCcpmh0RkYaMpwTztecwT
 5Vc1gnbVH1cRVMWbYUOa8AzW4U1OZ+zNXRU7BHR+zcFPMH3pY2FKYvILsJWUmRdOuliW
 17Mb4Tn1N9wtISF4sLT2INLVW7AVPwgZf3bKsa5bW0h6Po/Fev810psXbZrP98tAJvzj
 FxZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6b4cjhebNL1fK6JorqkxdW32ca50hvBdsS1x0tx3Hy6o2UrAxwQTLRS9cX9qEHwD8Zd8bLH8rPXwM@nongnu.org
X-Gm-Message-State: AOJu0YwtYZxMiq/GDI88iv13MnDNNrzPi3Ta4lBMXpXL1DuCt3DC0kch
 hrAxFM1Z7VgvxuBcwm3wD9lpsmUkfV2aIP/v2ARSFMRjXvEuUIIJFROs
X-Gm-Gg: ASbGncv+SvW6pgkAhbXTtFiHbX5fWrqI6qsnh+bzw9FSItlFaC45TyG94OIIiAy2zpJ
 Tt07wLFMEHFGWpQ+AWRveITOGDQQ6enG1AOQg9UmfDxDiVPSsjfj70jSBbkjD1B0Mi1dwtsOMpV
 Xz7zBAmqgS27v0/gJhi5Jxfo5iirSuBzL8O9UahTd9mE0f1ajcPxmqOOKuGFPnxAUfZ2L5Hzua6
 kLYEBJdTPmFt8shqkUz5RMxdKRb9BYxRzPFOYtBTaw07/D0ca52UEyfDtPh/Wyfq2o+nmmH95lm
 0003J/15CGe2x71maXkDHMKiBJC5yNdZYJejp7bptuqW7izt/Pwhw01EfKvy63upB4EF4fX4RhC
 zNK4TFte7S/y5jodFSIzQG1c50UjvuP4z5Cc=
X-Google-Smtp-Source: AGHT+IGlegXpjgdJaL8nFWyXsI1WkXCMWteF5yj3D6ktWNdpCVJh1NBnt5d2ExeSsXkFB0x1yljJjQ==
X-Received: by 2002:a17:903:22c9:b0:236:9726:7261 with SMTP id
 d9443c01a7336-23fb30dfd0cmr84719225ad.39.1753549294103; 
 Sat, 26 Jul 2025 10:01:34 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:6456:3d83:7c59:6543])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe329898sm20326575ad.46.2025.07.26.10.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jul 2025 10:01:33 -0700 (PDT)
Date: Sat, 26 Jul 2025 10:01:30 -0700
From: Fan Ni <nifan.cxl@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: peng guo <engguopeng@buaa.edu.cn>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, wyguopeng@163.com
Subject: Re: [PATCH] hw/i386/pc: Avoid overlap between CXL window and PCI
 64bit BARs in QEMU
Message-ID: <aIUJ6jyd3oCXbzQi@lg>
References: <20250718133545.5261-1-engguopeng@buaa.edu.cn>
 <20250725145337.00003c91@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725145337.00003c91@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 25, 2025 at 02:53:37PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Jul 2025 21:35:45 +0800
> peng guo <engguopeng@buaa.edu.cn> wrote:
> 
> > When using a CXL Type 3 device together with a virtio 9p device in QEMU, the
> > 9p device fails to initialize properly. The kernel reports the following:
> > 
> >     virtio: device uses modern interface but does not have VIRTIO_F_VERSION_1
> >     9pnet_virtio virtio0: probe with driver 9pnet_virtio failed with error -22
> > 
> > Further investigation revealed that the 64-bit BAR space assigned to the 9pnet
> > device was overlapped by the memory window allocated for the CXL devices. As a
> > result, the kernel could not correctly access the BAR region, causing the
> > virtio device to malfunction.
> > 
> > An excerpt from /proc/iomem shows:
> > 
> >     480010000-cffffffff : CXL Window 0
> >       480010000-4bfffffff : PCI Bus 0000:00
> >       4c0000000-4c01fffff : PCI Bus 0000:0c
> >         4c0000000-4c01fffff : PCI Bus 0000:0d
> >       4c0200000-cffffffff : PCI Bus 0000:00
> >         4c0200000-4c0203fff : 0000:00:03.0
> >           4c0200000-4c0203fff : virtio-pci-modern
> > 
> > To address this issue, this patch uses the value of `cxl_resv_end` to reserve
> > sufficient address space and ensure that CXL memory windows are allocated
> > beyond all PCI 64-bit BARs. This prevents overlap with 64-bit BARs regions such 
> > as those used by virtio or other pcie devices, resolving the conflict.
> > 
> > QEMU Build Configuration:
> > 
> >     ./configure --prefix=/home/work/qemu_master/build/ \
> >                 --target-list=x86_64-softmmu \
> >                 --enable-kvm \
> >                 --enable-virtfs
> > 
> > QEMU Boot Command:
> > 
> >     sudo /home/work/qemu_master/qemu/build/qemu-system-x86_64 \
> >         -nographic -machine q35,cxl=on -enable-kvm -m 16G -smp 8 \
> >         -hda /home/work/gp_qemu/rootfs.img \
> >         -virtfs local,path=/home/work/gp_qemu/share,mount_tag=host0,security_model=passthrough,id=host0 \
> >         -kernel /home/work/linux_output/arch/x86/boot/bzImage \
> >         --append "console=ttyS0 crashkernel=256M root=/dev/sda rootfstype=ext4 rw loglevel=8" \
> >         -object memory-backend-ram,id=vmem0,share=on,size=4096M \
> >         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >         -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> >         -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0,sn=0x123456789 \
> >         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> > 
> > Tested in a QEMU setup with a CXL Type 3 device and a 9pnet virtio device.
> > 
> > Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
> Analysis looks good.
> 
> For the patch I wonder if we should match the check that follows
> for pcms->cxl_devices_state.is_enabled rather than checking cxl_resv_end
> (which is only set to non 0 if that is_enabled is set).
> 
> Probably better to use a consistent condition for checking if CXL is
> there or not.
> 
> We also ideally need a suitable fixes tag.  I couldn't immediately find one
> so maybe it goes a long way back.

FYI. Commit histroy related to the line changed,


commit 78732a765986d5270d6b3d88afeb9e4d33092360
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jun 23 14:45:49 2023 +0200

    hw/i386/pc: Use machine_memory_devices_init()

    Let's use our new helper and stop always allocating ms->device_memory.
    Once allcoated, we're sure that the size > 0 and that the base was
    initialized.

    Adjust the code in pc_memory_init() to check for machine->device_memory
    instead of pcmc->has_reserved_memory and machine->device_memory->base.

    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Cc: Richard Henderson <richard.henderson@linaro.org>
    Cc: Eduardo Habkost <eduardo@habkost.net>
    Cc: "Michael S. Tsirkin" <mst@redhat.com>
    Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
    Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
    Acked-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20230623124553.400585-7-david@redhat.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1123,1 +1116,1 @@
-    if (pcmc->has_reserved_memory && machine->device_memory->base) {
+    if (machine->device_memory) {

commit b0c14ec4efe912ae6f14a4802574f7b6b6db0648
Author: David Hildenbrand <david@redhat.com>
Date:   Mon Apr 23 18:51:17 2018 +0200

    machine: make MemoryHotplugState accessible via the machine

    Let's allow to query the MemoryHotplugState directly from the machine.
    If the pointer is NULL, the machine does not support memory devices. If
    the pointer is !NULL, the machine supports memory devices and the
    data structure contains information about the applicable physical
    guest address space region.

    This allows us to generically detect if a certain machine has support
    for memory devices, and to generically manage it (find free address
    range, plug/unplug a memory region).

    We will rename "MemoryHotplugState" to something more meaningful
    ("DeviceMemory") after we completed factoring out the pc-dimm code into
    MemoryDevice code.

    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20180423165126.15441-3-david@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    [ehabkost: rebased series, solved conflicts at spapr.c]
    [ehabkost: squashed fix to use g_malloc0()]
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1432,1 +1435,1 @@
-    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {
+    if (pcmc->has_reserved_memory && machine->device_memory->base) {

commit bb292f5a9b944e47fae88a20767967e7e20122b4
Author: Eduardo Habkost <ehabkost@redhat.com>
Date:   Fri Dec 11 16:42:28 2015 -0200

    pc: Remove compat fields from PcGuestInfo

    Remove the fields: legacy_acpi_table_size, has_acpi_build,
    has_reserved_memory, and rsdp_in_ram from PcGuestInfo, and let
    the existing code use the PCMachineClass fields directly.

    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1385,1 +1385,1 @@
-    if (guest_info->has_reserved_memory && pcms->hotplug_memory.base) {
+    if (pcmc->has_reserved_memory && pcms->hotplug_memory.base) {

commit a7d69ff10b085ba6f8236600829532984cdea714
Author: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date:   Mon Jun 29 13:50:22 2015 +0530

    pc,pc-dimm: Extract hotplug related fields in PCMachineState to a structure

    Move hotplug_memory_base and hotplug_memory fields of PCMachineState
    into a separate structure so that the same can be made use of from
    other architectures supporing memory hotplug.

    Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
    Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
    Tested-by: Igor Mammedov <imammedo@redhat.com>
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1336,1 +1336,1 @@
-    if (guest_info->has_reserved_memory && pcms->hotplug_memory_base) {
+    if (guest_info->has_reserved_memory && pcms->hotplug_memory.base) {

commit de268e134c03612970d6f2c214df6287c9621cc8
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Mon Jun 2 15:25:10 2014 +0200

    pc: add 'etc/reserved-memory-end' fw_cfg interface for SeaBIOS

    'etc/reserved-memory-end' will allow QEMU to tell BIOS where PCI
    BARs mapping could safely start in high memory.

    Allowing BIOS to start mapping 64-bit PCI BARs at address where it
    wouldn't conflict with other mappings QEMU might place before it.

    That permits QEMU to reserve extra address space before
    64-bit PCI hole for memory hotplug.

    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
    Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1269,0 +1270,1 @@
+    if (guest_info->has_reserved_memory && pcms->hotplug_memory_base) {


Fan

> 
> > ---
> >  hw/i386/pc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2f58e73d3347..180bc615f3f0 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -975,7 +975,7 @@ void pc_memory_init(PCMachineState *pcms,
> >  
> >      rom_set_fw(fw_cfg);
> >  
> > -    if (machine->device_memory) {
> > +    if (machine->device_memory || cxl_resv_end) {
> >          uint64_t *val = g_malloc(sizeof(*val));
> >          uint64_t res_mem_end;
> >  
> 

-- 
Fan Ni


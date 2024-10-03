Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E49CF34BA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 16:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOTe-0003CX-OJ; Thu, 03 Oct 2024 12:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swOTc-0003CF-8K
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swOTY-0000Xt-Op
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727972086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ec+R/cjZzwi8GXhdcRCHDPCcznQU0X34ApQASaY63sQ=;
 b=A/w1K4O071GJ5U6Djlh50jagxv9qiNeYC1wZYunrE44nKsZqlZrXeuZJ3XQ0SzLUoxGa/5
 JXBvOTXqlYB92P8fMZKJor+QelP/mZVqlo6PBQXoLzswoOxrqtL3p5M0k/szhY/IzUK7nD
 aPq2nXsvWvUJCwSS//pWCgDipsDokKU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-U-FlIfJ8Px-PT2qnIrAr_w-1; Thu, 03 Oct 2024 12:14:43 -0400
X-MC-Unique: U-FlIfJ8Px-PT2qnIrAr_w-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-20b4efbb863so11112635ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 09:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727972082; x=1728576882;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ec+R/cjZzwi8GXhdcRCHDPCcznQU0X34ApQASaY63sQ=;
 b=E0Pv94O1M41iNlR3R9upPp+guO/7YTI+XKogE6Y01pLek6bEayBLTX3wVTnbAV4No7
 euABYOnp6WP3WVlXEcVrBJn5hWX+Ap7NLXOkEjl+ORzq2VeOqfWb2GV0BQI5Q/SKNtm3
 mjuxHSoSO2nUmso2f5jWCJF8MGUP4qRxwYA0sw1etWNrgSmDxuX2nNV+ZVXIv9o2MN07
 Hh9gJQB+w19v0JCeMqFHFBfUoNAONBewfg/VFbEtnKmptd3hYoH2TS4pVnsQ4kdOhqlV
 /rvE8YBZ/Cr/Ev5JyUlazdcMQ98dDcEsuWA3WIQX0eDEUWf6aQBlXydRDYIgWc0k55YN
 iuQw==
X-Gm-Message-State: AOJu0YzOw/+0R2iETJ/ml5YLytYRG4fYz5qj7ITB6HCC4NbyHf0LoqqH
 K7DnewpBkAb0S9HCLv5O6AmhHYwRt9t0AvZFKZL+Wdqkrg4ggeV7shLZ7oiMZpAWQ2RCpi4YhSo
 xkRGH7Dt0xykLHqjE1GVHGBjW82x/zqiB9ytQMJLR00qUufXKhrOA
X-Received: by 2002:a17:902:ce8f:b0:20b:68ec:6026 with SMTP id
 d9443c01a7336-20bc5a1940amr68955945ad.34.1727972082295; 
 Thu, 03 Oct 2024 09:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEON5W5Q2oqx4C2axW1v24Z8Ww14Ex8TOq49WbIObuaYhnQ6EZCBqVuK662XQxKW8vy8y8mmQ==
X-Received: by 2002:a17:902:ce8f:b0:20b:68ec:6026 with SMTP id
 d9443c01a7336-20bc5a1940amr68955665ad.34.1727972081856; 
 Thu, 03 Oct 2024 09:14:41 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beefafc76sm10522915ad.208.2024.10.03.09.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 09:14:40 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:14:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
Message-ID: <Zv7C7MeVP2X8bEJU@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> on the value of the anon-alloc machine property.  This option applies to
> memory allocated as a side effect of creating various devices. It does
> not apply to memory-backend-objects, whether explicitly specified on
> the command line, or implicitly created by the -m command line option.
> 
> The memfd option is intended to support new migration modes, in which the
> memory region can be transferred in place to a new QEMU process, by sending
> the memfd file descriptor to the process.  Memory contents are preserved,
> and if the mode also transfers device descriptors, then pages that are
> locked in memory for DMA remain locked.  This behavior is a pre-requisite
> for supporting vfio, vdpa, and iommufd devices with the new modes.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[Igor seems missing in the loop; added]

> ---
>  hw/core/machine.c   | 19 +++++++++++++++++++
>  include/hw/boards.h |  1 +
>  qapi/machine.json   | 14 ++++++++++++++
>  qemu-options.hx     | 11 +++++++++++
>  system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
>  system/trace-events |  3 +++
>  6 files changed, 83 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index adaba17..a89a32b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
>      ms->mem_merge = value;
>  }
>  
> +static int machine_get_anon_alloc(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->anon_alloc;
> +}
> +
> +static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->anon_alloc = value;
> +}
> +
>  static bool machine_get_usb(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> @@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "mem-merge",
>          "Enable/disable memory merge support");
>  
> +    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
> +                                   &AnonAllocOption_lookup,
> +                                   machine_get_anon_alloc,
> +                                   machine_set_anon_alloc);
> +
>      object_class_property_add_bool(oc, "usb",
>          machine_get_usb, machine_set_usb);
>      object_class_property_set_description(oc, "usb",
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 5966069..5a87647 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -393,6 +393,7 @@ struct MachineState {
>      bool enable_graphics;
>      ConfidentialGuestSupport *cgs;
>      HostMemoryBackend *memdev;
> +    AnonAllocOption anon_alloc;
>      /*
>       * convenience alias to ram_memdev_id backend memory region
>       * or to numa container memory region
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795..d4a63f5 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1898,3 +1898,17 @@
>  { 'command': 'x-query-interrupt-controllers',
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ]}
> +
> +##
> +# @AnonAllocOption:
> +#
> +# An enumeration of the options for allocating anonymous guest memory.
> +#
> +# @mmap: allocate using mmap MAP_ANON
> +#
> +# @memfd: allocate using memfd_create
> +#
> +# Since: 9.2
> +##
> +{ 'enum': 'AnonAllocOption',
> +  'data': [ 'mmap', 'memfd' ] }
> diff --git a/qemu-options.hx b/qemu-options.hx
> index d94e2cb..90ab943 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>      "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>      "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> +    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>      QEMU_ARCH_ALL)
> @@ -101,6 +102,16 @@ SRST
>          Enables or disables ACPI Heterogeneous Memory Attribute Table
>          (HMAT) support. The default is off.
>  
> +    ``anon-alloc=mmap|memfd``
> +        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
> +        or memfd_create.  This option applies to memory allocated as a
> +        side effect of creating various devices. It does not apply to
> +        memory-backend-objects, whether explicitly specified on the
> +        command line, or implicitly created by the -m command line
> +        option.
> +
> +        Some migration modes require anon-alloc=memfd.
> +
>      ``memory-backend='id'``
>          An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
>          Allows to use a memory backend as main RAM.
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a..174f7e0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -47,6 +47,7 @@
>  #include "qemu/qemu-print.h"
>  #include "qemu/log.h"
>  #include "qemu/memalign.h"
> +#include "qemu/memfd.h"
>  #include "exec/memory.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
> @@ -69,6 +70,8 @@
>  
>  #include "qemu/pmem.h"
>  
> +#include "qapi/qapi-types-migration.h"
> +#include "migration/options.h"
>  #include "migration/vmstate.h"
>  
>  #include "qemu/range.h"
> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                  qemu_mutex_unlock_ramlist();
>                  return;
>              }
> +
> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
> +                                        TYPE_MEMORY_BACKEND)) {

This is pretty fragile.. if someone adds yet another layer on top of memory
backend objects, the ownership links can change and this might silently run
into something else even without any warning..

I wished we dig into what is missing, but maybe that's too trivial.  If
not, we still need to make this as solid.  Perhaps that can be a ram flag
and let relevant callers pass in that flag explicitly.

I think RAM_SHARED can actually be that flag already - I mean, in all paths
that we may create anon mem (but not memory-backend-* objects), is it
always safe we always switch to RAM_SHARED from anon?

And that should also make sure that _if_ that path can already have an
optional RAM_SHARED flag passed in, it means we did something wrong,
because such change should not violate with whatever the user can specify
share=on/off.  It means nothing user specified would be violated.

I think that means below paths [1-4] are only relevant:

qemu_ram_alloc
    memory_region_init_rom_device_nomigrate [1]
    memory_region_init_ram_flags_nomigrate
        memory_region_init_ram_nomigrate    [2]
        memory_region_init_rom_nomigrate    [3]
qemu_ram_alloc_resizeable                   [4]

So I wonder whether we can have a patch simply switching [1-4] to
constantly use VM_SHARED; I assume they're all corner case allocations:
they never include major guest memory, but things like vram, etc.

I feel like that's fine, I think it should even work with migration where
an old QEMU with all such memory chunks being anon, be migrated to a new
QEMU where such memory chunks being all memfd.  Fundamentally it should
work as qemu migration relies on host pointer not anything else IIRC.
Worth double check, some migration test could also be useful if something
obvious I overlook.  Nothing yet I spot will go wrong.

Then, maybe..  we don't need any new machine type property?

> +            size_t max_length = new_block->max_length;
> +            MemoryRegion *mr = new_block->mr;
> +            const char *name = memory_region_name(mr);
> +
> +            new_block->mr->align = QEMU_VMALLOC_ALIGN;
> +            new_block->flags |= RAM_SHARED;
> +
> +            if (new_block->fd == -1) {
> +                new_block->fd = qemu_memfd_create(name, max_length + mr->align,
> +                                                  0, 0, 0, errp);
> +            }
> +
> +            if (new_block->fd >= 0) {
> +                int mfd = new_block->fd;
> +                qemu_set_cloexec(mfd);
> +                new_block->host = file_ram_alloc(new_block, max_length, mfd,
> +                                                 false, 0, errp);
> +            }
> +            if (!new_block->host) {
> +                qemu_mutex_unlock_ramlist();
> +                return;
> +            }
> +            memory_try_enable_merging(new_block->host, new_block->max_length);

IIUC this can be dropped.  It's destined to be SHARED here, so KSM won't work.

But if you agree with VM_SHARED idea I mentioned above, this chunk of code
is not needed as a whole, instead it'll be two separate patches instead:

  - Make above paths [1-4] constantly use VM_SHARED

  - Change qemu_anon_ram_alloc() path so that it'll cache the fd if VM_SHARED

> +            free_on_error = true;
> +
>          } else {
>              new_block->host = qemu_anon_ram_alloc(new_block->max_length,
>                                                    &new_block->mr->align,
> @@ -1932,6 +1964,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>          ram_block_notify_add(new_block->host, new_block->used_length,
>                               new_block->max_length);
>      }
> +    trace_ram_block_add(memory_region_name(new_block->mr), new_block->flags,
> +                        new_block->fd, new_block->used_length,
> +                        new_block->max_length);
>      return;
>  
>  out_free:
> diff --git a/system/trace-events b/system/trace-events
> index 074d001..4669411 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -47,3 +47,6 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
>  
>  # cpu-throttle.c
>  cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
> +
> +#physmem.c
> +ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
> -- 
> 1.8.3.1
> 

-- 
Peter Xu



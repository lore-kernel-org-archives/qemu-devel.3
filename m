Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A67C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 21:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC47J-0001NV-UF; Tue, 28 May 2024 17:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC47I-0001Mv-5K
 for qemu-devel@nongnu.org; Tue, 28 May 2024 17:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sC47C-0000fU-Sq
 for qemu-devel@nongnu.org; Tue, 28 May 2024 17:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716930732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZCqYKrX9eGj8FAPQaEKyEFTM7tpI+giLDe6H8fhh1M=;
 b=HLtNDIFafR+j70H5jfcAezaiKoPFhoS8ktXdTGDhF9mYzFfxRDYRTZQtEYRlE1TW85xh3q
 b1hR5ymxxi+IuJcC84spNuN3n0zfQVV0voMtfYL1TyZpxaoqTBuSVi2G9d9uwSetbQYVVX
 XsJ1XrChM1H1mmnYxXbem730uwx8a8Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Q7qTRrsTPSyvEpb9H67DPw-1; Tue, 28 May 2024 17:12:07 -0400
X-MC-Unique: Q7qTRrsTPSyvEpb9H67DPw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ad803bc570so3723996d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 14:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716930726; x=1717535526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZCqYKrX9eGj8FAPQaEKyEFTM7tpI+giLDe6H8fhh1M=;
 b=RpnklNr1B+9z9onUsvXnxWMZ2rclYEynDyvWEfyYpDLSqH32fsPS6DpLLtophkvaFN
 g/oalSfyfylMLQCZFAf4g6OUUmsds1NzqdMnbNxn7Dj8S/67BjmXPE7CR/x+oT8es1Pt
 TSC74rrkJlb0GeEPiN6DrzUksd1ognDAjecSL+WWn9shcE2ToeNO+7ASguYKy27jpYO2
 d5zhAVWWqmt5XAYUuGxrSxeBduX497aLxralZueFiKJuRUL7fOrK7tlxS91nb9lIleAV
 K+490aOALAQZBXVr/3WGpVK0aA+eYSWgxngUxJSsqNRBwY4zwULzOO9QuvGINy6gaIQp
 hIww==
X-Gm-Message-State: AOJu0YwXKHp0MBIMW4sEp3Ljz9D7ILEhZTyQKbcocLX6U8tdrqQPScDF
 h9/cT5nnsX50N5vTW98inVAJXAMyaK2igoV6JcpI0nbdi6lKtpkm9M2uzi/VGgyBgLYIhBfttcN
 ZWAVzp7srBiwTTFW09InINJhGfN4BRy/CFR9FdZ488qRISI8H+Z9G
X-Received: by 2002:a05:620a:f14:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-794ab05adc8mr1406533085a.1.1716930726193; 
 Tue, 28 May 2024 14:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmKpsQEiT6X7poOklZ/Io9kOlzovfkUwlWk9rsTwv207PxNwzM68W1Fc7bny9n68w+ShUqLQ==
X-Received: by 2002:a05:620a:f14:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-794ab05adc8mr1406528585a.1.1716930725422; 
 Tue, 28 May 2024 14:12:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abca6428sm413880685a.3.2024.05.28.14.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 14:12:05 -0700 (PDT)
Date: Tue, 28 May 2024 17:12:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <ZlZIoiH5Dj4XBbLO@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Apr 29, 2024 at 08:55:26AM -0700, Steve Sistare wrote:
> Allocate anonymous memory using memfd_create if the memfd-alloc machine
> option is set.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/core/machine.c   | 22 ++++++++++++++++++++++
>  include/hw/boards.h |  1 +
>  qemu-options.hx     |  6 ++++++
>  system/memory.c     |  9 ++++++---
>  system/physmem.c    | 18 +++++++++++++++++-
>  system/trace-events |  1 +
>  6 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 582c2df..9567b97 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -443,6 +443,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
>      ms->mem_merge = value;
>  }
>  
> +static bool machine_get_memfd_alloc(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return ms->memfd_alloc;
> +}
> +
> +static void machine_set_memfd_alloc(Object *obj, bool value, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    ms->memfd_alloc = value;
> +}
> +
>  static bool machine_get_usb(Object *obj, Error **errp)
>  {
>      MachineState *ms = MACHINE(obj);
> @@ -1044,6 +1058,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_set_description(oc, "mem-merge",
>          "Enable/disable memory merge support");
>  
> +    object_class_property_add_bool(oc, "memfd-alloc",
> +        machine_get_memfd_alloc, machine_set_memfd_alloc);
> +    object_class_property_set_description(oc, "memfd-alloc",
> +        "Enable/disable allocating anonymous memory using memfd_create");
> +
>      object_class_property_add_bool(oc, "usb",
>          machine_get_usb, machine_set_usb);
>      object_class_property_set_description(oc, "usb",
> @@ -1387,6 +1406,9 @@ static bool create_default_memdev(MachineState *ms, const char *path, Error **er
>      if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
>          goto out;
>      }
> +    if (!object_property_set_bool(obj, "share", ms->memfd_alloc, errp)) {
> +        goto out;
> +    }
>      object_property_add_child(object_get_objects_root(), mc->default_ram_id,
>                                obj);
>      /* Ensure backend's memory region name is equal to mc->default_ram_id */
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 69c1ba4..96259c3 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -372,6 +372,7 @@ struct MachineState {
>      bool dump_guest_core;
>      bool mem_merge;
>      bool require_guest_memfd;
> +    bool memfd_alloc;
>      bool usb;
>      bool usb_disabled;
>      char *firmware;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index cf61f6b..f0dfda5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>      "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>      "                mem-merge=on|off controls memory merge support (default: on)\n"
> +    "                memfd-alloc=on|off controls allocating anonymous guest RAM using memfd_create (default: off)\n"
>      "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
>      "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
> @@ -79,6 +80,11 @@ SRST
>          supported by the host, de-duplicates identical memory pages
>          among VMs instances (enabled by default).
>  
> +    ``memfd-alloc=on|off``
> +        Enables or disables allocation of anonymous guest RAM using
> +        memfd_create.  Any associated memory-backend objects are created with
> +        share=on.  The memfd-alloc default is off.
> +
>      ``aes-key-wrap=on|off``
>          Enables or disables AES key wrapping support on s390-ccw hosts.
>          This feature controls whether AES wrapping keys will be created
> diff --git a/system/memory.c b/system/memory.c
> index 49f1cb2..ca04a0e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>                                        uint64_t size,
>                                        Error **errp)
>  {
> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;

If there's a machine option to "use memfd for allocations", then it's
shared mem... Hmm..

It is a bit confusing to me in quite a few levels:

  - Why memory allocation method will be defined by a machine property,
    even if we have memory-backend-* which should cover everything?

  - Even if we have such a machine property, why setting "memfd" will
    always imply shared?  why not private?  After all it's not called
    "memfd-shared-alloc", and we can create private mappings using
    e.g. memory-backend-memfd,share=off.

>      return memory_region_init_ram_flags_nomigrate(mr, owner, name,
> -                                                  size, 0, errp);
> +                                                  size, flags, errp);
>  }
>  
>  bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
> @@ -1713,8 +1714,9 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>                                        uint64_t size,
>                                        Error **errp)
>  {
> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>      if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
> -                                                size, 0, errp)) {
> +                                                size, flags, errp)) {
>           return false;
>      }
>      mr->readonly = true;
> @@ -1731,6 +1733,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>                                               Error **errp)
>  {
>      Error *err = NULL;
> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
>      assert(ops);
>      memory_region_init(mr, owner, name, size);
>      mr->ops = ops;
> @@ -1738,7 +1741,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>      mr->terminates = true;
>      mr->rom_device = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
> +    mr->ram_block = qemu_ram_alloc(size, flags, mr, &err);
>      if (err) {
>          mr->size = int128_zero();
>          object_unparent(OBJECT(mr));
> diff --git a/system/physmem.c b/system/physmem.c
> index c736af5..36d97ec 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -45,6 +45,7 @@
>  #include "qemu/qemu-print.h"
>  #include "qemu/log.h"
>  #include "qemu/memalign.h"
> +#include "qemu/memfd.h"
>  #include "exec/memory.h"
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
> @@ -1825,6 +1826,19 @@ static void *ram_block_alloc_host(RAMBlock *rb, Error **errp)
>      if (xen_enabled()) {
>          xen_ram_alloc(rb->offset, rb->max_length, mr, errp);
>  
> +    } else if (rb->flags & RAM_SHARED) {
> +        if (rb->fd == -1) {
> +            mr->align = QEMU_VMALLOC_ALIGN;
> +            rb->fd = qemu_memfd_create(rb->idstr, rb->max_length + mr->align,
> +                                       0, 0, 0, errp);
> +        }

We used to have case where RAM_SHARED && rb->fd==-1, I think.

We have some code that checks explicitly on rb->fd against -1 to know
whether it's a fd based.  I'm not sure whether there'll be implications to
affect those codes.

Maybe it's mostly fine, OTOH I worry more on the whole idea.  I'm not sure
whether this is relevant to "we want to be able to share the mem with the
new process", in this case can we simply require the user to use file based
memory backends, rather than such change?

Thanks,

> +        if (rb->fd >= 0) {
> +            int mfd = rb->fd;
> +            qemu_set_cloexec(mfd);
> +            host = file_ram_alloc(rb, rb->max_length, mfd, false, 0, errp);
> +            trace_qemu_anon_memfd_alloc(rb->idstr, rb->max_length, mfd, host);
> +        }
> +
>      } else {
>          host = qemu_anon_ram_alloc(rb->max_length, &mr->align,
>                                     qemu_ram_is_shared(rb),
> @@ -2106,8 +2120,10 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
>                                                       void *host),
>                                       MemoryRegion *mr, Error **errp)
>  {
> +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> +    flags |= RAM_RESIZEABLE;
>      return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
> -                                   RAM_RESIZEABLE, mr, errp);
> +                                   flags, mr, errp);
>  }
>  
>  static void reclaim_ramblock(RAMBlock *block)
> diff --git a/system/trace-events b/system/trace-events
> index f0a80ba..0092734 100644
> --- a/system/trace-events
> +++ b/system/trace-events
> @@ -41,3 +41,4 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
>  
>  # physmem.c
>  ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"
> +qemu_anon_memfd_alloc(const char *name, size_t size, int fd, void *ptr) "%s size %zu fd %d -> %p"
> -- 
> 1.8.3.1
> 

-- 
Peter Xu



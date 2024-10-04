Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E234CFA77A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 13:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swiIs-0004np-Ts; Fri, 04 Oct 2024 09:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swiIq-0004nP-89
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1swiIn-0002Um-Qp
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 09:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728048300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ryLgpvU+mrMzBx/KUuGjsTntNFag5rv6vyy/BMh9TJw=;
 b=Px07NKTGyznijd/uHj/7iGvWPB3DW6biU6z+f5I4dm3A4hHPM0wP37kAjG7SW9d0vm0zMR
 m1faaqpuxXYq0vS76bebIO8idQJyYTct2s/yYd6/sVilvMDaVH1u+WnaiZrq6gCOkuwEu8
 aPaRT/aAPAhZRzk+4I77MBbuI45M618=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-78gQ_sfgO4C63h8l4t-okA-1; Fri, 04 Oct 2024 09:24:59 -0400
X-MC-Unique: 78gQ_sfgO4C63h8l4t-okA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-82ce3316d51so188512139f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 06:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728048298; x=1728653098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ryLgpvU+mrMzBx/KUuGjsTntNFag5rv6vyy/BMh9TJw=;
 b=kBScGoEorz2OKXXXkWAU0v5EqEqv2CgbZ7GIj+EglG+Ahf839+feZWFwdUef21Bh07
 him64atD3wYpgzOOAw3bziovdGa6H8Zc+qBEkSaPs3qqk8S1h0szr+q3mcVVB9eRBKco
 LkfWVgQgsOQxT9Jjfq4i8S0+oi3339UgzPRPoTGKyKFdxBVuVs+2mVhJt9x3KIei/y5u
 OBSkmFzdMDxjhIGQUZSacG559nXaWcc0TInyI1rILtzNDnjezazDw/Vud6RRP3k6BxcK
 Wu6yscvAkkUOvDZ7V52IZ51psAjWXPAEq50rabxxubt76X8fYjkSw8x8/IwpGIVhkpYZ
 uh+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEGQsaJ5UxAyrjkP5FQEERdg8OuZbkC4RgIfc+TMYQ7HqVSeHOh0yMTS8Wqbhf0/qY+14fbMlWoi7y@nongnu.org
X-Gm-Message-State: AOJu0YxiB3bfnFk+vWxbTDOddZ9C4tXV9kY9PT3ZoWX1Nr8x0pGEg6rH
 uWn+aUxcgLeH8zaEnWwyXqWUzk6mTdzjiNe9Iec1idvOBEtFpm83gZJO5uQGCpTI9gDyHx0Wsr0
 st1QGmkklwGB9lYAPkiJER7DRTdCQVVwb5g3EwenBiUwcCNDCl3YU
X-Received: by 2002:a05:6602:1588:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-834f7cdd476mr275837239f.6.1728048298307; 
 Fri, 04 Oct 2024 06:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ayMMxh+CNgoRwu1uk43Oe9pHlmmoN076XcEnbZ8E4d5HheeSPX/+9b/EWYzZWU6HL901Nw==
X-Received: by 2002:a05:6602:1588:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-834f7cdd476mr275832939f.6.1728048297785; 
 Fri, 04 Oct 2024 06:24:57 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db559b058csm734267173.84.2024.10.04.06.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 06:24:57 -0700 (PDT)
Date: Fri, 4 Oct 2024 09:24:54 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
Message-ID: <Zv_spkFwqwgxGkNY@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
 <Zv7C7MeVP2X8bEJU@x1n>
 <2143f803-439e-4b8b-ae92-07caa913d646@redhat.com>
 <Zv_ghrH6i4QOzne8@x1n>
 <bffa3dc0-36b7-4fa1-a0b6-cce34743a46c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bffa3dc0-36b7-4fa1-a0b6-cce34743a46c@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 04, 2024 at 02:54:38PM +0200, David Hildenbrand wrote:
> On 04.10.24 14:33, Peter Xu wrote:
> > On Fri, Oct 04, 2024 at 12:14:35PM +0200, David Hildenbrand wrote:
> > > On 03.10.24 18:14, Peter Xu wrote:
> > > > On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
> > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > > on the value of the anon-alloc machine property.  This option applies to
> > > > > memory allocated as a side effect of creating various devices. It does
> > > > > not apply to memory-backend-objects, whether explicitly specified on
> > > > > the command line, or implicitly created by the -m command line option.
> > > > > 
> > > > > The memfd option is intended to support new migration modes, in which the
> > > > > memory region can be transferred in place to a new QEMU process, by sending
> > > > > the memfd file descriptor to the process.  Memory contents are preserved,
> > > > > and if the mode also transfers device descriptors, then pages that are
> > > > > locked in memory for DMA remain locked.  This behavior is a pre-requisite
> > > > > for supporting vfio, vdpa, and iommufd devices with the new modes.
> > > > > 
> > > > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > > 
> > > > [Igor seems missing in the loop; added]
> > > > 
> > > > > ---
> > > > >    hw/core/machine.c   | 19 +++++++++++++++++++
> > > > >    include/hw/boards.h |  1 +
> > > > >    qapi/machine.json   | 14 ++++++++++++++
> > > > >    qemu-options.hx     | 11 +++++++++++
> > > > >    system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
> > > > >    system/trace-events |  3 +++
> > > > >    6 files changed, 83 insertions(+)
> > > > > 
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index adaba17..a89a32b 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
> > > > >        ms->mem_merge = value;
> > > > >    }
> > > > > +static int machine_get_anon_alloc(Object *obj, Error **errp)
> > > > > +{
> > > > > +    MachineState *ms = MACHINE(obj);
> > > > > +
> > > > > +    return ms->anon_alloc;
> > > > > +}
> > > > > +
> > > > > +static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
> > > > > +{
> > > > > +    MachineState *ms = MACHINE(obj);
> > > > > +
> > > > > +    ms->anon_alloc = value;
> > > > > +}
> > > > > +
> > > > >    static bool machine_get_usb(Object *obj, Error **errp)
> > > > >    {
> > > > >        MachineState *ms = MACHINE(obj);
> > > > > @@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
> > > > >        object_class_property_set_description(oc, "mem-merge",
> > > > >            "Enable/disable memory merge support");
> > > > > +    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
> > > > > +                                   &AnonAllocOption_lookup,
> > > > > +                                   machine_get_anon_alloc,
> > > > > +                                   machine_set_anon_alloc);
> > > > > +
> > > > >        object_class_property_add_bool(oc, "usb",
> > > > >            machine_get_usb, machine_set_usb);
> > > > >        object_class_property_set_description(oc, "usb",
> > > > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > > > index 5966069..5a87647 100644
> > > > > --- a/include/hw/boards.h
> > > > > +++ b/include/hw/boards.h
> > > > > @@ -393,6 +393,7 @@ struct MachineState {
> > > > >        bool enable_graphics;
> > > > >        ConfidentialGuestSupport *cgs;
> > > > >        HostMemoryBackend *memdev;
> > > > > +    AnonAllocOption anon_alloc;
> > > > >        /*
> > > > >         * convenience alias to ram_memdev_id backend memory region
> > > > >         * or to numa container memory region
> > > > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > > > index a6b8795..d4a63f5 100644
> > > > > --- a/qapi/machine.json
> > > > > +++ b/qapi/machine.json
> > > > > @@ -1898,3 +1898,17 @@
> > > > >    { 'command': 'x-query-interrupt-controllers',
> > > > >      'returns': 'HumanReadableText',
> > > > >      'features': [ 'unstable' ]}
> > > > > +
> > > > > +##
> > > > > +# @AnonAllocOption:
> > > > > +#
> > > > > +# An enumeration of the options for allocating anonymous guest memory.
> > > > > +#
> > > > > +# @mmap: allocate using mmap MAP_ANON
> > > > > +#
> > > > > +# @memfd: allocate using memfd_create
> > > > > +#
> > > > > +# Since: 9.2
> > > > > +##
> > > > > +{ 'enum': 'AnonAllocOption',
> > > > > +  'data': [ 'mmap', 'memfd' ] }
> > > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > > index d94e2cb..90ab943 100644
> > > > > --- a/qemu-options.hx
> > > > > +++ b/qemu-options.hx
> > > > > @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> > > > >        "                nvdimm=on|off controls NVDIMM support (default=off)\n"
> > > > >        "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
> > > > >        "                hmat=on|off controls ACPI HMAT support (default=off)\n"
> > > > > +    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
> > > > >        "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
> > > > >        "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
> > > > >        QEMU_ARCH_ALL)
> > > > > @@ -101,6 +102,16 @@ SRST
> > > > >            Enables or disables ACPI Heterogeneous Memory Attribute Table
> > > > >            (HMAT) support. The default is off.
> > > > > +    ``anon-alloc=mmap|memfd``
> > > > > +        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
> > > > > +        or memfd_create.  This option applies to memory allocated as a
> > > > > +        side effect of creating various devices. It does not apply to
> > > > > +        memory-backend-objects, whether explicitly specified on the
> > > > > +        command line, or implicitly created by the -m command line
> > > > > +        option.
> > > > > +
> > > > > +        Some migration modes require anon-alloc=memfd.
> > > > > +
> > > > >        ``memory-backend='id'``
> > > > >            An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
> > > > >            Allows to use a memory backend as main RAM.
> > > > > diff --git a/system/physmem.c b/system/physmem.c
> > > > > index dc1db3a..174f7e0 100644
> > > > > --- a/system/physmem.c
> > > > > +++ b/system/physmem.c
> > > > > @@ -47,6 +47,7 @@
> > > > >    #include "qemu/qemu-print.h"
> > > > >    #include "qemu/log.h"
> > > > >    #include "qemu/memalign.h"
> > > > > +#include "qemu/memfd.h"
> > > > >    #include "exec/memory.h"
> > > > >    #include "exec/ioport.h"
> > > > >    #include "sysemu/dma.h"
> > > > > @@ -69,6 +70,8 @@
> > > > >    #include "qemu/pmem.h"
> > > > > +#include "qapi/qapi-types-migration.h"
> > > > > +#include "migration/options.h"
> > > > >    #include "migration/vmstate.h"
> > > > >    #include "qemu/range.h"
> > > > > @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> > > > >                    qemu_mutex_unlock_ramlist();
> > > > >                    return;
> > > > >                }
> > > > > +
> > > > > +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
> > > > > +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
> > > > > +                                        TYPE_MEMORY_BACKEND)) {
> > > > 
> > > > This is pretty fragile.. if someone adds yet another layer on top of memory
> > > > backend objects, the ownership links can change and this might silently run
> > > > into something else even without any warning..
> > > > 
> > > > I wished we dig into what is missing, but maybe that's too trivial.  If
> > > > not, we still need to make this as solid.  Perhaps that can be a ram flag
> > > > and let relevant callers pass in that flag explicitly.
> > > 
> > > How would they decide whether or not we want to set the flag in the current
> > > configuration?
> > 
> > It was in the previous email where it got cut..  I listed four paths that
> > may need change.
> 
> That's not my question. Who would decide whether we want to set MAP_SHARED
> in these callers or not?
> 
> If you have "unconditionally" in mind, I think it's a bad idea. If there is
> some other toggle to perform that setting conditionally, why not.

Yes I thought it could be unconditionally.  We can discuss downside below,
I think we can still use a new flag otherwise, but the idea would be the
same, where I want the flag to be explicit in the callers not implicitly
with the object type check, which I think can be hackish.

> 
> > 
> > > 
> > > > 
> > > > I think RAM_SHARED can actually be that flag already - I mean, in all paths
> > > > that we may create anon mem (but not memory-backend-* objects), is it
> > > > always safe we always switch to RAM_SHARED from anon?
> > > 
> > > Do you mean only setting the flag (-> anonymous shmem) or switching also to
> > > memfd, which is a bigger change?
> > 
> > Switching to memfd.  I thought anon shmem (mmap(MAP_SHARED)) is mostly the
> > same internally, if we create memfd then mmap(MAP_SHARED) on top of it, no?
> 
> Memfd is Linux specific, keep that in mind. Apart from that there shouldn't
> be much difference between anon shmem and memfd (there are memory commit
> differences, though).

Could you elaborate the memory commit difference and what does that imply
to QEMU's usage?

> 
> Of course, there is a difference between anon memory and shmem, for example
> regarding what viritofsd faced (e.g., KSM) recently.

The four paths shouldn't be KSM target, AFAICT.  None of them are major
part of guest RAM, but only very small chunks like vram or roms.

Thanks,

-- 
Peter Xu



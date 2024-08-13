Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE33C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtYX-0005nS-0B; Tue, 13 Aug 2024 11:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdtYU-0005mw-JA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdtYS-0006zq-DJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723563322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0spfjn0k/6/2Qto+WA6uu27PzJZhhTSBayB+tH/whSI=;
 b=iLMSZQNyV1SnfmdXndzsfZ1aEbkBkqqu07obslyW4IAgI3HrfM3UrhzLqZSnFKTYKm+vbo
 ntCTZxTbQNsZzcPQIc7UF03owFSqK7oGbTazyG9JO2dbN/JpDUgEPUvUsGFAUcZfNB9qLy
 HqsXter4TQd4/rlKWzTWcyAdscU8ywg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-rRPTLfNUN7ahUecgsdOKBw-1; Tue, 13 Aug 2024 11:35:20 -0400
X-MC-Unique: rRPTLfNUN7ahUecgsdOKBw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44fea369811so8032681cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723563320; x=1724168120;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0spfjn0k/6/2Qto+WA6uu27PzJZhhTSBayB+tH/whSI=;
 b=FSXos8dMDDSM8NSaBLBmF2jmnsgT3FjqzX26QniyDhyxmU07ykb+nGaOWGt03+yRZM
 h/7LtT2kkoRWVbR3LkppwK2luhHXsckI24G/Xx4GoprG4eivilKy6Kf90oCM9BsjD8+D
 eFx1TCB7/uroAEcOgZNBUlh4X1Q0Pe7C7Ty0cVUcKnqUJ7c2azDD+LrdNN5CJudmzeov
 aETqSi2fOKL72ZzuU26Yb8TiPj9YlVFIdWpMwdcSJw04JJhNzi7F1RXQvOgPYYZRezfS
 SbFfB5P4ht8MbcbTnjSdVKC2LetBGavBRLmmSqgzSwuXT2yzN9b9BJj0ruT0gOi32dOG
 KsGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnFd0tyWb4zT+WrSgmuhVsImj2ChNPiOULOXm3A0PyMZ9PsgxaeA9OO1OYoPFee+2OzBMh0Zba0j+3j/8TSjJecNLfKyc=
X-Gm-Message-State: AOJu0Yzi58xXysNQVenOcZ++9StwVFQ0HY5rqHGQjyNuw1SIOidMzVWo
 3C8CdSrCrg5y/vB0LbOo/jqS1KzTdhfK44LHNz/H2XmzpAcRfdoHcuT/A/z4ECrcHD3Ed6TVCFf
 pPsb2N7+ixjo5F5Thyc11QJ/MhNlP+c2sn6AUNThvBCyEsIuOTgwd
X-Received: by 2002:a05:620a:1a8b:b0:79f:b3c:8fc3 with SMTP id
 af79cd13be357-7a4e4ecabeamr182395085a.6.1723563320089; 
 Tue, 13 Aug 2024 08:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhVwLLx2sBRB6v1M4BfQiOIfYVC1imChfCvH4uydYWf68dLIZhq1Y0z+RI2NLcBkIWwR3xXA==
X-Received: by 2002:a05:620a:1a8b:b0:79f:b3c:8fc3 with SMTP id
 af79cd13be357-7a4e4ecabeamr182392685a.6.1723563319529; 
 Tue, 13 Aug 2024 08:35:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4c7d71bddsm350860185a.38.2024.08.13.08.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:35:18 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:35:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <Zrt9M00rDk3EUdNM@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 02:37:59PM -0400, Steven Sistare wrote:
> On 8/8/2024 2:32 PM, Steven Sistare wrote:
> > On 7/29/2024 8:29 AM, Igor Mammedov wrote:
> > > On Sat, 20 Jul 2024 16:28:25 -0400
> > > Steven Sistare <steven.sistare@oracle.com> wrote:
> > > 
> > > > On 7/16/2024 5:19 AM, Igor Mammedov wrote:
> > > > > On Sun, 30 Jun 2024 12:40:24 -0700
> > > > > Steve Sistare <steven.sistare@oracle.com> wrote:
> > > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > > > on the value of the anon-alloc machine property.  This affects
> > > > > > memory-backend-ram objects, guest RAM created with the global -m option
> > > > > > but without an associated memory-backend object and without the -mem-path
> > > > > > option
> > > > > nowadays, all machines were converted to use memory backend for VM RAM.
> > > > > so -m option implicitly creates memory-backend object,
> > > > > which will be either MEMORY_BACKEND_FILE if -mem-path present
> > > > > or MEMORY_BACKEND_RAM otherwise.
> > > > 
> > > > Yes.  I dropped an an important adjective, "implicit".
> > > > 
> > > >     "guest RAM created with the global -m option but without an explicit associated
> > > >     memory-backend object and without the -mem-path option"
> > > > 
> > > > > > To access the same memory in the old and new QEMU processes, the memory
> > > > > > must be mapped shared.  Therefore, the implementation always sets
> > > > > > RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
> > > > > > user must explicitly specify the share option.  In lieu of defining a new
> > > > > so statement at the top that memory-backend-ram is affected is not
> > > > > really valid?
> > > > 
> > > > memory-backend-ram is affected by alloc-anon.  But in addition, the user must
> > > > explicitly add the "share" option.  I don't implicitly set share in this case,
> > > > because I would be overriding the user's specification of the memory object's property,
> > > > which would be private if omitted.
> > > 
> > > instead of touching implicit RAM (-m), it would be better to error out
> > > and ask user to provide properly configured memory-backend explicitly.
> > > 
> > > > 
> > > > > > RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
> > > > > > as the condition for calling memfd_create.
> > > > > 
> > > > > In general I do dislike adding yet another option that will affect
> > > > > guest RAM allocation (memory-backends  should be sufficient).
> > > > > 
> > > > > However I do see that you need memfd for device memory (vram, roms, ...).
> > > > > Can we just use memfd/shared unconditionally for those and
> > > > > avoid introducing a new confusing option?
> > > > 
> > > > The Linux kernel has different tunables for backing memfd's with huge pages, so we
> > > > could hurt performance if we unconditionally change to memfd.  The user should have
> > > > a choice for any segment that is large enough for huge pages to improve performance,
> > > > which potentially is any memory-backend-object.  The non memory-backend objects are
> > > > small, and it would be OK to use memfd unconditionally for them.
> > 
> > Thanks everyone for your feedback.  The common theme is that you dislike that the
> > new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
> > to remove that interaction, and document in the QAPI which backends work for CPR.
> > Specifically, memory-backend-memfd or memory-backend-file object is required,
> > with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
> > otherwise.  The legacy -m option without an explicit memory-backend-object will not
> > support CPR.
> > 
> > Non memory-backend-objects (ramblocks not described on the qemu command line) will always
> > be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
> > The logic in ram_block_add becomes:
> > 
> >      if (!new_block->host) {
> >          if (xen_enabled()) {
> >              ...
> >          } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
> >                                          TYPE_MEMORY_BACKEND)) {
> >              qemu_memfd_create()
> >          } else {
> >              qemu_anon_ram_alloc()
> >          }
> > 
> > Is that acceptable to everyone?  Igor, Peter, Daniel?

Sorry for a late reply.

I think this may not work as David pointed out? Where AFAIU it will switch
many old anon use cases to use memfd, aka, shmem, and it might be
problematic when share=off: we have double memory consumption issue with
shmem with private mapping.

I assume that includes things like "-m", "memory-backend-ram", and maybe
more.  IIUC memory consumption of the VM will double with them.

> 
> In a simple test here are the NON-memory-backend-object ramblocks which
> are allocated with memfd_create in my new proposal:
> 
>   memfd_create system.flash0 3653632 @ 0x7fffe1000000 2 rw
>   memfd_create system.flash1 540672 @ 0x7fffe0c00000 2 rw
>   memfd_create pc.rom 131072 @ 0x7fffe0800000 2 rw
>   memfd_create vga.vram 16777216 @ 0x7fffcac00000 2 rw
>   memfd_create vga.rom 65536 @ 0x7fffe0400000 2 rw
>   memfd_create /rom@etc/acpi/tables 2097152 @ 0x7fffca400000 6 rw
>   memfd_create /rom@etc/table-loader 65536 @ 0x7fffca000000 6 rw
>   memfd_create /rom@etc/acpi/rsdp 4096 @ 0x7fffc9c00000 6 rw
> 
> Of those, only a subset are mapped for DMA, per the existing QEMU logic,
> no changes from me:
> 
>   dma_map: pc.rom 131072 @ 0x7fffe0800000 ro
>   dma_map: vga.vram 16777216 @ 0x7fffcac00000 rw
>   dma_map: vga.rom 65536 @ 0x7fffe0400000 ro

I wonder whether there's any case that the "rom"s can be DMA target at
all..  I understand it's logically possible to be READ from as ROMs, but I
am curious what happens if we don't map them at all when they're ROMs, or
whether there's any device that can (in real life) DMA from device ROMs,
and for what use.

>   dma_map: 0000:3a:10.0 BAR 0 mmaps[0] 16384 @ 0x7ffff7fef000 rw
>   dma_map: 0000:3a:10.0 BAR 3 mmaps[0] 12288 @ 0x7ffff7fec000 rw
> 
> system.flash0 is excluded by the vfio listener because it is a rom_device.
> The rom@etc blocks are excluded because their MemoryRegions are not added to
> any container region, so the flatmem traversal of the AS used by the listener
> does not see them.
> 
> The BARs should not be mapped IMO, and I propose excluding them in the
> iommufd series:
>   https://lore.kernel.org/qemu-devel/1721502937-87102-3-git-send-email-steven.sistare@oracle.com/

Looks like this is clear now that they should be there.

> 
> Note that the old-QEMU contents of all ramblocks must be preserved, just like
> in live migration.  Live migration copies the contents in the stream.  Live update
> preserves the contents in place by preserving the memfd.  Thus memfd serves
> two purposes: preserving old contents, and preserving DMA mapped pinned pages.

IMHO the 1st purpose is a fake one.  IOW:

  - Preserving content will be important on large RAM/ROM regions.  When
    it's small, it shouldn't matter a huge deal, IMHO, because this is
    about "how fast we can migrate / live upgrade'.  IOW, this is not a
    functional requirement.

  - DMA mapped pinned pages: instead this is a hard requirement that we
    must make sure these pages are fd-based, because only a fd-based
    mapping can persist the pages (via page cache).

IMHO we shouldn't mangle them, and we should start with sticking with the
2nd goal here.  To be explicit, if we can find a good replacement for
-alloc-anon, IMHO we could still migrate the ramblocks only fall into the
1st purpose category, e.g. device ROMs, hopefully even if they're pinned,
they should never be DMAed to/from.

Thanks,

-- 
Peter Xu



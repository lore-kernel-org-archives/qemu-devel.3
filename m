Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B394CC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdutO-0001FH-Dl; Tue, 13 Aug 2024 13:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sdut8-0000IK-Bl
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sdut5-0002b1-Oc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723568445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiRap4hqcnGVI+yjReGvz3EQrkO968uMYqtli/AO2Qc=;
 b=hMbqYhEkFv1BFEVHbLdafFpXPSNDnlsqaTMG+zEOX3rlp+SKhSW4EI8iN3APkzjxfVJqFh
 GKr0hEQ8sPK2H9KVaQQA7ABkmIP7ATqeUChcqAIQrm7c8Dx7SdKG+cepNFKXGMBSsmASUz
 EXeQjj+H6ck9+hs6vO+VESb4fGUfOpI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-hkBNkMXaPZ-ixymWI3AE8A-1; Tue, 13 Aug 2024 13:00:43 -0400
X-MC-Unique: hkBNkMXaPZ-ixymWI3AE8A-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-39a143db6c4so57709585ab.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 10:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723568442; x=1724173242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiRap4hqcnGVI+yjReGvz3EQrkO968uMYqtli/AO2Qc=;
 b=iXQfr5DeMhTtrX90PgqIRaIdOJw3M+fR1OugRo0/AWdpllO1XiWjSU5j0NXL5iMcJc
 T/xGhzhWLNb1JdkSv6Z1yOeptJL2/RUyp7Ag2qJIlAKA3sjZ8lSkQBVEL++rS5DqSsJK
 BZ2j/ygGP7VZ/R/D9c5Tyjyi+fFQlB1vzHonHsb/5oar3/YMTwWA9YD/3OC3mXzmlEYg
 Mjx7HfTmBJoIUkiG8bWw7cfT0gWHUpDE/QOzIFSrzTeP9ZHT3E+6pxCzV92f0lKMWSFW
 EJ6zRv76X9yG2aPBkFcYwLLD6tCAUAGQH9EOvXk9538jhuNrE8n5gEY+VtaihW51CuwY
 BCKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaiioWgihwpuK0RqbzquGRORP5IpPoCd0ZIYedy/c5d2EVVzK+lJi0CkDpk9PpA1SZqHjZ4dr+YWOCcFtcZBd+sQy62OA=
X-Gm-Message-State: AOJu0Yzi4wDvtmHKy9Nchbs8h7MuwomdbK8bIEnr+v5IOla4U/e4M3dW
 59xzALjH4mmusMZSDB11+9dZiJYDqkj4UmNm2BFSgWUVsve2zQZlABY92maRoiRuyMaK+5YcAxC
 TkjRcylPmAgktfHoq1KtUZObI/QLUSvgUuzAciKaZldZnHCO/zfar
X-Received: by 2002:a92:c26f:0:b0:374:5300:88ac with SMTP id
 e9e14a558f8ab-39d124f7186mr3588915ab.18.1723568441935; 
 Tue, 13 Aug 2024 10:00:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCgGsymy2NASBTCR+mcFhOj5ktLhrW5nWoJGXiHe8nheEPRgouphNtzqNxca3BZe6c/zLOSw==
X-Received: by 2002:a92:c26f:0:b0:374:5300:88ac with SMTP id
 e9e14a558f8ab-39d124f7186mr3588605ab.18.1723568441335; 
 Tue, 13 Aug 2024 10:00:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76a35926sm2576564173.142.2024.08.13.10.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 10:00:40 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:00:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Igor Mammedov
 <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, David Hildenbrand
 <david@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <20240813110037.6f04ffe9.alex.williamson@redhat.com>
In-Reply-To: <Zrt9M00rDk3EUdNM@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
 <Zrt9M00rDk3EUdNM@x1n>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Tue, 13 Aug 2024 11:35:15 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Aug 12, 2024 at 02:37:59PM -0400, Steven Sistare wrote:
> > On 8/8/2024 2:32 PM, Steven Sistare wrote: =20
> > > On 7/29/2024 8:29 AM, Igor Mammedov wrote: =20
> > > > On Sat, 20 Jul 2024 16:28:25 -0400
> > > > Steven Sistare <steven.sistare@oracle.com> wrote:
> > > >  =20
> > > > > On 7/16/2024 5:19 AM, Igor Mammedov wrote: =20
> > > > > > On Sun, 30 Jun 2024 12:40:24 -0700
> > > > > > Steve Sistare <steven.sistare@oracle.com> wrote: =20
> > > > > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create=
 depending
> > > > > > > on the value of the anon-alloc machine property.=C2=A0 This a=
ffects
> > > > > > > memory-backend-ram objects, guest RAM created with the global=
 -m option
> > > > > > > but without an associated memory-backend object and without t=
he -mem-path
> > > > > > > option =20
> > > > > > nowadays, all machines were converted to use memory backend for=
 VM RAM.
> > > > > > so -m option implicitly creates memory-backend object,
> > > > > > which will be either MEMORY_BACKEND_FILE if -mem-path present
> > > > > > or MEMORY_BACKEND_RAM otherwise. =20
> > > > >=20
> > > > > Yes.=C2=A0 I dropped an an important adjective, "implicit".
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 "guest RAM created with the global -m option b=
ut without an explicit associated
> > > > > =C2=A0=C2=A0=C2=A0 memory-backend object and without the -mem-pat=
h option"
> > > > >  =20
> > > > > > > To access the same memory in the old and new QEMU processes, =
the memory
> > > > > > > must be mapped shared.=C2=A0 Therefore, the implementation al=
ways sets
> > > > > > > RAM_SHARED if alloc-anon=3Dmemfd, except for memory-backend-r=
am, where the
> > > > > > > user must explicitly specify the share option.=C2=A0 In lieu =
of defining a new =20
> > > > > > so statement at the top that memory-backend-ram is affected is =
not
> > > > > > really valid? =20
> > > > >=20
> > > > > memory-backend-ram is affected by alloc-anon.=C2=A0 But in additi=
on, the user must
> > > > > explicitly add the "share" option.=C2=A0 I don't implicitly set s=
hare in this case,
> > > > > because I would be overriding the user's specification of the mem=
ory object's property,
> > > > > which would be private if omitted. =20
> > > >=20
> > > > instead of touching implicit RAM (-m), it would be better to error =
out
> > > > and ask user to provide properly configured memory-backend explicit=
ly.
> > > >  =20
> > > > >  =20
> > > > > > > RAM flag, at the lowest level the implementation uses RAM_SHA=
RED with fd=3D-1
> > > > > > > as the condition for calling memfd_create. =20
> > > > > >=20
> > > > > > In general I do dislike adding yet another option that will aff=
ect
> > > > > > guest RAM allocation (memory-backends=C2=A0 should be sufficien=
t).
> > > > > >=20
> > > > > > However I do see that you need memfd for device memory (vram, r=
oms, ...).
> > > > > > Can we just use memfd/shared unconditionally for those and
> > > > > > avoid introducing a new confusing option? =20
> > > > >=20
> > > > > The Linux kernel has different tunables for backing memfd's with =
huge pages, so we
> > > > > could hurt performance if we unconditionally change to memfd.=C2=
=A0 The user should have
> > > > > a choice for any segment that is large enough for huge pages to i=
mprove performance,
> > > > > which potentially is any memory-backend-object.=C2=A0 The non mem=
ory-backend objects are
> > > > > small, and it would be OK to use memfd unconditionally for them. =
=20
> > >=20
> > > Thanks everyone for your feedback.=C2=A0 The common theme is that you=
 dislike that the
> > > new option modifies the allocation of memory-backend-objects.=C2=A0 O=
K, accepted.=C2=A0 I propose
> > > to remove that interaction, and document in the QAPI which backends w=
ork for CPR.
> > > Specifically, memory-backend-memfd or memory-backend-file object is r=
equired,
> > > with share=3Don (which is the default for memory-backend-memfd).=C2=
=A0 CPR will be blocked
> > > otherwise.=C2=A0 The legacy -m option without an explicit memory-back=
end-object will not
> > > support CPR.
> > >=20
> > > Non memory-backend-objects (ramblocks not described on the qemu comma=
nd line) will always
> > > be allocated using memfd_create (on Linux only).=C2=A0 The alloc-anon=
 option is deleted.
> > > The logic in ram_block_add becomes:
> > >=20
> > >  =C2=A0=C2=A0=C2=A0 if (!new_block->host) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xen_enabled()) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
..
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!object_dynami=
c_cast(new_block->mr->parent_obj.parent,
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 TYPE_MEMORY_BACKEND)) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
emu_memfd_create()
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
emu_anon_ram_alloc()
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > Is that acceptable to everyone?=C2=A0 Igor, Peter, Daniel? =20
>=20
> Sorry for a late reply.
>=20
> I think this may not work as David pointed out? Where AFAIU it will switch
> many old anon use cases to use memfd, aka, shmem, and it might be
> problematic when share=3Doff: we have double memory consumption issue with
> shmem with private mapping.
>=20
> I assume that includes things like "-m", "memory-backend-ram", and maybe
> more.  IIUC memory consumption of the VM will double with them.
>=20
> >=20
> > In a simple test here are the NON-memory-backend-object ramblocks which
> > are allocated with memfd_create in my new proposal:
> >=20
> >   memfd_create system.flash0 3653632 @ 0x7fffe1000000 2 rw
> >   memfd_create system.flash1 540672 @ 0x7fffe0c00000 2 rw
> >   memfd_create pc.rom 131072 @ 0x7fffe0800000 2 rw
> >   memfd_create vga.vram 16777216 @ 0x7fffcac00000 2 rw
> >   memfd_create vga.rom 65536 @ 0x7fffe0400000 2 rw
> >   memfd_create /rom@etc/acpi/tables 2097152 @ 0x7fffca400000 6 rw
> >   memfd_create /rom@etc/table-loader 65536 @ 0x7fffca000000 6 rw
> >   memfd_create /rom@etc/acpi/rsdp 4096 @ 0x7fffc9c00000 6 rw
> >=20
> > Of those, only a subset are mapped for DMA, per the existing QEMU logic,
> > no changes from me:
> >=20
> >   dma_map: pc.rom 131072 @ 0x7fffe0800000 ro
> >   dma_map: vga.vram 16777216 @ 0x7fffcac00000 rw
> >   dma_map: vga.rom 65536 @ 0x7fffe0400000 ro =20
>=20
> I wonder whether there's any case that the "rom"s can be DMA target at
> all..  I understand it's logically possible to be READ from as ROMs, but I
> am curious what happens if we don't map them at all when they're ROMs, or
> whether there's any device that can (in real life) DMA from device ROMs,
> and for what use.
>=20
> >   dma_map: 0000:3a:10.0 BAR 0 mmaps[0] 16384 @ 0x7ffff7fef000 rw
> >   dma_map: 0000:3a:10.0 BAR 3 mmaps[0] 12288 @ 0x7ffff7fec000 rw
> >=20
> > system.flash0 is excluded by the vfio listener because it is a rom_devi=
ce.
> > The rom@etc blocks are excluded because their MemoryRegions are not add=
ed to
> > any container region, so the flatmem traversal of the AS used by the li=
stener
> > does not see them.
> >=20
> > The BARs should not be mapped IMO, and I propose excluding them in the
> > iommufd series:
> >   https://lore.kernel.org/qemu-devel/1721502937-87102-3-git-send-email-=
steven.sistare@oracle.com/ =20
>=20
> Looks like this is clear now that they should be there.
>=20
> >=20
> > Note that the old-QEMU contents of all ramblocks must be preserved, jus=
t like
> > in live migration.  Live migration copies the contents in the stream.  =
Live update
> > preserves the contents in place by preserving the memfd.  Thus memfd se=
rves
> > two purposes: preserving old contents, and preserving DMA mapped pinned=
 pages. =20
>=20
> IMHO the 1st purpose is a fake one.  IOW:
>=20
>   - Preserving content will be important on large RAM/ROM regions.  When
>     it's small, it shouldn't matter a huge deal, IMHO, because this is
>     about "how fast we can migrate / live upgrade'.  IOW, this is not a
>     functional requirement.

Regardless of the size of a ROM region, how would it ever be faster to
migrate ROMs rather that reload them from stable media on the target?
Furthermore, what mechanism other than migrating the ROM do we have to
guarantee the contents of the ROM are identical?

I have a hard time accepting that ROMs are only migrated for
performance and there isn't some aspect of migrating them to ensure the
contents remain identical, and by that token CPR would also need to
preserve the contents to provide the same guarantee.  Thanks,

Alex

>   - DMA mapped pinned pages: instead this is a hard requirement that we
>     must make sure these pages are fd-based, because only a fd-based
>     mapping can persist the pages (via page cache).
>=20
> IMHO we shouldn't mangle them, and we should start with sticking with the
> 2nd goal here.  To be explicit, if we can find a good replacement for
> -alloc-anon, IMHO we could still migrate the ramblocks only fall into the
> 1st purpose category, e.g. device ROMs, hopefully even if they're pinned,
> they should never be DMAed to/from.
>=20
> Thanks,
>=20



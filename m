Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE669C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribJ8-0001bh-3t; Fri, 08 Mar 2024 09:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribJ4-0001bM-IE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:34:42 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribJ2-0007eO-Kw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:34:42 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5682ecd1f81so818354a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709908479; x=1710513279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SusSojd8QuvW6GYsFaznYZMvrnXEiJVmqs2DOPKoD60=;
 b=ZfkK8a7dloNcbAZNnZ2JNhyfvmSyYU96wlIufNm0PtOLKrClCsb1NtUe9zUOtdGt0k
 A05Zq8HjXLquXC3MFH6WlKlHk4MtMYGleXKgZ+2bCyX/KV/GA0GJN2ftBCynVvqc/2MZ
 IH+NiEsqqbBxxfYQcQJv3CFkXQxHt+7zafhmGmqbqF7Ojnm0+pBaJw1ZIKsLICWQj6M0
 ZsMSH7uU9MmkNUJPCbjckYhh8boxOyel1BK+7k0MmabtnCx2InCnItUSWg3TzppB1zPv
 MFCpVZmBL5Q9nI1EChxXyXfkbPJLTSUBZCPGAlxA3KLRJkxEmoCOgyX+Q0OsUK8ZvcNL
 ovCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908479; x=1710513279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SusSojd8QuvW6GYsFaznYZMvrnXEiJVmqs2DOPKoD60=;
 b=kwjZGoYhCNeuwLP32Kx1mjXt52CSFo38lfFBc1QoG428Zvq+F8Qhct9Ou6u6eCo3ww
 ZAKTPzwjMI4NVQ8qJ2wjK8csxV5Jjgvvi06FDeElB62R0jmotM7pREzUNO+nDrWdOenU
 A00/ze0t8sIeADcijhlmJQMpbBbeaPDqjIs6UW8gpQDP3N8l1K5DbQtpUxQEYagk6KBF
 AZMIUgxdeFOS4U6MBq0jtZP+/dkr1zrwUkWZuHphv+m0YEW5sVkZ8uFYZDLQBHfgTmq+
 EaG7MPmQcBzpvGZbDT2CIrh/g2hRmY8A7sRgN+zsT6du+6+FJbsE1f1miIDVjlJMhu9j
 WqUQ==
X-Gm-Message-State: AOJu0Yz2bSHKPzLe8QqrILpmU//rosjCWsoD91j+BAKyikFDw5Q/De/5
 VowhiJmuqx/FpQtxfex/3l98xsrnqsizPD5swEoPD3A6ZgnfgRx84hZ0omR1u+K8kjA9W1a7Bho
 RIKHvNjX9GzH6GkfxsfbpvQ9Q5AJadwP3ZStqgw==
X-Google-Smtp-Source: AGHT+IGKQ3enpmmjXFPKoZjhUSlw1mRFTdGsShTvI58JkFOhs9/Q3djb6E1F+47VO4UajJuljFBJ96cgscON8uCSCf4=
X-Received: by 2002:a50:c309:0:b0:565:2458:4f5a with SMTP id
 a9-20020a50c309000000b0056524584f5amr2074195edb.4.1709908479101; Fri, 08 Mar
 2024 06:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-5-alex.bennee@linaro.org>
In-Reply-To: <20240307181105.4081793-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:34:27 +0000
Message-ID: <CAFEAcA-xBS6T0tiK6AqO98ELwicFXJ84UueFNpqfQxNGyQofYw@mail.gmail.com>
Subject: Re: [PATCH 4/5] include/exec: annotate all the MemoryRegion fields
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 7 Mar 2024 at 18:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/exec/memory.h | 47 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 17b741bc4f5..312ed564dbe 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -778,9 +778,48 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void=
 **vaddr,
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>  typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>
> -/** MemoryRegion:
> - *
> - * A struct representing a memory region.
> +/**
> + * struct MemoryRegion - represents a memory region
> + * @parent_obj: parent QOM object for the region
> + * @romd_mode: if true ROM devices accessed directly rather than with @o=
ps

If true, read accesses go directly to host memory;
write accesses always go via the MMIO accessor.

You might alternatively say "true if a ROM device is in ROMD mode; see
memory_region_device_set_romd()", since the doc comment for
that function has an explanation of what ROMD mode is.

> + * @ram: true if a RAM-type device with a @ram_block

We call this a "RAM memory region" in memory.rst and in
other doc comments in this file.

> + * @subpage: true if region covers a subpage

This is the kind of doc comment that doesn't tell us anything
we didn't already know from the field name. More useful would
be to explain what the subpage handling is actually doing.

> + * @readonly: true for RAM-type devices that are readonly
> + * @nonvolatile: true for nonvolatile RAM-type devices (e.g. NVDIMM)
> + * @rom_device: true for a ROM device, see also @romd_mode
> + * @flush_coalesced_mmio: true to flush any queued coalesced MMIO
> + * operations before access
> + * @unmergeable: this section should not get merged with adjacent
> + * sections
> + * @dirty_log_mask: dirty events region cares about (see DIRTY_ flags)
> + * @is_iommu: true if part of an IOMMU device
> + * @ram_block: backing @RamBlock if @ram is true
> + * @owner: base QOM object that owns this region
> + * @dev: base Device that owns this region
> + * @ops: access operations for MMIO or @romd_mode devices
> + * @opaque: @dev specific data, passed with @ops
> + * @container: parent `MemoryRegion`
> + * @mapped_via_alias: number of times mapped via @alias, container
> + * might be NULL
> + * @size: size of @MemoryRegion
> + * @addr: physical hwaddr of @MemoryRegion

I think this is not a physical address; it's the address
(i.e. offset) of this MR within its parent MR @container.

> + * @destructor: cleanup function when @MemoryRegion finalized
> + * @align: alignment requirements for any physical backing store
> + * @terminates: true if this @MemoryRegion is a leaf node
> + * @ram_device: true if @ram device should use @ops to access

This doesn't sound right. True if this MR is a RAM device memory
region (i.e. it is backed using a pointer corresponding to a
host physical device); see @memory_region_init_ram_device_ptr().

We should also add "RAM device" to the "Types of regions"
list in docs/devel/memory.rst, which is currently missing it.

> + * @enabled: true once initialised, false once finalized

Not very useful, as it misses entirely the use of the flag.
Enabled MRs appear in the guest's memory space; non-enabled
MRs are ignored. By default MRs are enabled, but they can
be enabled and disabled at runtime using memory_region_set_enabled().

> + * @vga_logging_count: count of memory logging clients
> + * @alias: link to aliased @MemoryRegion

If this is an alias MemoryRegion, pointer to the MR we are aliasing.

> + * @alias_offset: offset into aliased region
> + * @priority: priority when resolving overlapping regions
> + * @subregions: list of subregions in this region
> + * @subregions_link: next subregion in the chain
> + * @coalesced: list of coalesced memory ranges
> + * @name: name of memory region
> + * @ioeventfd_nb: count of @ioeventfds for region
> + * @ioeventfds: ioevent notifiers for region
> + * @rdm: if exists see #RamDiscardManager
> + * @disable_reentrancy_guard: if true don't error if device accesses its=
elf
>   */
>  struct MemoryRegion {
>      Object parent_obj;
> @@ -806,7 +845,7 @@ struct MemoryRegion {
>      const MemoryRegionOps *ops;
>      void *opaque;
>      MemoryRegion *container;
> -    int mapped_via_alias; /* Mapped via an alias, container might be NUL=
L */
> +    int mapped_via_alias;
>      Int128 size;
>      hwaddr addr;
>      void (*destructor)(MemoryRegion *mr);
> --
> 2.39.2

thanks
-- PMM


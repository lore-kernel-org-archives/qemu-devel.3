Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39275CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDCT-0005dm-QR; Mon, 15 Jun 2026 15:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDCM-0005d7-MX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDCI-0003Sq-P3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781552531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qi3yLOX+GX7yFtlr/F7eOJTa/nSf4uKiVPbZwlIlxc0=;
 b=F/YnNRb/i9z+M0RE4QO7ft7TLTuLKIM+FW4geTZsPo1ihBC2N8lDLWBMShxNA4kQ+fZZJk
 9+pYzO1xvlJNFIz29FkZCwl4Jcle5eaOk6s7vx0lmBYN71S9chcJ1CFPbwTYF6QxqRYwod
 w0zMxASmRcp0Be0z4VvwvOhdvNXUWnA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-OFx_puyNOMaw4WJCq0fDFA-1; Mon, 15 Jun 2026 15:42:10 -0400
X-MC-Unique: OFx_puyNOMaw4WJCq0fDFA-1
X-Mimecast-MFC-AGG-ID: OFx_puyNOMaw4WJCq0fDFA_1781552529
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4601102c30dso2236651f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781552529; x=1782157329; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qi3yLOX+GX7yFtlr/F7eOJTa/nSf4uKiVPbZwlIlxc0=;
 b=O+sfrhDk5gOau1vi89bim1ySHb9CE43TByx4iiFITxdlB3mLzHNkXO6bP+El5qzSyk
 5YhoqvUTQpe+PeeNdORONf1Kx0UCLDT/ByYqBi9NEYCFO78N13a3MWDVsvE2456hTn+Y
 J3/0JjdqVOrYJNTEUBSU8PyFj1TtuS1EWCyxmKnZqbsC3z2ZudQdNVQrswO+O89s+PJJ
 bR7c256Iye1bYTI63M5PO9NaRs+68HRh8ADh3oahX1mzUHYstVNluy/hydxIUKx+nPNN
 74YJTDSfZrv+IYviHdbzMb8rShv8H51C8EYHRMQGQcXrG7pqWTFyozVSFKo7aRs6fmqu
 hwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552529; x=1782157329;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qi3yLOX+GX7yFtlr/F7eOJTa/nSf4uKiVPbZwlIlxc0=;
 b=L5TLR76bLgiH7YTF05wBs6Aa72ju3oC/eSRnVZsZtEn8lnbwXQEr07ktK7Cw50Yrgt
 l1zlv5R9NugKiqEDRdhIFURBvcEIfN9rPwtvetEvUrVX/51x7Aief32xz8s1cOkj928h
 HlxEwTGym+w42qFziUpVufaDgEa/7NogqgKYcQfnCH6Hk0qzeG2XriyKAdFot59s/tS/
 cIyx2csxIKxZDD/Pr/43t0EFngXsIYB9Nk2TUbbebonc9ttL/Wq88ALUY8bCWwm6NV0n
 xQuMiFySozZNxIXv3tzNzUFrGUgiWZwj54/55vEymqR/IouuuwdAwf/UNezYthbSqVJJ
 D3FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XYsivCGXXDkGOR2TtyetRvG574cIdH+nZ7h/FzlnLGL/xkFhr8qHyqPpaFe9DHok35XzrM0tiFte3@nongnu.org
X-Gm-Message-State: AOJu0Yzlt0g3k2ZcepUV9eq/vtfAhRDs7CoS0lpLWJgmocebW6MwcH8R
 RUHQM2NOZ5o+zUXJjEh4P/oJtHnpWnToIXQr6fodEuCzbBbTyQhgRT1oG1Lsp7xN0irlqzwUFgh
 CoM9l7itLtbdUchuUlie8ZchPQZIscqE4tusfVj/MuokZDyIUGturPxbWCp7AfcuM
X-Gm-Gg: Acq92OGzjtxRV+JN4nH4EvGBRDl5uQqqt29yfrRz2jsMgftzTntsKJ/VxMDwbriKe2Z
 rMXrKY3MwT3dZisMt0R2RAl+pI9GUu6QOwqgduscUc160WIyuqjBYPoRfhQnZSWHwtfK3k883Gd
 G/NaGMpaGyB5SD+WVxbN3XWNYHXzwhADHAr3OIBbef+FP8z4Pi1Qk+25EF15Hh4O8g1ThbwoC19
 nYE5sb55mdheJN/fXJ21+0amVtXlxBaOp6s3A6tzMhNa1CTroFh0gaYLt/GXFLqeHfq0zfzQoeB
 MGSgjTy4q+1NTjldyxoQeSaxNmae0Jjwb5tFCI7rLtThETk4EWxKV1N0KvfTFnEgE84h4QgC9sH
 aWEkAuOylwU/NTEGYqHSXV9t7JPHHq/yU/UEsdjU8UqY=
X-Received: by 2002:a05:6000:1863:b0:461:946f:9bb4 with SMTP id
 ffacd0b85a97d-4619f3abb97mr1148881f8f.23.1781552529001; 
 Mon, 15 Jun 2026 12:42:09 -0700 (PDT)
X-Received: by 2002:a05:6000:1863:b0:461:946f:9bb4 with SMTP id
 ffacd0b85a97d-4619f3abb97mr1148850f8f.23.1781552528528; 
 Mon, 15 Jun 2026 12:42:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cd6c2sm37181798f8f.30.2026.06.15.12.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:42:07 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:42:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260615154054-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 16, 2026 at 05:24:15AM +1000, Gavin Shan wrote:
> Hi Peter and Michael,
> 
> On 6/16/26 1:12 AM, Peter Maydell wrote:
> > On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
> > > > On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
> > > > > 
> > > > > All ram device regions were turned to be indirectly accessible by commit
> > > > > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > > > > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > > > > guest is started by the following command lines, with GH100 GPU card passed
> > > > > from the host.
> > > > 
> > > > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > > > index 1417132f6d..5878727d09 100644
> > > > > --- a/include/system/memory.h
> > > > > +++ b/include/system/memory.h
> > > > > @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> > > > >   void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> > > > > 
> > > > >   /* Internal functions, part of the implementation of address_space_read.  */
> > > > > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > > > > +void qemu_ram_move(void *dest, const void *src, size_t n);
> > > > 
> > > > New function prototypes in include headers need documentation comments.
> > > > 
> > > > In particular for these, it's really important that we clearly say
> > > > what semantics we are attempting to provide with them, so that
> > > > (a) when we're reviewing or later updating the implementation we
> > > > know what we are trying to provide
> > > > (b) when we're looking at the callsites we know what the function
> > > > is guaranteeing to us and what it is not, and thus whether it's
> > > > OK to use it or we need something els.
> > > > 
> > > > > +#if defined(__i386__) || defined(__x86_64__)
> > > > > +#define HOST_UNALIGNED_MMIO_OK 1
> > > > > +#else
> > > > > +#define HOST_UNALIGNED_MMIO_OK 0
> > > > > +#endif
> > > > 
> > > > We need to do something better than this. We can't
> > > > just say "oh, we trust that on x86 this works": it is
> > > > neither actually true that the compiler guarantees it
> > > 
> > > sorry guarantee what?
> > 
> > Well, that's part of my point about "we need a doc comment":
> > what exactly are we trying to guarantee ? But whatever it is,
> > "hardcoded ifdef that privileges x86" is definitely the wrong
> > answer.
> > 
> 
> Could you please check the following comments (documentation context) for the
> added functions look good to you? Please let me know if there are anything
> can be improved.
> 
> +
> +/**
> + * qemu_ram_copy: copy data to a RAMBlock
> + *
> + * @dest: destination where the data is copied to. It's the pointer returned
> + *        by ramblock_ptr() and its variants.
> + * @src: source where the data is copied from. It can be a regular memory block
> + *       or a pointer returned by ramblock_ptr() and its variants.
> + * @n: length of data to be copied
> + *
> + * The destination is always a pointer to data area of a RAMBlock which can
> + * be for a regular memory block or a MMIO region. The source can be a pointer
> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
> + * memcpy() to copy data between those MMIO regions as we do in this function.
> + * Besides, unaligned accesses are well handled on all architectures except
> + * i386 and x86_64 where the unaligned accesses are supported by the CPUs.
> + *
> + * The ensured atomicity and alignment consideration, which aren't needed
> + * by data copy between two regular memory blocks. So performance penalty
> + * is introduced by this function in such circumstance.
> + */
> +void qemu_ram_copy(void *dest, const void *src, size_t n);
> +
> +/**
> + * qemu_ram_move: move data to a RAMBlock
> + *
> + * @dest: destination where the data is moved to. It's the pointer returned
> + *        by ramblock_ptr() and its variants.
> + * @src: source where the data is moved from. It can be a regular memory block
> + *       or a pointer returned by ramblock_ptr() and its variants.
> + * @n: length of data to be moved
> + *
> + * The destination is always a pointer to data area of a RAMBlock which can
> + * be for a regular memory block or a MMIO region. The source can be a pointer
> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
> + * memmove() to move data from or to those MMIO regions as we do in this
> + * function. Besides, unaligned accesses are well handled on all architectures
> + * except i386 and x86_64 where the unaligned accesses are supported by the
> + * CPUs.
> + *
> + * The ensured atomicity and alignment consideration, which aren't needed
> + * by data movement between two regular memory blocks. So performance penalty
> + * is introduced by this function in such circumstance.
> + */
> +void qemu_ram_move(void *dest, const void *src, size_t n);
> +


I apologize, I don't understand what these comments are saying, at all.



> > -- PMM
> > 
> 
> Thanks,
> Gavin



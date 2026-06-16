Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3481CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLKn-00085P-VT; Tue, 16 Jun 2026 00:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLKj-00080x-QI
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZLKf-0001vG-O8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781583801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YoMpu5tWzRA7ZtBBFqYSjY/1BNBuoW+yP8901L5VGlU=;
 b=Z078oF+ZEQLJvwsi0HtdLir6DnaW7K2rX92ogbPwckarGvgHVUl6TGYD6BH+taOe4hmJmd
 Q9QM5vxEdoqH9sAra37gQBQnTSo93tzB66rnbiLU4WoXgPMY2qFBX3g/SuTiys1MAsVrBp
 lur+s9UARx6VlecWQwpQRD1LPjtF6V4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-4DmpfJgSN76ixWqL1VPwsA-1; Tue, 16 Jun 2026 00:23:19 -0400
X-MC-Unique: 4DmpfJgSN76ixWqL1VPwsA-1
X-Mimecast-MFC-AGG-ID: 4DmpfJgSN76ixWqL1VPwsA_1781583798
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef63d1214so2568069f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781583798; x=1782188598; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YoMpu5tWzRA7ZtBBFqYSjY/1BNBuoW+yP8901L5VGlU=;
 b=db0f56W1xZa5BAEl02mxE9QtYEL+d+xfnFNRjyzWCeGvvWYnBREyPcT0UC1+YlD8Sr
 p79pK6/knm1iPvytBoftOEQRVWcnTaWW5n0OpcXLhO20c8ac6IDJu5+1F9Vq95VWcUmo
 NB5N0ZvfLqh8qtcEEzkUx3ia9BUIH5iFnUA+rXzJI/kgLEU+hqkHd3jXbDVFpwYgzFo8
 FDu9LItyGfZcEeA4ww9T99Xje6fMVSDEuL9mPNNq/fFfszmhxghuPrX1ZGJPswdjZyMz
 GQTV2PKDHTnT36d+86LGSTDVGdsn9FpONhI7I2OC4MAHIJYQKhnnNE2wFp69F6uyWAC5
 LwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781583798; x=1782188598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoMpu5tWzRA7ZtBBFqYSjY/1BNBuoW+yP8901L5VGlU=;
 b=cOhpHQ2j0fQApAq9xWpy9PQrpAk3BrO2UmXHGXQpPPptXDWY/SaeFFlQhfQnWxZdVQ
 4DxaNxgRbXrPeod87X84OBbtIkERy80Zk1DKDdBcV8gHFwQUgeb6wiqEYHUxYzeRbz+B
 OHJ/GzYw10ZoQqp9uPEmW1YdiI1Khac1SxqSMohd+JVNenoFncfmDv6XwC464qSfn0YE
 NOC+qUqPOVKQmgQ0HpP2x9PyqeFoKIpJxHsattrDTIVUgeRTccLWk6cNrigtA+CON8dw
 3xUiTTaxxzs/48dzfmXRJUdcln9Zod3kLVY3fCE7bnULnPmiE4Z8YxCIDcLEQXQhb+xi
 ICNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m+SBMYeusFUnHEIAwQIg7ojUFhOVXuq9Hsu2JRiM8ThX1tO1hO9sYHahzp23EA+Wl0uXZ1mgmpU4d@nongnu.org
X-Gm-Message-State: AOJu0YzcMXMgNe2vUgHC2lALm/j1xzZ2pK6IIDjHhagsVPoEDTqPvHW8
 IF5uMKwHt9iEd/oEwMRck2g3W6bBJPYiQ4tC63NmGSgYH+m6Uj47ImG3aCSfoXSb0glxiggNHlE
 6a2a4P2WegGu9EJyXDAEKjtn9iZ9KcHAbhBjimQrdRtkiqROSUldbgxSX
X-Gm-Gg: Acq92OGtyq5g/osRfcXTDOAsoG5ZE2jDpHYwRhpSXvYMMpF/+5Gk/0YbFNhsdKRTxL2
 MzI4B8uRMb95y4dXOWwfE9jeUVMgTkWTFd/qm4smbn73DJz6MIDD3TgYnsQEiBl0XhLEXWydqrL
 hmOqhkpAI927Xc0NXkZVIUzvr8xYQ6RNx1pfm3Wz8VGnWhNQ1udb8SUx2XmJ2OR8WFx7ho40DX5
 2akqxnhoJiWsuf2TKB/R9m3VEsizTFgq1AZ4A7zUQyH2iU2fJrYUzZfPWxAsWPFobC//NuYO0b8
 d7DjAxNdWqNmt+M691HQsg0bj+PxP2APJ+dBK4agLlPURP1fgiwU/3LxGWrqJhsBH9j3vjMl2ea
 +vFQm3UQrh5QX5zmnvYgK+wrsHNlALoGASvHHW6muQs4=
X-Received: by 2002:a5d:6f1a:0:b0:460:e4d:bd46 with SMTP id
 ffacd0b85a97d-4619f3ac104mr3130328f8f.21.1781583798087; 
 Mon, 15 Jun 2026 21:23:18 -0700 (PDT)
X-Received: by 2002:a5d:6f1a:0:b0:460:e4d:bd46 with SMTP id
 ffacd0b85a97d-4619f3ac104mr3130281f8f.21.1781583797491; 
 Mon, 15 Jun 2026 21:23:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3dcsm38446884f8f.13.2026.06.15.21.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 21:23:16 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:23:12 -0400
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
Message-ID: <20260615224658-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 07:31:04AM +1000, Gavin Shan wrote:
> On 6/16/26 5:42 AM, Michael S. Tsirkin wrote:
> > On Tue, Jun 16, 2026 at 05:24:15AM +1000, Gavin Shan wrote:
> > > Hi Peter and Michael,
> > > 
> > > On 6/16/26 1:12 AM, Peter Maydell wrote:
> > > > On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
> > > > > > On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
> > > > > > > 
> > > > > > > All ram device regions were turned to be indirectly accessible by commit
> > > > > > > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > > > > > > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > > > > > > guest is started by the following command lines, with GH100 GPU card passed
> > > > > > > from the host.
> > > > > > 
> > > > > > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > > > > > index 1417132f6d..5878727d09 100644
> > > > > > > --- a/include/system/memory.h
> > > > > > > +++ b/include/system/memory.h
> > > > > > > @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> > > > > > >    void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> > > > > > > 
> > > > > > >    /* Internal functions, part of the implementation of address_space_read.  */
> > > > > > > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > > > > > > +void qemu_ram_move(void *dest, const void *src, size_t n);
> > > > > > 
> > > > > > New function prototypes in include headers need documentation comments.
> > > > > > 
> > > > > > In particular for these, it's really important that we clearly say
> > > > > > what semantics we are attempting to provide with them, so that
> > > > > > (a) when we're reviewing or later updating the implementation we
> > > > > > know what we are trying to provide
> > > > > > (b) when we're looking at the callsites we know what the function
> > > > > > is guaranteeing to us and what it is not, and thus whether it's
> > > > > > OK to use it or we need something els.
> > > > > > 
> > > > > > > +#if defined(__i386__) || defined(__x86_64__)
> > > > > > > +#define HOST_UNALIGNED_MMIO_OK 1
> > > > > > > +#else
> > > > > > > +#define HOST_UNALIGNED_MMIO_OK 0
> > > > > > > +#endif
> > > > > > 
> > > > > > We need to do something better than this. We can't
> > > > > > just say "oh, we trust that on x86 this works": it is
> > > > > > neither actually true that the compiler guarantees it
> > > > > 
> > > > > sorry guarantee what?
> > > > 
> > > > Well, that's part of my point about "we need a doc comment":
> > > > what exactly are we trying to guarantee ? But whatever it is,
> > > > "hardcoded ifdef that privileges x86" is definitely the wrong
> > > > answer.
> > > > 
> > > 
> > > Could you please check the following comments (documentation context) for the
> > > added functions look good to you? Please let me know if there are anything
> > > can be improved.
> > > 
> > > +
> > > +/**
> > > + * qemu_ram_copy: copy data to a RAMBlock
> > > + *
> > > + * @dest: destination where the data is copied to. It's the pointer returned
> > > + *        by ramblock_ptr() and its variants.
> > > + * @src: source where the data is copied from. It can be a regular memory block
> > > + *       or a pointer returned by ramblock_ptr() and its variants.
> > > + * @n: length of data to be copied
> > > + *
> > > + * The destination is always a pointer to data area of a RAMBlock which can
> > > + * be for a regular memory block or a MMIO region. The source can be a pointer
> > > + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
> > > + * memcpy() to copy data between those MMIO regions as we do in this function.
> > > + * Besides, unaligned accesses are well handled on all architectures except
> > > + * i386 and x86_64 where the unaligned accesses are supported by the CPUs.
> > > + *
> > > + * The ensured atomicity and alignment consideration, which aren't needed
> > > + * by data copy between two regular memory blocks. So performance penalty
> > > + * is introduced by this function in such circumstance.
> > > + */
> > > +void qemu_ram_copy(void *dest, const void *src, size_t n);
> > > +
> > > +/**
> > > + * qemu_ram_move: move data to a RAMBlock
> > > + *
> > > + * @dest: destination where the data is moved to. It's the pointer returned
> > > + *        by ramblock_ptr() and its variants.
> > > + * @src: source where the data is moved from. It can be a regular memory block
> > > + *       or a pointer returned by ramblock_ptr() and its variants.
> > > + * @n: length of data to be moved
> > > + *
> > > + * The destination is always a pointer to data area of a RAMBlock which can
> > > + * be for a regular memory block or a MMIO region. The source can be a pointer
> > > + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
> > > + * memmove() to move data from or to those MMIO regions as we do in this
> > > + * function. Besides, unaligned accesses are well handled on all architectures
> > > + * except i386 and x86_64 where the unaligned accesses are supported by the
> > > + * CPUs.
> > > + *
> > > + * The ensured atomicity and alignment consideration, which aren't needed
> > > + * by data movement between two regular memory blocks. So performance penalty
> > > + * is introduced by this function in such circumstance.
> > > + */
> > > +void qemu_ram_move(void *dest, const void *src, size_t n);
> > > +
> > 
> > 
> > I apologize, I don't understand what these comments are saying, at all.
> > 
> 
> Sorry to hear that, Michael. There are two things done in the newly added
> function qemu_ram_{copy, move}(), comparing to the original memcpy() and
> memmove():
> 
> - Data copy or movement on MMIO region(s) using __bultin_{memcopy, memmove}()
>   on x86, or qatomic_set() on other architecutures, to avoid the unexpected
>   optimization done by the compiler on memcpy/memmove. Unsafe instructions
>   can be produced by the compiler's optimization. This fixes the issue resolved
>   by commit 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
> 
> - The unaligned access is handled by forcing the access size aligned to (src | dest | n)
>   on non-x86 architectures, comparing to the original memcpy() and memmove().

Well first of all let's start with listing what the problems are.
Below is my understanding of the issues:

1. On x86, memcpy is different from __builtin_memcpy if
one uses old 1.0 force-headers from 2019. Likely no longer relevant.


2. variable length memcpy can translate 2,4,8 byte guest access
into multiple byte accesses. doing this for mmio is
guaranteed to break devices.


3. (theoretical concern) also on x86, unaligned accesses are possible on guest and host,
so converting an unaligned access to a series of aligned ones can
in theory break devices.

4. also on x86, vector instructions for large (>16 byte) writes
into pgprot_noncached memory are safe and faster than multiple 8 byte
ones. 

5. also on x86 it so happens that if you write a fixed-size memcpy this
gets optimized to a single store/load and it works for aligned and
unaligned addresses on that architecture. How to ensure this keeps being
correct is left as an excerise for the reader. But qemu already relies
on this and did for years. 

6. on non-x86 both unaligned accesses and vector instructions
for accessing  UC memory are illegal.

7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86
guest can
map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
If it does the second then it can use unaligned or vector for access.
This is why normal passthrough tends to work - it never traps to qemu at
all.

But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
can't use unaligned or vector instructions on non-x86.


8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
so qemu could safely use unaligned/vector instructioons even on non-x86.

9. Except sadly, vfio currently does not tell qemu how it maps
the memory, so qemu can not know what is safe on non-x86.





Now, what is to be done?


A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
At least for aligned, perferably for unaligned accesses too.
Fixed width memcpy seems to work for this. Whether we should bother with
__builtin to work around broken old fortify headers, I donnu.
I do not have any answer how to check that compiler does this correctly.
If anyone is motivated enough, adding a GCC builtin could be possible.
Given qemu did this for years, I think we can leave solving this for
another day.

B. Also on x86, I do not see why we should not use memcpy for large
accesses if we can. Better perf.

C. on non-x86, we currently must not memcpy since we do not know
if it is pgprot_noncached. yes, performance will be
bad for DMA into device RAM.




D.  It goes without saying that casting an unaligned address to unint32_t
(be it for qatomic_set or whatever) is undefined behaviour in C
and so a bad idea on any architecture.


E. also for non-x86, we really should teach vfio to tell qemu whether
it maps device pgprot_noncached or pgprot_writecombine.
we will then be able to use memcpy for >8 accesses.



Anyone, correct me if I'm wrong? Maybe I should start a new thread with
this summary?



> 
> Please let me know if we're on same page. If we do, I can revise the comments
> accordingly.
> 
> > 
> > 
> > > > -- PMM
> > > > 
> 
> Thanks,
> Gavin



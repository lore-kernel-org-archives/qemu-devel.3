Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678A9FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 14:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp7aO-00026m-Gn; Fri, 13 Sep 2024 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7aN-00025b-4N
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7aL-0004i7-9z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 10:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726238864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eDOIiQMChf/h+O4JCGa9kAswsfqChnrgVwSE0jg62oY=;
 b=TS21fFokZ3mMGLZAVXLW5eD/BmxQqaJCP+3YmipsY9yHWVoGAlBLUxNJkst0g+hAQzlYjg
 duczG0jD4RH+KWt4AYROoXNSK54IMzXQpopzQJofnzJe2n77mo/BVQVAK4TOHRQVqmAFD8
 QyB6sGMGaDAle8zJpZg+23VqMHOxkEY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-ErKwPTTsNi-uUJuWD3Sahw-1; Fri, 13 Sep 2024 10:47:42 -0400
X-MC-Unique: ErKwPTTsNi-uUJuWD3Sahw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c353d32ea0so28872366d6.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 07:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726238862; x=1726843662;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eDOIiQMChf/h+O4JCGa9kAswsfqChnrgVwSE0jg62oY=;
 b=bExWRYoeXjyEAcBRD/r1wZFi2pyxAkCbAQJ3nvyUZlIDhHHW3dyUX4w1/Tr+rllOWA
 G7GBX9Z0lXGz4lm8+yrIQ9cNnJc9ctb4mCa496MUdo/mCdZDJLM9NwaxM0B1vkE5Bi/n
 Ge8Mf2o4njZuL0ATjFNW3if6X4RCQE5KMT6bEMDhDEwG6+zpeH1maQmgOmuoECkmI+LG
 ABplpXdk1Qk43uFVda9um7c6z5y6Zy+7HqM/8EbwTj3H9PFJxaoWVkmUsoZSGDMRSj5S
 +o6ADrNQwxr87letgyt0+3XH+tAmKFvdc3u/KrDUjLAXBeiBUjDGhReORVucYMoquFRU
 SKMg==
X-Gm-Message-State: AOJu0Yzupc/CiOb0+51egciq2/rlPMxQwyPvQJHNzQ9WOrBmDM+RfU6z
 5eU+GYJSK29jxw54vZ6ulFRX/NAquN5uYC5xpqmvN4GX/VL2f3nYulgMwtnsCJz43CSvOSXU95H
 2A9h48LfyLwaIpzd6Q34cG/zIMXW5bWmHCUhjxwCKyu7pFnbBzuwq
X-Received: by 2002:ac8:5f87:0:b0:458:4323:d7b3 with SMTP id
 d75a77b69052e-45860325be2mr90622211cf.34.1726238861969; 
 Fri, 13 Sep 2024 07:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcuMdqKpIx10weU+aVUzAnF7lB+y4V+2kr5Wuc9lrruvgqJj27EzfOi743WTSHelsjHO937A==
X-Received: by 2002:ac8:5f87:0:b0:458:4323:d7b3 with SMTP id
 d75a77b69052e-45860325be2mr90621851cf.34.1726238861500; 
 Fri, 13 Sep 2024 07:47:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f6097fsm65410211cf.63.2024.09.13.07.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 07:47:40 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:47:38 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Mattias Nissler <mnissler@rivosinc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
Message-ID: <ZuRQirmjwWGj1N2D@x1n>
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441f797f-a377-45de-bfe6-042542c917d8@kaod.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 13, 2024 at 04:35:32PM +0200, Cédric Le Goater wrote:
> Hello,
> 
> +Mark (for the Mac devices)
> 
> On 9/9/24 22:11, Peter Xu wrote:
> > From: Mattias Nissler <mnissler@rivosinc.com>
> > 
> > When DMA memory can't be directly accessed, as is the case when
> > running the device model in a separate process without shareable DMA
> > file descriptors, bounce buffering is used.
> > 
> > It is not uncommon for device models to request mapping of several DMA
> > regions at the same time. Examples include:
> >   * net devices, e.g. when transmitting a packet that is split across
> >     several TX descriptors (observed with igb)
> >   * USB host controllers, when handling a packet with multiple data TRBs
> >     (observed with xhci)
> > 
> > Previously, qemu only provided a single bounce buffer per AddressSpace
> > and would fail DMA map requests while the buffer was already in use. In
> > turn, this would cause DMA failures that ultimately manifest as hardware
> > errors from the guest perspective.
> > 
> > This change allocates DMA bounce buffers dynamically instead of
> > supporting only a single buffer. Thus, multiple DMA mappings work
> > correctly also when RAM can't be mmap()-ed.
> > 
> > The total bounce buffer allocation size is limited individually for each
> > AddressSpace. The default limit is 4096 bytes, matching the previous
> > maximum buffer size. A new x-max-bounce-buffer-size parameter is
> > provided to configure the limit for PCI devices.
> > 
> > Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Acked-by: Peter Xu <peterx@redhat.com>
> > Link: https://lore.kernel.org/r/20240819135455.2957406-1-mnissler@rivosinc.com
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/exec/memory.h       | 14 +++----
> >   include/hw/pci/pci_device.h |  3 ++
> >   hw/pci/pci.c                |  8 ++++
> >   system/memory.c             |  5 ++-
> >   system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
> >   5 files changed, 76 insertions(+), 36 deletions(-)
> 
> Here is a report of a segv of the ppc64 mac99+cpu970 machine booting debian.
> See the stack trace below. Just wanted to let you know. I will digging further
> next week.
> 
> Thanks,
> 
> C.
> 
> 
> 
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> address_space_unmap (len=<optimized out>, access_len=0, is_write=false, buffer=0x0,
>     as=0x5555565d45c0 <address_space_memory>) at ../system/physmem.c:3333
> 3333	    assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
> (gdb) bt
> #0  address_space_unmap
>     (len=<optimized out>, access_len=0, is_write=false, buffer=0x0, as=0x5555565d45c0 <address_space_memory>)
>     at ../system/physmem.c:3333
> #1  address_space_unmap
>     (as=as@entry=0x5555565d45c0 <address_space_memory>, buffer=0x0, len=<optimized out>, is_write=<optimized out>, access_len=0) at ../system/physmem.c:3313
> #2  0x000055555595ea48 in dma_memory_unmap
>     (access_len=<optimized out>, dir=<optimized out>, len=<optimized out>, buffer=<optimized out>, as=<optimized out>) at /home/legoater/work/qemu/qemu.git/include/sysemu/dma.h:236
> #3  pmac_ide_atapi_transfer_cb (opaque=0x555556c06470, ret=<optimized out>) at ../hw/ide/macio.c:122
> #4  0x00005555559861f3 in DBDMA_run (s=0x555556c04c60) at ../hw/misc/macio/mac_dbdma.c:546
> #5  DBDMA_run_bh (opaque=0x555556c04c60) at ../hw/misc/macio/mac_dbdma.c:556
> #6  0x0000555555f19f33 in aio_bh_call (bh=bh@entry=0x555556ab5570) at ../util/async.c:171
> #7  0x0000555555f1a0f5 in aio_bh_poll (ctx=ctx@entry=0x5555566af150) at ../util/async.c:218
> #8  0x0000555555f0269e in aio_dispatch (ctx=0x5555566af150) at ../util/aio-posix.c:423
> #9  0x0000555555f19d8e in aio_ctx_dispatch
>     (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at ../util/async.c:360
> #10 0x00007ffff7315f4f in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> #11 0x0000555555f1b488 in glib_pollfds_poll () at ../util/main-loop.c:287
> #12 os_host_main_loop_wait (timeout=2143429) at ../util/main-loop.c:310
> #13 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:589
> #14 0x0000555555abeba3 in qemu_main_loop () at ../system/runstate.c:826
> #15 0x0000555555e63787 in qemu_default_main () at ../system/main.c:37
> #16 0x00007ffff6e29590 in __libc_start_call_main () at /lib64/libc.so.6
> #17 0x00007ffff6e29640 in __libc_start_main_impl () at /lib64/libc.so.6
> #18 0x000055555588d4f5 in _start ()

Thanks for the report!

Mattias,

Would you have time to take a look?

Thanks,

-- 
Peter Xu



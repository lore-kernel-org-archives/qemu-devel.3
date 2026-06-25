Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBAACDE009
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wchvX-0002Ul-3Z; Thu, 25 Jun 2026 07:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wchvU-0002Tp-Qc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 07:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wchvS-0003C9-L2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 07:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782385637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FATEn9IvSP3MQ1Fjm9Coqc+dZt8lLEF7L1VVxIDM9qs=;
 b=A/csQadJZlj2evI5gs4UnTPLUfFby98/uALbnYEI+UMwZIOCVI1NItL/mraQ35YV9Io92g
 rmHJmPG9rIad3JBI5JeukhEyRMYr84wIIeDVRm8J/AT8c2wsYFk2IYb6l4z3aGGZKqpTir
 fW7zOiqh8HnH+1zd5qjx20dM+KjCOog=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-spJQE1YVNmSP9ZyScvLPaQ-1; Thu, 25 Jun 2026 07:07:13 -0400
X-MC-Unique: spJQE1YVNmSP9ZyScvLPaQ-1
X-Mimecast-MFC-AGG-ID: spJQE1YVNmSP9ZyScvLPaQ_1782385632
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46d71a1791fso824966f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782385632; x=1782990432; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FATEn9IvSP3MQ1Fjm9Coqc+dZt8lLEF7L1VVxIDM9qs=;
 b=pj6kshgEUfc+y0k43OtcJ2IpY5ldF65t2NKBIpHURY+Lpfy5+z29FVS5ha0P1K/6BS
 jFPSzMm2whY5s170Qr3vQjRGXn2pP1ZtJ46/RNn+LotOP3+2qkofIlEXoxXrQB2mHXLn
 31Fv/g/YKZ21f29+2LIbNsNi+caYndnrMUBWrWNIEKyN915k2f5sl6qyR9XJe1dWPXHu
 wmFQZ98alrhZCOsp5AaKYi0OmLUBmECiMzQUogzoF2TZ9V9p35cJ1SP4Cu55kCRtn2JU
 7jgUqvAk+r7PWx1bdorQezfQjcyMxnBVXNvmtlmGncH61ojxWAtlsWUkD71m9yaCs51b
 jfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385632; x=1782990432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FATEn9IvSP3MQ1Fjm9Coqc+dZt8lLEF7L1VVxIDM9qs=;
 b=WHaIukxHnNe+VEYro8Z7IahdMVgZC0KoSE+VS895hVm1yzD2cKSsQfg1ywamhsrRof
 Jlw/GaSR22PHKClxFeEMX9QMC0zZl5MkROstL0Wukhsr+Qv8r4jhAOhoOR6KFbZT0hZs
 Wi8OWOUs1Jx+M1JcjDFC7wO/uWQTmwZ24eZZ6KATPtFgO0R1G7SoUqGUWYog/cxnilV5
 6zby7TJrw0R9X/0lyT5GNf6A33J6trRekUQAe4Ooj6qCkUycxQenwqYrxbM1YsanV4hj
 /btTIjH5wdYAbR9x7saPcjWiHIsEpVRrltUHhW0RXNWEgMQj/amt9KXyxLkSdKDd1r3+
 bldg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8trbIG4rNh/sLh8RCcsmTSAzStn2BJkOv2ksc1CRsma5kqEoAOzwPNbJlxsEvm2go3kP/aniW5GcSe@nongnu.org
X-Gm-Message-State: AOJu0YyqFBh8gAcE//lb+q4GDZeIbEE8kueoTWWVGVOLCydCsc3BN0Mp
 niyRsHdHdL8OqXz4qwzFE2L4KAORibOb7hFHz6hoybcRSKLZ6MtiBN5OLblH8HuHjzjP2wEI6Ip
 crEKIVY5uSYw9EAz8oHZTZUolqWPV2oOK7i0aP3JNo8qFB9xUc5gmv9l7
X-Gm-Gg: AfdE7ck5YkEFKYTj1Cpb72eIFHJ7tqR4YiYqWsF2+4mc5qHOaZdd2vi8JkxONtP/MKR
 7KuG/vVLOVjLkwy7F35NHd447+TgDKgPw3RakJIRYxVRuekbVb5sUq8P9WlSD8UTIrCNDdd+87+
 DMle5Npgmmbhwj74H2Gpx5GHhKDuWOSyTnHBXnDmEPg507Ch65+c04LMCJb+qLs9VImFlZB96sN
 ypM0V2co/m71iiOgDGZSara86V0HfZBZnT2EXqyyPwLtdZwu6P8FaaEcwzOG6SFVQqSyewMBE4J
 ZChoaVSUawXGJugAd6wbMxsFyUC8w+djq57nM7xQYqVTGltGh3Jnxli10bBiU/vGtCLpW3iVf3R
 wMEjnHq3XQNHJqZwEOeriwKEdzdX6m2+V
X-Received: by 2002:a05:600c:8b25:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-4926684a70bmr27927965e9.8.1782385632259; 
 Thu, 25 Jun 2026 04:07:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b25:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-4926684a70bmr27927245e9.8.1782385631687; 
 Thu, 25 Jun 2026 04:07:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840eefsm18098222f8f.1.2026.06.25.04.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 04:07:11 -0700 (PDT)
Date: Thu, 25 Jun 2026 07:07:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260625070551-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 25, 2026 at 11:09:26AM +0100, Peter Maydell wrote:
> On Tue, 16 Jun 2026 at 06:26, Gavin Shan <gshan@redhat.com> wrote:
> >
> > All ram device regions were turned to be indirectly accessible by commit
> > 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> > to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> > guest is started by the following command lines, with GH100 GPU card passed
> > from the host.
> >
> >    host$ lspci | grep GH100
> >    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
> >    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
> >          -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
> >          -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
> >          -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
> >          -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
> >          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
> >            :
> >    guest$ cd cuda-samples/build
> >    guest$ make -j 20 clean
> >    guest$ make -j 20
> >            :
> >    [ 54%] Linking CUDA executable graphMemoryNodes
> >    [ 54%] Built target graphMemoryNodes
> >    <no more output afterwards, guest becomes frozen here>
> >
> >    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
> >    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> >
> > When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> > the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
> > be presented to the guest through memory hot-add. The page cache can
> > then be allocated from the hot added memory blocks when cuda-samples
> > is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
> > device as part of the DMA request, the bounce buffer has to be used to
> > accomodate the request as the corresponding memory region (MemoryRegion)
> > is an indirectly accessible ram device region in qemu. However, the max
> > bounce bufer size is only 4096 bytes by default and that is exhausted
> > quickly, leading to a reset on the virtio-blk device and frozen guest
> > eventually.
> >
> >   QEMU
> >   ====
> >   virtio_blk_handle_output
> >     virtio_blk_handle_vq
> >       virtio_blk_get_request
> >         virtqueue_pop
> >           virtqueue_split_pop
> >             virtqueue_map_desc
> >               address_space_map
> >                 memory_access_is_direct         # Return false
> >                   memory_region_supports_direct_access
> >
> >   (qemu) info mtree
> >   memory-region: pci_bridge_pci
> >     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> >       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
> >         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
> >           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> >
> > This adds qemu_ram_{copy, move}() and replaces {memcpy, memmove}() with
> > them in the ram device memory region accessors, similar to what's done
> > in commit 4a2e242bbb so that the issue (MMIO access instructions were
> > optimized to SSE instructions) covered by that commit is fixed. This
> > makes 'ram_device_mem_ops' redundant, paving the way to revert that
> > commit to make ram device region directly accessible again in the next
> > patch.
> >
> > Reported-by: Julia Graham <jugraham@redhat.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> > v3: Documentation for qemu_ram_{copy, move}           (Peter/Michael)
> >     Support qemu_ram_move() for overlapped src/dest   (Richard)
> >     Use {memcpy, memmove} if step is 16-bytes or more (Michael)
> >     Code improvements                                 (Richard/Michael)
> > ---
> >  hw/remote/vfio-user-obj.c |   4 +-
> >  include/system/memory.h   |  32 ++++++-
> >  system/physmem.c          | 178 +++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 207 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> > index 87fa7b6572..97a6c88780 100644
> > --- a/hw/remote/vfio-user-obj.c
> > +++ b/hw/remote/vfio-user-obj.c
> > @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
> >          ram_ptr = memory_region_get_ram_ptr(mr);
> >
> >          if (is_write) {
> > -            memcpy((ram_ptr + offset), buf, size);
> > +            qemu_ram_copy(ram_ptr + offset, buf, size);
> >          } else {
> > -            memcpy(buf, (ram_ptr + offset), size);
> > +            qemu_ram_copy(buf, ram_ptr + offset, size);
> >          }
> >
> >          return 0;
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index 1417132f6d..84203c312d 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -2897,6 +2897,36 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
> >  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
> >
> >  /* Internal functions, part of the implementation of address_space_read.  */
> > +
> > +/**
> > + * qemu_ram_copy: copy data to ramblock
> > + *
> > + * @dst: destination where the data is copied to
> > + * @src: source where the data is copied from
> > + * @n: length of data to be copied
> > + *
> > + *
> > + * Copy @n bytes from @src to @dst with the assumption that @src and @dst
> > + * do not overlap. Handles special cases such as uncacheable ramblocks
> > + * correctly. Use this for accessing ramblock in response to DMA/VCPU IO,
> > + * in preference to memcpy().
> > + */
> 
> The documentation for these functions needs to say what semantics
> the function is providing (e.g. can I rely on it to do a 4 byte aligned
> load as a single 4 byte read?). This does not.
> 
> > +/* x86 should work with __builtin_{memcpy, memmove}() for IO access */
> > +#if defined(__i386__) || defined(__x86_64__)
> > +#define HOST_UNALIGNED_MMIO_OK 1
> > +#else
> > +#define HOST_UNALIGNED_MMIO_OK 0
> > +#endif
> 
> This is still wrong. We should not have "x86 magically works
> and all other hosts do something different" ifdefs. Define what
> semantics you need and then we can figure out how to
> implement them.
> 
> My current thought is that we need to handle accesses of
> 1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
> do exactly one host load/store of that type, and that anything else
> is "the guest isn't relying on specific semantics here, we can just
> assume it's plain old RAM and do whatever". That would not
> require any architecture specific ifdefs.
> 
> thanks
> -- PMM


Well. X86 is special, as usual. It allows unaligned mmio so
we really have no way to know an x86 guest does not intend
just that. That can only be emulated perfectly on x86
which is sad but I see no reason to actively break it.



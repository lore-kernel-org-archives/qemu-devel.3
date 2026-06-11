Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2A3CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgfb-0007xR-Ag; Thu, 11 Jun 2026 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXgfH-0007rY-M8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXgfF-0007bB-5j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781189147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3w6pKkSwRiQnFFFBWRuGroK4e/P7yi1Yd5z28WSQcYM=;
 b=I8k5Rv/yZJwkaU3ug09zVrCXwTdDuRldMIy95DGEkfDzE57JZShZWHZzOG3UsCz8c+G9TC
 +oWmyUIKQiAHRSeCA7dPJA0eryooGWZAaiiN1EPURUcuD9V3TKh+3lCgaXzKLce+9Hah7k
 9TCTsV0lK9Q5Ux2uebMWZFBIamepaIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-YyJoTqcwNiqobvhg_Df_qQ-1; Thu, 11 Jun 2026 10:45:46 -0400
X-MC-Unique: YyJoTqcwNiqobvhg_Df_qQ-1
X-Mimecast-MFC-AGG-ID: YyJoTqcwNiqobvhg_Df_qQ_1781189145
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b37e1ebfso42280515e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781189145; x=1781793945; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3w6pKkSwRiQnFFFBWRuGroK4e/P7yi1Yd5z28WSQcYM=;
 b=RSSKCHJFJDSlLo0fUA81f2MhSe6ihemVs1ny2JZPV6HaSfEQnY0iyQyfWLoRi8D7sx
 EVvHAOgjxCMvWwIuxjX/JsHL+5xLjOZT9h6VIyLd+SPGPHoOI/e7Vc/2NOu53SFtMBiE
 5P8fuZxNhtUvCpmhttNOTtvUpJBMXomuAFENaCBhtJ5RB5OGnQ5vB8ZtcNKGy6V9MFc+
 p1fSqhwEFRlhdrNH1P9KhmLxpujgi9bLk9WCaaFFPI5+xsl0Vr4GPN6kSPtLP8FrDWKt
 OCZjtnIAwwH1MogJGSZqF62/BB2bFXnf8XABqBrKKeyaBNTBgrEOxTbSzcA1+TBTOtDq
 c4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189145; x=1781793945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3w6pKkSwRiQnFFFBWRuGroK4e/P7yi1Yd5z28WSQcYM=;
 b=gvy8T+csPuptFd9cSBwJNlxegA1KmTAS9qKpHB6yZrmgzzDQr1a2rbW69EFrwaIFu/
 ReOP0zuhKZIubS2C3nqqlbPFyKcCtl0tmGcrfkZCJeEzG4yyyw5g2s6dtRP+LmK2yUNa
 xxp+6DYGCX0iKDmOeKvay3sSXqbxPdqOcMLvibbzpEXJS0vtjkJ+7RM1nLbyvUWhHkiT
 ZbyNGVK85JmaLl5yC+XwpmJk3DZMP9cZBjtQQZjrSMuHHbVuW1HjQui/I+g9Li4fuU1z
 24/lHYSZ9mLnm0KN4r0U1VHnxDhCK4FyPilNVVuCoviqE7t8+4cL2+QZZjnL5Z0FpUx8
 dCLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DHC+qUfUqRCjZllUl/qjEJq3LXedCBF7LwzKRFi+UXLzeeLJLTU2FV4CiHkOx5A79tdigjnNecfL4@nongnu.org
X-Gm-Message-State: AOJu0YzNFZRzhTyHA8y//5fXKo2LALhxs8AsPiZiDYiti8mogfSV1Gv2
 243kIUeUM3kONrZUCYK+cOm3V1JrhwcrcoZrPKQsfqvVbmZ1aSIMwMblgpGwvw5Px0RO6s2IwcM
 9EYoFoU/sytUWoH7iLBO7Ch65+gXZXi7lXy+NcWpdQw9fGz54DNlJE7ub
X-Gm-Gg: Acq92OG2Ei15ReCwrgDnDD6WnwflLad9GKRewZ5heIfEUiqvn1l7atbyuS/QVQ51agN
 3HX1lFXXnA/5NOE4iMqhLGLhFNdBXfPVx8qlKjJ4rCyfTqwy9S0b6Xci5UzPeZzkdtUJq3CfPc2
 9AqlmU764CHwOuWka/KSqnOB+q+j7H+5ynb4atF8DLVkBFHxK4OP0peTbsILOZjmlv+4SA76Pkv
 3ZhSxJJSiZMMGTpE5QcO9XXMSW4n1Hl2vRWmhM4SRQqWoW6S1NWHMrfSAmFphvzI7E50c7tOqJ8
 33b/NmCWFcSHXM2BbCFZDRZBih2Xqi1z2XsBVSolIrgFwgLI+9BQlD3wszJZkUcBE57uQIM/7GD
 7fQ/jHl4TVQBO8bDCFpV7mFqTdwNMkd4w4DtBXc8aMbZ/M5WbydYc4g==
X-Received: by 2002:a05:600c:584d:b0:490:bada:6b15 with SMTP id
 5b1f17b1804b1-490e5619a2bmr31415855e9.17.1781189144824; 
 Thu, 11 Jun 2026 07:45:44 -0700 (PDT)
X-Received: by 2002:a05:600c:584d:b0:490:bada:6b15 with SMTP id
 5b1f17b1804b1-490e5619a2bmr31415345e9.17.1781189144242; 
 Thu, 11 Jun 2026 07:45:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm88483275f8f.17.2026.06.11.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:45:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:45:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com,
 qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611103513-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
 <20260611142022.GA202155@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611142022.GA202155@fedora>
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

On Thu, Jun 11, 2026 at 10:20:22AM -0400, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2026 at 05:00:51PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 02:30:46PM -0400, Stefan Hajnoczi wrote:
> > > On Wed, Jun 10, 2026 at 05:49:21AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > > > as reported by Julia.
> > > > > 
> > > > >    host$ lspci | grep GH100
> > > > >    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
> > > > >    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -accel kvm \
> > > > >          -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
> > > > >          -cpu host -smp cpus=32 -m size=8G                                  \
> > > > >          -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
> > > > >          -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
> > > > >          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
> > > > > 
> > > > >    guest$ cd cuda-samples/build
> > > > >    guest$ make -j 20 clean
> > > > >    guest$ make -j 20
> > > > >                :
> > > > >    [ 54%] Linking CUDA executable graphMemoryNodes
> > > > >    [ 54%] Built target graphMemoryNodes
> > > > >    <no more output afterwards, guest becomes frozen here>
> > > > > 
> > > > >    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > > >    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> > > > > 
> > > > > When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> > > > > the memory blocks residing in the PCI BAR can be presented to the guest
> > > > > through memory hot-add. The page cache can be allocated from the hot added
> > > > > memory blocks when cuda-samples is being built. Afterwards, he page cache
> > > > > is sent to QEMU's virtio-blk device as part of the DMA request, the bounce
> > > > > buffer is used to accomodate the request as the corresponding memory
> > > > > region (MemoryRegion) is a RAM DEVICE region in qemu. For this specific
> > > > > case, false is returned from memory_access_is_direct() in the path where
> > > > > the DMA request is handled.
> > > > > 
> > > > >   QEMU
> > > > >   ====
> > > > >   virtio_blk_handle_output
> > > > >     virtio_blk_handle_vq
> > > > >       virtio_blk_get_request
> > > > >         virtqueue_pop
> > > > >           virtqueue_split_pop
> > > > >             virtqueue_map_desc
> > > > >               address_space_map
> > > > >                 memory_access_is_direct         # Return false
> > > > >                   memory_region_supports_direct_access
> > > > > 
> > > > >   (qemu) info mtree
> > > > >           :
> > > > >   memory-region: pci_bridge_pci
> > > > >     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > > > >       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
> > > > >         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
> > > > >           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> > > > > 
> > > > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > > > than one page when the guest page is 64KB. This tries to fix the issue
> > > > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > > > size is a larger one. With this applied, no guest system hang is seen
> > > > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > > > > 
> > > > > Reported-by: Julia Graham <jugraham@redhat.com>
> > > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > > ---
> > > > >  hw/virtio/virtio-bus.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> > > > > index cef944e015..e0933823f3 100644
> > > > > --- a/hw/virtio/virtio-bus.c
> > > > > +++ b/hw/virtio/virtio-bus.c
> > > > > @@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
> > > > >  /* A VirtIODevice is being plugged */
> > > > >  void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> > > > >  {
> > > > > +    AddressSpace *as;
> > > > >      DeviceState *qdev = DEVICE(vdev);
> > > > >      BusState *qbus = BUS(qdev_get_parent_bus(qdev));
> > > > >      VirtioBusState *bus = VIRTIO_BUS(qbus);
> > > > > @@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
> > > > >                  return;
> > > > >              }
> > > > >          }
> > > > > +    } else {
> > > > > +        /*
> > > > > +         * The maximal bounce buffer size of the virtio bus's parent may
> > > > > +         * have been customized by property 'x-max-bounce-buffer-size'.
> > > > > +         * Lets inherit the customized size if it's larger than the
> > > > > +         * current one.
> > > > > +         */
> > > > > +        as = klass->get_dma_as ? klass->get_dma_as(qbus->parent) : NULL;
> > > > > +        if (as) {
> > > > > +            vdev->dma_as->max_bounce_buffer_size = MAX(
> > > > > +                    vdev->dma_as->max_bounce_buffer_size,
> > > > > +                    as->max_bounce_buffer_size);
> > > > > +        }
> > > > >      }
> > > > >  }
> > > > >  
> > > > > -- 
> > > > > 2.54.0
> > > > 
> > > > 
> > > > Problem with all this is, users would not know how to size this.
> > > > 
> > > > So fundamentally, is not the issue that virtio blk (and scsi!) maps
> > > > all of the buffer all the time?
> > > >
> > > > It's not hard to add something like virtio_pop_unmapped that would not map,
> > > > then build QEMUSGLists out of addr/len pairs and submit these.
> > > > 
> > > > Stefan, do you think doing it like this would be bad for perf? Good for
> > > > perf?
> > > 
> > > I'd like to first make sure that the BAR really cannot be mmapped.
> > 
> > The issue is that qemu has no way to know, up front.
> 
> Gavin posted the lspci output:
> 
>   Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=16M]
>   Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=128G]
>   Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=32M]
> 
> These are prefetchable memory BARs, so I would expect them to be
> mmappable. Why does QEMU have no way of knowing upfront whether they can
> be mmapped?


They can be mmapped.  The issue is just that after mmap flatview uses
memcpy/memmove on them, and that might not match what guest driver is
expecting specifically for 1/2/4/8 byte accesses.


Removing mmap is one solution, this is what vfio does now.
Fixing flatview is another.


> > What we could thinkably do, is map it and do the
> > accesses from QEMU through the bounce buffer, while
> > DMA through mmap.
> > 
> > 
> > > A bounce buffer is necessary when QEMU has no way of mmapping the memory
> > > (e.g. it needs to invoke a device model's callback to read/write the
> > > MemoryRegion).
> > > 
> > > The reason why the bounce buffer size is low is because it's normally
> > > only used on emulated machines where MMIO registers or similar small
> > > MemoryRegions are accessed by DMA. If we ran into this on modern
> > > machines there would also be other consequences like vhost devices would
> > > be unable to access that memory since it cannot be shared/mmapped.
> > > 
> > > This is why I think we need to understand why this BAR is a RAM DEVICE.
> > 
> > 
> > VFIO maps all memory BARS like this.
> > 
> > > If it can support mmap then this issue, plus anything else like vhost,
> > > would work.
> > > 
> > > Gavin, can you share the output of `lspci -vv -s 0009:01:00.0`?
> > > 
> > > Thanks,
> > > Stefan
> > 
> > 




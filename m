Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8FCCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFYy-0000x7-VP; Wed, 10 Jun 2026 05:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXFYx-0000u6-BC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXFYv-00048s-CV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781084967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HJpIq4DO8bdfcDx0wh13Foq0nFERFPIB0/DgZ0IKkY4=;
 b=KF+YLDa4YZO9Xc+v6k+dAqB9TviLFlJzMAvlO32jqPrsrskm4Kr03AM+NzS7FCVNRI4wZi
 jEQNDDOwp17nG0Lkfsa8eaYslyaiqceoWfZbqxzYQwUupL3aDdnUDb0uV6Rwn82fw7vuJx
 vOPIjIcWQLIYfOxv3BTLxBtLRSOlPc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-7E9ZkYymPiu0EP5ea1VyHg-1; Wed, 10 Jun 2026 05:49:26 -0400
X-MC-Unique: 7E9ZkYymPiu0EP5ea1VyHg-1
X-Mimecast-MFC-AGG-ID: 7E9ZkYymPiu0EP5ea1VyHg_1781084965
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-460198535bcso4235111f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781084965; x=1781689765; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HJpIq4DO8bdfcDx0wh13Foq0nFERFPIB0/DgZ0IKkY4=;
 b=eoXcp251mbU+0TrRCbTuPh1Kq6k6zec/32FovBVTZHYoFX804uFOshqN94mVyhQIuO
 DBJ5R2eWyZf2HLeew/4vqA4alJflGLPojoztOosES/PHZ5nOA7+Zzgb3/MF2cZltZM8K
 yLwyPVJ2AMY1qJs1RCqZzm4BOApPrXdD2V2BSGziAon1GHsqCInass8u6tiCqvgG2Jqu
 SXRY8oC7TwEAVDnHm6iXvgRz3ZSjMclp+f9i3GKg79kQOY0DPFs2jx+2GcFCwBJGjHB+
 7RKLTHbtGg32i2t3wzNUI2N5v0a4XPocZgf4KM8csFLQyCV52ju11ta8OFpUuPMBZLZE
 DOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781084965; x=1781689765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJpIq4DO8bdfcDx0wh13Foq0nFERFPIB0/DgZ0IKkY4=;
 b=Ij+HTtJ+p5ymV1z79I+9lqnRtDISCBM3MUB48coi2Bh0F18mbSHUgTJhcVOiLwvmya
 6JiCTonC8skPvCZsHR9SQmWdjAVPASoJQPe4HwMkbaM1dFXchQZe02XVSjpG1csR/vfo
 5JSnScE6K2ZvFVKif6VySqL4cEGEiVsQqL/yAi1FOQJcuCowMZmuyZMkYXbItoUwNJ/o
 +dneHfEod8+8mwtXXrZaaHMO33O2oCJpw8dT7GbfJoKsJUhYpzkWCCc5t1iHD6+P6EF+
 J7EFYWtZJz7CI4qmohyIfOroVwtP1piJBPCasdWjyh44gNJReAFI9YCxYBTzWC6lvMAI
 cMqA==
X-Gm-Message-State: AOJu0YxjCkCSk9SUhfDM0cScdGC1JnDoqXU6oEvhbqWEQZdbAo64B+zI
 OsU4hlITQE5VfkkK8uiA4a1/mSe4on24HC/dH7zZR77D+6/uhH1hi2wOfqv/8Jfj3esSu9X3Fle
 N0KdSpg3TPPwQvuvXV/UDitR+sBP+gxStqlIVQseeIuAssjqggr6kykeX
X-Gm-Gg: Acq92OG5pP6SLsmbZCCzRDeVl1rrtEtR0MxFnhXTZDItGkPQ6fXFlU2ASjZ3I/Bwsds
 Jzg/z14h4YjKqSkFbfE1Zi/iuzmCxOkDypxvY9OQ7hLtZzDJ6Hs1dvVbByOm3ugexprmxwbiOaI
 9ixOTXM+oKojoAaFEnCfHNDgC0iaHNKQ5d0FsRU6Jw5NNHArsf38iNFxRk8gJ6LOhhHtTOJGiGr
 CG+nNJu3eXZrwMe8nyDz0VadUNHc4BBXn3I91Ps9UkhNA6cbwR8TQGZK6LQEK4SkX4fzbjEWz29
 ewDV8YpD/Nl3ioEbDkxgHpcGXTobsM4dEIa0ThDia7JL3JGhPiNjqctKcH/MLJBom4dIHspGjIs
 +CF5/FFfqpvlDaQ5gVKk/MqxP7qLBq99Y0R2Zim8tzQi7ShslbQMq9Q==
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id
 ffacd0b85a97d-46030652fcemr29809773f8f.26.1781084965235; 
 Wed, 10 Jun 2026 02:49:25 -0700 (PDT)
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id
 ffacd0b85a97d-46030652fcemr29809736f8f.26.1781084964737; 
 Wed, 10 Jun 2026 02:49:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm58967771f8f.32.2026.06.10.02.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 02:49:24 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:49:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, stefanha@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610041036-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608001821.850921-1-gshan@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> On the guest where a NVidia's GH100 card is passed from the host, the
> guest system hang can be observed on attempt to compile 'cuda-samples',
> as reported by Julia.
> 
>    host$ lspci | grep GH100
>    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -accel kvm \
>          -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>          -cpu host -smp cpus=32 -m size=8G                                  \
>          -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>          -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
> 
>    guest$ cd cuda-samples/build
>    guest$ make -j 20 clean
>    guest$ make -j 20
>                :
>    [ 54%] Linking CUDA executable graphMemoryNodes
>    [ 54%] Built target graphMemoryNodes
>    <no more output afterwards, guest becomes frozen here>
> 
>    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> 
> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> the memory blocks residing in the PCI BAR can be presented to the guest
> through memory hot-add. The page cache can be allocated from the hot added
> memory blocks when cuda-samples is being built. Afterwards, he page cache
> is sent to QEMU's virtio-blk device as part of the DMA request, the bounce
> buffer is used to accomodate the request as the corresponding memory
> region (MemoryRegion) is a RAM DEVICE region in qemu. For this specific
> case, false is returned from memory_access_is_direct() in the path where
> the DMA request is handled.
> 
>   QEMU
>   ====
>   virtio_blk_handle_output
>     virtio_blk_handle_vq
>       virtio_blk_get_request
>         virtqueue_pop
>           virtqueue_split_pop
>             virtqueue_map_desc
>               address_space_map
>                 memory_access_is_direct         # Return false
>                   memory_region_supports_direct_access
> 
>   (qemu) info mtree
>           :
>   memory-region: pci_bridge_pci
>     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> 
> By default, the max bounce buffer size is only 4096 bytes, even less
> than one page when the guest page is 64KB. This tries to fix the issue
> by inheriting the customized max bounce buffer size of the virtio bus's
> parent through property 'x-max-bounce-buffer-size' when the customized
> size is a larger one. With this applied, no guest system hang is seen
> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> 
> Reported-by: Julia Graham <jugraham@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/virtio/virtio-bus.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index cef944e015..e0933823f3 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
>  /* A VirtIODevice is being plugged */
>  void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>  {
> +    AddressSpace *as;
>      DeviceState *qdev = DEVICE(vdev);
>      BusState *qbus = BUS(qdev_get_parent_bus(qdev));
>      VirtioBusState *bus = VIRTIO_BUS(qbus);
> @@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>                  return;
>              }
>          }
> +    } else {
> +        /*
> +         * The maximal bounce buffer size of the virtio bus's parent may
> +         * have been customized by property 'x-max-bounce-buffer-size'.
> +         * Lets inherit the customized size if it's larger than the
> +         * current one.
> +         */
> +        as = klass->get_dma_as ? klass->get_dma_as(qbus->parent) : NULL;
> +        if (as) {
> +            vdev->dma_as->max_bounce_buffer_size = MAX(
> +                    vdev->dma_as->max_bounce_buffer_size,
> +                    as->max_bounce_buffer_size);
> +        }
>      }
>  }
>  
> -- 
> 2.54.0


Problem with all this is, users would not know how to size this.

So fundamentally, is not the issue that virtio blk (and scsi!) maps
all of the buffer all the time?

It's not hard to add something like virtio_pop_unmapped that would not map,
then build QEMUSGLists out of addr/len pairs and submit these.

Stefan, do you think doing it like this would be bad for perf? Good for
perf?

-- 
MST



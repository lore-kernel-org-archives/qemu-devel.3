Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02B2C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpCs4-0000xn-42; Wed, 29 Jul 2026 18:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpCs0-0000xM-EO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpCru-0000wR-SZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785364515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1DmobnpuqfOMUgi6Wi9zNfJkkb6Zpprc33nArsPitzk=;
 b=T0YuSHLtBiXTH/iy/+ayAH95baHM37nCPzeOfnuSyPvkBuI+6uZoekMaUSlDpuhFbcRncM
 JTkImfbTWPAdUT+Dwa2gKm3+AST0USNwyAWW9xy2UpqOhhxrccbhV5SF7aB8XFqnOArePs
 xIUBZg2Gqb6MMod/f1ol5LHgfSN1CL0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-yboX7Xo5OQiNkyEAjDFktg-1; Wed, 29 Jul 2026 18:35:13 -0400
X-MC-Unique: yboX7Xo5OQiNkyEAjDFktg-1
X-Mimecast-MFC-AGG-ID: yboX7Xo5OQiNkyEAjDFktg_1785364513
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83416551so1560546f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785364512; x=1785969312; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1DmobnpuqfOMUgi6Wi9zNfJkkb6Zpprc33nArsPitzk=;
 b=D9602YhtBK+jGUrsWIFlaomVy5WIXyUJWyvJjCKiwKv/9VnSxJiPj9WhuPqK4Qa2Fa
 DFfw5uJwws3ymwOzqoCK0RIsSVq+VWQw78hjhvJ3+KkoXAO2VBHdE2dfrXeqS0TRBjw7
 P7AhmLuqZhrIS3Js30tUpRr6Y9W5AgS4gfNLtWsvYNj2RCc6pDgKOLWS7z+2b6G5inUA
 kEXwIaeNKInlx2uHSZQKzLMAXJaF0YclY7IDTAjHnkayVMis31Sifqbguj7BM0hC4Ts8
 wuNUncQ1UA8nDOlJEwW+VaAUKBBGbBHBd8I00fOSJpHjqxzwXW/zYptJAM39o1Re1H3x
 lXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364512; x=1785969312;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1DmobnpuqfOMUgi6Wi9zNfJkkb6Zpprc33nArsPitzk=;
 b=pEHEsKDdTEoovvRgx9UZW2VSYB2wWUsDGJ/RApkeUdqMULdMN9G2itX/yAj9OIArz6
 /Er47bJybuznjB+jYSfxhJ5cBOOwPqCWIkxpkjO0Yh9fIF6h3JYP5cdbVPVJ0w+yvUO1
 DvVQuCHy1jayT2LicG2MWx/R+VpEgV0qQOhVbFVhoDAzqfUuql0+Jlo1hu9C4jvSpLbG
 yMTTtQ1qEsWKwZEs2L5PSf4bhbTwcA3j6LyIh5/rUaOrhp9SNofNJ3FqE9/MJUcjEFe8
 SBm4axlShPIXo/n7xa6r0c36qvPHAj3zsApmqWiRqx/Y+YDoHUpmMVjcQ0uJi9YgfNwf
 tmJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQipmnUpfOAeXtP9dNMAOyPnDjEU6Ac4ly9ZHADeVg+GguZJIGgW8GkDkop7jaevXvrwzmG2d73ybZ@nongnu.org
X-Gm-Message-State: AOJu0Yy38RtcP/5o+N9naZ/+sYm6FRxCZ2EBDEF1NjHYZ/Q5WhCJ6i7K
 WF9ph7rfEhpu42kHe1RPE6At1bfnImMnm2wSQ+6OFYyYPBvveGvj4Yhe6bFreaPfnZ6r6V0Zk6u
 cV6PItK2h6DXaV6pRof3E84Z54p8vHJbmtG1QqPxmbj5JKoW8g4GjjlzW
X-Gm-Gg: AR+sD129jBfnMlMmaQICsmepfcWhrUsM0wK5Jches17HRHJWE0TKfQb19k2WeKh/jM4
 zW2yjmbrf5P0CQw96mkLy0JFz719HLNYsujfLZGA+24PhnXJ1xlY1eNOQNcEN3wp0q65b6jvBmy
 lFDfD9dMfVTfWwykZxQP3W6eabjKjRkhF0K0tbGqsRQB3H2uwKUeZUnXHmh5jWu65LVrwFhlDjW
 5AtLJ1tW9w5Tj9erZ9OBnN06fL7E3fhMQJdVnYGSrW6a30sbgRkYX8Q1STZ5J4MwnUhXsZhiQrB
 UTlvYgYRInP6AUXZDRmh/xW7z7AxK800BHr/15F/JLkyOekEOK1DUBiNwMCoFduj8DJqFDlC1lM
 naQOcdxNdce0UPmaxzk7XCss=
X-Received: by 2002:a05:6000:178a:b0:47f:aebd:841d with SMTP id
 ffacd0b85a97d-47fc81c6668mr227602f8f.15.1785364512506; 
 Wed, 29 Jul 2026 15:35:12 -0700 (PDT)
X-Received: by 2002:a05:6000:178a:b0:47f:aebd:841d with SMTP id
 ffacd0b85a97d-47fc81c6668mr227571f8f.15.1785364511980; 
 Wed, 29 Jul 2026 15:35:11 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e3c73sm17175f8f.10.2026.07.29.15.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:35:11 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:35:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v5 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Message-ID: <20260729182316-mutt-send-email-mst@kernel.org>
References: <20260728031731.286666-1-gshan@redhat.com>
 <20260728031731.286666-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728031731.286666-3-gshan@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 01:17:30PM +1000, Gavin Shan wrote:
> All ram device regions were turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
> guest is started by the following command lines, with GH100 GPU card passed
> from the host.
> 
>    host$ lspci | grep GH100
>    0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>    host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>          -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>          -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>          -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>          -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>          -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>            :
>    guest$ cd cuda-samples/build
>    guest$ make -j 20 clean
>    guest$ make -j 20
>            :
>    [ 54%] Linking CUDA executable graphMemoryNodes
>    [ 54%] Built target graphMemoryNodes
>    <no more output afterwards, guest becomes frozen here>
> 
>    guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>    [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> 
> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
> be presented to the guest through memory hot-add. The page cache can
> then be allocated from the hot added memory blocks when cuda-samples
> is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
> device as part of the DMA request, the bounce buffer has to be used to
> accomodate the request as the corresponding memory region (MemoryRegion)
> is an indirectly accessible ram device region in qemu. However, the max
> bounce bufer size is only 4096 bytes by default and that is exhausted
> quickly, leading to a reset on the virtio-blk device and frozen guest
> eventually.
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
>   memory-region: pci_bridge_pci
>     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> 
> This adds qemu_ram_move() where the aligned and small-sized accesses are
> handled by qatomics, and fall back to memmove() otherwise. The memove()
> for the directly accessible regions is replaced by qemu_ram_move() so that
> the issue covered by commit 4a2e242bbb (MMIO access instructions were
> optimized to SSE instructions) is fixed. This makes 'ram_device_mem_ops'
> redundant, paving the way to revert that commit to make the ram device
> region directly accessible again in the next patch.
> 
> Besides, this also fixes the issue of the unexpected frozen reception on
> e1000 NIC in the scenario of DPDK due to the wrong Rx queue full indication
> caused by the following memcpy(), which is turned to 3 consective 'strb'
> instructions to the same location by glibc-2.24+ for aarch64. With this
> applied, the syntax of one-byte store is strictly ensured by a one-byte
> qatomic set.
> 
>   QEMU
>   ====
>   e1000_receive_iov
>     pci_dma_write
>       pci_dma_rw
>         dma_memory_rw
>           dma_memory_rw_relaxed
>             address_space_rw
>               address_space_write
>                 flatview_write
>                   flatview_write_continue
>                     flatview_write_continue_step
>                       memcpy    # 3 consective 'strb' instructions
> 
> Reported-by: Julia Graham <jugraham@redhat.com>
> Reported-by: Liu Gang <liugang24219@sangfor.com.cn>
> Reported-by: Ding Hui <dinghui@sangfor.com.cn>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v5: Improved commit log and comments to qemu_ram_move()
> ---
>  hw/remote/vfio-user-obj.c |  4 ++--
>  include/system/memory.h   | 35 ++++++++++++++++++++++++++++++-
>  system/physmem.c          | 43 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index ea50270628..a0498d218f 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>          ram_ptr = memory_region_get_ram_ptr(mr);
>  
>          if (is_write) {
> -            memmove((ram_ptr + offset), buf, size);
> +            qemu_ram_move((ram_ptr + offset), buf, size);
>          } else {
> -            memmove(buf, (ram_ptr + offset), size);
> +            qemu_ram_move(buf, (ram_ptr + offset), size);
>          }
>  
>          return 0;
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 336d4e84a6..2965d922de 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2668,6 +2668,39 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>  void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>  
>  /* Internal functions, part of the implementation of address_space_read.  */
> +
> +/**
> + * qemu_ram_move: move data from or to ramblock
> + *
> + * @dst: destination where the data is moved to
> + * @src: source where the data is moved from
> + * @n: length of data to be moved
> + *
> + * Move @n bytes from @src to @dst, the memory areas may overlap. This
> + * provides the same semantics as memmove(), plus an additional stronger
> + * guarantee: if @n is 1, 2 or 4 or 8 bytes, and @src and @dst are both
> + * naturally aligned for that access size, and the memory areas do not
> + * overlap, then both the load and the store will be done as a single
> + * atomic access (with the semantics of qatomic_read() and qatomic_set()).
> + *
> + * This is the underlying function that we use to implement accesses by
> + * a guest vCPU or a device DMA operation to a ram block. The atomic
> + * guarantee is needed for two major cases: (A) When the ram block is
> + * backed by a PCI BAR passed through from a host device (and so it might
> + * be hardware registers that must be accessed exactly once at the right
> + * width); (B) When an emulated device updates a data structure shared in
> + * guest memory with guest software (e.g. a network device's set of tx and
> + * rx descriptor blocks), if a write to memory is accidentally performed
> + * multiple times then it can break the guest code when it busy polls the
> + * guest memory.
> + *
> + * We don't attempt to perform the exact access when it would be unaligned
> + * because this can't be done on all host architectures. Although this is
> + * strictly speaking not doing what would happen on real hardware, we don't
> + * think there are going to be situations where that matters in practice.
> + */
> +void qemu_ram_move(void *dst, const void *src, size_t n);
> +
>  MemTxResult address_space_read_full(const AddressSpace *as, hwaddr addr,
>                                      MemTxAttrs attrs, void *buf, hwaddr len);
>  MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
> @@ -2741,7 +2774,7 @@ MemTxResult address_space_read(const AddressSpace *as, hwaddr addr,
>              mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>              if (len == l && memory_access_is_direct(mr, false, attrs)) {
>                  ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -                memmove(buf, ptr, len);
> +                qemu_ram_move(buf, ptr, len);
>              } else {
>                  result = flatview_read_continue(fv, addr, attrs, buf, len,
>                                                  addr1, l, mr);
> diff --git a/system/physmem.c b/system/physmem.c
> index 2c42e365cb..fbe7df2391 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3158,6 +3158,45 @@ void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
>      invalidate_and_set_dirty(mr, addr, size);
>  }
>  
> +void qemu_ram_move(void *dst, const void *src, size_t n)
> +{
> +    uintptr_t test, len;
> +
> +    if (src == dst || n == 0) {
> +        return;
> +    }
> +
> +    /*
> +     * Maximal length of aligned access that are determined by @src,
> +     * @dst and @n
> +     */
> +    test = (uintptr_t)src | (uintptr_t)dst | n;
> +    len = test & -test;
> +
> +    /* Overlapping buffers, unaligned or oversized access */
> +    if (n > 8 || len != n) {
> +        memmove(dst, src, n);
> +        return;
> +    }


This part I don't get exactly. It's fine on most arches I think.
x86, power...

But here is aarch64 for example:
https://codebrowser.dev/glibc/glibc/sysdeps/aarch64/memcpy.S.html

it says 
   It uses unaligned accesses and branchless sequences to keep the code small,
   simple and improve performance.

so if the point is to get rid of unaligned accesses to BARs, are you sure
it achieves this?




> +
> +    switch (len) {
> +    case 1:
> +        qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
> +        break;
> +    case 2:
> +        qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
> +        break;
> +    case 4:
> +        qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
> +        break;
> +    case 8:
> +        qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>  {
>      unsigned access_size_max = mr->ops->valid.max_access_size;
> @@ -3270,7 +3309,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                 false, true);
>  
> -        memmove(ram_ptr, buf, *l);
> +        qemu_ram_move(ram_ptr, buf, *l);
>          invalidate_and_set_dirty(mr, mr_addr, *l);
>  
>          return MEMTX_OK;
> @@ -3363,7 +3402,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                 false, false);
>  
> -        memmove(buf, ram_ptr, *l);
> +        qemu_ram_move(buf, ram_ptr, *l);
>  
>          return MEMTX_OK;
>      }
> -- 
> 2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD2BCD98D9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2W6-0006S9-HN; Fri, 12 Jun 2026 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2W2-0006Ra-CC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:05:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wY2Vy-0003DU-Dl
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:05:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65CCj7U12160957
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hDSd1Ch4IG/snO3LC3CMu3U6AyQM8zbZGv8bpsK6uO4=; b=gmi9qkTjmKDWLa6D
 TUxbbwMGlUWbPcKuckxWt3VzpqdbU76UBcZdYkB6JEIH1XKYPbmQMLH+RkyzXDPR
 r2ALXYKiKv4reglnoWmbTRGvp13AhZv0S2jt48bARHPi5c3WiirEdOtMnuPlqpc+
 41n46FK+16pv8TmryMFHQ6L+wS+LSZeMiXhYEpsA/zipa15/VMDaruNSz+OrqCf4
 UoC/R/ZD5x9cl2Zp4B+ux0G4HGiWXhFfiuAABbEFTsHlkKc27T6BDYPpyR4tg4HU
 B5KFd40YUlW89wdlND6BhigjleuIyRMrGR5aT+RGYxw6jiV987t0Gy8qPp1l+5un
 xLHwug==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014m2jx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:05:38 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48638b48315so1840504b6e.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781273138; x=1781877938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDSd1Ch4IG/snO3LC3CMu3U6AyQM8zbZGv8bpsK6uO4=;
 b=Ny2gebCun2tOp355uhPqRDGqmwjCue/S10YKa71f3YfuX3Wvx20PgUE28XagvFm8PE
 3tt5HPrJzoeeYrqKXoHlCD7DIJGJr3M4yjWwmLhTGLjjA7fRat7i6HirYjwryC9le+t4
 0i0CwBiipMnV0U54UMUiSs3H+98KC2N4dn81yC4qO6JEz5CWOy0qCNlwvjVU7s1lGFGW
 T3s8SruEZJ1JWvlAFO8ToGg2VTxUtKmEz+any+lhl8bABF1RwtBIJZjs/zRCmRWsLCXA
 B39s5UlugWCSl0fSQ15ssjRiDOyJDIfw+Nn50WebLgeWVCjW5+6Sy8gDWwnocdsooxTh
 /MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273138; x=1781877938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDSd1Ch4IG/snO3LC3CMu3U6AyQM8zbZGv8bpsK6uO4=;
 b=J9SP7a739+thuTNR+OC/Ti5U6A07EjtcKE5yH5M9Ksz/fYh/yt5/R2If/tCphu3+Yb
 wdkZTKTDa6lxqPwGK+NmWiElPc0pM+EKpso2/xAbTIt7sSoQGTYQP7ahg9qmR/R842sT
 jG4xqrjAO0vaC9bBLuR2r+aCdCc87baaPWTBTZsH0zkUcO9aL3D6iMGKCi2KC3Zx0XJS
 dmyr1Yaqd/UX6rCBDupdmViP79igiyEp9HSbEEA9XbbCjCgBZSg8t0rcrsV/rvZqieFZ
 0bVeWpsyFCtmAHt2wSbGkB3QJ1qElhpaWTJzdArNzjVzFIayeJkVIeOEZDO0hGNx/Caz
 PQzQ==
X-Gm-Message-State: AOJu0YymPvjxXrdwZGdvRODBiqAZ2+4ZxwBe75+vUHD6ZpIIQ5u+WIMU
 M/nWi7f8tM8ihSyijLa7KMgYmcnZwlpN7p4UvMTc6/r3OH5FYFrjEyoADR1obwPPb0RHQXjfW/j
 gWvXnOzmFLefIAAZ1RvTOKomVMFD7+UyweGhNH3UCO2KkDOYPWxJY34+DjA==
X-Gm-Gg: Acq92OFnBa3YfjfY53PSbomoyI+n6w/y2cZ/BQsNtcYjo177HXpGHEEVUjmyeEvGwy4
 +4OmfDl+cPDpk+jQnwyzl2avPi7I7mepLFT/bMZfHAzRp3Eqq/5S48Kbk5IVyj6D2Kd5wLAcpQy
 cGHF4a1znC6BnQoBKRiBtAyHfPHlLsY7tjfGkMfX/DiWcCf/8NK1KANDX2RtmHptWuwqrsMDGfV
 HKznvnXgNMpr6AKLHb0etCG4cAhnEwZGrgiy1mF2ojUG9ZDfDuw4SlZlMqAN+JUUSPM69bgS9Vr
 398805sFMGLi2vqQSIGjYTXlr5fEeyDWqsThjpiRqVxoRcEAJVpzmx6gA4UYhfQkTHTw8CO5jlt
 kV5la/H2a5bG4HQhP4cGz5xMuMPe3w40vvGWBxzBzE4bGj4Z15JothBOxlmXripT8kmVs0MsS
X-Received: by 2002:a05:6808:4fc6:b0:472:c4ba:32d9 with SMTP id
 5614622812f47-4872df27666mr1698202b6e.20.1781273137640; 
 Fri, 12 Jun 2026 07:05:37 -0700 (PDT)
X-Received: by 2002:a05:6808:4fc6:b0:472:c4ba:32d9 with SMTP id
 5614622812f47-4872df27666mr1698148b6e.20.1781273136840; 
 Fri, 12 Jun 2026 07:05:36 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d0475asm243290755e9.12.2026.06.12.07.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 07:05:35 -0700 (PDT)
Message-ID: <aa8b97e2-14da-4df1-9b61-33e01b5cffce@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 16:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, berrange@redhat.com, david@kernel.org,
 alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260612110307.1264798-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zcF_YakGLqw4lSY0zPIxTxHiAtLrcHoj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyOSBTYWx0ZWRfX6wCykEu2S3n+
 YsTJ7S1Jbtw4RECJvHbJL4bCpmauSX+cNDG/KhHlZYQomS2u4U9aJOuATguO7NdJc9hScL24zr/
 I918gKCJwkqUVz3Dna6oXI8zpXtRIk4=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2c1232 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=0CTYnOhIUTuevSWfFCgA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyOSBTYWx0ZWRfX5dJ/7cgMoymW
 xuZ3AUlQVCI09x6t4Ccg75M3tuhxmmfVsZ3rsspWnHCfS2Mzt5gussumJ6hLb9eARiBPXee2r2m
 gud4bCpFMSo9XMIOAPoJtpXRlu8XmMwQnepqMWRr5XHBeJJG1BhtRxDg10dIYwQ2hvS0CuWNZ9q
 XNlv/TxPJonPXeMQXQUMHbA3uQtxwTMQA5W4uHJW0ZFhheyhyfKy2rVdilwK9uXNOY3guGirdjl
 LMzBtvmhvZuX1x11vqYpBNdoNVRY1mz3gd8O5YkAzjNDiMyUdSjrt+unZOnb6OFkWYUzA9Qviie
 kRKfFk7zcTt01dPnZaEzBZVVUPDIvLoUpJoFCcQrWV2BsnTSuCQM91SdhTkK9+mF/bmJv3Zn+7H
 zYr1LyGtCl7MYTVZfGxyr6ISZSd1ZCINV/hrJAhjcsncl50EJF4x5/H0YeHPrSDGIACaaEaMp8z
 1jjRS1uUKtDWZPUpYxQ==
X-Proofpoint-ORIG-GUID: zcF_YakGLqw4lSY0zPIxTxHiAtLrcHoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Gavin,

On 12/6/26 13:03, Gavin Shan wrote:
> All ram device regions was turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> to guest hang on compiling 'cuda-samples' as reported by Julia. The guest
> is started by the following command lines, with a GH100 GPU card.
> 
>     host$ lspci | grep GH100
>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>             :
>     guest$ cd cuda-samples/build
>     guest$ make -j 20 clean
>     guest$ make -j 20
>             :
>     [ 54%] Linking CUDA executable graphMemoryNodes
>     [ 54%] Built target graphMemoryNodes
>     <no more output afterwards, guest becomes frozen here>
> 
>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
> 
> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
> the memory blocks residing in the PCI BAR#4 can be presented to the
> guest through memory hot-add. The page cache can be allocated from the
> hot added memory blocks when cuda-samples is being compiled. Afterwards,
> the page cache is sent to QEMU's virtio-blk device as part of the DMA
> request, the bounce buffer has to be used to accomodate the request as
> the corresponding memory region (MemoryRegion) is a RAM DEVICE region
> and indirectly accessible in qemu. However, the max bounce bufer size
> is only 4096 bytes by default. We're running out of that space quickly.
> 
>    QEMU
>    ====
>    virtio_blk_handle_output
>      virtio_blk_handle_vq
>        virtio_blk_get_request
>          virtqueue_pop
>            virtqueue_split_pop
>              virtqueue_map_desc
>                address_space_map
>                  memory_access_is_direct         # Return false
>                    memory_region_supports_direct_access
> 
>    (qemu) info mtree
>    memory-region: pci_bridge_pci
>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
> 
> This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
> accessors to ram device memory region, preparatory work to make ram device
> region directly accessible and bypass the bounce buffer in the DMA path
> in next patch.
> 
> Reported-by: Julia Graham <jugraham@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/remote/vfio-user-obj.c |  4 ++--
>   include/system/memory.h   | 42 ++++++++++++++++++++++++++++++++++++++-
>   system/physmem.c          |  8 ++++----
>   3 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 87fa7b6572..fe6f661fe2 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -375,9 +375,9 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>           ram_ptr = memory_region_get_ram_ptr(mr);
>   
>           if (is_write) {
> -            memcpy((ram_ptr + offset), buf, size);
> +            address_space_memcpy(ram_ptr + offset, buf, size);
>           } else {
> -            memcpy(buf, (ram_ptr + offset), size);
> +            address_space_memcpy(buf, ram_ptr + offset, size);
>           }
>   
>           return 0;
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..6bb2e13eea 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2938,6 +2938,46 @@ static inline bool memory_access_is_direct(const MemoryRegion *mr,
>       return true;
>   }
>   
> +static inline void address_space_memcpy(void *dest, const void *src, size_t n)

'address_space_' prefix for something that doesn't use neither
AddressSpace nor MemoryRegion is odd.

Maybe prefix 'qemu_ram_' or 'qemu_ram_ptr_' instead? (since the
address is returned by memory_region_get_ram_ptr)
Add the definitions in "system/ramblock.h" with that declaration?

> +{
> +    switch (n) {
> +    case 1:
> +        __builtin_memcpy(dest, src, 1);
> +        break;
> +    case 2:
> +        __builtin_memcpy(dest, src, 2);
> +        break;
> +    case 4:
> +        __builtin_memcpy(dest, src, 4);
> +        break;
> +    case 8:
> +        __builtin_memcpy(dest, src, 8);
> +        break;
> +    default:
> +        __builtin_memcpy(dest, src, n);
> +    }
> +}
> +
> +static inline void address_space_memmove(void *dest, const void *src, size_t n)
> +{
> +    switch (n) {
> +    case 1:
> +        __builtin_memmove(dest, src, 1);
> +        break;
> +    case 2:
> +        __builtin_memmove(dest, src, 2);
> +        break;
> +    case 4:
> +        __builtin_memmove(dest, src, 4);
> +        break;
> +    case 8:
> +        __builtin_memmove(dest, src, 8);
> +        break;
> +    default:
> +        __builtin_memmove(dest, src, n);
> +    }
> +}
> +
>   /**
>    * address_space_read: read from an address space.
>    *
> @@ -2970,7 +3010,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
>               mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
>               if (len == l && memory_access_is_direct(mr, false, attrs)) {
>                   ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -                memcpy(buf, ptr, len);
> +                __builtin_memcpy(buf, ptr, len);
>               } else {
>                   result = flatview_read_continue(fv, addr, attrs, buf, len,
>                                                   addr1, l, mr);
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf87573..5f46a9d676 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3272,7 +3272,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                  false, true);
>   
> -        memmove(ram_ptr, buf, *l);
> +        address_space_memmove(ram_ptr, buf, *l);
>           invalidate_and_set_dirty(mr, mr_addr, *l);
>   
>           return MEMTX_OK;
> @@ -3365,7 +3365,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>           uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                  false, false);
>   
> -        memcpy(buf, ram_ptr, *l);
> +        address_space_memcpy(buf, ram_ptr, *l);
>   
>           return MEMTX_OK;
>       }
> @@ -3503,8 +3503,8 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>               l = memory_access_size(mr, l, addr1);
>           } else {
>               /* ROM/RAM case */
> -            void *ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -            memcpy(ram_ptr, buf, l);
> +            address_space_memcpy(qemu_map_ram_ptr(mr->ram_block, addr1),
> +                                 buf, l);
>               invalidate_and_set_dirty(mr, addr1, l);
>           }
>           len -= l;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95383C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLlU-0001RT-1l; Mon, 27 Jul 2026 09:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woLlO-0001Qw-9o
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woLlL-0005mp-S2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:53:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlaNo3414034
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PxA1ZVnCLGJ0duczVSZ3Xajv24AVSh0WMgCl6zv4cvU=; b=SyKNiXe6n4we1LdR
 HXE8teJaVgF3MXCTCYdFaEdnjyli6lqcuHdQhms+93msFv0T+VbfjVjOSz6GdDDP
 4LsER4sdZ054s9/cUGlqy8jUzbVPApFIQUNhNwictuBd0Uzb8GRdrhcrSTfv1Dzv
 yiCty22WMhVWCwAP2C/6OiFKvd5ge2nnBuZPwIcEPgdIQWJKnwWNAgITtOjUg3JU
 hTQcaiGnJVc6mzzphK9irIxUAUHVVEzDtj0GMF1p0JlA+7DeHjEP8o5XxWkkZ8dP
 IazjRAMlIeitoAlfOkhg3VQHQP7ay69mvaBcTeOnaowXFJvWPgBB5WfdqZ0Hlnw2
 13khCA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v68wyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:52:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso33164371cf.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785160376; x=1785765176; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PxA1ZVnCLGJ0duczVSZ3Xajv24AVSh0WMgCl6zv4cvU=;
 b=DOfNBlOSgyln6OoY+j3sjEb7xTzf7Ici4mNO+xLDBmiQ5W6gL/zjhLEUKmMBYttJW9
 n+9N4kz4JR2dQhYWbn2UNsZ6msHpYgEOmpByNMSotKWTomrMHDD58dxdXp/W4Aug00/I
 KIEcD6BJByRWhGR0CONPcTqkMl55PQfoDPGYBugXe/3YM7OWC7LeMfxLfV4clINRKlEC
 LtZwXCrai0FDsYTQeEB0sLKBR/lv4wTWojNUbqIXbB9QuYZO0GXXn4tYOOQZgR8zmZN4
 tVcLoxZU0BX71/zXGRVygtMccp7hnwBbn/qucqEqDbm5aFM2amzs2IrLX5Aio8S0HOvJ
 jcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160376; x=1785765176;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxA1ZVnCLGJ0duczVSZ3Xajv24AVSh0WMgCl6zv4cvU=;
 b=nQXQD6pBSi8S65YxAfr+9Czj7dH9CPxEM8YvM+TSFF2DdOLgIYGpaKZ6h7uPfBQFbB
 wFDzCSSaqt12dTcz8hUofHm4nUwxPno3Fm/nW9IRcioihofO6qDoYTbfryhGwgEvaH7p
 EMeDaqJtuDwk/jQNOghgZCTqXh2yPj28jK3DzsUNOIocvU8dejSBXSWq23yyo3rCwTz7
 duZB/tpNw9ksc1eOWCSYByuDxLwNhPiePRqsyds2EWgIFjHRg5RqvfPrms6lNx4YNkwH
 mWUm/W+lg1LyEM1iDHY9W6TeerotO4K298qmB2Gdfme6owuIQJtEC0Pc2D5pVZoqCkHV
 5u7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rro/eqjEcsJeS0m7MrFnsaImh+rvWM/tZAlTXv/XkFNxZB3S/Dgf7pCC0jabJosb80pRDpoAHYGVTAP@nongnu.org
X-Gm-Message-State: AOJu0YxhJH5u6Up/nFizs7TfzUapSSh/F/aiiMi7q1IuqMjbWB5npwW5
 EpXFspcFfLIttUEEcIlLdhqsTnI025X5N2x1Px8tWVUU4FfJTIvItQw+ocMbGS5qbMCOujF+l9+
 uDaRdu+wKy6msfws8Qga+jwsPkbrVaZ25S5qXcOUemwH/OUQVXxm44Krdnw==
X-Gm-Gg: AR+sD13GkIrZ0/bMk3nZ3v78U2eeeWyg6rA37DVpgZfvarecoTCdSZxjH6URw2+UyKN
 X+cyAcDwmzquMB4zLtPYiAgAJJ7qSPrHDhEAABClRb2EG2Sjb9gYP/k0ukshcXXy0HV1NoVxfe1
 lwN4rXDEKdjRr/CSyHDrYq0jVBR2RC+uzEE0f9jg7YLsy6UX8Dvg9Wl+KXkxUh1wsNWz8haR91i
 rpXrwiQxbIc2d+XHJqql2wMC4d+33HB6rUdacoq0Olc365Dpa2VEqzBHpupb+K3gLw7KmBqnBz4
 +5r3aaYFOfjdals+QS4+SbzuhA+NueMf65atosXSBddLAT9OgTrxLpLIiyl4SbsxF+FzlE/uopn
 ii2NgrQY55Kvr4fVOvLCVKVbrq9lbWzW3LBemp4TSNEZdFRkSMOk=
X-Received: by 2002:ac8:5894:0:b0:51c:1b78:b03b with SMTP id
 d75a77b69052e-529a86ac2d0mr90987041cf.52.1785160375689; 
 Mon, 27 Jul 2026 06:52:55 -0700 (PDT)
X-Received: by 2002:ac8:5894:0:b0:51c:1b78:b03b with SMTP id
 d75a77b69052e-529a86ac2d0mr90986721cf.52.1785160375097; 
 Mon, 27 Jul 2026 06:52:55 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f395aasm222575975e9.15.2026.07.27.06.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 06:52:54 -0700 (PDT)
Message-ID: <0f29e87a-b544-4e48-a4d6-a079696196a5@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 mst@redhat.com, richard.henderson@linaro.org, alex@shazbot.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMSBTYWx0ZWRfXyUw9IZ7XWoSq
 0L61uFD+ENosIz7rWexPMnHOUdCenIGjbiZB74FrI13X8kotEUdlN64z1e6kQXy+k3YHYTq2Pxp
 QvLMKu+xIHIYrmadIHIHGdpE7lv36Fo=
X-Proofpoint-GUID: pmTJj_qaEvA_PDhkpjurbzS0axmr4XPj
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a6762b8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=RZ64C5euXlMH85ShDJYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pmTJj_qaEvA_PDhkpjurbzS0axmr4XPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMSBTYWx0ZWRfX8KUtVVwk+g3N
 MM19q5dZ+wAqjIUjAYxYmphbZ0f1etd4oQHvlCDJZk9BDU0GveDtLt/dK3IUDP4zH7y5VDVO7RU
 AOVg2TGSny/Yy7DhuDyXGKaqxTxJxOuYF6gz+603D3BwV22FNKWGNc/3HigPvwclUhpoQtdgpB2
 BxNykPwczT8r4MoF/0tVoTk6CtT5JtQB9/NBWO5LqnmnMx31I1hg4/6N7mv310miRL6qRgal8l8
 KGSUclkNGeXUQ7+5HyQf77TL+f+hUw1O7mJiWMPoJEiByLPCfs5mKaHflbH6M7p1ciKNW6WEQvH
 zb+RCRjixQ0hHjEDjwU2a3TPkbeIFZ+IhgP68GzyHRLXc5FRVsIYmS7VfDdJ+N+/Y9/g054KzL/
 Yn+Ya4OSles003A38Kwn2rQdOXkfkDwDJ7iQ/LjoKfboAfnnRPf1h4K/5aK2vfTRYXWd3saOiu0
 pwVKcUUCN26U+NHiWdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 27/7/26 14:51, Peter Maydell wrote:
> On Mon, 27 Jul 2026 at 04:27, Gavin Shan <gshan@redhat.com> wrote:
> 
> Initial note: I think this is basically the right thing; I have
> some suggestions for beefing up the doc comment and some minor
> other things below.
> 
>> All ram device regions were turned to be indirectly accessible by commit
>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>> guest is started by the following command lines, with GH100 GPU card passed
>> from the host.
>>
>>     host$ lspci | grep GH100
>>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64            \
>>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>>           -accel kvm -cpu host -smp cpus=48 -m size=8G                       \
>>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>>             :
>>     guest$ cd cuda-samples/build
>>     guest$ make -j 20 clean
>>     guest$ make -j 20
>>             :
>>     [ 54%] Linking CUDA executable graphMemoryNodes
>>     [ 54%] Built target graphMemoryNodes
>>     <no more output afterwards, guest becomes frozen here>
>>
>>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
>>
>> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
>> the memory blocks residing in the PCI BAR#4 of the GH100 GPU card can
>> be presented to the guest through memory hot-add. The page cache can
>> then be allocated from the hot added memory blocks when cuda-samples
>> is being built. Afterwards, the page cache is sent to QEMU's virtio-blk
>> device as part of the DMA request, the bounce buffer has to be used to
>> accomodate the request as the corresponding memory region (MemoryRegion)
>> is an indirectly accessible ram device region in qemu. However, the max
>> bounce bufer size is only 4096 bytes by default and that is exhausted
>> quickly, leading to a reset on the virtio-blk device and frozen guest
>> eventually.
>>
>>    QEMU
>>    ====
>>    virtio_blk_handle_output
>>      virtio_blk_handle_vq
>>        virtio_blk_get_request
>>          virtqueue_pop
>>            virtqueue_split_pop
>>              virtqueue_map_desc
>>                address_space_map
>>                  memory_access_is_direct         # Return false
>>                    memory_region_supports_direct_access
>>
>>    (qemu) info mtree
>>    memory-region: pci_bridge_pci
>>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
>>
>> This adds qemu_ram_move() where the aligned and small-sized accesses are
>> handled by qatomics, and fall back to memmove() otherwise. The memove()
>> for the directly accessible regions is replaced by qemu_ram_move() so that
>> the issue covered by commit 4a2e242bbb (MMIO access instructions were
>> optimized to SSE instructions) is fixed. This makes 'ram_device_mem_ops'
>> redundant, paving the way to revert that commit to make the ram device
>> region directly accessible again in the next patch.
> 
> I think this commit message should also describe the second category
> of bug that we intend it to fix: the one where a device does e.g.
> address_space_stb() to a data structure in guest memory and requires
> it to write exactly that byte exactly once.
> 
> 
>> Reported-by: Julia Graham <jugraham@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
---

>> +void qemu_ram_move(void *dst, const void *src, size_t n)
>> +{
>> +    uintptr_t test, len;
>> +
>> +    if (src == dst || n == 0) {
> 
> I think we should not bother testing for src == dst. It's
> vanishingly unlikely to actually happen, and if it does
> happen then the code will work fine, and it's probably better
> to actually do the access in that case than to skip it.
> 
>> +        return;
>> +    }
>> +
>> +    test = (uintptr_t)src | (uintptr_t)dst | n;
>> +    len = test & -test;
> 
> What is this doing? I am not a fan of clever bit twiddling
> that isn't commented to explain itself. Readers of the code
> shouldn't have to go off and search for an explanation of what
> is going on.

"max alignment of the 3 values"?

> 
>> +
>> +    /* Overlapping buffers, unaligned or oversized access */
>> +    if (n > 8 || len != n) {
>> +        memmove(dst, src, n);
>> +        return;
>> +    }
>> +
>> +    switch (len) {
>> +    case 1:
>> +        qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>> +        break;
>> +    case 2:
>> +        qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>> +        break;
>> +    case 4:
>> +        qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>> +        break;
>> +    case 8:
>> +        qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}

Maybe more readable (untested):

-- >8 --
  void qemu_ram_move(void *dst, const void *src, size_t len)
  {
      if (unlikely(n == 0)) {
          return;
      }
      if (len == 1) {
          qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
          return;
      } else if (QEMU_PTR_IS_ALIGNED(dst, len) && 
QEMU_PTR_IS_ALIGNED(src, len)) {
          switch (len) {
          case 2:
              qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
              return;
          case 4:
              qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
            return;
          case 8:
              qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
              return;
          default:
              break;
        }
     }
     /* Overlapping buffers, unaligned or oversized access */
     memmove(dst, src, len);
  }
---


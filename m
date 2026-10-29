Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14052606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kOS9jVlA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eJtF8gxB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMXgJ-0006lF-0L; Thu, 29 Oct 2026 17:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMXgG-0006kg-OE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:29:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xMXgC-0003Ib-A7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 17:29:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjwLp1708077
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 62sI/vQKssAdhhq8486PV7MC8U2vUbt+YTihITKQobk=; b=kOS9jVlA3ejhgmzE
 xW2423vagk2r0knXEhLP+uI8s+m6JLvziNBVRCrsucfnB9iELK8kv0n/U0laTsww
 HDCNVHrxdtdJGMBpDTLHr4iTVnrybMNgjOl0OJnkpCuhmqpYOQfLmpvQo0wthzNG
 x2PVdF8Xli1eB5ptgxw0RpbrFBjEjQ7CVew6LMBAyFCPSiUA/yMNDMTU9q0pa667
 xLyQzz48C+zrDEawfNAYX6BdPYARkR5teP1tNEDJiJfcOCRC+G2DmPJnLc0RN55d
 5x2auRqgw3ZEN+bhguAsiAHol2P8ekp5aUEA03BbDrDm1ax2TPg9rlGt+g1Nw0Qm
 YUEcag==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ckdmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:28:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so407087485a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793309336; x=1793914136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=62sI/vQKssAdhhq8486PV7MC8U2vUbt+YTihITKQobk=;
 b=eJtF8gxB0p+BXVNVofqD/q5GjmWOSu2i1hkBcos+ucdSJEis5OvgoBdHgwVqWbfRO7
 6flClIDRxoUk7Pan64jNw1OAEKCVJrqwtcqwU76QG0QOKZB9zuYvTbnPuNLC4xyhD2HZ
 RmPLz5MzPRXIDwP9t3a/T1Q8rrUiYEq5D4k31Uu4QZa9E+/SaaUG+mB2lJN4h7Fydpvk
 qTmepAsQuHahKiXwiCaxjN5QKXyGHDqAsjDFEWsfiiylfeJ0uDB2F53CdvzDSrAm7rcj
 2aGWnHdVCTWC1jwzbJd5H2GeKGNCW3FXruLipBjjTfKt3q8SoK7DX6F4PiK9KhOPgVKe
 pjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309336; x=1793914136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62sI/vQKssAdhhq8486PV7MC8U2vUbt+YTihITKQobk=;
 b=Pd8ojgFGP1b9VbZi62ugKd+b6/yDC2jhHBdMZ01poE1Ux5vlLZT4KMzvIZf1ux8GwQ
 NfXBeSlrUJ5lZlvBK1HNFRGeN+aGEt270O2b8B4+V0GQg5Lo/pUynHCqvf1NCe1kn6pf
 pdZPe5a9EjDMgKmjd/OePUr2AhzhLDGVTMwEkFC8UmJQb3C8XHCBoOPCVztxQ9wZ2Nwy
 ToFWrVqYfodaqKpfYC7KzrPb0dxjGh97xB16VwKgwNOHjlG1OHZgZmfCpuM86HBkpi2i
 coLIfELy1Fjn9YwHpBGGWfNgbfjGwbdZydzuUoxVoh/VM8OXm72vQjDZmC5I8JoUpdiX
 oLKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ1qZOIhmGQekGMTXaLH5ObP1uKXOmQOnrHTNiDMW7FdsfZopXnN+SMCT0vnWJsIU1+yeoYD2XIETx@nongnu.org
X-Gm-Message-State: AFq9FYKo57jzda61Nl5GeaPInDYz8tJILwGxbvLxGDckiawfDTxpyrGS
 oHibVoCstxJTEyEINPBwYYMdqX2cuUy8I3b8zsFNqIlokR3D67QnP5QDu+Nb5H75Gz+CW5wu4cE
 ORhsAYJlMi2m3vT3lvE2qu3TMtu3PxWycY2k/flkrEXMd6b6sR4EgzjVuZQ==
X-Gm-Gg: AYBFou2dRxQ3enY5vEggyNFmzQEZMwPsnAs6N8lN9Mo1g+c7rufD5eq7KY2pwRyUuUh
 QcnOkmu+TZWKxwhs98n4KK77lzDwS6OfJ4p192SrT9Jz9L45N1nkRLvklqYIv6Nzt2MrUcuPmjH
 BkqL3UNJaVLln9e0anXduOBsUPcCm6XD1f9ddispQWoo+aYSIPOvdMIs4nsnZg3ZVPP4OJYEVBO
 FEbI5WXLu4AOYpJlrl8GbNExqsbZEg7DKMjC0tEpOIaqWjYihQh2Bw0Aca57kUZ485Dp2nR/QEF
 ngHfxLlgd/7nWcZEnlKF2lIYYoMARzhw0Bkq5wd1aCD8LZe6dt7omNHBoPNV7jS5ZdXp/43qFfe
 3tQpa10/B3bytelPnYK8JijFfRbFS7e3FSuA6qPAcAMdl2Qrw5Wpuo0ZYNXsCKYnYTbQwifVScH
 lu8AW7/L+L6Q==
X-Received: by 2002:a05:620a:880c:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-944217ee856mr76045085a.68.1793309336290; 
 Thu, 29 Oct 2026 14:28:56 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:93f:12d4:6760 with SMTP id
 af79cd13be357-944217ee856mr76040485a.68.1793309335613; 
 Thu, 29 Oct 2026 14:28:55 -0700 (PDT)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94421246c21sm43414785a.27.2026.10.29.14.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 14:28:55 -0700 (PDT)
Message-ID: <49ae69e6-aab4-4f7d-8a12-db28cf513a62@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:28:51 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/iommu-sys: honor MSI vector masks
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20261028031042.1496-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028031042.1496-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gStur-x3JD1pni2mlQaRtaG_7q5WWODZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXy0EB4gLsPS6M
 5WoNwpSMS9xkxnqXbz7Pgwf70vrZeZSpfRSm0vXxQm16tk5GqbpqcryZMHhKSw9/WbqMjVN31eJ
 aM+PlWpoZqA6H/i68RjR5uX9Nj68Pcrjtnbydp3HjHSLro3TMUthcgdTeZuNfv0xhDGT/rvI+O6
 AcST7TIDFxowdVfE6NvTRsv8MpR+yJGNqv6x4IZ3e2LqOC+/qvXHenkv3GxbxZhE/Eimw2ILB5O
 7ZOOzQs3mmERfoBh7OgRfCeghj5W/BkJwsWBPdCFiclsoHsNdAlKc+5TcaTMykwF/FJYTE7Tcdp
 v6GwL7YYzf81kgMM70odXms9wXJ2kR/aoEvIewD3hq8N1BmqjksWn0hI3TFyKfoZO0/tEZcfeSf
 jYiV3e1tinE+tU3HWFi8Jfk94f5GOs5eLRbFL2sGzI+qS/5tbv0MJObARPEra//q0hnt/VS1b7t
 OGH2krHGFJVoKD755Dw==
X-Proofpoint-GUID: gStur-x3JD1pni2mlQaRtaG_7q5WWODZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX/081RC3S+3sh
 cZMkRoFRazZJc4m5Ye83/uYGAHtSmdxBcwPmwVA1fUIViB6tNjyL4OcGuWk21gzBrX1aPvDpeI7
 JUg9xZqehl2VC94yiK5NhZZ06Pfq6e4=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3ba99 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=KftNe6ig8OfTfckRe1kA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/2026 12:10 AM, Zephyr Li wrote:
> The system IOMMU currently sends MSIs without checking the corresponding
> vector mask bit in the MSI configuration table.
> 
> Honor the mask bit and maintain one pending flag per vector. Notifications
> generated while masked are deferred and coalesced. Unmasking a vector
> delivers one pending MSI, if any, and reset clears all pending flags.
> 
> Do not release deferred MSIs while FCTL.WSI selects wired interrupt mode.
> When switching back to MSI mode, release unmasked pending vectors and
> retain masked ones until unmask.
> 
> Add qtests covering masked and unmasked delivery, vector isolation, MSI
> configuration updates, wired interrupt delivery, mode transitions, and
> reset.
> 
> Fixes: 01c1caa9d1b4 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4444
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

This is less of a bug fix and more of a new feature.  I was ducking it for
awhile because the Linux kernel support for masked MSIs with the RISC-V IOMMU
isn't there yet, but I'm glad you went ahead and implemented it anyway.

One comment:

>   hw/riscv/riscv-iommu-sys.c     |  67 ++++-
>   hw/riscv/riscv-iommu.c         |  12 +
>   hw/riscv/riscv-iommu.h         |   3 +
>   tests/qtest/iommu-riscv-test.c | 461 +++++++++++++++++++++++++++++++++
>   4 files changed, 541 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 258c171efd..96d2bdff7a 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -52,8 +52,50 @@ struct RISCVIOMMUStateSys {
>       MemoryRegion msix_pba_mmio;
>       uint8_t *msix_table;
>       uint8_t *msix_pba;
> +    /* Platform MSI state; the reserved PBA region does not expose it. */

Can you add the riscv-iommu/riscv-aia citation that says that the PBA region doesn't
need update for this kind of masking?  As far as I'm aware we would need to update
msix_pba too, along with the msi_pending array you created.  Basically every time
you set s->msi_pending[vector] = true you would write '1' in msix_pba[vector],
and likewise when you're seeting s->msi_pending[vector] = false.

In fact, do we need s->msi_pending?  Can't we just use msix_pba directly?


Thanks,
Daniel



> +    bool msi_pending[RISCV_IOMMU_PCI_MSIX_VECTORS];
>   };
>   
> +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
> +                                                 uint32_t vector);
> +
> +static bool riscv_iommu_sysdev_msi_masked(RISCVIOMMUStateSys *s,
> +                                          uint32_t vector)
> +{
> +    uint8_t *table_entry;
> +
> +    g_assert(vector < RISCV_IOMMU_PCI_MSIX_VECTORS);
> +    table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
> +
> +    return pci_get_long(table_entry + PCI_MSIX_ENTRY_VECTOR_CTRL) &
> +           PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +}
> +
> +static void riscv_iommu_sysdev_release_pending(RISCVIOMMUStateSys *s,
> +                                              uint32_t vector)
> +{
> +    /* Retain deferred MSI messages until MSI mode is restored. */
> +    if (riscv_iommu_reg_get32(&s->iommu, RISCV_IOMMU_REG_FCTL) &
> +        RISCV_IOMMU_FCTL_WSI) {
> +        return;
> +    }
> +
> +    if (s->msi_pending[vector] &&
> +        !riscv_iommu_sysdev_msi_masked(s, vector)) {
> +        s->msi_pending[vector] = false;
> +        riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
> +    }
> +}
> +
> +static void riscv_iommu_sysdev_msi_enabled(RISCVIOMMUState *iommu)
> +{
> +    RISCVIOMMUStateSys *s = container_of(iommu, RISCVIOMMUStateSys, iommu);
> +
> +    for (unsigned vector = 0; vector < ARRAY_SIZE(s->msi_pending); vector++) {
> +        riscv_iommu_sysdev_release_pending(s, vector);
> +    }
> +}
> +
>   static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
>                                        unsigned size)
>   {
> @@ -67,9 +109,17 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
>                                     uint64_t val, unsigned size)
>   {
>       RISCVIOMMUStateSys *s = opaque;
> +    uint32_t vector = addr / PCI_MSIX_ENTRY_SIZE;
> +    bool was_masked;
>   
>       g_assert(addr + size <= RISCV_IOMMU_PCI_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE);
> +
> +    was_masked = riscv_iommu_sysdev_msi_masked(s, vector);
>       pci_set_long(s->msix_table + addr, val);
> +
> +    if (was_masked && !riscv_iommu_sysdev_msi_masked(s, vector)) {
> +        riscv_iommu_sysdev_release_pending(s, vector);
> +    }
>   }
>   
>   static const MemoryRegionOps msix_table_mmio_ops = {
> @@ -134,8 +184,8 @@ static void riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
>                                   &s->msix_pba_mmio);
>   }
>   
> -static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> -                                        uint32_t vector)
> +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s,
> +                                                 uint32_t vector)
>   {
>       uint8_t *table_entry = s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
>       uint64_t msi_addr = pci_get_quad(table_entry + PCI_MSIX_ENTRY_LOWER_ADDR);
> @@ -160,6 +210,17 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
>       }
>   }
>   
> +static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> +                                        uint32_t vector)
> +{
> +    if (riscv_iommu_sysdev_msi_masked(s, vector)) {
> +        s->msi_pending[vector] = true;
> +        return;
> +    }
> +
> +    riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
> +}
> +
>   static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
>                                         unsigned vector)
>   {
> @@ -194,6 +255,7 @@ static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
>       }
>   
>       s->iommu.notify = riscv_iommu_sysdev_notify;
> +    s->iommu.msi_enabled = riscv_iommu_sysdev_msi_enabled;
>   
>       /* 4 IRQs are defined starting from s->base_irq */
>       for (int i = 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
> @@ -255,6 +317,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
>       RISCVIOMMUState *iommu = &sys->iommu;
>   
>       riscv_iommu_reset(iommu);
> +    memset(sys->msi_pending, 0, sizeof(sys->msi_pending));
>   
>       trace_riscv_iommu_sys_reset_hold(type);
>   }
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 323a041b4a..23b6f8da86 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2419,6 +2419,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>       RISCVIOMMUState *s = opaque;
>       uint32_t regb = addr & ~3;
>       uint32_t busy = 0;
> +    uint32_t old_fctl = 0;
>       uint64_t val = 0;
>       bool cy_inh = false;
>   
> @@ -2434,6 +2435,10 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>   
>       /* Track actionable MMIO write. */
>       switch (regb) {
> +    case RISCV_IOMMU_REG_FCTL:
> +        old_fctl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
> +        break;
> +
>       case RISCV_IOMMU_REG_DDTP:
>       case RISCV_IOMMU_REG_DDTP + 4:
>           process_fn = riscv_iommu_process_ddtp;
> @@ -2510,6 +2515,13 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>        */
>       riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
>   
> +    if (regb == RISCV_IOMMU_REG_FCTL && s->msi_enabled &&
> +        (old_fctl & RISCV_IOMMU_FCTL_WSI) &&
> +        !(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL) &
> +          RISCV_IOMMU_FCTL_WSI)) {
> +        s->msi_enabled(s);
> +    }
> +
>       /* Busy flag update, MSB 4-byte register. */
>       if (busy) {
>           uint32_t rw = ldl_le_p(&s->regs[regb]);
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 7c470ba084..ea1b53e732 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -61,6 +61,9 @@ struct RISCVIOMMUState {
>       /* interrupt notifier */
>       void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>   
> +    /* Optional platform callback when FCTL switches from WSI to MSI. */
> +    void (*msi_enabled)(RISCVIOMMUState *iommu);
> +
>       /* IOMMU target address space */
>       AddressSpace *target_as;
>       MemoryRegion *target_mr;
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> index 2638024891..979a976e4f 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -19,6 +19,28 @@
>   
>   #define DMA_LEN           4
>   
> +#define RISCV_IOMMU_SYS_MSI_TARGET0  (QRIOMMU_SPACE_OFFS + 0x03000000ull)
> +#define RISCV_IOMMU_SYS_MSI_TARGET1  (RISCV_IOMMU_SYS_MSI_TARGET0 + 4)
> +#define RISCV_IOMMU_SYS_CQ_BASE      \
> +    (QRIOMMU_SPACE_OFFS + QRIOMMU_CQ_BASE_ADDR)
> +#define RISCV_IOMMU_SYS_MSI_DATA0    0x12345678
> +#define RISCV_IOMMU_SYS_MSI_DATA1    0xa5a55a5a
> +
> +/* RISC-V virt machine PLIC, hart 0 M-mode context. */
> +#define RISCV_PLIC_BASE             0x0c000000
> +#define RISCV_PLIC_PENDING          (RISCV_PLIC_BASE + 0x1000)
> +#define RISCV_PLIC_ENABLE           (RISCV_PLIC_BASE + 0x2000)
> +#define RISCV_PLIC_THRESHOLD        (RISCV_PLIC_BASE + 0x200000)
> +#define RISCV_PLIC_CLAIM            (RISCV_PLIC_THRESHOLD + 4)
> +#define RISCV_IOMMU_SYS_IRQ_BASE    36
> +
> +#define PCI_TESTDEV_TEST             0
> +#define PCI_TESTDEV_WIDTH            1
> +#define PCI_TESTDEV_OFFSET           4
> +#define PCI_TESTDEV_DATA             8
> +#define PCI_TESTDEV_COUNT            12
> +#define PCI_TESTDEV_NO_EVENTFD       0
> +
>   /* RISC-V virt machine PCI configuration */
>   #define RISCV_GPEX_PIO_BASE        0x3000000
>   #define RISCV_BUS_PIO_LIMIT        0x10000
> @@ -264,6 +286,425 @@ static void test_riscv_iommu_nested(void)
>       run_riscv_iommu_translation(&cfg);
>   }
>   
> +static void riscv_iommu_sys_set_wsi(QTestState *qts, bool wsi)
> +{
> +    uint64_t base = VIRT_RISCV_IOMMU_BASE;
> +    uint32_t fctl;
> +
> +    /* Feature changes require Off mode and all in-memory queues disabled. */
> +    g_assert_cmphex(qtest_readq(qts, base + RISCV_IOMMU_REG_DDTP) &
> +                    (RISCV_IOMMU_DDTP_MODE | RISCV_IOMMU_DDTP_BUSY),
> +                    ==, RISCV_IOMMU_DDTP_MODE_OFF);
> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_CQCSR) &
> +                    (RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CQON |
> +                     RISCV_IOMMU_CQCSR_BUSY), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FQCSR) &
> +                    (RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FQON |
> +                     RISCV_IOMMU_FQCSR_BUSY), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_PQCSR) &
> +                    (RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PQON |
> +                     RISCV_IOMMU_PQCSR_BUSY), ==, 0);
> +
> +    fctl = qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL);
> +    fctl = (fctl & ~RISCV_IOMMU_FCTL_WSI) |
> +           (wsi ? RISCV_IOMMU_FCTL_WSI : 0);
> +    qtest_writel(qts, base + RISCV_IOMMU_REG_FCTL, fctl);
> +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL) &
> +                    RISCV_IOMMU_FCTL_WSI, ==, fctl & RISCV_IOMMU_FCTL_WSI);
> +}
> +
> +static QTestState *riscv_iommu_sys_test_init(const char *extra_args)
> +{
> +    QTestState *qts;
> +    uint64_t cap;
> +    uint32_t igs;
> +
> +    if (!qtest_has_machine("virt")) {
> +        g_test_skip("virt machine not available");
> +        return NULL;
> +    }
> +
> +    qts = qtest_initf("-machine virt,aia=none,acpi=off,iommu-sys=on "
> +                      "-cpu max -smp 1 -m 512 -net none -nodefaults %s",
> +                      extra_args ? extra_args : "");
> +
> +    cap = qtest_readq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CAP);
> +    igs = (cap & RISCV_IOMMU_CAP_IGS) >> 28;
> +    g_assert_cmpuint(igs, <=, RISCV_IOMMU_CAP_IGS_BOTH);
> +    g_assert_cmpuint(igs, !=, RISCV_IOMMU_CAP_IGS_WSI);
> +
> +    riscv_iommu_sys_set_wsi(qts, false);
> +
> +    return qts;
> +}
> +
> +static QPCIDevice *riscv_iommu_sys_init_msi_sink(QTestState *qts,
> +                                                  QGenericPCIBus *gbus,
> +                                                  QPCIBar *bar,
> +                                                  uint64_t *target,
> +                                                  uint32_t *data)
> +{
> +    QPCIDevice *dev = NULL;
> +    uint32_t offset;
> +
> +    qpci_init_generic(gbus, qts, NULL, false);
> +    riscv_config_qpci_bus(gbus);
> +    qpci_device_foreach(&gbus->bus, PCI_VENDOR_ID_REDHAT,
> +                        PCI_DEVICE_ID_REDHAT_TEST, save_fn, &dev);
> +    g_assert(dev);
> +
> +    qpci_device_enable(dev);
> +    *bar = qpci_iomap(dev, 0, NULL);
> +    g_assert_false(bar->is_io);
> +
> +    qpci_io_writeb(dev, *bar, PCI_TESTDEV_TEST, PCI_TESTDEV_NO_EVENTFD);
> +    g_assert_cmpuint(qpci_io_readb(dev, *bar, PCI_TESTDEV_WIDTH), ==, 1);
> +    offset = qpci_io_readl(dev, *bar, PCI_TESTDEV_OFFSET);
> +    *data = qpci_io_readl(dev, *bar, PCI_TESTDEV_DATA);
> +    *target = bar->addr + offset;
> +    g_assert_cmpuint(qpci_io_readl(dev, *bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    return dev;
> +}
> +
> +static void riscv_iommu_sys_program_msi(QTestState *qts, unsigned vector,
> +                                        uint64_t target, uint32_t data,
> +                                        bool masked)
> +{
> +    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG +
> +                     vector * PCI_MSIX_ENTRY_SIZE;
> +
> +    qtest_writeq(qts, entry + PCI_MSIX_ENTRY_LOWER_ADDR, target);
> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_DATA, data);
> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
> +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
> +}
> +
> +static void riscv_iommu_sys_set_mask(QTestState *qts, unsigned vector,
> +                                     bool masked)
> +{
> +    uint64_t entry = VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CONFIG +
> +                     vector * PCI_MSIX_ENTRY_SIZE;
> +
> +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
> +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
> +}
> +
> +static void riscv_iommu_sys_setup_cq(QTestState *qts)
> +{
> +    uint64_t cqb = (RISCV_IOMMU_SYS_CQ_BASE >> 12) << 10;
> +    uint32_t cqcsr;
> +
> +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE, UINT64_MAX);
> +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE + 8, 0);
> +    qtest_writeq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQB, cqb);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
> +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE);
> +
> +    cqcsr = qtest_readl(qts,
> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CQON,
> +                    ==, RISCV_IOMMU_CQCSR_CQON);
> +}
> +
> +static void riscv_iommu_sys_trigger_cq_irq(QTestState *qts)
> +{
> +    uint32_t cqcsr;
> +
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 1);
> +    cqcsr = qtest_readl(qts,
> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL,
> +                    ==, RISCV_IOMMU_CQCSR_CMD_ILL);
> +}
> +
> +static void riscv_iommu_sys_rearm_cq_irq(QTestState *qts)
> +{
> +    uint32_t cqcsr;
> +
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
> +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
> +                 RISCV_IOMMU_CQCSR_CMD_ILL);
> +    cqcsr = qtest_readl(qts,
> +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);
> +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL, ==, 0);
> +
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_IPSR,
> +                 RISCV_IOMMU_IPSR_CIP);
> +    g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE +
> +                               RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_CIP,
> +                    ==, 0);
> +}
> +
> +static void test_riscv_iommu_sys_msi_unmasked(void)
> +{
> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA0, false);
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
> +                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_masked(void)
> +{
> +    QGenericPCIBus gbus;
> +    QPCIBar sink_bar;
> +    QPCIDevice *sink;
> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
> +    uint64_t sink_target;
> +    uint32_t sink_data;
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> +                                         &sink_target, &sink_data);
> +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
> +    riscv_iommu_sys_setup_cq(qts);
> +
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    riscv_iommu_sys_rearm_cq_irq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
> +
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
> +    g_free(sink);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_config_update(void)
> +{
> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +
> +    /* Updating a masked entry must not release the deferred message. */
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET1,
> +                                RISCV_IOMMU_SYS_MSI_DATA1, true);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
> +
> +    /* Release uses the current address and data, rather than a snapshot. */
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
> +                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_vector_isolation(void)
> +{
> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> +    riscv_iommu_sys_program_msi(qts, 1, RISCV_IOMMU_SYS_MSI_TARGET1,
> +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
> +    riscv_iommu_sys_setup_cq(qts);
> +
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), ==, 0);
> +
> +    riscv_iommu_sys_rearm_cq_irq(qts);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, 1);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
> +                    ==, RISCV_IOMMU_SYS_MSI_DATA1);
> +
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
> +                    ==, RISCV_IOMMU_SYS_MSI_DATA0);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_wsi_switch(const void *opaque)
> +{
> +    bool unmask_in_wsi = GPOINTER_TO_INT(opaque);
> +    QGenericPCIBus gbus;
> +    QPCIBar sink_bar;
> +    QPCIDevice *sink;
> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
> +    uint64_t sink_target;
> +    uint32_t sink_data;
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    g_assert_cmpuint((qtest_readq(qts, VIRT_RISCV_IOMMU_BASE +
> +                                 RISCV_IOMMU_REG_CAP) &
> +                      RISCV_IOMMU_CAP_IGS) >> 28,
> +                     ==, RISCV_IOMMU_CAP_IGS_BOTH);
> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> +                                         &sink_target, &sink_data);
> +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    /* Stop the CQ before changing FCTL, preserving the deferred message. */
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
> +    riscv_iommu_sys_set_wsi(qts, true);
> +    if (unmask_in_wsi) {
> +        riscv_iommu_sys_set_mask(qts, 0, false);
> +    }
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    riscv_iommu_sys_set_wsi(qts, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> +                     ==, unmask_in_wsi ? 1 : 0);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
> +
> +    /* Repeated mode changes and unmask writes must not replay the MSI. */
> +    riscv_iommu_sys_set_wsi(qts, true);
> +    riscv_iommu_sys_set_wsi(qts, false);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 1);
> +    g_free(sink);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_wsi_delivery(void)
> +{
> +    const unsigned vector = 1;
> +    const unsigned irq = RISCV_IOMMU_SYS_IRQ_BASE + vector;
> +    const uint32_t irq_bit = 1U << (irq % 32);
> +    const unsigned irq_word = (irq / 32) * 4;
> +    QGenericPCIBus gbus;
> +    QPCIBar sink_bar;
> +    QPCIDevice *sink;
> +    QTestState *qts = riscv_iommu_sys_test_init("-device pci-testdev");
> +    uint64_t sink_target;
> +    uint32_t sink_data;
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    sink = riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> +                                         &sink_target, &sink_data);
> +    riscv_iommu_sys_set_wsi(qts, true);
> +    /* The MSI vector mask must not suppress delivery through the wire. */
> +    riscv_iommu_sys_program_msi(qts, vector, sink_target, sink_data, true);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, vector);
> +
> +    qtest_writel(qts, RISCV_PLIC_BASE + irq * 4, 1);
> +    qtest_writel(qts, RISCV_PLIC_ENABLE + irq_word, irq_bit);
> +    qtest_writel(qts, RISCV_PLIC_THRESHOLD, 0);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word), ==, 0);
> +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, 0);
> +
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    /* The PLIC latches the pulse after the device's wire returns low. */
> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
> +                    ==, irq_bit);
> +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), ==, irq);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word), ==, 0);
> +    qtest_writel(qts, RISCV_PLIC_CLAIM, irq);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +
> +    /* A WSI event must not become a deferred MSI after switching modes. */
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
> +    riscv_iommu_sys_set_wsi(qts, false);
> +    riscv_iommu_sys_set_mask(qts, vector, false);
> +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT), ==, 0);
> +    g_free(sink);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_wsi_reset(void)
> +{
> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0);
> +    riscv_iommu_sys_set_wsi(qts, true);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +
> +    qtest_system_reset(qts);
> +    /* Reprogram valid MSI state without depending on table reset values. */
> +    riscv_iommu_sys_set_wsi(qts, true);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
> +    riscv_iommu_sys_set_wsi(qts, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    riscv_iommu_sys_set_mask(qts, 0, true);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    qtest_quit(qts);
> +}
> +
> +static void test_riscv_iommu_sys_msi_reset(void)
> +{
> +    QTestState *qts = riscv_iommu_sys_test_init(NULL);
> +
> +    if (!qts) {
> +        return;
> +    }
> +
> +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> +    riscv_iommu_sys_setup_cq(qts);
> +    riscv_iommu_sys_trigger_cq_irq(qts);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +
> +    qtest_system_reset(qts);
> +    riscv_iommu_sys_set_mask(qts, 0, false);
> +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), ==, 0);
> +    qtest_quit(qts);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -275,5 +716,25 @@ int main(int argc, char **argv)
>                      test_riscv_iommu_g_stage_only);
>       qtest_add_func("/iommu-testdev/translation/ns-nested",
>                      test_riscv_iommu_nested);
> +    qtest_add_func("/riscv-iommu-sys/msi/unmasked",
> +                   test_riscv_iommu_sys_msi_unmasked);
> +    qtest_add_func("/riscv-iommu-sys/msi/masked",
> +                   test_riscv_iommu_sys_msi_masked);
> +    qtest_add_func("/riscv-iommu-sys/msi/config-update",
> +                   test_riscv_iommu_sys_msi_config_update);
> +    qtest_add_func("/riscv-iommu-sys/msi/vector-isolation",
> +                   test_riscv_iommu_sys_msi_vector_isolation);
> +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-unmasked",
> +                        GINT_TO_POINTER(true),
> +                        test_riscv_iommu_sys_msi_wsi_switch);
> +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-masked",
> +                        GINT_TO_POINTER(false),
> +                        test_riscv_iommu_sys_msi_wsi_switch);
> +    qtest_add_func("/riscv-iommu-sys/wsi/delivery",
> +                   test_riscv_iommu_sys_wsi_delivery);
> +    qtest_add_func("/riscv-iommu-sys/msi/wsi-reset",
> +                   test_riscv_iommu_sys_msi_wsi_reset);
> +    qtest_add_func("/riscv-iommu-sys/msi/reset",
> +                   test_riscv_iommu_sys_msi_reset);
>       return g_test_run();
>   }



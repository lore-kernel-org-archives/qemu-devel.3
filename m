Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB2606F7C5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OQIqymj0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G2ZOZClr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOCWE-0005Pr-F0; Tue, 03 Nov 2026 06:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCWC-0005NL-0J
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:17:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xOCW8-0005Df-7N
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:17:31 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AABuQ3131576
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hZuJ1/Yo0RSCt/Z0ED7F/KG05J0433OZ8btCYsQoN/c=; b=OQIqymj0pfELwEom
 pLc45ubSSsHlX+5R4WLHIva13wwqSipcnyd+zlc8jJNExfWHae537py5jL4NMETH
 ORD1FMTbgPC780qyzi37OmA/X7yBQ0W8Vi2SkmM2Ij7Z8ju3/h5jw4BIRvHYP9n1
 KEnXl0hqFT/ASrqZKmrHnER0dK3Eh8FzKjJk2WjyEcUi1nEJRLOaK1gHNGM+kkoV
 CaHANlt68+drnux/Ml/WU3bkuShiGwiEUqdSCumoizWw02TEptQartTorpQXT+xm
 FNKGl41IaxO+19s+sUBe8+b0bz+qyKcCm6vxqy0ceWncgXLyyAfrj7olNr9tSto3
 hKX9RA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94cse9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:17:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53664911d46so63481261cf.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793704646; x=1794309446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZuJ1/Yo0RSCt/Z0ED7F/KG05J0433OZ8btCYsQoN/c=;
 b=G2ZOZClr9qus02HygF5HV987nuQY188eGdB6tXsVWnnel5bloD7zk4b++MKGKYDRMt
 EdjZ4/PAycnBvwTXJ9DvBKAicSDkYt+OlUhBs1A8eSVEfP0lEAJu4CZMscViliE5L3Ud
 9tCka+L6hAE7d3qDsvzUQxFM0N8YwWoN6bf2E/268Y2W+km4zXnNMYAl89dQdYu+7jz3
 HgHajS/JNzbZbXXkRhQRjOVJHJXO9GhAEFquF2zxKNEq3if5NwIHIceo/chOyNplkEGr
 iIGYKRVGUX9yP1NVkHu6AImYSeyZr5IHhIPjpBX76aaOjbRtnkRqLFkQWyCEGYuxd1Kd
 96oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704646; x=1794309446;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZuJ1/Yo0RSCt/Z0ED7F/KG05J0433OZ8btCYsQoN/c=;
 b=g1XqUjDYE6Gg67osM39GtlUfIqUQpph/QlbsvSznYCEBvArqLAMnaKiR9nMxQjFHHV
 baJsM7X0ZKEa0lTwIdB6mWYT+B38aB7KicujdZLpTMq9P8/okoIfdrUer/CVv5cxvRgH
 fzxGySDB+aFj1Dmxj0txtHVlrT7CcH5q49qcGHqyCx8V5qqnznTA1bipQGAXjhiHqJ1N
 kQwTmWZDk5a2w3swlPCKtDIi5RyWLQcbdFVsuFiDxEoO1WHe0rAxDNwCRnZ4BK8MxRHz
 FclbtHm9zlr7W9tsUhAqPesOgHg5H89ELjiMEJh/IclrJaggi/hfU6PYGY6SvzKf1+SW
 1wFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPVgBgOvOvQJl3SklJ2BtNSEOcFazNg/l9Vk2rS0thW+I1s8W7CmjYZr7z124vXLP4Spl66WJ6irPU@nongnu.org
X-Gm-Message-State: APuU4Z90CNDSi6Gr44QfXHpYYIO+By+i3SupGd79e4DPy7R8tVa94avW
 F5jFY30ujQNbK5FA7DVJ680HmLURw+DzogipENCt3NU6+ha/2KqIo6+7sypz7haJxYPyUAnuC5E
 EdMuwDrs4ERk4DCdIdwce5GzIdgL/QlZcazjic0Oew+vVLI3SLOFvZXdMPg==
X-Gm-Gg: AYBFou0RLHtcGe20WBCsNXxi/4YNoK+grv1A3Cr9bYHIXGj4r5wBYKmYe40dFDtzZZW
 d3VTmZdOeMchUs+1fFmUKZmq1+ZUn5c+R+T3LDKjOq5+PC99QC7iGjv8Yzp5i2O7jq1Y48Hj1kl
 VCqqeKsKGPopkxIo/DfNqYzALXnqpwqGgJWGsAoJF0/cY32esz1TIXjlkKVE8+FN6GNL/w1SIhx
 bWLq3aj8V36nllh+jVDfEklo6TzsoxOajoYxXX9cDszK9l3jX3XtD/4cKIQ0n27lCYmn4Zx26h6
 6cmnKTKXUNXuWVaS1CZAYwbusQbWaTaehLHQyS0Osv76Tfkhho4lAEEl6eYNJPfn7DtQSFD63Tt
 r6btKkmSV6mPwfVyIk0IubTt90MR5FFeF9KyzPPW/6YnsAR8sT2s9YXJTNhIMEu7NhmUK9uJGAt
 TFfbQuvQ==
X-Received: by 2002:a05:622a:420d:b0:535:21fd:30b2 with SMTP id
 d75a77b69052e-542b6f4fb31mr208261001cf.42.1793704645414; 
 Tue, 03 Nov 2026 03:17:25 -0800 (PST)
X-Received: by 2002:a05:622a:420d:b0:535:21fd:30b2 with SMTP id
 d75a77b69052e-542b6f4fb31mr208260631cf.42.1793704644758; 
 Tue, 03 Nov 2026 03:17:24 -0800 (PST)
Received: from [192.168.15.12] ([187.56.223.122])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5498cc59c80sm23521241cf.27.2026.11.03.03.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:17:24 -0800 (PST)
Message-ID: <f1039605-87c0-41bd-86f9-8eaf896bd691@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 08:17:17 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv/iommu-sys: honor MSI vector masks
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20261102081421.31332-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261102081421.31332-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6ae9c2c6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=bus90iwuyia7r0C3gDGjVg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=HwFc7jivAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=V9IQuAXPBFPZJmHPcX4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-ORIG-GUID: xZFy9JNwEt9MkI43nx7oer64M3dC9xZ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfXymIXG/kNV6Bw
 4TDyHvQsSTaiH/qPoOAdCvxWfxSYgoD34xB1LrkLBubUgx2/NN8YPy8rZT5l38OBICctFGgQ9Y0
 nJQbIs6pDmnBAhYHmVG956RzJITkRDf8XyEhkI90yHjvcpOXYMUZBrL7u0TfJS7XySpo5Z1uPWU
 rMitOpqZzD9DxbKfaXLT040VvKEOuVK8jgp45iSvRWL5g3bZ5+46fIFnHl86XykTcu2UJQVUULz
 j+aSSzpHCPMc/v7am8eWIv5Ds0+ZGAiysBkxm3pXg1ISmIKz9t7ORRLeQCdS22VW+UseUECWHl8
 wRdfs/8rDK5zQm7Kkg0XLgPCGBjJi1i3aHz+smiIpXjnhz7NT56BQOmqHLZaAdAj68v41PjZBx0
 qWYD2SIyn9lfBc7WQST23PEIBOTGnx4qlZSSH1J3UQPbXDAvI24UdgHkOzAW1y2oXqGOhk081uZ
 RlPPm98jSKLrpg6gZHg==
X-Proofpoint-GUID: xZFy9JNwEt9MkI43nx7oer64M3dC9xZ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfXwVDEHShgR3ce
 eK03pu54oEWohr+lp12IMg6CLLfw4KUtqMfasbvO1y8Rap55xpYFb0JVkQud85soojvmdboz/Xp
 voG2iqNJLlt4UL4mdHdS6oMsCAWWsHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030044
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/2/2026 5:14 AM, Zephyr Li wrote:
> The system IOMMU currently sends MSIs without checking the
> corresponding vector mask bit in the MSI configuration table.
> 
> Implement per-vector masking and maintain a separate pending flag
> for each vector. Notifications generated while masked are deferred
> and coalesced. Unmasking a vector delivers one pending MSI, if any,
> and reset clears all pending flags.
> 
> Keep the pending state separate from msix_pba because the current
> PBA MMIO mapping overlaps the reserved RISC-V IOMMU register space.
> 
> Do not release deferred MSIs while FCTL.WSI selects wired interrupt mode.
> When switching back to MSI mode, release unmasked pending vectors and
> retain masked ones until unmask.
> 
> Add qtests covering masked and unmasked delivery, vector isolation,
> MSI configuration updates, wired interrupt delivery, mode
> transitions, and reset.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4444
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> Changes in v2:
> - Document why the MSI pending state is kept separate from msix_pba.
> - Add RISC-V IOMMU specification references for the reserved MMIO
>    region and PCIe MSI-X PBA.
> - Add a qtest ensuring pending MSIs are not exposed through the
>    reserved MSI-X PBA MMIO region.
> - Rebase onto the latest QEMU master.
> 
>   hw/riscv/riscv-iommu-sys.c     |  83 +++++-
>   hw/riscv/riscv-iommu.c         |  12 +
>   hw/riscv/riscv-iommu.h         |   3 +
>   tests/qtest/iommu-riscv-test.c | 469 +++++++++++++++++++++++++++++++++
>   4 files changed, 565 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 258c171efd..f849b7a763 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -52,8 +52,66 @@ struct RISCVIOMMUStateSys {
>       MemoryRegion msix_pba_mmio;
>       uint8_t *msix_table;
>       uint8_t *msix_pba;
> +    /*
> +     * Keep MSI pending state separate from msix_pba.
> +     *
> +     * The msix_pba MMIO region is mapped at offset 0x400, which is
> +     * within the RISC-V IOMMU reserved register space (0x400-0xfff).
> +     * Reads from this reserved region must return zero. Using msix_pba
> +     * to track pending MSIs would expose non-zero bits through MMIO.
> +     *
> +     * The specification describes the MSI-X PBA in the context of
> +     * PCIe IOMMU integration, while this device is a SysBus device.
> +     * Therefore, maintain pending MSIs independently without updating
> +     * msix_pba.
> +     *
> +     * See:
> +     * https://docs.riscv.org/reference/iommu/v20260222/iommu_registers.html
> +     * https://docs.riscv.org/reference/iommu/v20260222/iommu_hw_guidelines.html
> +     */
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
> @@ -67,9 +125,17 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
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
> @@ -134,8 +200,8 @@ static void riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
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
> @@ -160,6 +226,17 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
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
> @@ -194,6 +271,7 @@ static void riscv_iommu_sys_realize(DeviceState *dev, Error **errp)
>       }
>   
>       s->iommu.notify = riscv_iommu_sysdev_notify;
> +    s->iommu.msi_enabled = riscv_iommu_sysdev_msi_enabled;
>   
>       /* 4 IRQs are defined starting from s->base_irq */
>       for (int i = 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
> @@ -255,6 +333,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
>       RISCVIOMMUState *iommu = &sys->iommu;
>   
>       riscv_iommu_reset(iommu);
> +    memset(sys->msi_pending, 0, sizeof(sys->msi_pending));
>   
>       trace_riscv_iommu_sys_reset_hold(type);
>   }
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 0e6970773a..5209ed2c23 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2424,6 +2424,7 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
>       RISCVIOMMUState *s = opaque;
>       uint32_t regb = addr & ~3;
>       uint32_t busy = 0;
> +    uint32_t old_fctl = 0;
>       uint64_t val = 0;
>       bool cy_inh = false;
>   
> @@ -2439,6 +2440,10 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
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
> @@ -2515,6 +2520,13 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
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
> index 403d10b321..e9c520981a 100644
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
> index 1cd753c4f2..0c05b3bd1b 100644
> --- a/tests/qtest/iommu-riscv-test.c
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -25,6 +25,28 @@
>   #define DBG_TRANSLATED_PA       0x90000000ull
>   #define DBG_NESTED_GPA          0x200000ull
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
> @@ -451,6 +473,432 @@ static void test_riscv_iommu_dbg(gconstpointer data)
>       riscv_iommu_test_teardown(&state);
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
> +    /*
> +     * Pending MSIs must not be exposed through the reserved
> +     * MSI-X PBA MMIO region.
> +     */
> +    g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE + 0x400),
> +                    ==, 0);
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
> @@ -468,5 +916,26 @@ int main(int argc, char **argv)
>   
>           qtest_add_data_func(path, &debug_tests[i], test_riscv_iommu_dbg);
>       }
> +
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



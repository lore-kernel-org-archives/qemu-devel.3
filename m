Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9200606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mK2LA0ha;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z9WP8VDq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpMQ-0000wv-Vy; Tue, 24 Nov 2026 07:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVpMP-0000w7-Pr
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:10:57 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVpMM-00067X-3T
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:10:57 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuaN71991488
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dFTlc8A4BU9VskvAEZY7T5zU4YZVc7LfjAvhtaZEzOg=; b=mK2LA0hawLqVZuqt
 97Dv9dH4gy6oZPYyXJUmYKD9XOH1pvAEfQqsYqNG0X7MFzotdUxxvFCZQb3oUfum
 fZoUViyxSjCL8t1K7gDCkhBY4WKjnaZWjOGedNqdQeOqbpgq5SrO7pf/0GAfxkWZ
 ILaTaO5QyiSuD9ctWJp1TQTizMXwnp0jlefCGKJZ689zMl5/GB02lXLyvIliRM7m
 ZnGrC7Rp4VSp20jPzN3Hrdb24//AbH3yOIc448AqqfKJX73rZuviZtH07YoQc3F6
 1wnXIZocjqG+lcdSbgxARczFZaSHdjRB3gxFWks4dNi5Pfgb7dEGtDHge/su5ogA
 kGSa1Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6su6c7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:10:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2c0e6653so688117785a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795522251; x=1796127051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dFTlc8A4BU9VskvAEZY7T5zU4YZVc7LfjAvhtaZEzOg=;
 b=Z9WP8VDqtRQCfIHa/6NjOathSCI+A4yAirXLjtVRYo6lCLPLeXroGp0IZMpK38/M7+
 SbB/XWiM8iGRs0xL3s7rPIyup/TC4UOt1jUtGdDNfatq08MCuVm2wvOVtEPc3djQ2zXu
 e1TSI8zDX6dLszNHzLWZ6a/vR6kl7mJPsFRF4BDqsfumVx3KyX9AMdqpojjR0818jKSG
 2d9VK8IcrfoWH6slfaZ6Kui5RLCy1HNWm4ZRiWyhw6/yEn7zgQzgwUi9Lyy5n2Ci+3oj
 wjB/gEjvzXxI1+Z0C27vxV6hiA2ZWYujdIpkOu4FSXjFDeeB23Ztkqx5tAS3EElQ2B73
 GqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522251; x=1796127051;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dFTlc8A4BU9VskvAEZY7T5zU4YZVc7LfjAvhtaZEzOg=;
 b=PUs1G+G8BpR3JL+9cpzSJbs46kIa/1G+kgLIO5+XnaginmTEoMGy1FQG3jC9hn9VKx
 GeGFYSGPWck3h0b6hcydEcB5c0ukGOFj+3j2u+PemOSVspQEBtsn83alSegM8qgYlVxD
 5r4DjohhXCvNOJO4HwDUy7irNSX6R84tRzGs9A+5AFmU+qDtZrHruzCGzLOFaOXTjauJ
 a2nZxdaCIP1Soxmf1YzTqZDzedRcBiquqUG4aMBVDul68/lyEwxgYpTRzRKw0ZJKu7a4
 fKbtMTls8ftaXiX3k9Q8T25lPDw1q7/XTv9sn+iiU+P/gYbafg3h4+eJyRsA88l6amkG
 PA3w==
X-Forwarded-Encrypted: i=1;
 AL+hErEf08fyjLcgk1WLAZL2YDeTGlKf6szjLVj+nfwwtbdvQsGB2L/zYXkqdpXcez/SCS7JrQ3prxPPmAhg@nongnu.org
X-Gm-Message-State: APuU4Z8jduYGOd4Em4Tr/TTGosiDYrJsAk89hr8pXR3R5btxAOTxqVF+
 JCtPtERYIVQ9+vf1AYg+9ARDPOV4TwuBTQMyV0sQqXIu/5l8AxFSacV4ugfS/BxQidIvfBac7Oh
 GzpE1qZzTlei6PYeplNfCIc8SHf92NEF3BzoNRjaiXa8l0IKnZV5QVUhnnA==
X-Gm-Gg: AZFdTZfQiK39Ylf5JiRdoTVzpybK58w/14O7PmlV/PxBngVErU3wHkRnc2Y0IhJnzRC
 SbQ8YRGcS2PLq15Ng5zasLTnhmHH9bWsLiPmi5+VUrbBsCoW6Ppv2lnOedmmhKvNEpZmVkiL6V6
 M1MozPRiwpCr1aqIF8FXQqfbyZCifWAQt5L7vUmv8xrlnkijFUa6SBKhTciST6uliEVIX2aOzeS
 Ine8t141zrZ8u+sDlBbmx4A5TVXaLDySJl54n87BzuuGCuMPnYjE3g32QI4fCsIzD59/7OCfAaL
 fvQYCb2oTsTfVAs6TLdJVF7v96vmyeMpAedS8evK+xq5OSO+mCbSMJtzw1/Oiz5hgOU7rfgHTVA
 SL0mCE/RnRpgdDd5mx+oI6or23UGD0llRPyYOvyUI6E3vqhq0Db1zSx8Koh47Gja8jbiqsPWx1Y
 u+uTtteQqF
X-Received: by 2002:a05:620a:700e:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-949bab5101emr2344467785a.60.1795522251124; 
 Tue, 24 Nov 2026 04:10:51 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:93b:db80:e0cf with SMTP id
 af79cd13be357-949bab5101emr2344461185a.60.1795522250418; 
 Tue, 24 Nov 2026 04:10:50 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3a646fsm1031070685a.22.2026.11.24.04.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 04:10:49 -0800 (PST)
Message-ID: <4dabf588-b0ab-4360-8cc0-19560a6750fb@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:10:46 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/riscv/riscv-iommu: Add unit tests for MSI trap
 handling
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20261116075141.167317-1-fritchleybohrer@gmail.com>
 <20261116075141.167317-4-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261116075141.167317-4-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rxsJSoIp8Ybdy2P9po2PsZaWNovg6M7h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX/s99rBvBDQAR
 vSPdDTVEXPewOFGD1T5HagPMXJHgLfl0a+3WpPWm3I2YYs+xg9M7Eqiy7skisQbdA0ng6llfw8J
 Q0AGiIct3fQhsb00z9VGJrufS3JdH2s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXwtDwHvPuZZwW
 0tkT7QYa3k/IcPP96PJzOsgbruyiLAtn64TM4GZfwrVtEg301al3hA+jxyHe2O646y8IfSc9IIq
 jzMMc5HU1jX2rW/etO2uUy2vSBdC7jwY7nlPJGzRWWHO2tBrdOiySn2q0RadYMFjOCt7fCIfkOH
 FnIMmYvyp8+bmELvGN2YScLZKuY9Zbxt8ip4AfRuK2QheHlRfzbTw8RevNz/CiNh5CTWDHBc5l3
 JOp6PEVTt2a/jh3sL1735YRcwXwlZb8zICSD3y/2RBU6wVK5i7P7ODh1oFXdMieVCrqH1WvRRFp
 pg+NxR1RSbZG5lDu3BsRnwgC6AxDSaQ7U7pFyP8qiO0fnGx0cfOsLRvx3KRkV5awrVz8ctfX1Sh
 /WYpvP0a+P1jZsYRVYdGYig1r6rKg/IGUHI5qQpsWVMxVKi2olcQ65kSpZzLjQnnLbBjKjObGL7
 BKFiCvxjcTsx5cVVwag==
X-Proofpoint-ORIG-GUID: rxsJSoIp8Ybdy2P9po2PsZaWNovg6M7h
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b057ecc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KpfOZQ45AAAA:8 a=iAGwjg5LuKujN0-w2ZEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=KHlNn528OWJD8b-aQ5dU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/2026 4:51 AM, Zephyr Li wrote:
> The recovery-fault and ordinary-DMA fallback paths are difficult to
> exercise deterministically with a qtest that updates page tables between
> the initial translation and the synchronous trap callback.
> 
> Move the private callback into an implementation fragment shared with a
> unit test. Use real QEMU types and replace the callback dependencies
> only in the test translation unit, without exporting a new API or adding
> runtime test hooks.
> 
> Cover rejected attributes, missing contexts, MSI forwarding, recovery
> faults, and 4/8-byte fallback writes with success and error returns.
> Check the addresses, little-endian bytes, transaction attributes,
> context release, single-fault behavior, and disabled replay HPM
> accounting. The PV assertions describe the existing callback policy, not
> complete request-PID validity handling.
> 
> Register the test for system builds and add it to the RISC-V MAINTAINERS
> entry. Use the usual pointer declaration in the moved callback. The
> production behavior is unchanged.
> 
> Use a distinct opaque reference in the context stub so the
> cleanup checks distinguish the returned context from its
> cache-lifetime reference.
> 
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                        |   1 +
>   hw/riscv/riscv-iommu-trap.c.inc    |  69 ++++++++
>   hw/riscv/riscv-iommu.c             |  61 +------
>   tests/unit/meson.build             |   1 +
>   tests/unit/test-riscv-iommu-trap.c | 266 +++++++++++++++++++++++++++++
>   5 files changed, 338 insertions(+), 60 deletions(-)
>   create mode 100644 hw/riscv/riscv-iommu-trap.c.inc
>   create mode 100644 tests/unit/test-riscv-iommu-trap.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d53e104c5..75de9034b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -387,6 +387,7 @@ F: tests/functional/riscv64
>   F: tests/tcg/riscv32/
>   F: tests/tcg/riscv64/
>   F: tests/qtest/iommu-riscv-test.c
> +F: tests/unit/test-riscv-iommu-trap.c
>   
>   RISC-V XThead* extensions
>   M: Christoph Muellner <christoph.muellner@vrull.eu>
> diff --git a/hw/riscv/riscv-iommu-trap.c.inc b/hw/riscv/riscv-iommu-trap.c.inc
> new file mode 100644
> index 0000000000..1e3eaee930
> --- /dev/null
> +++ b/hw/riscv/riscv-iommu-trap.c.inc
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Private RISC-V IOMMU MSI trap callback
> + *
> + * Copyright (C) 2021-2023, Rivos Inc.
> + */
> +
> +/* Shared privately with the deterministic trap callback unit tests. */
> +
> +/*
> + * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
> + * memory region as untranslated address, for additional MSI/MRIF interception
> + * by IOMMU interrupt remapping implementation.
> + * Note: Device emulation code generating an MSI is expected to provide a valid
> + * memory transaction attributes with requested_id set.
> + */
> +static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> +    uint64_t data, unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOMMUState *s = opaque;
> +    RISCVIOMMUContext *ctx;
> +    MemTxResult res;
> +    void *ref;
> +    uint32_t devid = attrs.requester_id;
> +    IOMMUTLBEntry iotlb = {
> +        .iova = addr,
> +        .target_as = s->target_as,
> +        .addr_mask = ~0ULL,
> +        .perm = IOMMU_WO,
> +    };
> +    int cause;
> +
> +    if (attrs.unspecified) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |= s->bus << 8;
> +
> +    ctx = riscv_iommu_ctx(s, devid, attrs.pid, IOMMU_WO, addr, &ref);
> +    if (ctx == NULL) {
> +        res = MEMTX_ACCESS_ERROR;
> +    } else {
> +        /*
> +         * The trap address is the original IOVA. Resolve the MSI GPA
> +         * without consulting or updating the translation cache.
> +         * Exclude this internal replay from the modeled HPM events.
> +         */
> +        cause = riscv_iommu_spa_fetch(s, ctx, &iotlb, false);
> +        if (cause) {
> +            riscv_iommu_report_fault(s, ctx,
> +                RISCV_IOMMU_FQ_TTYPE_UADDR_WR, cause,
> +                !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV),
> +                addr, iotlb.translated_addr);
> +            res = MEMTX_ACCESS_ERROR;
> +        } else if (iotlb.target_as == &s->trap_as) {
> +            res = riscv_iommu_msi_write(s, ctx, addr,
> +                                       iotlb.translated_addr, data,
> +                                       size, attrs);
> +        } else {
> +            /* The mapping may have changed since the original walk. */
> +            data = cpu_to_le64(data);
> +            res = dma_memory_write(iotlb.target_as, iotlb.translated_addr,
> +                                   &data, size, attrs);
> +        }
> +    }
> +    riscv_iommu_ctx_put(s, ref);
> +    return res;
> +}
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5752a4776b..cb98840121 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2599,66 +2599,7 @@ static const MemoryRegionOps riscv_iommu_mmio_ops = {
>       }
>   };
>   
> -/*
> - * Translations matching MSI pattern check are redirected to "riscv-iommu-trap"
> - * memory region as untranslated address, for additional MSI/MRIF interception
> - * by IOMMU interrupt remapping implementation.
> - * Note: Device emulation code generating an MSI is expected to provide a valid
> - * memory transaction attributes with requested_id set.
> - */
> -static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
> -    uint64_t data, unsigned size, MemTxAttrs attrs)
> -{
> -    RISCVIOMMUState* s = (RISCVIOMMUState *)opaque;
> -    RISCVIOMMUContext *ctx;
> -    MemTxResult res;
> -    void *ref;
> -    uint32_t devid = attrs.requester_id;
> -    IOMMUTLBEntry iotlb = {
> -        .iova = addr,
> -        .target_as = s->target_as,
> -        .addr_mask = ~0ULL,
> -        .perm = IOMMU_WO,
> -    };
> -    int cause;
> -
> -    if (attrs.unspecified) {
> -        return MEMTX_ACCESS_ERROR;
> -    }
> -
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |= s->bus << 8;
> -
> -    ctx = riscv_iommu_ctx(s, devid, attrs.pid, IOMMU_WO, addr, &ref);
> -    if (ctx == NULL) {
> -        res = MEMTX_ACCESS_ERROR;
> -    } else {
> -        /*
> -         * The trap address is the original IOVA. Resolve the MSI GPA
> -         * without consulting or updating the translation cache.
> -         * Exclude this internal replay from the modeled HPM events.
> -         */
> -        cause = riscv_iommu_spa_fetch(s, ctx, &iotlb, false);
> -        if (cause) {
> -            riscv_iommu_report_fault(s, ctx,
> -                RISCV_IOMMU_FQ_TTYPE_UADDR_WR, cause,
> -                !!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV),
> -                addr, iotlb.translated_addr);
> -            res = MEMTX_ACCESS_ERROR;
> -        } else if (iotlb.target_as == &s->trap_as) {
> -            res = riscv_iommu_msi_write(s, ctx, addr,
> -                                       iotlb.translated_addr, data,
> -                                       size, attrs);
> -        } else {
> -            /* The mapping may have changed since the original walk. */
> -            data = cpu_to_le64(data);
> -            res = dma_memory_write(iotlb.target_as, iotlb.translated_addr,
> -                                   &data, size, attrs);
> -        }
> -    }
> -    riscv_iommu_ctx_put(s, ref);
> -    return res;
> -}
> +#include "riscv-iommu-trap.c.inc"
>   
>   static MemTxResult riscv_iommu_trap_read(void *opaque, hwaddr addr,
>       uint64_t *data, unsigned size, MemTxAttrs attrs)
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 37b561d4a7..e4c425fbad 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -132,6 +132,7 @@ if have_system
>       'test-iov': [],
>       'test-opts-visitor': [testqapi],
>       'test-xs-node': [qom],
> +    'test-riscv-iommu-trap': [],
>       'test-virtio-dmabuf': [meson.project_source_root() / 'hw/display/virtio-dmabuf.c'],
>       'test-qmp-cmds': [testqapi],
>       'test-xbzrle': [migration],
> diff --git a/tests/unit/test-riscv-iommu-trap.c b/tests/unit/test-riscv-iommu-trap.c
> new file mode 100644
> index 0000000000..d4753c7f31
> --- /dev/null
> +++ b/tests/unit/test-riscv-iommu-trap.c
> @@ -0,0 +1,266 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* Deterministic tests of the private RISC-V IOMMU MSI trap callback. */
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "hw/riscv/riscv-iommu.h"
> +
> +#define TEST_IOVA       0x400040ull
> +#define TEST_GPA        0x28000040ull
> +#define TEST_DATA       0x1122334455667788ull
> +
> +static struct {
> +    RISCVIOMMUState state;
> +    RISCVIOMMUContext ctx;
> +    unsigned ref_cookie;
> +    AddressSpace physical_as;
> +    AddressSpace changed_as;
> +    MemTxAttrs attrs;
> +    bool missing_ctx;
> +    int walk_fault;
> +    AddressSpace *walk_as;
> +    hwaddr walk_addr;
> +    MemTxResult msi_result;
> +    MemTxResult dma_result;
> +    unsigned size;
> +    unsigned ctx_calls;
> +    unsigned put_calls;
> +    unsigned walk_calls;
> +    unsigned msi_calls;
> +    unsigned fault_calls;
> +    unsigned dma_calls;
> +} test;
> +
> +static void assert_attrs(MemTxAttrs attrs)
> +{
> +    g_assert_cmpuint(attrs.requester_id, ==, test.attrs.requester_id);
> +    g_assert_cmpuint(attrs.pid, ==, test.attrs.pid);
> +    g_assert_cmpuint(attrs.secure, ==, test.attrs.secure);
> +    g_assert_cmpuint(attrs.space, ==, test.attrs.space);
> +    g_assert_cmpuint(attrs.user, ==, test.attrs.user);
> +    g_assert_cmpuint(attrs.memory, ==, test.attrs.memory);
> +    g_assert_cmpuint(attrs.debug, ==, test.attrs.debug);
> +    g_assert_cmpuint(attrs.address_type, ==, test.attrs.address_type);
> +    g_assert_cmpuint(attrs.unspecified, ==, test.attrs.unspecified);
> +}
> +
> +static RISCVIOMMUContext *test_ctx(RISCVIOMMUState *s, unsigned devid,
> +                                 unsigned pid, IOMMUAccessFlags perm,
> +                                 uint64_t iova, void **ref)
> +{
> +    g_assert_true(s == &test.state);
> +    g_assert_cmpuint(devid, ==,
> +                     test.attrs.requester_id | (test.state.bus << 8));
> +    g_assert_cmpuint(pid, ==, test.attrs.pid);
> +    g_assert_cmpuint(perm, ==, IOMMU_WO);
> +    g_assert_cmphex(iova, ==, TEST_IOVA);
> +    test.ctx_calls++;
> +    /* Cached contexts return a separate reference for ctx_put(). */
> +    *ref = test.missing_ctx ? NULL : &test.ref_cookie;
> +    return test.missing_ctx ? NULL : &test.ctx;
> +}
> +
> +static void test_ctx_put(RISCVIOMMUState *s, void *ref)
> +{
> +    g_assert_true(s == &test.state);
> +    g_assert_true(ref == (test.missing_ctx ? NULL : &test.ref_cookie));
> +    test.put_calls++;
> +}
> +
> +static int test_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +                          IOMMUTLBEntry *iotlb, bool update_hpm)
> +{
> +    g_assert_true(s == &test.state);
> +    g_assert_true(ctx == &test.ctx);
> +    g_assert_cmphex(iotlb->iova, ==, TEST_IOVA);
> +    g_assert_true(iotlb->target_as == &test.physical_as);
> +    g_assert_cmphex(iotlb->addr_mask, ==, UINT64_MAX);
> +    g_assert_cmpuint(iotlb->perm, ==, IOMMU_WO);
> +    g_assert_false(update_hpm);
> +    test.walk_calls++;
> +    iotlb->target_as = test.walk_as;
> +    iotlb->translated_addr = test.walk_addr;
> +    return test.walk_fault;
> +}
> +
> +static MemTxResult test_msi_write(RISCVIOMMUState *s,
> +                                  RISCVIOMMUContext *ctx, uint64_t iova,
> +                                  uint64_t gpa, uint64_t data, unsigned size,
> +                                  MemTxAttrs attrs)
> +{
> +    g_assert_true(s == &test.state);
> +    g_assert_true(ctx == &test.ctx);
> +    g_assert_cmphex(iova, ==, TEST_IOVA);
> +    g_assert_cmphex(gpa, ==, test.walk_addr);
> +    g_assert_cmphex(iova, !=, gpa);
> +    g_assert_cmphex(data, ==, TEST_DATA);
> +    g_assert_cmpuint(size, ==, test.size);
> +    assert_attrs(attrs);
> +    test.msi_calls++;
> +    return test.msi_result;
> +}
> +
> +static void test_report_fault(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> +                              uint32_t ttype, uint32_t cause, bool pv,
> +                              uint64_t iotval, uint64_t iotval2)
> +{
> +    g_assert_true(s == &test.state);
> +    g_assert_true(ctx == &test.ctx);
> +    g_assert_cmpuint(ttype, ==, RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
> +    g_assert_cmpuint(cause, ==, test.walk_fault);
> +    /* Check the existing callback policy, not the complete PID/DPE model. */
> +    g_assert_cmpuint(pv, ==, !!(test.ctx.tc & RISCV_IOMMU_DC_TC_PDTV));
> +    g_assert_cmphex(iotval, ==, TEST_IOVA);
> +    g_assert_cmphex(iotval2, ==, test.walk_addr);
> +    test.fault_calls++;
> +}
> +
> +static MemTxResult test_dma_write(AddressSpace *as, dma_addr_t addr,
> +                                  const void *buf, dma_addr_t len,
> +                                  MemTxAttrs attrs)
> +{
> +    static const uint8_t expected[] = {
> +        0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11,
> +    };
> +
> +    g_assert_true(as == &test.changed_as);
> +    g_assert_cmphex(addr, ==, test.walk_addr);
> +    g_assert_cmpuint(len, ==, test.size);
> +    g_assert_cmpmem(buf, len, expected, len);
> +    assert_attrs(attrs);
> +    test.dma_calls++;
> +    return test.dma_result;
> +}
> +
> +/* Redirect dependencies only while compiling the private implementation. */
> +#define riscv_iommu_ctx test_ctx
> +#define riscv_iommu_ctx_put test_ctx_put
> +#define riscv_iommu_spa_fetch test_spa_fetch
> +#define riscv_iommu_msi_write test_msi_write
> +#define riscv_iommu_report_fault test_report_fault
> +#define dma_memory_write test_dma_write
> +#include "hw/riscv/riscv-iommu-trap.c.inc"
> +#undef riscv_iommu_ctx
> +#undef riscv_iommu_ctx_put
> +#undef riscv_iommu_spa_fetch
> +#undef riscv_iommu_msi_write
> +#undef riscv_iommu_report_fault
> +#undef dma_memory_write
> +
> +static void reset_test(void)
> +{
> +    memset(&test, 0, sizeof(test));
> +    test.state.target_as = &test.physical_as;
> +    test.state.bus = 0x80;
> +    test.attrs = (MemTxAttrs) {
> +        .requester_id = 0x3456,
> +        .pid = 0x5a,
> +        .secure = true,
> +        .space = 1,
> +        .user = true,
> +        .memory = true,
> +        .debug = true,
> +        .address_type = 1,
> +    };
> +    test.ctx.process_id = test.attrs.pid;
> +    test.walk_as = &test.state.trap_as;
> +    test.walk_addr = TEST_GPA;
> +    test.size = 4;
> +}
> +
> +static MemTxResult trap_write(void)
> +{
> +    return riscv_iommu_trap_write(&test.state, TEST_IOVA, TEST_DATA,
> +                                  test.size, test.attrs);
> +}
> +
> +static void assert_calls(unsigned ctx, unsigned walk, unsigned msi,
> +                         unsigned fault, unsigned dma)
> +{
> +    g_assert_cmpuint(test.ctx_calls, ==, ctx);
> +    g_assert_cmpuint(test.put_calls, ==, ctx);
> +    g_assert_cmpuint(test.walk_calls, ==, walk);
> +    g_assert_cmpuint(test.msi_calls, ==, msi);
> +    g_assert_cmpuint(test.fault_calls, ==, fault);
> +    g_assert_cmpuint(test.dma_calls, ==, dma);
> +}
> +
> +static void test_unspecified(void)
> +{
> +    reset_test();
> +    test.attrs.unspecified = true;
> +    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
> +    assert_calls(0, 0, 0, 0, 0);
> +}
> +
> +static void test_missing_context(void)
> +{
> +    reset_test();
> +    test.missing_ctx = true;
> +    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
> +    assert_calls(1, 0, 0, 0, 0);
> +}
> +
> +static void test_msi_forward(void)
> +{
> +    reset_test();
> +    test.size = 8;
> +    test.msi_result = MEMTX_ERROR;
> +    g_assert_cmpuint(trap_write(), ==, MEMTX_ERROR);
> +    assert_calls(1, 1, 1, 0, 0);
> +}
> +
> +static void test_rewalk_fault(gconstpointer data)
> +{
> +    reset_test();
> +    test.attrs.pid = 0;
> +    test.ctx.process_id = 0;
> +    test.ctx.tc = data ? RISCV_IOMMU_DC_TC_PDTV : 0;
> +    test.walk_fault = RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS;
> +    g_assert_cmpuint(trap_write(), ==, MEMTX_ACCESS_ERROR);
> +    assert_calls(1, 1, 0, 1, 0);
> +}
> +
> +typedef struct FallbackCase {
> +    const char *name;
> +    unsigned size;
> +    MemTxResult result;
> +} FallbackCase;
> +
> +static void test_fallback(gconstpointer data)
> +{
> +    const FallbackCase *cfg = data;
> +
> +    reset_test();
> +    test.size = cfg->size;
> +    test.walk_as = &test.changed_as;
> +    test.walk_addr = 0x90000040;
> +    test.dma_result = cfg->result;
> +    g_assert_cmpuint(trap_write(), ==, cfg->result);
> +    assert_calls(1, 1, 0, 0, 1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    static const FallbackCase fallback_cases[] = {
> +        { "fallback-4-success", 4, MEMTX_OK },
> +        { "fallback-4-error", 4, MEMTX_ERROR },
> +        { "fallback-8-success", 8, MEMTX_OK },
> +        { "fallback-8-error", 8, MEMTX_ERROR },
> +    };
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/riscv-iommu/trap/unspecified", test_unspecified);
> +    g_test_add_func("/riscv-iommu/trap/missing-context", test_missing_context);
> +    g_test_add_func("/riscv-iommu/trap/msi-forward", test_msi_forward);
> +    g_test_add_data_func("/riscv-iommu/trap/rewalk-fault-pdtv-off", NULL,
> +                         test_rewalk_fault);
> +    g_test_add_data_func("/riscv-iommu/trap/rewalk-fault-pdtv-on",
> +                         GUINT_TO_POINTER(1), test_rewalk_fault);
> +    for (unsigned i = 0; i < G_N_ELEMENTS(fallback_cases); i++) {
> +        g_autofree char *path = g_strdup_printf("/riscv-iommu/trap/%s",
> +                                               fallback_cases[i].name);
> +
> +        g_test_add_data_func(path, &fallback_cases[i], test_fallback);
> +    }
> +    return g_test_run();
> +}



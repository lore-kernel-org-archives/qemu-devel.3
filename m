Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B21C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x292C-0002YC-Af; Thu, 03 Sep 2026 11:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x292A-0002Xi-Il
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:07:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2928-0005pl-Nj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:07:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DAPU9035520
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lCQ7Fu0QpMR2Vb5Jj1cuRns2tFe4wkTIesTRq5ja4Hc=; b=j40uzFi8BcmuG0xt
 pV/54hJf8aesGcC4o4sdjFlLu35lgXKVSoNKvDN/AcChEbo4IqL5yXjRRoXfI/1O
 oomV1tjQEsXqGSsa9y0gJJT+MZNNqD3nM85MJHnJLSPGpD+qPZyPXAtIf2q080pK
 x8svPRTYc2msOE9wXQvsGJL4/r3txrGjwioxjJ72DXZ+4gAFhW91U76+MPdyqVVu
 Vsn+PGoDQqEG4ddejdO1TgRtxM2PvTdgo4V+PSIiPxi7W60Qmwkzf3HENctnOM5U
 3qlXFX4cAzvDn6RoDCXDk5mEPG4u5Yop4QldcSg7UWWMgJAwcIaFbi/FwVYSlXB6
 aYZfwQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m1qwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 15:07:15 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97cc09260a3so916272241.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788448035; x=1789052835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lCQ7Fu0QpMR2Vb5Jj1cuRns2tFe4wkTIesTRq5ja4Hc=;
 b=SJBSv5/DuzP0aU5b46IpTtjuUcDZzWDDTpMTlTKqAucAjIfWM2IlY6zIbQ5Vn3ZMpM
 SIGD1ETkItGRFMvL2J+96jV0tiBliVtzKfm+vC7ViH22g8j25pv5vpqb3+Ze3KEwdLHU
 jX3OTIwXRk+DNiCggksVkDpENKN05UAXaQJ6k+ngRF+7uwEPTePrYl2TO22AiewBihO6
 Xh+Els2gCoW15s+WTZSgsyYrAc5q91Uu5c1kNHyhQrh3ZTJ9ngHzga7QNPtFOvKef29z
 5Nt2SYlu4RBOWrBC563CwKBFJYUdsMz4EiT83aviNTXV0VkVHjO0VWv3b8i3PXN6RMOa
 Z0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788448035; x=1789052835;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lCQ7Fu0QpMR2Vb5Jj1cuRns2tFe4wkTIesTRq5ja4Hc=;
 b=FTAkpXXPi0tIyxbhyJpaSgp6RB0TWT0c2coiJ4GoANs++jpzpTj79SewkuxFBMZA17
 kK0iuV9FVHeXSgITqkdScIf71vzza6zQ+ze3svB7GrZZR4hVDw+iA2YS/t/cJsADIDU/
 tTtuYcjA9njit3RAzFXg8iY5AtIqFEZz0xvEBfTJSxu0urpNOOi2DGZGSH7jEyqmplQt
 krHLeh34giwmYeDr03mHz6HPtTcQvZzO589exIepY1CdrXnT4wSde8qEOmX5FGvBuh1L
 Naih25VQ5ocxiIaSfnpM+Jg3zZ+0ITeJEj/4YfsUddt4F+Okk9k9bejmJ1ybsxIq9LvQ
 LKtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4rgzTPwwoIWnTJpIs9t7BniirQ8v29OstMMejezF3VlkZMGb/dAob0dsAl2jluJkHOcevyh/YA7b9@nongnu.org
X-Gm-Message-State: AFuF++nCU9rhBccXvUQpTQuSZrfX6/JIkMTOTjtH1xoNS6sU5/3s1TEA
 zxQdqCgZ5Tl1wRIp2Kfp2AwhvByHM5kcLgr3jzruPsaDVpvj6Owu+xJgMMKYQZWrhxNTwXTpEj8
 hBs6+ooHdIcrheK8DQTc8nDNsUCCQDN24WI4gppboPDR4iFXr/LZpmMY3Fw==
X-Gm-Gg: AYBFou2TTn3WnwBMtFC1VIq6TQGAKc40aCl3mqI3DyUH0KmM361MhtymHjfkcT9+YU+
 xa9UZmkG0acUwJ2Vi+EUh9sjqt0ZM2znAXaAj5AQJ3JIKdQYnOGiCk79OJPO7tiu783Rfm0W+Ao
 iWJRm1bWpDBIT44xLwIvrfQpCgpVC9v9Kl6Ozmp3H6cvXbu+ebG9d0+zEyy32cIXz93QgVVjYs+
 MfQCefl3deW1u0l95cN7j4e4kXRGHSF6WdJrCZC50sSAhISuY4FpgyxzAsdikUiT7qTzWZQtusB
 5v71Yf9JutsXZdQ8A2XjMFvzTkevVtTZyGc+mYndY0aMRCMJTWSW3yYv+w4Eg3T2FzY812XJLi3
 HtfVTtieciXbpXadc9YF2Ns34tHZs6J9NVA==
X-Received: by 2002:a05:6102:1676:b0:785:6719:abb1 with SMTP id
 ada2fe7eead31-78a2ef7b044mr1369612137.11.1788448034822; 
 Thu, 03 Sep 2026 08:07:14 -0700 (PDT)
X-Received: by 2002:a05:6102:1676:b0:785:6719:abb1 with SMTP id
 ada2fe7eead31-78a2ef7b044mr1369480137.11.1788448030136; 
 Thu, 03 Sep 2026 08:07:10 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm89916045e9.3.2026.09.03.08.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 08:07:08 -0700 (PDT)
Message-ID: <fcdbdc94-49d3-4fe5-a91e-95a41038c382@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 17:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] hw/sd: Add Synopsys DesignWare MCI controller
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-5-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903112532.3276678-5-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gih6tth2_XIbgqrt0FzsMdFhrukeImmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEzMiBTYWx0ZWRfX5EOUvs4TzGxb
 vO5TTcRMPC7eJ9psiX3uTsLaQ0aQR3074Z5xltqbM3JSrDoUOwQQ5qcjSXVsy6010QTWsK8TVg6
 QIpc3YhyttfRs/nlFBA4qiiKxkD2wX0l6F04mYTj1cl3ycLjJcsPx/+W4xg61MZfqN1xb0T9Iah
 AxPBCmxeXx8gKAfMtRbUyTC2toz9UNhIo7KzbM6jxW6zi7fu/3FunRFq8Fv4oInuArF1+BzaT2O
 m451CutNyKFg24FdEZpAjDqAgbUJqoigPSoiP/qj8yN/8xBEfAledqDrngGRpfNd7ADC/oaiUyn
 nShybV1+swxo7U1ASXoxkdBNnd8TD3Ij7L2gjRPeGktCjoZiZSUzpx9Vp6zHvk3PE6ozM9QcdB/
 9qDnl6B6mPIFPWS/zA+J0YAV3d1mdTPfrzBsp4eCfDrhVBhJmTxO9Lmgm9sEWuvXNwXLaGwOg3p
 5T6nH8kequbAnK0XS9A==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a998d24 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=FRSEYCzRAAAA:8 a=aiGftIEPC_pO9Qtb4UsA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEzMiBTYWx0ZWRfX53k2+iCsuO2k
 O8B3tQSuSjbjwo8IJHlPODflb2vwdtyvlMwd/mvgRmFllkYVdjP7HEYKLsOqUiv//vv1pCnPvQJ
 hL4t+WHEgQr14lDGsKPOTAHSO1aIdc8=
X-Proofpoint-ORIG-GUID: gih6tth2_XIbgqrt0FzsMdFhrukeImmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030132
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

Hi Bin,

On 3/9/26 13:24, Bin Meng wrote:
> The Synopsys DesignWare Mobile Storage Host predates SDHCI and uses
> a distinct MCI programming interface. It is integrated by Samsung
> Exynos, Rockchip, HiSilicon, and Altera/Intel SoCFPGA platforms,
> among others.
> 
> Add a reusable controller model based on the DesignWare Mobile Storage
> Host 2.40a databook. Cover command and response handling, PIO FIFO
> aliases, reset and interrupt semantics, card state, and the standard
> 32-bit internal descriptor DMA engine. Also support the later 64-bit
> descriptor layout used by vendor variants.
> 
> Expose class hooks and immutable configuration fields so vendor
> extensions can reuse the common implementation.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   MAINTAINERS            |    2 +
>   hw/sd/Kconfig          |    5 +
>   hw/sd/dw_mci.c         | 1382 ++++++++++++++++++++++++++++++++++++++++
>   hw/sd/meson.build      |    1 +
>   include/hw/sd/dw_mci.h |   74 +++
>   5 files changed, 1464 insertions(+)
>   create mode 100644 hw/sd/dw_mci.c
>   create mode 100644 include/hw/sd/dw_mci.h
Please enable scripts/git.orderfile to ease review.


> +REG32(ENABLE_SHIFT, 0x110)


> +static const VMStateDescription dw_mci_vmsd = {
> +    .name = TYPE_DW_MCI,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .post_load = dw_mci_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, DwMciState, DW_MCI_REG_COUNT),
> +        VMSTATE_UINT8_ARRAY(fifo, DwMciState, DW_MCI_FIFO_MAX_BYTES),
> +        VMSTATE_UINT32(fifo_head, DwMciState),
> +        VMSTATE_UINT32(fifo_len, DwMciState),
> +        VMSTATE_UINT32(transfer_remaining, DwMciState),
> +        VMSTATE_UINT64(idmac_desc_addr, DwMciState),
> +        VMSTATE_BOOL(transfer_active, DwMciState),
> +        VMSTATE_BOOL(transfer_write, DwMciState),
> +        VMSTATE_BOOL(transfer_send_stop, DwMciState),
> +        VMSTATE_BOOL(idmac_suspended, DwMciState),
> +        VMSTATE_BOOL(idmac_fatal, DwMciState),
> +        VMSTATE_BOOL(card_inserted, DwMciState),
> +        VMSTATE_BOOL(card_readonly, DwMciState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};


> +#define DW_MCI_MMIO_SIZE      0x1000
> +#define DW_MCI_REG_COUNT      (DW_MCI_MMIO_SIZE / sizeof(uint32_t))

At a glance, less than 70 registers are addressed but you
map and allocate more than 1000, which end being migrated.

Maybe we can start with fewer (96?) registers, still mapping
the whole 4K region?

> +#define DW_MCI_FIFO_MAX_WORDS 2048
> +#define DW_MCI_FIFO_MAX_BYTES (DW_MCI_FIFO_MAX_WORDS * sizeof(uint32_t))
> +
> +struct DwMciState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    SDBus sdbus;
> +    qemu_irq irq;
> +
> +    uint32_t regs[DW_MCI_REG_COUNT];
> +    RegisterInfo regs_info[DW_MCI_REG_COUNT];
> +
> +    uint8_t fifo[DW_MCI_FIFO_MAX_BYTES];
> +    uint32_t fifo_head;
> +    uint32_t fifo_len;
> +    uint32_t transfer_remaining;
> +    uint64_t idmac_desc_addr;
> +    bool transfer_active;
> +    bool transfer_write;
> +    bool transfer_send_stop;
> +    bool idmac_suspended;
> +    bool idmac_fatal;
> +    bool card_inserted;
> +    bool card_readonly;
> +
> +    uint32_t verid;
> +    uint32_t hcon;
> +    uint32_t data_offset;
> +    uint32_t fifo_depth;
> +};


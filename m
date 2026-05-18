Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922ECCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwxc-0000uJ-Qc; Mon, 18 May 2026 08:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxa-0000tl-3c
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wOwxY-00067t-Hb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:20:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IBHRL32482391
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zzI5dIVTDPi0q3mFhwbGl1F0WzdSwZ7vh9U9z7Th+hs=; b=g0ge619cFTnv6+2Q
 oPT5+p1eM9CFA0aLK5FNGSL8c8cMXN88Gy9Ma1vkWubmKeRHEDHlHYYdIhj1LCtb
 r+elM9PXAn96kjuj/RGrAphqeFfBNsSHM5WlQvFdPjt9gF9P2BjW/f+0XGX6p0d1
 vfHMtzXadd3bZm2MAzCb1dsHuzzC3LRZEmgQJaNLl9xcPOGnZAI4BOWwvONJc0c1
 qcBk/zkb6e/MfCvIreeLTNfGon7ZqCpjXyD7k1XynSw5TBGXcHXL6MOEmtMaOlAb
 R3Lu4AlOKoE04uNxrhm1hkm76Ad4YfKWsNtu8L4i3J/oOjnz0GoXFcG3uzavLWa2
 WsZGVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvg7gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:20:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90ccab62c33so223050885a.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779106835; x=1779711635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zzI5dIVTDPi0q3mFhwbGl1F0WzdSwZ7vh9U9z7Th+hs=;
 b=BdLITvdN9p9P9uTMSS7qXz1AYJDK9LIF68+9KsOpAIxf2it0yMJkIMwlwxoWV/hPFE
 hjK5E8/N3Mo4/Skm0md4OVGp2EH5EPV4eKHQjyZA2IwYlGz/93RhLVtK6g+zf1PeXIYd
 JdNCiye/UUqvS/BsiWikReCzFpAherSnJIJrPUzVUI0Q0hgcL7lT5QcnCig2gvGeVzm6
 aS7jGnF3brZXfaKQQANTsiEBzRCthXY6JTWEWCei0wSL/xVi+wpo8P8+AsffzMJ07BE3
 Fa0WFqhCG5socDIC1dWUmNSRooxqVv3EVDcVaDaoq23pX+d+aMaQ+O+VubEGKDHCKcOf
 iffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779106835; x=1779711635;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zzI5dIVTDPi0q3mFhwbGl1F0WzdSwZ7vh9U9z7Th+hs=;
 b=R5ld+3D2SDagkz1N1Ysw0h4YCJwe13ylP0YXY6hD+yIDC9qVExfy04PDMcpUPhsPo9
 45lf/vE525nkXpGTPuHLBa3l4ajHoDfHD2+mmplBhwCuxmfM22Jnc9JuDghEtdqB9mds
 biyUJocAx3X1JGoQtHW324l0QKXqiEMyq1hol1yFjF1R3ObieCm6wy7OtxORVg8ix5gg
 kYPvQXGlsE78DIOPLkU+0Luzj840TCp9qHNcV6ABW4AyYyllEzJ8SRPZ+ZlhZZstp+VS
 I1nN4LFrnLPVfZj3NrMLdwbUHizEhmbowkqCfok/Nq6vvILEuCFHDEMuWBveQj94ht3N
 ewyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81F9+9NIlaKmhvrdeywtWLCz2mqI3xaD/QxnokVOyc7P48XL8SKTkAg/fY6TmMYBb7IBAj88XxCxPt@nongnu.org
X-Gm-Message-State: AOJu0Yymxqn89tVmu7xhaFdiRs6FtbfZPyCOXSvoo9hBxypifCHIRbGB
 45k/LupARoPH49FkN3tPTbjkgtInkue9MTYjkGgsSlhX7x9bBwN0GEo/gCTP7Cex8F4OEJwP6Zd
 /ItMBHg56H7HnHkvrX1aqKXOE+9Vjmmyb3ZZkrmnWP3nxK2sSm4RDwdg0Hw==
X-Gm-Gg: Acq92OEmqTVhb5y9wOUCqdfKOmuwbmKJ8TpHU887+Bls74zxPEyGkIH9BsKj7O9bUSy
 wkIaYeDRs9YfXzr8Lim18ZYSF5C1V6nMaI+Ew/WNHgwxzGABCh3N/xBIgzBjZa32gMRte+nfNG+
 ri3QW+AmSKC+YJYoyE8uxKeS0oU78kItwit3E6kYKTn+QccF/MoXAamvJ3EY3R3Dh0pHgv8Tx2r
 UJ+Vjg+wpNRRDOB/SzfVCDaZVucnX2Dm1Z6TJijvNFYj4K+/C0+YzkacS8r6+BTuft4G4umxTe4
 16luMLUUeozEJF/6tp1YJnYgG99/S6MqrHvOO4zG43V4/ndNHS2MvW3FomfA1HSTAhAQ1q2wdXL
 y58tHcsRn/8TOwzuJkxi4abUEv/THG9ZQftRXVFiG8XmWQtkrllvXa1FdRk0=
X-Received: by 2002:a05:620a:4542:b0:8f0:f1a5:680c with SMTP id
 af79cd13be357-911cef062f4mr2296773985a.29.1779106834880; 
 Mon, 18 May 2026 05:20:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:8f0:f1a5:680c with SMTP id
 af79cd13be357-911cef062f4mr2296769485a.29.1779106834376; 
 Mon, 18 May 2026 05:20:34 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bae27359sm1542218485a.17.2026.05.18.05.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:20:33 -0700 (PDT)
Message-ID: <c96dc256-9d89-4c06-b908-5419a6568ee0@oss.qualcomm.com>
Date: Mon, 18 May 2026 09:20:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/intc: riscv_imsic: Add reset API to IMSIC
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260428160103.3551125-1-jim.shu@sifive.com>
 <20260428160103.3551125-4-jim.shu@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428160103.3551125-4-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExOSBTYWx0ZWRfXzyioB9zAZzDI
 3kM9vcByeuF59I9+IoYtdx2aVqFNeAJkosrVt3hqRvN4RRlnVUnmQuXuktKKIDYR8a3NejUlukk
 aGAH51m/erYo+9tfAzGClfDeXG1awgC0uKf0EiPVOst/825z4xP0cwksya2oWZRL/uUEr9uFKgy
 2PkBbLVDmRQpEEQ5jJT1Ca1Q/+0qkln77dQS0CWEQ/U4HjrpGY3j37hLZ7I4LixfVfJag714PbB
 5RbkGp1If0TWOM4O4jxj+Flen8JHVxoksAtlaEf0/Jyu7fJVyiB6926pcmxgEeKZQBkJO7pvguw
 FxEJTIGL6xGw+T/ygrFgQbLNbVz2q2O5A7DaXvEsYiDVuJKESf5XIMK922V+8rfYdNjHDMQAHOE
 qGqhMaYOL3O1uNPFxjoBs2gkVMxPsQXjIGoyqCIcBWSrfbeSZNBs9iOOGOGL7Y1GTjLMv2sKSHa
 yjxrovS2/OjD0NQ39sA==
X-Proofpoint-GUID: 6pwBS1N7bcar5h9-0GSb0_f5wdqYMzJp
X-Proofpoint-ORIG-GUID: 6pwBS1N7bcar5h9-0GSb0_f5wdqYMzJp
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b0413 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=Ylk5joYACZCeeTKyrs8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/28/2026 1:01 PM, Jim Shu wrote:
> Clearing IMSIC registers and qemu_irq in the reset function
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/intc/riscv_imsic.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 7c9a0120335..ac59496c22b 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -342,6 +342,23 @@ static const MemoryRegionOps riscv_imsic_ops = {
>       }
>   };
>   
> +static void riscv_imsic_reset_enter(Object *obj, ResetType type)
> +{
> +    RISCVIMSICState *imsic = RISCV_IMSIC(obj);
> +    int i;
> +
> +    memset(imsic->eidelivery, 0, sizeof(uint32_t) * imsic->num_pages);
> +    memset(imsic->eithreshold, 0, sizeof(uint32_t) * imsic->num_pages);
> +
> +    for (i = 0; i < imsic->num_eistate; i++) {
> +        imsic->eistate[i] &= ~IMSIC_EISTATE_ENABLED;
> +    }
> +
> +    for (i = 0; i < imsic->num_pages; i++) {
> +        qemu_irq_lower(imsic->external_irqs[i]);
> +    }
> +}
> +
>   static void riscv_imsic_realize(DeviceState *dev, Error **errp)
>   {
>       RISCVIMSICState *imsic = RISCV_IMSIC(dev);
> @@ -425,9 +442,11 @@ static const VMStateDescription vmstate_riscv_imsic = {
>   static void riscv_imsic_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       device_class_set_props(dc, riscv_imsic_properties);
>       dc->realize = riscv_imsic_realize;
> +    rc->phases.enter = riscv_imsic_reset_enter;
>       dc->vmsd = &vmstate_riscv_imsic;
>   }
>   



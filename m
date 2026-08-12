Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51BAC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuDTd-0001gw-3i; Wed, 12 Aug 2026 14:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDTc-0001gf-4H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:14:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDTR-0006wY-SQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:14:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CI8QAf702721
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ACwUYQld6yyldzeZsxEogonMM6Lxt3bEZrsLDZx3FTM=; b=iN+JOv79Vv/LTdyF
 8au+3Ua2KWDL60kmexV3LTwS+MnVG2hRyfLDYlbXsnHt0A1QaN5JNUKFI+sDWTA1
 bGCaWe1G8mwW8nDJTBfwQd9odWYc2Xuah48Y3VYzDSGew8huHreheIFKcYZFfRsh
 KRuCLqJZlae14RrmnnfP5VnlxWeJJnkKUTD/G5pFWPZ8GQa+Oyoy3aYvDvYuJ+3q
 zia3/l/ufpgFReb5beFvDk63CB6+NDJx04ikylq9eWJRiGmzugnU68xDKYWnlYRv
 fpkj5nLzwH1nvpJYemC1xjLbkWZkkXdE4A5v7kkwtee3MWAFLMAW/iIbPieq8Nwl
 Hh+54w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucjere-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso138482685a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786558482; x=1787163282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ACwUYQld6yyldzeZsxEogonMM6Lxt3bEZrsLDZx3FTM=;
 b=XaKdmQod5wWTuT7wnYnrcGDHLqAOXZjegEeEt5MhVX8M/nLzIqqTdP8rdhsOzQN+V1
 BmX24OMlejHb02jyp0eIxO9vE/pBvtPp17uFxsEmvcNgeIKS6bHHD2uk/lAjbXvLTUuq
 7eRGnPOPla1LFHUhf4J/oevRzjJv9PEggzE2+qCVmhS4nD1LgF7UmwqeaBq6ewdlGx0v
 zNkVh6p+BZBvicQeQTNL4QL16Syfbk2VIJs8Apln0mONJ5QYRNgSnDWNRIrA7NV3OcyO
 bi2NRHxBsW/8fAK+d6w7r44KNkOfaTastHG8a575s3GbBeATFs5ckq0Mx873mw2G8UkK
 v7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786558482; x=1787163282;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACwUYQld6yyldzeZsxEogonMM6Lxt3bEZrsLDZx3FTM=;
 b=KHUiweJgd+0NsEsBG7jIfjEawcjYNEIPQQbyw1OGB7xjI1uHcqu2jFjPkdRmQrWwsl
 JUke/MEDVGPRdMcdr0CF64Gmb76DD41SEuRhg/FzRhR3B5MjOYhxAMV+z3/gbYOoW7Qr
 IXzoTfA7i7QeLwzl3AFSzR40jMYejACuXsP2v7wwV0CwjBOaIHdNfy1Q8bOSdId4hFSE
 RMrpUrnsPK41P8sUJ8GHe5mqlaF27BAKlWJxgR3v1WLP70c+Xsvqno6/alWAf9tNQcEp
 +Z7O7vI2ZOgLsj8iMDHsBvt7sbqgk/9h1k9vCUJYrt7G84cFRK+9NhwL8vQgqRZ2YbkS
 UrnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov/EsgZzmeu+30HirxoklvWz6++PP3TB4hjsuupgxd2Vur/xv72VvrBOdVtulvJSU1VoM89fXJ/QTD@nongnu.org
X-Gm-Message-State: AOJu0Yzs6+vhCBpt8a/ZSlHrTE5xvSx+8dYVvcA/C3ETu9W1cXuFxZqI
 I39rG0G958+uPTO+IQ1QAiRYe5U6sBMPG1zGWYK2oJi1DSAaS5DmBdj4maVAICMVRIvST1O7p4U
 eS+5DdSOz44j66WQpLtfJS66SK2k6pLRBjoIXlrN95/Q4fhBRWgjpLNLQVA==
X-Gm-Gg: AR+sD11nMkJZ1Ml+3HJvvzrTCUvWBlPPL+r6RYc3stVqggMwd2bwQLH5vDAhgstp8vi
 WdfMM3hYpz2y7fgXpPaWykOs+ix/hEDfVkNA6tbrQuidD61IpwhXr9RtCsDXl+oiNkXCb7lS1Fa
 /22J36nrX3ErbUMH3HEJealEdy+hn/R+puNPZZgPttUO54DuKRASjJJA93XvxD022F+OJlrdpA8
 AzX23Ij2X1lAJryCS+70nX5s2bM4fUGGf7JHq3ESxm7KmZxM6v2tmPhHF/hznRUd2FPDAA+nEIk
 utm0C+J0lRxW9y0nDGwAFj3xQLOn9ns7nmoL/pNEciGnPFx4QdYKpYmAY9FRcyCrtp2hSX9uEBS
 NDVuvekxJ+QhmRBSmyxMeRhomjoCqMikEjt7R
X-Received: by 2002:a05:620a:29d0:b0:92e:9cc7:fa46 with SMTP id
 af79cd13be357-936bf94d90fmr8517185a.21.1786558481826; 
 Wed, 12 Aug 2026 11:14:41 -0700 (PDT)
X-Received: by 2002:a05:620a:29d0:b0:92e:9cc7:fa46 with SMTP id
 af79cd13be357-936bf94d90fmr8511185a.21.1786558481355; 
 Wed, 12 Aug 2026 11:14:41 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5dd6a55sm183284685a.7.2026.08.12.11.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 11:14:40 -0700 (PDT)
Message-ID: <92d585b3-7eb8-4822-a89b-b5fea31aed79@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:14:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-4-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260812174417.2468981-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uTHU_S_b8r2_bLygf6ZAJ2sJPCWgMdso
X-Proofpoint-ORIG-GUID: uTHU_S_b8r2_bLygf6ZAJ2sJPCWgMdso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX8Nk07igfEiiE
 erojb2k+4sII8zbsRC3sKnHKIWSr9an0PZV3Ud2YSMZ21uCmoyAXgk8QHuYiKavYtYtXYF0zVnY
 uCZx/sVPtZL3/+OaueDHp2zU0VX4sMRRRwspEZlSo4bHBQg3/MvaXHNDoYUn75JS0YCT/7BztVe
 0efd4LM+l+HaVmtDCAnq+osoiPonjfSBHKaI8tDdzr4H6uXWMUBUlR2whdFdWbCyW/ek1x5GkYR
 /SuZDNfqbD7A0gnnWJj8lplN2LphQsBriXmZyJJpzeojC0F3nZwl6PnlIR1IosMXrSAbhFbDSgq
 P7AuvGv1r9I+FwuVwPkuzsNuqxtHpG/QmrylQkj7o3tTNDVJyRV7BEEH0ZzVPGbW3CwKOmM7fpj
 AnthKAe+21F9e+MxSq3megbkksi2cw2I/HLF1BpXAEGmtDyQ2ctqvMV3uCGFkz6xtRs0ybiXsAQ
 jRrC2y1mxWGIhf1PERw==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7cb812 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=k1rBJv9NlU-BUnd4o2wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX4j9gQIbzEdJz
 aPYnR4MQS+FyIVe3TqgZu19K1xWn+kvH63ha8K1gOcITZ+bfU3r0lZcdY1s7KqEM0W+I9z/pyq7
 m6fzaQESHZ3K0h1RtExAFdxaOWVmrlY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120145
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



On 8/12/2026 2:44 PM, Max Chou wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add SiFive custom int8 matmul extension implied rules to enable the
> implied extensions of SiFive custom int8 matmul extension recursively.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fffb92ff110..265a92a8b7f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2811,6 +2811,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
> @@ -2862,6 +2880,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &SMCTR_IMPLIED,
>       &SSCTR_IMPLIED,
>       &SSSTATEEN_IMPLIED,
> +    &XSFVQMACCDOD_IMPLIED,
> +    &XSFVQMACCQOQ_IMPLIED,
>       NULL
>   };
>   



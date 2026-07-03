Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5FEC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa4j-0000h2-9v; Fri, 03 Jul 2026 05:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa4h-0000gP-Aq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:20:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa4e-0004nL-LJ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:20:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rZ8b3136094
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lTRce2leYMpaLM7LPXBL6Q6414ZzO7xEoxmkUcr0Zr8=; b=JkPKv7Zq+TA/1ud1
 fhrR3Lt0ZEapPRS8zTnmYyWtL6GoZHDWDsj2CiaPYdUk2PR8/m2bckUCoMQRSrRi
 uVw/njIIAkF9XN/4U1LwcNHcoW6iwm/7g6qhbkjeMMq3cRoQrHXhiZmVodWOcKMN
 /S/BDJcgp6D0qr095et4FBYaIC4cXA9qfnCH6UtpE2VOypNyXzcJpEs0aBqXJV0H
 fjlanHfOTKL0Fr1f6WV56L7C9vFBfdxFnUTFq9qUgvPPm7VbjBvj/jFsX4LA5SLL
 qS34feFx1cJKZ9smXipUqIPWiEbDA9FpDt37V26rrLhcD4AGTeca8nVxp7/Ccccj
 GsfRIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b59kkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:20:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e663c29f2so42023785a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783070437; x=1783675237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTRce2leYMpaLM7LPXBL6Q6414ZzO7xEoxmkUcr0Zr8=;
 b=OOnGRY94nbCrbDLiySP2zxfiSylVEWEEnNimY/rVzaLPgz2avIzZ1vcqh6U2vydHCm
 gCiFbfkB/pRZAMlExuiv6rbnFySkzV59wXqN9AYpj7lbjGfMKxM9vwdCyyufOOBwAwZO
 3HESgulo3/nLuFMNFPoMepKZnvfsnl6lx8m3P/nflvwvS6jRWCBDAzJ/NuueXTQIKh/u
 w6yZSDLJHjoMVk2tKf3K5T4EgS/myw3uTz3chIY+9JvU+qmbceVgwRhPZHLJb8GOrd19
 +9DASQLZ1Kcs+XHPTnlp8wZGVcFbMWk1CFgEq1lTcUvYN4l/+OzSepk+9Hw7HPi3Yc8+
 ghNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070437; x=1783675237;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTRce2leYMpaLM7LPXBL6Q6414ZzO7xEoxmkUcr0Zr8=;
 b=CWzP/yWBzcTdUsWhiDoCVz5vshW4LHIJo2GrVNAw81Y/c6sG9GwwAiTFvZTUoxmJ26
 m4FNFVxhCiHdxOjQfyxyxUZt8BhGVzjDEHXPoNPWtEL5xKh6Ma+m1EQesZheD8QzdGcn
 iUi5fAFiExxJQ9dScwNBe2k1nzu6QFetqFhTz4YqMoW/WXI/K0lHnyl7yqUz+5B/vl0s
 kLqkplFrlALjrl5/Ji8qQKrPCKGaGeuZZ0KoibzdZ2CKC0fu/rzfoZbeBHEnj9jxoeAU
 l7BIe9HGcbLiLWSMzwRvvfvyZbIIc9k9frRL1T6h8L0WRM0OphC8Y6F+NlaTenR7FWJN
 Djdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N6OA+zcjU4Q9LgLEebE/xJvm3MDg1ZmE0zrfMkfnCCGI6Gf5AiW+lHsAAVdKQ1IR0TUeg2E5h56EU@nongnu.org
X-Gm-Message-State: AOJu0Yxzzl9b+8YZ8TFnTPWu57Dox16PXNbJHksffiWpCPTF4rvEbSL/
 fNDxTb8MM9F1ulcbMnTZDhOZmDa1gJtXpiu1CZoepxGCU2CNN9xhJFsu6U+WM/x98mY76/bs8rD
 D4yPCPkaki+29qFG0ReQvox8efijOB2ULgNJkfA7ey4GVV1pLgRWOvUrgUw==
X-Gm-Gg: AfdE7cn8ftOVm4flQWQPPq50jF1ThRp1jZvQNlGjUC+iAbi60HsuGMWQSvIuqMnjZYj
 YbfMbK+FXjynMpU93UlklR+qOIcmIGhZ/4RBxrBuX/Yd3wnsAyxrzi3aJeCTAyDW7F3+gcTr+sF
 yhVfksnEVCIVfz94RLqXXcfqUYJqUdhT04oSA2+meOhWNNRx9Pgcuhcr5plF5Umlzuorqdw42hD
 BSZTjadMd62EGHjkLcPFHF0LXwNGT1XwDKxQ5fEFBZm8FT/2PT2eKSyKSgvKMy9/IXOgs+Ulf9/
 1KIMl2Qq81nCd8QMc9kWvPEw91we6KkiALgHSLL+aGKQW/g6XO9v4PS3MSY4rCuUcDUdlPBFWCO
 3GNm+1sB2+PlyGWwBjOjvIqb/ksThEjRmYJ86qUS1FaEM9IhI2A5GYjFlX296LQ==
X-Received: by 2002:a05:620a:2b94:b0:92e:65d0:1cc4 with SMTP id
 af79cd13be357-92e8b543ba1mr401425585a.30.1783070437348; 
 Fri, 03 Jul 2026 02:20:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2b94:b0:92e:65d0:1cc4 with SMTP id
 af79cd13be357-92e8b543ba1mr401422685a.30.1783070436850; 
 Fri, 03 Jul 2026 02:20:36 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-698acf25f4dsm2091281a12.8.2026.07.03.02.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:20:36 -0700 (PDT)
Message-ID: <dc90bd46-3740-48c0-b484-0ec2bf322923@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/arm/smmuv3: Fix off-by-one bug in alignment
 strtab mask
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 berrange@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com,
 nathanc@nvidia.com
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701091209.2860306-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX89twhni6mddm
 9medbCsWMb/lfQ1IFr+bjfMqE/oNNTzrRLKdoh63uf9G1/Mo7vIbVg4ftJHlWlyOM2znZXm4lfi
 U0KSPevvOAgCPmxGbk7vpos43Dt6K9E=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a477ee6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=Kcw0qKp_e-QNtmgwFuYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 7yp9ZpUaTdtmof5LwDKWJb0j6kygrYf5
X-Proofpoint-GUID: 7yp9ZpUaTdtmof5LwDKWJb0j6kygrYf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX0gF/+Y+D/rBZ
 zFn49F9N0CRSuOkgbs08DHTvq+nlDkVrU3WJBcwBNIIHf7AqkgsW093D2PsU/lfixX9tC7pzmf/
 l7T5zulKQumvk3rb6wgGcHUTWg/iWy8voCvnsmzD8w3zHqfgGtbLhs+YHZmcsJaJD3jWFAu1k8z
 3HIES2yDgAmK5rBu3Zw2FpcGXrk1mOXLzgWXYWZH2RytTn1+7UFitNUYsdCdDmubyuFwPfiF4qz
 jLlGrFukv2og6uLYOEh1Jtli6j4R+n6cRFBkhl6+74c8fcGcd5JsIFbxKpCm2s1EByuqXIzKiau
 TvEgs81Y+sbYFFerZoTEmtKXORrpZ+i9t4Rdy/QUVBhCLbtTThxuEq3N7iF87TWMJk382PpA6cF
 SSUuUDwDnbvK99N/zGp8fCLuGkLkIlVhsvmRuxjgMDnkP5hDwR6r3N7D2Efr+KP2hjWqWgIE73X
 eQ9a2dTJtumSh29ABlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030088
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

Hi Eric,

On 1/7/26 11:11, Eric Auger wrote:
> The stream table base address needs to be aligned to its size.
> 
> With FMT == 0, the spec says the linear stream table base address
> musst have ADDR[LOG2SIZE + 5:0] = 0. STE are 64B
> 
> With FMT == 1, ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] = 0.
> L1 descriptors are 8B.
> 
> MAKE_64BIT_MASK() second argument is a size and not a shift, so
> there is an off-by-one computation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/smmuv3.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5e5a6a960c9..38aba9c0af9 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -664,7 +664,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>   {
>       dma_addr_t addr, strtab_base;
>       uint32_t log2size;
> -    int strtab_size_shift;
> +    int strtab_size;
>       int ret;
>   
>       trace_smmuv3_find_ste(sid, s->features, s->sid_split);
> @@ -685,9 +685,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>            * Align strtab base address to table size. For this purpose, assume it
>            * is not bounded by SMMU_IDR1_SIDSIZE.
>            */
> -        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
> +        strtab_size = MAX(6, (int)log2size - s->sid_split + 3);
>           strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> -                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
> +                      ~MAKE_64BIT_MASK(0, strtab_size);
>           l1_ste_offset = sid >> s->sid_split;
>           l2_ste_offset = sid & ((1 << s->sid_split) - 1);
>           l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
> @@ -729,9 +729,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>           }
>           addr = l2ptr + l2_ste_offset * sizeof(*ste);
>       } else {
> -        strtab_size_shift = log2size + 5;
> +        strtab_size = log2size + 6;
>           strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
> -                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
> +                      ~MAKE_64BIT_MASK(0, strtab_size);
>           addr = strtab_base + sid * sizeof(*ste);
>       }
>   

Maybe in a preliminary patch extract this magic '5' value to a
self-describing #definition?


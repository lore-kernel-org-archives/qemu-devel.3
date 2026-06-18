Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CA7CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDrR-0006Ym-BB; Thu, 18 Jun 2026 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDrP-0006YV-Be
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:36:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDrM-0008Ey-NF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:36:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IDrN951453079
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oiIzWgo2ACmGpLKfLueCD8cX1zsKt1grMXbORVio9w8=; b=cSDIWSMMm9NM5V6S
 YcMn3SBWIViGsddcpHntgXFrJcmvPqjo5CX1hI5HcPOMz7fdZp7H79T+kv8C7cnB
 8gTMLpkj2ybepvO9Sgb2QUcGF/lmjJH4o9SrvR52aVJn32PxXPFGh5d/1YQtxcDM
 8F9pP4xXHdYMYH7TPFMWEeRmFGBpjS1pzVgdFqFjtT7VKd2n1ChzdJqt63jkg5ao
 mH1dQg+2Z0vVifua0gUCE7w8v6RK553qhHVWoZI4QfZcv1kDqI1on17sfDJgXVnc
 IL0xtQPU+dOJ3tHi8kRDQgjCBHf17xvhQ0u+cNTDa9yoaEXdqiFJxidHOq8X3b4Z
 YLDZ+g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccx7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:36:46 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6c89de84f33so1559528137.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781793406; x=1782398206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oiIzWgo2ACmGpLKfLueCD8cX1zsKt1grMXbORVio9w8=;
 b=TvPJ0tEXiUl/YrBYtnosooRBEFDs7WNyLplt7zPzJZ1FzMR864OJXCMHSoTk8RtZq2
 wGsqEeUenN7iflwTokow8Rvr2CLidcJOOhNh//gRsKS1ITOmM86s/Jfd9lP1KTy4Gy5h
 xaABLk2Ac1cb3YHPLAPw9/ihY/MogQNS9kPqt5iLhSH+ww5xkJt/E2YVTt9Uq/io/pLn
 DIU6GQXEZm51uafIf8Mnj39acrJowzB7PIsWgAoobeFfhUA0/Wy+Msjvi7v6vc7jp9J9
 ZsdCjJXXNMj5yr66TuWOl3MOasMKY8Zp5VZQzPNt+tL+HKVnAELYFuX6SqIOxg67OSOR
 KGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793406; x=1782398206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oiIzWgo2ACmGpLKfLueCD8cX1zsKt1grMXbORVio9w8=;
 b=kD9yOQY93kgNkiDXQutptfHzD99bkvI7mDOOB4lFzPlp3ts6pXUkDwaDjHALYSUqSv
 Fqd26lSOGnA4Cta5k+a8pIfi66wlgevGpzCTqJrDxOljY2tN0J7GWbXoVOhDmHCntL96
 PAY19mYaWr5+GP15bI3g2YMCU7hmq3g5DJnAKxSOcdMpHxDJAbukh9VFk3t8L7puZoXu
 /M9a5fShSSOYNwjptamFIhF2BapoPUg4Ljr/fzX6E5PaWo8Mu1QOJrIrpcGUo6xhl1Rk
 so1yjMsIcNvaBqZK19HWtOOkVQ1tELUnl8nm4bn2CeVhlZX+WKANOaidglgn7/NHQXDO
 NkmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Mi3INwK7tjQR21xoCcwqUaJ39+E9e5rx4EmNse4vsdOM8YXkWdh7S10vYpmIB0A3DXBTv7YxQEzR1@nongnu.org
X-Gm-Message-State: AOJu0Yw+hFGNx+sG2+DiRxEuVTyBqCptssPMaVJxv4+Ww8wl7Ebqm5TF
 /+PwH9DvI4Wh3CqYDt7Ct25y4QrizoaGqEdDgns1Ty2ZsftaiuuA/cPgORwLC2YfXNWK0rlKB/N
 j3RnEasOqafoBrRtPHtezjnc+CQ5cqnj04QEqrEC+5qIlhZqRSpx8/6e/kA==
X-Gm-Gg: AfdE7cnjLsZVvw70W4w073fXGvoOBIKmH54bvl399ybGN7+Q/VcUC3mKC8W/bfJwRUH
 wocXTUJKx8ljDXOX+0exWrkJUM/46pha7M4otCZ4gqG0vGhzutTlSSNCm5/F3hWC0CVd3rA1slX
 d4RimKY93s5PHwSQUagXB4aVA2u/GjIFsy2o1CvqvqBwIKM04XdnAgt60O3GM8HCKwJdfEMF7eK
 LwXBHZSuyqa2Wq0JnbiOll7dxm0WDmoLWW6lDAA7KyfnyI/cKQGf2m5/pr/T+Vt3DCK3VKKfxk2
 A6VINk/5Lp5Dafc7E4pztJCM2aOZAMsIIfVTIXBDsjD3tRS10kmig6PACxaTHwlY+GR03JoVQ/T
 fERX+aw4QD6kexjEST+FMaXewrsht+CIYdNLL43Bz9LBZwMVpAojzAb8mkaY62g==
X-Received: by 2002:a05:6102:50a8:b0:6d9:5eaa:6d9c with SMTP id
 ada2fe7eead31-727c51cec36mr2652367137.12.1781793405968; 
 Thu, 18 Jun 2026 07:36:45 -0700 (PDT)
X-Received: by 2002:a05:6102:50a8:b0:6d9:5eaa:6d9c with SMTP id
 ada2fe7eead31-727c51cec36mr2652341137.12.1781793405561; 
 Thu, 18 Jun 2026 07:36:45 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm284654915e9.12.2026.06.18.07.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 07:36:44 -0700 (PDT)
Message-ID: <f174b13c-2678-42d8-b59b-b14d7e9177cd@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Content-Language: en-US
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <tencent_4EF8937D817B836D3D911B9B05491B02950A@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_4EF8937D817B836D3D911B9B05491B02950A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzNSBTYWx0ZWRfX9SFS3FvQAigi
 +IdzA5Inub74Zlwc63NTHAHivx7RF4sEOznW9vOpHKkPqXaYN+aOo6sKwyQm7QYVY0m89RtOtzB
 4Qch3u8TJEbxSFkUBy1e9DUqWjUI6a5el6nfuNxpyfZB4wHdT2bgg48v34GxRkveilFFc2aZh0y
 Nhh4nMXFqiFtkmizd/JpJZwwIF7djq25o9TR9wDqHISrEPx8XNQkQ3wNOa2Hl8Y8NsgRt+RVUTZ
 qkQ4LH+MpgDwqrAyS40rXEHyfg13/wIhbypdJKiTe4Khf9/3l3wbvIZd3SruXMMPbSQNuI5OC5h
 248ML017+NG81iTRk5ryzyVsQf6bGQm4hrshaZXbYjWfDvFIxWUwCr0yeSQ76//BBqa9Sp+fZgU
 iibqe2Tbo+7z2wGzkjosufksy1QvuBnq6tEzIgcv6gLnmLuuTOBuo12E3Ewv2BXyKKPgUipNySx
 zvBRK7ud6UYTUYpzaMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzNSBTYWx0ZWRfX5g+Veu0reNza
 8heXZxJgeYX26oJszhXBHL3LxiOOdU01lNyPgx4ytyWnLBkdUjXsalP8bvHdVYWGyL+kYQFRkY+
 O92t2S176DuEkqcNKeg7c080YaNhSYg=
X-Proofpoint-GUID: iq818NXIp7-jZnYPbogyToEV9mT1aUFA
X-Proofpoint-ORIG-GUID: iq818NXIp7-jZnYPbogyToEV9mT1aUFA
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a34027e cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=bDN84i_9AAAA:8
 a=Wo38fnyJPC63dEFqrDAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180135
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18/6/26 16:06, ZhengXiang Qin wrote:
> check_zicbom_access() currently treats any probe_access_flags() result
> other than TLB_INVALID_MASK as a successful access. However, a result
> with TLB_MMIO means that the target is MMIO-like and should not be
> treated as a normal cache block management target.
> 
> Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
> non-cacheable/MMIO-like memory.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
> ---
> Changes since v1:
> - Use a bit test for TLB_MMIO since probe_access_flags() returns a bitmask.
> - Keep Reviewed-by tags from v1.
> 
>   target/riscv/op_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81873014cb..f23b060585 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>       void *phost;
>       int ret;
>   
> +    target_ulong fault_addr = address;

CPURISCVState::badaddr is of type uint64_t, can we use that here instead
of target_ulong?

>       /* Mask off low-bits to align-down to the cache-block. */
>       address &= ~(cbomlen - 1);
>   
> @@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>        */
>       ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                                mmu_idx, true, &phost, ra);
> +    if (ret & TLB_MMIO) {
> +        env->badaddr = fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
> +    }

Maybe adding 'else' make this code path more readable.

>       if (ret != TLB_INVALID_MASK) {
>           /* Success: readable */
>           return;

Feel free to ignore these nitpicking comments.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



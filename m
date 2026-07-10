Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5025C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiK1M-0004hW-5y; Fri, 10 Jul 2026 18:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK1K-0004gU-CV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:48:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiK1I-0001kJ-T2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:48:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALClvQ1931558
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x7Ue+ohxjKzqpww/QqQ0FHJaegZAXOfEUJHVV8e7wUs=; b=GzsJla9YvIbFCbnw
 ALL3TUiYg6fS0O6dibttdkfj+a4wZK/3JSHldPyFYuarPC0PCor/sEGAGaEbU+6Q
 JJpwLupnZEXF+VO/2tA0kwzkITyLPNnZDwHP3uxU3pLacKxQ3FiUXvHmRnjETEtz
 gCN8aYqCGp9N9/Eag/ncUqOA96MA+tY4fxjBHmt/O1nmskxMBchq1z6j1Z4lGaMF
 /PsOTPNkTSjs188wmvvnjY1WWSxmByiDH4Ddye0SBBs39oiR+v9pp2/I4bavDDyz
 UGZFJdEfduBFYEjOGcuPy53jECRlCdrHNJFqsQ4PFqKQc6ynxbRHvJIoQM+GKGUG
 Mf+QiQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r7x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:48:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso14711871cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783723711; x=1784328511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x7Ue+ohxjKzqpww/QqQ0FHJaegZAXOfEUJHVV8e7wUs=;
 b=Dod+kUNBbhUIfwykvHB9bO1DrTc/GjrbNgTgaasv7WSsPBef2IkFkMrbR+qPoT6YPj
 yzH03CaISA51kyG3/OzBcZtjVLoP+ZERnwMpwT6f5uxmbuAH1uUb2sSrbVVBJQDEZ8iZ
 /sKdsCHgijj/GlzhlFQCWrEe31D5W7knySDLO2Oxkq+PwHZbgTZ3xvjw9TLTEAqfaPb0
 KEZ2MVDIsH4vwlNMmqdiV/AwOQTbOO6U0X//nSGbvuEa/0uyHLUBrjZbhL2XFccTxvGw
 VgPZeZ71A72ZhX5NWVb1+YaCqUcId898rl3DuQ282Gt+XHBXa7Bl3ZQpVcoqAIlx9r+n
 n/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783723711; x=1784328511;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x7Ue+ohxjKzqpww/QqQ0FHJaegZAXOfEUJHVV8e7wUs=;
 b=QfFYjiF2tjuROMXPzEGYu66lgcbvSAVZkPyIzUqjxeRRyAu7uJLUXKqiQ+bAb9/r1L
 jF9kn2L/EbN5dpvwmCN2C83LBMAU0QsXBux6lYl9WSxpauqseNLPltAu5denqiJMYhF7
 QDx1qKJv+4OR2wZyJNI2FlTvtyKK/rYq2LDBVRCNnJ7OtwSsncN5N7A4/8DQaHxUPvyq
 w6D38gOgYRuH8Jn1DMjpNUoEJbk1PN03hyguvy2l063PiNoD2Wo5Tz1imIM88ZP63T9G
 UmWT+Lr5xTlnGhKaQV6GVsahylBY7HkIMX8nHWGle33WgM543FXDWwH+fkMJRG29toHZ
 67Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJrIWxFdudbgD/dpCjzNvW3eO9W4naY3RWitmzo09ocGRRQ+HjbHuN6OMvXr/gcW5PM1EoHJ1nYwgs@nongnu.org
X-Gm-Message-State: AOJu0YycNhCI2qEgj186CGti5tMLSp+YiqeRZ32iJhSwSRtS/n4HN13L
 oHruDKezoqCHvg9KgliCy49Nv9NJrv9ZQV/eESK7B9QFVzw54YSplRcGIzVlvgKkr+YbOSlaeYX
 ghBQNObElWcsXaRwZD/Y49IOxf4BCGUpdblHOvyGnEnPAr3rCRjluBaMWjw==
X-Gm-Gg: AfdE7cmFc/IX+5WFSm6nAu08UyVCPNSAd9MeruWT9u8H9amkhIAp20FZTI2iY5hUeKx
 UnDDf62zM2l4uW7iPettyKTVHvfh+d/Leo3iKgRIxyNKoN5pC53gAhnK2XlfyHStM7Ef9exqPjq
 DJVyrD8LnpYUZaDe9Wrlok4j6O59AFCNurvUDMFnim1rT76Y7oPeiuAa6PdxTJ3guqxivH0aYLv
 rAeRR+CQlEV4LX4bOnrLMOpJdpABny8pad+ntYYTKWuGG9gx5egzbYw5O7uptuKflB8ThJOObac
 /HwiXjpieFZDERTkF1dD72/LacChtDxkqz95G39SugwYfo1K6v0tShDbaNXngYMc8P6LC4JqiMe
 842AKvnF06nho3prMBDi1C3lUXF3sa81a2huwFZwYiSzyYC+YQwu3LlFe8/Edxw==
X-Received: by 2002:a05:622a:1f88:b0:51c:fdd:f040 with SMTP id
 d75a77b69052e-51cbf8df184mr8667981cf.21.1783723710753; 
 Fri, 10 Jul 2026 15:48:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1f88:b0:51c:fdd:f040 with SMTP id
 d75a77b69052e-51cbf8df184mr8666611cf.21.1783723707928; 
 Fri, 10 Jul 2026 15:48:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a2e499sm100209015e9.0.2026.07.10.15.48.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:48:26 -0700 (PDT)
Message-ID: <e8e0fe2b-3aee-48d7-85d7-5829c9039588@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hexagon: raise SIGBUS on unaligned scalar
 stores
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, matheus.bernardino@oss.qualcomm.com,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Alessandro Di Federico <ale@rev.ng>
References: <20260709233436.3075100-1-brian.cain@oss.qualcomm.com>
 <20260709233436.3075100-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260709233436.3075100-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5176bf cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-TQTanUlv4ZweVcjcWoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: TpQwWsvdKcxSlBDB9duAzcR2T-zFog25
X-Proofpoint-ORIG-GUID: TpQwWsvdKcxSlBDB9duAzcR2T-zFog25
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfX3o/Vzt3+fl29
 uZdhD1oAEUTU9mUoAmt40MDfv/jnzZhsuyTjrp5hcKTKhOyTebNCwmUc5II0Y8pNqS26KOWDRKz
 6rFyEKtPcmmtQ2vYOyaQh0UsqU2r8Uc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyOSBTYWx0ZWRfX6N8F2wLRcEbr
 wOzRBOXYw7YjASy4t8gizMxaGOm8Unw0w16TiHJTumslIdXFMnsbe94FgGfbhSjUt/YeMNgAsQc
 LPiGq/TTs7nS7ywVK7act9Lven7cn+DpZa9t6PGld58g9+uv+pNNQCB9CaydAy6nqtu3iQqFYE0
 DDHsR/IHnQ/5oE2rkVvRrnUVnsVj6zXIPQ9OXiaVECXvHhcZa5o9KJ2ueLurXnP0lSY+AgvSCYJ
 7FMxaVAwO7SWkZWsMdGPWOYZ9mJZvHr4EPUvXvHxvW9WIz5wIeJaBgT4VUweZddM6ukyT08sU8v
 poebhgnjg7l2st+MZCr9QVpf92Fvcd++3x54UrfneDgyUBblpSy0R2yQeF4iWHy0tRvqO2rjX2/
 Wn2252IigiU69Pysrir1fNwDPpv7AU4tbbW2m/cWXgIGIDY6FGcOkEUKg/TguFDGAMF1z3BkpLY
 UUR3Cpvxbx3OJVUcayw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100229
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Brian,

On 10/7/26 01:34, Brian Cain wrote:
> hexagon-linux-user had no enforcement of alignment for scalar store
> exceptions, and unaligned stores silently succeeded instead of raising
> SIGBUS.
> 
> Stores are logged rather than committed immediately, so both commit
> paths need the fix.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/genptr.c    |  4 ++--
>   target/hexagon/op_helper.c | 13 ++++++++++---
>   target/hexagon/translate.c |  6 +++---
>   3 files changed, 15 insertions(+), 8 deletions(-)


> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 125952aee59..3ce223caba3 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -95,19 +95,26 @@ static void commit_store(CPUHexagonState *env, int slot_num, uintptr_t ra)
>   {
>       uint32_t width = env->mem_log_stores[slot_num].width;
>       target_ulong va = env->mem_log_stores[slot_num].va;
> +    MemOpIdx oi;
>   
>       switch (width) {
>       case 1:
>           cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
>           break;
>       case 2:
> -        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
> +        oi = make_memop_idx(MO_LEUW | MO_ALIGN,
> +                            cpu_mmu_index(env_cpu(env), false));
> +        cpu_stw_mmu(env, va, env->mem_log_stores[slot_num].data32, oi, ra);
>           break;
>       case 4:
> -        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32, ra);
> +        oi = make_memop_idx(MO_LEUL | MO_ALIGN,
> +                            cpu_mmu_index(env_cpu(env), false));
> +        cpu_stl_mmu(env, va, env->mem_log_stores[slot_num].data32, oi, ra);
>           break;
>       case 8:
> -        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64, ra);
> +        oi = make_memop_idx(MO_LEUQ | MO_ALIGN,
> +                            cpu_mmu_index(env_cpu(env), false));
> +        cpu_stq_mmu(env, va, env->mem_log_stores[slot_num].data64, oi, ra);
>           break;
Thanks for the API conversion :)

Consider enabling TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API in
configs/targets/ (I missed that when you merged the system emulation
part).


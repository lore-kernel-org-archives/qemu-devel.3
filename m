Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7E8C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsMGq-0007aH-9V; Fri, 07 Aug 2026 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMGo-0007ZG-57
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:14:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsMGl-0004qG-O1
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 11:14:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677Cfhgb1530722
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 15:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EwreuXvH5Fm7VDS0c7WJaNI4zJs4R3CPKJSTGKiPIEY=; b=dewfLSuDF9Fk5SdE
 hy5KevnLrvTz4tN2UaYtshIBDRu2y824jKRvuM2ruTBzjFVob7RFRAifbEivabfD
 xc7LaFqq0ciwhsQ6+xzU7FaCeG8f60R+hKSbKcKLCIqINU1jQHxNQ3XaTCYQlHA/
 l+8w1nQ4fx6aSzfLs8tQoh5BP2FG27PSkxrC2Uobp3xEK8V10z3v5pfky0K7q9c1
 1m0mlGIZqiwhYcx9fDPgG6W/PPa0nhbyO1TyzkF14omahy/06RAXtP6HyL4Tx6eG
 VquB5JO6A4MGlb+8haosSXXsp6jELwnm7Kans0BZn//rEvAUMBjkOXlVJwUIt/EB
 Dti0RA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwcjb1bmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 15:13:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso30796886d6.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786115637; x=1786720437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwreuXvH5Fm7VDS0c7WJaNI4zJs4R3CPKJSTGKiPIEY=;
 b=Xm2ZhfGl31VVnSlJSReWNckfPL28GsgVRk3kM2PhiaDhOEeQBglEIqyox429X+ECli
 EogIczIanS8Cw2DOnanA03HlgWeZNEsmQ+y91Vr9QTiISEpumTGg05LecEC3XYeUtZ54
 WrkpaiSpi0IT0NwV2wOWi6uPSG8PZg9TNTa7E6aJOx7XZcL8RWRgo37nlmPvCYm+p9fb
 J6iH/1oc7jUsB6iJ1+n5i0c6ooAsra2YG6xH+u1lGGEYP22In9MLhS7MTFKv3uRoNUk6
 5U22I1v/1c4IPUU+7Uvtic7AmB197q8rH8zWKFDeOKghJwOBDG3f+SYADn56IJF2Z5Ex
 1brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115637; x=1786720437;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwreuXvH5Fm7VDS0c7WJaNI4zJs4R3CPKJSTGKiPIEY=;
 b=sDVcPlofcHW0L8wA73edc+9YddmaGAHOhKNf+EblCkdFVoVAVwLKrlodmU8ylOvcVm
 FhwrEqAyc2aj74G735LZZLw1ZQj4J8LiXNpDKWhQ5vG5id6qaxg0DnsJLBAf+s7U6ZS4
 b7u+avXhsZiTYaMNgorRpsux+g1xw5n1NgtVb2pvPs71G+XqvocdxC0bfxCIvKGA6jLT
 LXmnjnS9oWMdIU1jUm5Q3NNTw63UU6JJYP+R7vP/XGCFBBx1WJeN4gWyq9+jkWYL3JIb
 MDgfrDXj5fr3CfR2wYW22ImLrS93g7alAtgmdBgGs1vt95LKQD3zU4WStQozup6oDb0t
 IZCA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrfOFxkySFDDqKXMj99HOicUvxAZ3OO/PJvGMoNefNEDuPqD0KDdrextqGmCsPmZpkhXPg3A7DIx9Z@nongnu.org
X-Gm-Message-State: AOJu0Yy/xLqLfUYNVRXBNmHNYDwDQp618Xem+cT5IW6wqvOH5yi2q0ID
 6AVxlEoRc4DTLQlln49GiTVN8AbDmu2hNvW/rAcTdE/nvcv+/iMmHlDm0vFWUSnOe2KTl/Z+dfC
 nDk42spcmOjrcoiMAnBjpGtTjLa/Z1AG2fku5Bc6L5w7Lu+IOJWLWxLxXAw==
X-Gm-Gg: AR+sD11HRyV2qUKO/OgLe8XZfIQkgRHoPOhVmvC2Jw9dcEGvGEBbHTXQ4QRvZrJRrDO
 J3V4JM9dWgqmttpFGCUrBARopKspQrvZLV+lWovytyvFnnn6FeKUlTUQ0/CbMJh7Zstouj/1MBa
 9TjwGiYkqEeNryI6d9AcNON5wYlADEj3ljoIqHMmaUV80luo5wzhvNxVW0hjEDiOXfUQKaY/i4U
 VeUCdue0og5rM5XIc/0FrNvkvkKUdBg0AWCF/x5kdyfWugWHh9caT7jFDbSkTE5D9GLjvgNVmOJ
 tneucKLx5mSLlD1sCKj3w08imXQkjCeZHN5/W/UJ1jSWhgKQqeK6YT/pJkPKdWmBrl3ix45TM4/
 s6GFk/BAlLhsG8gIoZF26ODQ9gPx55hPRlzcG
X-Received: by 2002:a05:6214:4306:b0:908:958f:4f2 with SMTP id
 6a1803df08f44-908a6f63f11mr52993906d6.2.1786115637310; 
 Fri, 07 Aug 2026 08:13:57 -0700 (PDT)
X-Received: by 2002:a05:6214:4306:b0:908:958f:4f2 with SMTP id
 6a1803df08f44-908a6f63f11mr52993056d6.2.1786115636860; 
 Fri, 07 Aug 2026 08:13:56 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a9329677sm10726136d6.36.2026.08.07.08.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 08:13:56 -0700 (PDT)
Message-ID: <9308dd7e-5242-4e77-ba1c-79453455b009@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 12:13:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
References: <20260805164345.698208-1-frank.chang@sifive.com>
 <20260805164345.698208-8-frank.chang@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805164345.698208-8-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX5qJa/KwqifaB
 EUsgju2qKI/9UpTMVM674PXZjzAiNxbxqPHE80W2+8mVmYj12Pie1l1+78Cfzcg0ttBMzo4NFSl
 bryn/MGgVvzcxhDXSPBkWnkvZzCTYwxNjrdYXb4BCVSZmCVb8iamvu6gajehXXw7qKpKB3mC9P3
 3rJOEaXPAkjIUVbYbdhfZrIOEjOtrLlNe2WLXD5/Xo1st9XiJNOxfpIjVPWwKSVo2wECOhPudQw
 D6NqbHl0vNJEPKGfiRs06qQ9n/xvRQCTIkdomt6UJwivLAuh6lGXE2y68TnJI7eYk3xOsodZWgb
 Z1rY+dkyTmndEVWvniZoyRA/0D9OvvKrnKIIO38s22xuT+ORdAuFkqiRLdMFE+M/OFI5wL9/cHZ
 0J9xD3d6cBpPVJSxht37ShAX0gd2quyNb5Otk2imQ0ZOZNgHv00Re494fBi/Qtf/uhBYhdDV0Pl
 JTBnmssV6p2UxCR705Q==
X-Authority-Analysis: v=2.4 cv=QsBuG1yd c=1 sm=1 tr=0 ts=6a75f636 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=07t4oCQUOmU6uM9syAYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX6cQzgoueww4i
 0Tsc283IkBxrtQMMTFfNZJjquckxJCeg1kyNj4yMVpS1+b/LgvtfLJJzAhXwxyiKfuUus2iNpip
 fAnk0hhPXe7numS1ns5ym1tocUw4Hts=
X-Proofpoint-ORIG-GUID: 2N3ZHqZ5MlYAkzl0g5WRKUT9vBeBpk2o
X-Proofpoint-GUID: 2N3ZHqZ5MlYAkzl0g5WRKUT9vBeBpk2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/5/2026 1:43 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Update Zicclsm ISA string and expose it as a CPU property to allow user
> to turn on/off Zicclsm extension.
> 
> In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
> Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
> Now that Zicclsm has been converted to an explicit CPU option, it must be
> explicitly added to the RVA22U64 profile's extension list to ensure the
> profile remains compliant with the specification.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7ee89f6fc4b..19b93f9c979 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -164,7 +164,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
>       ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
> -    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
>       ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>       ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>       ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
> @@ -2237,6 +2237,7 @@ static RISCVCPUProfile RVA22U64 = {
>           CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
>           CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
>           CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
> +        CPU_CFG_OFFSET(ext_zicclsm),
>   
>           /* mandatory named features for this profile */
>           CPU_CFG_OFFSET(ext_zic64b),



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32479606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRNlLdjI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hAYm5RKc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZeA-00037z-8o; Thu, 29 Oct 2026 19:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZe5-00037j-OH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:34:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZe2-0006nE-Tx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:34:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKbPx1578788
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 paaNaPsfCs4GTzPYkbhy108PJTLvm5mLoN4o7ZSewvo=; b=gRNlLdjIjxcjaMiv
 HfepGLhMNs4dtoHo0Dc5WE/8MMpg/gSdSyqRrW3r/6jC4vMVULi/8Nax8Bbdx4Jd
 3JbSrzJkmubGeJnC/BPOnZD4Cjslr53waLKc1R3o3cIo5rtFCPMDQzpXzmBl/+VK
 dn7A+9hZuK+W8Dj3juT2HUF3CPleCzJHPDqi6hSXwuD3+vJYmxpBgUCUY1M1FukY
 SrtgzBU91dHrx1jxEofNpF5IORh307ezYA1/3oMpM7p3ZEFkkxYSregw+m9/6ahO
 FqqmA5XQ1H/tm+ApmobSXxAEcYbOu/gUm/hOxqP6fRDShnMrfah1Q3/MF1t9iieV
 kg9Cqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgb8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:34:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53661e036a2so1777001cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793316890; x=1793921690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=paaNaPsfCs4GTzPYkbhy108PJTLvm5mLoN4o7ZSewvo=;
 b=hAYm5RKcnksytc3p9hVFhdmaIfGftXyDaFzcNtoEJdfB5Ic0Zlk6GPaduVaqen/VhH
 vlgqIRWFvlcS/BqldbC8GN//FcXzuDrRiGw7sC2EH0uajK5yLNK+JpMi7i29ZmATXaPT
 xLEtd43jJVMwtX0PImZ/FxoavHQYzVJDJkeePCBBzWqN2AEaHxaK8cMmrNjolyrmJdY/
 ldHm1V3gs4ATA0Nj+/qSsjEnA1xqLyrdXT9whfx2UO6jOkxagSKn5ncLj6lS3HfLnAFL
 KBrWX+2zOWv0ZGLOuBTi+75cJxi5u3n4DnR3WOm7opzPJZZkrBJsIo7o9L7hneE3Zl9n
 QtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793316890; x=1793921690;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paaNaPsfCs4GTzPYkbhy108PJTLvm5mLoN4o7ZSewvo=;
 b=IRc0VZNugVCx0HkyHMb4oOCkN6rOOG/+5ZOnajL/bvAB9lWTsTjVree41uHOw9JbsQ
 ZfqQ7MaC6DUpj2VyiWMS26Msi6djnEvZo7gxw533bH25iQgLvvfC/C4+XlDsBNRvCbCZ
 J/n3U/fRGi+56OSI7qba/nWl6iFVpjqpFkrhhD4WcGXK8es7edDMQzwkKFhCnhmCKmvG
 UUfUpvzO4wyH+oTuDEi04ReqdlW3fQhaYOFH0sz/551kf6FY5qP0b1RlQ3B75VZ26Gmu
 Cxrt1JxuXWSefhFXrrw9glHDRel65fQSsqtq7XEyLoZ13ssFnoKvOlxUWIg0OpPMjU+8
 ojNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBB68o+wnL7ImXPvOltkgoiGLafD1GFOlNBW5/RQYPr8kzUolEaFk49q59Hqk5Ug8tnO5/oYX4pD3I@nongnu.org
X-Gm-Message-State: AFq9FYIWwiS+v7U10wudu/SOd8rvAz4thZEn3AKZwQMMLUPxkKkiCIbK
 5Zl59o5PkuHTfGiPVtFq1EO7sb88b6o4BBGylUgr/aHvCrd3T+Nd7u9kdys1f/EMg5vT+++q6oY
 fm0Ai5rcbsLUnFO1aahkx0OAbrV5Oh4n4lgJnYRJpQjSGCq/9g30Dv9gLYw==
X-Gm-Gg: AYBFou2oO08vr2BSa5a+9tyBBBDIHpVvNIZjqCduPmVFIT0hcltK26zwcbGX3nqfy19
 z5kVFjE2B8rqwMSxgdK87ppsW9iL2LNCeoCaubWEl0l3+FrMfdYtVRXg7bXp5YkXhdy88Sg7Xl+
 orfoKPIiQ7sLB3cWd0N1VEjpQasg5oHHsaavjfTyTLE5QhH38Zh4bQFef5KQItmt89sk4AWvYGn
 HQB6sgb++eNGCeEnpRd9US1hHRhXTNfCEljQefA1NbnGawDM0GJEdhtelwQyK0JGxgp3C0CMIVm
 hJthTKBRN2Q3tSQiPIYvcfyvu/1bJDizjCMp71hUF6DjAfg3zV6V0akkZMwmPG7hUMppcCiP9SY
 lnuVh1aNJqrpAt6pQ4hpT8z0NnoIhCg7vk+1gf+oOYtmazeNAym6ihvNuNZbtEs4BpqmWeOjpsK
 h/2GFd07CEg9Tuevh6Kmf39uWoK9UWWKWlLfQo5GYEus5njRwNuH5Z
X-Received: by 2002:ac8:5a84:0:b0:53e:35dc:9bd7 with SMTP id
 d75a77b69052e-542b7cfff77mr10382691cf.61.1793316889998; 
 Thu, 29 Oct 2026 16:34:49 -0700 (PDT)
X-Received: by 2002:ac8:5a84:0:b0:53e:35dc:9bd7 with SMTP id
 d75a77b69052e-542b7cfff77mr10382281cf.61.1793316889230; 
 Thu, 29 Oct 2026 16:34:49 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542f690ea85sm362231cf.4.2026.10.29.16.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 16:34:47 -0700 (PDT)
Message-ID: <8926a45d-27d6-4a5a-9a8f-7d8f40952431@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:34:46 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] target/hexagon: add HLX helper support
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-7-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-7-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vY_ugo5SVCUcsLvLAujlcUW-xxvIz4f0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MiBTYWx0ZWRfX9d4X8ROm8PnX
 0cOB6rNq/v08P1mJVjqcZWDTm18NFKJiovqMyYN1RN3Ifd5jjzZVOBNZWFEC/EXibTLmUoRSfKL
 h66UYXlTonwBZcnDaTptk6z0r8TGC6A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MiBTYWx0ZWRfX1n6f9ADaT9W/
 eyuIiqdKxuxxTKHtfrU9nrTEjJ051N0FupWxkjBp6X1zDwztUaE7Uz5IbyOyaNnWGlv9sMiDO/T
 cFufrrOhD1hq74ZSA1VD9uWysX862yfzbKFJ0/QSC9ctu6HLWT2110e8Fy3nDA/9pgVymic5mSW
 zEZHJ9923ElSU++S4ByWpL9dUqy3Ihn19DitcSZA8+Qf+FQ9narMWZGwPP+ahae8MdyqZtr2rYV
 16PyIoWqn0y6U713+U7WZ+AiHe2zVLmyVd+6AGaxBilM8ZweTQbVYAV7KUIxwZ+snlqzvO6ujt4
 k4Xda10EENzEjk8eMZYvF7qx+VteHSoWpUeWtfrS00S3q6m/gSDMzRq3l3xe3n9FiEae+38ti6e
 o1Auandxypad8yXosMdEevQYuOwWIqvdCayXVmuHasa1GjSVaH5On5rFoj7B3S0c73McTd1GQFI
 NoWZNMZgvTTrDDGrGFg==
X-Proofpoint-ORIG-GUID: vY_ugo5SVCUcsLvLAujlcUW-xxvIz4f0
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae3d81a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=3URqhVyr4cxL2sENWZcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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


On 10/29/2026 12:43 PM, Marco Liebel wrote:
> Add HLX vector load, store, copy and commit helpers plus generator
> support for L register arguments and register pairs.
>
> HLX accesses are limited to VTCM. V85 defines no exception for an
> access outside it, so the helpers do not check the address.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h                |  4 ++
>   target/hexagon/gen_helper_funcs.py  | 86 ++++++++++++++++++++++++--
>   target/hexagon/gen_helper_protos.py |  7 ++-
>   target/hexagon/helper.h             |  6 ++
>   target/hexagon/hlx_helper.c         | 95 +++++++++++++++++++++++++++++
>   target/hexagon/macros.h             | 56 +++++++++++++++++
>   target/hexagon/meson.build          |  1 +
>   7 files changed, 246 insertions(+), 9 deletions(-)
>   create mode 100644 target/hexagon/hlx_helper.c


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 904dcc2e7d..7524ab8769 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -204,6 +204,10 @@ typedef struct CPUArchState {
>   
>       HLXVector future_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
>       HLXVector tmp_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
> +    /* Pending HLX store. */
> +    HLXVector hlx_store_data QEMU_ALIGNED(16);
> +    target_ulong hlx_store_va;
> +    bool hlx_store_pending;
>   
>       /* Temporaries used within instructions */
>       MMVectorPair VuuV QEMU_ALIGNED(16);
> diff --git a/target/hexagon/gen_helper_funcs.py b/target/hexagon/gen_helper_funcs.py
> index 1629ebc0e1..a53a57df12 100755
> --- a/target/hexagon/gen_helper_funcs.py
> +++ b/target/hexagon/gen_helper_funcs.py
> @@ -55,24 +55,28 @@ def gen_helper_function(f, tag, tagregs, tagimms):
>       if not hex_common.is_predicated(tag):
>           for regtype, regid in regs:
>               reg = hex_common.get_register(tag, regtype, regid)
> -            if reg.is_writeonly() and not reg.is_hvx_reg():
> +            is_vector = reg.is_hvx_reg() or reg.is_hlx_reg()
> +            if reg.is_writeonly() and not is_vector:
>                   f.write(hex_common.code_fmt(f"""\
>                       {reg.helper_arg_type()} {reg.helper_arg_name()} = 0;
>                   """))
>   
> -    ## Print useful information about HVX registers
> +    ## Print useful information about HVX and HLX registers.
>       for regtype, regid in regs:
>           reg = hex_common.get_register(tag, regtype, regid)
>           if reg.is_hvx_reg():
>               reg.helper_hvx_desc(f)
> +        if reg.is_hlx_reg():
> +            reg.helper_hlx_desc(f)
>   
>       if hex_common.need_slot(tag):
>           if "A_LOAD" in hex_common.attribdict[tag]:
>               f.write(hex_common.code_fmt(f"""\
> -                bool pkt_has_scalar_store_s1 = slotval & 0x1;
> +                bool pkt_has_scalar_store_s1 __attribute__((unused)) = \
> +                    slotval & 0x1;
>               """))
>           f.write(hex_common.code_fmt(f"""\
> -            uint32_t slot = slotval >> 1;
> +            uint32_t slot __attribute__((unused)) = slotval >> 1;
>           """))
>   
>       if "A_FPOP" in hex_common.attribdict[tag]:
> @@ -80,14 +84,84 @@ def gen_helper_function(f, tag, tagregs, tagimms):
>               arch_fpop_start(env);
>           """))
>   
> +    ## Define HLX register variables.
> +    has_hlx_reg = False
> +    for regtype, regid in regs:
> +        reg = hex_common.get_register(tag, regtype, regid)
> +        if reg.is_hlx_reg():
> +            has_hlx_reg = True
> +            if reg.is_pair():
> +                tmp_name = f"_{reg.reg_tcg()}_tmp"
> +                f.write(hex_common.code_fmt(f"""\
> +                    HLXVectorPair {tmp_name};
> +                """))
> +                if reg.is_read():
> +                    f.write(hex_common.code_fmt(f"""\
> +                        hlx_interleave_pair(&{tmp_name},
> +                            (const HLXVector *)({reg.helper_arg_name()}),
> +                            (const HLXVector *)({reg.helper_arg_name()}) + 1);
> +                    """))
> +                else:
> +                    f.write(hex_common.code_fmt(f"""\
> +                        memset(&{tmp_name}, 0, sizeof({tmp_name}));
> +                    """))
> +                f.write(hex_common.code_fmt(f"""\
> +                    #define {reg.reg_tcg()} {tmp_name}
> +                """))
> +            else:
> +                reg_def = f"(*(HLXVector *)({reg.helper_arg_name()}))"
> +                f.write(hex_common.code_fmt(f"""\
> +                    #define {reg.reg_tcg()} {reg_def}
> +                """))
> +
> +    ## Declare fLVFOREACH loop variables.
> +    semantics = hex_common.semdict[tag]
> +    if has_hlx_reg and "fLVFOREACH" in semantics:
> +        f.write(hex_common.code_fmt(f"""\
> +            int i;
> +        """))
> +        # Remove nested fHIDE() wrappers.
> +        while 'fHIDE(' in semantics:
> +            # Find the matching closing parenthesis.
> +            start = semantics.find('fHIDE(')
> +            paren_count = 0
> +            end = -1
> +            for pos in range(start + len('fHIDE('), len(semantics)):
> +                if semantics[pos] == '(':
> +                    paren_count += 1
> +                elif semantics[pos] == ')':
> +                    if paren_count == 0:
> +                        end = pos
> +                        break
> +                    paren_count -= 1
> +            if end < 0:
> +                raise Exception(f"unbalanced fHIDE( in {tag}")
> +            semantics = semantics[:start] + semantics[end + 1:]
> +
>       f.write(hex_common.code_fmt(f"""\
> -        {hex_common.semdict[tag]}
> +        {semantics};
>       """))
>   
> +    ## Undefine HLX registers and deinterleave written pairs.
> +    for regtype, regid in regs:
> +        reg = hex_common.get_register(tag, regtype, regid)
> +        if reg.is_hlx_reg():
> +            if reg.is_pair() and reg.is_written():
> +                tmp_name = f"_{reg.reg_tcg()}_tmp"
> +                f.write(hex_common.code_fmt(f"""\
> +                    hlx_deinterleave_pair(
> +                        (HLXVector *)({reg.helper_arg_name()}),
> +                        (HLXVector *)({reg.helper_arg_name()}) + 1,
> +                        &{tmp_name});
> +                """))
> +            f.write(hex_common.code_fmt(f"""\
> +                #undef {reg.reg_tcg()}
> +            """))
> +
>       ## Return the scalar result
>       for regtype, regid in regs:
>           reg = hex_common.get_register(tag, regtype, regid)
> -        if reg.is_written() and not reg.is_hvx_reg():
> +        if reg.is_written() and not reg.is_hvx_reg() and not reg.is_hlx_reg():
>               f.write(hex_common.code_fmt(f"""\
>                   return {reg.helper_arg_name()};
>               """))
> diff --git a/target/hexagon/gen_helper_protos.py b/target/hexagon/gen_helper_protos.py
> index 59c8bdd05c..00dddaeb90 100755
> --- a/target/hexagon/gen_helper_protos.py
> +++ b/target/hexagon/gen_helper_protos.py
> @@ -42,9 +42,10 @@ def gen_helper_prototype(f, tag, tagregs, tagimms):
>       arguments = ", ".join(declared)
>   
>       ## Add the TCG_CALL_NO_RWG_SE flag to helpers that don't take the env
> -    ## argument and aren't HVX instructions.  Since HVX instructions take
> -    ## pointers to their arguments, they will have side effects.
> -    if hex_common.need_env(tag) or hex_common.is_hvx_insn(tag):
> +    ## argument and are not vector instructions. Vector pointer arguments
> +    ## have side effects.
> +    if (hex_common.need_env(tag) or hex_common.is_hvx_insn(tag) or
> +            "A_HLX" in hex_common.attribdict[tag]):
>           f.write(f"DEF_HELPER_{len(declared) - 1}({tag}, {arguments})\n")
>       else:
>           f.write(f"DEF_HELPER_FLAGS_{len(declared) - 1}({tag}, "
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 245cd50b89..766995fae3 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_2(cabacdecbin_val, TCG_CALL_NO_RWG_SE, s64, s64, s64)
>   DEF_HELPER_FLAGS_2(cabacdecbin_pred, TCG_CALL_NO_RWG_SE, s32, s64, s64)
>   
>   /* HLX helpers */
> +DEF_HELPER_5(hlx_load_vec, void, env, ptr, tl, i32, i32)
> +DEF_HELPER_5(hlx_store_vec, void, env, tl, ptr, i32, i32)
> +DEF_HELPER_1(hlx_commit_store, void, env)
>   DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
>   
>   /* Floating point */
> @@ -154,3 +157,6 @@ DEF_HELPER_3(modify_ccr, void, env, i32, i32)
>   DEF_HELPER_1(pending_interrupt, void, env)
>   DEF_HELPER_2(tlbinvasid, void, env, i32)
>   #endif
> +DEF_HELPER_2(hlx_copy_live_to_future, void, env, i32)
> +DEF_HELPER_2(hlx_copy_live_to_tmp,    void, env, i32)
> +DEF_HELPER_2(hlx_commit_reg,          void, env, i32)
> diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
> new file mode 100644
> index 0000000000..6525abfb2c
> --- /dev/null
> +++ b/target/hexagon/hlx_helper.c
> @@ -0,0 +1,95 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "accel/tcg/cpu-ldst.h"
> +#include "exec/helper-proto.h"
> +#include "hlx/hlx.h"
> +#include "hw/hexagon/hexagon_hlx.h"
> +#include "accel/tcg/probe.h"
> +#include "tcg/tcg-gvec-desc.h"
> +
> +#define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
> +
> +/* Align down to 2KB. Above and below are unused in V85. */
> +void HELPER(hlx_load_vec)(CPUHexagonState *env, void *dst_void,
> +                          target_ulong ea, uint32_t above, uint32_t below)
> +{
> +    HLXVector *dst = (HLXVector *)dst_void;
> +    target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
> +    uintptr_t raddr = GETPC();
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +
> +    /* A 2KB-aligned access stays within one page. */
> +    void *host = probe_read(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx,
> +                            raddr);
> +
> +    if (host) {
> +        memcpy(dst, host, HLX_VEC_SIZE_BYTES);
> +    } else {
> +        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
> +            uint64_t val = cpu_ldq_le_data_ra(env, aligned_ea + i, raddr);
> +            memcpy(&dst->ub[i], &val, 8);
> +        }
> +    }
> +}
> +
> +void HELPER(hlx_store_vec)(CPUHexagonState *env, target_ulong ea,
> +                           void *src_void, uint32_t above, uint32_t below)
> +{
> +    target_ulong aligned_ea = ea & HLX_MEM_ALIGN_MASK;
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +
> +    probe_write(env, aligned_ea, HLX_VEC_SIZE_BYTES, mmu_idx, GETPC());
> +    memcpy(&env->hlx_store_data, src_void, sizeof(HLXVector));
> +    env->hlx_store_va = aligned_ea;
> +    env->hlx_store_pending = true;
> +}
> +
> +void HELPER(hlx_commit_store)(CPUHexagonState *env)
> +{
> +    target_ulong va = env->hlx_store_va;
> +    uintptr_t raddr = GETPC();
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    void *host;
> +
> +    if (!env->hlx_store_pending) {
> +        return;
> +    }
> +    env->hlx_store_pending = false;
> +
> +    host = probe_write(env, va, HLX_VEC_SIZE_BYTES, mmu_idx, raddr);
> +    if (host) {
> +        memcpy(host, &env->hlx_store_data, HLX_VEC_SIZE_BYTES);
> +    } else {
> +        for (int i = 0; i < HLX_VEC_SIZE_BYTES; i += 8) {
> +            uint64_t val;
> +            memcpy(&val, &env->hlx_store_data.ub[i], 8);
> +            cpu_stq_le_data_ra(env, va + i, val, raddr);
> +        }
> +    }
> +}
> +
> +void HELPER(hlx_copy_live_to_future)(CPUHexagonState *env, uint32_t rnum)
> +{
> +    g_assert(env->hlx_ctx != NULL);
> +    memcpy(&env->future_LRegs[rnum], &env->hlx_ctx->LRegs[rnum],
> +           sizeof(HLXVector));
> +}
> +
> +void HELPER(hlx_copy_live_to_tmp)(CPUHexagonState *env, uint32_t rnum)
> +{
> +    g_assert(env->hlx_ctx != NULL);
> +    memcpy(&env->tmp_LRegs[rnum], &env->hlx_ctx->LRegs[rnum],
> +           sizeof(HLXVector));
> +}
> +
> +void HELPER(hlx_commit_reg)(CPUHexagonState *env, uint32_t rnum)
> +{
> +    g_assert(env->hlx_ctx != NULL);
> +    memcpy(&env->hlx_ctx->LRegs[rnum], &env->future_LRegs[rnum],
> +           sizeof(HLXVector));
> +}
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 195bd6a0c9..2748e26d6c 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -703,4 +703,60 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
>   
>   #define fPREDUSE_TIMING()
>   
> +#define fLVECSIZE() (2048)
> +/* Unlike HVX, COUNT is an element count. */
> +#define fLVFOREACH(COUNT, VAR) for (VAR = 0; VAR < (COUNT); VAR++)
> +
> +#define fLMPY16UU(A, B) \
> +    ((uint64_t)((uint32_t)(uint16_t)(A) * (uint32_t)(uint16_t)(B)))
> +#define fLMPY16SU(A, B) ((int64_t)(int32_t)((int16_t)(A) * (uint16_t)(B)))
> +#define fLMPY16SS(A, B) ((int64_t)(int32_t)((int16_t)(A) * (int16_t)(B)))
> +
> +#define fLSHIFT(VAL, SHAMT) \
> +    ((SHAMT) <= 0 ? ((int64_t)(VAL) << fMIN(32, -(SHAMT))) : \
> +                    ((int64_t)(VAL) >> fMIN(32, (SHAMT))))
> +#define fLSHIFT_RND(VAL, SHAMT) \
> +    ((SHAMT) <= 0 ? ((int64_t)(VAL) << fMIN(32, -(SHAMT))) : \
> +                    ((((int64_t)(VAL) >> fMIN(32, (SHAMT) - 1)) + 1) >> 1))
> +#define fLSHIFTU(VAL, SHAMT) \
> +    ((SHAMT) <= 0 ? ((uint64_t)(VAL) << fMIN(32, -(SHAMT))) : \
> +                    ((uint64_t)(VAL) >> fMIN(32, (SHAMT))))
> +#define fLSHIFTU_RND(VAL, SHAMT) \
> +    ((SHAMT) <= 0 ? ((uint64_t)(VAL) << fMIN(32, -(SHAMT))) : \
> +                    ((((uint64_t)(VAL) >> fMIN(32, (SHAMT) - 1)) + 1) >> 1))
> +
> +#define fABSW(A) (((int64_t)(A) < 0) ? (-(int64_t)(A)) : ((int64_t)(A)))
> +#define fBIT_WIDTH(SIZE, VAL) \
> +    ((uint32_t)(VAL) ? \
> +     (SIZE) - (__builtin_clz((uint32_t)(VAL)) - (32 - (SIZE))) : 0)
> +
> +#define HLX_MEM_ALIGN_MASK (~(HLX_VEC_SIZE_BYTES - 1))
> +
> +#ifdef QEMU_GENERATE
> +#define fLOADMML(EA, DST, ABOVE, BELOW) \
> +    gen_helper_hlx_load_vec(tcg_env, tcg_constant_ptr((intptr_t)&(DST)), \
> +                            EA, tcg_constant_i32(ABOVE), \
> +                            tcg_constant_i32(BELOW))
> +#else
> +#define fLOADMML(EA, DST, ABOVE, BELOW) \
> +    do { HELPER(hlx_load_vec)(env, &(DST), (EA), (ABOVE), (BELOW)); } while (0)
> +#endif
> +
> +/* The helper logs the store for packet commit. */
> +#ifdef QEMU_GENERATE
> +#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
> +    gen_helper_hlx_store_vec(tcg_env, EA, tcg_constant_ptr((intptr_t)&(SRC)), \
> +                             tcg_constant_i32(ABOVE), tcg_constant_i32(BELOW))
> +#else
> +#define fSTOREMML(EA, SRC, ABOVE, BELOW) \
> +    do { HELPER(hlx_store_vec)(env, (EA), &(SRC), (ABOVE), (BELOW)); } while (0)
> +#endif
> +
> +/* Helpers receive .new registers in future_LRegs. */
> +#define fNEWLREG(LNUM) (LNUM)
> +
> +#define fMPY3216UU(A, B) (fZE32_64(A) * fZXTN(16, 64, B))
> +#define check_ilog2_compliance(RESULT, INPUT, OFFSET) do {} while (0)
> +#define f64BIT_SCALAR_MASK(REG) do {} while (0)
> +
>   #endif
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 429317a658..1aa4df7ac7 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -265,6 +265,7 @@ hexagon_ss.add(files(
>       'mmvec/system_ext_mmvec.c',
>       'mmvec/hvx_ieee_fp.c',
>       'mmvec/hvx_qfloat.c',
> +    'hlx_helper.c',
>   ))
>   
>   hexagon_softmmu_ss.add(files(


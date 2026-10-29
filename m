Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fk4TVqos;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zg+g3Goe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYmH-0006PQ-JQ; Thu, 29 Oct 2026 18:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMYmE-0006P9-JO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:39:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMYmC-0001jr-8H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:39:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZW9S1363156
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YocuEL/MHcbauhpGWNPAZ7BH06yFn1kDTYhHfmKwm1w=; b=fk4TVqosHfFg2YZc
 5/otbmz1D80m4DFnbo7eawko1SBZaC9/0+vc8Jok/137B2Xk+N8Wliw6lzjkLE7h
 rR8j0Gdc/TQs3bOGsKS/7oMzHpgQa2RvtT7e7tDJ3T1WSqkIiZzstp5g0sIKMcxN
 oGXl3KHf0qN9/nh5daUN4lPWEuBDqB4sSujoq8723Kswst9sNwZa0fKegBzrM06d
 s6+eWIj26zwQK3s5Zp4kaQUEJUWuhIUeS+4CCMdUmEGkM8twtUsYLArybV0GWotF
 9vOrkYVftcMNA9sVaJfpsHoZ/vLq48P1hhKM+s4KWyYHvlm1BkZueFgglcluvIZg
 e/wbaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg6ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:39:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5365d95f4a1so881541cf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793313553; x=1793918353; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YocuEL/MHcbauhpGWNPAZ7BH06yFn1kDTYhHfmKwm1w=;
 b=Zg+g3GoeG9H5Si3Sibsi6uYsHbwj1org85Xa1woBuN4wlcpnFlD63HJa/knbBw0lDf
 VawrUgFu2YVhcqLmV4OFd39lnxrfl8Vn8xtQGtTh/HHlG9SL3mmF1KhWdCRr7RfckNjf
 eXYc/tkzDkKXGwVioHw4Cxa8cfO2z36ewSgwg/j8SEiO6M1FsrbDjJeZcLEx3ZqoU3w0
 lEyuI41DKgk8BRCgcg2koQ/l6znr3FsVu5qTZKd5/isrUgNOM+zIIG9tYsJzFXOOcRJ6
 uB00MtNFtPVGHE62k1RDj05HaQS4DYWcSLgJs7tsEtrv0XV5ulwqutzyI/clt/2HCRA4
 k8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793313553; x=1793918353;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YocuEL/MHcbauhpGWNPAZ7BH06yFn1kDTYhHfmKwm1w=;
 b=Lgig2iS6MH1OjrJicN3lplf8YM3O+MZO3urzacq8sCX7qrjqmghT0AB3HbfiOrb7Kv
 +VOZ6VRuHDWihbDjWEirVl+R3Kfva6EvHyq3szOrG0peEFgD36QDmZVgPXOBEKCyjNa5
 d4kuSdmgeUbkEVk9vlLAcm9wLlpZJag9ZnTI20AF66UOl07E5gjBhndzrUxVjkw/uuIU
 VMYqFcwqnSRGFN1q89k7QEZizgCA3qxy2y1LTUSDBJZWc6zP+e+KnRqjlkfUBrzJGSd3
 cpuG0JbhRkd0WAkQL5UX80or8SqpggRSssFZFui41UUciXZ8jo0bPz2l5NWHAdgA10yw
 Trxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBywRA27Rih7YxCb0qRixeC+Bkpnkt3xqgZ+OfURIfxbTpTqThGit9oJA8jER5107B6sqgbtpZ6/9VTk@nongnu.org
X-Gm-Message-State: AFq9FYLqjRFMBZ9HPD4O3O2BG5ywO1UASMdo0zWPDFyF5p28GUNYgIhs
 WJby1vVhS6/Iwb8KZL8OSYXXyxgt0D5mHwh6sT9oZ95IN6yiHXVwv5QDpYNhctPPfx0T9wiQr2m
 2NtEu0Co2223OxdPqYvLqqPL1d7n8XsRJVv1Rgh6JBBAq90900uokjf/iVg==
X-Gm-Gg: AYBFou1x5RS2XGrqEgRns9I+x2HitTjI7OCWztA7E5LkdCrVp6DE67LpoHZD3KXl9Oy
 RMGRYqVNAXvdOWpeawzX2v/VEABh/N2iNQfSQnSBAMa89NcL7OlbnJZcCiuWS2FoyLUvP/AG06a
 P6lGU0U3eJJdomkIfI6OMi4HIYxTsFPLZUMqIiKxkCnlEQcx5fcGVR7P+Dak4w1d/0UkGrGTg+a
 3HMzYRjb5YMOIcgDEctMSTq7JHe0qXlRjBsug2IRAKWRku2Hk5qGoHoxuwTjgvI+5cgC3ATQrDS
 vlyCujctMtIXpdqGoY++n+WW5ixEPtkfFRZQ+UHEpE7TBnRP01TI1sW0B4cP4alVB1RIHOYSIUm
 6Tj0APzMBPiReeEVhN2svmsbBpxS6v7Kva177uOup+qPWojn+fgzV+AJKK+KBfeXN471t5hPxVc
 qhl33AJ7kj1E58LyhAwTw8tkCuNqfled9QLevCnWHhxy2icGWznY/d
X-Received: by 2002:a05:622a:993:b0:536:6586:4f82 with SMTP id
 d75a77b69052e-542b3e68065mr8809951cf.7.1793313553133; 
 Thu, 29 Oct 2026 15:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:993:b0:536:6586:4f82 with SMTP id
 d75a77b69052e-542b3e68065mr8809561cf.7.1793313552632; 
 Thu, 29 Oct 2026 15:39:12 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca675888csm810656d6.3.2026.10.29.15.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 15:39:11 -0700 (PDT)
Message-ID: <7cf76176-76ad-428a-9e9f-733bd97088b5@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 17:39:09 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] target/hexagon: generate the opcode translator table
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-5-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-5-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3O3lVxz-uyXrGpWX0oOMrVpGG_K53GOJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4OSBTYWx0ZWRfXymQu9fZxWZtA
 5Efq/ETMI22ExXRXJs6HmFeo2RnFWcXgDU+Mt/jl6PBOZtdUdB6NwW1EeSr3gNfVvrryt/1y3lq
 P7AlASVlCwr5vkJ4nT3f5uU4inOhuvY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4OSBTYWx0ZWRfX/slCC0r4tEu9
 TD/lTsUEMAEHpjSxw6u5deOEWht4XYLAj7kHZoYjJ2OYUcFZBtnOdt3+J5g3rwWM5cpzyTEw7L6
 mtmz07148IRJU1JSUOs1t1SEhXwXiiSt/8w6vDZ/pU+C2mtH/KE4PQtIGarKuw46XLH2cECuHBg
 7oRaJsVLPhZp6X+FJ27iJuioABbhIQs2H/4uGEkTjdFWxGEJCT8pK+UMyqDwmlMTHUSQO/oFQ+5
 iH2V7CTLZLZJncCoWHsSJU9ST5otTrD5dWISBZ77PwiQ8UuckQhEG5lc2N1m3naM/qxC/bhN1xz
 j3oBQib4TuarFzpuwEsf6+YJgwsOUgPNITuZCbcs93pklu9F21pHsDIV00/JQJhqm2tlyIOk05s
 o9vhgifD4mOwsRFk4yUeHYT/rh3P+0uRyTDHFBBXR/lhfmLMkV0Bm25b7bif5v+Kw3WvyDak+4w
 mcUPlvMXymHyUCU+i5A==
X-Proofpoint-ORIG-GUID: 3O3lVxz-uyXrGpWX0oOMrVpGG_K53GOJ
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae3cb11 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bL_POnTFyjDyxVHKGd8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290089
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
> Generate the opcode translator table instead of listing it in genptr.c.
> Skip empty translators and inline the helper slot value.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/gen_tcg_func_table.py | 29 ++++++++++++++++++++++++++++
>   target/hexagon/gen_tcg_funcs.py      |  4 ----
>   target/hexagon/genptr.c              | 15 +-------------
>   target/hexagon/hex_common.py         |  3 ++-
>   target/hexagon/meson.build           | 11 +++++++++++
>   5 files changed, 43 insertions(+), 19 deletions(-)
>   create mode 100755 target/hexagon/gen_tcg_func_table.py

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
> new file mode 100755
> index 0000000000..ba56ede568
> --- /dev/null
> +++ b/target/hexagon/gen_tcg_func_table.py
> @@ -0,0 +1,29 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import hex_common
> +
> +
> +def main():
> +    args = hex_common.parse_common_args(
> +        "Emit the table of instruction translation functions"
> +    )
> +
> +    with open(args.out, "w") as f:
> +        f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
> +        f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
> +        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
> +
> +        for tag in hex_common.tags:
> +            if hex_common.tag_ignore(tag):
> +                continue
> +            f.write(f"    [{tag}] = generate_{tag},\n")
> +
> +        f.write("};\n\n")
> +        f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
> index 61effa38cf..4305eda996 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -173,11 +173,7 @@ def main():
>   
>           for tag in hex_common.tags:
>               if hex_common.tag_ignore(tag):
> -                f.write(f"static void generate_{tag}"
> -                        f"(DisasContext *ctx)\n")
> -                f.write("{\n}\n\n")
>                   continue
> -
>               gen_def_tcg_func(f, tag, tagregs, tagimms)
>   
>           f.write("#endif    /* HEXAGON_TCG_FUNCS_H */\n")
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index d0aabacf35..fd3f6a1edf 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -752,15 +752,6 @@ void gen_vframecheck(DisasContext *ctx, TCGv vsp)
>       tcg_gen_mov_tl(hex_gpr[HEX_REG_VSP], vsp);
>   }
>   
> -#ifndef CONFIG_HEXAGON_IDEF_PARSER
> -static TCGv gen_slotval(DisasContext *ctx)
> -{
> -    int slotval =
> -        (ctx->pkt.pkt_has_scalar_store_s1 & 1) | (ctx->insn->slot << 1);
> -    return tcg_constant_tl(slotval);
> -}
> -#endif
> -
>   void gen_store32(TCGv vaddr, TCGv src, uint32_t width, uint32_t slot)
>   {
>       tcg_gen_mov_tl(hex_store_addr[slot], vaddr);
> @@ -1855,8 +1846,4 @@ void gen_add_sat_i64(DisasContext *ctx, TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>   }
>   
>   #include "tcg_funcs_generated.c.inc"
> -const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {
> -#define OPCODE(X)    [X] = generate_##X
> -#include "opcodes_def_generated.h.inc"
> -#undef OPCODE
> -};
> +#include "tcg_func_table_generated.c.inc"
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 94e70b8657..a4807bed7b 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1520,7 +1520,8 @@ def helper_args(tag, regs, imms):
>       if need_slot(tag):
>           args.append(HelperArg(
>               "i32",
> -            "gen_slotval(ctx)",
> +            "tcg_constant_i32((ctx->pkt.pkt_has_scalar_store_s1 & 1) | "
> +            "(ctx->insn->slot << 1))",
>               "uint32_t slotval"
>           ))
>       if need_part1(tag):
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 0633852321..429317a658 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -42,10 +42,21 @@ hexagon_ss.add(semantics_generated)
>   #
>   # Step 2
>   # We use Python scripts to generate the following files
> +#     tcg_func_table_generated.c.inc
>   #     printinsn_generated.h.inc
>   #     op_attribs_generated.h.inc
>   #     opcodes_def_generated.h.inc
>   #
> +tcg_func_table_generated = custom_target(
> +    'tcg_func_table_generated.c.inc',
> +    output: 'tcg_func_table_generated.c.inc',
> +    depends: [semantics_generated],
> +    depend_files: [hex_common_py, gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h],
> +    command: [python, files('gen_tcg_func_table.py'), semantics_generated,
> +              gen_tcg_h, gen_tcg_hvx_h, gen_tcg_sys_h, '@OUTPUT@'],
> +)
> +hexagon_ss.add(tcg_func_table_generated)
> +
>   printinsn_generated = custom_target(
>       'printinsn_generated.h.inc',
>       output: 'printinsn_generated.h.inc',


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fGD3ee+O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZOuH25Fc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwyW-0000Ax-Tl; Thu, 22 Oct 2026 13:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJwyU-0000Al-Ew
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:53:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xJwyR-0004ee-D1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:53:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MGOVom159826
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /HqquRtHBzNT0bXB5mvembCQzjGVTxujWLbZyK3yx1s=; b=fGD3ee+OAYqo+bY4
 XKdA++YoAkBqj+33UOKBhftptEzZbEe/sJYV5T5i1ShIz77CMo21wY3sA6EsqvC5
 moDbD+JjSYozSZe5XlypmU6UxD31bn/P17P3CrfL1ld7+348a2UnwOczcLI6nXWv
 o1r6A4miVMK7ceAfPfakU0wPgJtvSNCKyMbt7NooB3ioJ6CSDUdotYOmDeBsbAT7
 BVC5taa51vJa2IVPG4XEta3xIWZBzHhhhBf8kyI0upCmBmgklzGkr05wFQXoVCEZ
 v60naIB+N0zVdlMM+rLABKpn0XsCbhKBJkqlSOp7UeTRnuThuUYuWDZyJZAdZ5FI
 9D6+kQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw0cyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 17:53:05 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4dab94dc3e7so235343b6e.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691585; cv=none;
 d=google.com; s=arc-20260327;
 b=i9KY+5hXA9Gtn/v/HRIPStL7fjSFl8nx3jcTVNCJ5S+dSAPc6b6POvPyMoDQXxeEyd
 9W7c5/vf0hQSdACX8/DXbG+Y/IdSGg3iML7dCSAvu5X67V2ETgsGPfAjI9irfzzvPU/u
 tpRTs4WPsmGWjycKq6D5kW7qSBWwIEaMb8SrdOlMcsWGspMv05rAivHJIWXdJyOtK09l
 MzkyWFPY4qifjB+IVIOTzDrC50TXnUwpgDPyqd9HuvzDWqgph5TWBh31LnjYny4oTNtq
 2ewZCnYNCVdR4ioqCpvSt1uaOeZpn40ClzoAyIRIADRkogv/b7dEPGjjCdJTGB3JRUL/
 Tjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/HqquRtHBzNT0bXB5mvembCQzjGVTxujWLbZyK3yx1s=;
 fh=91Qh0CwNy7hz/SABiv0vN2wob3TmMO2eFI2qsEc3U8o=;
 b=E6y6j1hCp9KrSXRdXnDMAla3J0wKYpeEoSBUuAiMBsCLTtMD+BO/taxlwOc77yA3cL
 5XeGJR3eASuNJo/rIQ24Nx5iUpYY65ZDN02OhJdzeJGUV4Ypzkvh72B4VghSji6JcEau
 eyBkGszMl81fYZQT9yPnrgTGQqirClwNIVBwnc3JkKgofhuR/INiDtyCYr3ygEmBKYRA
 IDkGMOxFLwpyVMjSLzeuYNDJoF/ULdEP40j4XfKym2nMNtusv7Hej8LEwrIzN8j6pS2x
 +I2PQ7Znrl8UuaJ+WZxpsFmsjaMDOtf3QYLUZkvaWINGstF/DO9BbGTGai8IkUhG1cs0
 BzMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792691585; x=1793296385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HqquRtHBzNT0bXB5mvembCQzjGVTxujWLbZyK3yx1s=;
 b=ZOuH25Fc2tT7SCrZCAN7V2/h9DWbGCdjCCupgnNvdOVh9x6kSY0z14wheShk662N5T
 gpz3VivQN+q6AnhDwzbArifVWRvMJgUNh5+MaPwNTMWWwP/TPv29PhUGrYQVQd7ISnJu
 zgZDDdEv7aE1jNZcW3fLCem0vxbeVKDqyNCdGGA1vorQRGyQaxRpOO62kxHjyDjkMq9b
 Vef5imLj3QV8TOL8W2w45ZAHcOffIfU2USU2YIWj7reGysDljY/HgtFEIPUK8+dmMveW
 KAnlK6Wb5mjM87nWHeymLctSdUlFKsSno8mP483f8lM9KHMgIDQ9VxDMlUPPjoRGjNBh
 v0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691585; x=1793296385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HqquRtHBzNT0bXB5mvembCQzjGVTxujWLbZyK3yx1s=;
 b=YAjtBuinI17QehSImhL2fKxBCq1UVC1eL3B+wbIYnwZorGzMFSrCWjaQq54zK9s5u1
 FnWeFg7m0FVd3kUZxE9wjN0C46vzDu9nXi2KQ5ZDB7RXpnOK67EMho+oYLEWJ26/pllR
 vaeLHfKA6ipw1FsRfpHl57wZ6OMIG7iNRGS8yoc5Xt1YKzzm5fWlZe7QnQBl3A12Mtho
 YQ0y77gpHmG+XzrVzGZUwJDRHhYk29R9VWtYfVHPJ2GgplSbWONxDcbXzzIMOhB0S+gI
 btQy0pvkoAkg3qBRKyATrEL1biGFzACGgUv9KH5TgevgW0c/G/UZCNzBN2akIQCINgpZ
 xZrw==
X-Gm-Message-State: AFq9FYJZgaEOeqq47Y1Gm0ri3a8KiWIgNOUSWsZparfYri2Xup2xYdvF
 yft/isW3IbPqvx8Qhyvk8466a1VDb6xLEG8imZs65Sfzu0Sxbpxlb2nxTDBUNE99A4OifcE/k77
 +w8E5Q4z1mL4q3Ipa7zkJtiLv9s53Q34GexIs4m+oPq+CYLhuaAKSwfgxb4Oe4064ue3E+8hmix
 DVnXaUfajYeOoWAuNkTWpLKJ0rR0pYUa4u
X-Gm-Gg: AYBFou1vP/B667Y6yLV/rSpCCYzrRhfE+MEydGeR4UFMRbeNDRFuMAcSyPB77gQn1TW
 wRYzJ0fPJ2nFExEq8x7kXTP4WE8sit7pJTPc1TWYKyvEJJxwcHAWtAOkMOjudQR1sLmpStKss9/
 3SoQtKH+3qEX3HSnVz1C9I9SAaBWN+CAyQ/oRpgJ8th9Q78OcJiGk6c/oMrioeQ7tX/H/CLPCdi
 Bg2CWzkgXYHFUOFRsU=
X-Received: by 2002:a05:6808:159e:b0:4c5:12a4:ec8a with SMTP id
 5614622812f47-553611f9d25mr4994518b6e.36.1792691584636; 
 Thu, 22 Oct 2026 10:53:04 -0700 (PDT)
X-Received: by 2002:a05:6808:159e:b0:4c5:12a4:ec8a with SMTP id
 5614622812f47-553611f9d25mr4994505b6e.36.1792691584108; Thu, 22 Oct 2026
 10:53:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
 <20261021224421.3786109-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261021224421.3786109-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:52:53 -0500
X-Gm-Features: AclHuK_5ElkIKc4poRdytHh79dtNA1teybgnPZLQiu5vzf_CvRqCY6I8FnoooWI
Message-ID: <CAJ+KCYOtUQW-cK6MY+gjE9L3Eo0-Uof_1dmx5TXSo3FErDxKqw@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jvyeruPqvn-jF5uLCqzodNRiJMHVQjXF
X-Proofpoint-ORIG-GUID: jvyeruPqvn-jF5uLCqzodNRiJMHVQjXF
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada4d81 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=WrOmP3KnlklZZN6DtfIA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MSBTYWx0ZWRfX2th6nIpyi1G7
 Ci+iENSATv9vV+t+QmVnJjQzD9px7YefcjBmiAwqiil6fdsOYQ/ZbSfGzJBkh01UT0BwMtiCkWD
 y/wojIYExPNBiBEPUZxLfSEGsie9DkA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MSBTYWx0ZWRfX7Jfev3neb7r7
 vMzRr3eBoKzfVCOkgjIAxooZPrthBnsaPTS8tDAlAhjIkEQAg2Tw4waVtLszwhwzSaa3PeQ8k60
 H1LvFsCIZkGC+sBw3tqYX+mGQew3F6eiIizSd5J/ZfeowZ2LWomowe/OTFqdYiyuMQ7RJhT0cMt
 BHNgYDXxQrFqOBq62mvMHrJuvp12Q10sG5fc/ZWOuekj5hqnHbNglZvv6Nke9fbw4yI+iaH9oRm
 TTkTotNJlz8M593JrLsn3hnt0cVejREzxJdJEGd/2gvokYu8Q2jqy03t2lShEcWDyS4Vxhy0nVN
 r61L22sjv19dwqkP39JHu8l0rHMeyNbA29s8SszRhhw6XfPk2R2SGMy+Sl3uGLFfiotJwyun8ZS
 wU1kWgGDzoNBWb1Sw0v6EoETS+LyIxkZ8ZAgfJoda3S657/d1NiVqcN5KPpzZR34wQgqXZ4n8uW
 Je91yAh3/2z1sa+FLTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 5:44=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add decode and translation for trap2 and the vallocframe and vdeallocfram=
e
> instruction forms introduced with v83. Model vector stack overflow as a
> precise exception and report it to linux-user as SIGSEGV.
>
> Teach the IDEF parser about VSP and vector frame checks. Describe the
> vallocframe and vdeallocframe instruction semantics in system.idef, and m=
ove
> the vector stack overflow check into a shared TCG generator helper.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h                   |  2 +
>  target/hexagon/gen_tcg.h                    | 51 +++++++++++++++++++++
>  target/hexagon/genptr.h                     |  1 +
>  target/hexagon/hex_regs.h                   |  2 +
>  target/hexagon/idef-parser/parser-helpers.h |  1 +
>  target/hexagon/translate.h                  |  1 +
>  linux-user/hexagon/cpu_loop.c               |  5 ++
>  target/hexagon/cpu.c                        |  2 +-
>  target/hexagon/decode.c                     |  1 +
>  target/hexagon/genptr.c                     | 21 +++++++++
>  target/hexagon/hexswi.c                     | 25 +++++++++-
>  target/hexagon/iclass.c                     |  1 +
>  target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>  target/hexagon/translate.c                  |  2 +-
>  target/hexagon/tag_rev_info.c.inc           | 10 ++++
>  target/hexagon/gen_idef_parser_funcs.py     |  2 +-
>  target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>  target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>  target/hexagon/imported/encode_pp.def       |  5 ++
>  target/hexagon/imported/system.idef         |  8 ++++
>  20 files changed, 166 insertions(+), 5 deletions(-)
>

> +#ifdef CONFIG_USER_ONLY
> +#define fGEN_TCG_V2_CHECK_AND_WRITE_VSP(VSP) \
> +    do { \
> +        TCGLabel *write_vsp =3D gen_new_label(); \
> +        tcg_gen_brcond_tl(TCG_COND_GEU, VSP, \
> +                          hex_gpr[HEX_REG_VFRAMELIMIT], write_vsp); \
> +        gen_precise_exception(HEX_CAUSE_VECTOR_STACK_OVERFLOW, ctx->pkt.=
pc); \
> +        gen_set_label(write_vsp); \
> +        tcg_gen_mov_tl(hex_gpr[HEX_REG_VSP], VSP); \
> +    } while (0)
> +#else
> +#define fGEN_TCG_V2_CHECK_AND_WRITE_VSP(VSP) \
> +    do { \
> +        TCGLabel *write_vsp =3D gen_new_label(); \
> +        TCGv mode =3D tcg_temp_new(); \
> +        tcg_gen_andi_tl(mode, hex_t_sreg[HEX_SREG_SSR], \
> +                        1 << reg_field_info[SSR_EX].offset); \
> +        tcg_gen_brcondi_tl(TCG_COND_NE, mode, 0, write_vsp); \
> +        tcg_gen_andi_tl(mode, hex_t_sreg[HEX_SREG_SSR], \
> +                        1 << reg_field_info[SSR_UM].offset); \
> +        tcg_gen_brcondi_tl(TCG_COND_EQ, mode, 0, write_vsp); \
> +        tcg_gen_brcond_tl(TCG_COND_GEU, VSP, \
> +                          hex_gpr[HEX_REG_VFRAMELIMIT], write_vsp); \
> +        gen_precise_exception(HEX_CAUSE_VECTOR_STACK_OVERFLOW, ctx->pkt.=
pc); \
> +        gen_set_label(write_vsp); \
> +        tcg_gen_mov_tl(hex_gpr[HEX_REG_VSP], VSP); \
> +    } while (0)
> +#endif

The definitions of  fGEN_TCG_V2_CHECK_AND_WRITE_VSP exactly
match gen_vframecheck from genptr.c. Maybe we should call the function
from the macros (and remove one of the macro definitions)


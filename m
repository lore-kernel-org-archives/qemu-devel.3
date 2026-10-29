Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ew5EXgSB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HD1l2FNn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW1A-0006qf-EA; Thu, 29 Oct 2026 15:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMW18-0006po-5y
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:42:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMW16-00087h-4T
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:42:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJ2dRm4159536
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XlGzq+nFzG7DZh+rohpT8/k9MHXOAgpJ2TgGuZKazls=; b=ew5EXgSBqQhIW5ml
 tnqzIMAE3ojmbNBbORboSbyQLtdsPLeOcgxDa/hPs78gec3ss0pbHeel/mkAxCnh
 7z/AUmbw08RLKP5JJhX8228wrpFvUCRorlxCHWtOVFSfJ0igX0jM6hpQ9m9/PsjP
 5yqjb4wIrfm7gKxf3Fjjtq7z9sNhAifDfepw2h1dxatHDdmqPRG/sirIGLPuvkcY
 PBf4UBXEuHe+XYdYtXwFef/CK4xNZz+GYj/sr+dM5IPhvCLDtjsRKXatL84x8t/u
 wKeFJdoyk4qwi+zO+epA5soAtkEa8X2JRXod7qoW20Y30PrmDuupf5wvgs5RuL7n
 5TXwug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmby38632-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:42:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-537548d4bc0so59692491cf.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793302945; x=1793907745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XlGzq+nFzG7DZh+rohpT8/k9MHXOAgpJ2TgGuZKazls=;
 b=HD1l2FNnMwFOtzRq38xlOVApgxNpttct33TnFLvG0i7aArqqvUgr37elUcXxggj5JO
 s1G9zbHYf3FI+leQofj9QNGfIaBR4c0BbIDpjh2f7rTIH2dXJif1lXH5L+IUyuuvTgRT
 MxuvqH8wyqcm4xNYJAS5jkz7A2ZSd357k48EGpRjL87WBByDf0HFvTkw8/uYyR4ldq1y
 C4X/pejL+06cFA/KUhMHwNR7wKrTY0etrU9GesaKlHpJd1DAEXiL3jXBql9F5tDURD1V
 yxUXClnWi8Gs5i/H8reQ8kJM9oRXov1wxVSi+2xvPiBpUh3T5NqvjWLI9G5CFgm0Q75M
 c1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302945; x=1793907745;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XlGzq+nFzG7DZh+rohpT8/k9MHXOAgpJ2TgGuZKazls=;
 b=oSGnZ/fTS2lbGr0PvVri9HLe/D2MdbrpIk50HO6/kKQW5iy7rQT8+R8l/X0x/9SrHX
 jmqQ3ecC7efWgQ5b6wSL/gTmcSxJVUSNRKBjFqtKG8W/fmwKghjHHFGmtl1H7ZsJNqgo
 3qajytsCxoxIi54k8b2Q1veIYhJOr/8teuY/R5O62w42T3iR0brCrUTKSYPAj85NpQWw
 NEeWl0smIfg49RCbungwCA0ltPX59kO7oH8Vw32HhGvWeva7M70CJkyCA/Gu+WcA+ysk
 L/KNjw06sa5xelYo73Jx68k/5IJ9OpSAFlGMVH7U3M20iQoH2lDiObW76ZfUlAj4L5jL
 0g8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmyvY/23k8Bx87pZOV6xv1aVTT7xy4GWkiSmD8ShpiW0hHgLwflx1sSFGH9UWM5YgsEfTfDF4kwCu5@nongnu.org
X-Gm-Message-State: AFq9FYLKzSKSjLtLa5ojSUJ54i0lnTCDDweyB4BR92vrd1xA3tj2sOI8
 /mMcjkONJalTVLdvEn7QMK7zW92MsAyYu6yme42nIDKXPEnJELvfykqUuGQ7sgXsLqxB+ZB3ixH
 GgPr5Mo/qavgMumXHnj3VoRoSKh6PTynDUABWZXPo/23NEZhG6g8nqZC94Q==
X-Gm-Gg: AYBFou18eT7fHnwmgnbcE/mvOhR1Rdj44GFQ42NTNPVS4+snXGVj8fS5C6HQphglLcm
 afnwglSQB0mshzdjJ1AULTx1EvdC2J1BQQoUQcQVCvSvw35n9XrhwrBQBME65pHAiASw/2tVHZ5
 BkR2RDUkMPFteWMyjzfW4OOzj+9pZBpW1m2mYnSnIN0jn5M62+FYeYVqz+4JeMKv6d5DGXVrGNl
 j/N4sdNFLqzVVHtw6+GI26tnzTbgq9x1jd/Wm5hM1c5ybzBXahVSpl5LGP8nBrOL3lIWYIPEgaT
 0LmOTUc6XBLSq4/pewwil568rHpBzwZ/DfpMY0fotA3gF8zQ/rnw5l3zeGRWls6B6leFO/obpaf
 LI3EDTQQsrLcmiLT15WhT8lWOsvNFZxepoEFlyZUH4lwnEFagHFPbVpR9wpkGEXP/+tza5wJh30
 OALoa0wu+aiF3gUhroRTzaXNR+NbCyxV6C8HTVQw==
X-Received: by 2002:ac8:5fd0:0:b0:533:386a:edca with SMTP id
 d75a77b69052e-542b639bf3amr1329111cf.16.1793302945026; 
 Thu, 29 Oct 2026 12:42:25 -0700 (PDT)
X-Received: by 2002:ac8:5fd0:0:b0:533:386a:edca with SMTP id
 d75a77b69052e-542b639bf3amr1328881cf.16.1793302944598; 
 Thu, 29 Oct 2026 12:42:24 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542a4fe1495sm2137201cf.21.2026.10.29.12.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 12:42:23 -0700 (PDT)
Message-ID: <2cd017f1-09b7-4e40-91ea-54baa89e1d39@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:42:22 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] target/hexagon: add HLX attributes and exception
 cause
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-3-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-3-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfX7copJ+MqIuO4
 RwdVgbVKMTnLkJBIZwknclgVByxhykAJBj/p6SuHvlx5q/AmmDW8/pDgsRGMvPbXMqR5SQl6Hf3
 v06Obhtzm1YJuojsL7eqS5PQY7xeq8k=
X-Authority-Analysis: v=2.4 cv=ZvN4uN7G c=1 sm=1 tr=0 ts=6ae3a1a1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mom8MH0z6KcibJbK-IMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NyBTYWx0ZWRfX0VnWYW9HxetI
 gQu++HNgexviXPoKnsqI0a64Vc25FdPfnmHnWWwRGtNdXS0zG0VjDFDZGwzVX5QsBrbwWMrNnI6
 kZ4u/gGW7rmxdFeBEbwlx1+WhTb0K2bT06H5qI1d0+WOItHd1/2g241QLOkfgGT9TD+6c4dyyBz
 VKJAqJXDQDR5JoMzdeOQ2sGUWk4hF+rRCWXUD/qRP3swH0f8NU/T+S/YNjPxmnuipEswMJwi03q
 gQcrFezoAusHwBWrab8zQ+osuPaDsMHIZkWgO72SkOfZM5X3jjBau/mVzBNmd5oZPL+tinFsVxH
 0Aw1xyAJ4q7a6xzNYtUaY+ovMZ/Raa2206F2INHecpgGG8MRxyjtIx6xqJTYsuEuUPJlKWWrsft
 WzP0QbaP23Q8gY+TKeAG8gU6FPUI8y1+PDMjKcGduK25fFtL3D3NkvASxrzd9FUjMUfgzLOB5NI
 ze6Ri2L5raocnxfHINQ==
X-Proofpoint-ORIG-GUID: iXkVqTBr45MkWisU9FR8FnwN0e7f2RXH
X-Proofpoint-GUID: iXkVqTBr45MkWisU9FR8FnwN0e7f2RXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290077
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
> Add HLX instruction attributes, a packet flag, and the
> NO_COPROC3_ENABLE exception cause.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/attribs_def.h.inc | 18 ++++++++++++++++++
>   target/hexagon/cpu_bits.h        |  1 +
>   target/hexagon/hexswi.c          |  1 +
>   target/hexagon/insn.h            |  1 +
>   4 files changed, 21 insertions(+)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
> index 96ad1fd2f8..a02261ee5e 100644
> --- a/target/hexagon/attribs_def.h.inc
> +++ b/target/hexagon/attribs_def.h.inc
> @@ -69,6 +69,24 @@ DEF_ATTRIB(RLS_SAME_THREAD, "Store release with the same thread", "", "")
>   /* V6 Vector attributes */
>   DEF_ATTRIB(CVI, "Executes on the HVX extension", "", "")
>   
> +/* HLX attributes */
> +DEF_ATTRIB(HLX, "Executes on the HLX extension", "", "")
> +DEF_ATTRIB(HLX_MEM, "HLX memory instruction", "", "")
> +DEF_ATTRIB(HLX_MPY, "HLX multiply instruction", "", "")
> +DEF_ATTRIB(HLX_SHIFT, "HLX shift instruction", "", "")
> +DEF_ATTRIB(HLX_COMMON_ALU, "HLX common ALU instruction", "", "")
> +DEF_ATTRIB(HLX_PAIRED_ALU, "HLX paired ALU instruction", "", "")
> +DEF_ATTRIB(HLX_ANY_RESOURCE, "HLX can use any resource", "", "")
> +DEF_ATTRIB(HLX_SLOT23, "HLX can execute in slot 2 or 3", "", "")
> +DEF_ATTRIB(HLX_NEW, "HLX new-value instruction", "", "")
> +DEF_ATTRIB(HLX_TMP, "HLX temporary register instruction", "", "")
> +DEF_ATTRIB(HLX_CU_SCALAR, "HLX scalar CU instruction", "", "")
> +DEF_ATTRIB(HLX_SCALAR32, "HLX 32-bit scalar operand", "", "")
> +DEF_ATTRIB(HLX_SCALAR64, "HLX 64-bit scalar operand", "", "")
> +DEF_ATTRIB(HLX_LXX_MPY, "HLX Lxx multiply operation", "", "")
> +DEF_ATTRIB(HLX_LXX_ADD, "HLX Lxx add operation", "", "")
> +DEF_ATTRIB(NOTE_HLX_MEM, "HLX memory access notes", "", "")
> +
>   DEF_ATTRIB(CVI_NEW, "New value memory instruction executes on HVX", "", "")
>   DEF_ATTRIB(CVI_VM, "Memory instruction executes on HVX", "", "")
>   DEF_ATTRIB(CVI_VP, "Permute instruction executes on HVX", "", "")
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index c9ba09989e..65dda2175d 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -79,6 +79,7 @@ enum hex_cause {
>       HEX_CAUSE_INVALID_OPCODE = 0x015, /* alias: same cause as INVALID_PACKET */
>       HEX_CAUSE_NO_COPROC_ENABLE = 0x016,
>       HEX_CAUSE_NO_COPROC2_ENABLE = 0x018,
> +    HEX_CAUSE_NO_COPROC3_ENABLE = 0x019,
>       HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
>       HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
>       HEX_CAUSE_VECTOR_STACK_OVERFLOW = 0x01c,
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index fb46c05360..f18ecaae42 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -923,6 +923,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
>           case HEX_CAUSE_INVALID_OPCODE:
>           case HEX_CAUSE_NO_COPROC_ENABLE:
>           case HEX_CAUSE_NO_COPROC2_ENABLE:
> +        case HEX_CAUSE_NO_COPROC3_ENABLE:
>           case HEX_CAUSE_UNSUPPORTED_HVX_64B:
>           case HEX_CAUSE_VECTOR_STACK_OVERFLOW:
>           case HEX_CAUSE_REG_WRITE_CONFLICT:
> diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
> index 5d59430da9..5751c9ced9 100644
> --- a/target/hexagon/insn.h
> +++ b/target/hexagon/insn.h
> @@ -71,6 +71,7 @@ struct Packet {
>   
>       bool pkt_has_hvx;
>       Insn *vhist_insn;
> +    bool pkt_has_hlx;
>   
>       Insn insn[INSTRUCTIONS_MAX];
>   };


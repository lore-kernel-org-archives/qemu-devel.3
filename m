Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE13606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fXk5Yvdr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j6laNu6W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaIU-0000E0-J8; Thu, 29 Oct 2026 20:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaIS-0000Dl-8F
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:16:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaIP-0001jT-OP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:16:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKXE8506071
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRN/bOTSE76ILQeKL9PhslowwJ115b/+fubK60gmBao=; b=fXk5YvdrYFYZupBe
 lX6o62ev8LM2h1zEjCJi+6e3ehmnD8ighDiy3Qe2y4toGvKC/uBB9EJ6Aao4QB2E
 QvxsDiPvLzFHmyvYbn54pZTyOJEpIU75JvxQEx0QTm0IcLgr2rDZUyYdrRoQj5mN
 CyadqLhAySniGbY2kdz0yxD8NE3BfT/rbLx/o0sfAlZ7DTVPwpNtob0ZsleRPvws
 EjN0DA8li2+LBrmXfXrndikVfuBzVBNJ/eILZhzCy0WiwmIifKXQ6utgedokpoSL
 Cucabx2bVru1AEUEqrtzorhyiZi4LVsDaH4DWUAuWs20KfIRVB3lyzfqsUF5NPPw
 z4uo2w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p0ff1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:16:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338c215ed2so1887411cf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793319394; x=1793924194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HRN/bOTSE76ILQeKL9PhslowwJ115b/+fubK60gmBao=;
 b=j6laNu6WTgbHLwRpGlvAil/sXdC1rWYgCt0IQ+9dF4Ko2bR9qPAt67YE7i0ihP9uO6
 /5nOgt/Rimxs9jvTAy5NadzmQgHJIQx23D4GczEJI/XfCBQVx8E+BIRQ4BEPgQ4tPrg+
 zOk5vscSYV5RjMkH2c/AH9gOPhL+g3yEDl+lRJTkanI+PuBe71DsZperdlDSueK8IEXD
 BDVOl2+0JzQJ+vcUvxa/GXfw6fcz1PIw420oFISwo0bmxh6tRBhzzLio/7L4L2CEnAry
 GBPu9cxQa9Xz9jQ32VjmRTYoF0kwLDmSDXIxjtQ2XBO6kvOMr68HhKLeuPuM0QbPQmSU
 xWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319394; x=1793924194;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HRN/bOTSE76ILQeKL9PhslowwJ115b/+fubK60gmBao=;
 b=C3/yb9u3pxv1N/YFXiKeqxBPYlxd/qGAozueVmUGEA29gDazO5KkVCXKTcLR/pW9/w
 sCV3blm/d8rOZ0seaNDiQwBfH7hTRFj4OXybHJexpTDtGl2VoBaXh3snZt0yZ35eBm8/
 hvgEEZDswfuF990Ge1GDX5VsslBadn+3Bo+oMNXcoXx2efD5vjZ2CPXC+1kMoPeO7K5c
 SZJoe6EF16expX/zpXZp1jO+lGZa1i2iD0Veij3o1OYT/zUN0RIJeTIBgdJaBMyIgUzr
 qsPh85AzkDuyt7GjlKgyPjkst+FqADo9J/AjCOM2mCF21B1kuKfvWdTtLYB+H2ODCXmv
 SXHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJT2q8ysFb0iyi4x1NYw4C4CAH5weHQbK3ZSliF3lF8xwswYhrF8uRJHPnVbT/cNkmBbMwuGRJ/CD0@nongnu.org
X-Gm-Message-State: AFq9FYLSIOdubY/zEjPsCpQBtd80ZeTAYi5LIFwUsrcZPr1STK4oeaKV
 +Vo62JEMH77H0lHFIej9lN5T/1RXj8ibDtapxmeWwLqKJPjkzvkwLwKSMf8pZHQQnnVI/suWYjK
 4oLTqSPBTj8HBkYX6wwpdxWrwnWbw9PlEgjzdaUWQ97ndYj5gOST4wY5qEQ==
X-Gm-Gg: AYBFou0FRKMpEMJKi2hCEFckJDI2cXPovaF68L01M0AQT3Pvlu8tO3+Te5Ftheb1L55
 dQRNfD65W3hXaiBQE8YJmqhSjZe/BKBwlnnWz4ZGFTDtEFAjHGfpbzEyr53isGQECLU8aR3Rcis
 vbBZxMr2KHKWOtNMwrYkxaA+tZ6QAWTcITYSdtKo4h1tO8rlXEgZhEMPU2aLhgsmTNimoJ15lUy
 pkmK6a+j7e5MsYnJD3e55h7c3S8zZmTuNN3PQm42qBQ/SFgt4BNWe376Aop6u2/r7fdX59P5pPL
 4Wa3XUu1MyfMlOVGd4tXl2O1nPtAbr32C2sa6G//zcCN51dcI8lJ/A76N6ws3uH8udsCYpPfd20
 zT4kZHvE2OS8ESWfbpRe8CXMdU9gz2hpEUBkwYWyT8GitcVqVKfakCqVJkL8zUPKGFWSdaO8X0B
 lVSOug3A0HHSZfcpO6kFiqaVr6fgbvs86uK2inUmgmmDcKz6CKAvUv
X-Received: by 2002:a05:622a:2b46:b0:535:f9db:4567 with SMTP id
 d75a77b69052e-542b88d3b8cmr10384441cf.64.1793319394134; 
 Thu, 29 Oct 2026 17:16:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2b46:b0:535:f9db:4567 with SMTP id
 d75a77b69052e-542b88d3b8cmr10384111cf.64.1793319393456; 
 Thu, 29 Oct 2026 17:16:33 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542f6ef76f5sm1087611cf.12.2026.10.29.17.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:16:32 -0700 (PDT)
Message-ID: <e4855212-5011-469c-a4fb-c1f4a15fbc38@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:16:30 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] target/hexagon: add HLX compare and average gvec
 operations
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-10-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-10-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMCBTYWx0ZWRfX81CGyQG7ewaf
 +dZtUraToAzLvmv5iNERVagrnty0j3+uni8jJPZmqhBt5uUC6ClXMm5j/puM+sVcO4Jyr8wdxRN
 LHFZqbOtMApiNiXUMuMKlGtBz9aVAf/etA8cwbwchdVIYLTyInmaWC0nKspZHpVLgHKFKP+mc43
 KTEoPYPPets71P1DwKYK4yEP4WGdhUJksd2a9JCtCCmIYwmrfqa9DQXJ0DXmaMdt+f63fYK9ZiI
 QuGKsp/6TOnu1KLWKklzzAe5726JBzhZZXxINbpqYZcWaitPoiB5sW5MkZ7ZijKLLe5jdzwNypT
 0tB40KWdtn5+Hq8L2fuOGvKlTxbNUjDwNHXpaPyT8w31xI0O1Ae7GXYRlWltULmz5B2Vlgz4uew
 ex0j3/hohyo63HI29eDkqFDsDazoBaXaarU/TI3j0Qxmu1tFLMC1OW4w4K7hPMk4a0cKLupW177
 wMADXI8/sNJUJpzPYMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMCBTYWx0ZWRfX1sDwPQGBCDaR
 r/cvz56eTJWPdFGxAJ+wF3P+1CHJcZSIg3mPwN8+4irMkMDvCdV1lLIERSBqpNlIXIrf+hKQGsN
 srcBVyMjMuqs/WFmUb6AZoBfkm4cQHk=
X-Proofpoint-ORIG-GUID: ZKqwQxNW9_1TRzxJoKK35dlluNAhVFwR
X-Proofpoint-GUID: ZKqwQxNW9_1TRzxJoKK35dlluNAhVFwR
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae3e1e3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2rSJJTxtMjq_0QecKbYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300000
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


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Add halfword greater-than compares and out-of-line helpers for
> truncating and rounding halfword averages.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h          |  10 +++
>   target/hexagon/hex_common.py     |  16 +++++
>   target/hexagon/hlx_gvec_tables.c | 105 +++++++++++++++++++++++++++++++
>   target/hexagon/hlx_gvec_tables.h |   5 ++
>   target/hexagon/hlx_helper.c      |  52 +++++++++++++++
>   5 files changed, 188 insertions(+)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 471ef0903b..f42cb8d9b6 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -44,6 +44,16 @@ DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_sub16, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, i32)
>   DEF_HELPER_FLAGS_3(hlx_gvec_abs_uh_sat16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>   
> +/* GVec helpers for MO_16 averages. */
> +DEF_HELPER_FLAGS_4(hlx_gvec_avg_sh16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(hlx_gvec_avg_sh16_rnd, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16_rnd, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +
>   /* Floating point */
>   DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
>   DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 3f4d796a98..d0b36b8e06 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -388,6 +388,22 @@ def skip_qemu_helper(tag):
>                            "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
>       "LX_abs_uh_sat":    {"op": "gvec2", "table": "hlx_abs_uh_sat_op",
>                            "vece": "MO_16"},
> +    "LX_cmp_gt_h":   {"op": "cmp",    "cond": "TCG_COND_GT",
> +                      "vece": "MO_16"},
> +    "LX_cmp_gt_uh":  {"op": "cmp",    "cond": "TCG_COND_GTU",
> +                      "vece": "MO_16"},
> +    "LX_cmp_gt_hp":  {"op": "cmp",    "cond": "TCG_COND_GT",
> +                      "vece": "MO_16",   "size": "2 * sizeof(HLXVector)"},
> +    "LX_cmp_gt_uhp": {"op": "cmp",    "cond": "TCG_COND_GTU",
> +                      "vece": "MO_16",   "size": "2 * sizeof(HLXVector)"},
> +    "LX_avg_h":         {"op": "gvec3", "table": "hlx_avg_sh_op",
> +                         "vece": "MO_16"},
> +    "LX_avg_h_rnd":     {"op": "gvec3", "table": "hlx_avg_sh_rnd_op",
> +                         "vece": "MO_16"},
> +    "LX_avg_uh":        {"op": "gvec3", "table": "hlx_avg_uh_op",
> +                         "vece": "MO_16"},
> +    "LX_avg_uh_rnd":    {"op": "gvec3", "table": "hlx_avg_uh_rnd_op",
> +                         "vece": "MO_16"},
>   }
>   
>   def is_hlx_inline_tag(tag):
> diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
> index dd5aa788e0..a5d40e149c 100644
> --- a/target/hexagon/hlx_gvec_tables.c
> +++ b/target/hexagon/hlx_gvec_tables.c
> @@ -111,3 +111,108 @@ const GVecGen2 hlx_abs_uh_sat_op = {
>       .fno     = gen_helper_hlx_gvec_abs_uh_sat16,
>       .vece    = MO_16,
>   };
> +
> +/* Halfword averages. The shift is arithmetic or logical by signedness. */
> +static void hlx_fniv_avg_sh(unsigned vece, TCGv_vec r,
> +                             TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec ta = tcg_temp_new_vec_matching(r);
> +    TCGv_vec tb = tcg_temp_new_vec_matching(r);
> +    tcg_gen_and_vec(vece, ta, a, b);
> +    tcg_gen_xor_vec(vece, tb, a, b);
> +    tcg_gen_sari_vec(vece, tb, tb, 1);
> +    tcg_gen_add_vec(vece, r, ta, tb);
> +}
> +
> +static void hlx_fniv_avg_sh_rnd(unsigned vece, TCGv_vec r,
> +                                 TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec ta = tcg_temp_new_vec_matching(r);
> +    TCGv_vec tb = tcg_temp_new_vec_matching(r);
> +    tcg_gen_or_vec(vece, ta, a, b);
> +    tcg_gen_xor_vec(vece, tb, a, b);
> +    tcg_gen_sari_vec(vece, tb, tb, 1);
> +    tcg_gen_sub_vec(vece, r, ta, tb);
> +}
> +
> +static void hlx_fniv_avg_uh(unsigned vece, TCGv_vec r,
> +                             TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec ta = tcg_temp_new_vec_matching(r);
> +    TCGv_vec tb = tcg_temp_new_vec_matching(r);
> +    tcg_gen_and_vec(vece, ta, a, b);
> +    tcg_gen_xor_vec(vece, tb, a, b);
> +    tcg_gen_shri_vec(vece, tb, tb, 1);
> +    tcg_gen_add_vec(vece, r, ta, tb);
> +}
> +
> +static void hlx_fniv_avg_uh_rnd(unsigned vece, TCGv_vec r,
> +                                  TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec ta = tcg_temp_new_vec_matching(r);
> +    TCGv_vec tb = tcg_temp_new_vec_matching(r);
> +    tcg_gen_or_vec(vece, ta, a, b);
> +    tcg_gen_xor_vec(vece, tb, a, b);
> +    tcg_gen_shri_vec(vece, tb, tb, 1);
> +    tcg_gen_sub_vec(vece, r, ta, tb);
> +}
> +
> +static const TCGOpcode hlx_vecop_avg_sh[] = {
> +    INDEX_op_and_vec,
> +    INDEX_op_xor_vec,
> +    INDEX_op_sari_vec,
> +    INDEX_op_add_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_avg_sh_rnd[] = {
> +    INDEX_op_or_vec,
> +    INDEX_op_xor_vec,
> +    INDEX_op_sari_vec,
> +    INDEX_op_sub_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_avg_uh[] = {
> +    INDEX_op_and_vec,
> +    INDEX_op_xor_vec,
> +    INDEX_op_shri_vec,
> +    INDEX_op_add_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_avg_uh_rnd[] = {
> +    INDEX_op_or_vec,
> +    INDEX_op_xor_vec,
> +    INDEX_op_shri_vec,
> +    INDEX_op_sub_vec,
> +    0
> +};
> +
> +const GVecGen3 hlx_avg_sh_op = {
> +    .fniv    = hlx_fniv_avg_sh,
> +    .opt_opc = hlx_vecop_avg_sh,
> +    .fno     = gen_helper_hlx_gvec_avg_sh16,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen3 hlx_avg_sh_rnd_op = {
> +    .fniv    = hlx_fniv_avg_sh_rnd,
> +    .opt_opc = hlx_vecop_avg_sh_rnd,
> +    .fno     = gen_helper_hlx_gvec_avg_sh16_rnd,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen3 hlx_avg_uh_op = {
> +    .fniv    = hlx_fniv_avg_uh,
> +    .opt_opc = hlx_vecop_avg_uh,
> +    .fno     = gen_helper_hlx_gvec_avg_uh16,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen3 hlx_avg_uh_rnd_op = {
> +    .fniv    = hlx_fniv_avg_uh_rnd,
> +    .opt_opc = hlx_vecop_avg_uh_rnd,
> +    .fno     = gen_helper_hlx_gvec_avg_uh16_rnd,
> +    .vece    = MO_16,
> +};
> diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
> index 55ab6bb63f..e01c853eb1 100644
> --- a/target/hexagon/hlx_gvec_tables.h
> +++ b/target/hexagon/hlx_gvec_tables.h
> @@ -12,4 +12,9 @@ extern const GVecGen3 hlx_ushsat_add_op;
>   extern const GVecGen3 hlx_ushsat_sub_op;
>   extern const GVecGen2 hlx_abs_uh_sat_op;
>   
> +extern const GVecGen3 hlx_avg_sh_op;
> +extern const GVecGen3 hlx_avg_sh_rnd_op;
> +extern const GVecGen3 hlx_avg_uh_op;
> +extern const GVecGen3 hlx_avg_uh_rnd_op;
> +
>   #endif /* HLX_GVEC_TABLES_H */
> diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
> index 906f31ba17..c624b66f83 100644
> --- a/target/hexagon/hlx_helper.c
> +++ b/target/hexagon/hlx_helper.c
> @@ -143,3 +143,55 @@ void HELPER(hlx_gvec_abs_uh_sat16)(void *d, void *a, uint32_t desc)
>           *(int16_t *)((char *)d + i) = (int16_t)r;
>       }
>   }
> +
> +void HELPER(hlx_gvec_avg_sh16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t av = *(int16_t *)((char *)a + i);
> +        int16_t bv = *(int16_t *)((char *)b + i);
> +        int16_t r = (int16_t)((av & bv) + ((av ^ bv) >> 1));
> +        *(int16_t *)((char *)d + i) = r;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_avg_sh16_rnd)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t av = *(int16_t *)((char *)a + i);
> +        int16_t bv = *(int16_t *)((char *)b + i);
> +        int16_t r = (int16_t)((av | bv) - ((av ^ bv) >> 1));
> +        *(int16_t *)((char *)d + i) = r;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_avg_uh16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
> +        uint16_t av = *(uint16_t *)((char *)a + i);
> +        uint16_t bv = *(uint16_t *)((char *)b + i);
> +        uint16_t r = (uint16_t)((av & bv) + ((av ^ bv) >> 1));
> +        *(uint16_t *)((char *)d + i) = r;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_avg_uh16_rnd)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
> +        uint16_t av = *(uint16_t *)((char *)a + i);
> +        uint16_t bv = *(uint16_t *)((char *)b + i);
> +        uint16_t r = (uint16_t)((av | bv) - ((av ^ bv) >> 1));
> +        *(uint16_t *)((char *)d + i) = r;
> +    }
> +}


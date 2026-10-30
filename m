Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gL8q1rsj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T2LHLsOv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaLR-00011b-H6; Thu, 29 Oct 2026 20:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaLP-00011R-71
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:19:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaLM-0001qq-PW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:19:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKanF1564651
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wtavZn6kuzDxpGMU1/mNr9I7O4jPDuV4tZEv9a/JqXE=; b=gL8q1rsjJpd3/lV/
 oSQpw/+0W/K301sP8tzJq1oDF7NbR+XMPLW4va3ISDXsn8R7x0uSa6y9O1rXuwav
 OufA3xJvv9HbgjSqhgQUdSdrrP3OIhM8vzn1pkrWd0B+odKM4ZgTQKhUoZCW90E9
 3dFbVNzFbi7b8OfvU+Ppf7NbE3kTneoafWYZUbfjZPdH4RSt8nYAD1Hd+ToptQyY
 29oENw2Kk+UX/Km+XZ/+jV2W/a5HkJC/AIF2lNv7D+FUfbTGA4DjjWHwqNm0NKxu
 Ok4Zyyz+nPApeAVNJ+zu88bCtB/y2I80vBnH8Mmylsoia4eosQPKj2v0oyzGcy28
 jIbyoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgf6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:19:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-534f3fe0236so2700811cf.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793319577; x=1793924377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wtavZn6kuzDxpGMU1/mNr9I7O4jPDuV4tZEv9a/JqXE=;
 b=T2LHLsOvgY6H8ak6xozuH7mYtZHaybcubIbB2k56uqMX05UySnhIqejspjafH11SI+
 2vZkXVVINDyHC5cKgClNwzR7LPRRYIJC6NQxv2kuw4dQ3Uwtu1i+wtHZiLoLVzXVjoCL
 8bNDaXRvQgtQGc7FEy1Zb8WnJx4/Ark4URJzQno5yEGi5R43XI8lWjeCLGPu8Z3T/QPg
 jYF9JsJtSQKRQr2GHlJ6Hu5uJYScwuw7PkLzPRiSAS2wKDJ9552/p00UZfXCi7KY2zif
 YYr7HFHnafLeJ130kzHsogTwD9zePX4VHyXGFIW/eb8KJemirx4X4DFq29hixZXSly88
 V4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319577; x=1793924377;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wtavZn6kuzDxpGMU1/mNr9I7O4jPDuV4tZEv9a/JqXE=;
 b=vNZD/+ss6A7MPZhAZzm1IqAVDEeNF/If3PGKSKCnSbGC5dD1i1gbNbsQbUkPrE8MQ9
 QP1V3DULHN3ejNumgf+id0Krzz02CFfpSZptJdBsLX7i4Y1uxoU0COiaB3l4dqja5B4X
 DrIueWSPsBRUZ90JsbIfHnFHQe0NkvH9kE02mDtlV2RAE7ajXzuNTD2duR1uFs939wvN
 AN9AO67so9Sz9eH3inFtKltKmTv6oLfVSdQ47A+YKzTNdJEboIbvGh+i7P/c2CxLkv8h
 Odj9KCu+GPTz7fW27iD+9CnTuBZiVtjOCuqMgoHLUwZVe6lGBWMrGHea0DvEhiitF5IV
 QmvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqSc6jReuOxWNXpcL/dO1La+brypbkpniGtXIgWMfWLp/u/Z76+BTSpirbeGOBLiA/cINxb/ZjbMMF@nongnu.org
X-Gm-Message-State: AFq9FYIGSXz0Kj/O3EtxhqWiVo/7yxTAxaaHEEjrxrJ/8Pyf3mELEkwI
 Hkseh3TlezV71ddFYhvqFWJ85Nx52ksa6+5RrfPHSyg4tPYl1mL1+Viw54Po3Vm9tsrD0ZW61aj
 QniuEFLXZum+HZrSJMhKJ98lLHGSULZVEUQbVvgD2zFmAyPLp4XaBNPDRwA==
X-Gm-Gg: AYBFou3AmsqGWptCHsxtSZxJ7oPRzuP1wXyLLN2+rG8yvh9LY3pVkFOSdYXfK45wiAE
 OpPMbG3vzfyU7jbrEE2GQUpBzPbjQcZCfnovKCKHnuGqMHk4mlHP66xXjmuacYSayAXfgeiY4Ff
 HamUHCWvK7zdSphWIZNLM1czmB9hFTeEnZMX/IdYOU/r2qGQM6yz9x1/e0osB+aQkJ/71wwRKah
 62XRg1QMb6Inkl4OPwkNgu/XZKiA3H/uCtsTSqowSow4yiKdNbya+7zFtGFvaVsSQgz9fRQrZhI
 WIhWsziPuKjKPUOJbx8u2aILhSRFeQJobNC1H111DsysjXoFHtVccuG+yLYNOlIlU3Io2i9FHX4
 fplVc+3bb/lYUZvsfV+qKiPLPch2bcT/E9YL1BWJ+o2CbQDIgRTSe91d8RbyqIAfHL9bFvbhndC
 Mve/J6516LrVO4PyPM2awuOOVH+G2d16TnffqUKMiFpwa9/8c4iDBK
X-Received: by 2002:ac8:5713:0:b0:536:6328:8244 with SMTP id
 d75a77b69052e-542b397a4b9mr12009371cf.9.1793319576794; 
 Thu, 29 Oct 2026 17:19:36 -0700 (PDT)
X-Received: by 2002:ac8:5713:0:b0:536:6328:8244 with SMTP id
 d75a77b69052e-542b397a4b9mr12009031cf.9.1793319576301; 
 Thu, 29 Oct 2026 17:19:36 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-542f74dcf6csm1148861cf.16.2026.10.29.17.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:19:35 -0700 (PDT)
Message-ID: <98721865-c870-4ba6-bd96-baa53602ac43@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:19:33 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] target/hexagon: add HLX unsigned saturating gvec
 operations
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-9-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-9-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6I6WIFd29aZkFYNQZq5mih6NiHGpdQ85
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMCBTYWx0ZWRfX+Ht9Dv4DZb1c
 ZLWgRdFSOsse9zsHCsZ3fN2jnGUFtH9ctU5GC1G6zi/2ShwxZrB39O1D97j7acmGKT//tB1SW+v
 vAkd7nV2R6BAD/EOCn3GHXCkstoTTXY=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae3e299 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=4y55B-Ngg9Cho1YXPLsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 6I6WIFd29aZkFYNQZq5mih6NiHGpdQ85
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMCBTYWx0ZWRfX7Hiwd9khgAbO
 WVDKRrDknt8UurxBurBXzuO9PFiJxVgdgh44SnwRtAZ2rX6NFYCVxwg/aHKnAueZHCAvuUav8vi
 jBu0DWM/H6D5uJN44dSc1usEtIrLWNVmYqVPkJyLfZVLuQKpX7WaMMuhgEeic2+AhzkT/ft5H+p
 JkVxa68DwEfM2VLQkcpl6h7DgOPd12janXpS9TVFRUVsQ9AZMpo3mxSIIXx/d0hzMYhCKq5N+V/
 8mune4ov08YZpml4XyFqqyewKVauH8jkI/Aog4Ckd0ypn6TcZpWcVipZ2R9kAh1l0xtxgkqmaZS
 Sw30ZYYlSy7VBGwTg252Z8W1JAXKUYTZKU0QjpR0f5gNsFQj/6feQBrgHnVJxYZZGN0fD5B8xAu
 uET1Zp2j8agREMpZVfRncXfAh1CxM3PJ7x8RPJz1sUsxeqM+c0zGw1npFGsF+7QgWSUws6P4ev3
 YAiiOh3cJUwQWMZP76A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300000
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
> Add out-of-line gvec helpers for signed-to-unsigned halfword saturation
> and saturating absolute value.
>
> HLX vectors exceed the gvec unroll limit, so these helpers run.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/genptr.c          |   2 +-
>   target/hexagon/helper.h          |   7 ++
>   target/hexagon/hex_common.py     |  10 +++
>   target/hexagon/hlx_gvec_tables.c | 113 +++++++++++++++++++++++++++++++
>   target/hexagon/hlx_gvec_tables.h |  15 ++++
>   target/hexagon/hlx_helper.c      |  50 ++++++++++++++
>   target/hexagon/meson.build       |   1 +
>   7 files changed, 197 insertions(+), 1 deletion(-)
>   create mode 100644 target/hexagon/hlx_gvec_tables.c
>   create mode 100644 target/hexagon/hlx_gvec_tables.h

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 808caf4289..b57f255b24 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -36,7 +36,7 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "gen_tcg_sys.h"
>   #endif
> -
> +#include "hlx_gvec_tables.h"
>   #include "genptr.h"
>   
>   static void gen_sabsdiff_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index 766995fae3..471ef0903b 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -37,6 +37,13 @@ DEF_HELPER_5(hlx_store_vec, void, env, tl, ptr, i32, i32)
>   DEF_HELPER_1(hlx_commit_store, void, env)
>   DEF_HELPER_FLAGS_2(hlx_trace_op, TCG_CALL_NO_RWG, void, env, i32)
>   
> +/* GVec helpers for signed-to-unsigned MO_16 saturation. */
> +DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_add16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(hlx_gvec_ushsat_sub16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_3(hlx_gvec_abs_uh_sat16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>   /* Floating point */
>   DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
>   DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index a6ac84d792..3f4d796a98 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -378,6 +378,16 @@ def skip_qemu_helper(tag):
>                         "vece": "MO_16"},
>       "LX_abs_uhp":    {"op": "gvec2_fn", "fn": "abs",
>                         "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_add_uhh_sat":   {"op": "gvec3", "table": "hlx_ushsat_add_op",
> +                         "vece": "MO_16"},
> +    "LX_sub_uhh_sat":   {"op": "gvec3", "table": "hlx_ushsat_sub_op",
> +                         "vece": "MO_16"},
> +    "LX_add_uhp_h_sat": {"op": "gvec3", "table": "hlx_ushsat_add_op",
> +                         "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_sub_uhp_h_sat": {"op": "gvec3", "table": "hlx_ushsat_sub_op",
> +                         "vece": "MO_16", "size": "2 * sizeof(HLXVector)"},
> +    "LX_abs_uh_sat":    {"op": "gvec2", "table": "hlx_abs_uh_sat_op",
> +                         "vece": "MO_16"},
>   }
>   
>   def is_hlx_inline_tag(tag):
> diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
> new file mode 100644
> index 0000000000..dd5aa788e0
> --- /dev/null
> +++ b/target/hexagon/hlx_gvec_tables.c
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "tcg/tcg.h"
> +#include "tcg/tcg-op-common.h"
> +#include "tcg/tcg-op-gvec-common.h"
> +#include "hlx_gvec_tables.h"
> +#include "exec/helper-gen.h"
> +
> +/* Saturate signed halfword results to uint16_t. */
> +
> +static const TCGOpcode hlx_vecop_ushsat_add[] = {
> +    INDEX_op_add_vec,
> +    INDEX_op_ssadd_vec,
> +    INDEX_op_smax_vec,
> +    INDEX_op_cmp_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_ushsat_sub[] = {
> +    INDEX_op_sub_vec,
> +    INDEX_op_sssub_vec,
> +    INDEX_op_smax_vec,
> +    INDEX_op_cmp_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_abs_uh_sat[] = {
> +    INDEX_op_abs_vec,
> +    INDEX_op_umin_vec,
> +    0
> +};
> +
> +static void hlx_fniv_ushsat_add(unsigned vece, TCGv_vec r,
> +                                 TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec wrap    = tcg_temp_new_vec_matching(r);
> +    TCGv_vec ssat    = tcg_temp_new_vec_matching(r);
> +    TCGv_vec pos_ovf = tcg_temp_new_vec_matching(r);
> +    TCGv_vec pa      = tcg_temp_new_vec_matching(r);
> +    TCGv_vec pb      = tcg_temp_new_vec_matching(r);
> +    TCGv_vec zero    = tcg_constant_vec_matching(r, vece, 0);
> +
> +    tcg_gen_add_vec(vece, wrap, a, b);
> +
> +    tcg_gen_ssadd_vec(vece, ssat, a, b);
> +    tcg_gen_smax_vec(vece, ssat, ssat, zero);
> +
> +    tcg_gen_cmp_vec(TCG_COND_GE, vece, pa, a, zero);
> +    tcg_gen_cmp_vec(TCG_COND_GE, vece, pb, b, zero);
> +    tcg_gen_cmp_vec(TCG_COND_LT, vece, pos_ovf, wrap, zero);
> +    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pa);
> +    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pb);
> +
> +    tcg_gen_bitsel_vec(vece, r, pos_ovf, wrap, ssat);
> +}
> +
> +static void hlx_fniv_ushsat_sub(unsigned vece, TCGv_vec r,
> +                                 TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec wrap    = tcg_temp_new_vec_matching(r);
> +    TCGv_vec ssat    = tcg_temp_new_vec_matching(r);
> +    TCGv_vec pos_ovf = tcg_temp_new_vec_matching(r);
> +    TCGv_vec pa      = tcg_temp_new_vec_matching(r);
> +    TCGv_vec nb      = tcg_temp_new_vec_matching(r);
> +    TCGv_vec zero    = tcg_constant_vec_matching(r, vece, 0);
> +
> +    tcg_gen_sub_vec(vece, wrap, a, b);
> +
> +    tcg_gen_sssub_vec(vece, ssat, a, b);
> +    tcg_gen_smax_vec(vece, ssat, ssat, zero);
> +
> +    /* Positive subtraction overflow needs a >= 0 and b < 0. */
> +    tcg_gen_cmp_vec(TCG_COND_GE, vece, pa, a, zero);
> +    tcg_gen_cmp_vec(TCG_COND_LT, vece, nb, b, zero);
> +    tcg_gen_cmp_vec(TCG_COND_LT, vece, pos_ovf, wrap, zero);
> +    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, pa);
> +    tcg_gen_and_vec(vece, pos_ovf, pos_ovf, nb);
> +
> +    tcg_gen_bitsel_vec(vece, r, pos_ovf, wrap, ssat);
> +}
> +
> +static void hlx_fniv_abs_uh_sat(unsigned vece, TCGv_vec r, TCGv_vec a)
> +{
> +    /* Clamp abs(INT16_MIN) to INT16_MAX. */
> +    TCGv_vec imax = tcg_constant_vec_matching(r, vece, 0x7FFF);
> +    tcg_gen_abs_vec(vece, r, a);
> +    tcg_gen_umin_vec(vece, r, r, imax);
> +}
> +
> +const GVecGen3 hlx_ushsat_add_op = {
> +    .fniv    = hlx_fniv_ushsat_add,
> +    .opt_opc = hlx_vecop_ushsat_add,
> +    .fno     = gen_helper_hlx_gvec_ushsat_add16,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen3 hlx_ushsat_sub_op = {
> +    .fniv    = hlx_fniv_ushsat_sub,
> +    .opt_opc = hlx_vecop_ushsat_sub,
> +    .fno     = gen_helper_hlx_gvec_ushsat_sub16,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen2 hlx_abs_uh_sat_op = {
> +    .fniv    = hlx_fniv_abs_uh_sat,
> +    .opt_opc = hlx_vecop_abs_uh_sat,
> +    .fno     = gen_helper_hlx_gvec_abs_uh_sat16,
> +    .vece    = MO_16,
> +};
> diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
> new file mode 100644
> index 0000000000..55ab6bb63f
> --- /dev/null
> +++ b/target/hexagon/hlx_gvec_tables.h
> @@ -0,0 +1,15 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HLX_GVEC_TABLES_H
> +#define HLX_GVEC_TABLES_H
> +
> +#include "tcg/tcg-op-gvec-common.h"
> +
> +extern const GVecGen3 hlx_ushsat_add_op;
> +extern const GVecGen3 hlx_ushsat_sub_op;
> +extern const GVecGen2 hlx_abs_uh_sat_op;
> +
> +#endif /* HLX_GVEC_TABLES_H */
> diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
> index 6525abfb2c..906f31ba17 100644
> --- a/target/hexagon/hlx_helper.c
> +++ b/target/hexagon/hlx_helper.c
> @@ -93,3 +93,53 @@ void HELPER(hlx_commit_reg)(CPUHexagonState *env, uint32_t rnum)
>       memcpy(&env->hlx_ctx->LRegs[rnum], &env->future_LRegs[rnum],
>              sizeof(HLXVector));
>   }
> +
> +/* HLX vectors exceed the gvec inline limit. */
> +void HELPER(hlx_gvec_ushsat_add16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int32_t r = (int32_t)(*(int16_t *)((char *)a + i))
> +                  + (int32_t)(*(int16_t *)((char *)b + i));
> +        if (r < 0) {
> +            r = 0;
> +        } else if (r > 0xFFFF) {
> +            r = 0xFFFF;
> +        }
> +        *(uint16_t *)((char *)d + i) = (uint16_t)r;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_ushsat_sub16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int32_t r = (int32_t)(*(int16_t *)((char *)a + i))
> +                  - (int32_t)(*(int16_t *)((char *)b + i));
> +        if (r < 0) {
> +            r = 0;
> +        } else if (r > 0xFFFF) {
> +            r = 0xFFFF;
> +        }
> +        *(uint16_t *)((char *)d + i) = (uint16_t)r;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_abs_uh_sat16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t v = *(int16_t *)((char *)a + i);
> +        int32_t r = (v < 0) ? -(int32_t)v : (int32_t)v;
> +        if (r > INT16_MAX) {
> +            r = INT16_MAX;
> +        }
> +        *(int16_t *)((char *)d + i) = (int16_t)r;
> +    }
> +}
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 1aa4df7ac7..fd4983343d 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -266,6 +266,7 @@ hexagon_ss.add(files(
>       'mmvec/hvx_ieee_fp.c',
>       'mmvec/hvx_qfloat.c',
>       'hlx_helper.c',
> +    'hlx_gvec_tables.c',
>   ))
>   
>   hexagon_softmmu_ss.add(files(


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FADCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMgM-0007IG-AV; Wed, 07 Oct 2026 04:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEGW5-0004Jn-Ct
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:32:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEGVi-0007TE-AF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:32:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696EAurD217413
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 16:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cQrPrHvdJ5//Ei+2e3s6feIOdKLvN0N86vsqgLGuY2c=; b=iWby+AyQeyHWKXzZ
 q+bQ2fQi/z2yt+k8NtoZYf3wF5qb4yb7g3l0wXozjY2uJrlBhQt93hqFLejGCTWo
 RvbBxEGzxPjnnBGpUpIzAizTinfW86fU2bgmcx3YhZW5BG0A6qSLGPxYxMlt6zxH
 +m+TrtQJrSdf4dMOao1EEvgdwkF1N6EeeYy0+1ao0WhJmwlTjg2JObhMkIaz2/Dl
 L+EWyTRniS8aA60NkpMKrJ2H/iDX07ggwX3IOlrNUtm8CZSokHteY1GmFlt0f2mu
 hpzGgdOgBZgCVN9YEigm7u7FQij6xukQ8frVYHcjSGKi2a1NZhZKMk8e2ZyARK3P
 0oyiuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4vmrsw2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 16:00:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef5fd7934so8229725eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791302405; x=1791907205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQrPrHvdJ5//Ei+2e3s6feIOdKLvN0N86vsqgLGuY2c=;
 b=gc1gCKHQvn513rffHF/2JkWsR8PeZ8YhSUmeM6JXPKeMk1f6nO8PUYZZsZQTfyZDCV
 hk7Pe/0nmPq/38gHbbvzwZxgf1msZ1rfDqdD0f9cCS792h9VaK1FqywlCDhwvFwVIqeu
 yojlahs//AzTcfPwbMdcr34ml4vuEuTNwWuObcJT4nfJYoaakeI6SSOxx70MJTnmk7ge
 KFQsXejlw6P7oxqzyJWDz/udrtVeEipOxm66CYyoZif/+zxgId/Ur/6io7JMC0LAtpd3
 qUDTBRTEVcydOcNrMeFgW84Hltl5sUQpM77zvLDBT6DlbDtoFYfUgK5tY8/BBAUlZp8l
 L9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791302405; x=1791907205;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQrPrHvdJ5//Ei+2e3s6feIOdKLvN0N86vsqgLGuY2c=;
 b=Q6oEeXtMux/7RD7mhMMI+9QF6CLWqM4DY8/Y1Uzs5OtxdEgiaGtxo3sgIVpZBsEgpm
 GoR+7WIAewr3aJlHLN5SwaS/bds9S4n1l5cFy9YauQletV3NgxvmrK6eGc2oGVnnsyTD
 elHDYaOUo/cqrLXPtM0rB6rxMnqaF4EVqbk+3tjs1ZnEX0WgbXimJH+kmY7HVDRBSsv/
 QYR3NC/296r0EytAn4QkUlueGH1X8XSNTLzwJsqys/kRI9tYNb0KOpQ4i7CcwG3yjgh4
 ZiJGdYtEcHf1qvMWuYbLhMZUdUaYxbkzZf3Oqa+MyQTQAL7on+WRNna+FXaP8fWbgAy8
 iC5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5WcPaxGSQ2Bv/vYFHx/uwsRnlFmFRUdzL4X5xIGuHA+ze5/KarDEgS1RM+goYBayQ+tR0GBlvBdi2@nongnu.org
X-Gm-Message-State: AFq9FYKxjYtWzI94ZH56U5XVMyTGjwrOdSzOVfBsYF1MmB+ps4UK+eez
 FGHhX8xai/VrvgtPfkhfXuzGGMPiNrULv7bMYRcQZ7we4wrLjrSDJJwDBp9+4TC0mfLqlCvwerK
 id1pxFBNwY4URIZvsd8yh0dFeShVoRG3dFDIs0xgH8boYHKksyuS7iuu0gA==
X-Gm-Gg: AYBFou3+LiJaNfxx6tjdt42DcfdtYWjyC26a6Y+qfwte2Dzf2zRe0SV5WNlTVwWLTWc
 BuT7Q/u+ZCp/0EQhCcQ2zjBapI4aghPkDN0/0sK+GJhVnqqw5J5aGAjx6WoyIj0hhLowmgPIw+H
 W2h10E8SO0Y739Pl2x8D7c/UkiL0NJ0+gY+7E6D9aSZf6p+hG4u/Y/rasxHXT1zAuTDJ7hjOgmW
 s/UzvWJse5eQRaPYi/Yx7/o5vFeOZf35r+1svMslhfOTjmtWkGrJ9ii+bcI2HtUicnv1aYpH3O2
 kiULHfR9HU5RlJnnx7i3+sYrsen08PQkghXJNEILrEqVceYq5imTCG4gQS3m0YEPxBYvevHW0Ux
 AEBMtRNfIQlHOE9w9zQqOUeIfcsgf9SNIKKXpHllXL4XLk49yplCOVewfjonRx4pLjJSlDg==
X-Received: by 2002:a05:7301:7309:b0:34b:5e55:fe7f with SMTP id
 5a478bee46e88-3514da97e6bmr2189237eec.0.1791302404834; 
 Tue, 06 Oct 2026 09:00:04 -0700 (PDT)
X-Received: by 2002:a05:7301:7309:b0:34b:5e55:fe7f with SMTP id
 5a478bee46e88-3514da97e6bmr2189193eec.0.1791302403784; 
 Tue, 06 Oct 2026 09:00:03 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b3b5aesm12633310eec.29.2026.10.06.09.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 09:00:02 -0700 (PDT)
Message-ID: <627ba7fb-ad8d-40f5-8440-2e7392552151@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 09:00:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] target/hexagon: use vector payload size for HVX
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com
References: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
 <20261005032616.1293829-6-brian.cain@oss.qualcomm.com>
 <37303d83-8197-46bd-be25-5c9e4961d314@oss.qualcomm.com>
 <63755d87-435d-444e-b825-5935edcd177e@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <63755d87-435d-444e-b825-5935edcd177e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XZ4cX455 c=1 sm=1 tr=0 ts=6ac51b06 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_WfK9Il2V_R-0XhqvRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 1R_1_YFCMjqH7c8hwMKC-7cZuXG7h1Lz
X-Proofpoint-ORIG-GUID: 1R_1_YFCMjqH7c8hwMKC-7cZuXG7h1Lz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MyBTYWx0ZWRfX+VS+6OkkJk36
 gTLN4juIrL6kn+IAm0Qx6pfRm4+gglo9Crac0D3Q8I1q43LubIuEXayCR8DV4wnSiel/2Dh0WLE
 eI3bZA1nrUITLZsjZzAN4IfUScgpOD/zNvkAJ9UN2JnTtYhFieOH7+JSAoZ8xdTlNA88XY0TNRg
 JcQqvdDlL6mpDh9LbljYaBQCbqcGE6BKXXNo5GRdEW8F4zjnBO7bGlt54eUL/XP07q9CD3pmw/9
 gwEu1E6l7kSwjiSwGdSwlwr/wT5lPJ3gSNdfAVsDF9bBalhqRleVWVgmhHoc0+5rzElxZMd7y3H
 6b4T9Bp4FsIQPJy8lsIAWUseFq2u0CJ6zeEGveaUefVx1dAFL7PHDWGboPa61pELL+w+dL4SfOq
 YH/Bm2WN48j2k/eKnMRnLvfWHygqYkknLNUkuPdFiI4WXCjH/anHgM4lrZJlg851pZV2B7/s3Gk
 R3aSnTJRwhV0H1GReBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MyBTYWx0ZWRfX5pvk8c8aDYti
 so+pWxFjolGpiZ0SejmuT4WGa7A+ZNqfvfI63QcgQIcoam7lVIKGTwoKlU5XXFV8lxrn+8qusVB
 hw+0EcCAL9Gf0jxs6t0d5WKYZMBOLJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/6/2026 8:58 AM, Brian Cain wrote:
> 
> On 10/5/2026 4:36 PM, Pierrick Bouvier wrote:
>> On 10/4/2026 8:26 PM, Brian Cain wrote:
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/gen_tcg_hvx.h            | 242 ++++++++++++------------
>>>   target/hexagon/mmvec/macros.h           |   8 +-
>>>   target/hexagon/genptr.c                 |  18 +-
>>>   target/hexagon/mmvec/system_ext_mmvec.c |   8 +-
>>>   target/hexagon/op_helper.c              |  34 ++--
>>>   5 files changed, 152 insertions(+), 158 deletions(-)
>>>
>>> diff --git a/target/hexagon/gen_tcg_hvx.h b/target/hexagon/gen_tcg_hvx.h
>>> index 548b49b4156..e439b0817f2 100644
>>> --- a/target/hexagon/gen_tcg_hvx.h
>>> +++ b/target/hexagon/gen_tcg_hvx.h
>>> @@ -126,19 +126,19 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>     #define fGEN_TCG_V6_vassign(SHORTCODE) \
>>>       tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vassign_tmp(SHORTCODE) \
>>>       tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vcombine_tmp(SHORTCODE) \
>>>       do { \
>>>           tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off, VvV_base,
>>> VvV_off, \
>>> -                             sizeof(MMVector), sizeof(MMVector)); \
>>> +                             VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>>           tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off +
>>> sizeof(MMVector), \
>>> -                             VuV_base, VuV_off, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             VuV_base, VuV_off, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     /*
>>> @@ -150,19 +150,19 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>       do { \
>>>           if (VddV_off != VuV_off) { \
>>>               tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off,
>>> VvV_base, \
>>> -                                 VvV_off, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                                 VvV_off, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>               tcg_gen_gvec_mov_var(MO_64, VddV_base, \
>>>                                    VddV_off + sizeof(MMVector),
>>> VuV_base, \
>>> -                                 VuV_off, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                                 VuV_off, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>           } else { \
>>>               intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>>>               tcg_gen_gvec_mov_var(MO_64, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                                 sizeof(MMVector), sizeof(MMVector)); \
>>> +                                 VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>>               tcg_gen_gvec_mov_var(MO_64, VddV_base, VddV_off,
>>> VvV_base, \
>>> -                                 VvV_off, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                                 VvV_off, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>               tcg_gen_gvec_mov_var(MO_64, VddV_base, \
>>>                                    VddV_off + sizeof(MMVector),
>>> tcg_env, tmpoff, \
>>> -                                 sizeof(MMVector), sizeof(MMVector)); \
>>> +                                 VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>>           } \
>>>       } while (0)
>>>   @@ -174,7 +174,7 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           tcg_gen_andi_tl(lsb, PsV, 1); \
>>>           tcg_gen_brcondi_tl(TCG_COND_NE, lsb, PRED, false_label); \
>>>           tcg_gen_gvec_mov_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                             sizeof(MMVector), sizeof(MMVector)); \
>>> +                             VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>>           gen_set_label(false_label); \
>>>       } while (0)
>>>   @@ -190,62 +190,52 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>   /* Vector add - various forms */
>>>   #define fGEN_TCG_V6_vaddb(SHORTCODE) \
>>>       tcg_gen_gvec_add_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, VvV_base, \
>>> -                         VvV_off, sizeof(MMVector), sizeof(MMVector))
>>> +                         VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vaddh(SHORTCYDE) \
>>>       tcg_gen_gvec_add_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vaddw(SHORTCODE) \
>>>       tcg_gen_gvec_add_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>   -#define fGEN_TCG_V6_vaddb_dv(SHORTCODE) \
>>> -    tcg_gen_gvec_add_var(MO_8, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> +#define fGEN_TCG_PAIR_ADDSUB_BASIC(OP, VECE) \
>>> +    do { \
>>> +        tcg_gen_gvec_##OP##_var(VECE, VddV_base, VddV_off, \
>>> +                                VuuV_base, VuuV_off, VvvV_base,
>>> VvvV_off, \
>>> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>> +        tcg_gen_gvec_##OP##_var(VECE, VddV_base, \
>>> +                                VddV_off + sizeof(MMVector),
>>> VuuV_base, \
>>> +                                VuuV_off + sizeof(MMVector),
>>> VvvV_base, \
>>> +                                VvvV_off + sizeof(MMVector), \
>>> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>> +    } while (0)
>>>   -#define fGEN_TCG_V6_vaddh_dv(SHORTCYDE) \
>>> -    tcg_gen_gvec_add_var(MO_16, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> -
>>> -#define fGEN_TCG_V6_vaddw_dv(SHORTCODE) \
>>> -    tcg_gen_gvec_add_var(MO_32, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> +#define fGEN_TCG_V6_vaddb_dv(SHORTCODE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_8)
>>> +#define fGEN_TCG_V6_vaddh_dv(SHORTCYDE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_16)
>>> +#define fGEN_TCG_V6_vaddw_dv(SHORTCODE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(add, MO_32)
>>>     /* Vector sub - various forms */
>>>   #define fGEN_TCG_V6_vsubb(SHORTCODE) \
>>>       tcg_gen_gvec_sub_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, VvV_base, \
>>> -                         VvV_off, sizeof(MMVector), sizeof(MMVector))
>>> +                         VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vsubh(SHORTCODE) \
>>>       tcg_gen_gvec_sub_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vsubw(SHORTCODE) \
>>>       tcg_gen_gvec_sub_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>   -#define fGEN_TCG_V6_vsubb_dv(SHORTCODE) \
>>> -    tcg_gen_gvec_sub_var(MO_8, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> -
>>> -#define fGEN_TCG_V6_vsubh_dv(SHORTCODE) \
>>> -    tcg_gen_gvec_sub_var(MO_16, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> -
>>> -#define fGEN_TCG_V6_vsubw_dv(SHORTCODE) \
>>> -    tcg_gen_gvec_sub_var(MO_32, VddV_base, VddV_off, VuuV_base,
>>> VuuV_off, \
>>> -                         VvvV_base, VvvV_off, sizeof(MMVector) * 2, \
>>> -                         sizeof(MMVector) * 2)
>>> +#define fGEN_TCG_V6_vsubb_dv(SHORTCODE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_8)
>>> +#define fGEN_TCG_V6_vsubh_dv(SHORTCODE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_16)
>>> +#define fGEN_TCG_V6_vsubw_dv(SHORTCODE)
>>> fGEN_TCG_PAIR_ADDSUB_BASIC(sub, MO_32)
>>>     #define fGEN_TCG_V6_vaddbsat(SHORTCODE) \
>>>       tcg_gen_gvec_ssadd_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> @@ -278,8 +268,14 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>                             VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_PAIR_ADDSUB(OP, VECE, DBASE, DST, ABASE, SRC_A,
>>> BBASE, SRC_B) \
>>> -    tcg_gen_gvec_##OP##_var(VECE, DBASE, DST, ABASE, SRC_A, BBASE,
>>> SRC_B, \
>>> -                           2 * VECTOR_SIZE_BYTE, 2 * VECTOR_SIZE_BYTE)
>>> +    do { \
>>> +        tcg_gen_gvec_##OP##_var(VECE, DBASE, DST, ABASE, SRC_A,
>>> BBASE, SRC_B, \
>>> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>> +        tcg_gen_gvec_##OP##_var(VECE, DBASE, DST + sizeof(MMVector), \
>>> +                                ABASE, SRC_A + sizeof(MMVector), \
>>> +                                BBASE, SRC_B + sizeof(MMVector), \
>>> +                                VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE); \
>>> +    } while (0)
>>>     #define fGEN_TCG_V6_vaddbsat_dv(SHORTCODE) \
>>>       fGEN_TCG_PAIR_ADDSUB(ssadd, MO_8, VddV_base, VddV_off, \
>>> @@ -458,7 +454,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 15); \
>>>           tcg_gen_gvec_sars_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vasrh_acc(SHORTCODE) \
>>> @@ -467,10 +463,10 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 15); \
>>>           tcg_gen_gvec_sars_var(MO_16, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>           tcg_gen_gvec_add_var(MO_16, VxV_base, VxV_off, VxV_base,
>>> VxV_off, \
>>> -                             tcg_env, tmpoff, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vasrw(SHORTCODE) \
>>> @@ -478,7 +474,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 31); \
>>>           tcg_gen_gvec_sars_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vasrw_acc(SHORTCODE) \
>>> @@ -487,10 +483,10 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 31); \
>>>           tcg_gen_gvec_sars_var(MO_32, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>           tcg_gen_gvec_add_var(MO_32, VxV_base, VxV_off, VxV_base,
>>> VxV_off, \
>>> -                             tcg_env, tmpoff, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vlsrb(SHORTCODE) \
>>> @@ -498,7 +494,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 7); \
>>>           tcg_gen_gvec_shrs_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vlsrh(SHORTCODE) \
>>> @@ -506,7 +502,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 15); \
>>>           tcg_gen_gvec_shrs_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vlsrw(SHORTCODE) \
>>> @@ -514,7 +510,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 31); \
>>>           tcg_gen_gvec_shrs_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     /* Vector shift left - various forms */
>>> @@ -523,7 +519,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 7); \
>>>           tcg_gen_gvec_shls_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vaslh(SHORTCODE) \
>>> @@ -531,7 +527,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 15); \
>>>           tcg_gen_gvec_shls_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vaslh_acc(SHORTCODE) \
>>> @@ -540,10 +536,10 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 15); \
>>>           tcg_gen_gvec_shls_var(MO_16, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>           tcg_gen_gvec_add_var(MO_16, VxV_base, VxV_off, VxV_base,
>>> VxV_off, \
>>> -                             tcg_env, tmpoff, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vaslw(SHORTCODE) \
>>> @@ -551,7 +547,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 31); \
>>>           tcg_gen_gvec_shls_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     #define fGEN_TCG_V6_vaslw_acc(SHORTCODE) \
>>> @@ -560,74 +556,74 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           TCGv shift = tcg_temp_new(); \
>>>           tcg_gen_andi_tl(shift, RtV, 31); \
>>>           tcg_gen_gvec_shls_var(MO_32, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                              shift, sizeof(MMVector),
>>> sizeof(MMVector)); \
>>> +                              shift, VECTOR_SIZE_BYTE,
>>> VECTOR_SIZE_BYTE); \
>>>           tcg_gen_gvec_add_var(MO_32, VxV_base, VxV_off, VxV_base,
>>> VxV_off, \
>>> -                             tcg_env, tmpoff, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             tcg_env, tmpoff, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>       } while (0)
>>>     /* Vector max - various forms */
>>>   #define fGEN_TCG_V6_vmaxw(SHORTCODE) \
>>>       tcg_gen_gvec_smax_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vmaxh(SHORTCODE) \
>>>       tcg_gen_gvec_smax_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vmaxuh(SHORTCODE) \
>>>       tcg_gen_gvec_umax_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vmaxb(SHORTCODE) \
>>>       tcg_gen_gvec_smax_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vmaxub(SHORTCODE) \
>>>       tcg_gen_gvec_umax_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>     /* Vector min - various forms */
>>>   #define fGEN_TCG_V6_vminw(SHORTCODE) \
>>>       tcg_gen_gvec_smin_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vminh(SHORTCODE) \
>>>       tcg_gen_gvec_smin_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vminuh(SHORTCODE) \
>>>       tcg_gen_gvec_umin_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vminb(SHORTCODE) \
>>>       tcg_gen_gvec_smin_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>   #define fGEN_TCG_V6_vminub(SHORTCODE) \
>>>       tcg_gen_gvec_umin_var(MO_8, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                          VvV_base, VvV_off, sizeof(MMVector), \
>>> -                          sizeof(MMVector))
>>> +                          VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                          VECTOR_SIZE_BYTE)
>>>     /* Vector logical ops */
>>>   #define fGEN_TCG_V6_vxor(SHORTCODE) \
>>>       tcg_gen_gvec_xor_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vand(SHORTCODE) \
>>>       tcg_gen_gvec_and_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         VvV_base, VvV_off, sizeof(MMVector), \
>>> -                         sizeof(MMVector))
>>> +                         VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                         VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vor(SHORTCODE) \
>>>       tcg_gen_gvec_or_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, VvV_base, \
>>> -                        VvV_off, sizeof(MMVector), sizeof(MMVector))
>>> +                        VvV_off, VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vnot(SHORTCODE) \
>>>       tcg_gen_gvec_not_var(MO_64, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     /* Q register logical ops */
>>>   #define fGEN_TCG_V6_pred_or(SHORTCODE) \
>>> @@ -659,8 +655,8 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>       do { \
>>>           intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>>>           tcg_gen_gvec_cmp_var(COND, TYPE, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                             VvV_base, VvV_off, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>           vec_to_qvec(SIZE, QdV_base, QdV_off, tcg_env, tmpoff); \
>>>       } while (0)
>>>   @@ -690,8 +686,8 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>           intptr_t tmpoff = offsetof(CPUHexagonState, vtmp); \
>>>           intptr_t qoff = offsetof(CPUHexagonState, qtmp); \
>>>           tcg_gen_gvec_cmp_var(COND, TYPE, tcg_env, tmpoff, VuV_base,
>>> VuV_off, \
>>> -                             VvV_base, VvV_off, sizeof(MMVector), \
>>> -                             sizeof(MMVector)); \
>>> +                             VvV_base, VvV_off, VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE); \
>>>           vec_to_qvec(SIZE, tcg_env, qoff, tcg_env, tmpoff); \
>>>           OP(MO_64, QxV_base, QxV_off, QxV_base, QxV_off, tcg_env,
>>> qoff, \
>>>              sizeof(MMQReg), sizeof(MMQReg)); \
>>> @@ -762,29 +758,29 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>     /* Vector splat - various forms */
>>>   #define fGEN_TCG_V6_lvsplatw(SHORTCODE) \
>>> -    tcg_gen_gvec_dup_i32_var(MO_32, VdV_base, VdV_off,
>>> sizeof(MMVector), \
>>> -                             sizeof(MMVector), RtV)
>>> +    tcg_gen_gvec_dup_i32_var(MO_32, VdV_base, VdV_off,
>>> VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE, RtV)
>>>     #define fGEN_TCG_V6_lvsplath(SHORTCODE) \
>>> -    tcg_gen_gvec_dup_i32_var(MO_16, VdV_base, VdV_off,
>>> sizeof(MMVector), \
>>> -                             sizeof(MMVector), RtV)
>>> +    tcg_gen_gvec_dup_i32_var(MO_16, VdV_base, VdV_off,
>>> VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE, RtV)
>>>     #define fGEN_TCG_V6_lvsplatb(SHORTCODE) \
>>> -    tcg_gen_gvec_dup_i32_var(MO_8, VdV_base, VdV_off,
>>> sizeof(MMVector), \
>>> -                             sizeof(MMVector), RtV)
>>> +    tcg_gen_gvec_dup_i32_var(MO_8, VdV_base, VdV_off,
>>> VECTOR_SIZE_BYTE, \
>>> +                             VECTOR_SIZE_BYTE, RtV)
>>>     /* Vector absolute value - various forms */
>>>   #define fGEN_TCG_V6_vabsb(SHORTCODE) \
>>>       tcg_gen_gvec_abs_var(MO_8, VdV_base, VdV_off, VuV_base, VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vabsh(SHORTCODE) \
>>>       tcg_gen_gvec_abs_var(MO_16, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     #define fGEN_TCG_V6_vabsw(SHORTCODE) \
>>>       tcg_gen_gvec_abs_var(MO_32, VdV_base, VdV_off, VuV_base,
>>> VuV_off, \
>>> -                         sizeof(MMVector), sizeof(MMVector))
>>> +                         VECTOR_SIZE_BYTE, VECTOR_SIZE_BYTE)
>>>     /* Vector loads */
>>>   #define fGEN_TCG_V6_vL32b_pi(SHORTCODE)                    SHORTCODE
>>> @@ -826,12 +822,12 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>       fGEN_TCG_PRED_VEC_LOAD(fLSBOLD(PvV), \
>>>                              fEA_REG(RxV), \
>>>                              VdV, \
>>> -                           fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                           fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>   #define fGEN_TCG_PRED_VEC_LOAD_npred_pi \
>>>       fGEN_TCG_PRED_VEC_LOAD(fLSBOLDNOT(PvV), \
>>>                              fEA_REG(RxV), \
>>>                              VdV, \
>>> -                           fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                           fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>     #define fGEN_TCG_V6_vL32b_pred_pi(SHORTCODE) \
>>>       fGEN_TCG_PRED_VEC_LOAD_pred_pi
>>> @@ -860,12 +856,12 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>     #define fGEN_TCG_PRED_VEC_LOAD_pred_ai \
>>>       fGEN_TCG_PRED_VEC_LOAD(fLSBOLD(PvV), \
>>> -                           fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                           fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                              VdV, \
>>>                              do {} while (0))
>>>   #define fGEN_TCG_PRED_VEC_LOAD_npred_ai \
>>>       fGEN_TCG_PRED_VEC_LOAD(fLSBOLDNOT(PvV), \
>>> -                           fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                           fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                              VdV, \
>>>                              do {} while (0))
>>>   @@ -950,7 +946,7 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>       } while (0)
>>>     #define fGEN_TCG_NEWVAL_VEC_STORE_pi \
>>> -    fGEN_TCG_NEWVAL_VEC_STORE(fEA_REG(RxV), fPM_I(RxV, siV *
>>> sizeof(MMVector)))
>>> +    fGEN_TCG_NEWVAL_VEC_STORE(fEA_REG(RxV), fPM_I(RxV, siV *
>>> VECTOR_SIZE_BYTE))
>>>     #define fGEN_TCG_V6_vS32b_new_pi(SHORTCODE) \
>>>       fGEN_TCG_NEWVAL_VEC_STORE_pi
>>> @@ -958,7 +954,7 @@ static inline void assert_vhist_tmp(DisasContext
>>> *ctx)
>>>       fGEN_TCG_NEWVAL_VEC_STORE_pi
>>>     #define fGEN_TCG_NEWVAL_VEC_STORE_ai \
>>> -    fGEN_TCG_NEWVAL_VEC_STORE(fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +    fGEN_TCG_NEWVAL_VEC_STORE(fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                                 do { } while (0))
>>>     #define fGEN_TCG_V6_vS32b_new_ai(SHORTCODE) \
>>> @@ -992,22 +988,22 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>>>                               fEA_REG(RxV), \
>>>                               VsV, ALIGN, \
>>> -                            fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>   #define fGEN_TCG_PRED_VEC_STORE_npred_pi(ALIGN) \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>>>                               fEA_REG(RxV), \
>>>                               VsV, ALIGN, \
>>> -                            fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>   #define fGEN_TCG_PRED_VEC_STORE_new_pred_pi \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>>>                               fEA_REG(RxV), \
>>>                               OsN, true, \
>>> -                            fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>   #define fGEN_TCG_PRED_VEC_STORE_new_npred_pi \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>>>                               fEA_REG(RxV), \
>>>                               OsN, true, \
>>> -                            fPM_I(RxV, siV * sizeof(MMVector)))
>>> +                            fPM_I(RxV, siV * VECTOR_SIZE_BYTE))
>>>     #define fGEN_TCG_V6_vS32b_pred_pi(SHORTCODE) \
>>>       fGEN_TCG_PRED_VEC_STORE_pred_pi(true)
>>> @@ -1032,22 +1028,22 @@ static inline void
>>> assert_vhist_tmp(DisasContext *ctx)
>>>     #define fGEN_TCG_PRED_VEC_STORE_pred_ai(ALIGN) \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>>> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                               VsV, ALIGN, \
>>>                               do { } while (0))
>>>   #define fGEN_TCG_PRED_VEC_STORE_npred_ai(ALIGN) \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>>> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                               VsV, ALIGN, \
>>>                               do { } while (0))
>>>   #define fGEN_TCG_PRED_VEC_STORE_new_pred_ai \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLD(PvV), \
>>> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                               OsN, true, \
>>>                               do { } while (0))
>>>   #define fGEN_TCG_PRED_VEC_STORE_new_npred_ai \
>>>       fGEN_TCG_PRED_VEC_STORE(fLSBOLDNOT(PvV), \
>>> -                            fEA_RI(RtV, siV * sizeof(MMVector)), \
>>> +                            fEA_RI(RtV, siV * VECTOR_SIZE_BYTE), \
>>>                               OsN, true, \
>>>                               do { } while (0))
>>>   diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/
>>> macros.h
>>> index 74c277fc06f..2bf360dd2c1 100644
>>> --- a/target/hexagon/mmvec/macros.h
>>> +++ b/target/hexagon/mmvec/macros.h
>>> @@ -221,7 +221,7 @@
>>>   #define SCATTER_OP_WRITE_TO_MEM(TYPE) \
>>>       do { \
>>>           ra = GETPC(); \
>>> -        for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>>> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES; i += sizeof(TYPE)) { \
>>>               if (test_bit(i, env->vtcm_log.mask)) { \
>>>                   TYPE dst = 0; \
>>>                   TYPE inc = 0; \
>>> @@ -244,7 +244,7 @@
>>>       } while (0)
>>>   #define SCATTER_OP_PROBE_MEM(TYPE, MMU_IDX, RETADDR) \
>>>       do { \
>>> -        for (int i = 0; i < sizeof(MMVector); i += sizeof(TYPE)) { \
>>> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES; i += sizeof(TYPE)) { \
>>>               if (test_bit(i, env->vtcm_log.mask)) { \
>>>                   for (int j = 0; j < sizeof(TYPE); j++) { \
>>>                       probe_read(env, env->vtcm_log.va[i + j], 1, \
>>> @@ -329,8 +329,8 @@
>>>   #endif
>>>   #define fVFOREACH(WIDTH, VAR) for (VAR = 0; VAR < fVELEM(WIDTH);
>>> VAR++)
>>>   #define fVARRAY_ELEMENT_ACCESS(ARRAY, TYPE, INDEX) \
>>> -    ARRAY.v[(INDEX) / (fVECSIZE() /
>>> (sizeof(ARRAY.TYPE[0])))].TYPE[(INDEX) % \
>>> -    (fVECSIZE() / (sizeof(ARRAY.TYPE[0])))]
>>> +    ARRAY.v[(INDEX) / (fVECSIZE() / (sizeof(ARRAY.v[0].TYPE[0])))] \
>>> +        .TYPE[(INDEX) % (fVECSIZE() / (sizeof(ARRAY.v[0].TYPE[0])))]
>>>     #define fVSATDW(U, V) fVSATW(((((long long)U) << 32) | fZXTN(32,
>>> 64, V)))
>>>   #define fVASL_SATHI(U, V) fVSATW(((U) << 1) | ((V) >> 31))
>>> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
>>> index cd4ae2f6838..845854f7bb7 100644
>>> --- a/target/hexagon/genptr.c
>>> +++ b/target/hexagon/genptr.c
>>> @@ -1508,9 +1508,9 @@ static void gen_vreg_load(DisasContext *ctx,
>>> TCGv_ptr dstbase,
>>>   {
>>>       TCGv_i64 tmp = tcg_temp_new_i64();
>>>       if (aligned) {
>>> -        tcg_gen_andi_tl(src, src, ~((int32_t)sizeof(MMVector) - 1));
>>> +        tcg_gen_andi_tl(src, src, ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
>>>       }
>>> -    for (int i = 0; i < sizeof(MMVector) / 8; i++) {
>>> +    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; i++) {
>>>           tcg_gen_qemu_ld_i64(tmp, src, ctx->mem_idx, MO_LE | MO_UQ);
>>>           tcg_gen_addi_tl(src, src, 8);
>>>           tcg_gen_st_i64(tmp, dstbase, dstoff + i * 8);
>>> @@ -1532,15 +1532,15 @@ static void gen_vreg_store(DisasContext *ctx,
>>> TCGv EA, TCGv_ptr srcbase,
>>>       tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
>>>       if (aligned) {
>>>           tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
>>> -                        ~((int32_t)sizeof(MMVector) - 1));
>>> +                        ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
>>>       } else {
>>>           tcg_gen_mov_tl(hex_vstore_addr[slot], EA);
>>>       }
>>> -    tcg_gen_movi_tl(hex_vstore_size[slot], sizeof(MMVector));
>>> +    tcg_gen_movi_tl(hex_vstore_size[slot], MAX_VEC_SIZE_BYTES);
>>>         /* Copy the data to the vstore buffer */
>>>       tcg_gen_gvec_mov_var(MO_64, tcg_env, dstoff, srcbase, srcoff,
>>> -                         sizeof(MMVector), sizeof(MMVector));
>>> +                         MAX_VEC_SIZE_BYTES, MAX_VEC_SIZE_BYTES);
>>>       /* Set the mask to all 1's */
>>>       tcg_gen_gvec_dup_imm(MO_64, maskoff, sizeof(MMQReg),
>>> sizeof(MMQReg), ~0LL);
>>>   }
>>> @@ -1555,12 +1555,12 @@ static void
>>> gen_vreg_masked_store(DisasContext *ctx, TCGv EA,
>>>         tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
>>>       tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
>>> -                    ~((int32_t)sizeof(MMVector) - 1));
>>> -    tcg_gen_movi_tl(hex_vstore_size[slot], sizeof(MMVector));
>>> +                    ~((int32_t)MAX_VEC_SIZE_BYTES - 1));
>>> +    tcg_gen_movi_tl(hex_vstore_size[slot], MAX_VEC_SIZE_BYTES);
>>>         /* Copy the data to the vstore buffer */
>>>       tcg_gen_gvec_mov_var(MO_64, tcg_env, dstoff, srcbase, srcoff,
>>> -                         sizeof(MMVector), sizeof(MMVector));
>>> +                         MAX_VEC_SIZE_BYTES, MAX_VEC_SIZE_BYTES);
>>>       /* Copy the mask */
>>>       tcg_gen_gvec_mov_var(MO_64, tcg_env, maskoff, bitsbase, bitsoff,
>>>                            sizeof(MMQReg), sizeof(MMQReg));
>>> @@ -1580,7 +1580,7 @@ static void vec_to_qvec(size_t size, TCGv_ptr
>>> dstbase, intptr_t dstoff,
>>>       TCGv_i64 zero = tcg_constant_i64(0);
>>>       TCGv_i64 ones = tcg_constant_i64(~0);
>>>   -    for (int i = 0; i < sizeof(MMVector) / 8; i++) {
>>> +    for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; i++) {
>>>           tcg_gen_ld_i64(tmp, srcbase, srcoff + i * 8);
>>>           tcg_gen_movi_i64(mask, 0);
>>>   diff --git a/target/hexagon/mmvec/system_ext_mmvec.c b/target/
>>> hexagon/mmvec/system_ext_mmvec.c
>>> index 081cadd814a..3777f68d6e7 100644
>>> --- a/target/hexagon/mmvec/system_ext_mmvec.c
>>> +++ b/target/hexagon/mmvec/system_ext_mmvec.c
>>> @@ -21,15 +21,13 @@
>>>     void mem_gather_store(CPUHexagonState *env, target_ulong vaddr,
>>> int slot)
>>>   {
>>> -    size_t size = sizeof(MMVector);
>>> -
>>>       env->vstore_pending[slot] = 1;
>>>       env->vstore[slot].va   = vaddr;
>>> -    env->vstore[slot].size = size;
>>> -    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0], size);
>>> +    env->vstore[slot].size = MAX_VEC_SIZE_BYTES;
>>> +    memcpy(&env->vstore[slot].data, &env->tmp_VRegs[0],
>>> MAX_VEC_SIZE_BYTES);
>>>         /* On a gather store, overwrite the store mask to emulate
>>> dropped gathers */
>>> -    bitmap_copy(env->vstore[slot].mask, env->vtcm_log.mask, size);
>>> +    bitmap_copy(env->vstore[slot].mask, env->vtcm_log.mask,
>>> MAX_VEC_SIZE_BYTES);
>>>   }
>>>     void mem_vector_scatter_init(CPUHexagonState *env)
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 4f00ca773f3..4d948d548bc 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -191,7 +191,7 @@ void HELPER(commit_hvx_stores)(CPUHexagonState *env)
>>>                   g_assert_not_reached();
>>>               }
>>>           } else {
>>> -            for (int i = 0; i < sizeof(MMVector); i++) {
>>> +            for (int i = 0; i < MAX_VEC_SIZE_BYTES; i++) {
>>>                   if (test_bit(i, env->vtcm_log.mask)) {
>>>                       cpu_stb_data_ra(env, env->vtcm_log.va[i],
>>>                                        hexagon_mmvec_get_byte(&env-
>>> >vtcm_log.data,
>>> @@ -491,7 +491,7 @@ static void probe_hvx_stores(CPUHexagonState
>>> *env, int mmu_idx,
>>>                   g_assert_not_reached();
>>>               }
>>>           } else {
>>> -            for (int i = 0; i < sizeof(MMVector); i++) {
>>> +            for (int i = 0; i < MAX_VEC_SIZE_BYTES; i++) {
>>>                   if (test_bit(i, env->vtcm_log.mask)) {
>>>                       probe_write(env, env->vtcm_log.va[i], 1,
>>> mmu_idx, retaddr);
>>>                   }
>>> @@ -1408,14 +1408,14 @@ void HELPER(vhist)(CPUHexagonState *env)
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>         for (int lane = 0; lane < 8; lane++) {
>>> -        for (int i = 0; i < sizeof(MMVector) / 8; ++i) {
>>> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; ++i) {
>>>               unsigned char value = hexagon_mmvec_get_byte(input,
>>> -                (sizeof(MMVector) / 8) * lane + i);
>>> +                (MAX_VEC_SIZE_BYTES / 8) * lane + i);
>>>               unsigned char regno = value >> 3;
>>>               unsigned char element = value & 7;
>>>                 hex_hvx(env)->VRegs[regno]
>>> -                .uh[(sizeof(MMVector) / 16) * lane + element]++;
>>> +                .uh[(MAX_VEC_SIZE_BYTES / 16) * lane + element]++;
>>>           }
>>>       }
>>>   }
>>> @@ -1425,15 +1425,15 @@ void HELPER(vhistq)(CPUHexagonState *env)
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>         for (int lane = 0; lane < 8; lane++) {
>>> -        for (int i = 0; i < sizeof(MMVector) / 8; ++i) {
>>> +        for (int i = 0; i < MAX_VEC_SIZE_BYTES / 8; ++i) {
>>>               unsigned char value = hexagon_mmvec_get_byte(input,
>>> -                (sizeof(MMVector) / 8) * lane + i);
>>> +                (MAX_VEC_SIZE_BYTES / 8) * lane + i);
>>>               unsigned char regno = value >> 3;
>>>               unsigned char element = value & 7;
>>>   -            if (fGETQBIT(env->qtmp, sizeof(MMVector) / 8 * lane +
>>> i)) {
>>> +            if (fGETQBIT(env->qtmp, MAX_VEC_SIZE_BYTES / 8 * lane +
>>> i)) {
>>>                   hex_hvx(env)->VRegs[regno].uh[
>>> -                    (sizeof(MMVector) / 16) * lane + element]++;
>>> +                    (MAX_VEC_SIZE_BYTES / 16) * lane + element]++;
>>>               }
>>>           }
>>>       }
>>> @@ -1443,7 +1443,7 @@ void HELPER(vwhist256)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1458,7 +1458,7 @@ void HELPER(vwhist256q)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1475,7 +1475,7 @@ void HELPER(vwhist256_sat)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1490,7 +1490,7 @@ void HELPER(vwhist256q_sat)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1507,7 +1507,7 @@ void HELPER(vwhist128)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1522,7 +1522,7 @@ void HELPER(vwhist128q)(CPUHexagonState *env)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1539,7 +1539,7 @@ void HELPER(vwhist128m)(CPUHexagonState *env,
>>> int32_t uiV)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>>> @@ -1556,7 +1556,7 @@ void HELPER(vwhist128qm)(CPUHexagonState *env,
>>> int32_t uiV)
>>>   {
>>>       MMVector *input = &env->tmp_VRegs[0];
>>>   -    for (int i = 0; i < (sizeof(MMVector) / 2); i++) {
>>> +    for (int i = 0; i < (MAX_VEC_SIZE_BYTES / 2); i++) {
>>>           unsigned int bucket = fGETUBYTE(0, input->h[i]);
>>>           unsigned int weight = fGETUBYTE(1, input->h[i]);
>>>           unsigned int vindex = (bucket >> 3) & 0x1F;
>> It seems that this patch do different kind of changes, and uses various
>> values:
>> - keep sizeof(MMVector) is some macros (?), like
>> fGEN_TCG_PAIR_ADDSUB_BASIC.
>> - use MAX_VEC_SIZE_BYTES
>> - use VECTOR_SIZE_BYTE
>>
>> What's the difference between those cases?
> 
> 
> Yeah: it's a bit confusing and pretty easy to get wrong.
> sizeof(MMVector) includes the vector and the "extended QFloat" precision
> that's lost on loads/stores.  MAX_VEC_SIZE_BYTES and VECTOR_SIZE_BYTE
> include just the register content.  The distinction between these two is
> because there's a 64-byte mode of Hexagon HVX that's not (yet?)
> supported by QEMU.
> 
> 
> I will change it like so in order to make it harder to get wrong and
> easier to review:
> 
> 
> - replace some VECTOR_SIZE_BYTE or MAX_VEC_SIZE_BYTES based expressions
> with sizeof_field() / sizeof() as appropriate
> 
> - for any remaining equivalent-but-different-semantic expressions, add
> some BUILD_BUG_ON to check them
>

Distinct patches with distinct commit messages are welcome also, to
differentiate the various replacements.

> 
>>
>> Regards,
>> Pierrick



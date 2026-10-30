Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gE6Gjk8f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iDCqgXEO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaLy-0001LQ-Or; Thu, 29 Oct 2026 20:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaLv-0001JC-DS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:20:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaLt-0001v4-8U
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:20:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKL8h1529957
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j5fIotj24/9KD11n5qlqkUNTRRY+p27lI9eQ9IfqSgU=; b=gE6Gjk8fF2d+L+vx
 Jut5saZHLlG/m5S1rHMwwdJQTeCUfzrlK0fA5KUOuye4t6xs1YMn1nUtV/9041lg
 Bm+IIKeKz1sb9Ir/G2KA1uDMNfR1aC+Hrhvd0OXHnZGpuKRv4ogHHk0G3RGGd2SF
 pmW7eyZBURq7m7/B9puQk25ql4SopM8xlkPn9fVlse0eH0KqBF3uQNXmN59RueAj
 k0vsDo9R82MBjSBWqapke1dZEX5GDx78NYt45PQA5kgdvspxNP+0aNeJNXhzTgio
 u8r25A842yvdX8ZqUkx4CmAmzgqVy/3OIlguWLJZ00mfVN178B3KvLKDOKdB58Yu
 61zfpg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qgf6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:20:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so20270285a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793319610; x=1793924410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j5fIotj24/9KD11n5qlqkUNTRRY+p27lI9eQ9IfqSgU=;
 b=iDCqgXEO1//n6VPmhky72HJ+3789OZguHIEGltQs1ldwIE30xpTNVEUlZHuvcf7L3B
 NEmQVExL/wjHLcjY+Ryn61QCWPpcgiBKEHVrW3n7eWlZ5zn+qrGfFNjlBg7vdYOusI2d
 HlsslF6+MkZnOBJ+Mqq88Aib37yPCoM51Rxo1ClvKceLfCTPBEfNErNLc/FftE7h6kVc
 0kPGmeX9fBQQOkavkPx4tzOzUcZcthrObnztW3MNaIrr5ZxCylV3QX6ycfNLDVYec9zK
 ojkEuSAY0YEk30JDuxOs8/UiH3oY9B71DneVUCSjHp/GKwPpvjs926rCa2Kl3bxINFdY
 cJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319610; x=1793924410;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j5fIotj24/9KD11n5qlqkUNTRRY+p27lI9eQ9IfqSgU=;
 b=GiJONqyAGzEkcYuFOKvwGUybXJycBF+fqWhMxAoDxFeIQVkqcuBbrLMSQXsOWCkgaM
 sElzUMrtI4M0AtZMbdMYn5NMaGZrNlCOHh6oxkMXrUV2HGDyjUsGX7sWGUXR6GxjmOER
 IfAXzJ8AbQDG4eZimtJwjqJJOEu9ghLvMcO3SS+kHhzztCaKWGRAI0aN3DjG7bPfmuqI
 TYCuTK4cAq1DMqzAiMq6A9xTKTAXfiy4Zlk4jl+HhWZgkglKkDm9LPfM0Za2WmvBl8jQ
 QaMEAb1HtTirsYaX7ezMusb0QuUTh7NAi7N0LzdlivtiZlBlvdCTHD4wUaMnlpcsmrHO
 wCkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMG+u7EUl2nRXsNyPubnoD+EmrUD08C1OkPjMIszUuLj2nkOO2+IylpcEKvdSPqsnnzO6acel7rynz@nongnu.org
X-Gm-Message-State: AFq9FYKBJW2b1NnpUIaeS0TjkAufMNSazVfVFaVRvNljeg5844OBQ4Q2
 kD8g85hr+rNDtBCTLRN0WrQsiRt5j7UZwJApo1EAE8q58HNv8OF3luYHHJ3G1Zf+WqfCUKW3vRx
 rXvr+MGzIhxUJAM69YFGwf2gcU89ax0K/FKjf/Dc4ZOx7s6PFRbpDOTNrSQ==
X-Gm-Gg: AYBFou3jQBl4nx4adFrBSeCSI4hzp5QG0A+0Hx0ZXNkKd8MZrcozNWZe/OR2bD1almH
 wJhvKPECs5JJOA9ud234wZW1Z/XXVdTPr83RemZVJiG7hj4ekwUIR6CQBakTKZcRS+lOVAO1I2/
 LXB7/TYNzoMd6iCNzlKXsYTOT/DEAGmwifgG12rXgeAMHl/AOgypZOH3U+pHJdX8vrS5lWNrPMK
 VFzYvNJ1lFwa4B9X9sbARJbAnmvr155laTfIER7TyxaXQjwuYKCEg+3MZyqD4G7XQ3DeqPBmc1c
 KdB61fOUv1ESCIEA0kx3P22QZ26Pq1iFjCnUM6T4x2cKhddyze3bOrXJf55CK5mUJxWDCYN4LFT
 XmtnNEkS09k5Y6ydvQjxi6fhzh36BTzXgak/RRX9FZnrRkWxMFl75q607K3klFTCFUNISSY3TzR
 VzOEFsszpu/TStUelmsnQE1bOzPwCJTezGRK+U/Uvmz4h2K0bdJfOG
X-Received: by 2002:a05:620a:4627:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-94421585475mr152986985a.5.1793319610256; 
 Thu, 29 Oct 2026 17:20:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4627:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-94421585475mr152982085a.5.1793319609759; 
 Thu, 29 Oct 2026 17:20:09 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425ab9c73sm581385a.34.2026.10.29.17.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:20:08 -0700 (PDT)
Message-ID: <f69e9bc7-8910-4448-b497-7e29558ecc1b@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:20:07 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] target/hexagon: add HLX absdiff and sign-fill gvec
 operations
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-11-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-11-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iUSsEPelCKRWqypfvPdeKppsUrX_Vm3i
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae3e2bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=CcBTekESmXp-EHdDyGkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX7vUkUI17ELXO
 v0PE4sXTPEQNDQxvwylDKgTtxKRJ7tw5FAWTUMpsKVse/jLGfOy6ddZ6OuVorshqhh9aEAYPFWY
 0cgTHjePoGTAP6dl5g0o6ePmA2zh48HqwOgZvzN8BvYmJ75jrCHfwrJpNXQg2DnxUw9jbyMClgX
 /BNN9SwN+E+2Wz3D2p+3QXo+3DXZOSkjoRd4XMKtyBExV1kg/cpGdFyAp2U4TX556DYbn6ID3Il
 tJuUJOLiQw9SdXKEnEYGdbPO7H2wt7tOubqNHueaTzHR1ldM9U1tJskeUbTQvwdtA63BLWuWSNQ
 siPeDbm7IRlqiMCU7R4c3h5sKYSWcUVpc/lLL5D8ukP0UeDvCRaZBstnu/k4hV32K91bAvapetg
 8A6ITHLrOWM28bfNAnOcQVXQ+5oMlr3yGkWOwnBHEl5uku6NSVCRxnhOATp/F4pvBiu0vYurr6U
 HJ2J2rxRwnH5Z6Wz1EA==
X-Proofpoint-ORIG-GUID: iUSsEPelCKRWqypfvPdeKppsUrX_Vm3i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX6bg+5ScVYgHm
 9owjgcj8gpG7YPu+2t2AOEMcnSpdE0NpYPRlX+ZUgi7EAzucbrjKELUvW0bBdJrMD64YmkQAc2f
 C1LVzBEY4fJA5ykkhkgcIRFQ1ruuAMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> Add gvec helpers for halfword absolute difference and sign fill.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h          |  9 +++++
>   target/hexagon/hex_common.py     | 10 +++++
>   target/hexagon/hlx_gvec_tables.c | 68 ++++++++++++++++++++++++++++++++
>   target/hexagon/hlx_gvec_tables.h |  5 +++
>   target/hexagon/hlx_helper.c      | 39 ++++++++++++++++++
>   5 files changed, 131 insertions(+)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index f42cb8d9b6..1ced8c5651 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -54,6 +54,15 @@ DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16, TCG_CALL_NO_RWG,
>   DEF_HELPER_FLAGS_4(hlx_gvec_avg_uh16_rnd, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, i32)
>   
> +/* GVec helpers for MO_16 absolute differences. */
> +DEF_HELPER_FLAGS_4(hlx_gvec_absdiff_sh16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(hlx_gvec_absdiff_uh16, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, i32)
> +
> +/* GVec helper for a halfword arithmetic shift by 15. */
> +DEF_HELPER_FLAGS_3(hlx_gvec_sari15_h16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
> +
>   /* Floating point */
>   DEF_HELPER_3(conv_sf2df, f64, env, f32, i32)
>   DEF_HELPER_3(conv_df2sf, f32, env, f64, i32)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index d0b36b8e06..fc6f69b411 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -404,6 +404,16 @@ def skip_qemu_helper(tag):
>                            "vece": "MO_16"},
>       "LX_avg_uh_rnd":    {"op": "gvec3", "table": "hlx_avg_uh_rnd_op",
>                            "vece": "MO_16"},
> +    "LX_absdiff_h":     {"op": "gvec3", "table": "hlx_absdiff_sh_op",
> +                         "vece": "MO_16"},
> +    "LX_absdiff_uh":    {"op": "gvec3", "table": "hlx_absdiff_uh_op",
> +                         "vece": "MO_16"},
> +
> +    # These use one source register, not a pair destination.
> +    "LX_conv_uw_uh":    {"op": "conv_h_to_w_pair", "sign_extend": False,
> +                         "vece": "MO_16"},
> +    "LX_conv_w_h":      {"op": "conv_h_to_w_pair", "sign_extend": True,
> +                         "vece": "MO_16", "table": "hlx_sari15_h_op"},
>   }
>   
>   def is_hlx_inline_tag(tag):
> diff --git a/target/hexagon/hlx_gvec_tables.c b/target/hexagon/hlx_gvec_tables.c
> index a5d40e149c..f1e36bd20b 100644
> --- a/target/hexagon/hlx_gvec_tables.c
> +++ b/target/hexagon/hlx_gvec_tables.c
> @@ -216,3 +216,71 @@ const GVecGen3 hlx_avg_uh_rnd_op = {
>       .fno     = gen_helper_hlx_gvec_avg_uh16_rnd,
>       .vece    = MO_16,
>   };
> +
> +/* Halfword absolute difference as uint16_t. */
> +static void hlx_fniv_absdiff_sh(unsigned vece, TCGv_vec r,
> +                                 TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec mx = tcg_temp_new_vec_matching(r);
> +    TCGv_vec mn = tcg_temp_new_vec_matching(r);
> +    tcg_gen_smax_vec(vece, mx, a, b);
> +    tcg_gen_smin_vec(vece, mn, a, b);
> +    tcg_gen_sub_vec(vece, r, mx, mn);
> +}
> +
> +static void hlx_fniv_absdiff_uh(unsigned vece, TCGv_vec r,
> +                                 TCGv_vec a, TCGv_vec b)
> +{
> +    TCGv_vec mx = tcg_temp_new_vec_matching(r);
> +    TCGv_vec mn = tcg_temp_new_vec_matching(r);
> +    tcg_gen_umax_vec(vece, mx, a, b);
> +    tcg_gen_umin_vec(vece, mn, a, b);
> +    tcg_gen_sub_vec(vece, r, mx, mn);
> +}
> +
> +static const TCGOpcode hlx_vecop_absdiff_sh[] = {
> +    INDEX_op_smax_vec,
> +    INDEX_op_smin_vec,
> +    INDEX_op_sub_vec,
> +    0
> +};
> +
> +static const TCGOpcode hlx_vecop_absdiff_uh[] = {
> +    INDEX_op_umax_vec,
> +    INDEX_op_umin_vec,
> +    INDEX_op_sub_vec,
> +    0
> +};
> +
> +const GVecGen3 hlx_absdiff_sh_op = {
> +    .fniv    = hlx_fniv_absdiff_sh,
> +    .opt_opc = hlx_vecop_absdiff_sh,
> +    .fno     = gen_helper_hlx_gvec_absdiff_sh16,
> +    .vece    = MO_16,
> +};
> +
> +const GVecGen3 hlx_absdiff_uh_op = {
> +    .fniv    = hlx_fniv_absdiff_uh,
> +    .opt_opc = hlx_vecop_absdiff_uh,
> +    .fno     = gen_helper_hlx_gvec_absdiff_uh16,
> +    .vece    = MO_16,
> +};
> +
> +/* Fill LX_conv_w_h's high register with sign bits. */
> +
> +static void hlx_fniv_sari15_h(unsigned vece, TCGv_vec r, TCGv_vec a)
> +{
> +    tcg_gen_sari_vec(vece, r, a, 15);
> +}
> +
> +static const TCGOpcode hlx_vecop_sari15_h[] = {
> +    INDEX_op_sari_vec,
> +    0
> +};
> +
> +const GVecGen2 hlx_sari15_h_op = {
> +    .fniv    = hlx_fniv_sari15_h,
> +    .opt_opc = hlx_vecop_sari15_h,
> +    .fno     = gen_helper_hlx_gvec_sari15_h16,
> +    .vece    = MO_16,
> +};
> diff --git a/target/hexagon/hlx_gvec_tables.h b/target/hexagon/hlx_gvec_tables.h
> index e01c853eb1..4375bf3ff8 100644
> --- a/target/hexagon/hlx_gvec_tables.h
> +++ b/target/hexagon/hlx_gvec_tables.h
> @@ -17,4 +17,9 @@ extern const GVecGen3 hlx_avg_sh_rnd_op;
>   extern const GVecGen3 hlx_avg_uh_op;
>   extern const GVecGen3 hlx_avg_uh_rnd_op;
>   
> +extern const GVecGen3 hlx_absdiff_sh_op;
> +extern const GVecGen3 hlx_absdiff_uh_op;
> +
> +extern const GVecGen2 hlx_sari15_h_op;
> +
>   #endif /* HLX_GVEC_TABLES_H */
> diff --git a/target/hexagon/hlx_helper.c b/target/hexagon/hlx_helper.c
> index c624b66f83..c063706cfa 100644
> --- a/target/hexagon/hlx_helper.c
> +++ b/target/hexagon/hlx_helper.c
> @@ -195,3 +195,42 @@ void HELPER(hlx_gvec_avg_uh16_rnd)(void *d, void *a, void *b, uint32_t desc)
>           *(uint16_t *)((char *)d + i) = r;
>       }
>   }
> +
> +void HELPER(hlx_gvec_absdiff_sh16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t av = *(int16_t *)((char *)a + i);
> +        int16_t bv = *(int16_t *)((char *)b + i);
> +        int16_t mx = (av > bv) ? av : bv;
> +        int16_t mn = (av > bv) ? bv : av;
> +        *(uint16_t *)((char *)d + i) = (uint16_t)(mx - mn);
> +    }
> +}
> +
> +void HELPER(hlx_gvec_absdiff_uh16)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
> +        uint16_t av = *(uint16_t *)((char *)a + i);
> +        uint16_t bv = *(uint16_t *)((char *)b + i);
> +        uint16_t mx = (av > bv) ? av : bv;
> +        uint16_t mn = (av > bv) ? bv : av;
> +        *(uint16_t *)((char *)d + i) = mx - mn;
> +    }
> +}
> +
> +void HELPER(hlx_gvec_sari15_h16)(void *d, void *a, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        int16_t av = *(int16_t *)((char *)a + i);
> +        *(uint16_t *)((char *)d + i) = (uint16_t)(av >> 15);
> +    }
> +}


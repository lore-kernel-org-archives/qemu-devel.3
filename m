Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2660A260C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O6FvJciY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cjB8j9QW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnr2-0006LH-PE; Fri, 30 Oct 2026 10:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnqp-0006Bv-6l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnqi-0005H4-MP
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERGVt2495208
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QZ+4hL+ikPbT+Ri4skBft/2kbeOGCUGKqhiuJEeuifk=; b=O6FvJciYDi+Ymarv
 G8wr2h5TU6ebi2R//Kbn7r+Q4OPImU4gAgikDZJnxWE5aNhT+wStec3VyJ3dvyBg
 8UN2CExgo5q55SDxVEADTboGvmSMnKbJyx05Vmb5zmc+H+c8qsbXobplUfjB3s+7
 pUUxEuPox6cXN1RznBFDBN/BRnxcPqT1j2svuOIaqf917i7BhPlPpjDsYNHEI6my
 kt2X1ABwn2+6At1hr8U0hOd1uJ5OyEek1bXPlx5efYhZwCndEcjOfaL/2B7kNHoy
 kf8Zq45gz4LCcJPEeHpsLFYrkwYbls5/v3mH+p/P24Go2DuDqW3mlbxeU8EwnCk+
 ztq60w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3kup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:44:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-536778a8137so14039521cf.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371494; x=1793976294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QZ+4hL+ikPbT+Ri4skBft/2kbeOGCUGKqhiuJEeuifk=;
 b=cjB8j9QWKEu7FSNbMBxcj87UHCbumnbPv0QsyJYR6rbTArOjY862OezGw1LCBdQAAV
 4PdPV/+qyaLUqMOE6pBPamiC2uk7Fjv0DYOBGsqAyWwXqWJWqEfILCVMUDdTl5pqcqBo
 y5MJH9BTZZAilE+jKtSbUGiEcIFeAEZJbT76vp+N5nB/BX8we05neWvK+wuRNxk5KoFN
 7zIJDz7krc29/vVqus0qmr980nun69Gv+6CfTCbxrTU+5uDR0xhx1LILYBk26M7WcIh+
 jLBThTQzCheX4QDuEq3QfZWvX/jCHz/PEpUqrzuhale+xq4cGV9aWuD+fjkGfe15RFvG
 acFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371494; x=1793976294;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QZ+4hL+ikPbT+Ri4skBft/2kbeOGCUGKqhiuJEeuifk=;
 b=tiJcHXLMpe8pxioq+ocgy26Bycp/6/n9ALB78BJKvURoAgn6gcBFdMZd0+hEKGHGhI
 UXaugbP4qy+lPNIdN/Eiy/VvPFPmoDf3loQ4JjOq4AUNwL6NmKKgseaSjAOQ/txZaAB9
 s9ITSPKrD3fvu0LZbgL4lLG8bnYtdTpm/v3+1pWG2hcrQI0FLME4FnrL5VBMTDfMHQV3
 1kAeC6HpURxJj0YcvYs5qMBXbio0Q125xcA8Z0ocPaFAZZKxq5c8UZShcB9oWatZFIV3
 YIyQNtG0oFawk2IzQGxbIcPGhSeMNPhflClaZBp0KG2DYXGhFqDs1gByJRdZ6qtwN+Kl
 hjtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWaUX1h6PdEETNMPmdNv0noFkSYYrMM+ACBOZO2pm64ItQ01+roRU2ybMSaLdp6rQ2bE61VYbOQDNZ@nongnu.org
X-Gm-Message-State: AFq9FYIUbt2d5PrQGhtWrrpV73bVyzV/PJZpKnwOv67Vj9DRYOFNqBiB
 rd/d1TODg5WD0uHAA3DtlxZAsdoy5ivJIAATFBzPhxovvFUS7YH91nBgOVUmObm6esIFoz1C/Oy
 wSqUC+O1rTch1RRtpBcrMIk38WPvg314rlAhHlHld3YN5Z0eCX7X3RTnVkA==
X-Gm-Gg: AYBFou2jA9G/VKnZzkX4i1xPvXq5BG4RJJXZEhHhxgH+jPBkd9fJeqzsf/KPcOo1NKR
 scGoLlsRLkxKUslzBdJedkq5D8lV4/0P1W7atPRkiU2OXMIi3FD9pTkYd2ylZSir5beuz3uGE2a
 pk8MzzqVkoG+X4H8BarkGrmwE0aVzWhf/v2ECuQNZirUe1lv53Mx/9G6JU2OYr8qpwWDnpGC32g
 TLJm5OwLRK+ktBYkqoOvlyHPFye/LpLCr+tuyb0eB/3gMWM8HQdPpwFMJIT8KyPUn6sip5nujyK
 mxGo2MaHWaRTCAI45uQvVcSonae3J6FU/Wh0arKAPWQji3CsBRwQSQ208aZaBCU+fS0vib99WsB
 SCjw/jfP7EW9PorBr+3wTpUmfNXmpWhV1qy/9NwVRb8W8MJ1cTOkDm/wnNPARW2UWDUSdxSleaU
 Hzbbi7TULdNX4XvSO4Sp/zFk/Fph0belbRSFwuJA==
X-Received: by 2002:a05:622a:2306:b0:536:7113:5dbb with SMTP id
 d75a77b69052e-542b87da525mr36157901cf.76.1793371493449; 
 Fri, 30 Oct 2026 07:44:53 -0700 (PDT)
X-Received: by 2002:a05:622a:2306:b0:536:7113:5dbb with SMTP id
 d75a77b69052e-542b87da525mr36157091cf.76.1793371492570; 
 Fri, 30 Oct 2026 07:44:52 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5431246c7casm15052491cf.19.2026.10.30.07.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:44:51 -0700 (PDT)
Message-ID: <826685b1-b030-420e-b87f-bcda5eb30b92@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:44:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] target/hexagon: add HLX shift, average and lookup
 instructions
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-17-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-17-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX0S+nFbjGoJgB
 xd6xHpcKNsl+Hp/lbys94lZtnzqkPg/+OBxCPrI+zFdXZGXD8RSYJYrNUCPbUTFs9tp/7vH75Wk
 9cAxielMqGeahVarAkkYjH4zkXLDG5+hZz8tv1rIk5FXY+O+H8vjsF4tcbIdDAeC31FmwQRGOMM
 nlaXlD7D0JT+Kjp49pHBmW6ib26RI+3Tsrr7VuOa1y+ryHIMDOEis+QjM27e4PSsmPamfRGulLp
 QHoHAehhqcEy9g6pv/3xq8JaUc0TbmwFnorJJy32I3r022NR9u7XCUq41zOWERLSoljNp0UQqeP
 ZSesLSjs+gYHo4CQlvoXPjFvHfy5dht5oCI9Mn6co58S0x2qt+PpJrO0xidatipEcqskGz+kAyq
 M/gBaEC7AE8dFdV6Txwtg1rFyZ7zLte/GldN9i4w5bFls7dz68FgyBqao+DM/4K8EOCkQLGF9ig
 jvbJIZABew7xAdv0rCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX/Wpgo7G8qIh3
 7eJOuOScdiLrn33iqAprovwmGSjukv5YEvw4q84J4BMdyBj0MYEjHF5d1h1UV6gBB9qlBcMBDkV
 v7rM6kZ1vJO4lSnhIMt4wy03neLXtzo=
X-Proofpoint-ORIG-GUID: 8EYg_5L4m2BCXHNyRMGk8zioJ7OFNgUh
X-Proofpoint-GUID: 8EYg_5L4m2BCXHNyRMGk8zioJ7OFNgUh
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4ad66 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OaGloM35DCjXXIZ3kxUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Define HLX shift, average, absolute difference, lookup, conversion, and
> ilog2 subtraction instructions.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/hlx/encode_ext.def |  59 +++++++
>   target/hexagon/imported/hlx_ext.idef       | 174 +++++++++++++++++++++
>   2 files changed, 233 insertions(+)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>
> diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
> index 5a11f58d79..520af860da 100644
> --- a/target/hexagon/imported/hlx/encode_ext.def
> +++ b/target/hexagon/imported/hlx/encode_ext.def
> @@ -51,6 +51,65 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
>   DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
>   DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
>   
> +DEF_ENC(LX_lut4,"11101101000tttttPP1000uuuu0dddd0")
> +DEF_ENC(LX_lut4_sh,"11101101000tttttPP1000uuuu0dddd1")
> +DEF_ENC(LX_lut4_sh_neg,"11101101000tttttPP1000uuuu1dddd0")
> +DEF_ENC(LX_lut4_mask,"11101101000tttttPP1000uuuu1dddd1")
> +DEF_ENC(LX_absdiff_h,"11101101000vvvv-PP1001uuuu0dddd0")
> +DEF_ENC(LX_absdiff_w,"11101101000vvvv-PP1001uuuu0dddd1")
> +DEF_ENC(LX_absdiff_uh,"11101101000vvvv-PP1001uuuu1dddd0")
> +DEF_ENC(LX_absdiff_uw,"11101101000vvvv-PP1001uuuu1dddd1")
> +DEF_ENC(LX_avg_h,"11101101000vvvv-PP1010uuuu0dddd0")
> +DEF_ENC(LX_avg_w,"11101101000vvvv-PP1010uuuu0dddd1")
> +DEF_ENC(LX_avg_uh,"11101101000vvvv-PP1010uuuu1dddd0")
> +DEF_ENC(LX_avg_uw,"11101101000vvvv-PP1010uuuu1dddd1")
> +DEF_ENC(LX_avg_h_rnd,"11101101000vvvv-PP1011uuuu0dddd0")
> +DEF_ENC(LX_avg_w_rnd,"11101101000vvvv-PP1011uuuu0dddd1")
> +DEF_ENC(LX_avg_uh_rnd,"11101101000vvvv-PP1011uuuu1dddd0")
> +DEF_ENC(LX_avg_uw_rnd,"11101101000vvvv-PP1011uuuu1dddd1")
> +DEF_ENC(LX_navg_h,"11101101000vvvv-PP1100uuuu0dddd0")
> +DEF_ENC(LX_navg_w,"11101101000vvvv-PP1100uuuu0dddd1")
> +DEF_ENC(LX_navg_uh,"11101101000vvvv-PP1100uuuu1dddd0")
> +DEF_ENC(LX_navg_uw,"11101101000vvvv-PP1100uuuu1dddd1")
> +DEF_ENC(LX_conv_b_h_lo,"11101101000vvvv-PP1101uuuu0dddd0")
> +DEF_ENC(LX_conv_b_h_hi,"11101101000vvvv-PP1101uuuu0dddd1")
> +DEF_ENC(LX_conv_h_b_lo,"11101101000-----PP1101uuuu1dddd0")
> +DEF_ENC(LX_conv_h_b_hi,"11101101000-----PP1101uuuu1dddd1")
> +DEF_ENC(LX_shra_h_uh,"11101101000vvvv-PP1110uuuu0xxxx0")
> +DEF_ENC(LX_shrar_h_uh,"11101101000tttttPP1110uuuu0xxxx1")
> +DEF_ENC(LX_shra_h_h,"11101101000vvvv-PP1110uuuu1xxxx0")
> +DEF_ENC(LX_shrar_h_h,"11101101000tttttPP1110uuuu1xxxx1")
> +DEF_ENC(LX_shra_w_uw,"11101101000vvvv-PP1111uuuu0xxxx0")
> +DEF_ENC(LX_shrar_w_uw,"11101101000tttttPP1111uuuu0xxxx1")
> +DEF_ENC(LX_shra_w_w,"11101101000vvvv-PP1111uuuu1xxxx0")
> +DEF_ENC(LX_shrar_w_w,"11101101000tttttPP1111uuuu1xxxx1")
> +DEF_ENC(LX_sub_ilog2_h,"11101101001iiii-PP1001uuuu0dddd0")
> +DEF_ENC(LX_sub_ilog2_uh,"11101101001iiii-PP1001uuuu0dddd1")
> +DEF_ENC(LX_sub_ilog2_w,"11101101001iiiiiPP1001uuuu1dddd0")
> +DEF_ENC(LX_sub_ilog2_uw,"11101101001iiiiiPP1001uuuu1dddd1")
> +DEF_ENC(LX_shr_h,"11101101001vvvv-PP1010uuuu0dddd0")
> +DEF_ENC(LX_shrr_h,"11101101001tttttPP1010uuuu0dddd1")
> +DEF_ENC(LX_shr_uh_uh,"11101101001vvvv-PP1010uuuu1dddd0")
> +DEF_ENC(LX_shrr_uh_uh,"11101101001tttttPP1010uuuu1dddd1")
> +DEF_ENC(LX_shr_uw_uw,"11101101001vvvv-PP1011uuuu0dddd0")
> +DEF_ENC(LX_shrr_uw_uw,"11101101001tttttPP1011uuuu0dddd1")
> +DEF_ENC(LX_shr_w_w,"11101101001vvvv-PP1011uuuu1dddd0")
> +DEF_ENC(LX_shrr_w_w,"11101101001tttttPP1011uuuu1dddd1")
> +DEF_ENC(LX_shr_h_w_uh,"11101101001vvvv-PP1100uuuu0dddd0")
> +DEF_ENC(LX_shrr_h_w_uh,"11101101001tttttPP1100uuuu0dddd1")
> +DEF_ENC(LX_shr_h_w_sat,"11101101001vvvv-PP1100uuuu1dddd0")
> +DEF_ENC(LX_shrr_h_w_sat,"11101101001tttttPP1100uuuu1dddd1")
> +DEF_ENC(LX_shr_h_w_rnd_sat,"11101101001vvvv-PP1101uuuu0dddd0")
> +DEF_ENC(LX_shrr_h_w_rnd_sat,"11101101001tttttPP1101uuuu0dddd1")
> +DEF_ENC(LX_shr_uh_w_sat,"11101101001vvvv-PP1101uuuu1dddd0")
> +DEF_ENC(LX_shrr_uh_w_sat,"11101101001tttttPP1101uuuu1dddd1")
> +DEF_ENC(LX_shr_uh_w_rnd_sat,"11101101001vvvv-PP1110uuuu0dddd0")
> +DEF_ENC(LX_shrr_uh_w_rnd_sat,"11101101001tttttPP1110uuuu0dddd1")
> +DEF_ENC(LX_shr_uh_uw_rnd_sat,"11101101001vvvv-PP1110uuuu1dddd0")
> +DEF_ENC(LX_shrr_uh_uw_rnd_sat,"11101101001tttttPP1110uuuu1dddd1")
> +DEF_ENC(LX_shr_uh_uw_sat,"11101101001vvvv-PP1111uuuu0dddd0")
> +DEF_ENC(LX_shrr_uh_uw_sat,"11101101001tttttPP1111uuuu0dddd1")
> +
>   DEF_ENC(LX_add_w,"11101111000vvvv-PP1000uuuu0dddd0")
>   DEF_ENC(LX_add_w_sat,"11101111000vvvv-PP1000uuuu0dddd1")
>   DEF_ENC(LX_add_uw_sat,"11101111000vvvv-PP1000uuuu1dddd0")
> diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
> index 47e1171473..7a6ab194b9 100644
> --- a/target/hexagon/imported/hlx_ext.idef
> +++ b/target/hexagon/imported/hlx_ext.idef
> @@ -19,12 +19,60 @@
>       } \
>   }
>   
> +EXTINSN(LX_lut4,"Ld16.h=lut4(Lu16.uh,Rtt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
> +fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]= fGETHALF(((LuV.uh[i]>>14)&0x3), RttV ); })
> +
> +EXTINSN(LX_lut4_sh,"Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
> +fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4s(fGETUHALF(((LuV.uh[i]>>14)&0x3), RttV ))<<15; })
> +
> +EXTINSN(LX_lut4_sh_neg,"Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1:neg",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
> +fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (fCAST4u(fGETUHALF(((LuV.uh[i]>>14)&0x3), RttV )) - (1<<16))<<15; })
> +
> +EXTINSN(LX_lut4_mask,"Ld16.h=lut4(Lu16.uh,Rtt32.h):mask",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR64),"Large 4 entry lookup table",
> +fHIDE(f64BIT_SCALAR_MASK(RttV)) fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (fGETHALF(((LuV.uh[i]>>14)&0x3), RttV ) & ((LuV.uh[i] & 0x3FFF) == 0 ? 0xFFFF : 0)); })
> +
>   Q6INSN(LX_mux_h_alt,"if(Lv16.h<0) Lx16.h = Lu16.h",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from if(Lv16.h<0) Lx16.h = Lu16.h to Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",
>   fASM_MAP("if(Lv16.h<0) Lx16.h = Lu16.h","Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)"))
>   
>   EXTINSN(LX_mux_h,"Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Mux select",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i] = (LvV.h[i] < 0) ? LuV.h[i] : LxV.h[i]; })
>   
> +EXTINSN(LX_shra_h_uh,"Lx16.h+=shr(Lu16.uh,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFTU(LuV.uh[i],LvV.h[i]); })
> +
> +EXTINSN(LX_shrar_h_uh,"Lx16.h+=shr(Lu16.uh,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFTU(LuV.uh[i],fCAST2_2s(RtV)); })
> +
> +EXTINSN(LX_shra_h_h,"Lx16.h+=shr(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFT(LuV.h[i],LvV.h[i]); })
> +
> +EXTINSN(LX_shrar_h_h,"Lx16.h+=shr(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i]+=fLSHIFT(LuV.h[i],fCAST2_2s(RtV)); })
> +
> +EXTINSN(LX_shra_w_uw,"Lxx16.w+=shr(Luu16.uw,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFTU(LuuV.l[i].uw,LvV.h[i]); })
> +
> +EXTINSN(LX_shrar_w_uw,"Lxx16.w+=shr(Luu16.uw,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFTU(LuuV.l[i].uw,fCAST2_2s(RtV)); })
> +
> +EXTINSN(LX_shra_w_w,"Lxx16.w+=shr(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFT(LuuV.l[i].w,LvV.h[i]); })
> +
> +EXTINSN(LX_shrar_w_w,"Lxx16.w+=shr(Luu16.w,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w+=fLSHIFT(LuuV.l[i].w,fCAST2_2s(RtV)); })
> +
> +EXTINSN(LX_sub_ilog2_h,"Ld16.h=sub(ilog2(Lu16.h),#u4)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(16,LuV.h[i] ^ -(LuV.h[i] < 0)) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuV.h[i], uiV);); })
> +
> +EXTINSN(LX_sub_ilog2_uh,"Ld16.h=sub(ilog2(Lu16.uh),#u4)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(16,LuV.uh[i]) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuV.uh[i], uiV);); })
> +
> +EXTINSN(LX_sub_ilog2_w,"Ld16.h=sub(ilog2(Luu16.w),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].w ^ -(LuuV.l[i].w < 0)) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].w, uiV);); })
> +
> +EXTINSN(LX_sub_ilog2_uw,"Ld16.h=sub(ilog2(Luu16.uw),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].uw) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].uw, uiV);); })
> +
>   EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
>   { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
>   
> @@ -85,6 +133,18 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
>   EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
>   
> +EXTINSN(LX_conv_b_h_hi,"Ld16.b=packhi(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Grab the high byte of two halfwords and pack into 16-bit register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.b[2*i+1] = LuV.b[2*i+1]; LdV.b[2*i] = LvV.b[2*i+1]; })
> +
> +EXTINSN(LX_conv_b_h_lo,"Ld16.b=packlo(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Grab the low byte of two halfwords and pack into 16-bit register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.b[2*i+1] = LuV.b[2*i]; LdV.b[2*i] = LvV.b[2*i]; })
> +
> +EXTINSN(LX_conv_h_b_hi,"Ldd16.h=unpackhi(Lu16.b)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Place bytes from two-byte packed register in high byte of each 16-bit register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].b[3] = LuV.b[2*i+1]; LddV.l[i].b[1] = LuV.b[2*i]; })
> +
> +EXTINSN(LX_conv_h_b_lo,"Ldd16.h=unpacklo(Lu16.b)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Place bytes from two-byte packed register in low byte of each 16-bit register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].b[2] = LuV.b[2*i+1]; LddV.l[i].b[0] = LuV.b[2*i]; })
> +
>   EXTINSN(LX_add_w,"Ldd16.w=add(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w + LvvV.l[i].w; })
>   
> @@ -151,6 +211,18 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fABSW(LuuV.l[i].h[0]); Ldd
>   EXTINSN(LX_abs_uhp_sat,"Ldd16.h=abs(Luu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSATH(fABSW(LuuV.l[i].h[0])); LddV.l[i].h[1] = fVSATH(fABSW(LuuV.l[i].h[1])) ; })
>   
> +EXTINSN(LX_absdiff_h,"Ld16.uh=absdiff(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i] - LvV.h[i]); })
> +
> +EXTINSN(LX_absdiff_uh,"Ld16.uh=absdiff(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of unsigned half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? (LuV.uh[i] - LvV.uh[i]) : (LvV.uh[i] - LuV.uh[i]); })
> +
> +EXTINSN(LX_absdiff_w,"Ldd16.uw=absdiff(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fABS(fSXTN(32,64,LuuV.l[i].w) - fSXTN(32,64,LvvV.l[i].w)); })
> +
> +EXTINSN(LX_absdiff_uw,"Ldd16.uw=absdiff(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Absolute differences: large vector of unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw > LvvV.l[i].uw) ? (LuuV.l[i].uw - LvvV.l[i].uw) : (LvvV.l[i].uw - LuuV.l[i].uw); })
> +
>   EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
>   
> @@ -262,6 +334,108 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=uiV; })
>   EXTINSN(LX_assign_rw,"Ldd16.w=Rt32.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=RtV; })
>   
> +EXTINSN(LX_avg_h,"Ld16.h=avg(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVAVGS(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_avg_h_rnd,"Ld16.h=avg(Lu16.h,Lv16.h):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of half word with rounding",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVAVGSRND(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_navg_h,"Ld16.h=navg(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVNAVGS(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_avg_w,"Ldd16.w=avg(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVAVGS(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_avg_w_rnd,"Ldd16.w=avg(Luu16.w,Lvv16.w):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of word with rounding",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVAVGSRND(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_navg_w,"Ldd16.w=navg(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVNAVGS(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_avg_uh,"Ld16.uh=avg(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVAVGU(16, LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_avg_uh_rnd,"Ld16.uh=avg(Lu16.uh,Lv16.uh):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned half word with rounding",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVAVGURND(16, LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_navg_uh,"Ld16.h=navg(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of unsigned half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVNAVGU(16, LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_avg_uw,"Ldd16.uw=avg(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVAVGU(32, LuuV.l[i].uw, LvvV.l[i].uw); })
> +
> +EXTINSN(LX_avg_uw_rnd,"Ldd16.uw=avg(Luu16.uw,Lvv16.uw):rnd",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Average of large vector of unsigned word with rounding",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVAVGURND(32, LuuV.l[i].uw, LvvV.l[i].uw); })
> +
> +EXTINSN(LX_navg_uw,"Ldd16.w=navg(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Negative average of large vector of unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVNAVGU(32, LuuV.l[i].uw, LvvV.l[i].uw); })
> +
> +EXTINSN(LX_shr_uh_uh,"Ld16.uh=shr(Lu16.uh,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fLSHIFTU(LuV.uh[i], LvV.h[i]); })
> +
> +EXTINSN(LX_shrr_uh_uh,"Ld16.uh=shr(Lu16.uh,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fLSHIFTU(LuV.uh[i], fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_shr_h,"Ld16.h=shr(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fLSHIFT(LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_shrr_h,"Ld16.h=shr(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fLSHIFT(LuV.h[i], fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_shr_uw_uw,"Ldd16.uw=shr(Luu16.uw,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=fLSHIFTU(LuuV.l[i].uw, LvV.h[i]); })
> +
> +EXTINSN(LX_shrr_uw_uw,"Ldd16.uw=shr(Luu16.uw,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=fLSHIFTU(LuuV.l[i].uw, fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_shr_w_w,"Ldd16.w=shr(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=fLSHIFT(LuuV.l[i].w, LvV.h[i]); })
> +
> +EXTINSN(LX_shrr_w_w,"Ldd16.w=shr(Luu16.w,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional shift large vector",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_shr_h_w_uh,"Ld16.h=shr(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Narrowing modular shift",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fGETHALF(0,(LuuV.l[i].w >> (LvV.uh[i] & 15))); })
> +
> +EXTINSN(LX_shrr_h_w_uh,"Ld16.h=shr(Luu16.w,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Narrowing modular shift",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fGETHALF(0,(LuuV.l[i].w >> (fGETUHALF(0,RtV) & 15))); })
> +
> +EXTINSN(LX_shr_h_w_sat,"Ld16.h=shr(Luu16.w,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT(LuuV.l[i].w, LvV.h[i])); })
> +
> +EXTINSN(LX_shr_h_w_rnd_sat,"Ld16.h=shr(Luu16.w,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT_RND(LuuV.l[i].w, LvV.h[i])); })
> +
> +EXTINSN(LX_shrr_h_w_sat,"Ld16.h=shr(Luu16.w,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV))); })
> +
> +EXTINSN(LX_shrr_h_w_rnd_sat,"Ld16.h=shr(Luu16.w,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fVSATH(fLSHIFT_RND(LuuV.l[i].w, fGETHALF(0,RtV))); })
> +
> +EXTINSN(LX_shr_uh_uw_sat,"Ld16.uh=shr(Luu16.uw,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU(LuuV.l[i].uw, LvV.h[i])); })
> +
> +EXTINSN(LX_shr_uh_uw_rnd_sat,"Ld16.uh=shr(Luu16.uw,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU_RND(LuuV.l[i].uw, LvV.h[i])); })
> +
> +EXTINSN(LX_shrr_uh_uw_sat,"Ld16.uh=shr(Luu16.uw,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU(LuuV.l[i].uw, fGETHALF(0,RtV))); })
> +
> +EXTINSN(LX_shrr_uh_uw_rnd_sat,"Ld16.uh=shr(Luu16.uw,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFTU_RND(LuuV.l[i].uw, fGETHALF(0,RtV))); })
> +
> +EXTINSN(LX_shr_uh_w_sat,"Ld16.uh=shr(Luu16.w,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT(LuuV.l[i].w, LvV.h[i])); })
> +
> +EXTINSN(LX_shr_uh_w_rnd_sat,"Ld16.uh=shr(Luu16.w,Lv16.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT_RND(LuuV.l[i].w, LvV.h[i])); })
> +
> +EXTINSN(LX_shrr_uh_w_sat,"Ld16.uh=shr(Luu16.w,Rt32.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT(LuuV.l[i].w, fGETHALF(0,RtV))); })
> +
> +EXTINSN(LX_shrr_uh_w_rnd_sat,"Ld16.uh=shr(Luu16.w,Rt32.h):rnd:sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Bidirectional narrowing shift large vector with round and saturation",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=fVSATUH(fLSHIFT_RND(LuuV.l[i].w, fGETHALF(0,RtV))); })
> +
>   Q6INSN(LX_zero,"Ld16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=#0 to Ld16=xor(L15,L15)",
>   fASM_MAP("Ld16=#0","Ld16=xor(L15,L15)"))
>   


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23640606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=goY/FD4/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZLNYfZlq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaV1-0003Wh-9k; Thu, 29 Oct 2026 20:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaV0-0003WZ-BW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:29:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaUv-0002f2-Ki
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:29:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKXFD506071
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NBOevhB1AOptqM39Mnkea/6mxnifN+O5SypX+Uc9PUI=; b=goY/FD4/Y3xPp9qa
 9Mu9GQSxkMBYW6wCJsk9M/50KBmZtFhvUU+7Ui/ZI2VQq641DpRXXnfb4AEbfpiy
 AJ981YTRZUc/PXM558y8qZjmtXlBCj+TrVBeqIUDRJvI7ZHwL+A1AHBsaaetLfHC
 h9lmtgjlJWsCIJA/tMxSz1xTeuD01lCK+pBV2Sq2W7Xrl+L3SFpGwlQwAAhewd0Y
 TbyePoPQ/XxQ/RrZHxW1/9RqDi755Ce87DhwRzBx4NR4ZXZvR3XOLOX5d90N5uD+
 WtQT5U/bY3vKi94Zm+o3ESbGg5k7lo1n8kOImJu8ZaXhDu+r1EQAe+W/Q7nKcBrY
 pnm0OQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p0gd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:29:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f6f4fe531so22327585a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793320170; x=1793924970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NBOevhB1AOptqM39Mnkea/6mxnifN+O5SypX+Uc9PUI=;
 b=ZLNYfZlqhWm7KndBp4AkSo5ESGmnZlsCM2N/+d4zu7KwstBOqu4vdU2NHMqLERWoFw
 23r7YaNIhs964/CldgWe1Pr0VwYRgykbg4xQ0/yFf5+ctzgDqTHsWGkd9nJDwPJu58Ym
 Hm/l3aQpFBl8X4pet9VYrEMA9dKeu2D2ZLA0Y9LMFt092FTrkGWTzPZfsyqYsrs3YlS1
 gdbaY2Rk5L16CdpOM3d0jzml+gG061dZ1Xqh7DsrqX3OWArNdKGSJar3BmWN+Lx0vDN5
 7dOJkywLVi9yo7dJnwBGQqz06C/RHemXJJ7VKyBqI8I02kyUltI3/H6wcT5U/WxeJcXt
 JxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320170; x=1793924970;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NBOevhB1AOptqM39Mnkea/6mxnifN+O5SypX+Uc9PUI=;
 b=GRUhgC90CB/VjRZEwPTrjX3BI9MZkxNbvJ4XT1TJObcT5wHIIHlWDlBmkQ62l+gx6M
 liw8FSoh5Nk6wfimclGsrnFr3IQaJAO4xW86IKBXtnRevU/965JBuiR5eX9YCl6J8gNT
 edmSO63a00nnBOLJN1bQmz+kI7ysYQY4TQFxAv3mMx9qreWqWH6ipM8GDUkzyLwYKS7/
 Sk+ncg4inG6oWJuHZ3x3X99L39lZ7D0j0BLJOhD0FoDJPuufSnc4l+17VUr6bHx4BEpO
 7Y9CHpiok2GdWQPxG4UtNq61J3V6rs4sW8kiIj8/Xg8JlQMzUATWzqnVGzScrKkb+Ro5
 q6iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBziX4hm9fgXL3t9yVC/5RAdKhK9yaDfaSFBzwIz6OHtlM84I8CQl8maBE8pcr5iDFFlD76rH7jM1aP+@nongnu.org
X-Gm-Message-State: AFq9FYJQSqbq452xdk4ZYawFfrF6GXGTW3f+IacvfksLDkppYyhYKJ7x
 +l2f5EVKfGLIkBmxUQbROCkkeeW8C+JOlKDnfg4mXPdGV0TtZjJ5ctO2H2+rHxuFNQZxnA/mhF8
 r0kswz+KAj+iEHzUdkENFkSXG6GbxX/ARzOeVWTvjFwEtAxePRbjXi1rOvw==
X-Gm-Gg: AYBFou0QxQN5mPryMQxthDTizUSmRqY01ZML7EM+L3WNyMmHgtJwiabGUaex4j11e2R
 rY+iqsGnpVyFYVcQ3Y5803l9jneCN7bUiNsNQVUntbgGD4VlOJQKEXlDwgv0Fg7E7cajc9mWqng
 NBAh5Vm0ABeFfPKytMLtUdsNSbRZkFxkMEg67EabfaP6J2jPqPu78E0stkWp4bKhWHUVjw3+Qdh
 5oo7X7vkqU/M1hMZab9peRc8yaC5NIU7MFS8nhx1J1+8p7AOyyw74BmiwP7ENT7I+ZwsU+RPq3W
 yZMX4zSQjglWz+WHL23HvrWx4CgIEWSlvRxzozpHx1bDAz0sNIWy81mHroU0o/Ca3IE/zj+A5I6
 5kCSP/GhPwJmfaVlFLPUwDS8qLQeoCtyj08pgCSwjXGWnYZSH/E/oVqT0Xqm4QBVygw9QDINqfk
 9z26KQcCNCk/T0K1lut3okFkmE9NcWO5o3nV7AF7LerMqv4Bv7SUZw
X-Received: by 2002:a05:620a:640e:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-944217ca60amr125760485a.67.1793320170276; 
 Thu, 29 Oct 2026 17:29:30 -0700 (PDT)
X-Received: by 2002:a05:620a:640e:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-944217ca60amr125757785a.67.1793320169714; 
 Thu, 29 Oct 2026 17:29:29 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425a7195esm2581685a.27.2026.10.29.17.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:29:28 -0700 (PDT)
Message-ID: <477700ae-d5a2-4d30-a465-05664206186f@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:29:26 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] target/hexagon: add HLX common ALU instructions
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-15-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-15-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX4H9KOmnLwQRe
 +SnHjDBMHamhzBQiU6UPLQAIPdMulO5F4IQzCY5E4Zf9gweLW2QOKiwX406jXx9mYMP+9cA78am
 J8lY9/egXsvAvPk7wl4HxefoXw5KLowNoCbLai4QEnReGHvlWjqdlT1IFQDYgrvwM3g6+daSoAN
 R+1Cg3V23NusE76nEWTErscpcAwRcCgV09zNNeyh66hDTxhv34wfCVOGPZuk+hmj6YJgle6pcef
 E8Fpmrv6L7kkRIgl630f5IY5LPzs5k5YN542vP/SZV9zZSkpbCDzOU1oI4KCNz0vVmK80ByHD5u
 Ua4y4o9hiBXkrVwtrEeuZDdtLrYIxFMLu1iCWIdORRt2mSdb2kJkVzlECCB0RZZq+lan7uxCiPR
 xCiCBS30WyXqqC/TxCMBbVj88/Z6IjKK0v+DgMUoSZmHudIEf7SBb9vrBO4/ScEvTcdILL16pNQ
 9xMELs570pHzEo5Anzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX7djKiKl7WL+e
 tPbtzU2F33g/oAlEE7Z17ok5xq6kA629dKGuIN01LiTTEQefEAgAT3kY5SOOOayWUKaiZlQpbD+
 Lv+PBXOPW+75ZcjYOxELrZa0/wirTEY=
X-Proofpoint-ORIG-GUID: oQAGj0s7OLHI6VPE5LsxDTdEPCMaXNM1
X-Proofpoint-GUID: oQAGj0s7OLHI6VPE5LsxDTdEPCMaXNM1
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae3e4eb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=UJR3086HZcZIBQz_bpUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300001
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
> Define single-register HLX arithmetic, compare, logical, conversion, and
> assignment instructions.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/hlx/encode_ext.def |  38 ++++++
>   target/hexagon/imported/hlx_ext.idef       | 132 +++++++++++++++++++++
>   target/hexagon/mmvec/macros.h              |   5 +
>   3 files changed, 175 insertions(+)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
> index 10d13db376..cb6d1b03d8 100644
> --- a/target/hexagon/imported/hlx/encode_ext.def
> +++ b/target/hexagon/imported/hlx/encode_ext.def
> @@ -13,6 +13,44 @@ DEF_ENC(LX_L16b_p_tmp,"1001100----sssssPP-10vv--100dddd")
>   DEF_ENC(LX_S16b_new,"1010-1001--sssssPP000----000uuuu")
>   DEF_ENC(LX_S16b_p_new,"1010-1001--sssssPP000vv--100uuuu")
>   
> +DEF_ENC(LX_mux_h,"11100101000vvvv-PP1000uuuu0xxxx0")
> +DEF_ENC(LX_cmp_gt_h,"11100101000vvvv-PP1000uuuu0dddd1")
> +DEF_ENC(LX_cmp_gt_uh,"11100101000vvvv-PP1000uuuu1dddd0")
> +DEF_ENC(LX_max_h,"11100101000vvvv-PP1001uuuu0dddd0")
> +DEF_ENC(LX_min_h,"11100101000vvvv-PP1001uuuu0dddd1")
> +DEF_ENC(LX_max_uh,"11100101000vvvv-PP1001uuuu1dddd0")
> +DEF_ENC(LX_min_uh,"11100101000vvvv-PP1001uuuu1dddd1")
> +DEF_ENC(LX_conv_uw_uh,"11100101000--001PP1010uuuu0dddd0")
> +DEF_ENC(LX_conv_w_h,"11100101000--001PP1010uuuu0dddd1")
> +DEF_ENC(LX_abs_uh,"11100101000--001PP1010uuuu1dddd0")
> +DEF_ENC(LX_abs_uh_sat,"11100101000--001PP1010uuuu1dddd1")
> +DEF_ENC(LX_add_h,"11100101000vvvv-PP1011uuuu0dddd0")
> +DEF_ENC(LX_add_h_sat,"11100101000vvvv-PP1011uuuu0dddd1")
> +DEF_ENC(LX_add_uh_sat,"11100101000vvvv-PP1011uuuu1dddd0")
> +DEF_ENC(LX_add_uhh_sat,"11100101000vvvv-PP1011uuuu1dddd1")
> +DEF_ENC(LX_sub_h,"11100101000vvvv-PP1100uuuu0dddd0")
> +DEF_ENC(LX_sub_h_sat,"11100101000vvvv-PP1100uuuu0dddd1")
> +DEF_ENC(LX_and,"11100101000vvvv-PP1101uuuu0dddd0")
> +DEF_ENC(LX_andn,"11100101000vvvv-PP1101uuuu0dddd1")
> +DEF_ENC(LX_not,"11100101000-----PP1101uuuu1dddd0")
> +DEF_ENC(LX_xor,"11100101000vvvv-PP1101uuuu1dddd1")
> +DEF_ENC(LX_or,"11100101000vvvv-PP1110uuuu0dddd0")
> +DEF_ENC(LX_orn,"11100101000vvvv-PP1110uuuu0dddd1")
> +DEF_ENC(LX_assign,"11100101000-----PP1110uuuu1dddd0")
> +DEF_ENC(LX_assign_w,"11100101000-----PP1110uuuu1dddd1")
> +DEF_ENC(LX_sub_uh_sat,"11100101000vvvv-PP1111uuuu0dddd0")
> +DEF_ENC(LX_sub_uhh_sat,"11100101000vvvv-PP1111uuuu0dddd1")
> +DEF_ENC(LX_add_wwh,"11100101000vvvv-PP1111uuuu1dddd0")
> +DEF_ENC(LX_add_wwuh,"11100101000vvvv-PP1111uuuu1dddd1")
> +DEF_ENC(LX_sub_wwuh,"11100101001vvvv-PP1000uuuu0dddd1")
> +DEF_ENC(LX_sub_wwh,"11100101001vvvv-PP1000uuuu0dddd0")
> +DEF_ENC(LX_assign_r,"11100101001tttttPP1001----1dddd0")
> +DEF_ENC(LX_assign_rw,"11100101001tttttPP1001----1dddd1")
> +DEF_ENC(LX_add_wuh,"11100101001vvvv-PP1010uuuu0dddd0")
> +DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
> +DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
> +DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
> +
>   #undef DEF_ENC
>   #undef EXTEXTNAME
>   #undef CONCAT
> diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
> index 3685596e5e..4cee4ce816 100644
> --- a/target/hexagon/imported/hlx_ext.idef
> +++ b/target/hexagon/imported/hlx_ext.idef
> @@ -19,6 +19,12 @@
>       } \
>   }
>   
> +Q6INSN(LX_mux_h_alt,"if(Lv16.h<0) Lx16.h = Lu16.h",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from if(Lv16.h<0) Lx16.h = Lu16.h to Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",
> +fASM_MAP("if(Lv16.h<0) Lx16.h = Lu16.h","Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)"))
> +
> +EXTINSN(LX_mux_h,"Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Mux select",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxV.h[i] = (LvV.h[i] < 0) ? LuV.h[i] : LxV.h[i]; })
> +
>   EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
>   { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
>   
> @@ -31,6 +37,132 @@ EXTINSN(LX_S16b_new,"mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PAR
>   EXTINSN(LX_S16b_p_new,"if (Pv4) mem(Rs32)=Ku16.new",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_STORE,A_HLX_NEW,A_DOTNEWVALUE,A_RESTRICT_SLOT0ONLY,A_CONDEXEC),"Aligned HLX new halfword store",
>   { fEA_REG(RsV); if(fLSBOLD(PvV)){fSTOREMML(EA,fNEWLREG(KuN),false,false);} else {STORE_CANCEL(EA);};})
>   
> +EXTINSN(LX_add_h,"Ld16.h=add(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = LuV.h[i] + LvV.h[i]; })
> +
> +EXTINSN(LX_add_h_sat,"Ld16.h=add(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSADDSAT(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_add_uh_sat,"Ld16.uh=add(Lu16.uh,Lv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUADDSAT(16, LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_add_uhh_sat,"Ld16.uh=add(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSADDSAT(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_sub_h,"Ld16.h=sub(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub h",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = LuV.h[i] - LvV.h[i]; })
> +
> +EXTINSN(LX_sub_h_sat,"Ld16.h=sub(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVSSUBSAT(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_sub_uh_sat,"Ld16.uh=sub(Lu16.uh,Lv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSUBSAT(16, LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_sub_uhh_sat,"Ld16.uh=sub(Lu16.h,Lv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Vector Add & Saturate",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fVUSSUBSAT(16, LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_add_wwh,"Ldd16.w=add(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w + fSXTN(16,32,LvV.h[i])); })
> +
> +EXTINSN(LX_add_wwuh,"Ldd16.w=add(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w + fZXTN(16,32,LvV.uh[i])); })
> +
> +EXTINSN(LX_sub_wwh,"Ldd16.w=sub(Luu16.w,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w - fSXTN(16,32,LvV.h[i])); })
> +
> +EXTINSN(LX_sub_wwuh,"Ldd16.w=sub(Luu16.w,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector sub with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(LuuV.l[i].w - fZXTN(16,32,LvV.uh[i])); })
> +
> +EXTINSN(LX_add_wuh,"Ldd16.w=add(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(fZXTN(16,32,LuV.uh[i]) + fZXTN(16,32,LvV.uh[i])); })
> +
> +EXTINSN(LX_sub_wuh,"Ldd16.w=sub(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector addition with widen into two large vectors",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fCAST4_4s(fZXTN(16,32,LuV.uh[i]) - fZXTN(16,32,LvV.uh[i])); })
> +
> +EXTINSN(LX_conv_uw_uh,"Ldd16.uw=zxt(Lu16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert unsigned halfword to unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
> +
> +EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
> +
> +EXTINSN(LX_abs_uh,"Ld16.uh=abs(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value of large vector of half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i]); })
> +
> +EXTINSN(LX_abs_uh_sat,"Ld16.h=abs(Lu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value & saturate of large vector of half word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSATH(fABSW(LuV.h[i])); })
> +
> +EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
> +
> +EXTINSN(LX_cmp_gt_h,"Ld16.h=cmp.gt(Lu16.h, Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Signed compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? 0xFFFF : 0x0; })
> +
> +EXTINSN(LX_max_uh,"Ld16.uh=max(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
> +
> +EXTINSN(LX_min_uh,"Ld16.uh=min(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vectormac max ",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] < LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
> +
> +EXTINSN(LX_max_h,"Ld16.h=max(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
> +
> +EXTINSN(LX_min_h,"Ld16.h=min(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] < LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
> +
> +EXTINSN(LX_and,"Ld16=and(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical And",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & LvV.uh[i]; })
> +
> +EXTINSN(LX_or,"Ld16=or(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical OR",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | LvV.uh[i]; })
> +
> +EXTINSN(LX_xor,"Ld16=xor(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical XOR",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] ^ LvV.uh[i]; })
> +
> +EXTINSN(LX_not,"Ld16=not(Lu16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical NOT",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = ~LuV.uh[i]; })
> +
> +EXTINSN(LX_andn,"Ld16=andn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not And",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & ~LvV.uh[i]; })
> +
> +EXTINSN(LX_orn,"Ld16=orn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not OR",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | ~LvV.uh[i]; })
> +
> +EXTINSN(LX_assign,"Ld16.h=Lu16.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign an Lreg",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=LuV.uh[i]; })
> +
> +EXTINSN(LX_assign_w,"Ldd16.w=Luu16.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign a double Lreg",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=LuuV.l[i].w; })
> +
> +EXTINSN(LX_assign_r,"Ld16.h=Rt32.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fGETHALF(0,RtV); })
> +
> +EXTINSN(LX_assign_s,"Ld16.h=#s5",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_SCALAR32),"Assign a signed immediate to L register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=siV; })
> +
> +EXTINSN(LX_assign_u,"Ld16.uh=#u5",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_SCALAR32),"Assign a unsigned immediate to L register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=uiV; })
> +
> +EXTINSN(LX_assign_rw,"Ldd16.w=Rt32.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=RtV; })
> +
> +Q6INSN(LX_zero,"Ld16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=#0 to Ld16=xor(L15,L15)",
> +fASM_MAP("Ld16=#0","Ld16=xor(L15,L15)"))
> +
> +Q6INSN(LX_zero_w,"Ldd16=#0",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16=#0 to Ldd16=xor(L15:14,L15:14)",
> +fASM_MAP("Ldd16=#0","Ldd16=xor(L15:14,L15:14)"))
> +
> +Q6INSN(LX_assign_alt,"Ld16=Lu16",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=Lu16 to Ld16.h=Lu16.h",
> +fASM_MAP("Ld16=Lu16","Ld16.h=Lu16.h"))
> +
> +Q6INSN(LX_assign_w_alt,"Ldd16=Luu16",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16=Luu16 to Ldd16.w=Luu16.w",
> +fASM_MAP("Ldd16=Luu16","Ldd16.w=Luu16.w"))
> +
> +Q6INSN(LX_hi,"Ld16=hi(Luu16)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=hi(Luu16) to Ld=lo(LW)",
> +fASM_MAP("Ld16=hi(Luu16)","Ld=lo(LW)"))
> +
> +Q6INSN(LX_lo,"Ld16=lo(Luu16)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ld16=lo(Luu16) to Ld=hi(LW)",
> +fASM_MAP("Ld16=lo(Luu16)","Ld=hi(LW)"))
> +
>   Q6INSN(LX_LL16b_tmp,"Ldd16.tmp=mem(Rs32)",ATTRIBS(A_MAPPING,A_HLX,A_NO_IDEF_PARSER),"Mapping from Ldd16.tmp=mem(Rs32) to LWd.tmp=mem(R)",
>   fASM_MAP("Ldd16.tmp=mem(Rs32)","LWd.tmp=mem(R)"))
>   
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index 0e643b2910..ef22fe3306 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -341,6 +341,11 @@
>       fVSATN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) + fSXTN(WIDTH, 2 * WIDTH, V))
>   #define fVUSUBSAT(WIDTH, U, V) \
>       fVSATUN(WIDTH, fZXTN(WIDTH, 2 * WIDTH, U) - fZXTN(WIDTH, 2 * WIDTH, V))
> +/* Signed inputs, result saturated to the unsigned range */
> +#define fVUSADDSAT(WIDTH, U, V) \
> +    fVSATUN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) + fSXTN(WIDTH, 2 * WIDTH, V))
> +#define fVUSSUBSAT(WIDTH, U, V) \
> +    fVSATUN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) - fSXTN(WIDTH, 2 * WIDTH, V))
>   #define fVSSUBSAT(WIDTH, U, V) \
>       fVSATN(WIDTH, fSXTN(WIDTH, 2 * WIDTH, U) - fSXTN(WIDTH, 2 * WIDTH, V))
>   #define fVAVGU(WIDTH, U, V) \


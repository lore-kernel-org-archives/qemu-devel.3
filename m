Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E354606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HzI4Btvn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TarVKz8C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnrO-0006Ot-FS; Fri, 30 Oct 2026 10:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnr4-0006Lx-Tr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnr2-0005Sy-IU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:45:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER5eo2596635
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5JHNur/fV/ZXa/l922GIwrx1Ao7hNSGrjRT9dHBoPIk=; b=HzI4BtvnpF9NAdjB
 EOqH4mdwDb/fVvDiMPyFGchptzMoMLzDWuIcC/rOKV+/T2hvG7tZpT8JqwXEBNwn
 A71Vp4exF1NqqbV7GbtcXKufH6JypyjK8YaXJUX1XyGSeN/uqiXl97/RdLUMlgR+
 SGnHB6jtUlg7zJHlwN3H/AlwJEAIp8PrPhNhsIonrzGtDTZk12O2Ll0AbkZcLkJh
 GuvQLP8FmqSy6UEjSJZRJ8w+cwPfjKtKaOaVhAkpRogXNXwRXSOiNWwIh5SBrmUC
 xM+PEN+TokZwh7aWnzptE27pUcioGMTKxB885YTl+xV4TnfizBLPEQLn4o+7Z4yO
 ivaczA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pbjrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:45:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso24000416d6.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371513; x=1793976313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JHNur/fV/ZXa/l922GIwrx1Ao7hNSGrjRT9dHBoPIk=;
 b=TarVKz8Cc1Wqan7FqoDoc3yC7bIVGzexpVvXlwuFzcY8Rr00OVAVjmnMemva9ojMZd
 y258Cc2XLVO1vgL2GUf67NFj/T2GJC/Ihs5x0sRbGTirBia3mL4iqBQIXP+DY+z7qSBw
 cgz5HzXSpYvKzYIaK59hzjiMPuizi53c3K3KrtR7D2H910kL92b0KyC04aW3t6+xC20k
 zMAL471dWFWUf7TEMfqvtx/CTEMQtg/gr/xYCAms9p23o+AAQLSqgiFw9/Ffwv/HyavX
 QildA5f31mBiJExVTEZMAUEyxKDsu/O/y3NH+LQDHNQw400sfm/xQsV9+pV7c9kgXlWj
 Us3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371513; x=1793976313;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JHNur/fV/ZXa/l922GIwrx1Ao7hNSGrjRT9dHBoPIk=;
 b=1jflL2662bIMy4slf1Qjly65aLGUVer8TGK09xflO1gDR1z5dU6zUzmYPJss6yS7l2
 u/ZYnVqWxh6Z46bBWXg8O4LswqGBSiMEL8gpgiq4rzlp5N+3ON0Zyin6c0rp/8CqizJk
 N+ofVXv6fpPP9p3S/WJJBmh7EQxTxy5qBbRO7OV81R2DgVfCJctIUAlHK43dMbtjvf7Y
 NZGERw7hd66s/i8vhA1+hWzVcuI2Ojxty1cN46Ce5L7rLS1LI1bMH/ibn1ZogwLbP4Sh
 cWtAnVZROe+3dCJSZm5Xk2A6vKC4qw/mpvPPG0D1sDzr71KLx3ZENhadyxUw88QXwvYv
 PE1A==
X-Gm-Message-State: AFq9FYKp2K0WlD6KC3PxRb4FH5UESeo/yUAqBm3ce1Os0R2QI0jV3bgC
 1BJDnvURp9v9GNgvRsb1w5caducKeslkiKsZGGSD8OzJGsSvDxmgCYL4iKQB18dLTILzUtehOGU
 J/orsvu0j/xmKZ0PNtmF7wZqRxd0KMDC4Aabp0vKMp27qbmq2nmHkvDoHAhhpNy+vIg==
X-Gm-Gg: AYBFou07h06RGPvrrougdihrAw/jhYz1DfYHwKc7n7VJCGINNvzvakCXXQHCkhQEXZO
 8O9FNTuKffEHLZb4RqWWsHRbvX+eejIdzdf4stM5ICBj+fmQwi7rBw9VQJ7xRjUkL5XC0u7oaFA
 NvfaAEVutOUI/NDa3Ae8gyHygU+5pBvoAID7iRR0/4Sags90eEGRqZWdRNjaIggyIN1oEDiEVJx
 5RCOOw9nx8kzzVKj+lav//jsLOAwxqio72NprRBYGYXgoFCIpOXa8pKp+nq3waL5FaAe3NmTeba
 YE3b9BJUf1B6TlkS5XjPpcz7K2AkASd3VVzASPGlRN8Se8mKbfGKQ7QMFSUB+lBsPsJtiLSM9rd
 hQWjCIXncJ2BMEwuCGgCw7xeIfVm484VokL0VeksYo2S/x2DT83qnHuCagy1xoD+No0HRlSGBB4
 HtcalG6tBUrQll9cZ8Dn3Q7MEqV0Ms2oLXk/5fOg==
X-Received: by 2002:a05:6214:3909:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91ca4b980d0mr41540616d6.51.1793371513045; 
 Fri, 30 Oct 2026 07:45:13 -0700 (PDT)
X-Received: by 2002:a05:6214:3909:b0:91b:5d3b:4aca with SMTP id
 6a1803df08f44-91ca4b980d0mr41539666d6.51.1793371512211; 
 Fri, 30 Oct 2026 07:45:12 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca80672f4sm16701946d6.34.2026.10.30.07.45.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:45:11 -0700 (PDT)
Message-ID: <036b3947-068c-4f8e-b726-90efe288be86@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:45:10 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] target/hexagon: add HLX multiply instructions
To: qemu-devel@nongnu.org
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-18-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-18-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX9F1Ale8EQqqh
 wkGlGRa2k2Z4k3DOAfI8IkY74rKxBXw3WgFrut6TVJOZVc31ucYsnRHNR+tFqwOeYK+layLRO1D
 Rti0EeOaF++pww3w1yBmiSMIo5NvArkKIhiTpyH9d+cCQwHrZ2KI/2NKlBh2DprYsPTtRT/2p+c
 pN5HZ/Pi/9J45qtVxHSd+8enTv707fMzNGD+afuP01gC+/oy2gCAHPws/qPoj+iKLN3yD81d2Bt
 TZez2mfY1Cq9NOY8fdIdjuSZoucGlJRg20Tx3Ar0NLDf/DLd81UgM5RUaUNpAtcJfiG8ReXuBEs
 yl4XBmh3j56iWb0Gj7ACHKh2s6DpG5ngZpb15Xq5kYokPgqRC0tzmKWYrflQyoQ8oeG1OnZHpAC
 wuL6MjI1DM8AC8VsloA4hEcOE0QCKrsAmVQaZqJ23j/wnAmlqop0a6eXct4UESFSEohy/+7C9va
 hzim/pru1moO95x8HJA==
X-Proofpoint-GUID: GFJzAzxUuTJc2c-RZw-rtI56xyigCmjo
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae4ad7a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=t6caM6LhBjHRVb_eLowA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: GFJzAzxUuTJc2c-RZw-rtI56xyigCmjo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX7d+UDm8qOX0a
 Ma//R0cI8O/d1NTldsXC9R0y9HzCOpg3k1R2/fciEbClGln556z4VJpuA6bKXiELNwNa06SFwEb
 wlZdNkh5uIILMHI2ITCE4XmDdfsJKvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> Define HLX multiply and multiply-accumulate instructions.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/hlx/encode_ext.def | 25 ++++++++
>   target/hexagon/imported/hlx_ext.idef       | 72 ++++++++++++++++++++++
>   2 files changed, 97 insertions(+)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
> index 520af860da..ee15c251d8 100644
> --- a/target/hexagon/imported/hlx/encode_ext.def
> +++ b/target/hexagon/imported/hlx/encode_ext.def
> @@ -51,6 +51,31 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
>   DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
>   DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
>   
> +DEF_ENC(LX_mpyr_uw_uh,"11100111000tttttPP1000uuuu0dddd0")
> +DEF_ENC(LX_mpy_uw_uh,"11100111000vvvv0PP1000uuuu0dddd1")
> +DEF_ENC(LX_mpyr_w_huh,"11100111000tttttPP1000uuuu1dddd0")
> +DEF_ENC(LX_mpy_w_huh,"11100111000vvvv0PP1000uuuu1dddd1")
> +DEF_ENC(LX_mpy_w_h,"11100111000vvvv0PP1001uuuu0dddd0")
> +DEF_ENC(LX_mpyr_w_h,"11100111000tttttPP1001uuuu0dddd1")
> +DEF_ENC(LX_mpa_wuh,"11100111000vvvv-PP1001uuuu1xxxx0")
> +DEF_ENC(LX_mpar_wuh,"11100111000tttttPP1001uuuu1xxxx1")
> +DEF_ENC(LX_mpar_whuh,"11100111000tttttPP1010uuuu0xxxx0")
> +DEF_ENC(LX_mpa_whuh,"11100111000vvvv-PP1010uuuu0xxxx1")
> +DEF_ENC(LX_mpar_wh,"11100111000tttttPP1010uuuu1xxxx0")
> +DEF_ENC(LX_mpa_wh,"11100111000vvvv-PP1010uuuu1xxxx1")
> +DEF_ENC(LX_mpar_wuh_lo,"11100111000tttttPP1011uuuu0xxxx0")
> +DEF_ENC(LX_mpa_wuh_lo,"11100111000vvvv-PP1011uuuu0xxxx1")
> +DEF_ENC(LX_mpar_whuh_lo,"11100111000tttttPP1011uuuu1xxxx0")
> +DEF_ENC(LX_mpa_whuh_lo,"11100111000vvvv-PP1011uuuu1xxxx1")
> +DEF_ENC(LX_mpar_wuh_hi,"11100111000tttttPP1100uuuu0xxxx0")
> +DEF_ENC(LX_mpa_wuh_hi,"11100111000vvvv-PP1100uuuu0xxxx1")
> +DEF_ENC(LX_mpar_wh_hi,"11100111000tttttPP1100uuuu1xxxx0")
> +DEF_ENC(LX_mpa_wh_hi,"11100111000vvvv-PP1100uuuu1xxxx1")
> +DEF_ENC(LX_mpar_uwuhuw_si,"11100111111tttttPP1101uuuu0xxxx0")
> +DEF_ENC(LX_mpa_uwuhuw_si,"11100111111vvvv-PP1101uuuu0xxxx1")
> +DEF_ENC(LX_mpar_wuhw_si,"11100111111tttttPP1101uuuu1xxxx0")
> +DEF_ENC(LX_mpa_wuhw_si,"11100111111vvvv-PP1101uuuu1xxxx1")
> +
>   DEF_ENC(LX_lut4,"11101101000tttttPP1000uuuu0dddd0")
>   DEF_ENC(LX_lut4_sh,"11101101000tttttPP1000uuuu0dddd1")
>   DEF_ENC(LX_lut4_sh_neg,"11101101000tttttPP1000uuuu1dddd0")
> diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
> index 7a6ab194b9..1e52148941 100644
> --- a/target/hexagon/imported/hlx_ext.idef
> +++ b/target/hexagon/imported/hlx_ext.idef
> @@ -73,6 +73,78 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].w ^ -(Luu
>   EXTINSN(LX_sub_ilog2_uw,"Ld16.h=sub(ilog2(Luu16.uw),#u5)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_SCALAR32),"Count leading bits of unsigned word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fBIT_WIDTH(32,LuuV.l[i].uw) - 1 - uiV; fHIDE(check_ilog2_compliance(LdV.h[i],LuuV.l[i].uw, uiV);); })
>   
> +EXTINSN(LX_mpyr_uw_uh,"Ldd16.uw=mpy(Lu16.uh,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX unsigned half and scalar unsigned half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fLMPY16UU(LuV.uh[i],fGETUHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpy_uw_uh,"Ldd16.uw=mpy(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with two HLX unsigned half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fLMPY16UU(LuV.uh[i],LvV.uh[i]); })
> +
> +EXTINSN(LX_mpyr_w_huh,"Ldd16.w=mpy(Lu16.h,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX unsigned half and scalar unsigned half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SU(LuV.h[i],fGETUHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpy_w_huh,"Ldd16.w=mpy(Lu16.h,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with unsigned half and signed half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SU(LuV.h[i],LvV.uh[i]); })
> +
> +EXTINSN(LX_mpyr_w_h,"Ldd16.w=mpy(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Widening multiply with HLX signed half and scalar signed half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SS(LuV.h[i],fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpy_w_h,"Ldd16.w=mpy(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Widening multiply with signed half and signed half",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fLMPY16SS(LuV.h[i],LvV.h[i]); })
> +
> +EXTINSN(LX_mpar_wuh,"Lxx16.w+=mpy(Lu16.uh,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w += fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpa_wuh,"Lxx16.w+=mpy(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w += fLMPY16UU(LuV.uh[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_mpar_whuh,"Lxx16.w+=mpy(Lu16.h,Rt32.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpa_whuh,"Lxx16.w+=mpy(Lu16.h,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SU(LuV.h[i], LvV.uh[i]); })
> +
> +EXTINSN(LX_mpar_wh,"Lxx16.w+=mpy(Lu16.h,Rt32.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SS(LuV.h[i], fGETHALF(0,RtV)); })
> +
> +EXTINSN(LX_mpa_wh,"Lxx16.w+=mpy(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LxxV.l[i].w + fLMPY16SS(LuV.h[i], LvV.h[i]); })
> +
> +EXTINSN(LX_mpar_wuh_lo,"Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[0]); })
> +
> +EXTINSN(LX_mpa_wuh_lo,"Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i],LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[0]); })
> +
> +EXTINSN(LX_mpar_whuh_lo,"Lxx16.w=add(mpy(Lu16.h,Rt32.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[0]); })
> +
> +EXTINSN(LX_mpa_whuh_lo,"Lxx16.w=add(mpy(Lu16.h,Lv16.uh),lo(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fLMPY16SU(LuV.h[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[0]); })
> +
> +EXTINSN(LX_mpar_wuh_hi,"Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[1]); })
> +
> +EXTINSN(LX_mpa_wuh_hi,"Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16UU(LuV.uh[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[1]); })
> +
> +EXTINSN(LX_mpar_wh_hi,"Lxx16.uw=add(mpy(Lu16.h,Rt32.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16SU(LuV.h[i], fGETUHALF(0,RtV)) + fZE16_32(LxxV.l[i].uh[1]); })
> +
> +EXTINSN(LX_mpa_wh_hi,"Lxx16.uw=add(mpy(Lu16.h,Lv16.uh),hi(Lxx16).uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_ADD),"",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fLMPY16SU(LuV.h[i], LvV.uh[i]) + fZE16_32(LxxV.l[i].uh[1]); })
> +
> +EXTINSN(LX_mpar_uwuhuw_si,"Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Rt32.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = fGETWORD(0,RtV) + fMPY3216UU(LxxV.l[i].uh[1],LuV.h[i]); })
> +
> +EXTINSN(LX_mpa_uwuhuw_si,"Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].uw = LvvV.l[i].w + fMPY3216UU(LxxV.l[i].uh[1],LuV.h[i]); })
> +
> +EXTINSN(LX_mpar_wuhw_si,"Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Rt32.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = fGETWORD(0,RtV) + fMPY3216SU(LxxV.l[i].h[1],LuV.uh[i]); })
> +
> +EXTINSN(LX_mpa_wuhw_si,"Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_MPY,A_RESTRICT_SLOT3ONLY,A_HLX_LXX_MPY),"Large multiply add",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LxxV.l[i].w = LvvV.l[i].w + fMPY3216SU(LxxV.l[i].h[1],LuV.uh[i]); })
> +
>   EXTINSN(LX_L16b_tmp,"Ld16.tmp=mem(Rs32)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_NOTE_HLX_MEM,A_HLX_MEM,A_VTCM_ALLBANK_ACCESS,A_LOAD,A_RESTRICT_SLOT1ONLY,A_HLX_TMP),"Aligned HLX load",
>   { fEA_REG(RsV); fLOADMML(EA,LdV,false,false);})
>   


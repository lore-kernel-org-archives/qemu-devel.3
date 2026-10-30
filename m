Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W5ZPAgEq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jQ3rJ4BE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnvJ-0008I4-94; Fri, 30 Oct 2026 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnv9-0008Ff-F9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:49:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnv5-0005pE-Fm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:49:31 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDSN4141541
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pyr5kFR5HfKaa1t4UqgSHpzHLXBtoZhqca0rya1hkgA=; b=W5ZPAgEqxWYZSliL
 t1FQD7nPspt+SFrrWvqZERrTuXPiZZVxIeSzfk9tuBIQrCU0DvIBqykV86AMp3Df
 j/FcOUkLj74RyilYu2Iun/pqXY3eeivuG3xIK41qyS9WFMOeP93eToN3Ppb+ms2T
 jhld6LdE5e8SxXP3wA+N0W7nEaqkEyZfiZuQLYiJCYVaLvBKxm9CQ+m/B6UjMy/B
 SKKltv6wAi+DxcIrYs4JFBdhCgoupeXqQpYNsLgOirIBRd+CZ7BSChm/VQOvwS+J
 MXvEk9/7nw8810WOwOqu5HOJZDVYUNYUxU3eKOjMj/NM0loT2cb5g2xrmKHUoxvZ
 fMfdSA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6quhjg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:49:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7886e8dfso16998696d6.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371765; x=1793976565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pyr5kFR5HfKaa1t4UqgSHpzHLXBtoZhqca0rya1hkgA=;
 b=jQ3rJ4BEUVtadyxJO4AmqksvvQ8pccy0DRQqeNuOs5o13WzMZWTm07RI5ZmXym6rqQ
 CinQ8E/odMaFSFByjZ6rBbObj4Rhbhf3skRdEUL69SIkUCLQkA1ayfH2RnSAgXNxgQNt
 Vtny/YFHLlJWykCvNXr3CeXdfKhzgVBcOLm2HBnYxXh93uO68lVYGAZHYVqezglk/hNy
 Q+9hleqepmxdkslSLyl97HIZMAm8eQppgbZCAEUjl6ZA8X2phDNUSFEN6sTbb9XQZISJ
 bs7E5B6dJMcXU34Ti+q5lhGisrmLRe2jwohlwHMxLfXxlHBGobCBz2STZOEHCWiHDjo+
 ZBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371765; x=1793976565;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pyr5kFR5HfKaa1t4UqgSHpzHLXBtoZhqca0rya1hkgA=;
 b=nhnvYrDrLR+Ka3Edv6Y/IUyaXUvU6cdCsv8UJpC/ZAmrYaMeN4r/Tt7xZk8S/7x0rd
 gP1SZRgxfJXx9IgiG/pb0yNLXPaZb3xGUbsZb/WGSMVXfBz29ixXQj0zEho6Y1CEFds3
 GSHLtPzjjODyeD+rmN3XASJI9m6PuyI60ZPkMQaKHv1I8YqikUh0EXB+EdipFMjUrGaM
 JUl01hzKwSIpS9eeiatSzU17geabzkm4MM4YefJmxPLBWxkI4XWYf9oOtJau15R7iuW0
 bu75zOtAFRHnNUV+p/OCfr0KEY9CAWV3OVFk+SI/n3LqB51xI5RN3OMnG8xvxkbCmKue
 goIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU+5vIXJTX/5xNyt29OyPp/IUuWxraTjvuW6hT0pCMgQgCcO6SYgcdZh4xw1slgbalju4jVFmEZ/S5@nongnu.org
X-Gm-Message-State: AFq9FYKAUpx1hJ7h1NYqipJqxKlQ+oPzxa/e+PzAr2Av6dkpTRB177Hu
 KuPB18uLIaybuI6teVnbpvPqumA4aUKCvaD/CqgOKmdewvnzOVyq6rnpdgwlYybbTSqi0O+3d6p
 pN29CQQKp8UCfAs49FBwro7MGxyjvHTxGLayI4q/+u9H5rmLs+EsvPdD7vQ==
X-Gm-Gg: AYBFou1xpNukP9tTdjSpqGuS/7bNXi2PGZl159FZyZQti5D1/ZF9NcrKnFWOzWe3aqI
 qupdRckPFBp85uOIOkKByYnBOf5vEVzrlBAO1uN0LP/XQT8ujgzk8ifPzEYDeHa2PdaHpeOekO8
 TPOb87Svfva/G1Mj7gkofoztu3xaiK1e7S1QygSdaGsg1CvwIdspFOODlN+z4SAQt32e+HnW9fg
 wFqZxIB+aXmx9WgQ+W93sU+fQ0DL+MP2cfoKPxOy6Zr9zXp+7ievw9U0U6Mr4jiX1XzL53B2sRY
 /oVyqo/78VvJleb5OgsnQc+ZlpDMYqhWtAF7roDe4fkKCc/rRFjWZr3Rj1sC5iUzN6oY8PJvNLe
 XbGEeFf8qjwXYyHb50xWLD/WNb1fHEVHTHFDsyaeq1Ae7FUkjK+a4AxDH6SI2HX8Ernx/ABih2S
 miCEmjm7jAXj6on8sOhHxbxTL/1bAJkU1LPqhp3g==
X-Received: by 2002:a05:6214:240b:b0:91c:996a:7fd5 with SMTP id
 6a1803df08f44-91ca49f5b3fmr37801226d6.2.1793371764543; 
 Fri, 30 Oct 2026 07:49:24 -0700 (PDT)
X-Received: by 2002:a05:6214:240b:b0:91c:996a:7fd5 with SMTP id
 6a1803df08f44-91ca49f5b3fmr37800696d6.2.1793371763887; 
 Fri, 30 Oct 2026 07:49:23 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e23b0bsm17007976d6.2.2026.10.30.07.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:49:23 -0700 (PDT)
Message-ID: <7abe4c26-e5f7-48dd-9ee5-846df1b9fe08@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:49:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] target/hexagon: add HLX paired ALU instructions
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-16-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-16-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: g7jFM4-5S7_s7gBnaLCLcD7NmwoamV9d
X-Proofpoint-ORIG-GUID: g7jFM4-5S7_s7gBnaLCLcD7NmwoamV9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX75XSP3pi8IWC
 syk+K42aNYTv3AHd9YQs28+vd+7esx03Xxmazci/BFpNNrB5n8idoU1brDD7cNzguQ4grdnkEHz
 W3Wm+Fs12l7lg21eRmB11MMrFpl0jWq/ANxg5bkRpIEaV3HDe7GZJP6jiP2rv78gL2hNRbPxNll
 0sa3VKEzzdXxay+IueoFJQswe/1XRU0WeYLcJAkMTEKjtq5VbiVfQ9FxmkOy8wv2PVFdqW4lCNR
 GjdIRpbQ0LgzIPXq3Lthu7lRIHbZ/UwS1hNfFRXTTdhdJnsIZSUmZHjkyR9H1QuoyNIpXXi6Hes
 c2RB8S4S/kPZV04VqtJfcGlOvgKLNPvbH1aAAHxFJWiIt6omWhLJuhDAwt50C4FzVfv8eKNEtx8
 l+BfIvarpGED77LHeQdtbPVOsP9d6waZOwaGK9ZpxTvr5Yz+KvUqWY/OgPRiStJToqsAQ6hd0Ti
 eRjYlJTqqheE4SLaNSg==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4ae75 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jJt_iha1_3nJl9pDp8QA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX+tGI9krBiDJk
 MjtSaIpXTGBQnyxGgjx5VmApd8a4sFHx1A//ZHg5m80jkgiNnb15SXcpOHtZ7mJvxsl4SSlqwRP
 mjyaTe+pdVlDSUF9O+z7W9ioD0wfFf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
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
> Define HLX pair arithmetic, compare, logical, and combine instructions.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/imported/hlx/encode_ext.def |  40 +++++++
>   target/hexagon/imported/hlx_ext.idef       | 117 +++++++++++++++++++++
>   2 files changed, 157 insertions(+)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>
> diff --git a/target/hexagon/imported/hlx/encode_ext.def b/target/hexagon/imported/hlx/encode_ext.def
> index cb6d1b03d8..5a11f58d79 100644
> --- a/target/hexagon/imported/hlx/encode_ext.def
> +++ b/target/hexagon/imported/hlx/encode_ext.def
> @@ -51,6 +51,46 @@ DEF_ENC(LX_sub_wuh,"11100101001vvvv-PP1010uuuu0dddd1")
>   DEF_ENC(LX_assign_u,"11100101001iiiiiPP1010----1dddd0")
>   DEF_ENC(LX_assign_s,"11100101001iiiiiPP1010----1dddd1")
>   
> +DEF_ENC(LX_add_w,"11101111000vvvv-PP1000uuuu0dddd0")
> +DEF_ENC(LX_add_w_sat,"11101111000vvvv-PP1000uuuu0dddd1")
> +DEF_ENC(LX_add_uw_sat,"11101111000vvvv-PP1000uuuu1dddd0")
> +DEF_ENC(LX_add_uw_w_sat,"11101111000vvvv-PP1000uuuu1dddd1")
> +DEF_ENC(LX_sub_w,"11101111000vvvv-PP1001uuuu0dddd0")
> +DEF_ENC(LX_sub_w_sat,"11101111000vvvv-PP1001uuuu0dddd1")
> +DEF_ENC(LX_sub_uw_sat,"11101111000vvvv-PP1001uuuu1dddd0")
> +DEF_ENC(LX_sub_uw_w_sat,"11101111000vvvv-PP1001uuuu1dddd1")
> +DEF_ENC(LX_add_hp,"11101111000vvvv-PP1010uuuu0dddd0")
> +DEF_ENC(LX_add_hp_sat,"11101111000vvvv-PP1010uuuu0dddd1")
> +DEF_ENC(LX_add_uhp_sat,"11101111000vvvv-PP1010uuuu1dddd0")
> +DEF_ENC(LX_add_uhp_h_sat,"11101111000vvvv-PP1010uuuu1dddd1")
> +DEF_ENC(LX_sub_hp,"11101111000vvvv-PP1011uuuu0dddd0")
> +DEF_ENC(LX_sub_hp_sat,"11101111000vvvv-PP1011uuuu0dddd1")
> +DEF_ENC(LX_sub_uhp_sat,"11101111000vvvv-PP1011uuuu1dddd0")
> +DEF_ENC(LX_sub_uhp_h_sat,"11101111000vvvv-PP1011uuuu1dddd1")
> +DEF_ENC(LX_abs_uw,"11101111000-----PP1100uuuu0dddd0")
> +DEF_ENC(LX_abs_uw_sat,"11101111000-----PP1100uuuu0dddd1")
> +DEF_ENC(LX_abs_uhp,"11101111000-----PP1100uuuu1dddd0")
> +DEF_ENC(LX_abs_uhp_sat,"11101111000-----PP1100uuuu1dddd1")
> +DEF_ENC(LX_cmp_gt_uw,"11101111000vvvv-PP1101uuuu0dddd0")
> +DEF_ENC(LX_cmp_gt_w,"11101111000vvvv-PP1101uuuu0dddd1")
> +DEF_ENC(LX_cmp_gt_hp,"11101111000vvvv-PP1101uuuu1dddd0")
> +DEF_ENC(LX_cmp_gt_uhp,"11101111000vvvv-PP1101uuuu1dddd1")
> +DEF_ENC(LX_min_hp,"11101111000vvvv-PP1110uuuu0dddd0")
> +DEF_ENC(LX_min_uhp,"11101111000vvvv-PP1110uuuu0dddd1")
> +DEF_ENC(LX_max_hp,"11101111000vvvv-PP1110uuuu1dddd0")
> +DEF_ENC(LX_max_uhp,"11101111000vvvv-PP1110uuuu1dddd1")
> +DEF_ENC(LX_min_w,"11101111000vvvv-PP1111uuuu0dddd0")
> +DEF_ENC(LX_min_uw,"11101111000vvvv-PP1111uuuu0dddd1")
> +DEF_ENC(LX_max_w,"11101111000vvvv-PP1111uuuu1dddd0")
> +DEF_ENC(LX_max_uw,"11101111000vvvv-PP1111uuuu1dddd1")
> +DEF_ENC(LX_and_w,"11101111001vvvv-PP1000uuuu0dddd0")
> +DEF_ENC(LX_or_w,"11101111001vvvv-PP1000uuuu0dddd1")
> +DEF_ENC(LX_xor_w,"11101111001vvvv-PP1000uuuu1dddd0")
> +DEF_ENC(LX_combine_w,"11101111001vvvv-PP1000uuuu1dddd1")
> +DEF_ENC(LX_andn_w,"11101111001vvvv-PP1001uuuu0dddd0")
> +DEF_ENC(LX_not_w,"11101111001-----PP1001uuuu0dddd1")
> +DEF_ENC(LX_orn_w,"11101111001vvvv-PP1001uuuu1dddd0")
> +
>   #undef DEF_ENC
>   #undef EXTEXTNAME
>   #undef CONCAT
> diff --git a/target/hexagon/imported/hlx_ext.idef b/target/hexagon/imported/hlx_ext.idef
> index 4cee4ce816..47e1171473 100644
> --- a/target/hexagon/imported/hlx_ext.idef
> +++ b/target/hexagon/imported/hlx_ext.idef
> @@ -85,18 +85,90 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fZXTN(16,32,LuV.uh[i]); })
>   EXTINSN(LX_conv_w_h,"Ldd16.w=sxt(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Convert halfword to word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fSXTN(16,32,LuV.h[i]); })
>   
> +EXTINSN(LX_add_w,"Ldd16.w=add(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w + LvvV.l[i].w; })
> +
> +EXTINSN(LX_add_w_sat,"Ldd16.w=add(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSADDSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_add_uw_sat,"Ldd16.uw=add(Luu16.uw,Lvv16.uw):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUADDSAT(32, LuuV.l[i].uw, LvvV.l[i].uw); })
> +
> +EXTINSN(LX_add_uw_w_sat,"Ldd16.uw=add(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector add & saturate unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSADDSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_sub_w,"Ldd16.w=sub(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w - LvvV.l[i].w; })
> +
> +EXTINSN(LX_sub_w_sat,"Ldd16.w=sub(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSSUBSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_sub_uw_sat,"Ldd16.uw=sub(Luu16.uw,Lvv16.uw):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSUBSAT(32, LuuV.l[i].uw, LvvV.l[i].uw); })
> +
> +EXTINSN(LX_sub_uw_w_sat,"Ldd16.uw=sub(Luu16.w,Lvv16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector sub & saturate unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fVUSSUBSAT(32, LuuV.l[i].w, LvvV.l[i].w); })
> +
> +EXTINSN(LX_add_hp,"Ldd16.h=add(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = LuuV.l[i].h[0] + LvvV.l[i].h[0]; LddV.l[i].h[1] = LuuV.l[i].h[1] + LvvV.l[i].h[1] ; })
> +
> +EXTINSN(LX_add_hp_sat,"Ldd16.h=add(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSADDSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].h[1] = fVSADDSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
> +
> +EXTINSN(LX_add_uhp_sat,"Ldd16.uh=add(Luu16.uh,Lvv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate unsigned paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUADDSAT(16, LuuV.l[i].uh[0], LvvV.l[i].uh[0]); LddV.l[i].uh[1] = fVUADDSAT(16, LuuV.l[i].uh[1], LvvV.l[i].uh[1]) ; })
> +
> +EXTINSN(LX_add_uhp_h_sat,"Ldd16.uh=add(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register add & saturate unsigned paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSADDSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].uh[1] = fVUSADDSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
> +
> +EXTINSN(LX_sub_hp,"Ldd16.h=sub(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = LuuV.l[i].h[0] - LvvV.l[i].h[0]; LddV.l[i].h[1] = LuuV.l[i].h[1] - LvvV.l[i].h[1] ; })
> +
> +EXTINSN(LX_sub_hp_sat,"Ldd16.h=sub(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSSUBSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].h[1] = fVSSUBSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
> +
> +EXTINSN(LX_sub_uhp_sat,"Ldd16.uh=sub(Luu16.uh,Lvv16.uh):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate unsigned paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSUBSAT(16, LuuV.l[i].uh[0], LvvV.l[i].uh[0]); LddV.l[i].uh[1] = fVUSUBSAT(16, LuuV.l[i].uh[1], LvvV.l[i].uh[1]) ; })
> +
> +EXTINSN(LX_sub_uhp_h_sat,"Ldd16.uh=sub(Luu16.h,Lvv16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"L register sub & saturate unsigned paired halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fVUSSUBSAT(16, LuuV.l[i].h[0], LvvV.l[i].h[0]); LddV.l[i].uh[1] = fVUSSUBSAT(16, LuuV.l[i].h[1], LvvV.l[i].h[1]) ; })
> +
>   EXTINSN(LX_abs_uh,"Ld16.uh=abs(Lu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value of large vector of half word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = fABSW(LuV.h[i]); })
>   
>   EXTINSN(LX_abs_uh_sat,"Ld16.h=abs(Lu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Absolute value & saturate of large vector of half word",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = fVSATH(fABSW(LuV.h[i])); })
>   
> +EXTINSN(LX_abs_uw,"Ldd16.uw=abs(Luu16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value of large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = fABSW(LuuV.l[i].w); })
> +
> +EXTINSN(LX_abs_uw_sat,"Ldd16.w=abs(Luu16.w):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = fVSATW(fABSW(LuuV.l[i].w)); })
> +
> +EXTINSN(LX_abs_uhp,"Ldd16.uh=abs(Luu16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value of L register pair halfword",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = fABSW(LuuV.l[i].h[0]); LddV.l[i].uh[1] = fABSW(LuuV.l[i].h[1]) ; })
> +
> +EXTINSN(LX_abs_uhp_sat,"Ldd16.h=abs(Luu16.h):sat",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Absolute value & saturate of large vector of word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = fVSATH(fABSW(LuuV.l[i].h[0])); LddV.l[i].h[1] = fVSATH(fABSW(LuuV.l[i].h[1])) ; })
> +
>   EXTINSN(LX_cmp_gt_uh,"Ld16.h=cmp.gt(Lu16.uh, Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Unsigned compare greater than",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.uh[i] > LvV.uh[i]) ? 0xFFFF : 0x0; })
>   
>   EXTINSN(LX_cmp_gt_h,"Ld16.h=cmp.gt(Lu16.h, Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Signed compare greater than",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? 0xFFFF : 0x0; })
>   
> +EXTINSN(LX_cmp_gt_w,"Ldd16.w=cmp.gt(Luu16.w, Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector signed word compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w > LvvV.l[i].w) ? 0xFFFFFFFF : 0x0; })
> +
> +EXTINSN(LX_cmp_gt_uw,"Ldd16.w=cmp.gt(Luu16.uw, Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Word element compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].uw > LvvV.l[i].uw) ? 0xFFFFFFFF : 0x0; })
> +
> +EXTINSN(LX_cmp_gt_hp,"Ldd16.h=cmp.gt(Luu16.h, Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector signed word compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] > LvvV.l[i].h[0]) ? 0xFFFF : 0x0; LddV.l[i].h[1] = (LuuV.l[i].h[1] > LvvV.l[i].h[1]) ? 0xFFFF : 0x0 ; })
> +
> +EXTINSN(LX_cmp_gt_uhp,"Ldd16.h=cmp.gt(Luu16.uh, Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Word element compare greater than",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].uh[0] > LvvV.l[i].uh[0]) ? 0xFFFF : 0x0; LddV.l[i].h[1] = (LuuV.l[i].uh[1] > LvvV.l[i].uh[1]) ? 0xFFFF : 0x0 ; })
> +
>   EXTINSN(LX_max_uh,"Ld16.uh=max(Lu16.uh,Lv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = (LuV.uh[i] > LvV.uh[i]) ? LuV.uh[i] : LvV.uh[i]; })
>   
> @@ -109,6 +181,30 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] > LvV.h[i]) ? LuV.h[i]
>   EXTINSN(LX_min_h,"Ld16.h=min(Lu16.h,Lv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Large vector max ",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i] = (LuV.h[i] < LvV.h[i]) ? LuV.h[i] : LvV.h[i]; })
>   
> +EXTINSN(LX_min_w,"Ldd16.w=min(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w < LvvV.l[i].w) ? LuuV.l[i].w : LvvV.l[i].w; })
> +
> +EXTINSN(LX_min_uw,"Ldd16.uw=min(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw < LvvV.l[i].uw) ? LuuV.l[i].uw : LvvV.l[i].uw; })
> +
> +EXTINSN(LX_max_w,"Ldd16.w=max(Luu16.w,Lvv16.w)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = (LuuV.l[i].w > LvvV.l[i].w) ? LuuV.l[i].w : LvvV.l[i].w; })
> +
> +EXTINSN(LX_max_uw,"Ldd16.uw=max(Luu16.uw,Lvv16.uw)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw = (LuuV.l[i].uw > LvvV.l[i].uw) ? LuuV.l[i].uw : LvvV.l[i].uw; })
> +
> +EXTINSN(LX_min_hp,"Ldd16.h=min(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] < LvvV.l[i].h[0]) ? LuuV.l[i].h[0] : LvvV.l[i].h[0]; LddV.l[i].h[1] = (LuuV.l[i].h[1] < LvvV.l[i].h[1]) ? LuuV.l[i].h[1] : LvvV.l[i].h[1]; ; })
> +
> +EXTINSN(LX_min_uhp,"Ldd16.uh=min(Luu16.uh,Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector min unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = (LuuV.l[i].uh[0] < LvvV.l[i].uh[0]) ? LuuV.l[i].uh[0] : LvvV.l[i].uh[0]; LddV.l[i].uh[1] = (LuuV.l[i].uh[1] < LvvV.l[i].uh[1]) ? LuuV.l[i].uh[1] : LvvV.l[i].uh[1]; ; })
> +
> +EXTINSN(LX_max_hp,"Ldd16.h=max(Luu16.h,Lvv16.h)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[0] = (LuuV.l[i].h[0] > LvvV.l[i].h[0]) ? LuuV.l[i].h[0] : LvvV.l[i].h[0]; LddV.l[i].h[1] = (LuuV.l[i].h[1] > LvvV.l[i].h[1]) ? LuuV.l[i].h[1] : LvvV.l[i].h[1]; ; })
> +
> +EXTINSN(LX_max_uhp,"Ldd16.uh=max(Luu16.uh,Lvv16.uh)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector max unsigned word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uh[0] = (LuuV.l[i].uh[0] > LvvV.l[i].uh[0]) ? LuuV.l[i].uh[0] : LvvV.l[i].uh[0]; LddV.l[i].uh[1] = (LuuV.l[i].uh[1] > LvvV.l[i].uh[1]) ? LuuV.l[i].uh[1] : LvvV.l[i].uh[1]; ; })
> +
>   EXTINSN(LX_and,"Ld16=and(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical And",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & LvV.uh[i]; })
>   
> @@ -127,12 +223,33 @@ fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] & ~LvV.uh[i]; })
>   EXTINSN(LX_orn,"Ld16=orn(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Logical not OR",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i] = LuV.uh[i] | ~LvV.uh[i]; })
>   
> +EXTINSN(LX_and_w,"Ldd16=and(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical AND word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w & LvvV.l[i].w; })
> +
> +EXTINSN(LX_or_w,"Ldd16=or(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical OR word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w | LvvV.l[i].w; })
> +
> +EXTINSN(LX_xor_w,"Ldd16=xor(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical XOR word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w ^ LvvV.l[i].w; })
> +
> +EXTINSN(LX_andn_w,"Ldd16=andn(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical AND NOT word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w & ~LvvV.l[i].w; })
> +
> +EXTINSN(LX_orn_w,"Ldd16=orn(Luu16,Lvv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Large vector logical OR NOT word",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w = LuuV.l[i].w | ~LvvV.l[i].w; })
> +
> +EXTINSN(LX_not_w,"Ldd16=not(Luu16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Assign an Lreg",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].uw=~LuuV.l[i].uw; })
> +
>   EXTINSN(LX_assign,"Ld16.h=Lu16.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign an Lreg",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.uh[i]=LuV.uh[i]; })
>   
>   EXTINSN(LX_assign_w,"Ldd16.w=Luu16.w",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23),"Assign a double Lreg",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].w=LuuV.l[i].w; })
>   
> +EXTINSN(LX_combine_w,"Ldd16=combine(Lu16,Lv16)",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_SHIFT,A_RESTRICT_SLOT2ONLY,A_HLX_PAIRED_ALU),"Combine two lregs",
> +fHIDE(int i;) fLVFOREACH(1024, i) { LddV.l[i].h[1] = LuV.h[i]; LddV.l[i].h[0] = LvV.h[i];; })
> +
>   EXTINSN(LX_assign_r,"Ld16.h=Rt32.h",ATTRIBS(A_HLX,A_EXTENSION,A_NO_IDEF_PARSER,A_HLX_COMMON_ALU,A_HLX_SLOT23,A_HLX_CU_SCALAR,A_HLX_SCALAR32),"Assign half a scalar register to L register",
>   fHIDE(int i;) fLVFOREACH(1024, i) { LdV.h[i]=fGETHALF(0,RtV); })
>   


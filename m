Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0999C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqpu-00007N-63; Fri, 05 Jul 2024 17:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sPqpq-000072-5Y; Fri, 05 Jul 2024 17:51:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sPqpo-0002y3-Kn; Fri, 05 Jul 2024 17:51:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465FtaiE019711;
 Fri, 5 Jul 2024 21:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lXmK6myZBy50VZ65+i/tMOm2m1kdjo+jcUjIzITE/ok=; b=g5I9uWrRhSGwszOR
 q9tPU3sHP5y/UaxaW28gO5hCDmBCyZlaE0k4XCR6eChh7NCUYKV5ZwIUMOCCSlMI
 izuxVtjpFePPwbgEjaxbX9VP6oY62s/QcGIRl4D8PzrA2Xn50ESqUOScDzuLDCKM
 Y58adf35AHvX3fik9sywSxl/Hj+Lt3UYhRuVsdZXgtlyumRjm1fp30HwG2d7Hsg5
 AkfLCCCdQ8hxorpG4Vd9VJ44hxlBtMmHIIDDk5BFoBLXNib0w/YyX/Iu48dKu10g
 uVKxwKbQDIcvj2hJrEhthUI3dQL1XKp9ceE2Q3V2tMQwBmjiw6RMR9cy7KWlcqvY
 MRSpmQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406cwwa0sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jul 2024 21:51:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 465Lp7AO024379
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 5 Jul 2024 21:51:07 GMT
Received: from [10.110.93.59] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 14:51:06 -0700
Message-ID: <82dc0f6f-a00a-4013-84f7-8c6522062965@quicinc.com>
Date: Fri, 5 Jul 2024 16:50:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Cain <quic_bcain@quicinc.com>
Subject: Re: [PATCH 4/4] target/hexagon/imported/mmvec: Fix superfluous
 trailing semicolon
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>, "Laurent
 Vivier" <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
CC: <qemu-trivial@nongnu.org>, <qemu-devel@nongnu.org>, Brian Cain
 <bcain@quicinc.com>
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-5-zhao1.liu@intel.com>
Content-Language: en-US
In-Reply-To: <20240704084759.1824420-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: h21B1juOAN0H-Aggas0CcGXdLu9oxKZf
X-Proofpoint-GUID: h21B1juOAN0H-Aggas0CcGXdLu9oxKZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_16,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 adultscore=0 mlxlogscore=677 lowpriorityscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407050161
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/4/2024 3:47 AM, Zhao Liu wrote:
> Fix the superfluous trailing semicolon in target/hexagon/imported/mmvec/
> ext.idef.
>
> Cc: Brian Cain <bcain@quicinc.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Brian Cain <bcain@quicinc.com>


> ---
>   target/hexagon/imported/mmvec/ext.idef | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
> index 98daabfb07c4..03d31f6181d7 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -2855,7 +2855,7 @@ EXTINSN(V6_vscattermhw_add,  "vscatter(Rt32,Mu2,Vvv32.w).h+=Vw32", ATTRIBS(A_EXT
>       fVALIGN(RtV, element_size);
>       fVFOREACH(32, i) {
>           for(j = 0; j < 2; j++) {
> -             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);;
> +             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);
>                fVLOG_VTCM_HALFWORD_INCREMENT_DV(EA,VvvV.v[j].uw[i],VwV,(2*i+j),i,j,ALIGNMENT,MuV);
>           }
>       }


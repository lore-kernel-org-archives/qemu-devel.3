Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A9AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPiQ-0007gk-PW; Mon, 15 Jul 2024 13:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sTPiL-0007Ys-3g; Mon, 15 Jul 2024 13:42:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sTPiJ-0004nj-Ao; Mon, 15 Jul 2024 13:42:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8g6L029986;
 Mon, 15 Jul 2024 17:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pQjUjO9WFwohyShxbYRl1OcsQjkvGfi2P5LWo7su1e8=; b=ePlxZkrfJEMi2YTQ
 RfWCEPQgwV365JcxhVux7pCv7RMPTLHEqQZJLWsy8cELbCf6Nix5Zgzl+eB3BMmP
 X4+nIwdh9f40CX1PZlEKZ8+nm1oEcXNpkNAUKV33m9jLaH4YMkc8g6O+wxS5sNEL
 k9iUL5NLAG4SwQPcXIPJDT3/eQQMAyBXR2tdIp7eqJAWvQ0zh0T4Gslc0BpoUNyK
 yVzpZ1wvEziVU4HPUCrKh8c8iU8/qX1vhdp/2iBnnD2ebuhgfghAR9bDxMk+ytQK
 wIiwsiesxr8hEXhWa3PF9BDiBHCqweiofSBRidO+WKR/VfkoWIUMWDA1QaejkfZL
 4ncanA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bf9ed47e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 17:42:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46FHg8kG024324
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 17:42:08 GMT
Received: from [10.110.103.187] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 10:42:07 -0700
Message-ID: <a1839140-181a-4547-993f-3a672c889eea@quicinc.com>
Date: Mon, 15 Jul 2024 12:42:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/hexagon/imported/mmvec: Fix superfluous
 trailing semicolon
To: Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-trivial@nongnu.org>, <qemu-devel@nongnu.org>
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-5-zhao1.liu@intel.com>
 <82dc0f6f-a00a-4013-84f7-8c6522062965@quicinc.com>
 <d72fe736-2b6c-4c98-90d7-c613f21a2547@tls.msk.ru>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <d72fe736-2b6c-4c98-90d7-c613f21a2547@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 2nB6anqruvKVbCyfQEw9cChflbd3gHuC
X-Proofpoint-GUID: 2nB6anqruvKVbCyfQEw9cChflbd3gHuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=792 mlxscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407150138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
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


On 7/15/2024 4:59 AM, Michael Tokarev wrote:
> 06.07.2024 00:50, Brian Cain wrote:
>>
>> On 7/4/2024 3:47 AM, Zhao Liu wrote:
>>> Fix the superfluous trailing semicolon in 
>>> target/hexagon/imported/mmvec/
>>> ext.idef.
>>>
>>> Cc: Brian Cain <bcain@quicinc.com>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>
>> Reviewed-by: Brian Cain <bcain@quicinc.com>
>
> Brian, is it okay to fix this in something "imported" ?
> I realize you added your R-b, but do you realize it's "imported"?
>
Sure, it's fine - I'll just have to take extra care not to re-introduce 
issues like these when making updates.  I can try and work with the 
original sources to make sure it's addressed there.


> Thanks,
>
> /mjt
>
>>> ---
>>>   target/hexagon/imported/mmvec/ext.idef | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/target/hexagon/imported/mmvec/ext.idef 
>>> b/target/hexagon/imported/mmvec/ext.idef
>>> index 98daabfb07c4..03d31f6181d7 100644
>>> --- a/target/hexagon/imported/mmvec/ext.idef
>>> +++ b/target/hexagon/imported/mmvec/ext.idef
>>> @@ -2855,7 +2855,7 @@ EXTINSN(V6_vscattermhw_add, 
>>> "vscatter(Rt32,Mu2,Vvv32.w).h+=Vw32", ATTRIBS(A_EXT
>>>       fVALIGN(RtV, element_size);
>>>       fVFOREACH(32, i) {
>>>           for(j = 0; j < 2; j++) {
>>> -             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);;
>>> +             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);
>>> fVLOG_VTCM_HALFWORD_INCREMENT_DV(EA,VvvV.v[j].uw[i],VwV,(2*i+j),i,j,ALIGNMENT,MuV);
>>>           }
>>>       }
>>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1B5C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCvA-0001ca-4r; Wed, 31 Jul 2024 13:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sZCv0-0001bd-Df
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:15:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sZCux-0004Ax-T3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:15:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V98Gg9030656;
 Wed, 31 Jul 2024 17:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 935VHct2+spX1ffOkmBtDKjXidr5uYlYG9QsnyIvzqg=; b=W05yAZFJEL677RnF
 8jjfXO4KtpsqQhd9KqBZF29iljUP28N3ic8kpWqTGuKLxW35RVi6Z48yDRiRUeFv
 slCBcBWXQGGnd9mm0ek3SWA81tirvUnn3Z3xO3b88UwxHAA/OHe5bCggjldCrzmH
 Uq00ORgKuMd6l27uDMUlZdkb8/NvcxLJykexBWs5YopeuwcO187plhqVKDeeVsun
 hyYOHSsL6WAyu+kYcgL9YQUXGND3DRCscxJ9L0RoIjDSIwTxltFWCAE9aZkioXh5
 dEHnrVHx+NoBZ/TdzZnrxIstEsq8smC1GPdNtJOPcCeQLQHzy78Ap53W/vT4TSmx
 deeYIQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43bxej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 17:15:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46VHFACe031005
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 17:15:10 GMT
Received: from [10.110.37.171] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 10:15:09 -0700
Message-ID: <4dc9b238-bad7-4f13-9b22-73fd90914221@quicinc.com>
Date: Wed, 31 Jul 2024 12:15:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon/idef-parser: Remove self-assignment
To: Peter Maydell <peter.maydell@linaro.org>, Brian Cain <bcain@quicinc.com>
CC: Anton Johansson <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20230713120853.27023-1-anjo@rev.ng>
 <SN6PR02MB42058323403CE9291E40E005B837A@SN6PR02MB4205.namprd02.prod.outlook.com>
 <CAFEAcA_VttO0aEO6VBUAB4H9TVNH5tP5piZVq6F4Ao2MZF-UoA@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <CAFEAcA_VttO0aEO6VBUAB4H9TVNH5tP5piZVq6F4Ao2MZF-UoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: hzv8R-th3aRLxrcNAO87s3uwVP556iMX
X-Proofpoint-ORIG-GUID: hzv8R-th3aRLxrcNAO87s3uwVP556iMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310120
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


On 7/31/2024 12:07 PM, Peter Maydell wrote:
> On Thu, 13 Jul 2023 at 17:21, Brian Cain <bcain@quicinc.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Anton Johansson <anjo@rev.ng>
>>> Sent: Thursday, July 13, 2023 7:09 AM
>>> To: qemu-devel@nongnu.org
>>> Cc: Brian Cain <bcain@quicinc.com>; peter.maydell@linaro.org
>>> Subject: [PATCH] target/hexagon/idef-parser: Remove self-assignment
>>>
>>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>>> any links or attachments, and do not enable macros.
>>>
>>> The self assignment is clearly useless, and @1.last_column does not have
>>> to be set for an expression with only a single token, so remove it.
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>>> ---
>>>   target/hexagon/idef-parser/idef-parser.y | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-
>>> parser/idef-parser.y
>>> index cd2612eb8c..a6587f5bcc 100644
>>> --- a/target/hexagon/idef-parser/idef-parser.y
>>> +++ b/target/hexagon/idef-parser/idef-parser.y
>>> @@ -802,7 +802,6 @@ rvalue : FAIL
>>>
>>>   lvalue : FAIL
>>>            {
>>> -             @1.last_column = @1.last_column;
>>>                yyassert(c, &@1, false, "Encountered a FAIL token as lvalue.\n");
>>>            }
>>>          | REG
>>> --
>>> 2.41.0
>> Reviewed-by: Brian Cain <bcain@quicinc.com>
>
> Ping -- I just noticed that this patch never seems to have
> made it upstream. Brian, could you pick it up?
>
> (This fixes a Coverity issue: CID 976926.)

Sorry about that!  Queued at https://github.com/quic/qemu/ hex.next -- 
will include it in an upcoming PR.



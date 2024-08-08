Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA31C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 23:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scC6h-0003pN-GX; Thu, 08 Aug 2024 18:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1scC6g-0003ot-3d
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:59:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1scC6e-0004Np-Fh
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:59:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478Dr6g4010954;
 Thu, 8 Aug 2024 22:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KFfevHN5bqJNj6JRznE9VCd4M3C/I7R45G4CHNgkWt4=; b=JRKbJww0eYGeGQrx
 qcYilLHWz5RDAjqA7CyHjqfaIHySua1DKTToJ9I7ahKlh2NQLQT/mIBCuLqgyHj8
 8/RpwX3UNCSFkvc2wULUXwxGBEivHXOzO+2MytyCuqEJiikXHT4NAZLnCmIYVV/r
 MF7+vW7NABpJyxIXzWaVPlwHBd4Ub+0wVH3KVyjL8mmewhCRCJ86RT+zTvjoEGmz
 EGC7owSiQY0w/JrhN3Rmrtv0Pf5e3kjD010av60p3GhA9ZGZD9kpY7BBXCs/QU8B
 EmNKTSbtHG1Q/QE3Iuq8XOPLgZFWJCY3t58P4rUr/fjS7NkT2OO0LSz7MYeSDvJp
 T1xoOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vpuvjpe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 22:59:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 478MxYPv003328
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 22:59:34 GMT
Received: from [10.110.10.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 Aug 2024
 15:59:33 -0700
Message-ID: <d31caba7-5f52-4655-accf-c6ee7f3d22ff@quicinc.com>
Date: Thu, 8 Aug 2024 17:59:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] hex queue
To: Richard Henderson <richard.henderson@linaro.org>, Brian Cain
 <bcain@quicinc.com>, <qemu-devel@nongnu.org>
CC: <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
References: <20240808034244.4139757-1-bcain@quicinc.com>
 <ed7c7a20-7d32-456d-9cf7-0b706bb07955@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <ed7c7a20-7d32-456d-9cf7-0b706bb07955@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: S008GpAezvh_6xzWAfhsMHdyLh6bogi5
X-Proofpoint-GUID: S008GpAezvh_6xzWAfhsMHdyLh6bogi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_23,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080164
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


On 8/8/2024 5:39 PM, Richard Henderson wrote:
> On 8/8/24 13:42, Brian Cain wrote:
>> The following changes since commit 
>> 4c395ac42e55ff8e9fd4c992e351a04b10785503:
>>
>>    Merge tag 'pull-tcg-20240808' of https://gitlab.com/rth7680/qemu 
>> into staging (2024-08-08 09:07:00 +1000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/quic/qemu tags/pull-hex-20240807
>>
>> for you to fetch changes up to 47f3361a3af9d709218038a23b8907525310d2c3:
>>
>>    target/hexagon: switch to dc set_props() list (2024-08-07 20:37:21 
>> -0700)
>>
>> ----------------------------------------------------------------
>> Hexagon updates: lldb preds, v66 CPU, F2_conv* fix
>
>
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as 
> appropriate.
>
I don't believe I have an account here - can you refer me to more info 
on how to get one?


> r~
>


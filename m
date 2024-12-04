Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A65E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoK1-0008Po-0z; Wed, 04 Dec 2024 07:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1tIoJz-0008Pb-9E; Wed, 04 Dec 2024 07:17:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_llindhol@quicinc.com>)
 id 1tIoJt-0000l0-6R; Wed, 04 Dec 2024 07:17:35 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B41tKJM027245;
 Wed, 4 Dec 2024 12:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4OD6H62D7Ib8iKEn3DZkv3gh31Khg4KW3CH1i2rP2D0=; b=JloN3RrhrK/9gdFb
 JAzfw803jxdIQ2ES8733Ol+PhEd8hdqrBgzApRqzLev6YQtZWYl99JEXthZecS08
 MZqHsTjX8dDPnGpupUXpMLjFor7fDbpysWuFX0qO645yMeC3U2nnexEAbBwUUV9I
 Si8Q2qBMeFhOzPbV1wByW6gQzzEJULw/6OyS4FVXWtnjGbxFgHaF/a8bEJpU2+2d
 ww40IGfFyuUg4vkw1IQmxUKLzGx2mRUUi6Dzy0ZJQBxrsuQ20W3LZ+WkiHdhdb9Q
 cVDkG0MB5/GNHsD/qA3dxXOnKahsyU8sYrW7MrU8R5veUf+9/fWk6D5/bkMHsOEK
 AyQsaQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43a1g5kcb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Dec 2024 12:17:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4CHNnj010397
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 4 Dec 2024 12:17:23 GMT
Received: from [10.111.132.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Dec 2024
 04:17:22 -0800
Message-ID: <2106db77-88fb-4113-ae09-9bf77bce6ad7@quicinc.com>
Date: Wed, 4 Dec 2024 12:17:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: bump default memory size to 2GB
Content-Language: en-GB
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 <leif.lindholm@oss.qualcomm.com>
References: <20241126084928.252067-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA_SkZ+ew8AAVpBHuw-9YW4S5wFbB0Vqx+dBzXf97JGDGw@mail.gmail.com>
 <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
From: Leif Lindholm <quic_llindhol@quicinc.com>
In-Reply-To: <cd635753-4e2c-42d6-bb7b-d558d90f59d7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: szQVR_urJcrEpsWSJi90WC956mPj3V69
X-Proofpoint-ORIG-GUID: szQVR_urJcrEpsWSJi90WC956mPj3V69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=545 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_llindhol@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2024-12-02 10:53, Marcin Juszkiewicz wrote:
> W dniu 26.11.2024 o 14:14, Peter Maydell pisze:
>> On Tue, 26 Nov 2024 at 08:49, Marcin Juszkiewicz
>> <marcin.juszkiewicz@linaro.org> wrote:
>>>
>>> We are working on adding RME support to SBSA Reference Platform.
>>> When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
>>> memory for own use. Which ends with firmware panic on 1GB machine.
>>
>> Reasonable change, but isn't it also a bug in the RMM that it
>> grabs 1GB of RAM regardless of how much RAM the machine
>> actually has?
> 
> I think that the goal is "get it working" first and then optimize.

I agree on a different platform this could feel quite hacky, but in 
reality even 2GB falls within "ridiculously low for an SBSA platform".

If we're worried about overhead for CI jobs that do not require the 
feature, we could always conditionalize it on RME being enabled. But I'd 
be happy to wait and see.

Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>



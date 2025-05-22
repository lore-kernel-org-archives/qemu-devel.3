Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B6DC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI8Gf-0008N1-KU; Thu, 22 May 2025 11:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uI8Ga-0008Lh-0E; Thu, 22 May 2025 11:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uI8GW-0005My-Qd; Thu, 22 May 2025 11:55:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MENVZZ005437;
 Thu, 22 May 2025 15:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=R0DvMj
 CQ4eRAecr6K6HF2TdsCJSYLcEKQg0B77z5rfA=; b=ceDVDx64XQBXY+d8U7RN8G
 NHMVjf5jX+YgG78cE+b227j2KAoBITg5VNxIRnCIcgrz7ESPoTLV5JNwpwPBeAuU
 6T164nhFqT+b9d9kP3+c+5gFSLkspcvO+B1hzZ0XXLL+eiYGWDATzGv1JFBJ2ooG
 hUfhsSOYa0ARAEG/oPl8glbARTrt2GnjMmUvlf3wFPk/ei4wAFrmTMjW37D52jBN
 BBtpf3rcz5LARpI4KZewMNX/1IopcrC3H7kcljCQp5K0LNfSWYqkOs07BUonzF86
 VEG9V49zS/7crEfqnX1fKiFnxFzbHLurhBZ9RyZepspLWk3/2nJa+IICLvNH3PTw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46smf9d8jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 15:55:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDhk6D010701;
 Thu, 22 May 2025 15:55:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwnmj4kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 15:55:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MFtNCN30999294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 15:55:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1960458059;
 Thu, 22 May 2025 15:55:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FEAB58058;
 Thu, 22 May 2025 15:55:22 +0000 (GMT)
Received: from [9.61.242.155] (unknown [9.61.242.155])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 15:55:22 +0000 (GMT)
Message-ID: <c5f9dd66-f11d-4312-a1fb-2651fe894e6d@linux.ibm.com>
Date: Thu, 22 May 2025 11:55:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-3-rreyes@linux.ibm.com>
 <f917f4f3-836b-4bdf-8dde-4d83cb226334@redhat.com>
 <38ba5741-e564-4812-87e2-ba6235e077b1@linux.ibm.com>
 <73d159e9-abde-4f97-8d04-4f8f8783975d@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <73d159e9-abde-4f97-8d04-4f8f8783975d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X4G1FSifaVQC-ggmdeAe6EfKFuIjKxD2
X-Proofpoint-ORIG-GUID: X4G1FSifaVQC-ggmdeAe6EfKFuIjKxD2
X-Authority-Analysis: v=2.4 cv=TbqWtQQh c=1 sm=1 tr=0 ts=682f48ed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pi8Qu_Bq_sj6Cl0Ak0sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1OSBTYWx0ZWRfXyf7+sfUgE8DC
 QZrHd5hcPXLpLlaXQSjhCyUtymCVXtGR1vToc/eYY7byxypdYQ56wOcSqxnfzgX6sHDw0n2eDa2
 NM9MGPgRT8HigK4ldnYP+SZWoGkAXeHnzJYEA+lNAHXsDOo//dWfrxNI81e2N9VKmJwnA1Yw9+E
 FGg/WcqBP3yD67Mk48VRy4LxQUO7fjALpbDIb1b0l6UEShsnBZbRxmsji2MZWsLhuQa/7IdoSsE
 ELKcBXX9oJNtFRqUuDYM24P7fX3nFOCJEInk6tE5/LzDbtXOw+ZLvYnrBP21tCCcM1ow8o2Ox2w
 mnwwUJq3s2pfpc1Ro51k24BBRguZUfgLfr2NW96IW7M9iyYjwpOIKyocONJPDqBwxchGYLgwQD0
 UxQV/lJRtr+69Cd417aXNqkHfSi+uUxB0Yg2dOxCX4v1Daap6vywSBtKi+or9s/FHXBfsXQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/22/25 11:36 AM, Cédric Le Goater wrote:
> On 5/22/25 16:28, Rorie Reyes wrote:
>>
>> On 5/22/25 9:27 AM, Cédric Le Goater wrote:
>>> On 5/12/25 20:02, Rorie Reyes wrote:
>>>> Creates an object indicating that an AP configuration change event
>>>> has been received and stores it in a queue. These objects will later
>>>> be used to store event information for an AP configuration change
>>>> when the CHSC instruction is intercepted.
>>>>
>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>> ---
>>>>   hw/vfio/ap.c | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>> index 3d0af7a54a..5ea5dd9cca 100644
>>>> --- a/hw/vfio/ap.c
>>>> +++ b/hw/vfio/ap.c
>>>> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>>>>       EventNotifier cfg_notifier;
>>>>   };
>>>>   +typedef struct APConfigChgEvent {
>>>> +    QTAILQ_ENTRY(APConfigChgEvent) next;
>>>> +} APConfigChgEvent;
>>>> +
>>>> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>>> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>>> +
>>>
>>> Could cfg_chg_events be static ?
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>> You make a good point, Cedric. I'm only using this variable in ap.c. 
>> Having it as a static would prevent it from being modified anywhere else
>>
>
> Good. Would you have time to send a v10 ?
>
>
> Thanks,
>
> C.
>
>
I should be able to send a v10 by today. I'm currently working on the 
other two comments you left for patch 3


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FDAC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 02:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIIBU-0001Fj-Uk; Thu, 22 May 2025 22:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIIBR-0001Er-SU; Thu, 22 May 2025 22:30:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIIBQ-0002MH-2c; Thu, 22 May 2025 22:30:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNWmKG007772;
 Fri, 23 May 2025 02:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fb1IGE
 rDXfEGBCKEuEY8slHjXBquQvS6x7GgmTRwoOw=; b=hnonpUJi+KSPRoCydaCy8I
 75V8LQEONCi3/3hEhCvtLXjmJEz8mQ9ZkEXA56zuVZLlXmHvLoRAwGrW0IVReknz
 fb7/3qcIypvHXcuV7o0BWfSV3UXE9YZfAGDSZn640+JVk4mQ873EGnA98574e+xi
 CdIoOA1kz9cEkOPUQp3YDQmDlhcz8rWeNjQZkut/Sa/pXLu5zkGmHCXH1spLiaJv
 iM0eXhJtjhvMlapQ6aB2D2ovYPksswh1Btn/0JrFqTAbW3qxI1eWG726QDPJsKB3
 6rd+5mzyL6aDsC8mwFd5P356+4/sIEx0oKg8sC9rG2gc8h/T4nigHl73eKFTJP1g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9m7smvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 02:30:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1m3JE010630;
 Fri, 23 May 2025 02:30:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwnmmg5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 02:30:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N2UlEB9110180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 02:30:47 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5C4858059;
 Fri, 23 May 2025 02:30:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0233A58061;
 Fri, 23 May 2025 02:30:47 +0000 (GMT)
Received: from [9.61.243.208] (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 02:30:46 +0000 (GMT)
Message-ID: <5c9fc796-516c-4138-9852-c284446c8573@linux.ibm.com>
Date: Thu, 22 May 2025 22:30:46 -0400
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
X-Authority-Analysis: v=2.4 cv=SMZCVPvH c=1 sm=1 tr=0 ts=682fddd9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=9SWatgFAzlQhWMikDZIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AgUoX0Mry_zwRMkhH-R0uM_HpdwXON-p
X-Proofpoint-ORIG-GUID: AgUoX0Mry_zwRMkhH-R0uM_HpdwXON-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAxNyBTYWx0ZWRfX5aNdPhze7Pmp
 jJBJChzmd0twYbv0vLqjvQeeBHIbbA0UCrTmmnz3euWXQsjs6neHhW9IamYhTHNsADDesYuW85A
 BKEoPAQDYKJD/pz6c58S1pqlcVp0K1dV72sgWy7ggkN+1Z4me7BoklkTOHTV5z5KC4JJlAZW2ll
 6Ima6G9FuGURd9GBhcWGy67W74L+0VXs1BcjhvH+aucRD5l1INTA0s4f2iac6ZlLmg7PhhxBL9a
 EsFuxzpPZeFGKIDWq6McKtuiwtHCFYDJjEVPI+WVqKGYwKx9YBBzfSqiMrTDVQAOIxHokUT2YIt
 5LLinFIWV1cDK3ixg2HLqusyscDqCnuNULRUSEC0c8VDSH+u2DpwxrIbFF1IJTIqUyBWpZnLQ4t
 sJ39JDTvuE2FyRIwZOUlXcOGWCctndaJZ6rgarydPlnuO+WLa7YnIdtlVEuGzBW8FL5e0NHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_01,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230017
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Hey Cedric, I thought I'd be able to send out a v10 earlier but hit some 
bugs when working on the patch 3 comments. I'm working on it now and 
I'll try to get it out ASAP. Thanks


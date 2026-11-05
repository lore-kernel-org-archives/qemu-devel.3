Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC112606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ho5FIm5P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtXq-00056n-HP; Thu, 05 Nov 2026 04:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xOtXU-00053u-QC; Thu, 05 Nov 2026 04:13:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xOtXS-0005P3-5N; Thu, 05 Nov 2026 04:13:44 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56i5aO1177272; Thu, 5 Nov 2026 09:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+EkwXK
 oARHeRO1gVbjXvb+XiIWE6HBm7YALSFQheo9I=; b=ho5FIm5PlveMLYME3/cnk0
 vfHvs+SZHuDTVHsgB7NxdVXKNhZQslnfP/RBe5cGP0t2m04owLLdCyhuxCv0MOVJ
 wYoqXiFGXBw1Q/fFPJ3OzWvD/UdJYCNdNN4ZxIBYsSLCuOXp0WrfSMtjhGK2hLkj
 i9EYhjl+I+CM+TIyC/dbMF9ogHb6CH7/fTMLedeXDTuxGc3jzkb/M/QTnJUZJu1y
 Clzu1G/+2yKG0X/nDWEkKDhF+b7GLQYEjhz3y424gx3fH8Wbs4Dzusnsbu9s6Eb/
 L9N2mhMjlmknExSKpzsNA0QkLIaBeG0wj8uSLWDyVKSt+J4rl6xlZqSRvI1eDaRQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80t18ep-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 09:13:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56f0oW1128544; Thu, 5 Nov 2026 09:13:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmregk58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 09:13:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A59DWWn46793214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2026 09:13:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82DAF2004E;
 Thu,  5 Nov 2026 09:13:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41CD12004B;
 Thu,  5 Nov 2026 09:13:32 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2026 09:13:32 +0000 (GMT)
Message-ID: <5a1f3e91-6cd7-4d11-b03f-3329873d6cae@linux.ibm.com>
Date: Thu, 5 Nov 2026 10:13:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.2] event_notifier: Remove assertions
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Farman <farman@linux.ibm.com>, "'Michael S . Tsirkin'"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261104030034.3577845-1-farman@linux.ibm.com>
 <978f83f5-9aff-4e82-81ab-633a99b03d49@yandex-team.ru>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <978f83f5-9aff-4e82-81ab-633a99b03d49@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fi25l6T5lGet0U3t3XO_Ktps63-jq5D6
X-Proofpoint-ORIG-GUID: Fi25l6T5lGet0U3t3XO_Ktps63-jq5D6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX0veDG/l0Ab3/
 AqLAZWEC2rNo/vHJRSiRT3XF166MfjS3/Od96KrJfsPWY/O6tN9g54hoaegpM8MfaL/DRBn0so3
 K4GLgzDbnL3kWzVjIyKSwVji6pyjIrfNMV94McHpeWSGCBVDq26kNts23avwB6qN2WeuLzmWCb0
 vjoqh6xWKjtsE9NGPV+AVIgU7kTj+7aSsPbU3L8GLSI2DcCkorEAs1SnGROR4vCTqECUauNXkPg
 a+RQAXSat3xs/Ji9XokCT1jawuQpBfMOhf+WCtBUMMiTdbD/9sDoX8EeX/1ojUKhFP7932/aKvn
 0T62MouB7eDve+OLA0lpRpZpo/Lxp7qkcKRX4bF16Xc96DY4WYYW5XSNOvqKZH/+9t+sMoJ8xnx
 bqstSizKeCCtFx4wkH1Nk1R/ZBqvG06jfOk2HPcRo46WJZM5Czfz6GLgK+1qpHh4P3HOgtGb9ln
 TT67ZfUQxyVhc5CgMwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNCBTYWx0ZWRfX83m5zbFMHV3u
 Rl1dCrWT1ddwtNMtDPlnilWv7epTihkRCPhDDlYjH/jDfZTCaJ9jZXqsveMv1MCiLLLbWGeqh9K
 bQeE0Lf5ZDf3yDVXILMNqhNsR2hNC/Q=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aec48c1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=HYem5acS_q2KeS-RIY4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050034
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 04.11.26 um 11:29 schrieb Vladimir Sementsov-Ogievskiy:
> On 04.11.26 06:00, Eric Farman wrote:
>> Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added asserts
>> for uninitialized file descriptors in the various helper routines, because
>> it presumes that such a thing is always in place once a couple of
>> problematic paths were corrected in that commit.
>>
>> Not all paths appear to adhere to this, however. s390x breaks because there
>> is no config notifier so things that rely on vhost (virtio-net-ccw,
>> vhost-vsock-ccw, etc.) fail on this assertion when called from
>> vhost_start_config_intr().
>>
>> Remove these new assertions from the API; can try again another day.
>>
>> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6fb8orB2Coucn-fAYtTA@mail.gmail.com/
>> Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   util/event_notifier-posix.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
>> index f595945af74..db53e0cee02 100644
>> --- a/util/event_notifier-posix.c
>> +++ b/util/event_notifier-posix.c
>> @@ -27,7 +27,6 @@
>>    */
>>   void event_notifier_init_fd(EventNotifier *e, int fd)
>>   {
>> -    assert(fd >= 0);
>>       e->rfd = fd;
>>       e->wfd = fd;
>>       e->initialized = true;
>> @@ -97,15 +96,11 @@ void event_notifier_cleanup(EventNotifier *e)
>>   int event_notifier_get_fd(const EventNotifier *e)
>>   {
>> -    assert(e->initialized);
>> -    assert(e->rfd >= 0);
>>       return e->rfd;
>>   }
>>   int event_notifier_get_wfd(const EventNotifier *e)
>>   {
>> -    assert(e->initialized);
>> -    assert(e->wfd >= 0);
>>       return e->wfd;
>>   }
> 
> 
> In my opinion "[PATCH for 11.2 v2] vhost: only use config notifier when exists/initialized"[1]
> is better.
> 
> Removing assertions hides problems (like sending uninitialized fd to ioctl, fixed by [1])
> 
In any case e3b12d0c55e4 introduced a regression so can we get the revert or the fix
accepted asap please?



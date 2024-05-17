Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2F3C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 17:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s81h7-0006Rw-VK; Fri, 17 May 2024 13:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s81h6-0006RM-HE
 for qemu-devel@nongnu.org; Fri, 17 May 2024 13:48:36 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s81h4-0002T7-Gb
 for qemu-devel@nongnu.org; Fri, 17 May 2024 13:48:36 -0400
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 44HHR9i5024629; Fri, 17 May 2024 18:48:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=9ihnITGdnryzGqKaKLXjEtlkMoZ7ciatlf4rt0eVals=; b=
 FlOGlYGOXwQp22taSzT3cpQvWR44tRNVm18Z1+WLZvpbGfaIdYfHV+a16lLko7Iq
 woUA7cifSEQHzAGAx1UwQt37/rh16BAmMuJokyMdXYyrHhwEtW1zidLy/o/+hmPU
 6mRfRy7lDFplvYd1mj+EOMPBk9a7OBugNNHKSTb5vxb7nLF6yEnN/sC/PdEsTs/9
 UmtjhRuJT83cCb0Yuk0V3i7vCQaWMA5gK3jzaw6ikYTZa76Bt4DyYhlKTiaVGjNg
 QqaZ9lEmO3Wopy2ZjZH99A/PiAcD6lChv22EyBqAsZw8i8Zr/YdyjY/tNqN/yS94
 l0lwBe9G6rk0Ky0tugqX0Q==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 3y6bbkgptg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 18:48:30 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HC63eA004730; Fri, 17 May 2024 13:48:28 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3y240ybcyd-1;
 Fri, 17 May 2024 13:48:28 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 1272C333B9;
 Fri, 17 May 2024 17:48:25 +0000 (GMT)
Message-ID: <ab1c6134-58d0-4a3f-8853-90a5cae173d7@akamai.com>
Date: Fri, 17 May 2024 12:48:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Steven Sistare <steven.sistare@oracle.com>,
 Michael Tokarev <mjt@tls.msk.ru>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
 <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
 <d6176480-d87c-492b-8a0c-04bf81a4f59a@akamai.com>
 <59ad1f18-682b-46fc-a902-884ca6150c7d@akamai.com>
 <fadc022e-7cfd-4201-90e5-0193ce6220bc@tls.msk.ru>
 <916bca57-6bf9-48ea-82b7-c528660c6c4c@akamai.com>
 <f6e52844-d886-437c-94b4-22ad6c290532@oracle.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <f6e52844-d886-437c-94b4-22ad6c290532@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_07,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170137
X-Proofpoint-GUID: CnZfy9z1TpRH2ZJa6v5VWo2bHg4ptDNI
X-Proofpoint-ORIG-GUID: CnZfy9z1TpRH2ZJa6v5VWo2bHg4ptDNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_07,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405170137
Received-SPF: pass client-ip=67.231.149.131; envelope-from=mgalaxy@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

OK, acknowledged. Thanks, All.

- Michael

On 5/16/24 13:07, Steven Sistare wrote:
> On 5/16/2024 1:24 PM, Michael Galaxy wrote:
>> On 5/14/24 08:54, Michael Tokarev wrote:
>>> On 5/14/24 16:39, Michael Galaxy wrote:
>>>> Steve,
>>>>
>>>> OK, so it does not look like this bugfix you wrote was included in 
>>>> 8.2.4 (which was released yesterday). Unfortunately, that means 
>>>> that anyone using CPR in that release will still (eventually) 
>>>> encounter the bug like I did.
>>>
>>> 8.2.4 is basically a "bugfix" release for 8.2.3 which I somewhat
>>> screwed up (in a minor way), plus a few currently (at the time)
>>> queued up changes.   8.2.3 was a big release though.
>>>
>>>> I would recommend that y'all consider cherry-picking, perhaps, the 
>>>> relevant commits for a possible 8.2.5 ?
>>>
>>> Please Cc changes which are relevant for -stable to, well,
>>> qemu-stable@nongnu.org :)
>>>
>>> Which changes needs to be picked up?
>>>
>> Steve, can you comment here, please? At a minimum, we have this one: 
>> [PULL 20/25] migration: stop vm for cpr
>>
>> But that pull came with a handful of other changes that are also not 
>> in QEMU v8, so I suspect I'm missing some other important changes 
>> that might be important for a stable release?
>>
>> - Michael
>
> Hi Michael, I sent the full list of commits to this distribution 
> yesterday, and
> I see it in my Sent email folder.  Copying verbatim:
>
> ----
> Michael Galaxy, I'm afraid you are out of luck with respect to qemu 8.2.
> It has some of the cpr reboot commits, but is missing the following:
>
> 87a2848 migration: massage cpr-reboot documentation
> cbdafc1 migration: options incompatible with cpr
> ce5db1c migration: update cpr-reboot description
> 9867d4d migration: stop vm for cpr
> 4af667f migration: notifier error checking
> bf78a04 migration: refactor migrate_fd_connect failures
> 6835f5a migration: per-mode notifiers
> 5663dd3 migration: MigrationNotifyFunc
> c763a23e migration: remove postcopy_after_devices
> 9d9babf migration: MigrationEvent for notifiers
> 3e77573 migration: convert to NotifierWithReturn
> d91f33c migration: remove error from notifier data
> be19d83 notify: pass error to notifier with return
> b12635f migration: fix coverity migrate_mode finding
> 2b58a8b tests/qtest: postcopy migration with suspend
> b1fdd21 tests/qtest: precopy migration with suspend
> 5014478 tests/qtest: option to suspend during migration
> f064975 tests/qtest: migration events
> 49a5020 migration: preserve suspended for bg_migration
> 58b1057 migration: preserve suspended for snapshot
> b4e9ddc migration: preserve suspended runstate
> d3c86c99 migration: propagate suspended runstate
> 9ff5e79 cpus: vm_resume
> 0f1db06 cpus: check running not RUN_STATE_RUNNING
> b9ae473 cpus: stop vm in suspended runstate
> f06f316 cpus: vm_was_suspended
>
> All of those landed in qemu 9.0.
> ---
>
> - Steve


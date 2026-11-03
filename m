Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B82606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d+u+KmHp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOLEs-00030L-9p; Tue, 03 Nov 2026 15:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xOLEq-000307-DS; Tue, 03 Nov 2026 15:36:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xOLEo-0007hp-B1; Tue, 03 Nov 2026 15:36:12 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IiAV6991411; Tue, 3 Nov 2026 20:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rYunRO
 HgHF5BibfyZa1v7Msy0UlEA107zxkE3MaaUG8=; b=d+u+KmHpuWhphphuVzr0u3
 9phNFRufGFqgIK+ueg43rPuWIkcjQOo/SQ4Dk0T6p19/1+czD0yI9sUYFc4ROiLI
 OAnnTXFyVwkVo9Vu6nlrlJtID1bQkWyL23n2BhKXzRSmI/Fi6bsP5EFAlkE9LpcV
 mfCYJwkS9wQg0IqzLhwH7uXAIE2t59gVWj1QAhZtYyJkbIo5qFUvpaNlzKYgE8gw
 dwO4+8JSNYEMw9Gi4UJ8cFZqMvZlt0REfORQFGgc6s7/FjUp5p4/2qWgse2UFONH
 ka7/Xu9ycPdF+ut2kg0HdKIK1J6MXyzdbOcIRynLgOZaFLXOYwlrRlalpOVVhGAg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sr9kf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 20:36:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IaSD42980311; Tue, 3 Nov 2026 20:36:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gacxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 20:36:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A3Ka4Bx19727054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Nov 2026 20:36:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554D658059;
 Tue,  3 Nov 2026 20:36:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FF8658043;
 Tue,  3 Nov 2026 20:36:03 +0000 (GMT)
Received: from [9.61.98.239] (unknown [9.61.98.239])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Nov 2026 20:36:02 +0000 (GMT)
Message-ID: <207512f2-6cf8-4ad0-b3f7-a4cdc37a2be9@linux.ibm.com>
Date: Tue, 3 Nov 2026 15:36:02 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 49/78] util/event_notifier: more strict API
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <cover.1793207602.git.mst@redhat.com>
 <05f5ab90ea52b0151958fd2506c15858e3e80442.1793207602.git.mst@redhat.com>
 <92a5bdce-af21-4e8a-b869-57e903531a77@linux.ibm.com>
 <0af8c97e-55bf-421c-8b38-de1f88f44547@linux.ibm.com>
 <CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6fb8orB2Coucn-fAYtTA@mail.gmail.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6fb8orB2Coucn-fAYtTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMjEhBbqLjcRc-GUUphYOOa56F3zQv6V
X-Proofpoint-ORIG-GUID: RMjEhBbqLjcRc-GUUphYOOa56F3zQv6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX7IVK0y6lrfhT
 ynqP0gZ+RXBYKpr0CjGqQVdsmBfmE3Swb8yn+QLvHCYzks1zD4g91ADUzIOTCSYVgoSIDi/qpb6
 MZ+kSIlxJJBkHi++7ZzvAMAmVi3wH3abNbUsy/JR2cNeWDpudWhAZd0hwgsreR7XEfZf9qAmRb8
 GgKIxrE/6jFxo5QWjcdno+OyN3V6ERkCf2mAYUIIEo+f0MLCVEeeV/5IbjJJXCrWzJQlrsJkuJz
 V7/Qf1LGzEJZSeGXGAAihg4KJ2UvrzXBCvrAUyYEZlTDydzJHV3AKZzfWtp0C768pMcaZD23nb+
 hFeQG/66vDOnaI8SafKLX157CV46SULCCxUhSNQMVjHhWLy43i0rohch4O0HMbLQapkTY4h6h6R
 ckyS0+dlP1jeqZVEqSpthRGmtyNuQe+gqxMWMIIBu7bUKe/t9daon1oMwrwjKoB0DTaT95HkWZr
 bV/vgFI+BuNgGJoncwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX4T4YlD7s7Z87
 8TC0+BZng1Rj4SyCsSj9Sw4BzKd3MJ851EQym/yzUxw7hONA86Hck9Q+yIa6jA31EIZVijvVRbI
 DRn8jJ9tZyRUwzRnQxKB/2I8aWA+kAE=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea45b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6R7veym_AAAA:8 a=b1yj903lyAA_K7TMDcwA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/26 12:38 PM, Peter Maydell wrote:
> On Tue, 3 Nov 2026 at 17:32, Eric Farman <farman@linux.ibm.com> wrote:
>>
>>
>>
>> On 11/2/26 10:48 AM, Eric Farman wrote:
>>>
>>>
>>> On 10/28/26 1:16 PM, Michael S. Tsirkin wrote:
>>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>
>>>> We have .initialized in EventNotifier to track was it actually
>>>> initialized, and we have a comment that @fd passed to
>>>> event_notifier_init_fd() must be an eventfd object.
>>>>
>>>> Still, there are two specific users, which ignore these things,
>>>> and use -1 as specific value storing in notifier, to mark it
>>>> "uninitialized".
>>>>
>>>> Let's make strict API:
>>>>
>>>> - store only valid FDs in initialized notifier
>>>> - _set() asserts that passed fd is valid
>>>> - _get() asserts that notifier is initialized (actually, except
>>>>     the two specific cases we rework, all other callers are not
>>>>     prepared to notifier being uninitialized when _get() is called.
>>>>     In this case _get() returns 0 (which is a valid fd), and caller
>>>>     will mistakenly use it, which is worse than abort())
>>>
>>> Well, there are other cases that would require rework not addressed
>>> here, as this commit breaks (at least) vhost-vsock-ccw and virtio-net-
>>> ccw (for vhost=on) on an s390x host. I'll look into that, but was not
>>> prepared for such a late surprise.
>>
>> I sent a fix [0] for the assertion that shows up with this particular
>> patch in some of the common configurations, but it still leaves VDPA
>> broken on s390x (which was also working before this commit). So, not a
>> good idea.
>>
>> I just posted a variation [1] of that which restores VDPA functionality.
>> Would that be doable? Or can we get the assertions here removed until we
>> can adhere to the API restriction?
> 
> If this change regressed something, and we don't have an immediately
> obvious fix for that, we should probably revert this change.
> Can we do that without too much trouble?

I don't know about the other parts of this commit that were changed in 
advance of the API change performed here, but from my chair it's fine to 
either revert this commit or remove the assertions that it added. I'll 
send a patch for the latter, in case that's preferred.

Thanks,
Eric


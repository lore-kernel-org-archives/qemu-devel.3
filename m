Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6AAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eqs-0003ju-8h; Thu, 16 May 2024 13:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s7eqo-0003hb-1g
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:25:07 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s7eqj-0000zZ-Vc
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:25:03 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 44GEwkm7022542; Thu, 16 May 2024 18:24:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=/ed58JGR9Tf8NVh/Y6fHeeAdLphSJ/BqQAtd2ytUsuM=; b=
 YArams4AWh7UxXz2qY0/OWPZxJWkM5VeLCXomCE4rSK+gvh5cgAAtvXkQm2yR5Wt
 Al/A+MIpUd1zWt/4drBhSZIiw4jtglYuMl1mDj0zWcxUFh6CgU0rot86Nyq6nzsH
 Ba3GXDmdg2k4Mg5PAtp6exQp5FtWoSA4+8eeckBUx5WziAnWi8o3wdGS94MNaWsZ
 N8kKFoM7A6Q+N9iyFvuDRgmR8QE/R/orXStaYLO3uHqXS+Nt4fs6b6LlTUFVZocR
 8Ou3vSwoTn6+SnCUz2CQk2bBmew+Vo+5Trx0hzg3Su2y0l+gGH6x/8RtUFcHt18W
 0dS8oMwARhF3mftxYzl61w==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60]
 (may be forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3y1yxysnj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 18:24:43 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GFY5j5000906; Thu, 16 May 2024 10:24:41 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 3y26nb7x5k-1;
 Thu, 16 May 2024 10:24:41 -0700
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 49400333B5;
 Thu, 16 May 2024 17:24:39 +0000 (GMT)
Message-ID: <916bca57-6bf9-48ea-82b7-c528660c6c4c@akamai.com>
Date: Thu, 16 May 2024 12:24:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Michael Tokarev <mjt@tls.msk.ru>,
 Steven Sistare <steven.sistare@oracle.com>, peterx@redhat.com,
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
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <fadc022e-7cfd-4201-90e5-0193ce6220bc@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160124
X-Proofpoint-ORIG-GUID: Ki3Bs1D8wt8nhBQZ7gEKQvI7gXr6O8o_
X-Proofpoint-GUID: Ki3Bs1D8wt8nhBQZ7gEKQvI7gXr6O8o_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxlogscore=872
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160125
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


On 5/14/24 08:54, Michael Tokarev wrote:
> On 5/14/24 16:39, Michael Galaxy wrote:
>> Steve,
>>
>> OK, so it does not look like this bugfix you wrote was included in 
>> 8.2.4 (which was released yesterday). Unfortunately, that means that 
>> anyone using CPR in that release will still (eventually) encounter 
>> the bug like I did.
>
> 8.2.4 is basically a "bugfix" release for 8.2.3 which I somewhat
> screwed up (in a minor way), plus a few currently (at the time)
> queued up changes.   8.2.3 was a big release though.
>
>> I would recommend that y'all consider cherry-picking, perhaps, the 
>> relevant commits for a possible 8.2.5 ?
>
> Please Cc changes which are relevant for -stable to, well,
> qemu-stable@nongnu.org :)
>
> Which changes needs to be picked up?
>
Steve, can you comment here, please? At a minimum, we have this one: 
[PULL 20/25] migration: stop vm for cpr

But that pull came with a handful of other changes that are also not in 
QEMU v8, so I suspect I'm missing some other important changes that 
might be important for a stable release?

- Michael


> Thanks,
>
> /mjt


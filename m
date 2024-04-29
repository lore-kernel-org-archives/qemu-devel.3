Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A78C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QlE-0007lu-Hu; Mon, 29 Apr 2024 09:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s1Qkx-0007kx-R5; Mon, 29 Apr 2024 09:09:21 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s1Qkm-000271-0l; Mon, 29 Apr 2024 09:09:17 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TCnsGR006750;
 Mon, 29 Apr 2024 14:08:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=GV9SnNHzDXHKX5jlCImjUebP7ZEGbuMwhEHEUbz9asA=; b=
 m3H/JR1KmN1uAlqNqcfdFrJJZp1fJDKVKwrWTHtRfk8EobLWyDw6Em79+LpBufu8
 H7E6NNbLWLcpT+Ko35y0NndTMoq4aMr9Z3C3GyOmg1548T7ZVhpKWheqOQLyJ3bg
 eZFMw2wzD5PJeMpptyxYUiz3Lpg6ejjJovZgsbdX4wryuKUbPxtrgtr1wQF6yJVd
 JVIhymc36d3tyo+RGPTrSdrlAmkVKtOxC/PRGWsuSuuE6fVIhJoTKBHh08v77XcT
 lEQvjkf7o1Os9poceEggy5JiFoPx16rQgTcullQnso/iSIXR1FJhCMJNsBFI1pHO
 itFnINHKQqsNL391g5qrNw==
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3xrrmcdxrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 14:08:19 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TAV4sj012275; Mon, 29 Apr 2024 09:08:17 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 3xrvpy1n26-1;
 Mon, 29 Apr 2024 09:08:17 -0400
Received: from [100.64.0.1] (prod-aoa-dallas2clt14.dfw02.corp.akamai.com
 [172.27.166.123])
 by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 81321637FA; 
 Mon, 29 Apr 2024 13:08:13 +0000 (GMT)
Message-ID: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
Date: Mon, 29 Apr 2024 08:08:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Content-Language: en-US
To: Yu Zhang <yu.zhang@ionos.com>, Peter Xu <peterx@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
References: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n> <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_10,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290082
X-Proofpoint-GUID: 3r461xsC7RHN9oB8HYl-IGWyUgXFScXn
X-Proofpoint-ORIG-GUID: 3r461xsC7RHN9oB8HYl-IGWyUgXFScXn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_10,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290082
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.127, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi All (and Peter),

My name is Michael Galaxy (formerly Hines). Yes, I changed my last name 
(highly irregular for a male) and yes, that's my real last name: 
https://www.linkedin.com/in/mrgalaxy/)

I'm the original author of the RDMA implementation. I've been discussing 
with Yu Zhang for a little bit about potentially handing over 
maintainership of the codebase to his team.

I simply have zero access to RoCE or Infiniband hardware at all, 
unfortunately. so I've never been able to run tests or use what I wrote 
at work, and as all of you know, if you don't have a way to test 
something, then you can't maintain it.

Yu Zhang put a (very kind) proposal forward to me to ask the community 
if they feel comfortable training his team to maintain the codebase (and 
run tests) while they learn about it.

If you don't mind, I'd like to let him send over his (very detailed) 
proposal,

- Michael

On 4/11/24 11:36, Yu Zhang wrote:
>> 1) Either a CI test covering at least the major RDMA paths, or at least
>>      periodically tests for each QEMU release will be needed.
> We use a batch of regression test cases for the stack, which covers the
> test for QEMU. I did such test for most of the QEMU releases planned as
> candidates for rollout.
>
> The migration test needs a pair of (either physical or virtual) servers with
> InfiniBand network, which makes it difficult to do on a single server. The
> nested VM could be a possible approach, for which we may need virtual
> InfiniBand network. Is SoftRoCE [1] a choice? I will try it and let you know.
>
> [1]  https://urldefense.com/v3/__https://enterprise-support.nvidia.com/s/article/howto-configure-soft-roce__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDLfvUXZXPwMTaXizuIQeIgJiywPzuwbqx8wM0KUsyopw_EYQxWvGHE3ig$
>
> Thanks and best regards!
>
> On Thu, Apr 11, 2024 at 4:20 PM Peter Xu <peterx@redhat.com> wrote:
>> On Wed, Apr 10, 2024 at 09:49:15AM -0400, Peter Xu wrote:
>>> On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) via wrote:
>>>>
>>>> on 4/10/2024 3:46 AM, Peter Xu wrote:
>>>>
>>>>>> Is there document/link about the unittest/CI for migration tests, Why
>>>>>> are those tests missing?
>>>>>> Is it hard or very special to set up an environment for that? maybe we
>>>>>> can help in this regards.
>>>>> See tests/qtest/migration-test.c.  We put most of our migration tests
>>>>> there and that's covered in CI.
>>>>>
>>>>> I think one major issue is CI systems don't normally have rdma devices.
>>>>> Can rdma migration test be carried out without a real hardware?
>>>> Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for example
>>>> $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
>>>> then we can get a new RDMA interface "rxe_eth0".
>>>> This new RDMA interface is able to do the QEMU RDMA migration.
>>>>
>>>> Also, the loopback(lo) device is able to emulate the RDMA interface
>>>> "rxe_lo", however when
>>>> I tried(years ago) to do RDMA migration over this
>>>> interface(rdma:127.0.0.1:3333) , it got something wrong.
>>>> So i gave up enabling the RDMA migration qtest at that time.
>>> Thanks, Zhijian.
>>>
>>> I'm not sure adding an emu-link for rdma is doable for CI systems, though.
>>> Maybe someone more familiar with how CI works can chim in.
>> Some people got dropped on the cc list for unknown reason, I'm adding them
>> back (Fabiano, Peter Maydell, Phil).  Let's make sure nobody is dropped by
>> accident.
>>
>> I'll try to summarize what is still missing, and I think these will be
>> greatly helpful if we don't want to deprecate rdma migration:
>>
>>    1) Either a CI test covering at least the major RDMA paths, or at least
>>       periodically tests for each QEMU release will be needed.
>>
>>    2) Some performance tests between modern RDMA and NIC devices are
>>       welcomed.  The current knowledge is modern NIC can work similarly to
>>       RDMA in performance, then it's debatable why we still maintain so much
>>       rdma specific code.
>>
>>    3) No need to be soild patchsets for this one, but some plan to improve
>>       RDMA migration code so that it is not almost isolated from the rest
>>       protocols.
>>
>>    4) Someone to look after this code for real.
>>
>> For 2) and 3) more info is here:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/r/ZhWa0YeAb9ySVKD1@x1n__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDLfvUXZXPwMTaXizuIQeIgJiywPzuwbqx8wM0KUsyopw_EYQxWpIWYBhQ$
>>
>> Here 4) can be the most important as Markus pointed out.  We just didn't
>> get there yet on the discussions, but maybe Markus is right that we should
>> talk that first.
>>
>> Thanks,
>>
>> --
>> Peter Xu
>>


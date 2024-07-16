Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF11C3DA60
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 20:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToVc-0000lO-8p; Tue, 16 Jul 2024 16:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sToVZ-0000kt-8m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 16:10:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sToVU-00008E-2b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 16:10:45 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sToV7-0000tB-J4; Tue, 16 Jul 2024 22:10:17 +0200
Message-ID: <35969f33-f6f3-4c34-8b9d-8c1ebac3305e@maciej.szmigiero.name>
Date: Tue, 16 Jul 2024 22:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_00/13=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
 <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
 <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
 <Zn19kaeFiYuwwc4B@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEV4gUJDWuO
 nQAKCRCEf143kM4JdyzED/0Qwk2KVsyNwEukYK2zbJPHp7CRbXcpCApgocVwtmdabAubtHej
 7owLq89ibmkKT0gJxc6OfJJeo/PWTJ/Qo/+db48Y7y03Xl+rTbFyzsoTyZgdR21FQGdgNRG9
 3ACPDpZ0UlEwA4VdGT+HKfu0X8pVb0G0D44DjIeHC7lBRzzE5JXJUGUVUd2FiyUqMFqZ8xP3
 wp53ekB5p5OstceqyZIq+O/r1pTgGErZ1No80JrnVC/psJpmMpw1Q56t88JMaHIe+Gcnm8fB
 k3LyWNr7gUwVOus8TbkP3TOx/BdS/DqkjN3GvXauhVXfGsasmHHWEFBE0ijNZi/tD63ZILRY
 wUpRVRU2F0UqI+cJvbeG3c+RZ7jqMAAZj8NB8w6iviX1XG3amlbJgiyElxap6Za1SQ3hfTWf
 c6gYzgaNOFRh77PQbzP9BcAVDeinOqXg2IkjWQ89o0YVFKXiaDHKw7VVld3kz2FQMI8PGfyn
 zg5vyd9id1ykISCQQUQ4Nw49tqYoSomLdmIgPSfXDDMOvoDoENWDXPiMGOgDS2KbqRNYCNy5
 KGQngJZNuDicDBs4r/FGt9/xg2uf8M5lU5b8vC78075c4DWiKgdqaIhqhSC+n+qcHX0bAl1L
 me9DMNm0NtsVw+mk65d7cwxHmYXKEGgzBcbVMa5C+Yevv+0GPkkwccIvps7AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEWBwUJ
 DWuNXAAKCRCEf143kM4Jd5OdD/0UXMpMd4eDWvtBBQkoOcz2SqsWwMj+vKPJS0BZ33MV/wXT
 PaTbzAFy23/JXbyBPcb0qgILCmoimBNiXDzYBfcwIoc9ycNwCMBBN47Jxwb8ES5ukFutjS4q
 +tPcjbPYu+hc9qzodl1vjAhaWjgqY6IzDGe4BAmM+L6UUID4Vr46PPN02bpm4UsL31J6X+lA
 Vj5WbY501vKMvTAiF1dg7RkHPX7ZVa0u7BPLjBLqu6NixNkpSRts8L9G4QDpIGVO7sOC9oOU
 2h99VYY1qKml0qJ9SdTwtDj+Yxz+BqW7O4nHLsc4FEIjILjwF71ZKY/dlTWDEwDl5AJR7bhy
 HXomkWae2nBTzmWgIf9fJ2ghuCIjdKKwOFkDbFUkSs8HjrWymvMM22PHLTTGFx+0QbjOstEh
 9i56FZj3DoOEfVKvoyurU86/4sxjIbyhqL6ZiTzuZAmB0RICOIGilm5x03ESkDztiuCtQL2u
 xNT833IQSNqyuEnxG9/M82yYa+9ClBiRKM2JyvgnBEbiWA15rAQkOqZGJfFJ3bmTFePx4R/I
 ZVehUxCRY5IS1FLe16tymf9lCASrPXnkO2+hkHpBCwt75wnccS3DwtIGqwagVVmciCxAFg9E
 WZ4dI5B0IUziKtBxgwJG4xY5rp7WbzywjCeaaKubtcLQ9bSBkkK4U8Fu58g6Hg==
In-Reply-To: <Zn19kaeFiYuwwc4B@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On 27.06.2024 16:56, Peter Xu wrote:
> On Thu, Jun 27, 2024 at 11:14:28AM +0200, Maciej S. Szmigiero wrote:
>> On 26.06.2024 18:23, Peter Xu wrote:
>>> On Wed, Jun 26, 2024 at 05:47:34PM +0200, Maciej S. Szmigiero wrote:
>>>> On 26.06.2024 03:51, Peter Xu wrote:
>>>>> On Wed, Jun 26, 2024 at 12:44:29AM +0200, Maciej S. Szmigiero wrote:
>>>>>> On 25.06.2024 19:25, Peter Xu wrote:
>>>>>>> On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>> Hi Peter,
>>>>>>>
>>>>>>> Hi, Maciej,
>>>>>>>
>>>>>>>>
>>>>>>>> On 23.06.2024 22:27, Peter Xu wrote:
>>>>>>>>> On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
>>>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>>>
>>>>>>>>>> This is an updated v1 patch series of the RFC (v0) series located here:
>>>>>>>>>> https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
>>>>>>>>>
>>>>>>>>> OK I took some hours thinking about this today, and here's some high level
>>>>>>>>> comments for this series.  I'll start with which are more relevant to what
>>>>>>>>> Fabiano has already suggested in the other thread, then I'll add some more.
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
>>>>>>>>
>>>>>>>> That's a long list, thanks for these comments.
>>>>>>>>
>>>>>>>> I have responded to them inline below.
>>>>>>>>(..)
>>>>>>
>>>>>> 2) Submit this operation to the thread pool and wait for it to complete,
>>>>>
>>>>> VFIO doesn't need to have its own code waiting.  If this pool is for
>>>>> migration purpose in general, qemu migration framework will need to wait at
>>>>> some point for all jobs to finish before moving on.  Perhaps it should be
>>>>> at the end of the non-iterative session.
>>>>
>>>> So essentially, instead of calling save_live_complete_precopy_end handlers
>>>> from the migration code you would like to hard-code its current VFIO
>>>> implementation of calling vfio_save_complete_precopy_async_thread_thread_terminate().
>>>>
>>>> Only it wouldn't be then called VFIO precopy async thread terminate but some
>>>> generic device state async precopy thread terminate function.
>>>
>>> I don't understand what did you mean by "hard code".
>>
>> "Hard code" wasn't maybe the best expression here.
>>
>> I meant the move of the functionality that's provided by
>> vfio_save_complete_precopy_async_thread_thread_terminate() in this patch set
>> to the common migration code.
> 
> I see.  That function only does a thread_join() so far.
> 
> So can I understand it as below [1] should work for us, and it'll be clean
> too (with nothing to hard-code)?

It will need some signal to the worker threads pool to terminate before
waiting for them to finish (as the code in [1] just waits).

In the case of current vfio_save_complete_precopy_async_thread() implementation,
this signal isn't necessary as this thread simply terminates when it has read
all the date it needs from the device.

In a worker threads pool case there will be some threads waiting for
jobs to be queued to them and so they will need to be somehow signaled
to exit.

> The time to join() the worker threads can be even later, until
> migrate_fd_cleanup() on sender side.  You may have a better idea on when
> would be the best place to do it when start working on it.
> 
>>
>>> What I was saying is if we target the worker thread pool to be used for
>>> "concurrently dump vmstates", then it'll make sense to make sure all the
>>> jobs there were flushed after qemu dumps all non-iterables (because this
>>> should be the last step of the switchover).
>>>
>>> I expect it looks like this:
>>>
>>>     while (pool->active_threads) {
>>>         qemu_sem_wait(&pool->job_done);
>>>     }
> 
> [1]
> 
(..)
>> I think that with this thread pool introduction we'll unfortunately almost certainly
>> need to target this patch set at 9.2, since these overall changes (and Fabiano
>> patches too) will need good testing, might uncover some performance regressions
>> (for example related to the number of buffers limit or Fabiano multifd changes),
>> bring some review comments from other people, etc.
>>
>> In addition to that, we are in the middle of holiday season and a lot of people
>> aren't available - like Fabiano said he will be available only in a few weeks.
> 
> Right, that's unfortunate.  Let's see, but still I really hope we can also
> get some feedback from Fabiano before it lands, even with that we have
> chance for 9.1 but it's just challenging, it's the same condition I
> mentioned since the 1st email.  And before Fabiano's back (he's the active
> maintainer for this release), I'm personally happy if you can propose
> something that can land earlier in this release partly.  E.g., if you want
> we can at least upstream Fabiano's idea first, or some more on top.
> 
> For that, also feel to have a look at my comment today:
> 
> https://lore.kernel.org/r/Zn15y693g0AkDbYD@x1n
> 
> Feel free to comment there too.  There's a tiny uncertainty there so far on
> specifying "max size for a device state" if do what I suggested, as multifd
> setup will need to allocate an enum buffer suitable for both ram + device.
> But I think that's not an issue and you'll tackle that properly when
> working on it.  It's more about whether you agree on what I said as a
> general concept.
> 

Since it seems that the discussion on Fabiano's patch set has subsided I think
I will start by basing my updated patch set on top of his RFC and then if
Fabiano wants to submit v1/v2 of his patch set then I will rebase mine on top
of it.

Otherwise, you can wait until I have a v2 ready and then we can work with that.

Thanks,
Maciej



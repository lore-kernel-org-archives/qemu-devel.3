Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD1C04FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOPh-0002L9-7D; Thu, 18 Apr 2024 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rxOPe-0002K6-1b
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:38 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rxOPb-0000Vs-Lh
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:50:37 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rxOPK-0002UX-6g; Thu, 18 Apr 2024 11:50:18 +0200
Message-ID: <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
Date: Thu, 18 Apr 2024 11:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_RFC_00/26=5D_Multifd_=F0=9F=94=80_device_s?=
 =?UTF-8?Q?tate_transfer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
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
In-Reply-To: <Zh_6W8u3H4FmGS49@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.04.2024 18:35, Daniel P. Berrangé wrote:
> On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
>> On 17.04.2024 10:36, Daniel P. Berrangé wrote:
>>> On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> VFIO device state transfer is currently done via the main migration channel.
>>>> This means that transfers from multiple VFIO devices are done sequentially
>>>> and via just a single common migration channel.
>>>>
>>>> Such way of transferring VFIO device state migration data reduces
>>>> performance and severally impacts the migration downtime (~50%) for VMs
>>>> that have multiple such devices with large state size - see the test
>>>> results below.
>>>>
>>>> However, we already have a way to transfer migration data using multiple
>>>> connections - that's what multifd channels are.
>>>>
>>>> Unfortunately, multifd channels are currently utilized for RAM transfer
>>>> only.
>>>> This patch set adds a new framework allowing their use for device state
>>>> transfer too.
>>>>
>>>> The wire protocol is based on Avihai's x-channel-header patches, which
>>>> introduce a header for migration channels that allow the migration source
>>>> to explicitly indicate the migration channel type without having the
>>>> target deduce the channel type by peeking in the channel's content.
>>>>
>>>> The new wire protocol can be switch on and off via migration.x-channel-header
>>>> option for compatibility with older QEMU versions and testing.
>>>> Switching the new wire protocol off also disables device state transfer via
>>>> multifd channels.
>>>>
>>>> The device state transfer can happen either via the same multifd channels
>>>> as RAM data is transferred, mixed with RAM data (when
>>>> migration.x-multifd-channels-device-state is 0) or exclusively via
>>>> dedicated device state transfer channels (when
>>>> migration.x-multifd-channels-device-state > 0).
>>>>
>>>> Using dedicated device state transfer multifd channels brings further
>>>> performance benefits since these channels don't need to participate in
>>>> the RAM sync process.
>>>
>>> I'm not convinced there's any need to introduce the new "channel header"
>>> protocol messages. The multifd channels already have an initialization
>>> message that is extensible to allow extra semantics to be indicated.
>>> So if we want some of the multifd channels to be reserved for device
>>> state, we could indicate that via some data in the MultiFDInit_t
>>> message struct.
>>
>> The reason for introducing x-channel-header was to avoid having to deduce
>> the channel type by peeking in the channel's content - where any channel
>> that does not start with QEMU_VM_FILE_MAGIC is currently treated as a
>> multifd one.
>>
>> But if this isn't desired then, as you say, the multifd channel type can
>> be indicated by using some unused field of the MultiFDInit_t message.
>>
>> Of course, this would still keep the QEMU_VM_FILE_MAGIC heuristic then.
> 
> I don't like the heuristics we currently have, and would to have
> a better solution. What makes me cautious is that this proposal
> is a protocol change, but only addressing one very narrow problem
> with the migration protocol.
> 
> I'd like migration to see a more explicit bi-directional protocol
> negotiation message set, where both QEMU can auto-negotiate amongst
> themselves many of the features that currently require tedious
> manual configuration by mgmt apps via migrate parameters/capabilities.
> That would address the problem you describe here, and so much more.

Isn't the capability negotiation handled automatically by libvirt
today?
I guess you'd prefer for QEMU to internally handle it instead?

> If we add this channel header feature now, it creates yet another
> thing to keep around for back compatibility. So if this is not
> strictly required, in order to solve the VFIO VMstate problem, I'd
> prefer to just solve the VMstate stuff on its own.

Okay, got it.

>>> That said, the idea of reserving channels specifically for VFIO doesn't
>>> make a whole lot of sense to me either.
>>>
>>> Once we've done the RAM transfer, and are in the switchover phase
>>> doing device state transfer, all the multifd channels are idle.
>>> We should just use all those channels to transfer the device state,
>>> in parallel.  Reserving channels just guarantees many idle channels
>>> during RAM transfer, and further idle channels during vmstate
>>> transfer.
>>>
>>> IMHO it is more flexible to just use all available multifd channel
>>> resources all the time.
>>
>> The reason for having dedicated device state channels is that they
>> provide lower downtime in my tests.
>>
>> With either 15 or 11 mixed multifd channels (no dedicated device state
>> channels) I get a downtime of about 1250 msec.
>>
>> Comparing that with 15 total multifd channels / 4 dedicated device
>> state channels that give downtime of about 1100 ms it means that using
>> dedicated channels gets about 14% downtime improvement.
> 
> Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
> place ? Is is transferred concurrently with the RAM ? I had thought
> this series still has the RAM transfer iterations running first,
> and then the VFIO VMstate at the end, simply making use of multifd
> channels for parallelism of the end phase. your reply though makes
> me question my interpretation though.
> 
> Let me try to illustrate channel flow in various scenarios, time
> flowing left to right:
> 
> 1. serialized RAM, then serialized VM state  (ie historical migration)
> 
>        main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |
> 
> 
> 2. parallel RAM, then serialized VM state (ie today's multifd)
> 
>        main: | Init |                                            | VM state |
>    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> 
> 
> 3. parallel RAM, then parallel VM state
> 
>        main: | Init |                                            | VM state |
>    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd4:                                                     | VFIO VM state |
>    multifd5:                                                     | VFIO VM state |
> 
> 
> 4. parallel RAM and VFIO VM state, then remaining VM state
> 
>        main: | Init |                                            | VM state |
>    multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
>    multifd4:        | VFIO VM state                                         |
>    multifd5:        | VFIO VM state                                         |
> 
> 
> I thought this series was implementing approx (3), but are you actually
> implementing (4), or something else entirely ?

You are right that this series operation is approximately implementing
the schema described as numer 3 in your diagrams.

However, there are some additional details worth mentioning:
* There's some but relatively small amount of VFIO data being
transferred from the "save_live_iterate" SaveVMHandler while the VM is
still running.

This is still happening via the main migration channel.
Parallelizing this transfer in the future might make sense too,
although obviously this doesn't impact the downtime.

* After the VM is stopped and downtime starts the main (~ 400 MiB)
VFIO device state gets transferred via multifd channels.

However, these multifd channels (if they are not dedicated to device
state transfer) aren't idle during that time.
Rather they seem to be transferring the residual RAM data.

That's most likely what causes the additional observed downtime
when dedicated device state transfer multifd channels aren't used.

> 
> With regards,
> Daniel

Best regards,
Maciej



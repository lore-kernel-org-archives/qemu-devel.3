Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7462CC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 08:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWxm-0002Db-HD; Fri, 20 Jun 2025 04:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uSWxk-0002DM-GB; Fri, 20 Jun 2025 04:19:04 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uSWxh-0007Hp-W7; Fri, 20 Jun 2025 04:19:04 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5E02A41E5A;
 Fri, 20 Jun 2025 10:18:51 +0200 (CEST)
Message-ID: <e6300c11-fa25-4d24-941b-1784703fd1da@proxmox.com>
Date: Fri, 20 Jun 2025 10:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: Ilya Dryomov <idryomov@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
 <aE_pbAS_gS12Fp8f@redhat.com>
 <CAOi1vP-oc0XHR28E7JrvZOohL7KZEq7LunYKHfb540W=a8t=wQ@mail.gmail.com>
 <4a7ca415-0d16-4b21-ad93-31c35f1a4511@proxmox.com>
 <CAOi1vP8sazy4h=HcZyxE+EaC_C-5QnYezvwnJLzTCnz+=HM4hQ@mail.gmail.com>
 <CAOi1vP81g40nOnskY8fR8Eh7j9JMJdfD=P0+HBVUp80suNQWJQ@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAOi1vP81g40nOnskY8fR8Eh7j9JMJdfD=P0+HBVUp80suNQWJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 19.06.25 um 23:20 schrieb Ilya Dryomov:
> On Thu, Jun 19, 2025 at 8:38 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Mon, Jun 16, 2025 at 2:38 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>>
>>> Am 16.06.25 um 12:28 schrieb Ilya Dryomov:
>>>> On Mon, Jun 16, 2025 at 11:52 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>> On Mon, Jun 16, 2025 at 11:25:54AM +0200, Ilya Dryomov wrote:
>>>>>> On Thu, May 15, 2025 at 1:29 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>>>>>>  ##
>>>>>>>  # @BlockdevOptionsRbd:
>>>>>>>  #
>>>>>>> @@ -4327,6 +4360,9 @@
>>>>>>>  #     authentication.  This maps to Ceph configuration option "key".
>>>>>>>  #     (Since 3.0)
>>>>>>>  #
>>>>>>> +# @key-value-pairs: Key-value pairs for additional Ceph configuraton.
>>>>>>> +#     (Since 10.1)
>>>>>>> +#
>>>>>>>  # @server: Monitor host address and port.  This maps to the "mon_host"
>>>>>>>  #     Ceph option.
>>>>>>>  #
>>>>>>> @@ -4342,6 +4378,7 @@
>>>>>>>              '*user': 'str',
>>>>>>>              '*auth-client-required': ['RbdAuthMode'],
>>>>>>>              '*key-secret': 'str',
>>>>>>> +            '*key-value-pairs' : 'RbdKeyValuePairs',
>>>>>>
>>>>>> To side-step all of the above, have you considered implementing
>>>>>> a straightforward passthrough to Ceph instead?  Something like
>>>>>>
>>>>>>   '*key-value-pairs': ['RbdKeyValuePair']
>>>>>>
>>>>>> where RbdKeyValuePair is just a pair arbitrary strings (and
>>>>>> key-value-pairs is thus an optional list of those).  rados_conf_set()
>>>>>> would be called just the same but the user would be able to override
>>>>>> any Ceph option they wish, not just a few that we thought of here.
>>>>>
>>>>> Passing through arbitrary key/value pairs as strings is essentially
>>>>> abdicating our design responsibility in QAPI. enums would no longer
>>>>> be introspectable. Integers / booleans would require abnormal formatting
>>>>> by clients. API stability / deprecation promises can no longer be made.
>>>>> and more besides.
>>>
>>> Yes, and I also was under the impression that there is no desire to
>>> re-introduce arbitrary key-value pairs with QMP/blockdev options.
>>
>> Hi Fiona,
>>
>> What do you mean by re-introduce?

Sorry, should've stated this better. It is possible to specify arbitrary
key-value pairs with '-drive', and by "re-introduce" I mean allowing the
same for '-blockdev'.

>>>>> Given that limitation, if we did go the string pairs route, I would
>>>>> expect it to be marked as "unstable" in the QAPI schema, so apps have
>>>>> a suitable warning NOT to rely on this.
>>>>
>>>> This sounds sensible to me.  We can continue exposing the most common
>>>> Ceph options through a proper QAPI schema but add key-value-pairs as an
>>>> alternative low-level route for those who want to avoid dealing with
>>>> physical configuration files.
>>>
>>> As written in the commit message, the cache option should not apply to
>>> all volumes, so using configuration files is rather impractical there.
>>>
>>> I'd prefer defining the cache option(s) explicitly, and have people add
>>> additional key-value pairs they require explicitly going forward. But if
>>> you really don't want me to, I can still go with the unstable, arbitrary
>>> strings approach instead.
>>
>> The RBD cache policy option would definitely count as one of the most
>> common, so I don't have an objection to it being added in an explicit
>> form.  I'm also fine with the "disabled" enum value that you expressed
>> a preference for in another email.
> 
> The QEMU block layer-wide "cache" option is kind of in the way though:
> if it's set to "off"/"none" or the more specific "cache.direct" option
> is set to "on", we disable the RBD cache.  So there is an existing way
> to control that, but it's at another level and QEMU cache modes aren't
> distinguished (i.e. there is no mapping to RBD which means that one can
> have "cache=writeback" set in QEMU but still get e.g. "writethrough"
> RBD cache policy come from the ceph.conf file).  An extra enum value
> for disabling the RBD cache might muddy the waters further.

Even with "cache=writeback" in QEMU, the RBD cache policy will default
to "writearound". And we do need "writeback" on the RBD side too:
https://git.proxmox.com/?p=qemu-server.git;a=commitdiff;h=738dc81cbae03ff03592c30a82c7e4d0d39a54ba;hp=e43b19109e57e6e7654c4fa6e2ed14a39b4a6fe2

> Another thing that comes to mind is that if you need to control the
> cache policy (or any other RBD option) on a per-image basis as opposed
> to per-user basis, you can employ image-level configuration overrides
> on the RBD side -- see "rbd config image get/set/ls/rm" commands.

Oh, that sounds like a good alternative :)

Best Regards,
Fiona



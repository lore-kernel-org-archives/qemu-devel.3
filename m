Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B50E63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 07:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrszs-0008P5-WE; Mon, 16 Feb 2026 02:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vrszR-0008G2-3j; Mon, 16 Feb 2026 02:25:53 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vrszN-0007i6-0Y; Mon, 16 Feb 2026 02:25:52 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8E28780854;
 Mon, 16 Feb 2026 10:25:44 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:450::1:4] (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hPSvxY2ACW20-eEY3tCbL; Mon, 16 Feb 2026 10:25:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771226744;
 bh=i7DWY4R7GuyFc3Phdu768OUee0a9nkUQdh3YWwFQPBA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gX/fWfzp831yfUEa3ue0ZPUHHvKK4AGbFdiC6RElK4nefyGIj4qM+KJvoGOOHnPcL
 N1kzGDuejoaUo37lBaazIa8ejgfKLZdlhF7iUbfZxeOVMGOkAYDHQIz/QbQwQkaiPw
 m4FDhSUgnT/tV7h5mDkVVpNLRPs6WdNO/Mqmk0q0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <94f379d8-4e9d-48fb-9529-c05251fdebab@yandex-team.ru>
Date: Mon, 16 Feb 2026 10:25:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260122160113.1147745-1-vsementsov@yandex-team.ru>
 <87qzr0y990.fsf@pond.sub.org>
 <74b1555d-1e4f-4be2-85e4-902f9670e435@yandex-team.ru>
 <877bsf23y4.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <877bsf23y4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14.02.26 10:13, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 04.02.26 15:38, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Now we have blockdev-replace QMP command, which depend on a possibility
>>>> to select any block parent (block node, block export, or qdev) by one
>>>> unique name. The command fails, if name is ambiguous (i.e., match
>>>> several parents of different types). In future we want to rid of this
>>>> ambiguity.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>
>>> We have numerous kinds of IDs, i.e. names chosen by the user than need
>>> to be unique, but only among the same kind.  For instance, you can't
>>> name two block nodes "foo", but you can name a block node, a block
>>> export, a qdev, and a network backend "foo".  Using the same ID for
>>> multiple things is of course a bad idea.  Permitting it was also a bad
>>> idea.
>>>
>>> Your patch rectifies this design mistake, but only partially.  Consider:
>>>
>>> * IDs need to be unique with their kind.  This is what we have now.  I
>>>    don't like it.
>>>
>>> * IDs need to be unique among their kind and possibly some set of
>>>     additional kinds.  This is where your patch takes us.  I like it even
>>>    less, to be honest.
>>>
>>> * IDs need to be unique, period.  This is what I'd like to have.
>>
>> I like it. Is it enough to write it so simple in deprecation doc? Or should
>> we still list all such ids we have in QEMU?
>>
>> It may be something like:
>>
>> Any kind of IDs you use to reference objects in QEMU must be unique, any
>> used ID must reference exactly one object. This includes, but is not limited
>> to qdev full and relative to "/peripheral/" paths, block-node and block-export
>> names.
> 
> This would serve as a declaration of intent.  Better than nothing, I
> guess.
> 
> To enforce uniqueness, we'll have to create a single table of IDs.
> 
> If we make it a set, we can reject duplicate IDs, but can't point to the
> other ID.  Meh.
> 
> If we make it map to the kind of ID, we can report the kind.  Something
> like "block node name 'foo' clashes with block export ID 'foo'".  Feels
> adequate.
> 
> If we make it map the the object the ID identifies, we can get rid of
> existing means to map from ID to object.  May or may not be worthwhile.
> 
> If we create the single table of IDs now rather than later, we can warn.
> Something like "duplicate IDs are deprecated: block node name 'foo'
> clashes with block export ID 'foo'".  Much more likely to get users'
> attention than a note in docs/about/deprecated.rst.
> 
> We could even wire it to the "-compat deprecated-input=..." machinery
> (I'd assist with that).  This would let people test their software is
> ready for enforced unique IDs.
> 
> Thoughts?
> 


Sounds good. At least, I may try to make a common function, to be used both
on object creation and from blockdev-replace to check for ambiguity.


Now, another thought come in my mind:

Shouldn't we instead of uniting different name-spaces, select qom-path as a
primary source of object referencing?
So, simple reserve "block/export/EXPORT_NAME" for exports and
"block/node/NODE_NAME" for nodes?

I imaging, if we simply "deprecate duplicating IDs", this will force libvirt
and others to include object type into the id, so they may start use block
node names like "block-node-disk1", and block export names like "block-export-disk1".
We can be proactive, providing a common path for "foldering" IDs.

This way, node-name becomes "relative" QOM path, and may be used in context where
only node-name could be used (all existing use cases in the API now), but in interfaces,
where may be used objects of different kinds (like new blockdev-replace) the full
path is preferred (or even required).


-- 
Best regards,
Vladimir


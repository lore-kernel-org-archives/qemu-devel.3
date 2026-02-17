Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B6E9A029
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 17:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsPIz-0000Wx-Qi; Tue, 17 Feb 2026 12:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsPIu-0000QL-Dh; Tue, 17 Feb 2026 12:56:08 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsPIo-0003CL-HG; Tue, 17 Feb 2026 12:56:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 61C6E807CC;
 Tue, 17 Feb 2026 20:55:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3b::1:9] (unknown [2a02:6bf:8080:b3b::1:9])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntdlr33AhKo0-hN5uptP3; Tue, 17 Feb 2026 20:55:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771350949;
 bh=Tv68b5iLW1ED7FVww5PjYMG21KQ2786yuOcSvJ3nY0w=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gJ+W5PqtuXlkuaa92a/11vxGzUQagcuKVIexfg2LgdGWS5ztH0icRayd+Jc9iJRFW
 68mAX/PYNbwOIJRRYdIbApay4PqBRzXbgcDWmZR+FzbBpQgo3nne1B+wrsub2syTwo
 sOzEWJ/UN7B9B1FkFgleUVgpfbhPPC8IeFeGC4D8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <04575653-a2ba-4ef1-b1af-a514bec80a69@yandex-team.ru>
Date: Tue, 17 Feb 2026 20:55:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] qapi: add blockdev-replace command
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
 <20260119144941.87936-5-vsementsov@yandex-team.ru>
 <87wm0sy9s4.fsf@pond.sub.org>
 <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru>
 <87seb3zr7j.fsf@pond.sub.org>
 <f9aed7fd-2f56-4b54-bf4f-693e0c10fb38@yandex-team.ru>
 <87seazjz2q.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87seazjz2q.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 17.02.26 16:10, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 14.02.26 11:04, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> On 04.02.26 15:26, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>>
>>>>>> Add a command that can replace bs in following BdrvChild structures:
>>>>>>
>>>>>>     - qdev blk root child
>>>>>>     - block-export blk root child
>>>>>>     - any child of BlockDriverState selected by child-name
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>>>>> Let's see whether I understand...
>>>>>
>>>>> @parent determines which of the three cases mentioned in the commit
>>>>> message it ids:
>>>>>
>>>>> * If @parent is a QOM path, case 1.
>>>>>
>>>>> * If @parent is a block export name (@id in BlockExportOptions and
>>>>>     BlockExportInfo), case 2.
>>>>>
>>>>> * If @parent is a block node name (@node-name in BlockdevOptions and
>>>>>     BlockDeviceInfo), case 3.
>>>>>
>>>>> Correct?
>>>>>
>>>>> Problem: this is ambiguous.  A @parent "foo" could in fact be any of the
>>>>> three cases.
>>>>
>>>> Yes. And we return an error in case of any ambiguity.
>>>
>>> So, in case of ambiguity, the command does not work.
>>>
>>> On the one hand, this is the user's doing: reusing the same ID for
>>> multiple things has always been a bad idea.
>>>
>>> On the other hand, we're now turning a bad idea that may cause confusion
>>> into an bad idea that may break things.  Feels iffy.
>>>
>>> For QOM paths, we have a workaround: avoid partial QOM paths.  Feels
>>> okay.  Partial QOM paths are rather obscure, and best avoided entirely.
>>>
>>> The only workaround for block export vs. block node ambiguity is to
>>> avoid ID reuse.  By the time a user sees the command fail, the IDs are
>>> what they are, and there's is no workaround.
>>>
>>> Do you need blockdev-replace to work for both *now*?
>>>
>>> At the very least, we need to document the trap and point to the
>>> workaround.
>>>
>>> Alternatively, come up with an interface that avoids the issue.  See
>>> below.
>>>
>>>>> 3. If a block node named "foo" exists, it's case 3.
>>>>>
>>>>> 2. If a block export named "foo" exists, it's also case 2.
>>>>>
>>>>> 1. If exactly one QOM object named "foo" exists, it's also case 1.  Why?
>>>>>       "foo" is a syntactically valid partial QOM path.  Partial QOM paths
>>>>>       are a convenience feature that is virtually unknown (and possibly
>>>>>       ill-advised): you can omit leading path components as long as there's
>>>>>       no ambiguity.
>>>>>
>>>>> Peeking ahead in the series...  PATCH 8 appears to deprecate the
>>>>> ambiguity between case 2. and 3.
>>>>>
>>>>> I think we need to do better.
>>>
>>> See review of PATCH 8 for doing better on deprecation.
>>>
>>>>> More questions...
>>>>>
>>>>> In case 1 and 2, @child "should be root".  What happens when it's
>>>>> something else?
>>>>
>>>> Error returned. s/should/must/ ?
>>>
>>> Yes, please.
>>>
>>>>> In case 3, @child "should be any if its children names".  I figure the
>>>>> command fails when it isn't.
>>>>
>>>> And here.
>>>
>>> Likewise.
>>>
>>>>>> +{ 'command': 'blockdev-replace',
>>>>>> +  'data': { 'parent': 'str', 'child': 'str', 'new-child': 'str' } }
>>>>>
>>>>> [...]
>>>
>>> This interface sort of overloads @parent and @child, and overloading the
>>> former creates ambiguity that can make the command unusable.
>>
>> Is it a real problem if we do deprecate the thing, that leads to this
>> ambiguity?
>>
>> If it is, we may mark the command "unstable" during the deprecation period.
> 
> By itself, the proposed command is a trap for the unwary.
> 
> Deprecating the usage that enables the trap makes the trap temporary.
> 
> Warning on (deprecated) usage that enables the trap helps users avoid
> it.  Human users, mostly.
> 
> Marking the command "unstable" should ensure management application
> avoid the command, and thus the trap.
> 
> All of the above together feels acceptable to me.  Can we do better?
> Maybe, and that's discussed below.
> 
>> Or even postpone its addition up to the end of this period.
> 
> No trap, no problem :)
> 
>>> @parent's set of valid values is the union of QOM path, block node name,
>>> block export ID with values occuring in more than one of them dropped.
>>>
>>> @child's set of valid values depends on @parent: child name when it's a
>>> QOM path, else "root".
>>>
>>> The obvious non-overloaded interface is a union of three branches: QOM,
>>> block node, block export.  The QOM branch has variant members @qom-path
>>> and @child.  The block node branch has variant member @node-name.  The
>>> block export branch has variant member @id.
>>>
>>> This is a bit more verbose: you have to specify the union tag[*].
>>>
>>> If we ever need to replace block nodes associated with additional
>>> things, we simply more branches.  These branches can have arbitrary
>>> members.  In your interface, we'd have to make do with @child, or maybe
>>> add optional arguments.
>>>
>>> Thoughts?  Mind, this isn't a demand!  I'm exploring the design space.
>>
>> Union-based solution was v9: https://lore.kernel.org/qemu-devel/20240626115350.405778-5-vsementsov@yandex-team.ru/
>>
>> And there was a discussion, that we may try a way without a union. And that's
>> this v10.
> 
> I see Kevin suggested to explore this approach.  I certainly respect his
> judgement.
> 
>> Hmm, but that had different field names for parents: qdev-id, export-id and node-name.
>>
>> What you suggest is to keep one filed for parent - "parent", but also add a "parent-type"
>> field. This way, we may deprecate and remove "parent-type" in future. Or, we may
>> add it as deprecated now (together with deprecating non-unique IDs)
> 
> We can't deprecate the union tag right away: it is *required*.
> 
>>> [*] We could add a "may omit union tag when the tag value can be derived
>>> from present variant members" convenience feature to QAPI, but I'm not
>>> sure it's worth the complexity.
>>>
>>
>> It also may be not a union, but a simple structure with optional fields:
>>
>> {
>>      parent: str, required, qom-path, or node-name, or export name
>>      child: str, optional, but required when parent is node-name, and must be 'root'
>>             if present for other parent types
>>      parent-type: str, optional, "qom-path" | "block-node" | "block-export", helps to
>>             overcome parent ambiguity, deprecated
>>      new-child: str, required node-name
>> }
> 
> PRO union: which members are valid together is syntactically obvious.
> With a bunch of optional members, that information is in the member
> descriptions.
> 
> CON union: need to specify the union tag.  The verbosity is a non-issue
> for management applications, and mildly bothersome for humans.
> 
> How important is keeping things terse for humans here?
> 

It's not very important. Mostly, I just want to make "nice" interface, and possibility to
reference any supported object by one ID seemed very tempting to me.

But to be honest, introducing such a precedent makes sense, if we have in mind more
cases where such approach may be reused. Personally, I don't have them. If blockdev-replace
command remains the only API for the ages, which allows to mix in one field different kinds
of IDs, it becomes just an extra exclusion from common practices.

Finally, I don't care too much, which interface we chose. I'm not sure now that unifying
ids is better than union. So I'm OK to go back to union-based solution from v9, update and
resend it as v11.

-- 
Best regards,
Vladimir


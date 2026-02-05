Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBBFE9128B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 07:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vntpP-000259-AM; Thu, 05 Feb 2026 02:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vntp3-00024C-0u; Thu, 05 Feb 2026 02:30:48 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vntp0-0004SM-Al; Thu, 05 Feb 2026 02:30:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 19768C039E;
 Thu, 05 Feb 2026 10:30:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VUkGn00ABSw0-JA0nqige; Thu, 05 Feb 2026 10:30:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770276632;
 bh=x9tMlc5A4PUrMemLwiG9q+nknLaRx7soTxzv3kFUk+s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=crfuRc7+PWvsp1s3ZWfNIuEDRLkRxu/io4pEUtiIqt9NNOeNmLww2i0nXhy7mIN++
 Q/7fXVG0brEWlHGyhXfWWWeZopvpFxuLbZQ0VbE/bkII6/qn4cQsTDQbmK0DVShjIV
 fP6yJEuXxHrOEwQ4xd0gpGDpI1cxOZhpiqKL1UqA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <739edd0f-8342-418e-96bb-01bc9bd3349e@yandex-team.ru>
Date: Thu, 5 Feb 2026 10:30:31 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wm0sy9s4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 04.02.26 15:26, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add a command that can replace bs in following BdrvChild structures:
>>
>>   - qdev blk root child
>>   - block-export blk root child
>>   - any child of BlockDriverState selected by child-name
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b82af74256..9cc7c3d140 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -6334,3 +6334,27 @@
>>   ##
>>   { 'struct': 'DummyBlockCoreForceArrays',
>>     'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
>> +
>> +##
>> +# @blockdev-replace:
>> +#
>> +# Replace a block-node associated with device (@parent should be
>> +# QOM path, and @child should be "root") or with block-export (@parent
>> +# should be export name, and @child should be "root") or any child
>> +# of block-node (@parent should be node-name, and @child should be any
>> +# if its children names) with @new-child block-node.
> 
> of its
> 
>> +#
>> +# @parent: QOM path or block-export or node-name, which @child should
>> +#     be repalced.  If several matching parents exist, the command
> 
> replaced
> 
>> +#     will fail
> 
> End the sentence with a period, please.
> 
>> +#
>> +# @child: child to replace.  Must be "root" when parent is QOM path or
>> +#     block-export
> 
> Likewise.
> 
>> +#
>> +# @new-child: node-name of the block-node, which should become a
>> +#    replacement for @child's current block-node
> 
> Likewise.
> 
> Indent one more, please.
> 
>> +#
>> +# Since 11.0
>> +##
> 
> Let's see whether I understand...
> 
> @parent determines which of the three cases mentioned in the commit
> message it ids:
> 
> * If @parent is a QOM path, case 1.
> 
> * If @parent is a block export name (@id in BlockExportOptions and
>    BlockExportInfo), case 2.
> 
> * If @parent is a block node name (@node-name in BlockdevOptions and
>    BlockDeviceInfo), case 3.
> 
> Correct?
> 
> Problem: this is ambiguous.  A @parent "foo" could in fact be any of the
> three cases.

Yes. And we return an error in case of any ambiguity.

> 
> 3. If a block node named "foo" exists, it's case 3.
> 
> 2. If a block export named "foo" exists, it's also case 2.
> 
> 1. If exactly one QOM object named "foo" exists, it's also case 1.  Why?
>     "foo" is a syntactically valid partial QOM path.  Partial QOM paths
>     are a convenience feature that is virtually unknown (and possibly
>     ill-advised): you can omit leading path components as long as there's
>     no ambiguity.
> 
> Peeking ahead in the series...  PATCH 8 appears to deprecate the
> ambiguity between case 2. and 3.
> 
> I think we need to do better.
> 
> More questions...
> 
> In case 1 and 2, @child "should be root".  What happens when it's
> something else?

Error returned. s/should/must/ ?

> 
> In case 3, @child "should be any if its children names".  I figure the
> command fails when it isn't.

And here.

> 
>> +{ 'command': 'blockdev-replace',
>> +  'data': { 'parent': 'str', 'child': 'str', 'new-child': 'str' } }
> 
> [...]
> 


-- 
Best regards,
Vladimir


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0422DCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1Iv-0003id-BG; Mon, 01 Sep 2025 05:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut1Is-0003hy-Rh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:58:22 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut1In-0000H7-DC
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:58:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 784CD80C78;
 Mon, 01 Sep 2025 12:58:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:12c::1:9] (unknown [2a02:6bf:8080:12c::1:9])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Bwauau2F0Ko0-sChn2y4d; Mon, 01 Sep 2025 12:58:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756720692;
 bh=u8EUt1d/7ZfqSH21XQFnHqkNQnzSK5sCCDUEZ9SSRo0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QYk4bd7YVVXOJ38wJpWcvuOFb1mxAuL8ewBfZGAMhwETbrj9PJwtSBuY72jFF/o7I
 /xmNNRaTks6QtR+v2JegbzxJtWmRt0YxQ2DFJTeO7CCLTs6+MYZw7JSfWeelqXJmFK
 LmbQkXvXTWCh2sSYuyR1yQ1wpLNaaaoqbpC5leW4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <66837e31-6751-48bb-b2b0-827dfdec527c@yandex-team.ru>
Date: Mon, 1 Sep 2025 12:58:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi: net/tap: deprecate vhostforce option
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com,
 devel@lists.libvirt.org
References: <20250829125429.795595-1-vsementsov@yandex-team.ru>
 <87wm6lcjfx.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wm6lcjfx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 30.08.25 11:17, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> This option simply duplicates the @vhost option since long ago
>> (10 years!)
>> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
> 
> This isn't obvious to me.
> 
> As far as I can see, their only use is in net_init_tap_one():
> 
>      if (tap->has_vhost ? tap->vhost :
>          vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
> 
> Can you take this apart for me?

Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
(that don't have MSI-X support), you should hav set vhostforce=on
(with vhost=on or unset).

Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
for vhost-enabling options logic.

So we simply have redundant options:

vhost=on / vhost=off : vhostforce ignored, doesn't make sense

vhost unset : vhostforce counts, enabling vhost

So you may enable vhost several ways:
- vhost=on
- vhostforce=on
- vhost=on + vhostforce=on
- and even vhost=on + vhostforce=off

- they are all equal.

> 
>> Let's finally deprecate it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   docs/about/deprecated.rst | 7 +++++++
>>   qapi/net.json             | 6 +++++-
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index d50645a071..d14cb37480 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>>   The ``reconnect`` option only allows specifying second granularity timeouts,
>>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>>   
>> +TAP ``vhostforce`` (since 10.2)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The ``vhostforce`` option just duplicates the main ``vhost`` option.
>> +Use ``vhost`` alone.
> 
> Would "Use instead ``vhost`` instead" be clearer?

I meant, that user should not use vhost=on + vhostforce=on anymore.

My be just "Use ``vhost``", without "alone"/"instead"?

> 
>> +
>> +
>>   VFIO device options
>>   '''''''''''''''''''
>>   
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 78bcc9871e..d1216bb60a 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -353,6 +353,10 @@
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# Features:
>> +#
>> +# @deprecated: Member @vhostforce is deprecated.  Simply use @vhost.
> 
> @deprecated text is commonly of the form "FOO is deprecated.  Use BAR
> instead."
> 
> Recommend "Use @vhost instead."
> 
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -369,7 +373,7 @@
>>       '*vhost':      'bool',
>>       '*vhostfd':    'str',
>>       '*vhostfds':   'str',
>> -    '*vhostforce': 'bool',
>> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>       '*queues':     'uint32',
>>       '*poll-us':    'uint32'} }
> 


-- 
Best regards,
Vladimir


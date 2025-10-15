Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15684CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92J6-0000fY-FQ; Wed, 15 Oct 2025 10:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92J0-0000ez-0E
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:16:46 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92Is-0002X8-Fr
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:16:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8982:0:640:5cf4:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3D7F6807FC;
 Wed, 15 Oct 2025 17:16:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a94::1:15] (unknown
 [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QGRfeD3F6Sw0-z5MvY6te; Wed, 15 Oct 2025 17:16:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760537786;
 bh=VkbZSrqRdF56Tr9OVfRkNhBqQ95hLYsAyjBKRVhk+EY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=k3b63BFAdaDBL8d2cfN9HSPpxPm+++/xQ1BDdjymjXyC5DEKY7mwLPuoBlc8Xew6L
 2/qrwxY/15JM5hnfQtIroL2zqZXatyC/jBjJi7RXRmHSPnK0hDHtnE25k4klD4QZKo
 ZPozX5+66JdriENpHgcx6cJSRoOVY+qd//gZavj8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <92593ecc-e807-4cdc-aea8-81f41e63b87e@yandex-team.ru>
Date: Wed, 15 Oct 2025 17:16:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qapi: net/tap: deprecate vhostforce option
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
References: <20250901153943.65235-1-vsementsov@yandex-team.ru>
 <CACGkMEtD3_WP51=XPFM6oTsrSUCHkm9+ukEEWC68iayCKzNU9Q@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEtD3_WP51=XPFM6oTsrSUCHkm9+ukEEWC68iayCKzNU9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14.10.25 08:48, Jason Wang wrote:
> On Mon, Sep 1, 2025 at 11:39 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> This option doesn't make sense since long ago (10 years!)
>> commit 1e7398a140f7a6 ("vhost: enable vhost without without MSI-X").
> 
> qemu-options.hx still say:
> 
> """
>      "                use vhostforce=on to force vhost on for non-MSIX
> virtio guests\n"
> """
> 
> Should we fix that as well?

will do.

> 
>>
>> Prior 1e7398a140f7a6, to enable vhost for some specific kind of guests
>> (that don't have MSI-X support), you should have set vhostforce=on
>> (with vhost=on or unset).
>>
>> Since 1e7398a140f7a6, guest type doesn't matter, all guests are equal
>> for vhost-enabling options logic.
>>
>> The current logic is:
>>    vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>>    vhost unset : vhostforce counts, enabling vhost
>>
>> Currently you may enable vhost several ways:
>> - vhost=on
>> - vhostforce=on
>> - vhost=on + vhostforce=on
>> - and even vhost=on + vhostforce=off
>>
>> - they are all equal.
>>
>> Let's finally deprecate the extra option.
> 
> Note that vhostforce works for vhost-user as well:
> 
> { 'struct': 'NetdevVhostUserOptions',
>    'data': {
>      'chardev':        'str',
>      '*vhostforce':    'bool',
>      '*queues':        'int' } }
> 
> Should we change that as well?
> 

hmm, this vhostforce is unused. Will deprecate it as well.

>>
>> Also, fix @vhostforce documentation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>
>> v3: - two spaces between sentences for vhostforce description
>>      - add r-b by Markus
>>
>>   docs/about/deprecated.rst |  7 +++++++
>>   qapi/net.json             | 11 +++++++++--
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index d50645a071..b17a5a41aa 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -516,6 +516,13 @@ Stream ``reconnect`` (since 9.2)
>>   The ``reconnect`` option only allows specifying second granularity timeouts,
>>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>>
>> +TAP ``vhostforce`` (since 10.2)
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The ``vhostforce`` option is redundant with the ``vhost`` option.
>> +If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
>> +
>> +
>>   VFIO device options
>>   '''''''''''''''''''
>>
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 78bcc9871e..bab26e0c5d 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -346,13 +346,20 @@
>>   # @vhostfds: file descriptors of multiple already opened vhost net
>>   #     devices
>>   #
>> -# @vhostforce: vhost on for non-MSIX virtio guests
>> +# @vhostforce: enable vhost-net network accelerator.  Ignored when
>> +#    @vhost is set.
>>   #
>>   # @queues: number of queues to be created for multiqueue capable tap
>>   #
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# Features:
>> +#
>> +# @deprecated: Member @vhostforce is deprecated.  The @vhostforce
>> +#    option is redundant with the @vhost option. If they conflict,
>> +#    @vhost takes precedence.  Just use @vhost.
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -369,7 +376,7 @@
>>       '*vhost':      'bool',
>>       '*vhostfd':    'str',
>>       '*vhostfds':   'str',
>> -    '*vhostforce': 'bool',
>> +    '*vhostforce': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>       '*queues':     'uint32',
>>       '*poll-us':    'uint32'} }
>>
>> --
>> 2.48.1
>>
> 
> Thanks
> 

Thanks for reviewing!

-- 
Best regards,
Vladimir


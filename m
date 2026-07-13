Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4679EC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKsh-00005K-DR; Mon, 13 Jul 2026 13:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjKsd-0008Vi-1G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:47 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjKsZ-00050D-Ee
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 0E4F8C08CD;
 Mon, 13 Jul 2026 20:55:39 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id btSRMB0XGuQ0-idUowOsI; Mon, 13 Jul 2026 20:55:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783965338;
 bh=nz2l5jN2QkQtdNKtEycPqNtFsGFb6nJVU7KahWQz5rs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g5YnA1jzwjCeFIa0iX7p19yAie0GrgQB3pzehKMMTepvIwn253EJAxDoHVDnPrXCa
 xbF/fs2lRQu9RQ22Di8Ho/xDdMDIRHAkVL/WN9GmsVcFuCs7Pf5XiF1R71pSmnb2oT
 WyPtb+d/Lmp7Pk1L1BxsoY0nk8fdbE5ZJNl6O0hA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <25b5e9a6-e563-4ab0-9075-04a3a00d3b33@yandex-team.ru>
Date: Mon, 13 Jul 2026 20:55:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/14] qapi: add local migration parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Eric Blake <eblake@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-10-vsementsov@yandex-team.ru>
 <alS1DMD_pRrklFRb@redhat.com>
 <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
 <alTKMA87h9x951Ei@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <alTKMA87h9x951Ei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 13.07.26 14:21, Daniel P. Berrangé wrote:
> On Mon, Jul 13, 2026 at 01:55:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 13.07.26 12:51, Daniel P. Berrangé wrote:
>>> On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> We are going to implement local-migration feature: some devices will be
>>>> able to transfer open file descriptors through migration stream (which
>>>> must UNIX domain socket for that purpose).  This allows to transfer the
>>>> whole backend state without reconnecting and restarting the backend
>>>> service. For example, virtio-net will migrate its attached TAP netdev,
>>>> together with its connected file descriptors.
>>>>
>>>> In this commit we introduce a migration parameter, which enables
>>>> the feature for devices that support it (none at the moment).
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>> Reviewed-by: Ben Chaney <bchaney@akamai.com>
>>>> ---
>>>>    include/migration/misc.h |  2 ++
>>>>    migration/options.c      | 18 +++++++++++++++++-
>>>>    qapi/migration.json      | 12 ++++++++++--
>>>>    3 files changed, 29 insertions(+), 3 deletions(-)
>>>
>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 66bd900465a..03bdf19f3a6 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -830,7 +830,8 @@
>>>>               'zero-page-detection',
>>>>               'direct-io',
>>>>               { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>>>> -           'cpr-exec-command'] }
>>>> +           'cpr-exec-command',
>>>> +           'local'] }
>>>>    ##
>>>>    # @migrate-set-parameters:
>>>> @@ -1012,6 +1013,12 @@
>>>>    #     Must be set to the same value on both source and destination
>>>>    #     before migration starts.  (Since 11.1)
>>>>    #
>>>> +# @local: Enable local migration for devices that support it.  Backend
>>>> +#     state and its file descriptors can then be passed to the
>>>> +#     destination in the migration channel.  The migration channel
>>>> +#     must be a Unix domain socket.  Usually needs to be enabled per
>>>> +#     device.  (Since 11.2)
>>>
>>> What happens when this is enabled and there are devices which
>>> don't support it ?
>>
>> These devices are migrated as usual, ignoring "local" option.
>>
>>>
>>> What happens when this is enabled and a device on the src
>>> does not support it but a device on the (newer) QEMU dest
>>> does support it ?  How does the mgmt app know which devices
>>> support it ?
>>
>> The only supporting device (TAP-backend) declares support by
>> "local-migration-supported", so mgmt app should care to set
>> same value for it on host and target (like for other options
>> actually). Or simply relay on default, which is true starting
>> from 11.2 Machine Type.
>>
>>>
>>> Can we document the semantics in these cases.
>>
>> That's: "Usually needs to be enabled per device."
> 
> ....except that we have it enabled by default for TAP backends
> in new machine types.... except that it will then break if the
> app/user has enabled any of the "forbidden" options.
> 
> The way this doc is written makes it sound like "local" is an
> optimization you can turn on in any scenario, and it will do
> the right thing if the device supports it. That is very much
> not the case - enabling this flag will definitely break many
> configs out of the box, with new machine types due to the TAP
> device defaults & incompatible options.

Ok, now we decided to NOT make default support for TAP in newer
machine types.

So, enabling "local" is safe in existing scenarios, only explicit
enabling TAP.local-migration-supported will change the behavior.

Keep "local" documentation as is?

I see the only way to make it more informative: directly describe
connection with TAP.local-migration-supported, without general
phrases about "devices that support" and "usual". We'll have to
update it when more devices added (my next step is vhost-user-blk),
but at least, it would be absolutely correct at the moment.

> 
> 
>> So, we (may) have three types of devices:
>>
>> 1. Not supporting "local" migration: they just ignore "local" migration
>> parameter.
> 
> Yep, the easy case.
> 
>>
>> 2. Supporting "local" from the beginning (not such devices for now):
>> they simply do "local" migration when "local" is set, and "usual"
>> migration when "local" is not set.
> 
> ...except that abort the migration if you used any forbidden options.
> I really dislike this as default out of the box behaviour for the
> TAP backend.
> 
>> 3. Support for "local" appears at some moment (like TAP in this series).
>> Such devices should have a possibility to enable/disable the "support
>> for local" by hand, to be able to migrate betweend supporting and
>> not supporting QEMU versions.
> 
> If the mgmt app is manually enabling the feature, then mitigates
> the problem of forbidden options, as they should be aware of
> whether their config is safe to enable or not.
> 
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir


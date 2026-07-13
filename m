Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC2C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEKS-0004at-25; Mon, 13 Jul 2026 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjEKN-0004a2-5y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:56:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjEKI-0004fi-Uv
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:55:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id B8CAA80848;
 Mon, 13 Jul 2026 13:55:50 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id ntLOM20aB4Y0-C1WZgYcx; Mon, 13 Jul 2026 13:55:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783940150;
 bh=jn0FQxXgDz3mtEWaDeeXRrJ3VY3lCCb/djOnCm0pDbs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Y8D7vRa3OfEMcpAvasijhmyuXg8l3Fd9yhJe2uwYLeZxxXGURVqlvCoU2Dplneq2Z
 zaz9K/BaKT8gDT2uMV/IllYTDx9ejwqo4ptQuBZwse7c8kspYUAYUGGS4uM688BAZK
 mWfQbWjQyXRoypDZSOc5tg7B0bUOBuOye8vM2mSQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <05c89310-7bec-4aac-addc-b5ef377e09a7@yandex-team.ru>
Date: Mon, 13 Jul 2026 13:55:48 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <alS1DMD_pRrklFRb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 13.07.26 12:51, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2026 at 10:17:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We are going to implement local-migration feature: some devices will be
>> able to transfer open file descriptors through migration stream (which
>> must UNIX domain socket for that purpose).  This allows to transfer the
>> whole backend state without reconnecting and restarting the backend
>> service. For example, virtio-net will migrate its attached TAP netdev,
>> together with its connected file descriptors.
>>
>> In this commit we introduce a migration parameter, which enables
>> the feature for devices that support it (none at the moment).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Ben Chaney <bchaney@akamai.com>
>> ---
>>   include/migration/misc.h |  2 ++
>>   migration/options.c      | 18 +++++++++++++++++-
>>   qapi/migration.json      | 12 ++++++++++--
>>   3 files changed, 29 insertions(+), 3 deletions(-)
> 
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 66bd900465a..03bdf19f3a6 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -830,7 +830,8 @@
>>              'zero-page-detection',
>>              'direct-io',
>>              { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>> -           'cpr-exec-command'] }
>> +           'cpr-exec-command',
>> +           'local'] }
>>   
>>   ##
>>   # @migrate-set-parameters:
>> @@ -1012,6 +1013,12 @@
>>   #     Must be set to the same value on both source and destination
>>   #     before migration starts.  (Since 11.1)
>>   #
>> +# @local: Enable local migration for devices that support it.  Backend
>> +#     state and its file descriptors can then be passed to the
>> +#     destination in the migration channel.  The migration channel
>> +#     must be a Unix domain socket.  Usually needs to be enabled per
>> +#     device.  (Since 11.2)
> 
> What happens when this is enabled and there are devices which
> don't support it ?

These devices are migrated as usual, ignoring "local" option.

> 
> What happens when this is enabled and a device on the src
> does not support it but a device on the (newer) QEMU dest
> does support it ?  How does the mgmt app know which devices
> support it ?

The only supporting device (TAP-backend) declares support by
"local-migration-supported", so mgmt app should care to set
same value for it on host and target (like for other options
actually). Or simply relay on default, which is true starting
from 11.2 Machine Type.

> 
> Can we document the semantics in these cases.

That's: "Usually needs to be enabled per device."

Requiring any device to have a specific options like
"local-migration-supported" (for TAP device in this series) would
be not correct if new devices added, supporting "local" migration
from the beginning..

So, we (may) have three types of devices:

1. Not supporting "local" migration: they just ignore "local" migration
parameter.

2. Supporting "local" from the beginning (not such devices for now):
they simply do "local" migration when "local" is set, and "usual"
migration when "local" is not set.

3. Support for "local" appears at some moment (like TAP in this series).
Such devices should have a possibility to enable/disable the "support
for local" by hand, to be able to migrate betweend supporting and
not supporting QEMU versions.

Unsure, that we need this all be described here, may be, just ref
the only supporting device (TAP), so user may go to
"local-migration-supported" description for details?



> 
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>> @@ -1053,7 +1060,8 @@
>>               '*direct-io': 'bool',
>>               '*x-rdma-chunk-size': { 'type': 'uint64',
>>                                       'features': [ 'unstable' ] },
>> -            '*cpr-exec-command': [ 'str' ]} }
>> +            '*cpr-exec-command': [ 'str' ],
>> +            '*local': 'bool' } }
>>   
>>   ##
>>   # @query-migrate-parameters:
>> -- 
>> 2.43.0
>>
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir


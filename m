Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB2C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4gY-0005aB-Sf; Tue, 21 Jul 2026 03:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4gM-0005ZG-CF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:14:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4gI-000110-24
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:14:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 196F2809DC;
 Tue, 21 Jul 2026 10:14:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:45b::1:22] (unknown
 [2a02:6bf:8080:45b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id EEQfYE2XbW20-93pjrnal; Tue, 21 Jul 2026 10:14:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784618055;
 bh=j/B8Jxx8T3CzbNDHx+FRLHyp5oPVuFr0RHTm4oJTSP0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MGWM+z4lbxwOYIYl5dC3Jt2Qkxp57VSR15HQl/VOi8BvkGlLXXccQG91rzLjGK7i9
 yvf8QSjsrK6bCgtu/XYxiYRkvtpFLHy3g+f6n8JA/VBsrdmCVjyCDR0qROpo33o4gC
 C1Nqbu4oVs2TDL+lExbwVNQvGK7bCTtcdRMRuEUw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8872727e-1ffe-4d41-aac4-1e4ae682897e@yandex-team.ru>
Date: Tue, 21 Jul 2026 10:14:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/15] qapi: add local migration parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Eric Blake <eblake@redhat.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-10-vsementsov@yandex-team.ru>
 <87ik68suso.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ik68suso.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 21.07.26 09:47, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
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
> 
> [...]
> 
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 66bd900465a..813c1f76e46 100644
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
>> @@ -1012,6 +1013,15 @@
>>   #     Must be set to the same value on both source and destination
>>   #     before migration starts.  (Since 11.1)
>>   #
>> +# @local: Permit the use of optimizations for local migration.
>> +#     This must only be set when both the source and destination
>> +#     QEMU processes are on the same OS and directly connected
> 
> I think "on the same OS" is less than clear.  Does it mean both ends run
> Linux, or both ends run Windows?  That doesn't make sense.  Recommend to
> scratch it, because what matters is the UNIX domain socket.

Agree.

> 
> With that, my Acked-by stands.
> 
> Ignorant question you may well have covered before: could we forgo
> @local and simply use "is a UNIX domain socket"?

My mistake is still not having the answer in commit message.

We can't because, UNIX socket may be only a first part of transfer
channel to the remote target.

https://lore.kernel.org/qemu-devel/20260713162057-mutt-send-email-mst@kernel.org/


> 
>> +#     with a UNIX domain socket as the migration channel to enable
>> +#     use of file descriptor passing.  Individual device backends
>> +#     may need additional configuration flags set  to enable local
>> +#     migration optimizations.  This will be documented against the
>> +#     device backends where it applies.  (Since 11.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>> @@ -1053,7 +1063,8 @@
>>               '*direct-io': 'bool',
>>               '*x-rdma-chunk-size': { 'type': 'uint64',
>>                                       'features': [ 'unstable' ] },
>> -            '*cpr-exec-command': [ 'str' ]} }
>> +            '*cpr-exec-command': [ 'str' ],
>> +            '*local': 'bool' } }
>>   
>>   ##
>>   # @query-migrate-parameters:
> 


-- 
Best regards,
Vladimir


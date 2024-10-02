Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE77CF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzs3-00081Z-5J; Wed, 02 Oct 2024 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svzru-0007s5-OL; Wed, 02 Oct 2024 09:58:18 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svzrs-0003fe-Bs; Wed, 02 Oct 2024 09:58:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:f69e:0:640:3ef4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8DD8860BAE;
 Wed,  2 Oct 2024 16:58:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwbhXp1IdOs0-DZTN8r9G; Wed, 02 Oct 2024 16:58:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727877490;
 bh=P1CYH8mUxQMTkwYRT96zQoZAg3RIKRe6HJvEzb7VE2o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=g5CoPmRAu+r0YytDaTp6u9VBzph+/KIrCac+b4ZNPMHy/hLzs7KP03B6P/v3idFkG
 W3X7AUEwFxMiLRlfY08u92Fzjv1kytUkzmrd/YxBRL8eJJgqQRA5ab7tEsVJqcgAx1
 LM0NAd2Sk5F+aGT/zE7/xlUjI3Vu6j3WUn2f54xs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a2747d44-9f1d-4bec-a9dd-c7e9f7363575@yandex-team.ru>
Date: Wed, 2 Oct 2024 16:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, alexander.ivanov@virtuozzo.com
References: <20240809161828.1342831-4-eblake@redhat.com>
 <20240809161828.1342831-6-eblake@redhat.com> <87wmiqy5rl.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wmiqy5rl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02.10.24 16:49, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Although defaulting the handshake limit to 10 seconds was a nice QoI
>> change to weed out intentionally slow clients, it can interfere with
>> integration testing done with manual NBD_OPT commands over 'nbdsh
>> --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
>> to alter the timeout away from the default.
>>
>> The parameter name here intentionally matches the spelling of the
>> constant added in commit fb1c2aaa98, and not the command-line spelling
>> added in the previous patch for qemu-nbd; that's because in QMP,
>> longer names serve as good self-documentation, and unlike the command
>> line, machines don't have problems generating longer spellings.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>   qapi/block-export.json         | 10 ++++++++++
>>   include/block/nbd.h            |  6 +++---
>>   block/monitor/block-hmp-cmds.c |  4 ++--
>>   blockdev-nbd.c                 | 26 ++++++++++++++++++--------
>>   4 files changed, 33 insertions(+), 13 deletions(-)
>>
>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>> index ce33fe378df..c110dd375ad 100644
>> --- a/qapi/block-export.json
>> +++ b/qapi/block-export.json
>> @@ -17,6 +17,10 @@
>>   #
>>   # @addr: Address on which to listen.
>>   #
>> +# @handshake-max-secs: Time limit, in seconds, at which a client that
>> +#     has not completed the negotiation handshake will be disconnected,
>> +#     or 0 for no limit (since 9.2; default: 10).
>> +#
>>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>>   #
>>   # @tls-authz: ID of the QAuthZ authorization object used to validate
>> @@ -34,6 +38,7 @@
>>   ##
>>   { 'struct': 'NbdServerOptions',
>>     'data': { 'addr': 'SocketAddress',
>> +            '*handshake-max-secs': 'uint32',
>>               '*tls-creds': 'str',
>>               '*tls-authz': 'str',
>>               '*max-connections': 'uint32' } }
>> @@ -52,6 +57,10 @@
>>   #
>>   # @addr: Address on which to listen.
>>   #
>> +# @handshake-max-secs: Time limit, in seconds, at which a client that
>> +#     has not completed the negotiation handshake will be disconnected,
>> +#     or 0 for no limit (since 9.2; default: 10).
>> +#
>>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>>   #
>>   # @tls-authz: ID of the QAuthZ authorization object used to validate
>> @@ -72,6 +81,7 @@
>>   ##
>>   { 'command': 'nbd-server-start',
>>     'data': { 'addr': 'SocketAddressLegacy',
>> +            '*handshake-max-secs': 'uint32',
>>               '*tls-creds': 'str',
>>               '*tls-authz': 'str',
>>               '*max-connections': 'uint32' },
> 
> Are we confident we'll never need less than a full second?
> 

Hmm, recent "[PATCH v2] chardev: introduce 'reconnect-ms' and deprecate 'reconnect'" shows that at least sometimes second is not enough precision.

Maybe, using milliseconds consistently for all relatively short time intervals in QAPI would be a good rule?

-- 
Best regards,
Vladimir



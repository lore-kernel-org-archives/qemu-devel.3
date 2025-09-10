Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF607CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 10:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwI8f-0001Do-Qb; Wed, 10 Sep 2025 06:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI8c-0001CX-U7; Wed, 10 Sep 2025 06:33:19 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwI8a-0006cg-QB; Wed, 10 Sep 2025 06:33:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 33F5B8046C;
 Wed, 10 Sep 2025 13:33:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b48::1:39] (unknown
 [2a02:6bf:8080:b48::1:39])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CXH75B6FjSw0-0HGIstVI; Wed, 10 Sep 2025 13:33:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757500392;
 bh=h6y1giuF2cd9H7+dV5dNfWfARY3so0T5BRoYwULgSxs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zLaZnpMG8FqfVhL5F+ly3JMCxKjYiPToqv6aYLgtJJ9h/UVIuhXPvyPgBnd1n+1SL
 7YvrpyxwjiV/3wyVB6Mm9qxxCAKBYAGhKghxyDIUxnqP5qQ6PqEFiLJN8tm0dB7rqv
 ZVrdGTu/Xr8ixfFlIrdDnyPEWBdgG5u/SvG4EkBI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7d8153f0-28e4-422b-8210-28d1d7472528@yandex-team.ru>
Date: Wed, 10 Sep 2025 13:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aMFIhJp-GfOhv3AV@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMFIhJp-GfOhv3AV@redhat.com>
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

On 10.09.25 12:44, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use common qemu_set_blocking() instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   contrib/ivshmem-server/ivshmem-server.c |  5 ++++-
>>   hw/hyperv/syndbg.c                      |  4 +++-
>>   hw/virtio/vhost-user.c                  |  5 ++++-
>>   include/qemu/sockets.h                  |  1 -
>>   io/channel-socket.c                     |  7 +++----
>>   net/dgram.c                             | 16 +++++++++++++---
>>   net/l2tpv3.c                            |  5 +++--
>>   net/socket.c                            | 20 ++++++++++++++++----
>>   qga/channel-posix.c                     |  7 ++++++-
>>   tests/unit/socket-helpers.c             |  5 ++++-
>>   tests/unit/test-crypto-tlssession.c     |  8 ++++----
>>   util/oslib-posix.c                      |  7 -------
>>   util/oslib-win32.c                      |  5 -----
>>   util/vhost-user-server.c                |  4 ++--
>>   14 files changed, 62 insertions(+), 37 deletions(-)
>>
> 
>> diff --git a/qga/channel-posix.c b/qga/channel-posix.c
>> index 465d688ecb..ddf8ebdc5e 100644
>> --- a/qga/channel-posix.c
>> +++ b/qga/channel-posix.c
>> @@ -28,6 +28,7 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>>       GAChannel *c = data;
>>       int ret, client_fd;
>>       bool accepted = false;
>> +    Error *err = NULL;
>>   
>>       g_assert(channel != NULL);
>>   
>> @@ -36,7 +37,11 @@ static gboolean ga_channel_listen_accept(GIOChannel *channel,
>>           g_warning("error converting fd to gsocket: %s", strerror(errno));
>>           goto out;
>>       }
>> -    qemu_socket_set_nonblock(client_fd);
>> +    if (!qemu_set_blocking(client_fd, false, &err)) {
>> +        g_warning("errer: %s", error_get_pretty(err));
> 
> s/errer/error/
> 
> 
> This is a pre-existing problem, but none of this code should be using
> g_warning. g_printerr() should have been used for printing error
> messages. I'm not expecting you to fix that, just an observation.

Sure.

> 
>> +        error_free(err);
>> +        goto out;
>> +    }
>>       ret = ga_channel_client_add(c, client_fd);
>>       if (ret) {
>>           g_warning("error setting up connection");
> 
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161FECAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtaD-0005Gx-54; Tue, 09 Sep 2025 04:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvta5-0005DO-4d; Tue, 09 Sep 2025 04:20:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvtZw-0000Rs-QO; Tue, 09 Sep 2025 04:20:00 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 955D0807BD;
 Tue, 09 Sep 2025 11:19:40 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dJErqC6GnCg0-Z8FzCFnP; Tue, 09 Sep 2025 11:19:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757405980;
 bh=bKXVlOQYaDFjqcBZPYD2v0aakelK1gndUtmXupXKMd8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MWRb2qChdhvJSkPUZqoAf4HOQNHkjsrvvN9y9xX5icDfhgjhXozjL8ySuMKWjuW1A
 4wd5mhKynLQnOA2hHMn/W3Bu2qolG5YDaQdk1b8N8/bV7mqZgDhZaCfIi+r+Uc0JsB
 T5AuuHENL4t8B5S4dDuj2xDDYLLKVUz9lWn7Scy8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f7ca50b0-b20d-451e-addb-693772239b34@yandex-team.ru>
Date: Tue, 9 Sep 2025 11:19:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] util: drop qemu_socket_set_nonblock()
To: Peter Xu <peterx@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-5-vsementsov@yandex-team.ru>
 <aL9Vuohpnyn8IcsI@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL9Vuohpnyn8IcsI@x1.local>
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

On 09.09.25 01:16, Peter Xu wrote:
> On Wed, Sep 03, 2025 at 12:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use common qemu_set_blocking() instead.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Posix's qemu_socket_set_nonblock() asserts the retval.. While Windows's one
> doesn't.  IIUC that's the only reason you provided the generic error
> path in all callers, just in case some of them might fail on Windows?

Honestly, I thought that checking error on Linux is good too.. It may fail,
why not to check, where possible?

> 
> I wished Windows's one has an assertion from the start too.  Maybe none of
> the failure path would really trigger.. Not a big deal:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> One nitpick below:
> 
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
>> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
>> index 2f3c7320a6..9ccd436ee4 100644
>> --- a/contrib/ivshmem-server/ivshmem-server.c
>> +++ b/contrib/ivshmem-server/ivshmem-server.c
>> @@ -146,7 +146,10 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
>>           return -1;
>>       }
>>   
>> -    qemu_socket_set_nonblock(newfd);
>> +    if (!qemu_set_blocking(newfd, false, NULL)) {
> 
> Better if with a IVSHMEM_SERVER_DEBUG(), which follows the original lines.

Will add

> 
>> +        close(newfd);
>> +        return -1;
>> +    }
>>       IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
>>   
>>       /* allocate new structure for this peer */
> 

Thanks for reviewing my patches!


-- 
Best regards,
Vladimir


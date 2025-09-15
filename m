Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BA8CAC58F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4Fl-0001gb-Ru; Mon, 15 Sep 2025 04:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy4FV-0001Ug-DM; Mon, 15 Sep 2025 04:07:47 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy4FD-0006ba-SK; Mon, 15 Sep 2025 04:07:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 55458C0122;
 Mon, 15 Sep 2025 11:07:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c82::1:39] (unknown
 [2a02:6bf:8080:c82::1:39])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 67K0c81GjqM0-f8QKKbbV; Mon, 15 Sep 2025 11:07:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757923627;
 bh=Ww7TyAph3zVBQ/5FFWhEsL5beLGXgab7AfGAn4UuHcY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=s0Ksigfc8/Vq9fLLRP4BlMLqCNDP+e1u/F6sss6aT/IE7d8S+iyiFxeCs0oj57Ifl
 bTDMC2k2pNkVJkMhz6jBftEo+ebskRhy6Wakymg9K0vlQqKn3RSdjvlC0MLWS1AYEA
 vTK+wNiod26OhCZIkTtPuBIQhQRs8M66Pq70c6Ho=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a2e3f547-e480-48df-a011-4105b3483c22@yandex-team.ru>
Date: Mon, 15 Sep 2025 11:07:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-5-vsementsov@yandex-team.ru>
 <aMRRYhbRAnTu4Sew@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMRRYhbRAnTu4Sew@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12.09.25 19:59, Daniel P. Berrangé wrote:
> On Thu, Sep 11, 2025 at 12:20:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use common qemu_set_blocking() instead.
>>
>> Note that pre-patch the behavior of Win32 and Linux realizations
>> are inconsistent: we ignore failure for Win32, and assert success
>> for Linux.
>>
>> How do we convert the callers?
> 
>> 3. io/channel-socket.c: here we convert both old calls to
>> qemu_socket_set_nonblock() and qemu_socket_set_block() to
>> one new call. Pre-patch we assert success for Linux in
>> qemu_socket_set_nonblock(), and ignore all other errors here.
>> Still, all callers pass errp=NULL to qio_channel_set_blocking(),
>> so after patch we ignore all errors. Switching from assertion
>> to ignoring may be not very good, but still acceptable, keeping
>> in mind that all callers of qio_channel_set_blocking() do
>> explicitly ignore the error.
> 
> This is a bit questionable. IMHO the reason why nearly all
> callers pass errp=NULL is laziness based on the assumption
> that the code actually asserts, and no one thinking to check
> the win impl which didn't asset.
> 
> IOW, I think we need a prior patch that sets the 'errp'
> in all these callers, either to &error_abort, or to
> propage the error if practical.
> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   contrib/ivshmem-server/ivshmem-server.c |  6 +++++-
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
>>   14 files changed, 63 insertions(+), 37 deletions(-)
>>
>> diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
>> index 2f3c7320a6..a65943d0b8 100644
>> --- a/contrib/ivshmem-server/ivshmem-server.c
>> +++ b/contrib/ivshmem-server/ivshmem-server.c
>> @@ -146,9 +146,13 @@ ivshmem_server_handle_new_conn(IvshmemServer *server)
>>           return -1;
>>       }
>>   
>> -    qemu_socket_set_nonblock(newfd);
>>       IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
>>   
>> +    if (!qemu_set_blocking(newfd, false, NULL)) {
> 
> &error_warn here so we diagnose the reason we're returning -1
> to the caller ?

O, I missed we have error_warn already. It was always my dream to implement it, but never got around to it.

Ok

> 
>> +        close(newfd);
>> +        return -1;
>> +    }
>> +
>>       /* allocate new structure for this peer */
>>       peer = g_malloc0(sizeof(*peer));
>>       peer->sock_fd = newfd;
> 
>> diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
>> index 37db24f72a..1b7e283f24 100644
>> --- a/tests/unit/socket-helpers.c
>> +++ b/tests/unit/socket-helpers.c
>> @@ -88,7 +88,10 @@ static int socket_can_bind_connect(const char *hostname, int family)
>>           goto cleanup;
>>       }
>>   
>> -    qemu_socket_set_nonblock(cfd);
>> +    if (!qemu_set_blocking(cfd, false, NULL)) {
> 
> &error_abort here.

Ok

> 
>> +        goto cleanup;
>> +    }
>> +
>>       if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
>>           if (errno == EINPROGRESS) {
>>               check_soerr = true;
>   
> With regards,
> Daniel


-- 
Best regards,
Vladimir


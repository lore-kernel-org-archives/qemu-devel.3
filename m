Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49FCCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVLT-0008He-Jt; Tue, 16 Sep 2025 09:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVKa-00087R-6P; Tue, 16 Sep 2025 09:02:58 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVKM-0004wP-0D; Tue, 16 Sep 2025 09:02:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2B63C8073B;
 Tue, 16 Sep 2025 16:02:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16c::1:b] (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id B2QSbC2FtSw0-KJLN5foX; Tue, 16 Sep 2025 16:02:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758027732;
 bh=6k5yllyBYk33y5Ss+0VihrRYxH7/ropDZXoUt998vJo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lEGAj69JReD/UU2zj0o14H4eOnGLDN3dk91m5qYZ5ZvCzML4oJbFPf5df5YQV1qDi
 SfxzYbJYHLgb0qlcev+7dgqUuC6oUUx91vAC57Pid0jl/okNmay5crcuHZe3KGYuGH
 XUvQYNeKIeWdGbYtEyd5s2sexGBYa42UGGhG7Wqo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <57708e9e-3cbf-43d6-8801-62337190fc85@yandex-team.ru>
Date: Tue, 16 Sep 2025 16:02:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] util: drop qemu_socket_set_nonblock()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Coiby Xu <Coiby.Xu@gmail.com>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-7-vsementsov@yandex-team.ru>
 <aMkgwkjM_fwoOCf8@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMkgwkjM_fwoOCf8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 16.09.25 11:33, Daniel P. Berrangé wrote:
> On Mon, Sep 15, 2025 at 10:30:58PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Use common qemu_set_blocking() instead.
>>
>> Note that pre-patch the behavior of Win32 and Linux realizations
>> are inconsistent: we ignore failure for Win32, and assert success
>> for Linux.
>>
>> How do we convert the callers?
>>
>> 1. Most of callers call qemu_socket_set_nonblock() on a
>> freshly created socket fd, in conditions when we may simply
>> report an error. Seems correct switching to error handling
>> both for Windows (pre-patch error is ignored) and Linux
>> (pre-patch we assert success). Anyway, we normally don't
>> expect errors in these cases.
>>
>> Still in tests let's use &error_abort for simplicity.
>>
>> What are exclusions?
>>
>> 2. hw/virtio/vhost-user.c - we are inside #ifdef CONFIG_LINUX,
>> so no damage in switching to error handling from assertion.
>>
>> 3. io/channel-socket.c: here we convert both old calls to
>> qemu_socket_set_nonblock() and qemu_socket_set_block() to
>> one new call. Pre-patch we assert success for Linux in
>> qemu_socket_set_nonblock(), and ignore all other errors here.
>> So, for Windows switch is a bit dangerous: we may get
>> new errors or crashes(when error_abort is passed) in
>> cases where we have silently ignored the error before
>> (was it correct in all such cases, if they were?) Still,
>> there is no other way to stricter API than take
>> this risk.
>>
>> 4. util/vhost-user-server - compiled only for Linux (see
>> util/meson.build), so we are safe, switching from assertion to
>> &error_abort.
>>
>> Note: In qga/channel-posix.c we use g_warning(), where g_printerr()
>> would actually be a better choice. Still let's for now follow
>> common style of qga, where g_warning() is commonly used to print
>> such messages, and no call to g_printerr(). Converting everything
>> to use g_printerr() should better be another series.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   contrib/ivshmem-server/ivshmem-server.c |  9 ++++++++-
>>   hw/hyperv/syndbg.c                      |  4 +++-
>>   hw/virtio/vhost-user.c                  |  5 ++++-
>>   include/qemu/sockets.h                  |  1 -
>>   io/channel-socket.c                     |  7 +++----
>>   net/dgram.c                             | 16 +++++++++++++---
>>   net/l2tpv3.c                            |  5 +++--
>>   net/socket.c                            | 20 ++++++++++++++++----
>>   qga/channel-posix.c                     |  7 ++++++-
>>   tests/unit/socket-helpers.c             |  4 +++-
>>   tests/unit/test-crypto-tlssession.c     |  8 ++++----
>>   util/oslib-posix.c                      |  7 -------
>>   util/oslib-win32.c                      |  5 -----
>>   util/vhost-user-server.c                |  4 ++--
>>   14 files changed, 65 insertions(+), 37 deletions(-)
> 
> 
>> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
>> index d805a92394..b3416ab956 100644
>> --- a/util/vhost-user-server.c
>> +++ b/util/vhost-user-server.c
>> @@ -78,7 +78,7 @@ static void vmsg_unblock_fds(VhostUserMsg *vmsg)
>>       }
>>   
>>       for (i = 0; i < vmsg->fd_num; i++) {
>> -        qemu_socket_set_nonblock(vmsg->fds[i]);
>> +        qemu_set_blocking(vmsg->fds[i], false, &error_abort);
>>       }
>>   }
> 
> The caller of this method is able to handle errors more gracefully
> than abort.
> 
> 
> 
>> @@ -303,7 +303,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
>>   
>>           vu_fd_watch->fd = fd;
>>           vu_fd_watch->cb = cb;
>> -        qemu_socket_set_nonblock(fd);
>> +        qemu_set_blocking(fd, false, &error_abort);
>>           aio_set_fd_handler(server->ctx, fd, kick_handler,
>>                              NULL, NULL, NULL, vu_fd_watch);
>>           vu_fd_watch->vu_dev = vu_dev;
> 
> Can we put a TODO here that error_abort should be fixed to be more
> graceful - either by moving the set_blocking call out of this
> callback entirely, or allowing this method to return errors.
> 
> 

will do

-- 
Best regards,
Vladimir


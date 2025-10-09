Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D4CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 22:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6zM1-0000P1-OO; Thu, 09 Oct 2025 18:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6zLz-0000OK-G9; Thu, 09 Oct 2025 18:43:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6zLx-0000fM-2u; Thu, 09 Oct 2025 18:43:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1F2A180664;
 Fri, 10 Oct 2025 01:43:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9hTWVB1FGeA0-Qh5JewW6; Fri, 10 Oct 2025 01:43:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760049790;
 bh=BgbXPCaCGRoxibsrhThRXNj0AcuFWbOzO/jwUZiRZs8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sk2x02NfOpOQPQt3xUqxl3Y7DjD+jj1NQjw4LkH0Mvrrscd1VSmzR3pzchhSde8kt
 iJUQpy0X+pDgLqZ+2SCuyhL3VeYMxVSbIUz3V5ydnyEenA+09Ku4dXHyYCHsPHm3OY
 O5VBGkaNv8rXnBICLKm7+DgsoJm7K5tMTG9bP/ns=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <aabfa3db-e434-4dde-b01e-b0195eb4adee@yandex-team.ru>
Date: Fri, 10 Oct 2025 01:43:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] vhost-user-blk: live-backend local migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 09.10.25 22:16, Raphael Norwitz wrote:
> My apologies for the late review here. I appreciate the need to work
> around these issues but I do feel the approach complicates Qemu
> significantly and it may be possible to achieve similar results
> managing state inside the backend. More comments inline.
> 
> I like a lot of the cleanups here - maybe consider breaking out a
> series with some of the cleanups?

Of course, I thought about that too.

> 
> On Wed, Aug 13, 2025 at 12:56 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Hi all!
>>
>> Local migration of vhost-user-blk requires non-trivial actions
>> from management layer, it should provide a new connection for new
>> QEMU process and handle disk operation movement from one connection
>> to another.
>>
>> Such switching, including reinitialization of vhost-user connection,
>> draining disk requests, etc, adds significant value to local migration
>> downtime.
> 
> I see how draining IO requests adds downtime and is impactful. That
> said, we need to start-stop the device anyways

No, with this series and new feature enabled we don't have this drain,
see

     if (dev->backend_transfer) {
         return 0;
     }

at start of do_vhost_virtqueue_stop().

> so I'm not convinced
> that setting up mappings and sending messages back and forth are
> impactful enough to warrant adding a whole new migration mode. Am I
> missing anything here?

In management layer we have to manage two end-points for remote
disk, and accompany a safe switch from one to another. That's
complicated and often long procedure, which contributes an
average delay of 0.6 seconds, and (which is worse) ~2.4 seconds
in p99.

Of course, you may say "just rewrite your management layer to
work better":) But that's not simple, and we came to idea, that
we can do the whole local migration at QEMU side, not touching
backend at all.

The main benefit: fewer participants. We don't rely on management layer
and vhost-user server to do proper things for migration. Backend even
don't know, that QEMU is updated. This makes the whole process
simpler and therefore safer.

The disk service may also be temporarily down at some time, which of course has
a bad effect on live migration and its freeze-time. We avoid this
issue with my series (as we don't communicate to the backend in
any way during migration, and disk service should not manage any
endpoints switching)

Note also, that my series is not a precedent in QEMU, and not a totally new
mode.

Steve Sistare works on the idea to pass backends through UNIX socket, and it
is now merged as cpr-transfer and cpr-exec migration modes, and supports
VFIO devices.

So, my work shares this existing concept on vhost-user-blk and virtio-net,
and may be used as part of cpr-transfer / cpr-exec, or in separate.

> 
>>
>> This all leads to an idea: why not to just pass all we need from
>> old QEMU process to the new one (including open file descriptors),
>> and don't touch the backend at all? This way, the vhost user backend
>> server will not even know, that QEMU process is changed, as live
>> vhost-user connection is migrated.
> 
> Alternatively, if it really is about avoiding IO draining, what if
> Qemu advertised a new vhost-user protocol feature which would query
> whether the backend already has state for the device? Then, if the
> backend indicates that it does, Qemu and the backend can take a
> different path in vhost-user, exchanging relevant information,
> including the descriptor indexes for the VQs such that draining can be
> avoided. I expect that could be implemented to cut down a lot of the
> other vhost-user overhead anyways (i.e. you could skip setting the
> memory table). If nothing else it would probably help other device
> types take advantage of this without adding more options to Qemu.
> 

Hmm, if say only about draining, as I understand, the only thing we need
is support migrating of "inflight region". This done in the series,
and we are also preparing a separate feature to support migrating
inflight region for remote migration.

But, for local migration we want more: remove disk service from
the process at all, to have a guaranteed small downtime for live updates.
independent of any problems which may occur on disk service side.

Why freeze-time is more sensitive for live-updates than for remote
migration? Because we have to run a lot of live-update operations:
simply update all the vms in the cloud to a new version. Remote
migration happens much less frequently: when we need to move all
vms from physical server to reboot it (or repair it, serve it, etc).

So, I still believe, that migrating backend states through QEMU migration
stream makes sense in general, and for vhost-user-blk it works well too.


-- 
Best regards,
Vladimir


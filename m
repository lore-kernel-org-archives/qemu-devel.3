Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D1CC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwepd-0001yE-LW; Wed, 19 Aug 2026 07:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwepa-0001wq-Vn; Wed, 19 Aug 2026 07:51:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwepZ-0003q1-0T; Wed, 19 Aug 2026 07:51:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id F26FEC021A;
 Wed, 19 Aug 2026 14:51:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c60::1:5] (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XpU53GDWVOs0-kcHo7wfd; Wed, 19 Aug 2026 14:51:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787140293;
 bh=taqTt5GWppXgoJFKPZLmwOtzax+GhBimuUBZ39gIFpc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HoE2CkVy+ILmd9g0X5CA9R8RcmVts/ur+vM6bWMZNwRPT6GADk1Kv//C1CBbRiYfr
 5mJGPoyJW3Xpkb6OI5d5hWNJWfkmhUcIyjrrw/fva5uj9ABqQfintYDRg61+XOHjpN
 X0rKX122wyehRm6JY+7l3PzYfQ94lHdAoLQhF7hE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9c486f0c-3389-4e83-bf5b-1c3507a334d0@yandex-team.ru>
Date: Wed, 19 Aug 2026 14:51:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block/nbd: clear reply.cookie when the reply is
 rejected
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
References: <20260812102906.894063-1-den@openvz.org>
 <20260812102906.894063-2-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260812102906.894063-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Precedence: list
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

On 12.08.26 13:29, Denis V. Lunev wrote:
> nbd_receive_replies() reads a reply header into s->reply and, when the
> header turns out to be unusable, reports a channel error and returns
> without touching it. The cookie stays there until the request which
> owns the reply clears it, and until then the waiters are explicitly
> allowed to look at a cookie which is not theirs:
> 
>      if (s->reply.cookie != 0) {
>          ind2 = COOKIE_TO_INDEX(s->reply.cookie);
>          assert(!s->requests[ind2].receiving);
> 
> Two of the error paths leave a value chosen by the server behind: one
> returns before the cookie is validated at all, the other returns
> because that validation has failed. A waiter which picks such a cookie
> up turns it into an index which is not in requests[] and accesses the
> array out of bounds, at an offset the server controls.
> 
> The reply is of no use to anybody at this point, so clear the cookie
> before the mutex is released and keep the invariant that a non-zero
> s->reply.cookie is always an index of a live request.
> 
> Observing the stale cookie takes a second thread, which a multiqueue
> configuration provides. Within one AioContext there is no yield point
> between the failed read and the clearing done by the owner in
> nbd_co_receive_one_chunk(), so nothing else of this node runs in
> between. The parked waiters cannot see it either, as they are woken
> only after the cookie has been cleared. What can get in is a request
> entering nbd_receive_replies() afresh, one just sent or one back for
> its next reply chunk, because that path takes the mutex without
> looking at the state.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> Cc: Eric Blake<eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


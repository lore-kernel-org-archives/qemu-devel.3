Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890C606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=0ByW00AQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYFA-0005H8-Fx; Wed, 04 Nov 2026 05:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOYF7-0005GV-4D; Wed, 04 Nov 2026 05:29:21 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOYF5-0006gJ-6E; Wed, 04 Nov 2026 05:29:20 -0500
Received: from mail-nwsmtp-smtp-corp-main-80
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id EE6F98087A;
 Wed, 04 Nov 2026 13:29:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b97::1:12]
 by mail-nwsmtp-smtp-corp-main-80 with ESMTPSA id ETJfuE5ZlKo0-aMeLliBw;
 Wed, 04 Nov 2026 13:29:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1793788155;
 bh=bQQVbMEeTnMcii3h6GBtaatbseyiHQICdnWhn8+Vjak=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0ByW00AQ4Km/LamxPTIuhTuMKVbMzQO4YTK6UBPuIrtJ/L1qDLsTi9YXxHadHzBqr
 blNYKPVQ0uzqHdembT5pIajacmH4XscM1CEG5p2knsJhZSToE+eD4aENTKjUgClbMg
 x5q/q57sAyV4rfs0O6+JJv4pQicHnI4RDYmQLr70=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <978f83f5-9aff-4e82-81ab-633a99b03d49@yandex-team.ru>
Date: Wed, 4 Nov 2026 13:29:14 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.2] event_notifier: Remove assertions
To: Eric Farman <farman@linux.ibm.com>, "'Michael S . Tsirkin'"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261104030034.3577845-1-farman@linux.ibm.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20261104030034.3577845-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04.11.26 06:00, Eric Farman wrote:
> Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added asserts
> for uninitialized file descriptors in the various helper routines, because
> it presumes that such a thing is always in place once a couple of
> problematic paths were corrected in that commit.
> 
> Not all paths appear to adhere to this, however. s390x breaks because there
> is no config notifier so things that rely on vhost (virtio-net-ccw,
> vhost-vsock-ccw, etc.) fail on this assertion when called from
> vhost_start_config_intr().
> 
> Remove these new assertions from the API; can try again another day.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA8+x3Bf0LDyh9hU6J9N-A8Lii6fb8orB2Coucn-fAYtTA@mail.gmail.com/
> Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   util/event_notifier-posix.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index f595945af74..db53e0cee02 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -27,7 +27,6 @@
>    */
>   void event_notifier_init_fd(EventNotifier *e, int fd)
>   {
> -    assert(fd >= 0);
>       e->rfd = fd;
>       e->wfd = fd;
>       e->initialized = true;
> @@ -97,15 +96,11 @@ void event_notifier_cleanup(EventNotifier *e)
>   
>   int event_notifier_get_fd(const EventNotifier *e)
>   {
> -    assert(e->initialized);
> -    assert(e->rfd >= 0);
>       return e->rfd;
>   }
>   
>   int event_notifier_get_wfd(const EventNotifier *e)
>   {
> -    assert(e->initialized);
> -    assert(e->wfd >= 0);
>       return e->wfd;
>   }
>   


In my opinion "[PATCH for 11.2 v2] vhost: only use config notifier when exists/initialized"[1]
is better.

Removing assertions hides problems (like sending uninitialized fd to ioctl, fixed by [1])



-- 
Best regards,
Vladimir


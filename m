Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03542C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x561S-0002do-Ie; Fri, 11 Sep 2026 14:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x561O-0002bm-Iw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:30:47 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x561K-0005gW-Ri
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:30:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:2219:0:640:5d89:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 1727C807E6;
 Fri, 11 Sep 2026 21:30:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:641::1:4] (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id aUVLcbCf1iE0-2Op8gdW1; Fri, 11 Sep 2026 21:30:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789151436;
 bh=UsljNlzmnjq51yUAUc/AiEeOTk+KcfkIAPYJVB4uRP4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NLKmwNcVkd3+h5s2JRchQ/yCF9YkMt9HjFKMZxpvDZsqG1nXgxG+yO4DBTQLzP/nX
 A4gP9EdK/fyiBzzmqyTV+sKhNzjVJduGoWWSXpIs3Q+3Mn2AQEOb9J782XsR8PH4Nr
 qrqFfCTnesX/etnPlG1oK+o8bK02CjMRgwZT6MuM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ae5c7048-95da-44fe-9bd9-00b942612dca@yandex-team.ru>
Date: Fri, 11 Sep 2026 21:30:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] util/event_notifier: return -1 for uninitialized
 notifiers
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com
References: <20260911180854.123969-1-vsementsov@yandex-team.ru>
 <20260911180854.123969-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260911180854.123969-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
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

On 11.09.26 21:08, Vladimir Sementsov-Ogievskiy wrote:
> Use initialized in event_notifier_get_fd() and event_notifier_get_wfd()
> instead of exposing the descriptor fields of an uninitialized notifier.
> This makes a zeroed notifier report the same absent descriptor as one
> that has been cleaned up, while preserving fd 0 for initialized notifiers.
> 
> Document the accessor contract so callers can test for an absent notifier
> without accessing its initialized flag directly.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   include/qemu/event_notifier.h | 1 +
>   util/event_notifier-posix.c   | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
> index 8a4ff308e19..de2e876cb15 100644
> --- a/include/qemu/event_notifier.h
> +++ b/include/qemu/event_notifier.h
> @@ -37,6 +37,7 @@ int event_notifier_test_and_clear(EventNotifier *);
>   
>   #ifdef CONFIG_POSIX
>   void event_notifier_init_fd(EventNotifier *, int fd);
> +/* These accessors return -1 for an uninitialized notifier. */
>   int event_notifier_get_fd(const EventNotifier *);
>   int event_notifier_get_wfd(const EventNotifier *);
>   #else
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index 83fdbb96bbc..34a2716dbf2 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -96,12 +96,12 @@ void event_notifier_cleanup(EventNotifier *e)
>   
>   int event_notifier_get_fd(const EventNotifier *e)
>   {
> -    return e->rfd;
> +    return e->initialized ? e->rfd : -1;
>   }
>   
>   int event_notifier_get_wfd(const EventNotifier *e)
>   {
> -    return e->wfd;
> +    return e->initialized ? e->wfd : -1;
>   }
>   
>   int event_notifier_set(EventNotifier *e)


Hmm. No, stop. I have better idea. Actually no caller (except of exclusions in 02 and 03 patches, which we get rid off) expect getting invalid fd. So better is assert(e->initialized) in both getters. And add event_notifier_initialized() for rare callers which aware of this thing.

-- 
Best regards,
Vladimir


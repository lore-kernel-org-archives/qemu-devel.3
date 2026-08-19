Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D569C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmiZ-0000J7-Gd; Wed, 19 Aug 2026 16:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwmiY-0000Ik-05
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwmiW-0006AE-FN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 16:16:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 354AC80D14;
 Wed, 19 Aug 2026 23:16:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a71::1:2b] (unknown
 [2a02:6bf:8080:a71::1:2b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qGdBA7CaNiE0-0uryp9Cv; Wed, 19 Aug 2026 23:16:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787170613;
 bh=uye8t2OCYz5INlAAZUNgSVYZK0nGuhL5TuDgWzBKiKM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=MSeEyfJq3l2vlepgF81MFA8VzGjtPozO3kO4qZ+jGZ9JbhDAveGOfaR5sHQzzUd9+
 e/4a2Hj6zLO5k9xuqEHBjhO9Xeuv0KrphMYmtyCcEhdoJWYGtnEFY+VR57uY8133/C
 sLI9JHxSAcgmW6tb3dD8Sd4dVwsxXXdqPV/qlQb4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <dea30f6c-0e36-4715-a489-73284d83c361@yandex-team.ru>
Date: Wed, 19 Aug 2026 23:16:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: skip tsc synchronization on shutdown
To: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260127201831.179237-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260127201831.179237-1-vsementsov@yandex-team.ru>
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

Ping)

On 27.01.26 23:18, Vladimir Sementsov-Ogievskiy wrote:
> That doesn't make real sense, but may take much time when
> there are a lot of vCPUs. Let's just skip it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/i386/kvm/clock.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index aba6842a22..46efdbed14 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -207,7 +207,9 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
>   
>           s->runstate_paused = runstate_check(RUN_STATE_PAUSED);
>   
> -        kvm_synchronize_all_tsc();
> +        if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> +            kvm_synchronize_all_tsc();
> +        }
>   
>           kvm_update_clock(s);
>           /*


-- 
Best regards,
Vladimir


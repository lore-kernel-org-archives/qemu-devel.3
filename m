Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B969BCCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 07:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJRKn-0005wB-Q9; Thu, 13 Nov 2025 02:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJRKc-0005tb-EZ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:01:28 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJRKZ-0005cu-Bq
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 02:01:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 94B4083299;
 Thu, 13 Nov 2025 10:01:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:833::1:4] (unknown [2a02:6bf:8080:833::1:4])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G1KSAF0FEmI0-mqrwgXR3; Thu, 13 Nov 2025 10:01:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763017277;
 bh=spLYecOGM5CMy/QG+xHvANDb1FOsi0Ae8uMMMf4lgqU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Rp6WHufvbbUIfX7VH/Nb7f75o35E+1SBG/ogmX7fhNYQ9a4G0aLk9cLXHXbYb5dRG
 4uA0NdiQh6ykV4M5dPbAymltTv4ABchE+JKROm4MIagT5D+75mkGk4ZE7f8+3WkbIX
 L2d+nX1wanZ2rwaj893sAuHVgQ9zQoXe2q+WzJQQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a5bfcf63-d7d8-429c-b189-a927986f8e51@yandex-team.ru>
Date: Thu, 13 Nov 2025 10:01:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] qapi: net: deprecate vhostforce option
To: jasowang@redhat.com
Cc: devel@lists.libvirt.org, eblake@redhat.com, armbru@redhat.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20251028152400.45938-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251028152400.45938-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

ping

Could this still be taken to 10.2? Or I have to resend with 11.0 numbers?

On 28.10.25 18:23, Vladimir Sementsov-Ogievskiy wrote:
> This option for tap and vhost-user netdevs doesn't make sense
> since long ago (10 years!), starting from commits:
> 
>   1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>   24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
> 
> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
> some specific kind of guests (that don't have MSI-X support), you should
> have set vhostforce=on.
> 
> Now guest type doesn't matter, all guests are equal for these
> options logic.
> 
> For tap the current logic is:
>    vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>    vhost unset : vhostforce counts, enabling vhost
> 
> So you may enable vhost for tap several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
> 
> - they are all equal.
> 
> For vhost-user we simply ignore the vhostforce option at all in the
> code.
> 
> Let's finally deprecate the extra options.
> 
> Also, fix @vhostforce documentation everywhere to show the real picture,
> and update vhost-user test to not use deprecated option.
> 
> While updating command line options, drop "experimental" word from
> "experimental in kernel accelerator". vhost-net is in production for
> years.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir


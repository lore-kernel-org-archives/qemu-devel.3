Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7939BC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJV7-00014K-9I; Thu, 16 Jul 2026 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkJV5-00014B-Uc
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:39:31 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wkJV3-0007Tj-Ce
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:39:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id CC25380691;
 Thu, 16 Jul 2026 13:39:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id OdOcxu0aAmI0-smdfkh46; Thu, 16 Jul 2026 13:39:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784198365;
 bh=t/6MzCE1iGFAU/lvKhfBZFAGDZ56qK2CP2nPO/pnf04=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qw8FUPbiUDuD2YUA4AwH7f64P9rIjx+FMgchbKdiq8PawGROzqKvltVHZhLUAla/g
 +dp6szsCXEelpqBph0TvSX8VKZ7qMNvgGfCZa3lDE5jn/ryZrdc4uDnfPjNpJVdE3o
 XlJoH5YRFWail4/3o/FHSS8aIrMKEqlpd59W7lpI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3dd53cb0-b4f9-4f1c-9d47-7fe28a872d52@yandex-team.ru>
Date: Thu, 16 Jul 2026 13:39:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] vhost refactoring and fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
 <20260715184145-mutt-send-email-mst@kernel.org>
 <89ef906d-56d3-40cd-bce4-5636dd963eee@yandex-team.ru>
 <20260716012417-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260716012417-mutt-send-email-mst@kernel.org>
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

On 16.07.26 08:25, Michael S. Tsirkin wrote:
> On Thu, Jul 16, 2026 at 02:27:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 16.07.26 01:41, Michael S. Tsirkin wrote:
>>> On Wed, May 27, 2026 at 09:16:01AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all. That's a preparation for vhost-user-blk backend-transfer
>>>> feature.
>>>>
>>>> 07: rebase on master,
>>>> 04: drop extra occurence of system_virtio_ss.add(files('vhost-user-stub.c'))
>>> so patch 10 is the fix?
>> Probably it's too late :/ I don't understand, what do you mean). Patch 10 is a
>> fix yes. But seems it has no relation to vhost-user-stub.c ?
> the patchset is big. I am debating with myself when to merge it.
> Is it possible to just apply fixes an cleanups later?

But you've already merged this patchset, see commits c549dca2f27..2d5e87062b6 :)

-- 
Best regards,
Vladimir


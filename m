Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29727C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjxGn-0002FU-Es; Wed, 15 Jul 2026 06:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjxGl-0002En-8R; Wed, 15 Jul 2026 06:55:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjxGi-0004s3-Dg; Wed, 15 Jul 2026 06:55:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 37AC680848;
 Wed, 15 Jul 2026 13:55:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c75::1:c] (unknown [2a02:6bf:8080:c75::1:c])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 7tNXJV2ZhuQ0-QCr0cind; Wed, 15 Jul 2026 13:55:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784112907;
 bh=eiQb09gJ+OqzeGLiiQOm0HQJB09t91FGn7S9MBc563o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Oa4Gp/1k1I031oyAbnkJLY2xkb/sk0wgFD3HXtYKuqJs/I/ebLKyZhvCYF9rvLSX4
 K/3SbrcAd4tyAEfi6AeW4NqCWwZHR72PNz1qtICNXmNQ7zQRVPoTYOk2eFCoEJgKEK
 uEjiKa+mGGUk/M1fxjX4TOqQirM/9Am+Rn/SPZ2o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ef1b14ef-02d3-47f0-9d85-aea43cb8133b@yandex-team.ru>
Date: Wed, 15 Jul 2026 13:55:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iotests/migrate-bitmaps-postcopy-test: replace the
 timing assertion with a content check
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260715103451.1930909-1-den@openvz.org>
 <20260715103451.1930909-4-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260715103451.1930909-4-den@openvz.org>
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

On 15.07.26 13:34, Denis V. Lunev wrote:
> `downtime * 10 < postcopy_time` was an unnormalized wall-clock
> heuristic (commit e80a4150a5) that fails on fast hosts, where the
> bitmap payload now transfers in under a second.
> 
> Check the actual invariant instead: right after RESUME, bitmap0's
> content hash on the destination must not yet match the fully
> migrated value. Throttle max-bandwidth first, since all-zero chunks
> skip the payload write and would otherwise let a fast host finish
> the transfer before the check runs.
> 
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Kevin Wolf<kwolf@redhat.com>
> CC: Hanna Reitz<hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


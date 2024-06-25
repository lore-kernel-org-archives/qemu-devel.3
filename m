Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E7DC30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM7BJ-0005wj-CK; Tue, 25 Jun 2024 10:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM7BG-0005vs-J6; Tue, 25 Jun 2024 10:29:58 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sM7BD-0006n5-JD; Tue, 25 Jun 2024 10:29:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 251A0617CA;
 Tue, 25 Jun 2024 17:29:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lTQv4L0rLCg0-TmT3ux06; Tue, 25 Jun 2024 17:29:47 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719325787;
 bh=ohP9RXTU851+6acKXPHcwU/4iEDZmHvLs3ozWX5chV8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PKBmYgftGjuLM00MtG/Vwog1Py5AZSb0fZfR1B7R1tGZJ9eqIffBhWH5B+GYXYTWM
 vX+iXz1HazRyo+ucU1W3cN78qdAARH4ViI12nuUXgXusSERBE6yyu2D+KHy0lEaURm
 tVi2zuyQmLvEUpWHKmKUTmR1JgNsVDEN5lz5hIss=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f0c72d01-bdbf-4165-b6a6-b6f050e6b58c@yandex-team.ru>
Date: Tue, 25 Jun 2024 17:29:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: add hotplug_blk test
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, crosa@redhat.com, philmd@linaro.org,
 wainersm@redhat.com, bleal@redhat.com, yc-core@yandex-team.ru
References: <20240409065854.366856-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240409065854.366856-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
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

ping2

On 09.04.24 09:58, Vladimir Sementsov-Ogievskiy wrote:
> Introduce a test, that checks that plug/unplug of virtio-blk device
> works.
> 
> (the test is developed by copying hotplug_cpu.py, so keep original
> copyright)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



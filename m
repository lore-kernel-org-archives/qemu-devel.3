Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67716C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JPH-00072o-Oi; Wed, 09 Sep 2026 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x4JPG-00072W-4W; Wed, 09 Sep 2026 10:36:10 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x4JPD-0003d0-38; Wed, 09 Sep 2026 10:36:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id AC8CC80794;
 Wed, 09 Sep 2026 17:35:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:4d::1:17] (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xZPm217Xb8c0-OwjfhV1k; Wed, 09 Sep 2026 17:35:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788964559;
 bh=0YW0BlX0gcnrZ13W/2GWeoBmnpNzrIErPodwZhD8bw0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ua3wIWaEfhIPb6Zdwe3rcem7zVZROxkuQqG27V4wnPvcbbf3EMaLg1mDCjmjZkbrm
 W5MIoJaJ4nBYEDeP7s7w111BmbN3Ar4PIxFtFHbEZR2iP7VvFwls8fubChRYnjr3Hm
 FObENS10qN4HRLHqFefjQr6J+7nUYUMrrORzA2rU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <51cd62fc-e117-4247-9bf9-cb1781b9baa8@yandex-team.ru>
Date: Wed, 9 Sep 2026 17:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/25] tests: Add parallels format support to
 image-fleecing
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260903144143.2328870-1-den@openvz.org>
 <20260903144143.2328870-26-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260903144143.2328870-26-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
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

On 03.09.26 17:41, Denis V. Lunev wrote:
> From: Denis V. Lunev<den@openvz.org>
> 
> Use a different bitmap name for parallels images, as the format has its
> own ID format and can not hold an arbitrary string.
> 
> Replace the hardcoded 'qcow2' target format with iotests.imgfmt.
> 
> Add 'parallels' to the supported formats.
> 
> Based on the original work from Alexander Ivanov.
> 
> Cc: Stefan Hajnoczi<stefanha@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Signed-off-by: Denis V. Lunev<den@openvz.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


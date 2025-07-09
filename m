Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B51C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 14:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVyT-0004Uv-I2; Wed, 09 Jul 2025 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uZVxn-0004Dq-GT; Wed, 09 Jul 2025 10:40:01 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uZVxk-0004HP-K1; Wed, 09 Jul 2025 10:39:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3c8c:0:640:20c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A9F8E60A49;
 Wed,  9 Jul 2025 17:39:48 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:868::1:7] (unknown [2a02:6bf:8080:868::1:7])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kdj0WR0GoOs0-lu3Pcdlm; Wed, 09 Jul 2025 17:39:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752071988;
 bh=ZzeHtb1KWMpaMk/+8dtADtxvspkhGe8LuXmfAShNJnE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RtxxCRpu4ecfin0nM5dkHM5l6FcFRp+SjCGS/BpcvmjMzxaVmfh3nU/Ec5stXFyfG
 DgnBZiffoJuDFsOW0CbK8K36TvJOlnpbTudHgC9DXzUipHCdbN7Q7HAZP87snM9/hi
 O4TqN5D22o9gnzkA2Rra8DqpulAgP66+kJ3mwd1g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2f112a12-367a-4f81-914e-bc899bab608c@yandex-team.ru>
Date: Wed, 9 Jul 2025 17:39:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost: drop backend_features
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: qemu-block@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 jasowang@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, raphael@enfabrica.net
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
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

ping:)

On 03.07.25 15:47, Vladimir Sementsov-Ogievskiy wrote:
> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.
> 
> Vladimir Sementsov-Ogievskiy (4):
>    vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>    vhost-user: stop use backend_features
>    vhost_net: stop use backend_features
>    hw/vhost: finally drop vhost_dev.backend_features field
> 
>   hw/block/vhost-user-blk.c         |  1 -
>   hw/net/vhost_net.c                | 14 ++++++--------
>   hw/scsi/vhost-scsi.c              |  1 -
>   hw/scsi/vhost-user-scsi.c         |  1 -
>   hw/virtio/vdpa-dev.c              |  1 -
>   hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
>   hw/virtio/vhost.c                 | 15 ++++++---------
>   hw/virtio/virtio-qmp.c            |  2 --
>   include/hw/virtio/vhost-backend.h |  2 ++
>   include/hw/virtio/vhost.h         |  7 -------
>   10 files changed, 30 insertions(+), 39 deletions(-)
> 

-- 
Best regards,
Vladimir



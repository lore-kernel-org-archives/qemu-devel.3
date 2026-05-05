Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C7FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCvs-00047C-Rs; Tue, 05 May 2026 06:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCvr-00046d-0e
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:23:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wKCvp-00008U-7o
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:23:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A190A807B3;
 Tue, 05 May 2026 13:23:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:78a::1:25] (unknown
 [2a02:6bf:8080:78a::1:25])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 9NdEuC0MA0U0-7WDaiVyt; Tue, 05 May 2026 13:23:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1777976590;
 bh=v4M76tyh2LIdaOwIiIqp6qE/qoa3L5W/vBQ318n8wyg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OAC9GkroCEGEsIquKqNTSIws4nTGozOF1wJELinGEWMutdpQwcRxNd79Z6665vrBU
 /QX/r+QXQGbywcyJ+wjosMvWCktAA0Gj3+tv/5qPUS3yGQ1/Xk38ml6BHndcq88xI1
 NdT7YzmGKnleK9yYLhq+jX2XT81yCgtQdVIvhJME=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <84f7da3d-bd1f-440c-a0b0-b9999bc96376@yandex-team.ru>
Date: Tue, 5 May 2026 13:23:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] vhost-user: VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
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

ping

On 20.04.26 23:20, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a new feature to pass GPA addresses instead of UVA
> to vhost-user server from QEMU. The details are in last patch
> 10/10 the others are preparation and refactoring.
> 
> v2:
> 06: reword commit message
> 
> Based-on: <20260420200339.708640-1-vsementsov@yandex-team.ru>
>     "[PATCH v6 00/22] vhost refactoring and fixes"
> 
> Vladimir Sementsov-Ogievskiy (10):
>    vhost: move IOTLB functions from vhost-backend.c to vhost.c
>    vhost: use consistent naming for backend handlers
>    vhost: rename vhost-backend.c to vhost-kernel.c
>    vhost: replace .vhost_vq_get_addr() with .vhost_phys_vring_addr()
>    vhost: simplify vhost_memory_map() and vhost_memory_unmap()
>    qapi: remove user addresses from x-query-virtio-vhost-queue-status
>    vhost: stop reusing vq->desc (and friends) to store physical address
>    vhost: rename vring pointer fields to reflect user addresses
>    vhost: add .vhost_phys_iotlb_msg() handler
>    vhost-user: add VHOST_USER_PROTOCOL_F_GPA_ADDRESSES
> 
>   docs/interop/vhost-user.rst                   |  21 +-
>   hw/virtio/meson.build                         |   2 +-
>   hw/virtio/{vhost-backend.c => vhost-kernel.c} |  90 +-------
>   hw/virtio/vhost-user.c                        |  32 ++-
>   hw/virtio/vhost-vdpa.c                        |  19 +-
>   hw/virtio/vhost.c                             | 193 +++++++++++++-----
>   hw/virtio/virtio-hmp-cmds.c                   |   3 -
>   hw/virtio/virtio-qmp.c                        |   3 -
>   include/hw/virtio/vhost-backend.h             |  37 ++--
>   include/hw/virtio/vhost-user.h                |   1 +
>   include/hw/virtio/vhost.h                     |   8 +-
>   qapi/virtio.json                              |  15 --
>   12 files changed, 210 insertions(+), 214 deletions(-)
>   rename hw/virtio/{vhost-backend.c => vhost-kernel.c} (83%)
> 


-- 
Best regards,
Vladimir


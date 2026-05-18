Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD740CD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwFB-00081x-Te; Mon, 18 May 2026 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwF4-0007z6-1u
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:34:38 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wOwF2-0005h4-Cc
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:34:37 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 974CF80799;
 Mon, 18 May 2026 14:34:32 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b95::1:20] (unknown
 [2a02:6bf:8080:b95::1:20])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id VYOXO04LuGk0-jYYRx5Et; Mon, 18 May 2026 14:34:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779104072;
 bh=SleAMGeVC29wze3qO4rAL9He2doUaKg8FG/D3x4jn1k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=N93OVdXv4UVxR6TnJ9E+A0TVACOOkxj0EorhtFJIlUhdlPA3KAdobvNGt86YLs1Fd
 NvIjK6m58OZXp94NTMPyX3JuEjMky1R2fX/1EM8cbLU7buH8fLTO+dMusN84rDrH6N
 EEnuVVtK9oBCTQkUsLQREKZQ1ZuBTI6ppqfrL/ps=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fa70e2bc-1286-4ff0-9de5-81caafdf956a@yandex-team.ru>
Date: Mon, 18 May 2026 14:34:31 +0300
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


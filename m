Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC487CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeeX-0002Ke-U5; Fri, 02 Oct 2026 10:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCeeF-0002Fs-UH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:54:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCeeC-0004RZ-Tp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:54:07 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 692ErMhA057176
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Oct 2026 23:53:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tlDHkHzguE5+h3w/7LtxOPCuucDwFmlthDMq86DA9HM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790952802; v=1;
 b=R5TIz1tlPWsRxMMuxG+2UZJw1m3tsiClMqXxenveVr//ddhzO51QAp2P9bBfB9I4
 b84ftRJz9OJGC95Aty6a06KUXrNQLXOxeKBxv9O588ggSmnVCJVt7XVOyAiTMDJA
 IuGVvyuF3JBuEBnd7oR8Gu4bRhs2ZIRArq5w8kFiWF84mFk96QFclGYUKvUhZUTl
 CkLGY9g0HeKj8rkujDuga8H+De6rv4wVs530rBx9oB3CG6UTjxVWvHnfuSBdS+js
 V11oik7dBrGTkEv28iwGG/tSEHSRk9NxgCDnyqQ0w4w71k3xYh0F4N6CoUkgILqn
 F+ApIztcVUW2IAnvgoxwqA==
Message-ID: <674e4907-1065-42a3-838e-400d369ed28e@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 2 Oct 2026 23:53:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 16/19] vhost: release ownership on exit
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, dongli.zhang@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org,
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org,
 peterx@redhat.com, clg@redhat.com
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
 <20261002-up-vsock-vhost-v5-v11-16-18fa09d8273d@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-16-18fa09d8273d@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/02 22:02, Andrey Drobyshev wrote:
> A CPR target that has taken the device ownership in post_load() doesn't
> always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
> truncated migration stream footer, makes QEMU exit() right away, and the
> ownership stays with the dead process.  The source still holds the FD,
> so the kernel never releases the device, and the source can't take it
> back after being resumed -> SET_OWNER fails with EBUSY.
> 
> Add an exit notifier to each vhost_dev, registered for its lifetime,
> that releases the ownership if still held.  This covers every orderly
> exit, which is every failure QEMU detects itself.  A target killed with
> SIGKILL or crashing still leaves the device unrecoverable.

With return-path enabled, incoming failure first sends "SHUT" with 
migrate_send_rp_shut(). The source can automatically resume before the 
notifier runs, receive EBUSY, and leave vsock stopped while the guest runs.

Regards,
Akihiko Odaki

> 
> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   hw/virtio/vhost.c         | 22 ++++++++++++++++++++++
>   include/hw/virtio/vhost.h |  3 +++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1241c5a954d..60cbb763e35 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -30,6 +30,7 @@
>   #include "system/dma.h"
>   #include "system/memory.h"
>   #include "system/ramblock.h"
> +#include "system/system.h"
>   #include "trace.h"
>   
>   /* enabled until disconnected backend stabilizes */
> @@ -53,6 +54,21 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>   static QLIST_HEAD(, vhost_dev) vhost_devices =
>       QLIST_HEAD_INITIALIZER(vhost_devices);
>   
> +/*
> + * Release the ownership of the vhost devices still held at exit(), so that
> + * another process sharing the backend FDs (e.g. the CPR source) can take
> + * them over.
> + */
> +static void vhost_exit_notify(Notifier *notifier, void *data)
> +{
> +    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
> +                                          exit_notifier);
> +
> +    if (hdev->owner) {
> +        vhost_dev_reset_owner(hdev);
> +    }
> +}
> +
>   unsigned int vhost_get_max_memslots(void)
>   {
>       unsigned int max = UINT_MAX;
> @@ -1823,6 +1839,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>       hdev->log_enabled = false;
>       hdev->started = false;
>       memory_listener_register(&hdev->memory_listener, &address_space_memory);
> +    hdev->exit_notifier.notify = vhost_exit_notify;
> +    qemu_add_exit_notifier(&hdev->exit_notifier);
>       QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>   
>       /*
> @@ -1872,6 +1890,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>           memory_listener_unregister(&hdev->memory_listener);
>           QLIST_REMOVE(hdev, entry);
>       }
> +    if (hdev->exit_notifier.notify) {
> +        qemu_remove_exit_notifier(&hdev->exit_notifier);
> +        hdev->exit_notifier.notify = NULL;
> +    }
>       migrate_del_blocker(&hdev->migration_blocker);
>       g_free(hdev->mem);
>       g_free(hdev->mem_sections);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index f6e32b59ab2..6bd19d1d51b 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -3,6 +3,7 @@
>   
>   #include "net/vhost_net.h"
>   #include "hw/virtio/vhost-backend.h"
> +#include "qemu/notify.h"
>   #include "hw/virtio/virtio.h"
>   #include "system/memory.h"
>   
> @@ -116,6 +117,8 @@ struct vhost_dev {
>        * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
>        */
>       bool owner;
> +    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
> +    Notifier exit_notifier;
>       bool log_enabled;
>       uint64_t log_size;
>       Error *migration_blocker;
> 



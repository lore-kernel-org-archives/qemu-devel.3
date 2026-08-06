Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2446AC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wry3r-0000tI-0M; Thu, 06 Aug 2026 09:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wry3p-0000sp-Jf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wry3n-00042C-5k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 09:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786022577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dH1XONBzF/dcAZygzTRXwWLECWAcOVXoW7W1sMU8SAY=;
 b=MI3cC8t5PzfdVmVj5AUD3idnEMGDqQsjsJ70cR1FfuG/RrQdbiTG26zXa4xkfFdQJWyCVR
 Txk+wsDFT7npqTIP/sC66WlaqfUM5D1vy28qn7XhUrysgiSd1Q1O67cPXvhOzGzi9RAWo3
 7rsJuzcIAhhb4Sc9sOE5ZgaRLxwsFlQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-qw6inMJEPD-4KdnoXz2kWQ-1; Thu, 06 Aug 2026 09:22:55 -0400
X-MC-Unique: qw6inMJEPD-4KdnoXz2kWQ-1
X-Mimecast-MFC-AGG-ID: qw6inMJEPD-4KdnoXz2kWQ_1786022575
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955e865174so11436445e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786022574; x=1786627374; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dH1XONBzF/dcAZygzTRXwWLECWAcOVXoW7W1sMU8SAY=;
 b=cCAuDiS9CJuUp4EOT2Bih8HqA+R3doDGrbYzgDysBxdGyTi6M88szWwEVn5E7uAIBV
 ZUO7I6VEgFfX7guwE5cnkrSoJO1+fm/agll0TVcVkRx4dIf4dsMz4/zEAhIIRdw5tLTk
 mEru/3HTZHtvxd2AIJCbIUXGRlP09mMwRveQP160kyGWDPEyqgRV0co0TxFox4+u3ThA
 6m9BNjzC5gMQS7KUFX5FTHWXf7aVHDVw+Y+tpD6r7yZVM7sza38LtmzuEOxw04pGfDIx
 mXGr+p8Pdch8ZbLSfUSDpA/wI4jRX7JdCJt0YTEVmAiIcuWrgpABD+hZO5GoYMSm54kt
 Bbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022574; x=1786627374;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dH1XONBzF/dcAZygzTRXwWLECWAcOVXoW7W1sMU8SAY=;
 b=GynHMeF7igENoP73fDudiGyrB9IIm40EUnEexkH69CI43C2iivknr6JzUND0WekQHz
 cqJTdcx/DJ2WOFUBc6T/iyTgl1LbWHi7r2XMphVni/UiXUwxQzZdK0gkrWy48KEiz30Z
 oSQQ/Fm5YNk+wwyq2mjrDNcpIQXAwqG1//6o8S2obV/bKrkAyU92471BeH03Esqh+WvQ
 cKkIZZT0THLLzfA0OIxSLcs6UMSMbILToPR05F4Ndb7E3j9HnmPThUgefg/DUXVIjFF1
 zdh368BBwQ1aQCqFosh5koB5yPSJ8iKiAODuDunFQLDpBI2Aqwqd1dpVyNgS9OKd4Jrs
 CvaA==
X-Gm-Message-State: AOJu0Yye5xpyNSUTAbX21IPrt3aC7M87r10V0DMp/moggSzwmqnqy7Sw
 3I3QMj0WYffEFijynygLnHsyG6KLH7FwATm/8jDCfa3c4653V7a8FdCadaQ845TrdYNmNmROoOH
 kKBEIzJh0wknVK0Q5daCqIc34OfVp9R6zrjJFfcliM46bunmQs+7E7QXh
X-Gm-Gg: AR+sD10KkR05TAIj8c2x5ceQr1R8lRFpjFdIp85WjLDkMeyWsE5rWBqNU1S9mtfXhxn
 5al17uw7uKYbrnqjG3IoaU0bylmYLzMf0R2XeKbDfLgELMiTCubXAeR0PO5grPL+t7aQfmUzeuv
 W26MF9F1conD7LWQct4iIvqnsKGMQ3sbXv01yGampJ+hI3gBlXVl4vN9m3tdsJN8lCLPJYxNQo+
 Vzv7ymrsJBM5DpyN6zgj40DD2ZMMWtnj7ETNNlWgYK+oPNAhMAVdJFvmOmir8tQrAuGnJ66kNDg
 7Sx+tF7tsZ33sfCNtTOJsR74CaAVujwMBizvr5wo/KtEKN4L26pRyGau4U/wsPyJ1oOWryiQL9k
 ESvg=
X-Received: by 2002:a05:600d:8492:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4994e7baa73mr139883905e9.11.1786022574546; 
 Thu, 06 Aug 2026 06:22:54 -0700 (PDT)
X-Received: by 2002:a05:600d:8492:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4994e7baa73mr139883165e9.11.1786022574067; 
 Thu, 06 Aug 2026 06:22:54 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b25c01sm5867310f8f.29.2026.08.06.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:22:53 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:22:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "aesteve@redhat.com" <aesteve@redhat.com>
Subject: Re: [PATCH] vhost-user: check memory slot availability for SHMEM_MAP
Message-ID: <anSKEbnzeJQXFKqy@sgarzare-redhat>
References: <mjOOKQpuMIz6MQIV5bwxAVsdiCHcF7CelDcVbte7RE5ehci9d4UsTCx2e4EdvRa2FYpryaZuX_gdEkhek7cL7TawBkicooZYlzmMYTEtPvg=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <mjOOKQpuMIz6MQIV5bwxAVsdiCHcF7CelDcVbte7RE5ehci9d4UsTCx2e4EdvRa2FYpryaZuX_gdEkhek7cL7TawBkicooZYlzmMYTEtPvg=@proton.me>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 05:36:37AM +0000, Feifan Qian wrote:
>SHMEM_MAP creates a separate RAM MemoryRegion for every mapping. It can
>therefore make a vhost-user memory table exceed the number of slots
>negotiated with the backend. The region reconciliation code then indexes
>fixed-size bookkeeping arrays past their end.
>
>Reject a mapping before changing the memory topology if KVM or a vhost
>backend has no unreserved slot left. Also validate each memory table
>against the negotiated vhost-user limit as a final defense for mappings
>that become visible in a later memory transaction.
>
>Fixes: b52e1896e764 ("vhost-user: Add VirtIO Shared Memory map request")
>Signed-off-by: Feifan Qian <bea1e@proton.me>
>---
>Tested with an ASan/UBSan x86_64 build and a vhost-user backend that
>mapped one-page SHMEM regions up to the 512-slot limit. The next
>SHMEM_MAP request was rejected and QEMU remained alive. Before this
>patch, the same reproducer reported an out-of-bounds write at found[512]
>in scrub_shadow_regions(). qtest-x86_64/qos-test also passed all 140
>subtests.
>
>hw/virtio/vhost-user.c | 18 ++++++++++++++++++
>1 file changed, 18 insertions(+)


This patch is corrupted:

$ git am ./20260720_bea1e_vhost_user_check_memory_slot_availability_for_shmem_map.mbx
Applying: vhost-user: check memory slot availability for SHMEM_MAP
error: corrupt patch at /home/stefano/repos/qemu/.git/worktrees/qemu-review/rebase-apply/patch:18
Patch failed at 0001 vhost-user: check memory slot availability for SHMEM_MAP

And the maintainer is not CCed:
$ ./scripts/get_maintainer.pl -f hw/virtio/vhost-user.c
"Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost, gitlab:@mstredhat)
Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost, gitlab:@sgarzarella)
qemu-devel@nongnu.org (open list:All patches CC here)

Please fix it.

Stefano

>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index 517cc4ca71..7f141c116b 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -10,6 +10,7 @@
>
>#include "qemu/osdep.h"
>#include "qapi/error.h"
>+#include "hw/mem/memory-device.h"
>#include "hw/virtio/virtio-dmabuf.h"
>#include "hw/virtio/virtio-qmp.h"
>#include "hw/virtio/vhost.h"
>@@ -1123,6 +1124,13 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
>int ret;
>
>+ if (mem->nregions > u->user->memory_slots) {
>+ error_report("vhost-user memory table has %u regions, "
>+ "but the backend supports only %d",
>+ mem->nregions, u->user->memory_slots);
>+ return -ENOSPC;
>+ }
>+
>if (do_postcopy) {
>/*
>* Postcopy has enough differences that it's best done in it's own
>@@ -1937,6 +1945,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>VhostUserMMap *vu_mmap = &payload->mmap;
>VirtioSharedMemoryMapping *existing;
>Error *local_err = NULL;
>+ unsigned int reserved_memslots;
>int ret = 0;
>
>if (fd < 0) {
>@@ -1977,6 +1986,15 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
>}
>}
>
>+ reserved_memslots = memory_devices_get_reserved_memslots();
>+ if ((kvm_enabled() &&
>+ kvm_get_free_memslots() <= reserved_memslots) ||
>+ vhost_get_free_memslots() <= reserved_memslots) {
>+ error_report("No free memory slots for shared memory mapping");
>+ ret = -ENOSPC;
>+ goto send_reply;
>+ }
>+
>memory_region_transaction_begin();
>
>/* Create VirtioSharedMemoryMapping object */
>--2.43.0



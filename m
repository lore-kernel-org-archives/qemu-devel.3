Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D3DC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMngt-0007Ue-6r; Wed, 04 Jun 2025 08:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMngr-0007U3-Fq
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMngp-0000Tj-PZ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749041873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSpNlgmj5ReO4/tbnxW3Q0hUhOIn5Ivq0W0vFq3MdeY=;
 b=jIIYLjwutR8sJiPuYLOWlcckQa8nKY8NOmdrPYU7jbDZqJYntyEI02372tICT927oVl4pm
 td7doJy69JgLCjetJY0dRrmeEY2hkd6kbgi3iWDWLGiGFp9bGM7NEj6JAvRPAZEJFLy0y1
 Dd3dtfkDqKN9+gmaVqcJu6z9dY6IN9I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-n7d0-N_2OZqkmOixoKXh8w-1; Wed,
 04 Jun 2025 08:57:50 -0400
X-MC-Unique: n7d0-N_2OZqkmOixoKXh8w-1
X-Mimecast-MFC-AGG-ID: n7d0-N_2OZqkmOixoKXh8w_1749041869
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED17E1800DA5; Wed,  4 Jun 2025 12:57:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8733B180045B; Wed,  4 Jun 2025 12:57:45 +0000 (UTC)
Date: Wed, 4 Jun 2025 14:57:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com
Subject: Re: [PATCH v2] hw/core/qdev-properties-system: Add missing return in
 set_drive_helper()
Message-ID: <aEBCxwfX7QQue1FB@redhat.com>
References: <20250523070211.280498-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523070211.280498-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.05.2025 um 09:02 hat Fiona Ebner geschrieben:
> Currently, changing the 'drive' property of e.g. a scsi-hd object will
> result in an assertion failure if the aio context of the block node
> it's replaced with doesn't match the current aio context:
> 
> > bdrv_replace_child_noperm: Assertion `bdrv_get_aio_context(old_bs) ==
> > bdrv_get_aio_context(new_bs)' failed.
> 
> The problematic scenario is already detected, but a 'return' statement
> was missing.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d1a58c176a ("qdev: allow setting drive property for realized device")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
> 
> Changes in v2:
> * Add missing condition in commit message, sorry for the noise!

Thanks, applied to the block branch.

But while we're here...

> Reproducer:
> 
> #!/bin/bash
> rm /tmp/disk0.raw
> rm /tmp/disk1.raw
> ./qemu-img create -f raw /tmp/disk0.raw 1G
> ./qemu-img create -f raw /tmp/disk1.raw 1G
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev file,node-name=node0,filename=/tmp/disk0.raw \
> --blockdev file,node-name=node1,filename=/tmp/disk1.raw \
> --nodefaults \
> --object 'iothread,id=iothread0' \
> --device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.0,addr=0x3,iothread=iothread0' \
> --device 'scsi-hd,bus=virtioscsi0.0,scsi-id=1,drive=node0,id=scsi0' \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "qom-set", "arguments": { "path": "/machine/peripheral/scsi0", "property": "drive", "value": "node1" } }
> {"execute": "quit"}
> EOF

...could you put this in a qemu-iotests case as a follow-up? It looks
like we don't have a proper test for qom-set on drive properties yet.

>  hw/core/qdev-properties-system.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 8e11e6388b..24e145d870 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -145,6 +145,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
>          if (ctx != bdrv_get_aio_context(bs)) {
>              error_setg(errp, "Different aio context is not supported for new "
>                         "node");
> +            return;
>          }
>  
>          blk_replace_bs(blk, bs, errp);

While this is the trivial fix for what was originally meant, I'm not
sure if that's the best way to handle the situation. I would have
expected that we do something similar as in bdrv_attach_child_common()
and try to move @bs into @ctx before failing.

Nowadays, even on failure to move @bs, we don't strictly have to error
out any more since the backends are properly multithreaded. But we
haven't made that change even to bdrv_attach_child_common() yet. I
wonder if we should only do that with a force option.

We don't have to address this now, but it probably doesn't hurt to think
a bit about what we want it to look like in the long run.

Kevin



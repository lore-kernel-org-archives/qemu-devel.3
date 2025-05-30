Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C822DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1mR-0005bw-4f; Fri, 30 May 2025 11:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uL1mO-0005aY-64
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uL1mL-0007qE-8y
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748619375;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jC7uuDpESgrNUNJVV/aX9HFvrUX3I6immadlD3/Sjos=;
 b=EvhLDBKF2Rd4DdUvuNwDbnY9RD4iN2IKhA+bPMhTGcyqgRdfMIZKqdToRlqrmdrR30TbGO
 2LjldPOgta3zsLXBWOPM72hchl8EALakkTiknWhlE2CU2bMOsw1/XfLWMrqysnr0NLlhsW
 nQAzY6dv//ltiObPtMHDl9BAZCLvTIY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-pi2T0dbOPq6xsQE-i_d1LQ-1; Fri,
 30 May 2025 11:36:12 -0400
X-MC-Unique: pi2T0dbOPq6xsQE-i_d1LQ-1
X-Mimecast-MFC-AGG-ID: pi2T0dbOPq6xsQE-i_d1LQ_1748619371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDDAA1800446; Fri, 30 May 2025 15:36:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B017180049D; Fri, 30 May 2025 15:36:06 +0000 (UTC)
Date: Fri, 30 May 2025 16:36:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, eduardo@habkost.net,
 pbonzini@redhat.com, vsementsov@virtuozzo.com
Subject: Re: [PATCH v2] hw/core/qdev-properties-system: Add missing return in
 set_drive_helper()
Message-ID: <aDnQYxtZH_SSxbcX@redhat.com>
References: <20250523070211.280498-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250523070211.280498-1-f.ebner@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Copying block maintainers, since while this is in QOM source files, this 
method is defacto block layer code.

On Fri, May 23, 2025 at 09:02:11AM +0200, Fiona Ebner wrote:
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
> 
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
> 
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



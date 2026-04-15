Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA1F4198F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxnU-0007Om-9v; Wed, 15 Apr 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCxnO-0007NQ-Dr
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 06:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCxnM-00021F-57
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 06:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776250109;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LYCcWmujtaVNu8EAtGMpINZJnIDO9rRBAkKGjC8bcGM=;
 b=i/TlOvbfSQegsWFpakhaN5+fAsmrQ47PwuaWZ/y1T6My+0d8uxLvAmNwSBOoI/zfBHsU7E
 kRYKiKL2oHGyCPtM9KNKG0dvPdCNKcvB4XFxeY6w8x1/HS1jm4MPXxqVtSAqtaOMgukxpU
 i6MpQhihA/Zf+K3OTtpcChn/180s2rg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-bNcuzSeaM4WopgOqrV-oPg-1; Wed,
 15 Apr 2026 06:48:27 -0400
X-MC-Unique: bNcuzSeaM4WopgOqrV-oPg-1
X-Mimecast-MFC-AGG-ID: bNcuzSeaM4WopgOqrV-oPg_1776250106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBCB418005A8; Wed, 15 Apr 2026 10:48:25 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8702430001A4; Wed, 15 Apr 2026 10:48:23 +0000 (UTC)
Date: Wed, 15 Apr 2026 11:48:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, stefanha@redhat.com, mr-083 <matthieu@min.io>
Subject: Re: [PATCH 2/2] block/monitor: add drive_insert HMP command
Message-ID: <ad9s9CRT0niUAPQn@redhat.com>
References: <20260409060155.94704-1-matthieu@min.io>
 <20260409060155.94704-3-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409060155.94704-3-matthieu@min.io>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 09, 2026 at 08:01:54AM +0200, mr-083 wrote:
> Add a drive_insert HMP command that reconnects a host block device file
> to an existing guest device whose backing store was previously removed
> with drive_del.
> 
> After drive_del, the BlockBackend remains attached to the guest device
> but has no BlockDriverState (shown as "[not inserted]" in info block).
> drive_insert opens the specified file, finds the device's BlockBackend
> by iterating all backends and matching the attached device ID, then
> calls blk_insert_bs() to reconnect the backing store.
> 
> This complements drive_del for non-removable devices (such as NVMe
> namespaces) where blockdev-change-medium cannot be used. Combined with
> PCIe AER Surprise Down error injection to trigger a controller reset,
> this enables complete NVMe disk hot-swap simulation where the guest
> sees the same device names throughout.
> 
> Example usage:
>   drive_del drv0             # remove backing store
>   drive_insert ns0 disk.qcow2  # reconnect backing
>   pcie_aer_inject_error rp0 SDN  # trigger controller reset
> 
> Signed-off-by: Matthieu Receveur <matthieu@min.io>
> ---
>  block/monitor/block-hmp-cmds.c | 59 ++++++++++++++++++++++++++++++++++
>  hmp-commands.hx                | 18 +++++++++++

I see v3 has dropped this new command, but in case you have plans
to re-introduce it..

First no new HMP-only commands please. Anything new must be implemented
in QMP, and the HMP must be a shim to the QMP.

drive_insert semantics are somewhat overloaded - it is doing two jobs,
first creating the block backend, and then associating the backend with
a device.  IMHO those tasks should be separate.  "drive_add" or
"blockdev-add" can already do the first task, so we shouldn't replicate
that. AFAICT, it would only need a way to do the backend/frontend
association, and possibly the PCI error injection should be done as
a standard part of that re-association of backends, which would avoid
the need for pcie_aer_inject_error which has no QMP impl currently.



>  include/block/block-hmp-cmds.h |  1 +
>  3 files changed, 78 insertions(+)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 1fd28d59eb..77e9662ead 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -38,7 +38,9 @@
>  #include "qemu/osdep.h"
>  #include "hw/core/boards.h"
>  #include "system/block-backend.h"
> +#include "system/block-backend-global-state.h"
>  #include "system/blockdev.h"
> +#include "block/block-global-state.h"
>  #include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-block-export.h"
>  #include "qobject/qdict.h"
> @@ -195,6 +197,63 @@ unlock:
>      hmp_handle_error(mon, err);
>  }
>  
> +void hmp_drive_insert(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id = qdict_get_str(qdict, "id");
> +    const char *filename = qdict_get_str(qdict, "filename");
> +    BlockBackend *blk = NULL;
> +    BlockBackend *iter;
> +    BlockDriverState *bs;
> +    Error *err = NULL;
> +
> +    GLOBAL_STATE_CODE();
> +
> +    /*
> +     * After drive_del, the BlockBackend is removed from the monitor name
> +     * registry but still attached to the device. Find it by iterating all
> +     * BlockBackends and matching by the device ID shown in "info block".
> +     */
> +    for (iter = blk_all_next(NULL); iter; iter = blk_all_next(iter)) {
> +        DeviceState *dev = blk_get_attached_dev(iter);
> +        if (dev && dev->id && strcmp(dev->id, id) == 0) {
> +            blk = iter;
> +            break;
> +        }
> +    }
> +
> +    if (!blk) {
> +        /* Fallback: try by block backend name */
> +        blk = blk_by_name(id);
> +    }
> +
> +    if (!blk) {
> +        error_setg(&err, "Device '%s' not found", id);
> +        goto out;
> +    }
> +
> +    if (blk_bs(blk)) {
> +        error_setg(&err, "Device '%s' already has a medium inserted", id);
> +        goto out;
> +    }
> +
> +    bs = bdrv_open(filename, NULL, NULL, BDRV_O_RDWR, &err);
> +    if (!bs) {
> +        goto out;
> +    }
> +
> +    if (blk_insert_bs(blk, bs, &err) < 0) {
> +        bdrv_unref(bs);
> +        goto out;
> +    }
> +
> +    bdrv_unref(bs);
> +    monitor_printf(mon, "OK\n");
> +    return;
> +
> +out:
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_commit(Monitor *mon, const QDict *qdict)
>  {
>      const char *device = qdict_get_str(qdict, "device");
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5cc4788f12..79af8e8988 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -207,6 +207,24 @@ SRST
>    actions (drive options rerror, werror).
>  ERST
>  
> +    {
> +        .name       = "drive_insert",
> +        .args_type  = "id:B,filename:F",
> +        .params     = "device filename",
> +        .help       = "insert a host block device into an empty drive",
> +        .cmd        = hmp_drive_insert,
> +    },
> +
> +SRST
> +``drive_insert`` *device* *filename*
> +  Insert a host block device file into a drive that has been emptied by
> +  ``drive_del``.  This reconnects the backing store without removing the
> +  guest device, enabling transparent disk hot-swap for non-removable devices
> +  such as NVMe namespaces.  Combined with PCIe AER Surprise Down error
> +  injection (``pcie_aer_inject_error`` *device* ``SDN``), this enables
> +  complete NVMe disk hot-swap simulation.
> +ERST
> +
>      {
>          .name       = "change",
>          .args_type  = "device:B,force:-f,target:F,arg:s?,read-only-mode:s?",
> diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
> index 71113cd7ef..73c9607402 100644
> --- a/include/block/block-hmp-cmds.h
> +++ b/include/block/block-hmp-cmds.h
> @@ -21,6 +21,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
>  
>  void hmp_commit(Monitor *mon, const QDict *qdict);
>  void hmp_drive_del(Monitor *mon, const QDict *qdict);
> +void hmp_drive_insert(Monitor *mon, const QDict *qdict);
>  
>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
>  void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



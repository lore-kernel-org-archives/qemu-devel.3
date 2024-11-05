Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912E6D12663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Fa2-0004u3-QH; Tue, 05 Nov 2024 04:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8Fa1-0004ti-3b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8FZw-0002ub-D3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730797823;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=f1aiaNs18TmkxrAhZ2lXwaLhmSGV43qc9f5DssudXA0=;
 b=Wbrgn76e+UCA2wfSLaHXiQTD7CFKA/k0msrt9t1b+KMwrBIQOy9f30lOvSlNEIjZIYT20a
 fZ++nwI9vIp6/Y0VBwz5Pi0IY6GRD44wzL8LlepKI1a+D0/3VnuaGSzXWa5mh951artlPq
 GBHponMVnvqx8N/hN3JvNtb3WZ6ksF4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-sH82qbxxNBeAEUzneFGqxQ-1; Tue,
 05 Nov 2024 04:10:17 -0500
X-MC-Unique: sH82qbxxNBeAEUzneFGqxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FE8219560B6; Tue,  5 Nov 2024 09:10:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AB9E1956086; Tue,  5 Nov 2024 09:10:10 +0000 (UTC)
Date: Tue, 5 Nov 2024 09:10:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PULL 23/65] qapi: introduce device-sync-config
Message-ID: <Zyng7yk8zQ1MPx_s@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
 <3f98408e2e4fb1792102aed2cd5425aa0e34cc9c.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f98408e2e4fb1792102aed2cd5425aa0e34cc9c.1730754238.git.mst@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 04, 2024 at 04:07:00PM -0500, Michael S. Tsirkin wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Add command to sync config from vhost-user backend to the device. It
> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> triggered interrupt to the guest or just not available (not supported
> by vhost-user server).
> 
> Command result is racy if allow it during migration. Let's not allow
> that.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Raphael Norwitz <raphael@enfabrica.net>
> Message-Id: <20240920094936.450987-4-vsementsov@yandex-team.ru>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  qapi/qdev.json            | 24 ++++++++++++++++++++++++
>  include/hw/qdev-core.h    |  6 ++++++
>  hw/block/vhost-user-blk.c |  1 +
>  hw/virtio/virtio-pci.c    |  9 +++++++++
>  system/qdev-monitor.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+)
> 
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 53d147c7b4..2a581129c9 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -163,3 +163,27 @@
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>    'data': { '*device': 'str', 'path': 'str' } }
> +
> +##
> +# @device-sync-config:
> +#
> +# Synchronize device configuration from host to guest part.  First,
> +# copy the configuration from the host part (backend) to the guest
> +# part (frontend).  Then notify guest software that device
> +# configuration changed.
> +#
> +# The command may be used to notify the guest about block device
> +# capcity change.  Currently only vhost-user-blk device supports
> +# this.
> +#
> +# @id: the device's ID or QOM path
> +#
> +# Features:
> +#
> +# @unstable: The command is experimental.
> +#
> +# Since: 9.1
> +##

Again, we're in the 9.2 dev cycle currently.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



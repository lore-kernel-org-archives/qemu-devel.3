Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF40DC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWef-0005uF-DW; Tue, 30 Jun 2026 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weWeV-0005sm-Vd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1weWeU-00081i-1w
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782818956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LQZipDXQofwb6udttBXvsJ71Aka78BYTOANw6v5zEn0=;
 b=it1BFtSL2kTLHow6trOi+dq1Q6OMWLOjCxDsiZdFghtFZoIzqf3QGNIIsOSyvWXU3/Fxy+
 +jk6WqKBhvaj/3eJ3WncrzuRKKVAt1ooRPPvNXKlSxRsagC0STo/duFQdq1FHcG6pOiRyy
 uXA9HlvjgXNfVEgxyP4XJqns9QfEUPs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-7uunBaFCNZ-50gsN-4H9IA-1; Tue,
 30 Jun 2026 07:29:12 -0400
X-MC-Unique: 7uunBaFCNZ-50gsN-4H9IA-1
X-Mimecast-MFC-AGG-ID: 7uunBaFCNZ-50gsN-4H9IA_1782818951
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F283718C1075; Tue, 30 Jun 2026 11:28:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 121ED1955D6D; Tue, 30 Jun 2026 11:27:59 +0000 (UTC)
Date: Tue, 30 Jun 2026 12:27:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] hw/display: add vhost-user-media device
Message-ID: <akOoPD_P51HDn-Jo@redhat.com>
References: <20260630112310.552606-1-aesteve@redhat.com>
 <20260630112310.552606-3-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630112310.552606-3-aesteve@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 30, 2026 at 01:23:09PM +0200, Albert Esteve wrote:
> Add the QEMU side of the vhost-user-media device, which connects to a
> virtio-media vhost-user backend daemon implementing the V4L2 API over
> the virtio-media protocol.
> 
> The virtio-media device is specified in the VirtIO specification v1.4,
> section 5.22:
>     https://docs.oasis-open.org/virtio/virtio/v1.4/cs01/virtio-v1.4-cs01.html
> 
> Tested with the rust-vmm vhost-device-media backend [1]:
> 
>     cargo run -- -s /path/to/media.sock -d /dev/video0 --backend v4l2-proxy
> 
> Example invocation:
> 
>     qemu-system-x86_64 \
>         -chardev socket,path=/tmp/media.sock,id=media \
>         -device vhost-user-media-pci,chardev=media,id=media
> 
> [1] https://github.com/rust-vmm/vhost-device/pull/944
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/display/Kconfig                   |   5 +
>  hw/display/meson.build               |   3 +
>  hw/display/vhost-user-media-pci.c    |  77 ++++++
>  hw/display/vhost-user-media.c        | 393 +++++++++++++++++++++++++++
>  hw/virtio/virtio.c                   |   3 +-
>  include/hw/virtio/vhost-user-media.h |  47 ++++
>  6 files changed, 527 insertions(+), 1 deletion(-)
>  create mode 100644 hw/display/vhost-user-media-pci.c
>  create mode 100644 hw/display/vhost-user-media.c
>  create mode 100644 include/hw/virtio/vhost-user-media.h
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index b3593fe981..060274b1e6 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -120,6 +120,11 @@ config VHOST_USER_VGA
>      default y
>      depends on VIRTIO_VGA && VHOST_USER_GPU
>  
> +config VHOST_USER_MEDIA
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> +
>  config DPCD
>      bool
>      select AUX
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index ffecedbf70..214c047df6 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -37,6 +37,9 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
>  system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
>  system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-dmabuf.c'))
>  system_ss.add(when: 'CONFIG_DM163', if_true: files('dm163.c'))
> +system_ss.add(when: 'CONFIG_VHOST_USER_MEDIA', if_true: files('vhost-user-media.c'))
> +system_ss.add(when: ['CONFIG_VHOST_USER_MEDIA', 'CONFIG_VIRTIO_PCI' ],
> +  if_true: files('vhost-user-media-pci.c'))
>  
>  stub_ss.add([files('acpi-vga-stub.c'), pixman])
>  if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
> diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-media-pci.c
> new file mode 100644
> index 0000000000..ad9e3900a4
> --- /dev/null
> +++ b/hw/display/vhost-user-media-pci.c
> @@ -0,0 +1,77 @@
> +/*
> + * Vhost-user MEDIA virtio device PCI glue
> + *
> + * Copyright Red Hat, Inc. 2024

Have you really been hanging on to this new code for 2 years
before posting ? Should this be 2026 ? 

> + * Authors: Albert Esteve <aesteve@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

> diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
> new file mode 100644
> index 0000000000..5c627437e7
> --- /dev/null
> +++ b/hw/display/vhost-user-media.c
> @@ -0,0 +1,393 @@
> +/*
> + * Vhost-user Media device
> + *
> + * Copyright Red Hat, Inc. 2024

Same Q

> + *
> + * This is the boilerplate for instantiating a vhost-user device
> + * implementing a virtio-media device.
> + *
> + * Authors:
> + *     Albert Esteve <aesteve@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +

> diff --git a/include/hw/virtio/vhost-user-media.h b/include/hw/virtio/vhost-user-media.h
> new file mode 100644
> index 0000000000..30bdef8ce1
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-media.h
> @@ -0,0 +1,47 @@
> +/*
> + * vhost-user-media virtio device
> + *
> + * Copyright Red Hat, Inc. 2024

Again


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8282C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 22:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Xt3-0000Kc-TC; Tue, 21 May 2024 18:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9Xt1-0000K2-V4
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s9Xsz-0005Nx-Em
 for qemu-devel@nongnu.org; Tue, 21 May 2024 18:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716330188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/EBPVvPMX3bdBBU8qSICg4uiFp8OF5WvyP48lAh+0I=;
 b=IVVKucxti5Ryfg85TbgtBCx3+7PzkzsucIFa0D1wbKDcKX5MyrPfVEaLpihOsUyPgE8LN+
 nKRi2UjTRasWxFld91pgszRg+cObHUg5GLF4fnbS5fcoXslsSgJfSpDo046Glv+0MoX70B
 lf/A2jjHLG1qY0GDAFUhtJW5xmx3vVs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-3ctOE2ysOJOnXmMcp5oXWA-1; Tue, 21 May 2024 18:23:06 -0400
X-MC-Unique: 3ctOE2ysOJOnXmMcp5oXWA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a1548d684fso46976976d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 15:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716330186; x=1716934986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/EBPVvPMX3bdBBU8qSICg4uiFp8OF5WvyP48lAh+0I=;
 b=r9LHFizvrz4Vqk7xmzgAGTAvWCw88qcpw0+pAB9kcXQ+5VpddDItOtumMusuNxQ4de
 L/bk8ynMZexajYom8u7ClwCYA8xyJA/n3e4BFV6VBhdXYhD9tnb+h7wew8VSD/IwCIab
 9St0fyXcfvzQZoteIxz48nRkgl+IIJQd41xPMc6aK1QFXbvx3IruibPi/LTln6M0wfgb
 4FpbGvphOn0tMPwSQGPJ1zLAR/iOxFCU2JJnN130y4dRCzitceqPbXcp2+oNxPifAfNa
 ORXc/1f/UJ22nYB5uzzngCA0KxENjThzSA3/dMFQUzB+eYw8nxtBd4X8YZis84njt0y9
 Bkgg==
X-Gm-Message-State: AOJu0YxwPh6wQGOFnZ2gPU98ulOw5KXRBflskvo6AEEjKiWsnwVE2lRj
 ESUAjP5rsOwkzWz7B9Ir7m/VSsRAtaEB81ebeX9hrsbBd1e1CGchxJ1lwivmsHdF0WnYJzRKgye
 qv2iGs7n3zQWCjSUOQdt9vFaYiEeswfxRfvqS2gFRExAn1rKrqLS7
X-Received: by 2002:a05:6214:3004:b0:69b:1c6d:9a64 with SMTP id
 6a1803df08f44-6ab80920651mr2272396d6.4.1716330185669; 
 Tue, 21 May 2024 15:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr5CaR2fTy02Odz9SdgbsDlKbLG9EiUG21rVXFsF3VxXhF3RdghsWNvPntbDS/O7ypoiVjbw==
X-Received: by 2002:a05:6214:3004:b0:69b:1c6d:9a64 with SMTP id
 6a1803df08f44-6ab80920651mr2272126d6.4.1716330185052; 
 Tue, 21 May 2024 15:23:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a941c29753sm33129056d6.18.2024.05.21.15.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 15:23:04 -0700 (PDT)
Date: Tue, 21 May 2024 18:23:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 jasowang@redhat.com, yuri.benditovich@daynix.com, andrew@daynix.com,
 farosas@suse.de, t.lamprecht@proxmox.com
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for VirtIO-net
 USO to machine 8.1
Message-ID: <Zk0exbvcqR586AE-@x1n>
References: <20240517075336.104091-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517075336.104091-1-f.ebner@proxmox.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 17, 2024 at 09:53:36AM +0200, Fiona Ebner wrote:
> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
> version 8.1 can fail with:
> 
> > kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
> > kvm: Failed to load virtio-net:virtio
> > kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
> > kvm: load of migration failed: Operation not permitted
> 
> The series
> 
> 53da8b5a99 virtio-net: Add support for USO features
> 9da1684954 virtio-net: Add USO flags to vhost support.
> f03e0cf63b tap: Add check for USO features
> 2ab0ec3121 tap: Add USO support to tap device.
> 
> only landed in QEMU 8.2, so the compatibility flags should be part of
> machine version 8.1.
> 
> Moving the flags unfortunately breaks forward migration with machine
> version 8.1 from a binary without this patch to a binary with this
> patch.
> 

I think it'll be nicer we always copy stable in the commit log, so that
"whether to copy stable" is stick with the patch:

Cc: qemu-stable <qemu-stable@nongnu.org>

Even though it's not required for qemu stable process (I'd say that's
because we have a good stable tree maintainer..).

So we need this in qemu 8.1, 8.2 and 9.0?

> Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  hw/core/machine.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c7ceb11501..95051b80db 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -50,15 +50,15 @@ GlobalProperty hw_compat_8_1[] = {
>      { "ramfb", "x-migrate", "off" },
>      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
>      { "igb", "x-pcie-flr-init", "off" },
> +    { TYPE_VIRTIO_NET, "host_uso", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> +    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
>  };
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>  
>  GlobalProperty hw_compat_8_0[] = {
>      { "migration", "multifd-flush-after-each-section", "on"},
>      { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
> -    { TYPE_VIRTIO_NET, "host_uso", "off"},
> -    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> -    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
>  };
>  const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
>  
> -- 
> 2.39.2
> 
> 
> 

-- 
Peter Xu



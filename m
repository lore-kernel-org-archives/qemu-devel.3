Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C053DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYMH-0002BH-OO; Tue, 17 Dec 2024 09:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNYMF-00026M-4P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNYMC-0002Vp-Po
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734444927;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=slcCUGbgXCiWDiMyH5TcYh6YKKSdiiIUuVyVyVeOsho=;
 b=Foe4hEHbxkHMeVOJ6unxp5gxSpVVcbNoHbU+X2QxN3lE8HzFUHqIBh6wXKfeLsgRkdU2Qc
 nkP7pTRtCXt+S48fmpFdnAa/ITBCUNZ7kb2tZMEma7yjE7Ex5RuylwxExEGwohK1NtpdTf
 Ch09NIoeDga8Nr+2hggufaXXZJKxX9Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-FDBL5Lk0O9G4Vx8u6JQ2Ig-1; Tue,
 17 Dec 2024 09:15:24 -0500
X-MC-Unique: FDBL5Lk0O9G4Vx8u6JQ2Ig-1
X-Mimecast-MFC-AGG-ID: FDBL5Lk0O9G4Vx8u6JQ2Ig
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB9E19560B3; Tue, 17 Dec 2024 14:15:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2AA919560A2; Tue, 17 Dec 2024 14:15:18 +0000 (UTC)
Date: Tue, 17 Dec 2024 14:15:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 3/7] x86/loader: expose unpatched kernel
Message-ID: <Z2GHc5qwDub89qCa@redhat.com>
References: <20241216105053.246204-1-kraxel@redhat.com>
 <20241216105053.246204-4-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216105053.246204-4-kraxel@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Mon, Dec 16, 2024 at 11:50:49AM +0100, Gerd Hoffmann wrote:
> Add a new "etc/boot/kernel" fw_cfg file, containing the kernel without
> the setup header patches.  Intended use is booting in UEFI with secure
> boot enabled, where the setup header patching breaks secure boot
> verification.
> 
> Needs OVMF changes too to be actually useful.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20240905141211.1253307-5-kraxel@redhat.com>
> ---
>  hw/i386/x86-common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 28341b42d949..1cef3045ad83 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -962,6 +962,9 @@ void x86_load_linux(X86MachineState *x86ms,
>      sev_load_ctx.setup_data = (char *)setup;
>      sev_load_ctx.setup_size = setup_size;
>  
> +    /* kernel without setup header patches */
> +    fw_cfg_add_file(fw_cfg, "etc/boot/kernel", kernel, kernel_size);
> +

How concerned should we be about the memory duplication overhead
from loading the kernel image twice ?

A bare modular kernel is 16MB, a non-modular one would be bigger
perhaps 10's of MB, a UKI meanwhile could easily be 100's of MB
in size, and >=1GB is not entirely insane to contemplate with a
UKI depending on how much is put into the embedded initrd.

I don't think the memory for fw_cfg is counted against the guest
RAM, right?

Is there anyway the duplicate kernel gets erased from memory once
the firmware is done, otherwise we live with this extra host RAM
overhead forever ?

>      if (sev_enabled()) {
>          sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
>      }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



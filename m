Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4CEC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBYb-0001cj-VE; Thu, 05 Jun 2025 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNBYa-0001cN-UC
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uNBYY-0002K3-Ua
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749133617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pWg934uPrhiLGoro/84ql+CujoIKOYEB7X82shANqIM=;
 b=AvD3sYHFDlOEjawxzEAjOAg725EJGciAiBT5q+19iVltJGtvSQdL2GzLmtjUUyr6uswtDG
 weIWBLwJyMF4Gs77CydmSqYRgu0Z61ko2O/f9A5ZovgNY6+wVeNFUsyTnBaT+O2lOrecuJ
 mRZctw8WzJFYmV7nYUjKUN8xNxAqx1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Z79gPdkRMj2BbdVSLEPM8A-1; Thu, 05 Jun 2025 10:26:56 -0400
X-MC-Unique: Z79gPdkRMj2BbdVSLEPM8A-1
X-Mimecast-MFC-AGG-ID: Z79gPdkRMj2BbdVSLEPM8A_1749133615
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so459850f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133615; x=1749738415;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWg934uPrhiLGoro/84ql+CujoIKOYEB7X82shANqIM=;
 b=wx4UrLbuZchDmTwl/VXqKBAc4ehfe7256KPvOCadwiqBhJUTVcnVemaegmOmzAY+Q1
 8SWXsEgmygJ4eUxdJk2AP9Em5Fatu57VXx1tCZO2RSH3o2RrT2VS+K3e3aty9yk1uHdM
 rjpqKWr29/ntbhvYuIax3yfHBxsIF38ythq6Vyidy7M+IaB4vE9ZdCM3jBYbi+a3nl51
 vfL64Wv4ujby5GHKroxobUJFmkkSrZrix120E4VQ4Pr9JcaNWopSLU+ugQtYTuArwKEL
 WU16G+9dn/nDxK/FH245ndYdGZwYxyOSVP+dO9Rzz5SpileHMg8QWEiG/WQ1gq+RkU9d
 t0Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/b3tCUR7TP/O47ZpuuteIpwZwhDe5DRvpukqjc+sGf3vzxgh8qic2CQ6jhpG9yiKq25wMJky28Gho@nongnu.org
X-Gm-Message-State: AOJu0YzryZL0CvQbv4uHGZA+VDveTBxaa6zd6GHFNvIBSsATzuIUP+4V
 LsIOlysnnCRpPb+6sJgmagX4ODL4kfUwOPNP/1q9DjnAmh09aXBPngTyWzNMIKdOCw2RgYrZ+B0
 vWICzTVZiJp3bl+MWxhoiPjZvzn8HxUzGsOcQV3Eq2a2KqGU+fXrM4sln
X-Gm-Gg: ASbGnctetC3FjgdlC8gmH2ugvpl6Xsr8Ilge3WSFLcp0FIa/R4RdlzbxKLeaSToCVb7
 DY9JvvYnF/xEfNY4Tjjk9bbMyen2XVt3jWQLJXNSHjNEIdbP+Z7TL7fuGNgZcfDEMVc6uNrPMCy
 rXkAPUp+mpidNuXRPtZixCDizb5p02dyasIPXoprj57/Zb3WGG7IEGnhOIT4wKdQKUCXoLPKDJT
 ZTHibBGN7MHV5fSewE8KVOp816cIi2tDvM/an687Mhwuzrr4ecyTFuIpmE6xuuLW9gPeB/2ftPA
 gS7tWoj+nZMj6QUqq9LrIqE08/9/k6k5dgN1yTQFaIBvI3p23ipbSsPD9cYqiV3YtGY4knDXIUX
 KD0JplIf50byqhf4DPiRCUiVRHKiiEFvBcs7xv4mBmgglEA==
X-Received: by 2002:a05:6000:2282:b0:3a4:f7f3:2d02 with SMTP id
 ffacd0b85a97d-3a51d900221mr6389965f8f.17.1749133614843; 
 Thu, 05 Jun 2025 07:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw0uV4PtNomqI0NWMCjV7GJ7j43Iwm6oFnQfjNlKnQHKpu9E2PUgVqn7ueNuGfiPkBP7qY7w==
X-Received: by 2002:a05:6000:2282:b0:3a4:f7f3:2d02 with SMTP id
 ffacd0b85a97d-3a51d900221mr6389941f8f.17.1749133614435; 
 Thu, 05 Jun 2025 07:26:54 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:54:3894:a12c:7ed9:4ede:d4f5?
 (2a01cb0100543894a12c7ed94eded4f5.ipv6.abo.wanadoo.fr.
 [2a01:cb01:54:3894:a12c:7ed9:4ede:d4f5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6d0dbsm24149090f8f.40.2025.06.05.07.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 07:26:53 -0700 (PDT)
Message-ID: <9094a7e6-fbb7-422e-9b13-f0ff29eb9ee3@redhat.com>
Date: Thu, 5 Jun 2025 16:26:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ramfb: Add property to control if load the romfile
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: Eric Auger <eauger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250605030351.2056571-1-shahuang@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250605030351.2056571-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On 6/5/25 05:03, Shaoqin Huang wrote:
> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but only
> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> So add a new property ramfb-romfile in both ramfb and vfio_pci device,
> because the vfio display also use the ramfb_setup() to load the
> vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/display/ramfb-standalone.c | 4 +++-
>   hw/display/ramfb-stubs.c      | 2 +-
>   hw/display/ramfb.c            | 6 ++++--
>   hw/vfio/display.c             | 4 ++--
>   hw/vfio/pci.c                 | 1 +
>   hw/vfio/pci.h                 | 1 +
>   include/hw/display/ramfb.h    | 2 +-
>   7 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index 1be106b57f..2b96a49baa 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -17,6 +17,7 @@ struct RAMFBStandaloneState {
>       QemuConsole *con;
>       RAMFBState *state;
>       bool migrate;
> +    bool ramfb_romfile;
>   };
>   
>   static void display_update_wrapper(void *dev)
> @@ -39,7 +40,7 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
>       RAMFBStandaloneState *ramfb = RAMFB(dev);
>   
>       ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
> -    ramfb->state = ramfb_setup(errp);
> +    ramfb->state = ramfb_setup(ramfb->ramfb_romfile, errp);
>   }
>   
>   static bool migrate_needed(void *opaque)
> @@ -62,6 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>   
>   static const Property ramfb_properties[] = {
>       DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> +    DEFINE_PROP_BOOL("ramfb-romfile", RAMFBStandaloneState, ramfb_romfile, true),
>   };
>   
>   static void ramfb_class_initfn(ObjectClass *klass, void *data)
> diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
> index cf64733b10..b83551357b 100644
> --- a/hw/display/ramfb-stubs.c
> +++ b/hw/display/ramfb-stubs.c
> @@ -8,7 +8,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>   {
>   }
>   
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>   {
>       error_setg(errp, "ramfb support not available");
>       return NULL;
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 8c0f907673..9a17d97d07 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -135,7 +135,7 @@ const VMStateDescription ramfb_vmstate = {
>       }
>   };
>   
> -RAMFBState *ramfb_setup(Error **errp)
> +RAMFBState *ramfb_setup(bool romfile, Error **errp)
>   {
>       FWCfgState *fw_cfg = fw_cfg_find();
>       RAMFBState *s;
> @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
>   
>       s = g_new0(RAMFBState, 1);
>   
> -    rom_add_vga("vgabios-ramfb.bin");
> +    if (romfile) {
> +        rom_add_vga("vgabios-ramfb.bin");
> +    }
>       fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
>                                NULL, ramfb_fw_cfg_write, s,
>                                &s->cfg, sizeof(s->cfg), false);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index ea87830fe0..56f10564f9 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -365,7 +365,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                             &vfio_display_dmabuf_ops,
>                                             vdev);
>       if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_romfile, errp);
>           if (!vdev->dpy->ramfb) {
>               return false;
>           }
> @@ -494,7 +494,7 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                             &vfio_display_region_ops,
>                                             vdev);
>       if (vdev->enable_ramfb) {
> -        vdev->dpy->ramfb = ramfb_setup(errp);
> +        vdev->dpy->ramfb = ramfb_setup(vdev->ramfb_romfile, errp);
>           if (!vdev->dpy->ramfb) {
>               return false;
>           }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed..bfdf365978 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,6 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>   
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_BOOL("ramfb-romfile", VFIOPCIDevice, ramfb_romfile, true),
>       DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                               ON_OFF_AUTO_AUTO),
>   };
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index d94ecaba68..d567de8f10 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -177,6 +177,7 @@ struct VFIOPCIDevice {
>       bool no_kvm_ioeventfd;
>       bool no_vfio_ioeventfd;
>       bool enable_ramfb;
> +    bool ramfb_romfile;

The attribute 'ramfb_romfile' sounds like a file name. Could you please
add an 'enable' prefix or suffix.


Thanks,

C.

  
>       OnOffAuto ramfb_migrate;
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
> diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> index a7e0019144..172aa6dc89 100644
> --- a/include/hw/display/ramfb.h
> +++ b/include/hw/display/ramfb.h
> @@ -6,7 +6,7 @@
>   /* ramfb.c */
>   typedef struct RAMFBState RAMFBState;
>   void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> -RAMFBState *ramfb_setup(Error **errp);
> +RAMFBState *ramfb_setup(bool romfile, Error **errp);
>   
>   extern const VMStateDescription ramfb_vmstate;
>   



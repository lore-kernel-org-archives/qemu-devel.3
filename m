Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBEC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Oj2-0005d3-DZ; Tue, 21 May 2024 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Oj0-0005ci-7c
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Oix-0002ug-QY
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716294971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3MeXqoC+KxtV08egeRSc1kP7YIuS8DZvRnHTLOUxxE=;
 b=crffoDLdBy1FgNGRVxxapFLRwosOuxh5NwDLOmeVJLVl6vefN31jHg7d795+NgYdPSqxPX
 SRGW5LIeQ8MJXlgr4wNyqQvp0pTXPEiU680zovurBZ40E9NQAwnDb99m1LDlHek5abjBON
 TPaMRKGSBf2OxsBVirjEPGmIu7La5IY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-wM5qJJ0AMgK-KfUst5DClQ-1; Tue, 21 May 2024 08:36:09 -0400
X-MC-Unique: wM5qJJ0AMgK-KfUst5DClQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab6bc106fdso19099766d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294969; x=1716899769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3MeXqoC+KxtV08egeRSc1kP7YIuS8DZvRnHTLOUxxE=;
 b=FgYh22tHLagmeQSc9TFeV9Z6YLxsEfufDWsk+fx2JgCp7/ZZ2O52jjhpsJ3Hjp0rTX
 +cfcKifoLcamJPL2vYRGL1QacqjWEguOZWBj7khUU11LdghnLJNHViEWhlbrR7DG57S5
 nsKvCelRN6A/6K47FySxYJX77jtJbhLUUfbXosl8RCcF2+aZP8PcENVmhBH84oR+cKlg
 jRuBUq5ohYRirqTladebyiyx/VD3dSAKxA+SQmhmRnTuSIesS6QOb83uOkly3g+WTesm
 /Hp9KkZSITqbhEE43xBUt2fkNjbKXnVzeUxvDFeKiIofxUMeYfi+AwHGL2sUiJfk55aB
 Yp7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Qq773X+gc8jvElCLlL7v1k9k4+6wmlZIcq8Z0GobdRuMleXQR7rs05TMm4EzHS0iunNugKisBzqFUXJ3xsrHdIJRMAk=
X-Gm-Message-State: AOJu0Yx7L3kgZIaxpD94nm5Ein4dTL47JG7Gl3p9PWZE7olbFRGpvWD5
 RCFuqGce95WTpZI1CuNjBo2JYDZzn+HjbHabylVuPgdeHLiuynLhnI1sFomENJAu5g/SVd/0QMi
 7n7U+c6F/uUJ1PSqOIc77HNBaMbVV/eia7GUpdtdukoO9IRNRckewsYavliyl
X-Received: by 2002:a05:6214:3ca1:b0:6a0:a7c6:436f with SMTP id
 6a1803df08f44-6a16824beb9mr397158926d6.38.1716294968849; 
 Tue, 21 May 2024 05:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkHjFcouLTdm25/5MvpYURDyUb8RA9yN+hkMIObk5I17zjLNmKjDf91bzSAicU4Sjh0FDazg==
X-Received: by 2002:a05:6214:3ca1:b0:6a0:a7c6:436f with SMTP id
 6a1803df08f44-6a16824beb9mr397158736d6.38.1716294968477; 
 Tue, 21 May 2024 05:36:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab6d76e124sm11957566d6.46.2024.05.21.05.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:36:07 -0700 (PDT)
Message-ID: <dcbb2b5c-960e-401b-8522-6790da630125@redhat.com>
Date: Tue, 21 May 2024 14:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] vfio/pci: Make vfio_intx_enable_kvm() return a bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-9-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> Since vfio_intx_enable_kvm() takes an 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h
> Rules section.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index aad012c348..12fb534d79 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -116,7 +116,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>       vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>   }
>   
> -static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   {
>   #ifdef CONFIG_KVM
>       int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
> @@ -124,7 +124,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>           vdev->intx.route.mode != PCI_INTX_ENABLED ||
>           !kvm_resamplefds_enabled()) {
> -        return;
> +        return true;
>       }
>   
>       /* Get to a known interrupt state */
> @@ -161,7 +161,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   
>       trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
>   
> -    return;
> +    return true;
>   
>   fail_vfio:
>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
> @@ -171,6 +171,9 @@ fail_irqfd:
>   fail:
>       qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>       vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> +    return false;
> +#else
> +    return true;
>   #endif
>   }
>   
> @@ -226,8 +229,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>           return;
>       }
>   
> -    vfio_intx_enable_kvm(vdev, &err);
> -    if (err) {
> +    if (!vfio_intx_enable_kvm(vdev, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
> @@ -302,8 +304,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>           return -errno;
>       }
>   
> -    vfio_intx_enable_kvm(vdev, &err);
> -    if (err) {
> +    if (!vfio_intx_enable_kvm(vdev, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   



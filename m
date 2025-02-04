Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC0FC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfK5w-0003zL-7e; Tue, 04 Feb 2025 09:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfK5l-0003u7-FQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfK5j-0002Kz-4Y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738679992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0NKXpdVNTXfHIKHX/W8nnP36OTPEWjqfFy3791lShbs=;
 b=QR/7idE+w/wCrT7s5cT80TgReJ5yDeI8LnHDpiYEZ13ensVqXw/Nq1jk1Ldl7fR3cCLVYo
 l1WxJ03Y3xSJisQC0NTRsAGO7P2DUCkBQXv4R7cU0H2l4RQebzVuQZ8Thb0KG7xSPr7dpN
 hthLM+VKs5gXsQAvsrTyt7+59c593/8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-J3NCMiXYOoaTBA0LyRcWhA-1; Tue, 04 Feb 2025 09:39:50 -0500
X-MC-Unique: J3NCMiXYOoaTBA0LyRcWhA-1
X-Mimecast-MFC-AGG-ID: J3NCMiXYOoaTBA0LyRcWhA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e6cf6742so1621284485a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738679990; x=1739284790;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NKXpdVNTXfHIKHX/W8nnP36OTPEWjqfFy3791lShbs=;
 b=Cs4Gilr5tCOOUqmbfQSg4cpj5ecUQBtLLb926+28UAo3nd2wyLht1DpmRqzQACpP49
 p0UuXs4XXCdunoGiJvIyedB2kjkhMAGpxpvpzg56QreOUURzJah6vi3ND3XGTUBQcpW1
 aH73AQu/rZPqjuEpsvJa8ZZE/Pr4j3e54f8fvdogHJCWG71gH+rtYPa6k3lf8Z8OGEXU
 NPbM0nhBGSuJQqwwjn9QYuumkM2soO2axwXQR6xnzEKovKq01REAI78x27D6VGiVtNIQ
 jRbfImcGlgDZngpvVm3Er/dQXrv9gEMOeHS9rr8/cFvCoOPq4uB3o7fF4X2lNBkfy4PS
 zSIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSd82lVKvTR1uSzGwCWz6qcPI9PkOhJMz55xvpLMmb9cBigshjFos/xl+J81ev5X7er/41LtafcY/M@nongnu.org
X-Gm-Message-State: AOJu0YxTmTuf0QXWUCGiE9+HmPJjWvgBVSQUwDYnfx4Hk2zX1qs38juH
 2EHAXZkBBn4/6lCLJ8N9ZBHY0sUIJr0HO2uW7dK0T4NPJQ1PFdLzzXku+75zxPOAwZoyBY3vhcl
 q+Egm9exq46YqmX+qqomasQOIA8j6btgJiVQVrvKjr1COHLZs7/nH
X-Gm-Gg: ASbGncsNbca7oUCPIPHt8wiNjd//2f4miC6/Q7YPN+lea1JjH/N4DWThHW2kMrU6bLs
 F7T3B0roL6RjfEqJh0wuu9NdZcTMYQvaJx1h3/6os43g+8NB/QKVIcwblKE8OX+aOyxBJXHiYfP
 BQFkx2hknEWV8LMC0VYBgXB+xZY11USLUT5o+rRrIu3gHXioVnhWxJ7MglQ0BMPqtzEcwcik3+i
 YXNWnmSRm4CHzcljjgh3x/VkxGVaNXApLTnJivOoeFGYL0ldtgAD7KsJVcw/HpdzGvqQpZ4eTUn
 XGDPQTXvbEEWceswgL+PNdZzMvxn57Ieeqv2WhEk0tI=
X-Received: by 2002:a05:620a:4550:b0:7b6:db05:12a9 with SMTP id
 af79cd13be357-7bffcd72796mr3437692485a.39.1738679989800; 
 Tue, 04 Feb 2025 06:39:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIVLWuLqDr0hOFzufE+sROLlSidMtHcg6HKm/Uqbg6UxLNOSFafnys1Y9QcSpbXLt59EhzYA==
X-Received: by 2002:a05:620a:4550:b0:7b6:db05:12a9 with SMTP id
 af79cd13be357-7bffcd72796mr3437688785a.39.1738679989391; 
 Tue, 04 Feb 2025 06:39:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8cfe1asm646830785a.25.2025.02.04.06.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 06:39:48 -0800 (PST)
Message-ID: <f08ce379-f69c-421c-a852-38736322c8e6@redhat.com>
Date: Tue, 4 Feb 2025 15:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 10/26] vfio-pci: refactor for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-11-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-11-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/29/25 15:43, Steve Sistare wrote:
> Refactor vector use into a helper vfio_vector_init.
> Add vfio_notifier_init and vfio_notifier_cleanup for named notifiers,
> and pass additional arguments to vfio_remove_kvm_msi_virq.
> 
> All for use by CPR in a subsequent patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.c | 106 +++++++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 68 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab17a98..24ebd69 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -54,6 +54,32 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +/* Create new or reuse existing eventfd */
> +static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
> +                              const char *name, int nr)
> +{
> +    int fd = -1;   /* placeholder until a subsequent patch */
> +    int ret = 0;
> +
> +    if (fd >= 0) {
> +        event_notifier_init_fd(e, fd);

Could you please first introduce the vfio_notifier_init() routine,
which can me merged quickly, and then, in a subsequent patch, modify
vfio_notifier_init() for CPR support.

> +    } else {
> +        ret = event_notifier_init(e, 0);
> +        if (ret) {
> +            Error *err = NULL;
> +            error_setg_errno(&err, -ret, "vfio_notifier_init %s failed", name);

I don't think "name" is useful if the caller calls error_prepend() to
extend the error message.


> +            error_report_err(err);

Nope. We should propagate the error with 'Error **' parameter and return
bool.

> +        }
> +    }
> +    return ret;
> +}
> +
> +static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
> +                                  const char *name, int nr)

That's a lot of unused parameters which should be introduces when required.

> +{
> +    event_notifier_cleanup(e);
> +}
> +
>   /*
>    * Disabling BAR mmaping can be slow, but toggling it around INTx can
>    * also be a huge overhead.  We try to get the best of both worlds by
> @@ -134,8 +160,8 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       pci_irq_deassert(&vdev->pdev);
>   
>       /* Get an eventfd for resample/unmask */
> -    if (event_notifier_init(&vdev->intx.unmask, 0)) {
> -        error_setg(errp, "event_notifier_init failed eoi");
> +    if (vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0)) {
> +        error_setg(errp, "vfio_notifier_init intx-unmask failed");
>           goto fail;
>       }
>   
> @@ -167,7 +193,7 @@ fail_vfio:
>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>                                             vdev->intx.route.irq);
>   fail_irqfd:
> -    event_notifier_cleanup(&vdev->intx.unmask);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>   fail:
>       qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>       vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> @@ -199,7 +225,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>       }
>   
>       /* We only need to close the eventfd for VFIO to cleanup the kernel side */
> -    event_notifier_cleanup(&vdev->intx.unmask);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>   
>       /* QEMU starts listening for interrupt events. */
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
> @@ -266,7 +292,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>       Error *err = NULL;
>       int32_t fd;
> -    int ret;
>   
>   
>       if (!pin) {
> @@ -289,9 +314,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       }
>   #endif
>   
> -    ret = event_notifier_init(&vdev->intx.interrupt, 0);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "event_notifier_init failed");
> +    if (vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0)) {
>           return false;
>       }
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
> @@ -300,7 +323,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->intx.interrupt);
> +        vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>           return false;
>       }
>   
> @@ -327,7 +350,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>   
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>       qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->intx.interrupt);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>   
>       vdev->interrupt = VFIO_INT_NONE;
>   
> @@ -471,13 +494,15 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>                                                vector_n, &vdev->pdev);
>   }
>   
> -static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
> +static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)

This change belongs to another patch.

>   {
> +    const char *name = "kvm_interrupt";
> +
>       if (vector->virq < 0) {
>           return;
>       }
>   
> -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
> +    if (vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr)) {
>           goto fail_notifier;
>       }
>   
> @@ -489,19 +514,20 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
>       return;
>   
>   fail_kvm:
> -    event_notifier_cleanup(&vector->kvm_interrupt);
> +    vfio_notifier_cleanup(vector->vdev, &vector->kvm_interrupt, name, nr);
>   fail_notifier:
>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>       vector->virq = -1;
>   }
>   
> -static void vfio_remove_kvm_msi_virq(VFIOMSIVector *vector)
> +static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                                     int nr)
>   {
>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
>                                             vector->virq);
>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>       vector->virq = -1;
> -    event_notifier_cleanup(&vector->kvm_interrupt);
> +    vfio_notifier_cleanup(vdev, &vector->kvm_interrupt, "kvm_interrupt", nr);
>   }
>   
>   static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
> @@ -511,6 +537,20 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> +static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vector->vdev = vdev;
> +    vector->virq = -1;
> +    vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr);
> +    vector->use = true;
> +    if (vdev->interrupt == VFIO_INT_MSIX) {
> +        msix_vector_use(pdev, nr);
> +    }
> +}


This change belongs to another patch.


Thanks,

C.


>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> @@ -524,13 +564,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       vector = &vdev->msi_vectors[nr];
>   
>       if (!vector->use) {
> -        vector->vdev = vdev;
> -        vector->virq = -1;
> -        if (event_notifier_init(&vector->interrupt, 0)) {
> -            error_report("vfio: Error: event_notifier_init failed");
> -        }
> -        vector->use = true;
> -        msix_vector_use(pdev, nr);
> +        vfio_vector_init(vdev, nr);
>       }
>   
>       qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
> @@ -542,7 +576,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>        */
>       if (vector->virq >= 0) {
>           if (!msg) {
> -            vfio_remove_kvm_msi_virq(vector);
> +            vfio_remove_kvm_msi_virq(vdev, vector, nr);
>           } else {
>               vfio_update_kvm_msi_virq(vector, *msg, pdev);
>           }
> @@ -554,7 +588,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                   vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>                   vfio_add_kvm_msi_virq(vdev, vector, nr, true);
>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
> -                vfio_connect_kvm_msi_virq(vector);
> +                vfio_connect_kvm_msi_virq(vector, nr);
>               }
>           }
>       }
> @@ -661,7 +695,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>       kvm_irqchip_commit_route_changes(&vfio_route_change);
>   
>       for (i = 0; i < vdev->nr_vectors; i++) {
> -        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
> +        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
>       }
>   }
>   
> @@ -741,9 +775,7 @@ retry:
>           vector->virq = -1;
>           vector->use = true;
>   
> -        if (event_notifier_init(&vector->interrupt, 0)) {
> -            error_report("vfio: Error: event_notifier_init failed");
> -        }
> +        vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i);
>   
>           qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>                               vfio_msi_interrupt, NULL, vector);
> @@ -797,11 +829,11 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
>           VFIOMSIVector *vector = &vdev->msi_vectors[i];
>           if (vdev->msi_vectors[i].use) {
>               if (vector->virq >= 0) {
> -                vfio_remove_kvm_msi_virq(vector);
> +                vfio_remove_kvm_msi_virq(vdev, vector, i);
>               }
>               qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>                                   NULL, NULL, NULL);
> -            event_notifier_cleanup(&vector->interrupt);
> +            vfio_notifier_cleanup(vdev, &vector->interrupt, "interrupt", i);
>           }
>       }
>   
> @@ -2854,8 +2886,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (event_notifier_init(&vdev->err_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for error detection");
> +    if (vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0)) {
>           vdev->pci_aer = false;
>           return;
>       }
> @@ -2867,7 +2898,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->err_notifier);
> +        vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>           vdev->pci_aer = false;
>       }
>   }
> @@ -2886,7 +2917,7 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
>                           NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->err_notifier);
> +    vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>   }
>   
>   static void vfio_req_notifier_handler(void *opaque)
> @@ -2920,8 +2951,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (event_notifier_init(&vdev->req_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for device request");
> +    if (vfio_notifier_init(vdev, &vdev->req_notifier, "req_notifier", 0)) {
>           return;
>       }
>   
> @@ -2932,7 +2962,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->req_notifier);
> +        vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>       } else {
>           vdev->req_enabled = true;
>       }
> @@ -2952,7 +2982,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
>                           NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->req_notifier);
> +    vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>   
>       vdev->req_enabled = false;
>   }



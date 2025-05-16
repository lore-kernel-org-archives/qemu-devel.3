Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4140BC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqRh-0001Is-Gx; Fri, 16 May 2025 04:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqRd-0001I8-No
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqRU-0004qw-3g
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mdrCNOi7N4o3WiuwHWrEgS/w0rObB7ZLvp6MQi96Fuw=;
 b=i7rULd5k4iNMTOnRVvwv6FT/iAU5gesqNKxvqWAv1Hs6/P92SPSjJMbuZwjBUvAmhrrhhT
 H4j7tEYWLbVP5G+yZSmZi2WCE4RiJDnDebE8H2ddjqQ7k3tMzuMpS1hYSsrP2j69ONPr7U
 m5zbvA45xFgTVOfCZ10okdypNLmbamQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-9cXpAFE-OHOakrrqMoCtsA-1; Fri, 16 May 2025 04:29:17 -0400
X-MC-Unique: 9cXpAFE-OHOakrrqMoCtsA-1
X-Mimecast-MFC-AGG-ID: 9cXpAFE-OHOakrrqMoCtsA_1747384156
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442fda1cba7so2555825e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384156; x=1747988956;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdrCNOi7N4o3WiuwHWrEgS/w0rObB7ZLvp6MQi96Fuw=;
 b=IoVIVFWMSw+TSdsoSPuH/zkttN0kVh6B9bzRcWltHQzZJMEVFwcgeixu43gWezfn6Z
 no9d/TcEe7I3hfhey7fEzDa98L1G8cnmO3l7lzMK1H70IswOMnkiTLNp7o10yJ1Zls1r
 leFhwYZbDgb4Ip5O8uAuq7A08jYJjLOIspPtQbcfrK6GBEWDrJoeUirWVlTtWCIiaK9d
 6RcLt7MD0cV+ZGViJr+ag3l9Q+Z9XDPs1Z/GKOKKIkuKjrPot0d651JH3DUTmde2PjZQ
 2hWZcEtHN8IzNkMbtVEMi/vyOY1S5C8d2Nnt380V13fiNu8M5XdP4ziKLVmOCO0/71hM
 w2nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWItjejOVunermd7XSTKUFVPSF98rCEKLp8/ClKK53VYyoRQYxUIIvqu+EQ9CkZhI+3P1cWPRkohq0I@nongnu.org
X-Gm-Message-State: AOJu0Yw3Oa6yJKu78Ub+tZO4jphWZFkV1ltkfkM4DfWy8F32YIf9l2Yl
 tCkhHFX4sD0oalGkkkCWEXHJTpvVlZFDRu5J62rtcdTymAguC7UGRHzNl37Tb7v3e1mk1HOmkMc
 Jt21hdN4NhkbywcZ7Yo5MNwgLsRqMWf5uIbTDF0xMxAI43rgjlZGvf6vl
X-Gm-Gg: ASbGncvbljLBZhog+IAY95Jrqcvs/M/eUZefTXxJrbhKCkuuqJ2B7FVjXhPnp//K/OB
 NgZ2mHLVlkX0N/BkEoqd2fGra9N6DLyjcwnC4l9BRztptxDXMtCOXOBcuOiUuRquowiZ98Mq195
 K0+n8wGURVeL4cKtxjQ2MEgyxXjL9HbnJogtK4lH1yS55dnU2RxyOkk6RK1IGGU619aMVwUEFYl
 7T4YqmbWupEBmeetoF69GLOe1ZeQiNzWDLDu0an7dJ3AZWGKVtAVDjEaqw/aiC5AHaSEz4m8nTf
 z24ATkX6F2BoOhbB+DPMD8u7MyWzJIPVuqi2hhDkCDeloq86YA==
X-Received: by 2002:a05:600c:528a:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-442ff03c4edmr16388355e9.30.1747384155977; 
 Fri, 16 May 2025 01:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhKZhUS7V+TUXyQwhHw5tLcl66KRsn9cjOi83A/MTcXaD9A9Tk/bQGiEmn/A0Ku+kHsE3qzg==
X-Received: by 2002:a05:600c:528a:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-442ff03c4edmr16387995e9.30.1747384155610; 
 Fri, 16 May 2025 01:29:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369293sm100614255e9.6.2025.05.16.01.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:29:14 -0700 (PDT)
Message-ID: <67d63adf-6785-4e95-95e4-e461cb89a7f6@redhat.com>
Date: Fri, 16 May 2025 10:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 17/42] vfio/pci: vfio_notifier_init
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-18-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-18-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Move event_notifier_init calls to a helper vfio_notifier_init.
> This version is trivial, but it will be expanded to support CPR
> in subsequent patches.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b46c42e..4159deb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -56,6 +56,16 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
> +{
> +    int ret = event_notifier_init(e, 0);
> +
> +    if (ret) {
> +        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +    }
> +    return !ret;
> +}
> +
>   /*
>    * Disabling BAR mmaping can be slow, but toggling it around INTx can
>    * also be a huge overhead.  We try to get the best of both worlds by
> @@ -136,8 +146,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       pci_irq_deassert(&vdev->pdev);
>   
>       /* Get an eventfd for resample/unmask */
> -    if (event_notifier_init(&vdev->intx.unmask, 0)) {
> -        error_setg(errp, "event_notifier_init failed eoi");
> +    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
>           goto fail;
>       }
>   
> @@ -268,7 +277,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>       Error *err = NULL;
>       int32_t fd;
> -    int ret;
>   
>   
>       if (!pin) {
> @@ -291,9 +299,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       }
>   #endif
>   
> -    ret = event_notifier_init(&vdev->intx.interrupt, 0);
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "event_notifier_init failed");
> +    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
>           return false;
>       }
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
> @@ -473,11 +479,13 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>   
>   static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
>   {
> +    const char *name = "kvm_interrupt";
> +
>       if (vector->virq < 0) {
>           return;
>       }
>   
> -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
> +    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
>           goto fail_notifier;
>       }
>   
> @@ -515,11 +523,12 @@ static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>       PCIDevice *pdev = &vdev->pdev;
> +    Error *err = NULL;

In case you resend, I prefer naming local Error variables local_err.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


>   
>       vector->vdev = vdev;
>       vector->virq = -1;
> -    if (event_notifier_init(&vector->interrupt, 0)) {
> -        error_report("vfio: Error: event_notifier_init failed");
> +    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
> +        error_report_err(err);
>       }
>       vector->use = true;
>       if (vdev->interrupt == VFIO_INT_MSIX) {
> @@ -749,13 +758,14 @@ retry:
>   
>       for (i = 0; i < vdev->nr_vectors; i++) {
>           VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +        Error *err = NULL;
>   
>           vector->vdev = vdev;
>           vector->virq = -1;
>           vector->use = true;
>   
> -        if (event_notifier_init(&vector->interrupt, 0)) {
> -            error_report("vfio: Error: event_notifier_init failed");
> +        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
> +            error_report_err(err);
>           }
>   
>           qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
> @@ -2907,8 +2917,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (event_notifier_init(&vdev->err_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for error detection");
> +    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
> +        error_report_err(err);
>           vdev->pci_aer = false;
>           return;
>       }
> @@ -2974,8 +2984,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (event_notifier_init(&vdev->req_notifier, 0)) {
> -        error_report("vfio: Unable to init event notifier for device request");
> +    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
> +        error_report_err(err);
>           return;
>       }
>   



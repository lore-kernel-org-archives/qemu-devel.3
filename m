Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BC8C3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqS9-0001MR-C0; Fri, 16 May 2025 04:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqS7-0001K8-O5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqS5-0004xR-Tf
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1zsV7X5vfLbA8KH9Vf5CelTVs7cPZgN9EyYCgBXXraM=;
 b=CGsjTlojAO0R8apZPSAm2xNOpE+nkNXapk3nxtcjINor9Ask0jBl/7X7nNNMRrRonAuduy
 XSoHjEIAiysC+kuk3MSZCnyBSRuRgVBFV8azWWTuSMgmGsxxKixyhpwtk2febmuoQfFaSH
 bqSJfi4lu1f6Ipg2Jy7j6NcEh8Y0tI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-jgsJsdwhPN2AxoAhx74vMA-1; Fri, 16 May 2025 04:29:54 -0400
X-MC-Unique: jgsJsdwhPN2AxoAhx74vMA-1
X-Mimecast-MFC-AGG-ID: jgsJsdwhPN2AxoAhx74vMA_1747384193
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0bcaf5f45so907330f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384193; x=1747988993;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zsV7X5vfLbA8KH9Vf5CelTVs7cPZgN9EyYCgBXXraM=;
 b=JS9ElEVG/ErkSENCeTaLmx8LRQ9k1p6Ax6R/qvaPBWvlRxUDA8Ha+AQg3iQNBEghnJ
 xKq+Om16pfN1Nxd00AIDEFCCeLlwHoAk1JJf1+tC7J7r6fTX7A2n1ZzzLBvbu90dLphs
 BwFgmSqi5EmPx2QlFZlQcFDztqkuLuS0zNFpNNxqkfxZAJ7V67tSxcB2n5FnhtNDXftX
 0yy0/gpK/STqq1POMxMJfRtIRNzdm+mAHZ4mfFoEq9POlod/W5zEuk/gapLnahn6cov7
 n+uAvgiGMTkyAdgXd3johlgtM/nL7ZHbnLWp+i3hCC5a7Y/YtkbClMbgUBXWVJGTXvCq
 BYOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLpgp7+4H3WQsH0rzZdAUlXTM4ptXMbs6i7YdIeHCvMt2by+47Q+nm6caZ2qPIfXjyYfop/ZZgQUQn@nongnu.org
X-Gm-Message-State: AOJu0YydqBTZ0NyHGjar1IOK8MD7Fn/L8ZRRueCOnxLVBvEW1XvzjG52
 pTOpdmalXzSIXA8/e11di3L7TJFDFf+1crtm8CoJdBqVAhWUTTcT0OqlTmOh2ey/JgabVnkI3sT
 cyD5yGaHIb/8WCVUUDFSuKPvfMe9bHgVZMv+qLNCH6xuxJMfIZ/wEx1Y5
X-Gm-Gg: ASbGncul4P/381JQ4BXcSmbujKFb8cEa92MYQiP0agy73qghQh9dm+3W7zp3RmWuoBK
 l7gW5rd2G5oYD3wOTFZUTysgtLO6VEPpmM0r+qBAyRWr5I3wH2+WmlZ954urUpvcA1fN5mFihX5
 YgVmcJgOu2abuAHHAjIqJBEdd2QQo1+QbXLq/O8EHYC0xatWPkxVIZQA9+hUz8C2wESNrQRtN3k
 sUfQPFopO6rJwnDMDhlLshR4/11CUlBgjbmMmbPs5dScknR52GkNq6G04WavRpH6rdgftM8+L/j
 2solOT+mcw8q7Sc5kIzc/m9xisM2uv4O9fW4ipChtzKFkfwlAA==
X-Received: by 2002:a05:6000:2285:b0:3a3:5b59:cb24 with SMTP id
 ffacd0b85a97d-3a3601dc06emr1346050f8f.57.1747384193369; 
 Fri, 16 May 2025 01:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbcSrT4hRr0vMhc2s/OeitweiWko+x0g8WOUO1ECMr0yE5LH6217G6kbIMI/UK7ugLfcvaCg==
X-Received: by 2002:a05:6000:2285:b0:3a3:5b59:cb24 with SMTP id
 ffacd0b85a97d-3a3601dc06emr1346027f8f.57.1747384192973; 
 Fri, 16 May 2025 01:29:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd50eda6sm24542785e9.13.2025.05.16.01.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:29:51 -0700 (PDT)
Message-ID: <948387ff-3caf-4cd0-adeb-a71f98ce73b6@redhat.com>
Date: Fri, 16 May 2025 10:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 19/42] vfio/pci: vfio_notifier_init cpr parameters
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-20-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-20-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Pass vdev and nr to vfio_notifier_init, for use by CPR in a subsequent
> patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dad6209..bfeaafa 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -56,7 +56,8 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> -static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
> +static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
> +                               const char *name, int nr, Error **errp)
>   {
>       int ret = event_notifier_init(e, 0);
>   
> @@ -146,7 +147,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       pci_irq_deassert(&vdev->pdev);
>   
>       /* Get an eventfd for resample/unmask */
> -    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
> +    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
>           goto fail;
>       }
>   
> @@ -299,7 +300,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       }
>   #endif
>   
> -    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
> +    if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
> +                            errp)) {
>           return false;
>       }
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
> @@ -485,7 +487,8 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
>           return;
>       }
>   
> -    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
> +    if (!vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr,
> +                            NULL)) {
>           goto fail_notifier;
>       }
>   
> @@ -528,7 +531,7 @@ static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>   
>       vector->vdev = vdev;
>       vector->virq = -1;
> -    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
> +    if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr, &err)) {
>           error_report_err(err);
>       }
>       vector->use = true;
> @@ -765,7 +768,8 @@ retry:
>           vector->virq = -1;
>           vector->use = true;
>   
> -        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
> +        if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i,
> +                                &err)) {
>               error_report_err(err);
>           }
>   
> @@ -2918,7 +2922,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
> +    if (!vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0,
> +                            &err)) {
>           error_report_err(err);
>           vdev->pci_aer = false;
>           return;
> @@ -2985,7 +2990,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
> +    if (!vfio_notifier_init(vdev, &vdev->req_notifier, "req_notifier", 0,
> +                            &err)) {
>           error_report_err(err);
>           return;
>       }



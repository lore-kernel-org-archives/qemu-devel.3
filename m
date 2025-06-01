Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BA9C5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZ9-0002J4-9M; Sun, 01 Jun 2025 11:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkZ5-0002F8-6M
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLkZ3-0004e6-LF
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JM95DHwXzlDExy0RWKOhS3EErqNETTYBPlKPucLRpFw=;
 b=a6DDOImgLbpxdiVVq4QAjNEaWDynoA6VWFyHT9eZvStpDNYi5n6f5Snnmko0Twm9wDlUEv
 ReN+jqGdREhTLD1XJgF1xiwr9TbIMgA0yq6yB9s8CBx+XSNvx50yvDRoUiT9yCYZedlXNy
 ZvBTcuog9xjs+MHfRga8rIvnRJlt9P0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-x04SuhJ8PE-7uWudv2p9KA-1; Sun, 01 Jun 2025 11:25:31 -0400
X-MC-Unique: x04SuhJ8PE-7uWudv2p9KA-1
X-Mimecast-MFC-AGG-ID: x04SuhJ8PE-7uWudv2p9KA_1748791531
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso15955035e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791530; x=1749396330;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JM95DHwXzlDExy0RWKOhS3EErqNETTYBPlKPucLRpFw=;
 b=YmL3AFjBsNH8oqNbJvfu/c2M3Fhca0gv43Fb46rVgOHxkhil2T4U0B/3HtuD+sQ1D0
 eM8FwcJHBseXJFTODdJutH7R0zdFnLJEGoF9iYkcGgUuRcBmAta2eUhueTl3N7u6327R
 qiX/kCDmoxPMl4TmRg0U8noqnkYgNqsUs/Ko/Aay+ylFVZr2pGlEa44nNfyHpVe2P9L5
 3KCeNdsTmgOAnm5zBtF/Iq48pYnann7ZxBEehYbhpaA71/JQUrlMuGDQlTDAUYV3q3NW
 YRxOB+TOzYktlJeMQGEpTogJBqt/QeUcso/BTulQrE3cfcMJ+r7JXhtbhUx9MbyB18fp
 LRKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwclASo29RQEBkSLnX0l50+xgHt5nB6NJyJ7Sp+pVMvLy535hjd0GEKsjT4gwa1If0ceepo+txtMhQ@nongnu.org
X-Gm-Message-State: AOJu0Yw9oh9nNxjUYB2yHtjAm1i9DBsrkkVGd9DAFgfyV+xegEcAy1wS
 8XS9MisnTto8xDQR9XTU0BTCEdUbE6Eiru182NP66lPeT+w6q1vwCE7HM2LU1jw3nq24/J59VXk
 ZRp9jVoznmpwV0AsfZfgQFcF55hjkEJMyF0tQQ/0+/MPb7xolV03eJkkw
X-Gm-Gg: ASbGncuywA54Yof8XQgjljCg8zdOmG62L9CDH+47Fjcl0oS0GlTyXr0ms7dxZwyrcl2
 6kTGG3ZUBrpkGc4fWfQ3GzQOx8YqQIsc978VaUkWoCxNKmYhuzfaSehkHg819LGhfUS0+D7IBln
 81uHct78OlljEE18+Pr9kpzLf5JoHdsoE9FloT9GmKltSU/1e+2XWzQyFUeoRIs8WFygQ9CnT0s
 tAlEwqsIf5I/+srDiW46msYjHqwYy3MHQAHlbxYuw8vAsz+MmZZ39n0v/wVb7MHbr7h/wFlZK/U
 prst4XnQclwmF0HZH/c61pZ0R9qX0nQZFFsgmUmeCLdf1F/fMA==
X-Received: by 2002:a5d:5f56:0:b0:3a4:e423:4080 with SMTP id
 ffacd0b85a97d-3a4f89a5b17mr7257376f8f.4.1748791530627; 
 Sun, 01 Jun 2025 08:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw1/KYXqGQquM3zRK6DVFIMyXNuQBQKdpf9ohMQq7TdL6UehGr4mWXe6UgvmACoT3fnzDNCA==
X-Received: by 2002:a5d:5f56:0:b0:3a4:e423:4080 with SMTP id
 ffacd0b85a97d-3a4f89a5b17mr7257363f8f.4.1748791530251; 
 Sun, 01 Jun 2025 08:25:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000d50sm88035115e9.19.2025.06.01.08.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 08:25:29 -0700 (PDT)
Message-ID: <d98982d6-678f-473b-85f7-f547501aa570@redhat.com>
Date: Sun, 1 Jun 2025 17:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 18/43] vfio/pci: vfio_pci_vector_init
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/29/25 21:24, Steve Sistare wrote:
> Extract a subroutine vfio_pci_vector_init.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 840590c..2d6dc54 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -512,6 +512,22 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>       kvm_irqchip_commit_routes(kvm_state);
>   }
>   
> +static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vector->vdev = vdev;
> +    vector->virq = -1;
> +    if (event_notifier_init(&vector->interrupt, 0)) {
> +        error_report("vfio: Error: event_notifier_init failed");
> +    }
> +    vector->use = true;
> +    if (vdev->interrupt == VFIO_INT_MSIX) {
> +        msix_vector_use(pdev, nr);
> +    }
> +}
> +
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> @@ -525,13 +541,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
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
> +        vfio_pci_vector_init(vdev, nr);
>       }
>   
>       qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C5FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqQj-0000il-8t; Fri, 16 May 2025 04:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqQg-0000iO-Kb
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqQd-0004pC-SF
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n03Ot+YyGh/JfCSyhUpx7y8CMunSbbW9OxZf5Z9jT4E=;
 b=NQS8JXYpOnJEXpzyzAGa6txuMa9wvXFTbrp+8U5MwlMJEvpojrqWSuAGf32RVTJRKPMS4E
 Mc2y5se5U8SM2Z6ocK8Gan4vrEiRUxVBNk0O4vIN+OguM2zBo2L9YvV9yEUi/f/lVu8LIP
 LSoOfym2FGajAySkCa1929cREELH0CA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183--5pQ8nH9PAuvYa_pQH7V0g-1; Fri, 16 May 2025 04:28:22 -0400
X-MC-Unique: -5pQ8nH9PAuvYa_pQH7V0g-1
X-Mimecast-MFC-AGG-ID: -5pQ8nH9PAuvYa_pQH7V0g_1747384101
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso10421905e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384101; x=1747988901;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n03Ot+YyGh/JfCSyhUpx7y8CMunSbbW9OxZf5Z9jT4E=;
 b=MGoQ/iTHZ2yM4IHFXBGyO7cu1xZSI34ay5yvbJoKONzCKwXQ9ttUM0XIwPowckiuJP
 dyfLMCdH3sDglKfkJf5hjv5fWwOutfSs+xJci4q5j6ApDOHO4eaGmxbHsnXLnW8EVZzx
 DjJaij3vKi7weSl6DmK1FYn+QsU2P5a5WByIqscqvE/u+9/gTmDys0Oyfd9RP4zG19Hs
 o0lwDaccUwG8rqx074OaPbd9H/EopsWDyGctYuF3TyQ1zVd/0teiFViryuB29JxDY3uu
 RUx9QGeq+w7Ipt5t4R4FARPIDm5C/d6u/nga3pFBrUPpT6Uzqv7f1yHWaDPM5h5nD5yx
 prNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8dngoR/EQLe98grXx9up5jRuOmilV28vXOw/dlQht8s/hn7CSw1HTrEGv6+Xuo9aRQ2yPdVkeZWEF@nongnu.org
X-Gm-Message-State: AOJu0YxWpN8FiYs1fi+yotowHIUoFpbNgzW8Lee3yAFYhxjo2kGCWIDd
 vKp8RargV3Ycnhq4bo/V3JSjhEhz2khuqf7x/gPJjAMiJWU1hXwdWFkNuz3nTqqyN4zVYE3yrSX
 uxAE838zKi7eujVzqLu3S7vXHdALjFghE1Y8qHNc56nc7avDCSylx6cgb
X-Gm-Gg: ASbGncshOX9F5HrdaRk/SVm5b16YTOCC2Dd7styueinXyLmoKTFMKx8fv4jkYG8ePSE
 n93T1g/Fj9d/rXynaOvUjBfk6cDbijJg6gZTgCk6bPnUOAf1x0qXoGJBriSWmPKIxXRYcOo1lbF
 7AyDOyt2pbf8eZOfOoRIrUxybJ7rc/CUGAhXYqN6/NWjBwlvpvnCNjqSRyUAhCrnria7B3jPy5L
 ggiiG686rtAZ8tfBv9uRrNuApLozWtY6uJ0yh6nuONo2u0J+BGhzLzwWCb2XsIuG2tgP8M2L5UF
 Eac4sSeT6XM1LIRw6RPI7+w1MqZ2brpP+Sn62vBpwAAuT0IE9g==
X-Received: by 2002:a05:600c:6292:b0:441:d228:1fe5 with SMTP id
 5b1f17b1804b1-442fd679172mr21046885e9.33.1747384101390; 
 Fri, 16 May 2025 01:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtEGiOYVs9MuJuUiq/KNyKIuPRO6/hWvaJJhYgtlaHpRGtW0MBcQPuDCKEJwdTMJp6cAH7qA==
X-Received: by 2002:a05:600c:6292:b0:441:d228:1fe5 with SMTP id
 5b1f17b1804b1-442fd679172mr21046585e9.33.1747384100901; 
 Fri, 16 May 2025 01:28:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3951b62sm101336885e9.22.2025.05.16.01.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:28:19 -0700 (PDT)
Message-ID: <075a987b-0312-4175-88b4-2042dea4efeb@redhat.com>
Date: Fri, 16 May 2025 10:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 18/42] vfio/pci: pass vector to virq functions
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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
> Pass the vector number to vfio_connect_kvm_msi_virq and
> vfio_remove_kvm_msi_virq, so it can be passed to their subroutines in
> a subsequent patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4159deb..dad6209 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -477,7 +477,7 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>                                                vector_n, &vdev->pdev);
>   }
>   
> -static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
> +static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
>   {
>       const char *name = "kvm_interrupt";
>   
> @@ -503,7 +503,8 @@ fail_notifier:
>       vector->virq = -1;
>   }
>   
> -static void vfio_remove_kvm_msi_virq(VFIOMSIVector *vector)
> +static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> +                                     int nr)
>   {
>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
>                                             vector->virq);
> @@ -561,7 +562,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>        */
>       if (vector->virq >= 0) {
>           if (!msg) {
> -            vfio_remove_kvm_msi_virq(vector);
> +            vfio_remove_kvm_msi_virq(vdev, vector, nr);
>           } else {
>               vfio_update_kvm_msi_virq(vector, *msg, pdev);
>           }
> @@ -573,7 +574,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                   vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>                   vfio_add_kvm_msi_virq(vdev, vector, nr, true);
>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
> -                vfio_connect_kvm_msi_virq(vector);
> +                vfio_connect_kvm_msi_virq(vector, nr);
>               }
>           }
>       }
> @@ -681,7 +682,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>       kvm_irqchip_commit_route_changes(&vfio_route_change);
>   
>       for (i = 0; i < vdev->nr_vectors; i++) {
> -        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
> +        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
>       }
>   }
>   
> @@ -821,7 +822,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
>           VFIOMSIVector *vector = &vdev->msi_vectors[i];
>           if (vdev->msi_vectors[i].use) {
>               if (vector->virq >= 0) {
> -                vfio_remove_kvm_msi_virq(vector);
> +                vfio_remove_kvm_msi_virq(vdev, vector, i);
>               }
>               qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>                                   NULL, NULL, NULL);



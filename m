Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541A3C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsBe-0007ga-66; Mon, 05 May 2025 05:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsBV-0007cs-Ha
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsBS-0002DD-J5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746437541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kZVIdLF3cz3dayNgXwtf58QcW3uMyqdujIhNXBemGNA=;
 b=PqSn3U0Fki8Teuf/vYU+JTGAliecJWTGxn/8evc7F4MNUOWy6Pps43bLFKOsbpekoG67Db
 oPFYGINj0h/k3JgHnxHlGoxd6djLN3pot0tjMim5LZ7hm52I0aNHvaiRR8DdEn2XeFWEF5
 qLWfJgo/p7bW8MEmWsJsk3NxajStH14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Cd6ozzYfOVmdF61aTSOD5g-1; Mon, 05 May 2025 05:32:20 -0400
X-MC-Unique: Cd6ozzYfOVmdF61aTSOD5g-1
X-Mimecast-MFC-AGG-ID: Cd6ozzYfOVmdF61aTSOD5g_1746437539
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so30314025e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437539; x=1747042339;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZVIdLF3cz3dayNgXwtf58QcW3uMyqdujIhNXBemGNA=;
 b=wvJhYk5F0wImomX/oegcJULMkF1mGObd5YTG9pTKlxTjqgRy6WQgPyLpLNPuYB8H6W
 5X1msxY6YJu4ioyRIeGVU1RRkMtSzatxKPVT+B9PuilglsW3hg4UrjHqxK3gYLgwxL4N
 hP4N8/RdDAueTYLxQelHRowo0aeuVaZJaPJEyVcTy0WCQ1YJMF3DX6/hzQB3uMdG9MUe
 1GUbR/cRXJzKc7F2xq4RAQThflzfOCTh0KMailCqFHInFT3TUxJ+UYhsM1jIDquJ1ZJc
 6MGtGeatf5mmN8KQkBcnbd66LiSN1GysAlEE5aHxeA9DmD/oy0UId3+nA6gVhjQnm+ls
 5vMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWilKF7lzC5/Q137RMQnQ6RNRMj9qYdI/4Mlrfx0ggWCAlArFPa9cyTp18iTa1ZK4aWtFyDQj+5RBNO@nongnu.org
X-Gm-Message-State: AOJu0Yw3SDS1rg6QfPpk9skeYiyYQm6m1M4ZsznsVNrYuC/1cjPTOZZ/
 zjoj77SeQ0WfqII7oZ9nhGTevEoi5fCf6Ny30IGBkkRgOOcwtld1/S/8z9xd2PZdNQaRS31HL8m
 v4Sj3InwWvB8rd/AVoxP05WKTKSAlFsaO9a2esD7L7jnXzPIQM1+c
X-Gm-Gg: ASbGncvP+PYP15ki2S95gTqwgyTi7cd28AvmdnARks52R7Ymfj+06aB+vKqIxf8AnYP
 3tP6Fdda+HEWoZFLNn8P5ubNRGHipQyVedPuGbr6geWlGxkmWPcOFeXj3MopRvhjNpPSf316cgF
 ugHeZHqUvI3akaATyflhIwpf2e697jq73R2yWUl7ljx85OeGMw1sVkal8Kvh7XeIa07lUz2BerM
 GG6zsB3/byT6LL1OpFoNuZKKsre2F6COo8ZbHhe8gkJHibnIH1sI6HN+Zj6hIJW0QSupekLkvx+
 z46gMsCV18PuHBZKBU39cKtD1iBHqyMcWOIwYFmKAGlxI3U6Mw==
X-Received: by 2002:a5d:6e89:0:b0:3a0:a19f:1117 with SMTP id
 ffacd0b85a97d-3a0a19f1123mr3236939f8f.44.1746437538890; 
 Mon, 05 May 2025 02:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3FXsrORSecklYK/SLXwZjBEyguyIPEtHp6xOTPtqAOs9JemAxrx71f4prMIZzskVupMfJRA==
X-Received: by 2002:a5d:6e89:0:b0:3a0:a19f:1117 with SMTP id
 ffacd0b85a97d-3a0a19f1123mr3236914f8f.44.1746437538516; 
 Mon, 05 May 2025 02:32:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0f16fsm9797582f8f.77.2025.05.05.02.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:32:18 -0700 (PDT)
Message-ID: <aa51e693-dcb7-42db-a9e5-9d53489880a1@redhat.com>
Date: Mon, 5 May 2025 11:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] vfio: consistently handle return value for
 helpers
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-6-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
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

On 4/30/25 21:39, John Levon wrote:
> Various bits of code that call vfio device APIs should consistently use
> the "return -errno" approach for passing errors back, rather than
> presuming errno is (still) set correctly.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 407cf43387..768c48d7ad 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -398,7 +398,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
>   
>       ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>   
> -    return ret;
> +    return ret < 0 ? -errno : ret;
>   }
>   
>   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> @@ -459,7 +459,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>   
>       g_free(irq_set);
>   
> -    return ret;
> +    return ret < 0 ? -errno : ret;
>   }
>   
>   static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
> @@ -581,7 +581,8 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>               vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
>               ret = vfio_enable_vectors(vdev, true);
>               if (ret) {
> -                error_report("vfio: failed to enable vectors, %d", ret);
> +                error_report("vfio: failed to enable vectors, %s",
> +                             strerror(-ret));
>               }
>           } else {
>               Error *err = NULL;
> @@ -695,7 +696,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>       if (vdev->nr_vectors) {
>           ret = vfio_enable_vectors(vdev, true);
>           if (ret) {
> -            error_report("vfio: failed to enable vectors, %d", ret);
> +            error_report("vfio: failed to enable vectors, %s",
> +                         strerror(-ret));
>           }
>       } else {
>           /*
> @@ -712,7 +714,8 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
>            */
>           ret = vfio_enable_msix_no_vec(vdev);
>           if (ret) {
> -            error_report("vfio: failed to enable MSI-X, %d", ret);
> +            error_report("vfio: failed to enable MSI-X, %s",
> +                         strerror(-ret));
>           }
>       }
>   
> @@ -765,7 +768,8 @@ retry:
>       ret = vfio_enable_vectors(vdev, false);
>       if (ret) {
>           if (ret < 0) {
> -            error_report("vfio: Error: Failed to setup MSI fds: %m");
> +            error_report("vfio: Error: Failed to setup MSI fds: %s",
> +                         strerror(-ret));
>           } else {
>               error_report("vfio: Error: Failed to enable %d "
>                            "MSI vectors, retry with %d", vdev->nr_vectors, ret);
> @@ -882,17 +886,21 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>   static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   {
>       g_autofree struct vfio_region_info *reg_info = NULL;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint64_t size;
>       off_t off = 0;
>       ssize_t bytes;
> +    int ret;
> +
> +    ret = vfio_device_get_region_info(vbasedev, VFIO_PCI_ROM_REGION_INDEX,
> +                                      &reg_info);
>   
> -    if (vfio_device_get_region_info(&vdev->vbasedev,
> -                                    VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
> -        error_report("vfio: Error getting ROM info: %m");
> +    if (ret != 0) {
> +        error_report("vfio: Error getting ROM info: %s", strerror(-ret));
>           return;
>       }
>   
> -    trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
> +    trace_vfio_pci_load_rom(vbasedev->name, (unsigned long)reg_info->size,
>                               (unsigned long)reg_info->offset,
>                               (unsigned long)reg_info->flags);
>   
> @@ -901,8 +909,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>   
>       if (!vdev->rom_size) {
>           vdev->rom_read_failed = true;
> -        error_report("vfio-pci: Cannot read device rom at "
> -                    "%s", vdev->vbasedev.name);
> +        error_report("vfio-pci: Cannot read device rom at %s", vbasedev->name);
>           error_printf("Device option ROM contents are probably invalid "
>                       "(check dmesg).\nSkip option ROM probe with rombar=0, "
>                       "or load from file with romfile=\n");
> @@ -913,7 +920,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       memset(vdev->rom, 0xff, size);
>   
>       while (size) {
> -        bytes = pread(vdev->vbasedev.fd, vdev->rom + off,
> +        bytes = pread(vbasedev->fd, vdev->rom + off,
>                         size, vdev->rom_offset + off);
>           if (bytes == 0) {
>               break;



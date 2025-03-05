Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06A1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppqd-0001G6-EV; Wed, 05 Mar 2025 09:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tppqF-00018u-E9
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tppqC-00089z-PZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741185319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IsBZ/DFpq5C9sGK6lNAJ+pjPanDa0oYkvLiR+0Lf1ZM=;
 b=IOdH87g/75Ksv0JsQp5y+X9mSqypCqElUDkJIcNfi1DG0jumO8tMYu7dSlGUwFCILl/MhA
 VJfu9jA+ZZG2Udt6gY9+6K/VHOOBl/29Y1VmDzfQ0zbfJnqWtZtReYauYBfR+Cy5iare/i
 PdAr1NxkFls7wFeyjDEYtTckqRwlp6M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-62h3elZUOqawLXZyAz-P7g-1; Wed, 05 Mar 2025 09:35:16 -0500
X-MC-Unique: 62h3elZUOqawLXZyAz-P7g-1
X-Mimecast-MFC-AGG-ID: 62h3elZUOqawLXZyAz-P7g_1741185316
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390fd681712so1938718f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 06:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741185315; x=1741790115;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IsBZ/DFpq5C9sGK6lNAJ+pjPanDa0oYkvLiR+0Lf1ZM=;
 b=sb+oZ9px760l4ENYCmVHxRpNMR8dRh098UPhVFTavTngllbqkr+gCdWdBd2LjL6WW/
 GYTLfb9iiBvS/c+Hry2KZNoivuKkLX0yqJoL/Wqsdl+xU7URL6NG1zFsG65zywky/LWP
 Lvfc8ijx4znRP7KojXnKrfu4kJl5GWe13/ePD1wNm8EK6aQeQuyVmgPB9L1Akevqjex3
 1b7GibkUM+rqk4SmeyS9IFdEZAmLUxawrQlgZd5xL3mZgzSMYSQv/yQHi9KS+P3arr8M
 Gg9R1iyzW/yurqHkmMB0hMbOQ5+VY6fdSJOVYvhIi6jejSGqS1Eo0oXnN8dmqArDTSSp
 ZIqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGlmNn7BYBjpiMLbDcbaFF9YEiQ23j+HKHeQjGjEoDUcgLM0iGpFimkjD4h91m/FCSpKVBmBrzlEWN@nongnu.org
X-Gm-Message-State: AOJu0YzdN/9USBv839F8wfyoGR+AhUHggAfTFe5f/PrzNgFDOByVM1X8
 MyScc9rT6JyXTlla98KOCjE6VuwOU0xgcaqTBG495Qt5H0bXoo/2CA56n+Xb1oiepIfsGtGJ0U3
 et+gjdMeyzvpn8ATufByCOnXdmNaXzn2ZCEYs1n6KmyRbeBp6YcxW
X-Gm-Gg: ASbGncvOuK9vU+90n9NBtWkzdSGRVcPSSAFWAcb/mlaoHpOAUnjLTEBhk9N+qyhFPm9
 RI4OUKAn1K8TquPtji2yP3y6onCQ6Dk2HejCRK9GFH4z7+6X1ctbV5/QdzzeVLWrO1/91eT37Rk
 CoPf55J1eDMlMum5QUFD5X8Q5MKdsnkZo/cOw2o73bV/I9XnE2e4fsiZI68EkbXIsi0xFZIw7c3
 Eku3C4rGAvuufFzK0P06agat2HMkRsIyRDQiIVR9k2CjEBvOW/tfMrNL2LkF3avYtELnm9MDtEx
 p3wriJnf3FmCUkqDstTtbK2enHfau2Q3W66apStTruHxjs8=
X-Received: by 2002:a05:6000:1848:b0:390:db07:87ea with SMTP id
 ffacd0b85a97d-3911f7adc52mr3095378f8f.34.1741185315665; 
 Wed, 05 Mar 2025 06:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ5eK6JX42BinsWVxGeIQ28pOxlOSDNSvZ9ys5z/w4/cYnSv8XCg8/Kgw4/F7OlZ3EvOSQow==
X-Received: by 2002:a05:6000:1848:b0:390:db07:87ea with SMTP id
 ffacd0b85a97d-3911f7adc52mr3095348f8f.34.1741185315323; 
 Wed, 05 Mar 2025 06:35:15 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5dd1sm18917615e9.18.2025.03.05.06.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 06:35:14 -0800 (PST)
Message-ID: <393fdd69-69b9-4d10-8a08-834f0aa82978@redhat.com>
Date: Wed, 5 Mar 2025 15:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: fix cleanup of failed hotplug
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clg@redhat.com, qemu-devel@nongnu.org
References: <20250226210201.238489-1-mjrosato@linux.ibm.com>
 <20250226210201.238489-2-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250226210201.238489-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 26/02/2025 22.02, Matthew Rosato wrote:
> In the unlikely event that we must fail hotplug of a PCI passthrough
> device, ensure appropriate clean up of the associated zPCI device is
> performed.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 913d72cc74..6cc0e7538a 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1119,7 +1119,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                       if (rc) {
>                           error_setg(errp, "Plug failed for zPCI device in "
>                                      "interpretation mode: %d", rc);
> -                        return;
> +                        goto pbdev_cleanup;
>                       }
>                   } else {
>                       trace_s390_pcihost("zPCI interpretation missing");
> @@ -1150,7 +1150,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
>               error_setg(errp, "MSI-X support is mandatory "
>                          "in the S390 architecture");
> -            return;
> +            goto pbdev_cleanup;
>           }
>   
>           if (dev->hotplugged) {
> @@ -1168,6 +1168,23 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       } else {
>           g_assert_not_reached();
>       }
> +
> +    return;
> +
> + pbdev_cleanup:
> +    DeviceState *bdev = DEVICE(pbdev);
> +
> +    if (pbdev->shutdown_notifier.notify) {
> +        notifier_remove(&pbdev->shutdown_notifier);
> +    }
> +    if (pbdev->iommu->dma_limit) {
> +        s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
> +    }
> +    s390_pci_iommu_free(s, pci_get_bus(pbdev->pdev), pbdev->pdev->devfn);
> +    QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
> +    g_hash_table_remove(s->zpci_table, &pbdev->idx);
> +    object_unparent(OBJECT(bdev));
> +    qdev_unrealize(bdev);
>   }

Not sure, but should bdev realy be unrealized here already? Or should that 
rather be done by the caller (when it sees the errp set)?

  Thomas



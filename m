Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF8C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OmU-0007Vi-7q; Tue, 21 May 2024 08:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OmS-0007VG-65
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OmQ-0003FN-Ev
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TSqUY1Aq2xEYXgydASv91LXcfsihx0NZtlM6vL+MxQ=;
 b=jJr8hPXo9v1rQmiPeBXLtDgtCm5bJioldx4MB2evfDvTtgfDDLqZw0xL4EWOMGorZoCkOE
 9hfFJ5wRZjicPBFla+Q07/96R6Qp+5QJnW0qhZ3piw97ImflF7aNw25kncLRaBUxe5B3hs
 ayBn1R+nFWACkNSTMmmLFkCYeSFe/Ys=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-qdwGNCelMrqhhHQyjruDlg-1; Tue, 21 May 2024 08:39:43 -0400
X-MC-Unique: qdwGNCelMrqhhHQyjruDlg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-792e7b1d6a7so1023601285a.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295179; x=1716899979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8TSqUY1Aq2xEYXgydASv91LXcfsihx0NZtlM6vL+MxQ=;
 b=gBOgIt25bBp6N+SbtNvIcgvpmGE98Ojq1aXVWOkTKH0zWSTupog1bNaoKAt8SdCzxj
 lEmqcFM/5vPPGHV+OrVT/IYOzyu+BjdD5R8ItAAqyFhPksya1h+n7yguL9EPOg/kGc3y
 JFmy7fiAKa+3GKgUWBZS8BfDQGQzFZw9dIhkTgLRpHnWHujMysyIhWDvhR1ntIkDrNbv
 vnbXs5z3mZ8Caecu+FA0xzpJcO6hZMmv1UYekp3fzY2ohiBzs2zEjrSC++8/9nreisoz
 M5r8DjVUMf8PVtoooLRakPI2HceSt2Jy5RqUIYQUSHbdq5A2grYE/UlE/h21Kayg5bTF
 fnGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYcPy+pp3PNlHW9MCipMSDWF1HgUbZn/DDv96bXbF8xajRtCvJEK4pGHiiXnXULvLmIuo6PKB1werrvbu12sj/aKt4gfQ=
X-Gm-Message-State: AOJu0YweA9B8R6EcIzgVVYkeM/p07KS1fkxZ+jQDal4ezBZd9jUOs8e5
 9t4JLiS2Af0exNJ32F7VgBK8PV2Hl3R28A4/Cxtw6KIclrFUneKZiimh3SdWxRAGYezRfW5J1G6
 67BXKTRm9V8n5TLF6eyO5rb9tYbiUf8p1ANzbFrLbH/SKH7VBUU4f3kSDmxKo
X-Received: by 2002:a05:620a:4048:b0:792:8693:6602 with SMTP id
 af79cd13be357-792c75f293emr4236621585a.51.1716295179667; 
 Tue, 21 May 2024 05:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeN1R4RkIMVSeRviz2bJbeetd10Tcb5dxzodUBk/YELY+BGhok/OC2Qd8Czv+jJ3d1IZD26g==
X-Received: by 2002:a05:620a:4048:b0:792:8693:6602 with SMTP id
 af79cd13be357-792c75f293emr4236619685a.51.1716295179321; 
 Tue, 21 May 2024 05:39:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7931a60e966sm404108785a.39.2024.05.21.05.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:39:38 -0700 (PDT)
Message-ID: <8221733a-e4d9-4119-b1d5-0e1abda2d714@redhat.com>
Date: Tue, 21 May 2024 14:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] vfio/pci: Make vfio_populate_device() return a bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-11-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Since vfio_populate_device() takes an 'Error **' argument,
> best practices suggest to return a bool. See the qapi/error.h
> Rules section.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 379cbad757..c091d21adf 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2740,7 +2740,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>       return 0;
>   }
>   
> -static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
> +static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   {
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       struct vfio_region_info *reg_info;
> @@ -2750,18 +2750,18 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>       /* Sanity check device */
>       if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PCI)) {
>           error_setg(errp, "this isn't a PCI device");
> -        return;
> +        return false;
>       }
>   
>       if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
>           error_setg(errp, "unexpected number of io regions %u",
>                      vbasedev->num_regions);
> -        return;
> +        return false;
>       }
>   
>       if (vbasedev->num_irqs < VFIO_PCI_MSIX_IRQ_INDEX + 1) {
>           error_setg(errp, "unexpected number of irqs %u", vbasedev->num_irqs);
> -        return;
> +        return false;
>       }
>   
>       for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
> @@ -2773,7 +2773,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to get region %d info", i);
> -            return;
> +            return false;
>           }
>   
>           QLIST_INIT(&vdev->bars[i].quirks);
> @@ -2783,7 +2783,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>                                  VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
>       if (ret) {
>           error_setg_errno(errp, -ret, "failed to get config info");
> -        return;
> +        return false;
>       }
>   
>       trace_vfio_populate_device_config(vdev->vbasedev.name,
> @@ -2804,7 +2804,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>           if (ret) {
>               error_append_hint(errp, "device does not support "
>                                 "requested feature x-vga\n");
> -            return;
> +            return false;
>           }
>       }
>   
> @@ -2821,6 +2821,8 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>                       "Could not enable error recovery for the device",
>                       vbasedev->name);
>       }
> +
> +    return true;
>   }
>   
>   static void vfio_pci_put_device(VFIOPCIDevice *vdev)
> @@ -3036,8 +3038,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> -    vfio_populate_device(vdev, &err);
> -    if (err) {
> +    if (!vfio_populate_device(vdev, &err)) {

why not pass errp directly and avoid error_propagate() ?

Thanks,

C.


>           error_propagate(errp, err);
>           goto error;
>       }



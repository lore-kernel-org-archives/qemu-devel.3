Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CE9C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yKq-00083S-FK; Thu, 24 Apr 2025 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yKa-0007ug-LR
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7yKW-0000K6-HI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 11:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745507854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R1T0cVr0P4wlW6pClxtYjfVdRe5J4Y1/tokdivUs85s=;
 b=foCR+bq2EGohMqfGLXovk1DtSwVkPCOZ56W0A/EtaheNQQ2xLrCGFaMOeeA2pvkDTJ5YFD
 KIDwt70x3nDoHdVh3vTpg3/cn9XhhOB1ve6OlPrFo369F33CdcYiOX5gTvRndBhZ4TrV4U
 YNO3jYsARGd8BlSC4UbiDqdXzlDYKus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-SFGn-RYhOQ6aqLhIVXMd5g-1; Thu, 24 Apr 2025 11:17:32 -0400
X-MC-Unique: SFGn-RYhOQ6aqLhIVXMd5g-1
X-Mimecast-MFC-AGG-ID: SFGn-RYhOQ6aqLhIVXMd5g_1745507851
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so6387335e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745507851; x=1746112651;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1T0cVr0P4wlW6pClxtYjfVdRe5J4Y1/tokdivUs85s=;
 b=mUt0Tpat8a7PT8QkCx+FC6EZXelhAfQrsC3Pc+z6wmqZlG7QO9lolS/LfNRLA7ESlr
 6Zcj2vMr6lPmB9pr9vMsgVfEjguSRwr1TdJJqoY3+vq2/HOiu5SEcdS8M+kirJFyGMN3
 vk2GaXDmaAmtdnQvp0EZmcXOCNr30gJeCK/ZCczON+1xZEdMSxfKbbw8Yl2lttPJ909m
 j+igqSkdnsFZPSedTCIDsnfB9GeuLg/LnFQHlY9V/wWsHRCmZZuWbEN5YmfDCN6eY6kK
 iAz6g12ur+mbnk4hD/4Fu3VrAZ7hYoEEVNiS16pqNdv9tfGR7R/2yVxYp7rpfZmzzHyd
 XEaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKApzTo38slkHJyNn8BU/Lkv1M8pWN1B63eEmUlfM54z78S5uPtfBWbxaMSajZCqDx3UpREJ5nJgRA@nongnu.org
X-Gm-Message-State: AOJu0YzgxDqQV5xvkT49cbfF88WI4I6s2IgLOcOP/2csq0xrmGGesVgT
 Zhnhp70uuDD2V1i+SKfOcvbC3nXFqeRLq7mtMzgFS+eKHYTJ2YfBlf1seHtzEw9jvHBFEKXAFXe
 sFmSIp358xaSylkSzrP5VN3gf7pxSkL1dfMbSol+EAMMZwViaqBzl
X-Gm-Gg: ASbGncuA3rZtXscW17OXaouCVDjsJgDugSG+gQI+5dRqsYqH1514tOu3zwXqGcbdsq8
 V5bfdwka6QOoaau9uDNS+/TPkagi02WEAuJUOlSBNrvdMjM/4c+8Gpwnbz94c7k+whU9wDOW0DQ
 u949fMTfxO1+gp8aKUzcPJI+MAjC8FVC5hM+nsc+pbGCQE7dGAt7Oj2JrW0koIgahnGU7zl20jf
 T3tI8bDpCB4RyKGq//ic3dos+KUyonoUN5CjYjgxiu3/R0jGWkWVYfpPtYuAxewEYos+VXyJFkn
 MhpBcVGOZTwkqv02P8sllbLUjiwz9oggZreU1JDpBaW0+6Y=
X-Received: by 2002:a05:6000:1888:b0:390:eacd:7009 with SMTP id
 ffacd0b85a97d-3a06cfa2c07mr2270620f8f.42.1745507850659; 
 Thu, 24 Apr 2025 08:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKvJLHRXluinFXdoaEgpnoxhqb9wy7bwtLk/0TaJ57ixxj8lPXr3z15XoLg6QrG3VaA1QPEg==
X-Received: by 2002:a05:6000:1888:b0:390:eacd:7009 with SMTP id
 ffacd0b85a97d-3a06cfa2c07mr2270570f8f.42.1745507850020; 
 Thu, 24 Apr 2025 08:17:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54c35bsm2343609f8f.85.2025.04.24.08.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 08:17:29 -0700 (PDT)
Message-ID: <3f53b147-2517-4650-8e87-0b6bc7f36794@redhat.com>
Date: Thu, 24 Apr 2025 17:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: add vfio-pci-base class
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-9-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-9-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On 4/9/25 15:48, John Levon wrote:
> Split out parts of TYPE_VFIO_PCI into a base TYPE_VFIO_PCI_BASE. The
> base type contains properties generic to all vfio-pci implementations
> (although we have not yet introduced another subclass).
> 
> Note that currently there is no need for additional data for
> TYPE_VFIO_PCI, so it shares the same C struct type as
> TYPE_VFIO_PCI_BASE, VFIOPCIDevice.

I don't understand how the properties are distributed between the
abstract vfio-pci base class and the vfio-pci class. What's the
rationale ?

Can you remind me why the vfio-pci class for vfio-user can not
inherit directly from vfio-pci ?

Thanks,

C.

  
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/device.c |   2 +-
>   hw/vfio/pci.c    | 266 ++++++++++++++++++++++++++---------------------
>   hw/vfio/pci.h    |  12 ++-
>   3 files changed, 156 insertions(+), 124 deletions(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index f74b9c25ea..b9473878fc 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -361,7 +361,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>   VFIODevice *vfio_get_vfio_device(Object *obj)
>   {
>       if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
> -        return &VFIO_PCI(obj)->vbasedev;
> +        return &VFIO_PCI_BASE(obj)->vbasedev;
>       } else {
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 81bf0dab28..090b2f2ef0 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -241,7 +241,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>   
>   static void vfio_intx_routing_notifier(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       PCIINTxRoute route;
>   
>       if (vdev->interrupt != VFIO_INT_INTx) {
> @@ -516,7 +516,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                      MSIMessage *msg, IOHandler *handler)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector;
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
> @@ -621,7 +621,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
>   
>   static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>   
>       trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
> @@ -1169,7 +1169,7 @@ static const MemoryRegionOps vfio_vga_ops = {
>    */
>   static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIORegion *region = &vdev->bars[bar].region;
>       MemoryRegion *mmap_mr, *region_mr, *base_mr;
>       PCIIORegion *r;
> @@ -1215,7 +1215,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>    */
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
>       memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1248,7 +1248,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       uint32_t val_le = cpu_to_le32(val);
>   
>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
> @@ -3091,7 +3091,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       int i, ret;
>       char uuid[UUID_STR_LEN];
> @@ -3260,7 +3260,7 @@ error:
>   
>   static void vfio_instance_finalize(Object *obj)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>   
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -3278,7 +3278,7 @@ static void vfio_instance_finalize(Object *obj)
>   
>   static void vfio_exitfn(PCIDevice *pdev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       vfio_unregister_req_notifier(vdev);
> @@ -3302,7 +3302,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>   
>   static void vfio_pci_reset(DeviceState *dev)
>   {
> -    VFIOPCIDevice *vdev = VFIO_PCI(dev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
>   
>       trace_vfio_pci_reset(vdev->vbasedev.name);
>   
> @@ -3342,7 +3342,7 @@ post_reset:
>   static void vfio_instance_init(Object *obj)
>   {
>       PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = VFIO_PCI(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
>       device_add_bootindex_property(obj, &vdev->bootindex,
> @@ -3365,32 +3365,15 @@ static void vfio_instance_init(Object *obj)
>   
>   static PropertyInfo vfio_pci_migration_multifd_transfer_prop;
>   
> -static const Property vfio_pci_dev_properties[] = {
> -    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> -    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> -    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +static const Property vfio_pci_base_dev_properties[] = {
>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
>                               vbasedev.pre_copy_dirty_page_tracking,
>                               ON_OFF_AUTO_ON),
>       DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
>                               vbasedev.device_dirty_page_tracking,
>                               ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> -                            display, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> -    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
>       DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
>                          intx.mmap_timeout, 1100),
> -    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
> -    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
> -    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> -    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
> -                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
> -    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
> -                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP("x-migration-multifd-transfer", VFIOPCIDevice,
> @@ -3405,8 +3388,6 @@ static const Property vfio_pci_dev_properties[] = {
>       DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>       DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>       DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
> -    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> -                     no_geforce_quirks, false),
>       DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>                        false),
>       DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
> @@ -3417,61 +3398,55 @@ static const Property vfio_pci_dev_properties[] = {
>                          sub_vendor_id, PCI_ANY_ID),
>       DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                          sub_device_id, PCI_ANY_ID),
> -    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> -    DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
> -                                   nv_gpudirect_clique,
> -                                   qdev_prop_nv_gpudirect_clique, uint8_t),
>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
>                                   OFF_AUTO_PCIBAR_OFF),
> -#ifdef CONFIG_IOMMUFD
> -    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
> -                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> -#endif
> -    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
>   };
>   
> -#ifdef CONFIG_IOMMUFD
> -static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> -{
> -    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
> -}
> -#endif
>   
> -static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> +static void vfio_pci_base_dev_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
>   
> -    device_class_set_legacy_reset(dc, vfio_pci_reset);
> -    device_class_set_props(dc, vfio_pci_dev_properties);
> -#ifdef CONFIG_IOMMUFD
> -    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> -#endif
> -    dc->desc = "VFIO-based PCI device assignment";
> +    device_class_set_props(dc, vfio_pci_base_dev_properties);
> +    dc->desc = "VFIO PCI base device";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -    pdc->realize = vfio_realize;
>       pdc->exit = vfio_exitfn;
>       pdc->config_read = vfio_pci_read_config;
>       pdc->config_write = vfio_pci_write_config;
>   
> -    object_class_property_set_description(klass, /* 1.3 */
> -                                          "host",
> -                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 5.2 */
> +                                          "x-pre-copy-dirty-page-tracking",
> +                                          "Disable dirty pages tracking during iterative phase "
> +                                          "(DEBUG)");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "x-device-dirty-page-tracking",
> +                                          "Disable device dirty page tracking and use "
> +                                          "container-based dirty page tracking");
>       object_class_property_set_description(klass, /* 1.3 */
>                                             "x-intx-mmap-timeout-ms",
>                                             "When EOI is not provided by KVM/QEMU, wait time "
>                                             "(milliseconds) to re-enable device direct access "
>                                             "after INTx (DEBUG)");
> -    object_class_property_set_description(klass, /* 1.5 */
> -                                          "x-vga",
> -                                          "Expose VGA address spaces for device");
> -    object_class_property_set_description(klass, /* 2.3 */
> -                                          "x-req",
> -                                          "Disable device request notification support (DEBUG)");
> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
> +                                          "enable-migration",
> +                                          "Enale device migration. Also requires a host VFIO PCI "
> +                                          "variant or mdev driver with migration support enabled");
> +    object_class_property_set_description(klass, /* 10.0 */
> +                                          "x-migration-multifd-transfer",
> +                                          "Transfer this device state via "
> +                                          "multifd channels when live migrating it");
> +    object_class_property_set_description(klass, /* 9.1 */
> +                                          "migration-events",
> +                                          "Emit VFIO migration QAPI event when a VFIO device "
> +                                          "changes its migration state. For management applications");
>       object_class_property_set_description(klass, /* 2.4 and 2.5 */
>                                             "x-no-mmap",
>                                             "Disable MMAP for device. Allows to trace MMIO "
>                                             "accesses (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.1 */
> +                                          "x-balloon-allowed",
> +                                          "Override allowing ballooning with device (DEBUG, DANGER)");
>       object_class_property_set_description(klass, /* 2.5 */
>                                             "x-no-kvm-intx",
>                                             "Disable direct VFIO->KVM INTx injection. Allows to "
> @@ -3484,6 +3459,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>                                             "x-no-kvm-msix",
>                                             "Disable direct VFIO->KVM MSIx injection. Allows to "
>                                             "trace MSIx interrupts (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-kvm-ioeventfd",
> +                                          "Disable registration of ioeventfds with KVM (DEBUG)");
> +    object_class_property_set_description(klass, /* 3.0 */
> +                                          "x-no-vfio-ioeventfd",
> +                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
> +                                          "(DEBUG)");
>       object_class_property_set_description(klass, /* 2.5 */
>                                             "x-pci-vendor-id",
>                                             "Override PCI Vendor ID with provided value (DEBUG)");
> @@ -3498,95 +3480,136 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>                                             "x-pci-sub-device-id",
>                                             "Override PCI Subsystem Device ID with provided value "
>                                             "(DEBUG)");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "x-msix-relocation",
> +                                          "Specify MSI-X MMIO relocation to the end of specified "
> +                                          "existing BAR or new BAR to avoid virtualization overhead "
> +                                          "due to adjacent device registers");
> +}
> +
> +static const TypeInfo vfio_pci_base_dev_info = {
> +    .name = TYPE_VFIO_PCI_BASE,
> +    .parent = TYPE_PCI_DEVICE,
> +    .instance_size = 0,
> +    .abstract = true,
> +    .class_init = vfio_pci_base_dev_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
> +};
> +
> +static const Property vfio_pci_dev_properties[] = {
> +    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
> +    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
> +    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
> +    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> +                            display, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
> +    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
> +    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
> +    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
> +    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
> +    DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
> +    DEFINE_PROP_BIT("x-igd-lpc", VFIOPCIDevice, features,
> +                    VFIO_FEATURE_ENABLE_IGD_LPC_BIT, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
> +                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> +                     no_geforce_quirks, false),
> +    DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
> +                                   nv_gpudirect_clique,
> +                                   qdev_prop_nv_gpudirect_clique, uint8_t),
> +#ifdef CONFIG_IOMMUFD
> +    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
> +                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
> +#endif
> +    DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
> +};
> +
> +#ifdef CONFIG_IOMMUFD
> +static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    vfio_device_set_fd(&vdev->vbasedev, str, errp);
> +}
> +#endif
> +
> +static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, vfio_pci_reset);
> +    device_class_set_props(dc, vfio_pci_dev_properties);
> +#ifdef CONFIG_IOMMUFD
> +    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
> +#endif
> +    dc->desc = "VFIO-based PCI device assignment";
> +    pdc->realize = vfio_realize;
> +
> +    object_class_property_set_description(klass, /* 1.3 */
> +                                          "host",
> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
> +    object_class_property_set_description(klass, /* 8.1 */
> +                                          "vf-token",
> +                                          "Specify UUID VF token. Required for VF when PF is owned "
> +                                          "by another VFIO driver");
>       object_class_property_set_description(klass, /* 2.6 */
>                                             "sysfsdev",
>                                             "Host sysfs path of assigned device");
> +    object_class_property_set_description(klass, /* 2.12 */
> +                                          "display",
> +                                          "Enable display support for device, ex. vGPU");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "xres",
> +                                          "Set X display resolution the vGPU should use");
> +    object_class_property_set_description(klass, /* 3.2 */
> +                                          "yres",
> +                                          "Set Y display resolution the vGPU should use");
> +    object_class_property_set_description(klass, /* 1.5 */
> +                                          "x-vga",
> +                                          "Expose VGA address spaces for device");
> +    object_class_property_set_description(klass, /* 2.3 */
> +                                          "x-req",
> +                                          "Disable device request notification support (DEBUG)");
>       object_class_property_set_description(klass, /* 2.7 */
>                                             "x-igd-opregion",
>                                             "Expose host IGD OpRegion to guest");
>       object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
>                                             "x-igd-gms",
>                                             "Override IGD data stolen memory size (32MiB units)");
> -    object_class_property_set_description(klass, /* 2.11 */
> -                                          "x-nv-gpudirect-clique",
> -                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
> -                                          "clique for device [0-15]");
>       object_class_property_set_description(klass, /* 2.12 */
>                                             "x-no-geforce-quirks",
>                                             "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). "
>                                             "Improves performance");
> -    object_class_property_set_description(klass, /* 2.12 */
> -                                          "display",
> -                                          "Enable display support for device, ex. vGPU");
> -    object_class_property_set_description(klass, /* 2.12 */
> -                                          "x-msix-relocation",
> -                                          "Specify MSI-X MMIO relocation to the end of specified "
> -                                          "existing BAR or new BAR to avoid virtualization overhead "
> -                                          "due to adjacent device registers");
> -    object_class_property_set_description(klass, /* 3.0 */
> -                                          "x-no-kvm-ioeventfd",
> -                                          "Disable registration of ioeventfds with KVM (DEBUG)");
> -    object_class_property_set_description(klass, /* 3.0 */
> -                                          "x-no-vfio-ioeventfd",
> -                                          "Disable linking of KVM ioeventfds to VFIO ioeventfds "
> -                                          "(DEBUG)");
> -    object_class_property_set_description(klass, /* 3.1 */
> -                                          "x-balloon-allowed",
> -                                          "Override allowing ballooning with device (DEBUG, DANGER)");
> -    object_class_property_set_description(klass, /* 3.2 */
> -                                          "xres",
> -                                          "Set X display resolution the vGPU should use");
> -    object_class_property_set_description(klass, /* 3.2 */
> -                                          "yres",
> -                                          "Set Y display resolution the vGPU should use");
> -    object_class_property_set_description(klass, /* 5.2 */
> -                                          "x-pre-copy-dirty-page-tracking",
> -                                          "Disable dirty pages tracking during iterative phase "
> -                                          "(DEBUG)");
> -    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
> -                                          "enable-migration",
> -                                          "Enale device migration. Also requires a host VFIO PCI "
> -                                          "variant or mdev driver with migration support enabled");
> -    object_class_property_set_description(klass, /* 8.1 */
> -                                          "vf-token",
> -                                          "Specify UUID VF token. Required for VF when PF is owned "
> -                                          "by another VFIO driver");
> +    object_class_property_set_description(klass, /* 2.11 */
> +                                          "x-nv-gpudirect-clique",
> +                                          "Add NVIDIA GPUDirect capability indicating P2P DMA "
> +                                          "clique for device [0-15]");
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_set_description(klass, /* 9.0 */
>                                             "iommufd",
>                                             "Set host IOMMUFD backend device");
>   #endif
> -    object_class_property_set_description(klass, /* 9.1 */
> -                                          "x-device-dirty-page-tracking",
> -                                          "Disable device dirty page tracking and use "
> -                                          "container-based dirty page tracking");
> -    object_class_property_set_description(klass, /* 9.1 */
> -                                          "migration-events",
> -                                          "Emit VFIO migration QAPI event when a VFIO device "
> -                                          "changes its migration state. For management applications");
>       object_class_property_set_description(klass, /* 9.1 */
>                                             "skip-vsc-check",
>                                             "Skip config space check for Vendor Specific Capability. "
>                                             "Setting to false will enforce strict checking of VSC content "
>                                             "(DEBUG)");
> -    object_class_property_set_description(klass, /* 10.0 */
> -                                          "x-migration-multifd-transfer",
> -                                          "Transfer this device state via "
> -                                          "multifd channels when live migrating it");
>   }
>   
>   static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
> -    .parent = TYPE_PCI_DEVICE,
> +    .parent = TYPE_VFIO_PCI_BASE,
>       .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_dev_class_init,
>       .instance_init = vfio_instance_init,
>       .instance_finalize = vfio_instance_finalize,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_PCIE_DEVICE },
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { }
> -    },
>   };
>   
>   static const Property vfio_pci_dev_nohotplug_properties[] = {
> @@ -3632,6 +3655,7 @@ static void register_vfio_pci_dev_type(void)
>       vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
>       vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
>   
> +    type_register_static(&vfio_pci_base_dev_info);
>       type_register_static(&vfio_pci_dev_info);
>       type_register_static(&vfio_pci_nohotplug_dev_info);
>   }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index cbea3be029..4000ba804c 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -118,8 +118,13 @@ typedef struct VFIOMSIXInfo {
>       bool noresize;
>   } VFIOMSIXInfo;
>   
> -#define TYPE_VFIO_PCI "vfio-pci"
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
> +/*
> + * TYPE_VFIO_PCI_BASE is an abstract type used to share code
> + * between VFIO implementations that use a kernel driver
> + * with those that use user sockets.
> + */
> +#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   
>   struct VFIOPCIDevice {
>       PCIDevice pdev;
> @@ -187,6 +192,9 @@ struct VFIOPCIDevice {
>       Notifier irqchip_change_notifier;
>   };
>   
> +#define TYPE_VFIO_PCI "vfio-pci"
> +/* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
> +
>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
>   static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
>   {



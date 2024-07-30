Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AAEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoRj-0005tz-Oe; Tue, 30 Jul 2024 11:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sYoRi-0005oD-7C
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sYoRf-0004DL-O9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722352043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ke8GKRqB2B+6FqIK+oRdAuIevXRCY/7RxOajgnb0gF4=;
 b=HnBrjHZ3/qzEnpAoq3ixt3XICcpYd8oozYX7ZJYTuMgiuigcKbJmaxyrbg7eVv+AEPi6Db
 2Mn+N0lF4eROXQBTy/uBiLggPbPIqUV1jMSiFTMZuzoP5hrAUlj6/idr9CcMcg8v0IShjp
 pf5Hk0iNjYfkn/leY4kc/DfVAduYVWc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Ziw7GFQPOvi15xlDjSMpRg-1; Tue, 30 Jul 2024 11:07:20 -0400
X-MC-Unique: Ziw7GFQPOvi15xlDjSMpRg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36873a449dfso1610403f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722352036; x=1722956836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ke8GKRqB2B+6FqIK+oRdAuIevXRCY/7RxOajgnb0gF4=;
 b=GihO+Lfu5tIvdYlgCpcNNaGg7e41KO2di6GeQGdWSy1TOURDaUKV4UiNBPgvmYzVtT
 xXYSgsG5rtP+LRMFj8XebqeekUDwtCKdISm73t2JMkERNmV7qVKHDTDM7CQ9u49mzsdk
 4f6pu5yNga8q5ek9klvpfWIxJkOkOhGuxA2hqaWtncnGxIamjhvNaYr/8XGZNda2D1LZ
 qYaGhj037xDkQMC07PuKNDODc2CFrbzLzW8aY7wvn8ggAP2Vp3p5dV/XQ9b7ElKxhp2w
 v93LwMw/nxbtsqTU2DDrRRJU9q9Gk76EnAaAo5FWbZAhM/j/bq6w7/GVMy35xrk8cGd+
 3J5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9zdxMS1dNqMwicn9h0GQmhS3lP8Ryo/ZDdHZB6lmaz74d0d0h8DfyOqL5ML9+7XtyjXUniVwDdGxIAaAP0HSd31LYCO0=
X-Gm-Message-State: AOJu0YxbXcPgiTM5HUMdLRL1rOtDYRroJwKvC9RCLH+Qx6ZVS9LE+izp
 99vYE6bH4761ArYNs3ssTIdU3ImJ09YDFC6JkW+rdggaD/oZV3qyVmCI6cH5/fW17wQtWg7YQLq
 Hqih0dzqOrCRS5rATPt6MXQnPH55MID0a1Ry83cfZ5grVI37MJ8v0
X-Received: by 2002:adf:e3d1:0:b0:35f:fd7:6102 with SMTP id
 ffacd0b85a97d-36b8c8edd66mr1308650f8f.35.1722352036512; 
 Tue, 30 Jul 2024 08:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBOtx3KIyHkoXcHB3B3oYrSLn3CftG9WjtV40vTkKL7hv1TsvqurIpgwbpj+2j2dGgVUdBFg==
X-Received: by 2002:adf:e3d1:0:b0:35f:fd7:6102 with SMTP id
 ffacd0b85a97d-36b8c8edd66mr1308605f8f.35.1722352036026; 
 Tue, 30 Jul 2024 08:07:16 -0700 (PDT)
Received: from [192.168.1.18] (lfbn-tou-1-3-122.w86-201.abo.wanadoo.fr.
 [86.201.10.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm14789956f8f.95.2024.07.30.08.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 08:07:15 -0700 (PDT)
Message-ID: <3e82436c-9bc7-4dfa-a048-fc1de6793c72@redhat.com>
Date: Tue, 30 Jul 2024 17:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] qapi/common: Drop temporary 'prefix'
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au,
 andrew@daynix.com, arei.gonglei@huawei.com, berrange@redhat.com,
 berto@igalia.com, borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com, kwolf@redhat.com,
 leetroy@gmail.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-5-armbru@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240730081032.1246748-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/30/24 10:10, Markus Armbruster wrote:
> Recent commit "qapi: Smarter camel_to_upper() to reduce need for
> 'prefix'" added a temporary 'prefix' to delay changing the generated
> code.
> 
> Revert it.  This improves OffAutoPCIBAR's generated enumeration
> constant prefix from OFF_AUTOPCIBAR_OFF to OFF_AUTO_PCIBAR_OFF.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   qapi/common.json |  1 -
>   hw/vfio/pci.c    | 10 +++++-----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 25726d3113..7558ce5430 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -92,7 +92,6 @@
>   # Since: 2.12
>   ##
>   { 'enum': 'OffAutoPCIBAR',
> -  'prefix': 'OFF_AUTOPCIBAR',   # TODO drop
>     'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
>   
>   ##
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2407720c35..0a99e55247 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1452,7 +1452,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>       int target_bar = -1;
>       size_t msix_sz;
>   
> -    if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
> +    if (!vdev->msix || vdev->msix_relo == OFF_AUTO_PCIBAR_OFF) {
>           return true;
>       }
>   
> @@ -1464,7 +1464,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>       /* PCI BARs must be a power of 2 */
>       msix_sz = pow2ceil(msix_sz);
>   
> -    if (vdev->msix_relo == OFF_AUTOPCIBAR_AUTO) {
> +    if (vdev->msix_relo == OFF_AUTO_PCIBAR_AUTO) {
>           /*
>            * TODO: Lookup table for known devices.
>            *
> @@ -1479,7 +1479,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
>               return false;
>           }
>       } else {
> -        target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
> +        target_bar = (int)(vdev->msix_relo - OFF_AUTO_PCIBAR_BAR0);
>       }
>   
>       /* I/O port BARs cannot host MSI-X structures */
> @@ -1624,7 +1624,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>           } else if (vfio_pci_is(vdev, PCI_VENDOR_ID_BAIDU,
>                                  PCI_DEVICE_ID_KUNLUN_VF)) {
>               msix->pba_offset = 0xb400;
> -        } else if (vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
> +        } else if (vdev->msix_relo == OFF_AUTO_PCIBAR_OFF) {
>               error_setg(errp, "hardware reports invalid configuration, "
>                          "MSIX PBA outside of specified BAR");
>               g_free(msix);
> @@ -3403,7 +3403,7 @@ static Property vfio_pci_dev_properties[] = {
>                                      nv_gpudirect_clique,
>                                      qdev_prop_nv_gpudirect_clique, uint8_t),
>       DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
> -                                OFF_AUTOPCIBAR_OFF),
> +                                OFF_AUTO_PCIBAR_OFF),
>   #ifdef CONFIG_IOMMUFD
>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),



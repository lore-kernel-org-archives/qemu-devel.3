Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8762ECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so0oz-00042U-Cy; Tue, 10 Sep 2024 09:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so0oy-00041K-Pw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1so0ox-0001he-5b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725974533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5DIdtdfJn5kMtn8D4tl/LJy99xguNSg3eD7ePVbuaw=;
 b=er6TYlaZyTOGrvRuiHWFk+qvLD3AnmHvVnLdOkea/Sn6ZjGIQ5fQWbfTH4KtLbXB2lwj2p
 nneh4RYSYdVW5SFrxmOrk7AfGq01eKaertU8T8tR0I99wh9nG3DL9J6PHcHrq7IZ9OwvW9
 CZpkapr3lwUKzw2XyGmIqJKPfbQ5XaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-flXQw4SjOzmjZ5Akg6LqrQ-1; Tue, 10 Sep 2024 09:22:12 -0400
X-MC-Unique: flXQw4SjOzmjZ5Akg6LqrQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb115566eso26609235e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 06:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725974531; x=1726579331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5DIdtdfJn5kMtn8D4tl/LJy99xguNSg3eD7ePVbuaw=;
 b=UQNPqabMSC1Q9P8n6WDD58rwkW/B8bEOJIeT53G8fasIBf52pZmbQpGQvpyUa54O16
 2f8XfRt1c9ZijM173EIV96BN0JnCKI7TUe9JVWI5RMbZuL3PgEjWABBuBBrTBH5ZaDMI
 lmnNrjMYyhsD0a5b2buKPkxa7WDPf8ZCweDkYaS7f78SAnh+fvpX/bfEYVgcnF5kcAH7
 71PXfOkT8y1S24AQkGS7etbCa7fZPgCqafbaDm21pSVFZWQegMd2EZcDukzeldRGDUMT
 a7wZx3RwDie2jq5WfijhZXFJCJMC9SVNqnOfmeNFhNXVQgTkoI9X+BTCcvFpVXetwd7l
 Ee0Q==
X-Gm-Message-State: AOJu0Yy4ZXff90dcbl4V/dLkP7zeEzScXUoEPGBMImfGNoEdtRB5LIrm
 PNeUWUjQHUmefFK8DUII708cKRuTA4H9FsH4HBi4K1vjjT2HA8IX/2gZ0xUCjzvVs4rO54yyJMa
 HbWlP6G447eaN2i+q3WLOxSx/8DEjWDVVRkQV1HjPkE/8aXnzPrFU
X-Received: by 2002:a05:600c:1c17:b0:42c:bb58:a077 with SMTP id
 5b1f17b1804b1-42cbb58a491mr53594565e9.14.1725974530644; 
 Tue, 10 Sep 2024 06:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdtg5eHBnNdWf4WHzY2NPlHjO5vs/o+FJutSr3G4u6yrgnxgzvtIFNFIhm5uKSNLBX6zfuw==
X-Received: by 2002:a05:600c:1c17:b0:42c:bb58:a077 with SMTP id
 5b1f17b1804b1-42cbb58a491mr53594165e9.14.1725974530217; 
 Tue, 10 Sep 2024 06:22:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564af1asm8919014f8f.18.2024.09.10.06.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 06:22:09 -0700 (PDT)
Message-ID: <3589d479-cd8a-4d18-959a-480c55182a7f@redhat.com>
Date: Tue, 10 Sep 2024 15:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240823-reuse-v15-4-eddcb960e289@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/23/24 07:00, Akihiko Odaki wrote:
> The SR-IOV PFs set the multifunction bits during device realization so
> check them after that. This forbids adding SR-IOV devices to s390x.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

May be add :

Fixes: 6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")

?

Anyhow,

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/s390x/s390-pci-bus.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3e57d5faca18..00b2c1f6157b 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -971,14 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                       "this device");
>       }
>   
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> -        PCIDevice *pdev = PCI_DEVICE(dev);
> -
> -        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> -            error_setg(errp, "multifunction not supported in s390");
> -            return;
> -        }
> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>           S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
>   
>           if (!s390_pci_alloc_idx(s, pbdev)) {
> @@ -1069,6 +1062,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>           pdev = PCI_DEVICE(dev);
>   
> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +            error_setg(errp, "multifunction not supported in s390");
> +            return;
> +        }
> +
>           if (!dev->id) {
>               /* In the case the PCI device does not define an id */
>               /* we generate one based on the PCI address         */
> 



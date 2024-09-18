Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ECCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwD3-0000dR-2J; Wed, 18 Sep 2024 11:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqwD1-0000ar-Fw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqwCx-00024D-C8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726671785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+w+fZc9Dm3dd7J3sdb6mE9aN7L3G2/yuN3aIaiq6xuE=;
 b=XrCLgG+pDJItU8CUIJeuW8POJhKb0NHLfwQlE3OycgXyAbH359ntKAmaUIYjlbw8OYOmSd
 vAs9oS9mrKT6fiGg7ECDJJgS8OjOSwF59XA2G52gNv8XYI7ixkCTRPJwU3WFuDndN2CrPi
 k0VN6/lSFIg7YdZaZtr79nIH1oxARGU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-vm591LyZNx6cD615XYQjnA-1; Wed, 18 Sep 2024 11:02:57 -0400
X-MC-Unique: vm591LyZNx6cD615XYQjnA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb374f0cdso4931915e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 08:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726671775; x=1727276575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+w+fZc9Dm3dd7J3sdb6mE9aN7L3G2/yuN3aIaiq6xuE=;
 b=U9vnwYaGfxO6rTI9IY3UGdfURcwzohoobscLrQSCkQgsMtOrssm1UrvtTpHHLfO4Kx
 hDUOaB/X1jc2e0ZDixxWnr9OpM3pbhQh5Ne6Eb72+80duTJEZ3mvqVGv52mqPod3FZFV
 /p2X8e316bgjH2Og0hd29YuncuxYlK3QLI0ugIVq8jKsjfHcEl0BSXLWiMQeFg4ejkkT
 bl8eehW8ojiYXEgS/oN82DQcJqUDFkYkAtfrNmt3V6Lj6t6C43WO5Qi4hbCR5GW7HfBl
 WzEM12CwPD+Nb6QM3hTyDFsJNCoRTA4GnyiMgFljEBuY+VR6pc24pMXTeMUprlMi2cZd
 uvsw==
X-Gm-Message-State: AOJu0Yy24OV2GIqlNEw/2OcoMNVhz3wi+HPp8kk1PSZyQtbTO+etNxft
 n0uD8Phi320hJehdrKCtyI4b2FyA21dAie+4ZQn0mxPlrPhhCYtEvw9svfnjWk/YZWsEmvh5MUV
 kCENYNzvYp0J+sdh5rLhHNuvOySpk3MqeKgQ4O2RYX33necwhtFzS
X-Received: by 2002:a05:600c:3c91:b0:42c:b2a2:af3a with SMTP id
 5b1f17b1804b1-42cbdddf270mr201654025e9.9.1726671774386; 
 Wed, 18 Sep 2024 08:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmJ0jRRSq7Jq97wtRs9xPjjvyb+4wh9QXU6+XhGY804pFCZ9+WJcIKlu14osxk+rJDVvXZYg==
X-Received: by 2002:a05:600c:3c91:b0:42c:b2a2:af3a with SMTP id
 5b1f17b1804b1-42cbdddf270mr201653435e9.9.1726671773855; 
 Wed, 18 Sep 2024 08:02:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7051747asm19039265e9.36.2024.09.18.08.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 08:02:52 -0700 (PDT)
Message-ID: <4048f295-1073-432d-9c89-dac1b6b30da5@redhat.com>
Date: Wed, 18 Sep 2024 17:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/13] s390x/pci: Avoid creating zpci for VFs
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
 <20240913-reuse-v16-4-d016b4b4f616@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240913-reuse-v16-4-d016b4b4f616@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On 9/13/24 05:44, Akihiko Odaki wrote:
> VFs are automatically created by PF, and creating zpci for them will
> result in unexpected usage of fids. Currently QEMU does not support
> multifunction for s390x so we don't need zpci for VFs anyway.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3e57d5faca18..1a620f5b2a04 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   
>           pbdev = s390_pci_find_dev_by_target(s, dev->id);
>           if (!pbdev) {
> +            /*
> +             * VFs are automatically created by PF, and creating zpci for them
> +             * will result in unexpected usage of fids. Currently QEMU does not
> +             * support multifunction for s390x so we don't need zpci for VFs
> +             * anyway.
> +             */
> +            if (pci_is_vf(pdev)) {
> +                return;
> +            }
> +
>               pbdev = s390_pci_device_new(s, dev->id, errp);
>               if (!pbdev) {
>                   return;
> @@ -1167,7 +1177,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           int32_t devfn;
>   
>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
> -        g_assert(pbdev);
> +        if (!pbdev) {
> +            return;
> +        }


I don't understand this change. Could you please explain ?


Thanks,

C.



>           s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
>                                        pbdev->fh, pbdev->fid);
> @@ -1206,7 +1218,10 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
>            * we've checked the PCI device already (to prevent endless recursion).
>            */
>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
> -        g_assert(pbdev);
> +        if (!pbdev) {
> +            return;
> +        }
> +
>           pbdev->pci_unplug_request_processed = true;
>           qdev_unplug(DEVICE(pbdev), errp);
>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
> 



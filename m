Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F8CEE4985
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJoL-0004zz-SZ; Wed, 11 Sep 2024 05:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soJoK-0004tW-7V
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soJoI-00061b-MN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726047529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcwHyRoX9Qf99oFktbEaCvxy+3kxDGx0d9Tm7HWdpoA=;
 b=ET7VXXYFBxWjc6/S8zvqAtT0HB+Tb1nOEPd5bd0xhn0glk2V9t0+4DB0bhap7U4yNHGpvW
 GRunpX5ud1RyYZ6KGbgc4sBYvUSvN+2mMxNT63roAAGLNg/EJ69xLDqS4RYm6HphicUzuO
 em0wW0/+tGFyvovvQRfawD54JcGjBwo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1uft8V4ZMp-l40y5sSUyQw-1; Wed, 11 Sep 2024 05:38:48 -0400
X-MC-Unique: 1uft8V4ZMp-l40y5sSUyQw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb830ea86so13838195e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047527; x=1726652327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QcwHyRoX9Qf99oFktbEaCvxy+3kxDGx0d9Tm7HWdpoA=;
 b=tIq3j6P8KpmqptkWnW1OSuNYjVAQQuvp7M2faW2bWXrcZFmdNmjaVzWWIYcagFNJd1
 39oOumppizt7hke2YOQi7oijRDos8Bi5mT9Ov9WinmrtX1JDnv9MIQ/8sW0Ubb87pu+H
 ehTC85oW8bM5cXBmJHVgBnLFziPqDgJ6vx2JmC0knjoyfb5ixNnvAH8ZIGhSvNFAg8SO
 oYtUZpmj1yQewJjKrILID3XjAWgauXsMFfaRbD+rLPqkoUxkEfaZJ+J02sj0JA/HTb2Y
 JIjPZbYpGZqZotZ3epncXVW/yAxBVidTwM5JzK6NWIXBHcAQ4H1ipsheZUUjXQS3/wkq
 xJmQ==
X-Gm-Message-State: AOJu0YzYjZQV48ESYJe9+IowmyzVOHDzbGKN56XD6t2C9RawqXfGUhgq
 UvA1Ql/IvzmGNdZ+xkz/qJJ2cWsoaReUE2SfSroOW+WTRu+0dVdLkpEDiwhS+KaeLtZ/YlGLTwl
 H5rRpbcnfGVwMNvOHHxb6BYlqGewyQ6mcvzf6cIncZ2nYA6MCWuSQ
X-Received: by 2002:a5d:4306:0:b0:374:c50e:377b with SMTP id
 ffacd0b85a97d-378b080cf8cmr1337814f8f.57.1726047527105; 
 Wed, 11 Sep 2024 02:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7dDiasvKV1MpBB8pdnZ6G9IdZCrCyjchhgSWkYs+B86kvFZ7PcBytDBCLFT7eSh6aasNVJw==
X-Received: by 2002:a5d:4306:0:b0:374:c50e:377b with SMTP id
 ffacd0b85a97d-378b080cf8cmr1337802f8f.57.1726047526603; 
 Wed, 11 Sep 2024 02:38:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956650f2sm11000203f8f.26.2024.09.11.02.38.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:38:46 -0700 (PDT)
Message-ID: <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
Date: Wed, 11 Sep 2024 11:38:44 +0200
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240823-reuse-v15-4-eddcb960e289@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+Matthew +Eric

Side note for the maintainers :

Before this change, the igb device, which is multifunction, was working
fine under Linux.

Was there a fix in Linux since :

   57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
   6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug handler")

?

s390 PCI devices do not have extended capabilities, so the igb device
does not expose the SRIOV capability and only the PF is accessible but
it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
default Linux config which is unexpected)

Thanks,

C.



On 8/23/24 07:00, Akihiko Odaki wrote:
> The SR-IOV PFs set the multifunction bits during device realization so
> check them after that. This forbids adding SR-IOV devices to s390x.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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



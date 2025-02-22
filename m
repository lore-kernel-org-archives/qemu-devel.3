Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E349C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 06:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tliZa-0006Ru-1J; Sat, 22 Feb 2025 01:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tliZT-0006RJ-69
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 01:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tliZQ-0008FT-Hf
 for qemu-devel@nongnu.org; Sat, 22 Feb 2025 01:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740204054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YUctPu/rM5HEZqg8HRERuUWoD7InTnL7SEi8iuot/k=;
 b=GiY5FSbgZyQlLaUhs3fUxGjdZOPujIGD2D3KKUJVHOhzqo91xVVItgfTFwfdcIzlnao364
 AskxfKIHmQDsSf0aalZBUmbTe3r0ZCZRGrDq6TNaUlGNgEl6x/fRhkB1+2+qqXxSLC1FNV
 Ftpj77LDKTK+DeQDuqa+htUbYeol3iQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-u39wjV6nO6auAs1bpcLjJw-1; Sat, 22 Feb 2025 01:00:52 -0500
X-MC-Unique: u39wjV6nO6auAs1bpcLjJw-1
X-Mimecast-MFC-AGG-ID: u39wjV6nO6auAs1bpcLjJw_1740204052
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43995bff469so26960645e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 22:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740204051; x=1740808851;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YUctPu/rM5HEZqg8HRERuUWoD7InTnL7SEi8iuot/k=;
 b=WGsdoMCmUSeVW/vjpxPaa5LTU54IdigdcX22eeHkYXQGrXtvk+hef29/CmTiLVRIq6
 BQVzG0knI5I0uifomxY2qej/n1tdmfiWZdXycu/RmUpZWgsrbkLq+QQD8md8pH7OMPbI
 2xp4vv93CGtuVm4lmZabWGqv1esj+dpQAn9NOZXeNqrEZ12Bwrjpk9EG4g10mJhMvbLL
 b3OBKqWgQvqHqYlE7SXqR0FiDPNg5pLoVqkDDu45Kqmcl6oBXX8iALLMtuAj0YLmsBB0
 +316lPHSP806LsTgCAovzf0ABKbhXNZfeil+JdPLAMaoEsOXUtjLmBDz22M/ubAZzlAj
 i1mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU4lHzgr9G8Z7P9OYLNvayonTePFn4TfOhw1upj4mjlTfPO54q8kaJ1uLrifLh9rcQZnkBiRSE9Pe4@nongnu.org
X-Gm-Message-State: AOJu0YzhUO0s+/bSW1ArwSfSxdrAqwECLYITKnfxUHbPNn5CZLsm2fsM
 1G5i2iqokXJtMv1zJ9Yu5YavHmmvgDVD9pBuQ2n1gwJn9KJlSP7WY1YZ5Oa1oPmQRK5lUlZM1nd
 IMOlA2lu5S78ZKl9qyEAefPP6IwlrK6T1d+/2bMesjynw9LFL9qTw
X-Gm-Gg: ASbGnctS8U+Ra5Xk7ropXblTuuuQiRPrrdAinLBPMBzGIPg6SgefOog4cNXpb0TDW9O
 OCZW86XkTJcB/ZSDDUXBKSJp3pheRqgYshX0o7LShDKPXoCSafHuFls1SFxSU512cFbV1Yz0fAW
 A3FOHZRK7/ti5zOEwXYHNLFiWI/3iXQsuRd1mcF7xys+i9u+RGF7yWLSW6c8DPV1pTQhv4Kyovd
 eMkmlFHmh9kHA6NUwqyesPSGzpvZbGU65OVTvJbYhoz7W3RAmCRERtFRb/EEsAKSlFMRnAsgDVi
 K9Dg407UlOYZPrH6aNwEG7zc/nQkCiVSthOaE2QeeEDyYft9GeU=
X-Received: by 2002:a5d:47c2:0:b0:38f:394f:d81 with SMTP id
 ffacd0b85a97d-38f7078453cmr3593972f8f.2.1740204051577; 
 Fri, 21 Feb 2025 22:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEulIrUF3U8tC9rypoOTMXKkpD6cA5MqrvzWaTEv3MvMH0durL2rDyQBmKAcA+ZxAv8vP0b8A==
X-Received: by 2002:a5d:47c2:0:b0:38f:394f:d81 with SMTP id
 ffacd0b85a97d-38f7078453cmr3593959f8f.2.1740204051164; 
 Fri, 21 Feb 2025 22:00:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b031b613sm36839685e9.33.2025.02.21.22.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 22:00:49 -0800 (PST)
Message-ID: <86fb5af2-6cda-4a87-97b0-d06dbe55e086@redhat.com>
Date: Sat, 22 Feb 2025 07:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-5-alex.williamson@redhat.com>
 <SJ0PR11MB674457591D328D9178947A6B92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB674457591D328D9178947A6B92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

Hello Zhenzhong,

On 2/21/25 07:12, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Alex Williamson <alex.williamson@redhat.com>
>> Subject: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
>>
>> The pm_cap on the PCIExpressDevice object can be distilled down
>> to the new instance on the PCIDevice object.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>> ---
>> hw/pci-bridge/pcie_pci_bridge.c | 1 -
>> hw/virtio/virtio-pci.c          | 8 +++-----
>> include/hw/pci/pcie.h           | 2 --
>> 3 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
>> index 9fa656b43b42..2429503cfbbf 100644
>> --- a/hw/pci-bridge/pcie_pci_bridge.c
>> +++ b/hw/pci-bridge/pcie_pci_bridge.c
>> @@ -56,7 +56,6 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error
>> **errp)
>>      if (pos < 0) {
>>          goto pm_error;
>>      }
>> -    d->exp.pm_cap = pos;
>>      pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
>>
>>      pcie_cap_arifwd_init(d);
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index afe8b5551c5c..3ca3f849d391 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2209,8 +2209,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error
>> **errp)
>>              return;
>>          }
>>
>> -        pci_dev->exp.pm_cap = pos;
>> -
>>          /*
>>           * Indicates that this function complies with revision 1.2 of the
>>           * PCI Power Management Interface Specification.
>> @@ -2309,11 +2307,11 @@ static bool virtio_pci_no_soft_reset(PCIDevice *dev)
>> {
>>      uint16_t pmcsr;
>>
>> -    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
>> +    if (!pci_is_express(dev) || !(dev->cap_present & QEMU_PCI_CAP_PM)) {
> 
> Maybe a bit more optimized by checking dev->pm_cap,
> but it's also ok checking present bit. For the whole series,
> 
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Could you please reply to the cover letter instead ? Tools like b4
will apply the provided trailers to the whole series and not this
patch only.


Thanks,

C.




> 
> Thanks
> Zhenzhong
> 
>>          return false;
>>      }
>>
>> -    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
>> +    pmcsr = pci_get_word(dev->config + dev->pm_cap + PCI_PM_CTRL);
>>
>>      /*
>>       * When No_Soft_Reset bit is set and the device
>> @@ -2342,7 +2340,7 @@ static void virtio_pci_bus_reset_hold(Object *obj,
>> ResetType type)
>>
>>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>>              pci_word_test_and_clear_mask(
>> -                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
>> +                dev->config + dev->pm_cap + PCI_PM_CTRL,
>>                  PCI_PM_CTRL_STATE_MASK);
>>          }
>>      }
>> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>> index b8d59732bc63..70a5de09de39 100644
>> --- a/include/hw/pci/pcie.h
>> +++ b/include/hw/pci/pcie.h
>> @@ -58,8 +58,6 @@ typedef enum {
>> struct PCIExpressDevice {
>>      /* Offset of express capability in config space */
>>      uint8_t exp_cap;
>> -    /* Offset of Power Management capability in config space */
>> -    uint8_t pm_cap;
>>
>>      /* SLOT */
>>      bool hpev_notified; /* Logical AND of conditions for hot plug event.
>> --
>> 2.48.1
> 



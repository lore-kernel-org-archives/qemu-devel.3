Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9ECAC589
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtGI-00042Q-Dz; Tue, 09 Sep 2025 03:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvtGG-00041D-ES
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvtG9-0006Is-0Q
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757404761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M5lWeCLA1J2GmJuiA7T99O8l4Jz5wOIuEJfofxrsrX4=;
 b=S7CdxMisBZvqiMoM3+sV+0i4Tkt3UwouUVfsAeZYmgHZVQbMMzQcOvruxBMI5PiSuzZcEp
 lvV1UgXenqvoRMU8it/hfwv/7hBwgF7rbGldYpZHPasrZvCG6shrmMCdr1d+1GLwpj92fz
 qhhDWvFH0J0UdwM4M5gE5qGd/7ICmz0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TEg8Jc2PNQSmvm86S9MI8g-1; Tue, 09 Sep 2025 03:59:19 -0400
X-MC-Unique: TEg8Jc2PNQSmvm86S9MI8g-1
X-Mimecast-MFC-AGG-ID: TEg8Jc2PNQSmvm86S9MI8g_1757404759
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e1260394dcso2724411f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757404758; x=1758009558;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5lWeCLA1J2GmJuiA7T99O8l4Jz5wOIuEJfofxrsrX4=;
 b=vc/pTY+dwz4EmoZzmShXOv5BKX3baKm3EBNsmLjG3ba69U1HqWzUm6kEzVmrTEul0N
 dOAWxL1ZDiTa9akXWm4Hh9xm0A069oMPi796MB1/jIlFPE7UT9ViYaNU0GXphLG0OVkn
 UM8XM92xWqq23DGUjCWLLZl9/vb2mLM1V7aReDApdwzeAyn/RGxoaQLf/UHR2nYWC8q0
 ATOChKELR/raF0bfuAFqNNdH8rqhhppxizPokViqCRPY3f0ErtI08g6nTWHoPVieIozW
 rwzQ6jB63Fpit9zbBeCh2rALu5LsUeT8/PVOPdxqiu9PXOHV2LZXL93AeuIr7/UzbdiO
 n3JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs9j92AQRQAxGcMEfu39AWOQnCrn4RIPwsZyZaz7uN47fnN6AptMUsM93j/BG1o2BraTcak7q7s5cg@nongnu.org
X-Gm-Message-State: AOJu0YxiwA/lm1rIZ+UNzr1ko5FWCDLrsehQrVl6EH+1yZCMoWqbjkMo
 6mk3dq1NHqtr+zCeaxGTP+QODXjp3aSWNRnj3UhxRPRhY16op+IouedbRcKYKQvHczYocr6ElVo
 EdL8zwIH5dSgab/eAwh9vop1QjiIL58ht0Umg7mRJkVpnjh8HPsxD6IF/
X-Gm-Gg: ASbGnctLJMiCvWcvauC32UJ6U8VImE/DdEbI9pwd820zQiIyiIkKTckJahqBkhy+kIA
 wfBWhJgGakcul/hGiy9tzQ2WdOHlAxx6mszy/mVFHk9y7qaKN5m+ybwqzLAHeIQXSC+V+H9bta8
 AfqzkDmZEXQr96B9KAjrY7YOOP87tyw+Gjvk+bqrxVoVWrl/wEZy17EGlgIQ3jteggHFjj2WKAg
 6+h7whC7U5eFiHVSplZ2LVeVpU7rGXhQh5tBk7AgDmoaclX7ho1XHZuBkzObFIDRXeoGN+dve0L
 aN+MNBAcBh3kfm/msLH6KtU0Z/GvBpzdIjqlCPlBifABSIenIebk8xyQ0RKk6Hx6JynTFwh7gZU
 VBXc=
X-Received: by 2002:a05:6000:290e:b0:3e7:516d:9a7c with SMTP id
 ffacd0b85a97d-3e7516d9d7dmr1112308f8f.39.1757404758525; 
 Tue, 09 Sep 2025 00:59:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6E/5DH/aobdxLbbgf74svV6tuol+GZ0kZiVXeJWiedrdpUav/n/fa59tAlVZ3zu2SSrpQ7g==
X-Received: by 2002:a05:6000:290e:b0:3e7:516d:9a7c with SMTP id
 ffacd0b85a97d-3e7516d9d7dmr1112287f8f.39.1757404758037; 
 Tue, 09 Sep 2025 00:59:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7521bfe00sm1598797f8f.5.2025.09.09.00.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:59:17 -0700 (PDT)
Message-ID: <cd025b10-aa5b-4c94-ae38-76df79b50fcb@redhat.com>
Date: Tue, 9 Sep 2025 09:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-4-alifm@linux.ibm.com>
 <24333a79-2a49-4abb-8bb7-8e5b30a0d58b@redhat.com>
 <d396992a-1412-433c-afa8-619c7574de29@linux.ibm.com>
 <5ed9c5ef-cb1d-428c-a822-9f378fabd755@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <5ed9c5ef-cb1d-428c-a822-9f378fabd755@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/3/25 19:49, Matthew Rosato wrote:
> On 9/3/25 1:12 PM, Farhan Ali wrote:
>>
>> On 9/1/2025 4:25 AM, Cédric Le Goater wrote:
>>> On 8/25/25 23:24, Farhan Ali wrote:
>>>> Add an s390x specific callback for vfio error handling. For s390x pci devices,
>>>> we have platform specific error information. We need to retrieve this error
>>>> information for passthrough devices. This is done via a memory region which
>>>> exposes that information.
>>>>
>>>> Once this error information is retrieved we can then inject an error into
>>>> the guest, and let the guest drive the recovery.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    hw/s390x/s390-pci-bus.c          |  5 +++
>>>>    hw/s390x/s390-pci-vfio.c         | 76 ++++++++++++++++++++++++++++++++
>>>>    include/hw/s390x/s390-pci-bus.h  |  1 +
>>>>    include/hw/s390x/s390-pci-vfio.h |  2 +
>>>>    4 files changed, 84 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index f87d2748b6..af42eb9938 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -158,6 +158,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>>>    {
>>>>        HotplugHandler *hotplug_ctrl;
>>>>    +    qemu_mutex_destroy(&pbdev->err_handler_lock);
>>>> +
>>>>        if (pbdev->pft == ZPCI_PFT_ISM) {
>>>>            notifier_remove(&pbdev->shutdown_notifier);
>>>>        }
>>>> @@ -1140,6 +1142,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>            pbdev->iommu->pbdev = pbdev;
>>>>            pbdev->state = ZPCI_FS_DISABLED;
>>>>            set_pbdev_info(pbdev);
>>>> +        qemu_mutex_init(&pbdev->err_handler_lock);
>>>>              if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>>>                /*
>>>> @@ -1164,6 +1167,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>>                pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
>>>>                /* Fill in CLP information passed via the vfio region */
>>>>                s390_pci_get_clp_info(pbdev);
>>>> +            /* Setup error handler for error recovery */
>>>> +            s390_pci_setup_err_handler(pbdev);
>>>
>>> This can fail. Please add an 'Error **' parameter and change the returned
>>> value to bool.
>>>
>> I wanted to avoid hard failing here as we can have mismatch in kernel and QEMU support for the feature. For example we can have a newer QEMU version with the feature running on an older kernel. So wanted to treat any error in setting up the error handler would be more of an info/warn message.
> 
> +1, please do not cause a hard failure if the underlying host kernel is simply missing support...

It doesn't have to be a hard failure. The code could issue a
warn_report_err(). Similarly to what is done for the vfio_ap
device when IRQ notifying support is not available on the host.

This is minor.

C.

> 
>>>> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev)
>>>> +{
>>>> +    int ret;
>>>> +    VFIOPCIDevice *vfio_pci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
>>>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>> +                              sizeof(uint64_t))] = {};
>>>> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>>>> +
>>>> +    feature->argsz = sizeof(buf);
>>>> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>>>> +
>>>> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
>>>> +                                                     feature);
>>>
>>> Please introduce vfio helpers to hide the internal indirection :
>>>
>>>    ->vbasedev.io_ops->device_feature(...)
>>>
>>>> +
>>>> +    if (ret) {
>>>
>>> Shouldn't we test the return value to decide if the error is
>>> an unimplemented feature or an unexpected error ?
>>
>> Yeah, I think it makes sense separate out error for unimplemented feature (ENOTTY) vs any other unexpected error. Will change this.
>>
> 
> ... But if you add differentiation here between the 2 types of errors then I would be fine with hard-fail for unexpected cases and info/warn for missing host kernel support.



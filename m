Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D53C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJYK-0007xw-GG; Mon, 01 Jul 2024 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOJYJ-0007sW-4V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOJYH-0005FA-Cj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719850008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Piz3+qHphNrxZ+h/Hz+XsQ6a4ATI0+MFcQHX0PEdc8=;
 b=VU/0IDFCM9O54vpsPoW+ls1J/0ZFHYbjnrzQlWDbEjypIi/tLx+Puh0vRB1wc6eflOVgoP
 gXGa8QqlKpGntOJcHvqFod+2Y6v2xXmK+2VpOUn5TsCszLQmkeQExyBZWGgvyQSQKKK99A
 rChuXBzDZBoSY8dzQbbFNIkxE9b1NGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-A4Yk9e8pNAWaBHYRAE5H6A-1; Mon, 01 Jul 2024 12:06:46 -0400
X-MC-Unique: A4Yk9e8pNAWaBHYRAE5H6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-425739141c2so20654615e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850005; x=1720454805;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Piz3+qHphNrxZ+h/Hz+XsQ6a4ATI0+MFcQHX0PEdc8=;
 b=ZsF9mAbabqtcxQZrGG1Em5/ipqUlr7k8tfOZpom66CLzvzfUeJTdATShjuTfIaH05t
 7RZuxQkaOeu02utqDMUwtVmEj1htKOQr4oDW/Pk9xru+fCmFYOiZnerWs29e9MmKXJEv
 jqzfKslH6QRfusAtEdOTM+FbEKHh248zzD2abtj/1NqW07xZcA/4h0IDOC618VOBSRru
 Fu4bOFJUMjI4k0AIe4y10oC8uIvzk7noWjWLMtx+LUWl80atN7rQF9PL9dXhxrLpuy4D
 k8rSs9Pc8dnmmY0s9fFgbLxWAfvzXCcmsaCZXbFubAZTaR6QDhzkr3kSWUEu1VpEbcUY
 4GUg==
X-Gm-Message-State: AOJu0Yy5I9m72pUeUKWtqsnrE6O/a3Tls0Wmtghqp/h9hL+vI708ouak
 59n2WoILKbHM2bw2f5IIBm9vVQLFdNFESup3+82cDMjg14efDAhbY7vH9EClMmyUl4FaoYY876M
 vKYDICy0B/fgfdysXIOdTV6YQAH8e7CwpT+RW2/dfMW8AlWPpftlAkWdYyouD
X-Received: by 2002:a05:600c:1989:b0:425:6bc4:977b with SMTP id
 5b1f17b1804b1-4257a06df09mr52499225e9.26.1719850004883; 
 Mon, 01 Jul 2024 09:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFTCtIhHkByP493rReFRMKP/jclafE4KlieRZ0Td224GzClIWzYU636Yj6acW3I6iUYNwUXg==
X-Received: by 2002:a05:600c:1989:b0:425:6bc4:977b with SMTP id
 5b1f17b1804b1-4257a06df09mr52499005e9.26.1719850004523; 
 Mon, 01 Jul 2024 09:06:44 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de.
 [109.43.177.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9286sm10382944f8f.35.2024.07.01.09.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 09:06:44 -0700 (PDT)
Message-ID: <1ce5bce5-2659-4da8-81ac-34838768f04d@redhat.com>
Date: Mon, 1 Jul 2024 18:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Fix the de-initialization of vhost-user devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240618121958.88673-1-thuth@redhat.com>
 <3f96e237-d367-4f8e-b96d-f51d4ba33ab1@redhat.com>
 <20240701110607-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240701110607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 01/07/2024 17.06, Michael S. Tsirkin wrote:
> On Mon, Jul 01, 2024 at 04:07:56PM +0200, Thomas Huth wrote:
>> On 18/06/2024 14.19, Thomas Huth wrote:
>>> The unrealize functions of the various vhost-user devices are
>>> calling the corresponding vhost_*_set_status() functions with a
>>> status of 0 to shut down the device correctly.
>>>
>>> Now these vhost_*_set_status() functions all follow this scheme:
>>>
>>>       bool should_start = virtio_device_should_start(vdev, status);
>>>
>>>       if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>>           return;
>>>       }
>>>
>>>       if (should_start) {
>>>           /* ... do the initialization stuff ... */
>>>       } else {
>>>           /* ... do the cleanup stuff ... */
>>>       }
>>>
>>> The problem here is virtio_device_should_start(vdev, 0) currently
>>> always returns "true" since it internally only looks at vdev->started
>>> instead of looking at the "status" parameter. Thus once the device
>>> got started once, virtio_device_should_start() always returns true
>>> and thus the vhost_*_set_status() functions return early, without
>>> ever doing any clean-up when being called with status == 0. This
>>> causes e.g. problems when trying to hot-plug and hot-unplug a vhost
>>> user devices multiple times since the de-initialization step is
>>> completely skipped during the unplug operation.
>>>
>>> This bug has been introduced in commit 9f6bcfd99f ("hw/virtio: move
>>> vm_running check to virtio_device_started") which replaced
>>>
>>>    should_start = status & VIRTIO_CONFIG_S_DRIVER_OK;
>>>
>>> with
>>>
>>>    should_start = virtio_device_started(vdev, status);
>>>
>>> which later got replaced by virtio_device_should_start(). This blocked
>>> the possibility to set should_start to false in case the status flag
>>> VIRTIO_CONFIG_S_DRIVER_OK was not set.
>>>
>>> Fix it by adjusting the virtio_device_should_start() function to
>>> only consider the status flag instead of vdev->started. Since this
>>> function is only used in the various vhost_*_set_status() functions
>>> for exactly the same purpose, it should be fine to fix it in this
>>> central place there without any risk to change the behavior of other
>>> code.
>>>
>>> Fixes: 9f6bcfd99f ("hw/virtio: move vm_running check to virtio_device_started")
>>> Buglink: https://issues.redhat.com/browse/RHEL-40708
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    include/hw/virtio/virtio.h | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index 7d5ffdc145..2eafad17b8 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -470,9 +470,9 @@ static inline bool virtio_device_started(VirtIODevice *vdev, uint8_t status)
>>>     * @vdev - the VirtIO device
>>>     * @status - the devices status bits
>>>     *
>>> - * This is similar to virtio_device_started() but also encapsulates a
>>> - * check on the VM status which would prevent a device starting
>>> - * anyway.
>>> + * This is similar to virtio_device_started() but ignores vdev->started
>>> + * and also encapsulates a check on the VM status which would prevent a
>>> + * device from starting anyway.
>>>     */
>>>    static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status)
>>>    {
>>> @@ -480,7 +480,7 @@ static inline bool virtio_device_should_start(VirtIODevice *vdev, uint8_t status
>>>            return false;
>>>        }
>>> -    return virtio_device_started(vdev, status);
>>> +    return status & VIRTIO_CONFIG_S_DRIVER_OK;
>>>    }
>>
>> Michael, any concerns or comments about this patch?
>>
>> If not, I could also take it via my s390x tree since this fixes vhost-ccw
>> devices on s390x.
>>
>>   Thomas
> 
> I'm working on a pull request with this today.
> I can drop it if you prefer ...

Ah, perfect, please include it in your PR then!

  Thanks,
   Thomas



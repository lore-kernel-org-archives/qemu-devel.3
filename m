Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19F0CF11FE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 15:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syvLy-0002eT-4f; Thu, 10 Oct 2024 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1syvLo-0002dm-QO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1syvLj-0008He-EV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 11:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728575102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J8Iths7So6VNg4jhT5KVsSdwZ6XQwluRYvD1L0owMyM=;
 b=V3nlHEsCj9CeW0fzkPr14Ijs2FntibkC3qWHWhMCstbtixXuG++yR7AnpFO1fKu2KbjAeh
 sl2T3XIpLz7wbqwFhukC1Alx66JtqfHu1nAUHwAslP8ln7YcmlwP+Bhf0xvszgxDiSQp5v
 X0I8u8rcxUjWeV/TB1bKxQBfJSczs4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-obBYsyPWMoC_LAMTNoKwsg-1; Thu, 10 Oct 2024 11:44:58 -0400
X-MC-Unique: obBYsyPWMoC_LAMTNoKwsg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso6512055e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 08:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728575097; x=1729179897;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8Iths7So6VNg4jhT5KVsSdwZ6XQwluRYvD1L0owMyM=;
 b=W2w3K7L/B9qSwvFqM/zyo3mY6NPQTsuFmw9dfZKlxagzlr23MlVAA6khQtO1d+ckTq
 y09PzR/J1maA9UK/nYfMDMmZldjrCkF4OE5t55FG+17x8XytceHZqCDH2ntmDJ01tzRu
 UQ5d1jKbu5OVyYgeZ9dRjreP+zVMdO5G/pyKCf9/wY58E+FYxZhyJu3SFLF8KRCBCp9w
 a2LFHzCgIQyOXha/w4O+kpS3tZK30elNowvanNZa8AA5Wk7rL2f9LTnMJbL8mJSkYEP2
 5E15IWVKX0Fxy6YSKK43hHaq9AihzyqUKS2RTBhB0DdWTEUT4E+/5N0ac3kaJ4Ug9ZSQ
 vbYg==
X-Gm-Message-State: AOJu0YyMUUOLMmt5HZ1tsW3EYOwKDPkFTzupnwlcb5wLqq+7XiYGfxsn
 wDnSA89/VMuA+M3hsPmT5d85bTwOz8oBmfJskXYroTRHEVAu/B0XC0V/4v5Ra7h3Ex2aqTOCu2v
 HQrD106KT8yfQQUmuaUf8gd69XhKF/ReQwOMdWQealSkVULj2nmFU
X-Received: by 2002:a05:600c:1e10:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-430ccf1d7fdmr63541605e9.13.1728575097298; 
 Thu, 10 Oct 2024 08:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWVvCZAcNC0f+Td2gd2YQQmhp5qjwmdb9Kk//aYVEP6wAoRx934uoQB/mHBpHjVJPYfEyk5Q==
X-Received: by 2002:a05:600c:1e10:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-430ccf1d7fdmr63541425e9.13.1728575096883; 
 Thu, 10 Oct 2024 08:44:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4304efc0460sm80232575e9.1.2024.10.10.08.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 08:44:56 -0700 (PDT)
Message-ID: <d427ffc7-1d3d-476f-8ed8-4246e60e6da1@redhat.com>
Date: Thu, 10 Oct 2024 17:44:54 +0200
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
 <4048f295-1073-432d-9c89-dac1b6b30da5@redhat.com>
 <9e11e7b2-48f5-4b5e-8962-e7879016f04d@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9e11e7b2-48f5-4b5e-8962-e7879016f04d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Akihiko,

Sorry for the late reply.

On 9/18/24 17:32, Akihiko Odaki wrote:
> On 2024/09/18 17:02, Cédric Le Goater wrote:
>> Hello,
>>
>> On 9/13/24 05:44, Akihiko Odaki wrote:
>>> VFs are automatically created by PF, and creating zpci for them will
>>> result in unexpected usage of fids. Currently QEMU does not support
>>> multifunction for s390x so we don't need zpci for VFs anyway.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
>>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 3e57d5faca18..1a620f5b2a04 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>           pbdev = s390_pci_find_dev_by_target(s, dev->id);
>>>           if (!pbdev) {
>>> +            /*
>>> +             * VFs are automatically created by PF, and creating zpci for them
>>> +             * will result in unexpected usage of fids. Currently QEMU does not
>>> +             * support multifunction for s390x so we don't need zpci for VFs
>>> +             * anyway.
>>> +             */
>>> +            if (pci_is_vf(pdev)) {
>>> +                return;
>>> +            }
>>> +
>>>               pbdev = s390_pci_device_new(s, dev->id, errp);
>>>               if (!pbdev) {
>>>                   return;
>>> @@ -1167,7 +1177,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>           int32_t devfn;
>>>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>>> -        g_assert(pbdev);
>>> +        if (!pbdev) {
>>> +            return;
>>> +        }
>>
>>
>> I don't understand this change. Could you please explain ?
> 
> We need to tolerate that pbdev being NULL because VFs do no longer have zpci and pbdev will be NULL for them.

Then, I think we should extend the assert with a check on pci_is_vf(pdev)
to be symmetric with the plug handler and also, use the 'Error**' parameter
to report an error.

Thanks,

C.




> 
> Regards,
> Akihiko Odaki
> 



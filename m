Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0AACF2564
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 11:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szZwh-0007DR-En; Sat, 12 Oct 2024 07:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szZwf-0007D3-Fu
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 07:06:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1szZwd-0003C5-1r
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 07:06:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20cbca51687so5985745ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728731157; x=1729335957;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiHy2e1eBZT/9/0dDfgOsBlEvHBrClOmPmsBX0XG4Rc=;
 b=y1YGnXZUKLqM757JmrUppfskczQeADeQs0+UPGVBAmBUqZlPZcxzju8/F35jO9Xy9r
 qEp+XpR2XT2uQgQNrMSTrNNh4zvwAwDZImkirsoTY1q2hUDvZHkkvalZYCF3xt1M/C1M
 sQsSTokWH7R8i+uYHqnAx4BJVsAnUBnqAfAt3X/VavP8SpLRuv+3rEGvw3U5KwDXZwui
 eMHHdWT3N517SANZT+PraUxa9hha9jPQByH5Pg3wAKm+/FlzyEMF8oN+VCg8zZFarI61
 o8ekCyqWjh7naFJpE8tWPaCqReI32kWTfddLj5koUc0Tg0xzANpIDSIYR9oPiC9PuBKH
 IX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728731157; x=1729335957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KiHy2e1eBZT/9/0dDfgOsBlEvHBrClOmPmsBX0XG4Rc=;
 b=tn79Vqhrfedckp7Vf8VJikVYddssXkPV3tcOJtKtAPgQzvrMenJ1B1Dc5IQLX5BwVT
 HC8iSdWERjvChBAiGkDleWlk+VJaB4finyZKI74v6ROazdvAR5RKZGH9yHvz755C+vwQ
 QHbaXZGFtNUdbmN9TtL/UvfrsBT57DQlHlbTTe8flS2+LCBzOF8QakCmLXnlKm3botSB
 AMN3siFRSLkLmi08DxQUOGTX5Lgt3rWVBg4it6o0NshtzpmTVJZmbzYNjtBWx8kkmWJb
 KF3EtVtLOXudFhzOfU6V0pwENWePA70mN/akUftUPvT/tspM8Su9Tr1wez0fykR+7UMt
 khqg==
X-Gm-Message-State: AOJu0YwJSEa3ZoFiBPjeVHj8jX20QeysiLWCXZvXuBhga8jx2R+5hFH9
 I2opJRa75IoDko7gRHD+bGBcZe+JrB2SdHgrYy4u3qpiSLYA+AN4+A66R2qucrk=
X-Google-Smtp-Source: AGHT+IH8QlKYo9h9w9x2MQG3Hxt8OQcMfU3FC6VqD+LrcA9yyIcWIlwUPuHxSz3iZT2+20Fh7LmNGA==
X-Received: by 2002:a17:902:d4d1:b0:20b:a89a:1d3a with SMTP id
 d9443c01a7336-20cbb21843bmr40064045ad.28.1728731157283; 
 Sat, 12 Oct 2024 04:05:57 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0e75a0sm35608605ad.181.2024.10.12.04.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 04:05:56 -0700 (PDT)
Message-ID: <16774f97-9d42-41ee-b0be-43835c0a04f5@daynix.com>
Date: Sat, 12 Oct 2024 20:05:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/13] s390x/pci: Avoid creating zpci for VFs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
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
 <d427ffc7-1d3d-476f-8ed8-4246e60e6da1@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <d427ffc7-1d3d-476f-8ed8-4246e60e6da1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/10/11 0:44, Cédric Le Goater wrote:
> Hello Akihiko,
> 
> Sorry for the late reply.
> 
> On 9/18/24 17:32, Akihiko Odaki wrote:
>> On 2024/09/18 17:02, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> On 9/13/24 05:44, Akihiko Odaki wrote:
>>>> VFs are automatically created by PF, and creating zpci for them will
>>>> result in unexpected usage of fids. Currently QEMU does not support
>>>> multifunction for s390x so we don't need zpci for VFs anyway.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>   hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
>>>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>>> index 3e57d5faca18..1a620f5b2a04 100644
>>>> --- a/hw/s390x/s390-pci-bus.c
>>>> +++ b/hw/s390x/s390-pci-bus.c
>>>> @@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler 
>>>> *hotplug_dev, DeviceState *dev,
>>>>           pbdev = s390_pci_find_dev_by_target(s, dev->id);
>>>>           if (!pbdev) {
>>>> +            /*
>>>> +             * VFs are automatically created by PF, and creating 
>>>> zpci for them
>>>> +             * will result in unexpected usage of fids. Currently 
>>>> QEMU does not
>>>> +             * support multifunction for s390x so we don't need 
>>>> zpci for VFs
>>>> +             * anyway.
>>>> +             */
>>>> +            if (pci_is_vf(pdev)) {
>>>> +                return;
>>>> +            }
>>>> +
>>>>               pbdev = s390_pci_device_new(s, dev->id, errp);
>>>>               if (!pbdev) {
>>>>                   return;
>>>> @@ -1167,7 +1177,9 @@ static void s390_pcihost_unplug(HotplugHandler 
>>>> *hotplug_dev, DeviceState *dev,
>>>>           int32_t devfn;
>>>>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>>>> -        g_assert(pbdev);
>>>> +        if (!pbdev) {
>>>> +            return;
>>>> +        }
>>>
>>>
>>> I don't understand this change. Could you please explain ?
>>
>> We need to tolerate that pbdev being NULL because VFs do no longer 
>> have zpci and pbdev will be NULL for them.
> 
> Then, I think we should extend the assert with a check on pci_is_vf(pdev)
> to be symmetric with the plug handler and also, use the 'Error**' parameter
> to report an error.

This should never happen unless there is a programming error so plain 
g_assert() without error reporting should be fine. We don't need to 
report an error when it is VF; we just don't have a work to do and 
nothing wrong happens here.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> C.
> 
> 
> 
> 
>>
>> Regards,
>> Akihiko Odaki
>>
> 



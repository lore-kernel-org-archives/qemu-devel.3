Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54A0CDD541
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwfU-0005au-Oe; Wed, 18 Sep 2024 11:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sqwfQ-0005Xz-Vj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:32:32 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sqwfO-0005kr-7I
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:32:31 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so2075332a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726673548; x=1727278348;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=go59U1EnQgtzucR6l4lrKMA5NRKsTH+MkrqJ5+pKzXk=;
 b=NHSwbG+0oZOb8v6wh7gu5TpWktBHaLB0nom/vPIhYHLnv7yjoC652tlhuO9XMmv0ws
 zGlFnrj4cBSVzNMKlA2ad3NwEKHanB7SPIuhx5S0Ea1vU7VXIvsehQ18lSjKjkpK/hc6
 b3bdGtZETdm0mbJL/3SvbJdzMcrneQD4lENKqRJAqBL6pdVSURPObjAgN8zfrzsJy9i5
 +GYDbLPjuY1ekLhbPhQRWI+/tlj41pmvCeV4fCsHCacHL+phAMboWM7cJvnjWbtsws9Y
 Wx6a0HH9h4v7kvPiGxsan1XdPKixddbzo+PYhQb+00yUHOpOMvYH9yuDK8GzQwSqwoVI
 7dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726673548; x=1727278348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=go59U1EnQgtzucR6l4lrKMA5NRKsTH+MkrqJ5+pKzXk=;
 b=b9HkkQlidDXj9/ZripnGX0FrFu5VN2Es+WEb7RKjXGCbKsP2P8Q+0rPFOA70UlWkvB
 P/xSY95kghx5LVm8WwtIMJJ8rCo2bm7jGrzZ3tguP9oCttL0DqDBsimjt2tneN9SIuKW
 YmCBQmc1XzK56k2ucWaySjINklCNlHEBTApWiRBsXRFNzlpe2o8la3rjrnW0PZvTtQqM
 4nkctioo0IMSmFHY/9SrSfG0dV0WYoUvlC3GDe2DeJMQf8uJTn2uoxcSugstLlhGALzM
 k8k7vQ1tBdR/1gnKixeKcyRRyD96/5DxiQfPqMQqGCPS3qxRUFPhNoEL1vVrULmQCuTf
 OU0Q==
X-Gm-Message-State: AOJu0YyBsNGxgzfHd4B1MtvzJLzCY6MLzXpWPUcy6JE5i33RAFltJngI
 1WF1S/I+Mo/a2PacMLFXfSF/9dITpLosc7KF/Q1rXchUI8DogP/9PzWOiwSsf34=
X-Google-Smtp-Source: AGHT+IGDz9uO1wnjlPpW3jk4AX+I/jdaeLZ7yegYsO361KIMOoJDPUzt2sfHoytDjA6rr7BsvJAQ3A==
X-Received: by 2002:a05:6402:1e95:b0:5c2:768d:23e with SMTP id
 4fb4d7f45d1cf-5c413e4d08fmr23829718a12.27.1726673547755; 
 Wed, 18 Sep 2024 08:32:27 -0700 (PDT)
Received: from [10.130.6.89] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc89048sm5094710a12.88.2024.09.18.08.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 08:32:26 -0700 (PDT)
Message-ID: <9e11e7b2-48f5-4b5e-8962-e7879016f04d@daynix.com>
Date: Wed, 18 Sep 2024 17:32:25 +0200
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4048f295-1073-432d-9c89-dac1b6b30da5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/18 17:02, Cédric Le Goater wrote:
> Hello,
> 
> On 9/13/24 05:44, Akihiko Odaki wrote:
>> VFs are automatically created by PF, and creating zpci for them will
>> result in unexpected usage of fids. Currently QEMU does not support
>> multifunction for s390x so we don't need zpci for VFs anyway.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 3e57d5faca18..1a620f5b2a04 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>           pbdev = s390_pci_find_dev_by_target(s, dev->id);
>>           if (!pbdev) {
>> +            /*
>> +             * VFs are automatically created by PF, and creating zpci 
>> for them
>> +             * will result in unexpected usage of fids. Currently 
>> QEMU does not
>> +             * support multifunction for s390x so we don't need zpci 
>> for VFs
>> +             * anyway.
>> +             */
>> +            if (pci_is_vf(pdev)) {
>> +                return;
>> +            }
>> +
>>               pbdev = s390_pci_device_new(s, dev->id, errp);
>>               if (!pbdev) {
>>                   return;
>> @@ -1167,7 +1177,9 @@ static void s390_pcihost_unplug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>           int32_t devfn;
>>           pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
>> -        g_assert(pbdev);
>> +        if (!pbdev) {
>> +            return;
>> +        }
> 
> 
> I don't understand this change. Could you please explain ?

We need to tolerate that pbdev being NULL because VFs do no longer have 
zpci and pbdev will be NULL for them.

Regards,
Akihiko Odaki


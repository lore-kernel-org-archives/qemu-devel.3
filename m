Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222A2EE4991
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soL3R-0001bv-W3; Wed, 11 Sep 2024 06:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soL3K-0001ZO-Jr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:58:26 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soL3F-0005Qs-Up
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:58:24 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3e0510b6647so738935b6e.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726052300; x=1726657100;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A9xroaeEdzFAovweYcWBZQ4gfW9MaxGeWewKuyk2Zjo=;
 b=h6eZkgDk3RxRkyZ7Fa5IzGhJZRNaON5N5IAChIKVjTYeDynDOPS7/njTEzf0GtqnWB
 xjd8Jqsoeq38Q5A7OyoZ4KMreVVwEJxtHkUOCschEwEgKyOwhSnE/cPw4Z191p3rvBq0
 GIAm+vRVZNaQyeAGThpFuXWNH+qmrQ1Awvq5ixjZifZgQPBDB9HICO7PjkTh4/PyPQxY
 DI7kYU9RAcz4nPBymJPb1I67N8g9Z5wgAqg2+IYq6DnhZJny8/q6cl4mt4nKNYKrGo/t
 3H7gRiWB3iW550Yb/7VFrmbcqyjKI65/7r7m+1jIirDCizLwxOxn26KZTfgh/nV1RBw9
 wmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726052300; x=1726657100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9xroaeEdzFAovweYcWBZQ4gfW9MaxGeWewKuyk2Zjo=;
 b=ACXZOipIyAgz+9UzF0FPkrd62qoT1GmQDJ01oYhWvd7C/HNAeGcbvmqKLqP9Wb7/jj
 huhy+ufayerLU4dkOjV/PLFxJPnpmxLmEZGgsm2edazAiAiNiJPxfi1tqKXLE4GPUmsw
 NCpUp/LEh+deC3Hov4toOes8Wu/zC97r3Ce9tV0ihfnMMsCwhOUOM21ttt7qRFvfb/tE
 xM8KOTIjBqVPQNN8g728c2PF70m8xcBOwLHOjNovn81UtuU1nI5B4m8WhuS+SLKZZd2+
 nLWIYKiZGAnjehaR+rDHG2OaCK9h9yqPkqCibt+CqbrYMmw+vRqanZoPtAR4ZWte3iVV
 OBnw==
X-Gm-Message-State: AOJu0Yyn+YaC9pQe1Ri1cMHV4TULL/HBHT8kH4oucoY6LVyTUBshL+B3
 yh9TZCiN0vrDwqVAnidEFSFtpF1WKVM8TFFSmtrBnRU9yKuR4od1Y7jTK4KIvx0=
X-Google-Smtp-Source: AGHT+IHA1QKBWUlOROP6NXJ8lCzXjYte88kEOfPYYbpBDLy7J+a+40KjXlGpsGuBS9kDoDWLNxQR1g==
X-Received: by 2002:a05:6808:f10:b0:3e0:4057:6df9 with SMTP id
 5614622812f47-3e04057714fmr9347569b6e.16.1726052300151; 
 Wed, 11 Sep 2024 03:58:20 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db191eb8f4sm667411a12.74.2024.09.11.03.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 03:58:19 -0700 (PDT)
Message-ID: <eaebda7d-c61e-4ed8-a6b9-98e5f48f26ff@daynix.com>
Date: Wed, 11 Sep 2024 19:58:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction
 after device realization
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
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240823-reuse-v15-4-eddcb960e289@daynix.com>
 <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <2b5d2fce-8a1e-4f50-a5d2-0c4aaa2880af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
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

On 2024/09/11 18:38, Cédric Le Goater wrote:
> +Matthew +Eric
> 
> Side note for the maintainers :
> 
> Before this change, the igb device, which is multifunction, was working
> fine under Linux.
> 
> Was there a fix in Linux since :
> 
>    57da367b9ec4 ("s390x/pci: forbid multifunction pci device")
>    6069bcdeacee ("s390x/pci: Move some hotplug checks to the pre_plug 
> handler")
> 
> ?
> 
> s390 PCI devices do not have extended capabilities, so the igb device
> does not expose the SRIOV capability and only the PF is accessible but
> it doesn't seem to be an issue. (Btw, CONFIG_PCI_IOV is set to y in the
> default Linux config which is unexpected)

Doesn't s390x really see extended capabilities? hw/s390x/s390-pci-inst.c 
has a call pci_config_size() and pci_host_config_write_common(), which 
means it is exposing the whole PCI Express configuration space. Why 
can't s390x use extended capabilities then?

The best option for fix would be to replace the SR-IOV implementation 
with stub if s390x cannot use the SR-IOV capability. However I still 
need to know at what level I should change the implementation (e.g., is 
it fine to remove the entire capability, or should I keep the capability 
while writes to its registers no-op?)

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> C.
> 
> 
> 
> On 8/23/24 07:00, Akihiko Odaki wrote:
>> The SR-IOV PFs set the multifunction bits during device realization so
>> check them after that. This forbids adding SR-IOV devices to s390x.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 3e57d5faca18..00b2c1f6157b 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -971,14 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>                       "this device");
>>       }
>> -    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> -        PCIDevice *pdev = PCI_DEVICE(dev);
>> -
>> -        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> -            error_setg(errp, "multifunction not supported in s390");
>> -            return;
>> -        }
>> -    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
>>           S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
>>           if (!s390_pci_alloc_idx(s, pbdev)) {
>> @@ -1069,6 +1062,11 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>           pdev = PCI_DEVICE(dev);
>> +        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +            error_setg(errp, "multifunction not supported in s390");
>> +            return;
>> +        }
>> +
>>           if (!dev->id) {
>>               /* In the case the PCI device does not define an id */
>>               /* we generate one based on the PCI address         */
>>
> 


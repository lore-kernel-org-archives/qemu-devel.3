Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8CCC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtvX-0007M3-6t; Tue, 11 Mar 2025 03:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtvG-0007KD-0l
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:21:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtvD-0006iV-PE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:21:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso20407855e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741677657; x=1742282457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4MRcosGk5JGw79qKqLYfP0CenMmA/FvXV8RIFTg3nM=;
 b=ZcU58Dr7+3iN/70Y4W6lDHMFKkg6eTJJOpKmmSMPsBsTktsOI28M3oLasVUdHJhF8V
 A3P95r+GQOINojHXFlfyvfel+xq8VncNCuxpyHmFQ/B9WF+INF/pSWsUsm9sShxu/wcS
 8psfkgQaMJGp9V6dpYthpIgNwjVVCT5gCs2c7SbOBpP1wO+2VomZpX//sH6nxDYN0BGg
 vh/PiVMLmAi8lL6yZv5t+DtSb+G416d8ebVveK27O5T+pJLXQhtJXIQsZ6cdNKwKuhxD
 pTd8gP3hKZ4aBOrOyyyj6XVnSd5dYn00amjdki+y8qSF3B69VUBKNM4lzSSwoGnFotIX
 0z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741677657; x=1742282457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4MRcosGk5JGw79qKqLYfP0CenMmA/FvXV8RIFTg3nM=;
 b=gJ4//79DmRdTkAXtEriVh3ODCoY8LVmsupVnW9Miz8Z52GRYDpNKMV+jBOcs9is5lQ
 TUosDryrf0BZLqTk5T9/g96z64zBJLhYXEtm79ZDwLhcZyKNAJ2aY55P8F5MtC1fXo9b
 GjXRow1LKC93JN5UVjN2RM/hdARmOIlqW15fs0eg7RUhVmplGW9/xL30ZbdzdmqpiHTl
 GcD5EfGIbLB0kRd7a1piN+tfLVoU4HuTOWJ/LIzEql0bymN6Q74+L2q/75svT6DQN9bt
 JT6cUjxF2pNNrHbBzJxrmhFPEYUgZr2sN/Li4eDxCRhKJvhsF4EyKoIwA8vrsjWF3QR8
 hZTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOgu7Fek5CFTViHdrrcEaH51ZW+J3bAL9O2TwsgQQTh5MB8RRgKgx7ux+0msIt+FW5vSmkBW5p2AOD@nongnu.org
X-Gm-Message-State: AOJu0YwSbBKinJXEX5hTapleGNMqBLFHu82rmHpJhkiQ07TjEierLvVE
 55f0FHE9VPl1fqErO/R5HybOIWgnJ21MyDOK6CbaEo8DSwHLjptvvKU0/4NxXUQ=
X-Gm-Gg: ASbGncu8ov/ex0sngrukub4ba+12yBW54jPSjvGyJ7qpub0u87qzQnB22+dR5J7PDot
 0TL8HRK9tQ9l/QMywH4W4lGq4GscG7Cl9/1u9fmXy0oLKVd/OfhaSFShu3w047dZmkZY+2HHeWs
 lAApjAmkKecHXyMj5f3tfQD/d6RUYHmmjCk/vSi+/LJbSbnMmfVYXtgPZJOMKMSRT2bxLkslqay
 5qoLPc7AFWc80lBbZ+z63iHBfuRRZGqggE7+g2mnXtTeBqaGN+FDMID5ucetXS+JnhozkdMJ8/y
 MwwKhljl6c6hFNK7fWBGY48K2FsGHBjPFi+xRsIMa28UFwS2tcNiuOuy46HwZ7UBtIoiRu8VRva
 2HtG4O0V3zZdy9mKQ27VoLk8=
X-Google-Smtp-Source: AGHT+IE33NbAzCSykM60RwAZcUfXCXv25nI93SsQFLsQX/Peru1MjtR010FE94Sh2y0PIickba5sYQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43c549dcc0amr142489625e9.0.1741677657327; 
 Tue, 11 Mar 2025 00:20:57 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d059354e2sm7678345e9.0.2025.03.11.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:20:56 -0700 (PDT)
Message-ID: <456ee79a-04e9-4b8d-8b04-843f97a55ee2@linaro.org>
Date: Tue, 11 Mar 2025 08:20:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime
 using iommufd_builtin()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-16-philmd@linaro.org>
 <SJ0PR11MB67449BEA0E3B4A04E603633C92D62@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d883d194-3a68-4982-a408-d9ab889fd2c7@linaro.org>
 <SJ0PR11MB674427BA969DCC35B1FACBAF92D12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SJ0PR11MB674427BA969DCC35B1FACBAF92D12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/3/25 02:54, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH v2 15/21] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime
>> using iommufd_builtin()
>>
>> On 10/3/25 05:11, Duan, Zhenzhong wrote:
>>> Hi Philippe,
>>>
>>>> -----Original Message-----
>>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Subject: [PATCH v2 15/21] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime
>>>> using iommufd_builtin()
>>>>
>>>> Convert the compile time check on the CONFIG_IOMMUFD definition
>>>> by a runtime one by calling iommufd_builtin().
>>>>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> hw/vfio/pci.c | 38 ++++++++++++++++++--------------------
>>>> 1 file changed, 18 insertions(+), 20 deletions(-)
>>
>>
>>>> static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>>> {
>>>> @@ -3433,9 +3430,10 @@ static void vfio_pci_dev_class_init(ObjectClass
>> *klass,
>>>> void *data)
>>>>
>>>>       device_class_set_legacy_reset(dc, vfio_pci_reset);
>>>>       device_class_set_props(dc, vfio_pci_dev_properties);
>>>> -#ifdef CONFIG_IOMMUFD
>>>> -    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>>>> -#endif
>>>> +    if (iommufd_builtin()) {
>>>> +        device_class_set_props(dc, vfio_pci_dev_iommufd_properties);
>>>
>>> device_class_set_props() is called twice. Won't it break qdev_print_props() and
>> qdev_prop_walk()?
>>
>> device_class_set_props() is misnamed, as it doesn't SET an array of
>> properties, but ADD them (or 'register') to the class.
>>
>> See device_class_set_props_n() in hw/core/qdev-properties.c.
> 
> But it set dc->props_ and dc->props_count_, first to vfio_pci_dev_properties
> and then vfio_pci_dev_iommufd_properties, this will make qdev_prop_walk()
> find only iommufd property and miss others. Do I misunderstand?

You are right! And I thought I was understanding what this code does...


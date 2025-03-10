Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D85C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdKZ-0002rQ-G1; Mon, 10 Mar 2025 09:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdKV-0002nT-LP
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:38:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdKT-000849-RM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:38:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390effd3e85so3731894f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741613878; x=1742218678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8KySdQxX1nHvjTTeGWqK8o0qyyUi+8pyjyiDw/OuToM=;
 b=IMByab7Pe1sYnxW3BjPBCqMtyTWVyE2LuwVvt9mhQxcbzqtQBV75fj0hqclayobzSo
 jF3UaQ2Xd4LTppYHI7kfSNUf5Dlf6SjynkrKE2zLlCQb70mO8Fr2wRph/nU41LbebVWE
 15Zdy8Md7vxW00gK7a+Z7fnoPvwbb+wARRBgswpt3fc79pQOpByw2EEGf233wdTCdXcc
 EZ3L/eXpaGM5q/SEKv8cO5KSGxmieX/EYzmUe78wGQK29aJZ0Tk6x0KDaWC8JS7KRFae
 QR3To42KqiU5iCnNbK7Uldz2jWgZb2sod/JHwe2wIXIUvIZnfEOug72j378orxIb7S1Y
 qH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741613878; x=1742218678;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KySdQxX1nHvjTTeGWqK8o0qyyUi+8pyjyiDw/OuToM=;
 b=piTe/EYU2I0bHIRZZhMxMrx4olxSL0ls35UP23SEJADQygtOpGiRNd7h6kqZMavtAk
 bGThXVk7ghwDcczhpKELKCfDYGpb3Hp5BfNsGiQW7KbTeh0bFwIKf71XfhZzdvXAIO1e
 BVCHD8S53dI7PT6f0hnV57GL5K4hGg+9e/IffxxbYB7QEO6Cu7+1LwJUsKqfAyaBbnXi
 cb6XLiozQbgSdrj4qPfUaAqRegQU5kgF8+0pY6pfFiyu01slnjDqnW7HXTXw83EFUf2e
 uybZ5piHxUMBKeujO3pAPkWz1RGAM2SA+7vj1+PWQT8WuazoJXmYbbJPYS6dtRbpOIU9
 HTJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCCNmn3QafSvaREG13qKywU91s2RdecWetHaY9S6imQuVN74eOK04cUCoLrS5zOeSORhYVTNSz5w5n@nongnu.org
X-Gm-Message-State: AOJu0YyiVs6LrJY1U7sPoopdSxCY2QR4neNIkG8U4a+dXmnMjHbBNE9a
 V7vUTK+l5PZe6wWz4Z6OYouIm868QE3AsDLYb/3ajlW9mpJZEJnrWq0WzlDHm+Y=
X-Gm-Gg: ASbGncuHpbeCV5MBfq3RqNHPlUNyUYFeBi9pmvN2Tn3QR7eyn7ywPLsh08mMYj4xSPg
 K7dbII2AZ59BfgRf1NfFRV5UZapJnMYuq38cOaQCDen8uMJ9d/a5WW2bPjJfVbQCPRwpkI6FoOS
 NFdMdy8/RmgxM+5Srl8L2V5a5AR0mPve8gIYElyHePJ/qYEl26DFh9lv+/Vj7tpEuYiCy7jfQUJ
 Z8kH8EDqrslR40DO0kOGszqy5x1LKtbUTvZM7IXEUVcAuzpOHY0GZIkRaI/RCz75EEfR6VOou17
 dZOv10Ho8fsfpQJxf7R3oSzavJEc7Dpaif9HB1gswRj18L5YswuyB6b6cHpEHquN/SkyfugjzU5
 n1XxlshxOqubD
X-Google-Smtp-Source: AGHT+IEi3Zkt+nyRM6pBylfBbjpQZ+nrPau9+qv5tN7Kk8GGNSrRDFA2w3bF2VCAkL483hx7lOZtSA==
X-Received: by 2002:a5d:64ec:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3913406b7e9mr8435477f8f.49.1741613878158; 
 Mon, 10 Mar 2025 06:37:58 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e3099sm15376268f8f.69.2025.03.10.06.37.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:37:57 -0700 (PDT)
Message-ID: <d883d194-3a68-4982-a408-d9ab889fd2c7@linaro.org>
Date: Mon, 10 Mar 2025 14:37:54 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SJ0PR11MB67449BEA0E3B4A04E603633C92D62@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/3/25 05:11, Duan, Zhenzhong wrote:
> Hi Philippe,
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH v2 15/21] hw/vfio/pci: Check CONFIG_IOMMUFD at runtime
>> using iommufd_builtin()
>>
>> Convert the compile time check on the CONFIG_IOMMUFD definition
>> by a runtime one by calling iommufd_builtin().
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/vfio/pci.c | 38 ++++++++++++++++++--------------------
>> 1 file changed, 18 insertions(+), 20 deletions(-)


>> static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>> {
>> @@ -3433,9 +3430,10 @@ static void vfio_pci_dev_class_init(ObjectClass *klass,
>> void *data)
>>
>>      device_class_set_legacy_reset(dc, vfio_pci_reset);
>>      device_class_set_props(dc, vfio_pci_dev_properties);
>> -#ifdef CONFIG_IOMMUFD
>> -    object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
>> -#endif
>> +    if (iommufd_builtin()) {
>> +        device_class_set_props(dc, vfio_pci_dev_iommufd_properties);
> 
> device_class_set_props() is called twice. Won't it break qdev_print_props() and qdev_prop_walk()?

device_class_set_props() is misnamed, as it doesn't SET an array of
properties, but ADD them (or 'register') to the class.

See device_class_set_props_n() in hw/core/qdev-properties.c.

I'll see to rename the QDev methods for clarity.

Regards,

Phil.


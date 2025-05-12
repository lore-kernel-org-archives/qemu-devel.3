Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECB6C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESPL-0000NF-D1; Mon, 12 May 2025 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESPI-0000N1-Ra
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESPG-00043f-7Q
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747053433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Hm0xT26fUjefdmNIXpOjBeZwtbDvTFlkXVqqCbGwEs=;
 b=H03UeFAJ/4yweD8Z1Rt/VhRZ5rdkoIJQOiM/lHb3icCwNXEoJDUqk3Lwb6lUpdFcxVX89D
 trMZHoEV4sQ2Zn9yMyQOoJYYlxNSD0vI/z0U5iubrUWEeAWlDDBXBn3sykHIdA72OfH3kT
 YB5sPYcwkObQEHwpvc1oin+7N5gRBF8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-v0a68kmTMQayezDm4pMbdg-1; Mon, 12 May 2025 08:37:12 -0400
X-MC-Unique: v0a68kmTMQayezDm4pMbdg-1
X-Mimecast-MFC-AGG-ID: v0a68kmTMQayezDm4pMbdg_1747053431
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so23242045e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747053431; x=1747658231;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Hm0xT26fUjefdmNIXpOjBeZwtbDvTFlkXVqqCbGwEs=;
 b=O8dqmh9HEBAWDrIYig89GN3sjtBEl+H6ZtW/FzgjAp2kyG72tOAzsjsEpr/QZ9ZGON
 HZ/PByWhdmSNC/hfbKRU9ODr6kS1wT0Ig63eBofhFvHheShzMdE5/ESZLIFrMeGS3UU2
 vfuKl1Gd/dEVhNqHu59nMXMy1MurpSbjcD+F6w2faFGK05CbAPGP3ZymxkFuwQhoILO1
 I9zjPIN/WxxgIC9oiwdKDoMIbYHNwsl2Y3VmaQYBLFMwmHvSXfy+SOXQU4lOeOcqdGaG
 EJygsN1c/Qj4Gx8f3fc5proq6wLopCswI3KEcyvUjH9i3YN/AYAHADwbrCRAttUP4wXZ
 hDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXy8leymq4T6YzRsnw22YREK/bUKpe0mf9dN8zqCs/LI2Xn5Z+32hB/DmXTC3yKL9qGHvU1pJ0yDy@nongnu.org
X-Gm-Message-State: AOJu0Yzi7nN19ZAkKAdA2MIdX1fiisnh+ErZsmzEBA77k9KU/VH1C2rH
 +2eQjZz8mqBsjDeshGB9hpDV2O61wmKt8hwJnBXg572EZgqkA2cr85NpQTjUQFEglkjwQ1Ks9p0
 c99re0WiAmaCRq+30iU2dOdTPyJATkrF7Kho+ltuQ6l5cCIWtO+IZ
X-Gm-Gg: ASbGncvFtUEFPXi0U4hNUY4oPizdtWhetflH//0yBvMnQ7wpL/trVOVm1/CYP3CiOvb
 SLm+N9a9L8rOQwuiuviStobK47xg6fxFQowLK+t/eov3Xz2pbjtnNXYCNZU/0E/iU9ZhPZoOHTn
 859GPA5EwyoZqO7GNsoNd4iYGidisV6VR8pTdnONdgOu4qNgRS/9mSrY6DltXaY2DUXIUA/E0M9
 ANbk75KrnTftTv0p0hDXsqThSK8UprIb0V3gJJXHdMQoyRGkUtyfeOxuNUhJHQzpF/Age6SVVM/
 ta3j/Z3wFACHe4FQAWLrIhH/QD5+toSVFm65wTtYfbSwnuNMHJ4n
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr103894535e9.17.1747053430951; 
 Mon, 12 May 2025 05:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhIsFiEhqD+fZsVaH3hfftLkKAHAPmq0aualEAq4ahb9AlPr5lyP0sDyZjMxK7U6/YTfs3ug==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id
 5b1f17b1804b1-442d9cacc19mr103894285e9.17.1747053430585; 
 Mon, 12 May 2025 05:37:10 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67df574sm123372415e9.11.2025.05.12.05.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 05:37:10 -0700 (PDT)
Message-ID: <b3c9413d-971e-4ac9-8314-93b88b349495@redhat.com>
Date: Mon, 12 May 2025 14:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250509232156.106465-1-gustavo.romero@linaro.org>
 <80e7eacc-0b71-4e1c-981e-607a4ce8a7bd@redhat.com>
 <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e25812d6-cc1d-4727-b24e-208dbbe54afa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On 12/05/2025 14.08, Gustavo Romero wrote:
> Hi Thomas,
> 
> Thanks for the review.
> 
> On 5/12/25 04:59, Thomas Huth wrote:
>>   Hi!
>>
>> On 10/05/2025 01.19, Gustavo Romero wrote:
>>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>>> native controller and does not support ACPI-based hotplugging. However,
>>> since support is planned, this test sets 'acpi=force' and specifies an
>>> EDK2 firmware image in advance. This is harmless and prepares for future
>>> ACPI support.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/functional/meson.build                 |  1 +
>>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>>   2 files changed, 74 insertions(+)
>>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> Could you also add the test file to one of the sections in the MAINTAINERS 
>> file, please?
> 
> Any idea under which section I should add this test?
> 
> Currently, it's only TCG, but in the future probably there will be
> 1) a variant with --enable-kvm option and 2) it will have a variant
> with ACPI enabled. Hence, currently it doesn't seem to fit neither
> under "PCI" nor under "ARM ACPI Subsystem", I think I can create a
> section tho? Maybe "ARM PCI Hotplug"? Could you please advise?

A separate section likely only makes sense if there are other files that you 
could add there. Otherwise, simply add it to the arm "Virt" machine section?

  Thomas



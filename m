Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2DDC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 06:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJo5c-0008C1-OE; Tue, 27 May 2025 02:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJo5V-0008BW-MY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJo5O-00009q-Jo
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748328411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKcUKj/LlKENAraKAjOyxIlLxLJFH0ua2ybc/69QUec=;
 b=eL0D7x/W1dlkyfTeMl7eIZnn744CgRqx1+WUJ4QLi/rgk6igkh/Q+QDlqz2bH9Ozyvp4mg
 tZQxlwD+ck3747uBMWfWzEb6omc2eMSpMtdvW/01NBNIR7RBgkP28394G0cO27x0bJmeuy
 TImTCV4rPwl9ZCCkhWs7mhszQIzxETg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-yoAFzHnIPausWOrA-jjohw-1; Tue, 27 May 2025 02:46:50 -0400
X-MC-Unique: yoAFzHnIPausWOrA-jjohw-1
X-Mimecast-MFC-AGG-ID: yoAFzHnIPausWOrA-jjohw_1748328409
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so16925295e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 23:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748328409; x=1748933209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKcUKj/LlKENAraKAjOyxIlLxLJFH0ua2ybc/69QUec=;
 b=tFSzJWlAd134urXVt6XWvrko+dWL84fziUsV99rdgoaOMJ+Rp8ksNmqo3pNIf3spqi
 QyolpNM0HGqWkF42k4EQu25YUaqJzrItHN6yrkvmzWff7AcPsv4BV+DQAzxh70sLg4Dn
 bcPAWQmvaiXijf1pGzxBWF5gUJtDoDHxk7cC3no5hG7fiKI1IZju/8a1IBm6JBaEQGNX
 lKqqWmjhyay5Pesb6BcuylEcnVfhB6vrXzrRgkOeVt0CUycu1tRQ+0JwV9PpMrsRmCKy
 ypmYuQbMGIQ4j23YXSz56Lh1Cxa4qL97QuNwDp/ajxHNHzWYAbEZLhcAdh0hvFsMQef9
 xXEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHGrDntY8Yt8h5n0rEJ3DIT9DS42noertQz7mZQhwZSJS2IucaMX9wCuYcCfroLixVVnf4tmdW+RTJ@nongnu.org
X-Gm-Message-State: AOJu0YzS2U3B7rBDZeVO+He2+y+mG+JLVmflyg/yA/m21USSF5nJWSgs
 ZNaCvPoFjEfCUMMWtB/hjNTPfUxcibX8PYrEy758oM/an6cQHqVWmjr0iQyyw9awHUI1ssKcWgx
 6DMUE6HjC4AUIlurr5DJoAR/fEw9i75d0RchN5GrULWgLh1PXtrz5yzuo
X-Gm-Gg: ASbGncs8To3LIKwBy6o0ZEwB7EXOGPzK6Mu+pqbKvGB53qJWT8oOZUnKF8uXzZ9QBdz
 F7cBr5eU3kVOhI6nt5h56p1wdcZ0GF2YPczyLD7OrVPKb51MizLfs2J4dedBHb70W0IKjmfULtG
 iOX/AYZjsYgM/pIT9c2v2qIJ70XKMH5SLy/us1wkmuUfiBhrq5TcvqapQ9ShVTvg0x6u9ScLLG9
 rQjA92MGJNe28KAH+7MGVGI4KZyNMDSTvHVNZWmqpyHTmL2hFELnqe+ncMVSCkKrqv55hm5DW7u
 TqdTZANLPEyjg0m/Ugoet42KcHOVobdV93vs0DDoXsUojq+Q3DBy7OXn4uk=
X-Received: by 2002:a05:600c:4fc9:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-44c91ad70d0mr133060635e9.10.1748328408740; 
 Mon, 26 May 2025 23:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgeaJ2BLqWogyzXrlL0xyf9fbddk7yc4wxPjPU3t39H9OGnvkOfldAtfu7GNwNJZSvgouWjw==
X-Received: by 2002:a05:600c:4fc9:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-44c91ad70d0mr133060355e9.10.1748328408358; 
 Mon, 26 May 2025 23:46:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0552esm255876705e9.11.2025.05.26.23.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 23:46:47 -0700 (PDT)
Message-ID: <cdf2bcaa-ca41-4af2-9eaa-408f81f891fd@redhat.com>
Date: Tue, 27 May 2025 08:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-3-gustavo.romero@linaro.org>
 <a9a8d55f-7409-4dd6-97f6-a373de9870df@redhat.com>
 <d86cd26f-c43d-4a99-bd9e-573d3d7cf8bd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <d86cd26f-c43d-4a99-bd9e-573d3d7cf8bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/26/25 6:09 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/26/25 12:28, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 5/26/25 7:31 AM, Gustavo Romero wrote:
>>> ACPI PCI hotplug is now turned on by default so we need to change the
>>> existing tests to keep it off. However, even setting the ACPI PCI
>>> hotplug off in the existing tests, there will be changes in the ACPI
>>> tables because the _OSC method was modified, hence in the next patch of
>>> this series the blobs are updated accordingly.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   tests/qtest/bios-tables-test.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/qtest/bios-tables-test.c
>>> b/tests/qtest/bios-tables-test.c
>>> index 0a333ec435..216941dbb5 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -1626,7 +1626,7 @@ static void
>>> test_acpi_aarch64_virt_tcg_memhp(void)
>>>       };
>>>         data.variant = ".memhp";
>>> -    test_acpi_one(" -machine nvdimm=on"
>>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>>                     " -cpu cortex-a57"
>>>                     " -m 256M,slots=3,maxmem=1G"
>>>                     " -object memory-backend-ram,id=ram0,size=128M"
>>> @@ -1775,7 +1775,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>>        * to solve the conflicts.
>>>        */
>>>       data.variant = ".pxb";
>>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>>                     " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>>                     " -drive file="
>>>                    
>>> "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>>> @@ -1846,7 +1847,7 @@ static void
>>> test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>>         data.variant = ".acpihmatvirt";
>>>   -    test_acpi_one(" -machine hmat=on"
>>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>>                     " -cpu cortex-a57"
>>>                     " -smp 4,sockets=2"
>>>                     " -m 384M"
>>> @@ -2123,6 +2124,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>>       data.smbios_cpu_max_speed = 2900;
>>>       data.smbios_cpu_curr_speed = 2700;
>>>       test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-smbios
>>> type=4,max-speed=2900,current-speed=2700", &data);
>>>       free_test_data(&data);
>> On my end I also need to add -machine acpi-pcihp=off in
>> test_acpi_aarch64_virt_tcg_numamem
>
> Yeah, by reading the code I'm pretty sure this is required by the
> numamem variant
> as well but I don't see a failure here :( I have _no clue_ why the
> failure doesn't
> happen on my env. Are you running simply "make check V=2"? arm64 host?
on my end I am running on x86 host with TCG aarch64 configured qemu
make -j 128 tests/qtest/bios-tables-test
cd build
QTEST_QEMU_BINARY=./qemu-system-aarch64 tests/qtest/bios-tables-test
>
>
>> with that fixed,
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Thanks for the review! I'm sending a v2 with numamem variant fixed.
>
> BTW, I'm sending soon also a functional test variant for acpi-pcihp=off.
OK thanks!

Cheers

Eric
>
>
> Cheers,
> Gustavo
>  
>>
>> Thanks
>>
>> Eric
>>>   }
>>> @@ -2142,6 +2144,7 @@ static void
>>> test_acpi_aarch64_virt_tcg_topology(void)
>>>       };
>>>         test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-smp sockets=1,clusters=2,cores=2,threads=2",
>>> &data);
>>>       free_test_data(&data);
>>>   }
>>> @@ -2227,6 +2230,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>>       };
>>>         test_acpi_one("-cpu cortex-a57 "
>>> +                  "-machine acpi-pcihp=off "
>>>                     "-device virtio-iommu-pci", &data);
>>>       free_test_data(&data);
>>>   }
>>
>



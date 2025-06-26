Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36264C7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 10:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUjSr-0001Uq-LT; Thu, 26 Jun 2025 06:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUjSp-0001U1-Hw
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUjSn-0002oM-Hw
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750932251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqIMLUpLTvuoDk139361pTQIme9E1ERhTOI3fzvNR/s=;
 b=bMlmZZdI04NmhFQeq5QeQ+Knsy+Q2N1Zli91CKLwQWilHSQJt33XE+br+J4iTk2QY/8oF9
 ihtvYUKFQHfKsVGu6uVXUHiNIzsP0H3CO03MLZR3bjDlhKrC/z0MMTViIBGgaImrDbfc0L
 GYRAGvP8q/H5dxIuZdUz6LOfq3RXrfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-5dsSmGU8P5CUpkkAT5rofA-1; Thu, 26 Jun 2025 06:04:09 -0400
X-MC-Unique: 5dsSmGU8P5CUpkkAT5rofA-1
X-Mimecast-MFC-AGG-ID: 5dsSmGU8P5CUpkkAT5rofA_1750932249
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4535ad64d30so5760045e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 03:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750932249; x=1751537049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqIMLUpLTvuoDk139361pTQIme9E1ERhTOI3fzvNR/s=;
 b=nb5/NKIJbgj4KqrECHMAZoh8i9EFQfF7Y/P8ql+6pE0Cqp0jfxTuamxZb+blXK3ODM
 thhQrdqnoWCq1If82YOjQVD1yazS3KkgrRGPlVBNi7XfoPS9sT//gS4EuK8SaX5Htw6u
 +glbo7nmseOgU0ar+7S0fbP9URfphDCGQSPwY5n+pl5W27QG2eANx2l0G7SHTmfSmQAs
 ICLfunPwovjUEBAm1oqlAXn/it7HyXyszlq2+crrtDG9oG+C9JuVeNo5xmGz9cBH8NiZ
 1KVrJZahWRsuKbjPNATeQtXCkTzEzOuQ52c/a5HEIxQnUaOeEqKNYvCzbjXawICvoLJ/
 ioKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtxONPX7O+4l6D77JEkkHrA3xNu0sydKe6THhBIqwuCMmTlWgjbEnlfPeFScv9hBcvD0xOjTv2T6Bl@nongnu.org
X-Gm-Message-State: AOJu0YzAozbh3kdoG9+/tMRN4hlOCZZdWRlzyWpOes/Ka2Q2ufrZbuCR
 sc9UGbqG36lJF018HpLeGnZpcLS5EKij7rzjqoWxpZIMdOsogEocJNfZA21fDySIL4/C2k6TSWX
 YanAp66oZB9up8vSa4EjA3lfFtXWJi5mDLXJBZA294Gj8ij7GPfw+gVM0
X-Gm-Gg: ASbGnctlYbqzLp3fH+RP7NiDGR+HsJ5ciSqPDEklk7m0eQGE2aIbJ37tRbks/tCQj3l
 zAVxi7bi+mpNLN2Z0C160DnRpmGe2q8oKNbMxJcH9rVQajeExr6PU2PiqZLfpOy0JAFYfFTBrVZ
 GTV/bpfxFNANkYmz2fwwK+OLto3GWsO02Bsht5IDzibDzwTVKDoRjvXBS0ELBzxdreMmuWtpDAr
 7ZFnd+qsyaW21UeqH5tSzrOSSMiGjOPYgGyvagM03hUvdhzfF0DxmoOGLhUJiEBpzOkF8sRDOnr
 /ThJXkSfgtkyc5lFJXofIyIz8n/WO9LSBf0LqvdhXXDmuq7D1MS1d7q5BkrlSlI6JWPGsg==
X-Received: by 2002:a05:6000:1acd:b0:3a4:e7b7:3851 with SMTP id
 ffacd0b85a97d-3a6ed664462mr5585663f8f.58.1750932248456; 
 Thu, 26 Jun 2025 03:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtKyuXirffFfUfIMXv0kq8KSMyOi//um0epxcwoq8PrKPBNp9dzSrDo1TUFFK6ktWz1Pbjaw==
X-Received: by 2002:a05:6000:1acd:b0:3a4:e7b7:3851 with SMTP id
 ffacd0b85a97d-3a6ed664462mr5585615f8f.58.1750932247906; 
 Thu, 26 Jun 2025 03:04:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80ff8d9sm6998132f8f.70.2025.06.26.03.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 03:04:07 -0700 (PDT)
Message-ID: <cebadc10-2525-4646-8810-6c6cc1656b69@redhat.com>
Date: Thu, 26 Jun 2025 12:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/29] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-29-eric.auger@redhat.com>
 <20250620114029.00005a94@huawei.com> <20250620152232.36683ffc@fedora>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620152232.36683ffc@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/20/25 3:22 PM, Igor Mammedov wrote:
> On Fri, 20 Jun 2025 11:40:29 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Mon, 16 Jun 2025 11:46:57 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>
>>> The test uses -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
>>> to force the usage of ACPI PCI hotplug.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>  
>> Could we add the necessary (I'm not quite sure what) to trigger the _DSM
>> creation so EDSM gets used?  I'm not keen on that being dead code
>> wrt to tests on ARM.
> relevant x86 example:
>
>         " -device pcie-root-port,id=nohprp,port=0x0,chassis=2,hotplug=off,"    
argh. I did not see hotplug=off.

So then static acpi-index also works on ARM. So I will make edsm
independent on acpi pcihp

Sorry for the noise

Eric
>   
>                                  "addr=7.0"                                      
>         " -device pci-testdev,bus=nohprp,acpi-index=501"  
>> Jonathan
>>
>>
>>
>>> ---
>>>  tests/qtest/bios-tables-test.c | 34 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>
>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>> index 0b2bdf9d0d..4b9e391eaf 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -1643,6 +1643,38 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>>  
>>>  }
>>>  
>>> +static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
>>> +{
>>> +    test_data data = {
>>> +        .machine = "virt",
>>> +        .arch = "aarch64",
>>> +        .tcg_only = true,
>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>> +        .ram_start = 0x40000000ULL,
>>> +        .scan_len = 256ULL * MiB,
>>> +        .variant = ".acpipcihp",
>>> +    };
>>> +
>>> +   /* Use ACPI PCI Hotplug */
>>> +   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
>>> +                 " -cpu cortex-a57"
>>> +                 /*
>>> +                  * We just pick address=0x04 for the root port to avoid
>>> +                  * collisions with other PCI devices on the root bus (pcie.0).
>>> +                  * It could be any other value that doesn't collide.
>>> +                  *
>>> +                  * The 'chassis' and 'slot' options equal to 1 have no special
>>> +                  * meaning here, could be any integer, but we set them to known
>>> +                  * values to keep the test consistent.
>>> +                  */
>>> +                 " -device pcie-root-port,bus=pcie.0,chassis=1,slot=1,addr=0x04.0x00",
>>> +                 &data);
>>> +
>>> +    free_test_data(&data);
>>> +}
>>> +
>>>  static void test_acpi_microvm_prepare(test_data *data)
>>>  {
>>>      data->machine = "microvm";
>>> @@ -2580,6 +2612,8 @@ int main(int argc, char *argv[])
>>>              qtest_add_func("acpi/virt/numamem",
>>>                             test_acpi_aarch64_virt_tcg_numamem);
>>>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
>>> +            qtest_add_func("acpi/virt/acpipcihp",
>>> +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
>>>              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
>>>              qtest_add_func("acpi/virt/oem-fields",
>>>                             test_acpi_aarch64_virt_oem_fields);  



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253D8C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 12:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1m0c-0006uf-Kf; Mon, 07 Apr 2025 08:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1m0Y-0006tn-2u
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1m0T-0003Q0-NC
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 08:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744030515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uyjmVj8B9vjluIenrfJgcGG0sK9h4/CQ3HQasyGoFIg=;
 b=dLSFcjE9sH3Rj9dTbQsrggrRtmC7G1V+o/CdqDTJqkj9J+6oonRsSoMOM2dg1fmf7LVIRm
 wkpcfjRftDxMsR3u6ZUtBoAnoTCoCv23ua0+2LopWTyzu9z5tMw1ZnMgLFDx3E8Ku5o/fn
 ztq7gsLNjXuIawmCmrM3UFR7KtnpcfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-tO-39vw2OBiGxxCBoK9tzw-1; Mon, 07 Apr 2025 08:55:12 -0400
X-MC-Unique: tO-39vw2OBiGxxCBoK9tzw-1
X-Mimecast-MFC-AGG-ID: tO-39vw2OBiGxxCBoK9tzw_1744030511
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso21731155e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 05:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744030511; x=1744635311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uyjmVj8B9vjluIenrfJgcGG0sK9h4/CQ3HQasyGoFIg=;
 b=QG0qozPYh8QRlyctuvxIBPoRfLbAsL8yqrHLoNLsV29yjfJ0MtDfG+RcZYrn1fVNJQ
 hEdntyx7zbfvWS4HYcUblhw51uCZQVWpoJCnADSvyXBQgHld0icFv0U+AMjme5fDsdd5
 QKEwns/GuWzpphQce5amee199140trJKF+WNGBygKb4tXCx1zMvqLaOujjKu64ZaEYxt
 mscGhHGCKe3n6tDK36LQCKf8jYDdHxQoppJ4wtmk/HChEFFkZjK9XPQWq0O3COThdGDr
 oLiZZDaYLyVSuDjz98Lmf8YsgcxqF/KkdEI7lYERcDXUeeqY+Wm5udAvWkkFo0FJbmhZ
 t+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm7jasgjzT55bRdW1K/h8z66uBfUY3xJbqBqqKMUQvu2V6Ep8UV7/wSsvlZK50T87wpuJMEvWbe3s+@nongnu.org
X-Gm-Message-State: AOJu0YyOEJO20cL5F3C7hkXDyqzRwrjV+doIZGSqtf+b6jayA0tecG6X
 Bo3XrY4YSfk6IcNZciVZWInlU7APra07OGOYG93uZhRe3CTI/M34Put3SnGz0vgUsSgAi+TKKVL
 hWiaZmU/fm85rYtsnQOlmOajHBizEvrX0Q7A2PMsZGVVQYXOWMS5X
X-Gm-Gg: ASbGncuD/L9PiA5yngQ39qKiTQxec3qZ/jGzlfWD7DhbS8wTEZhNDgcj5CQaBzAsVs0
 D8f2SlzIOAnGOfI+4ZaMRmUHBSxMC/Vm7eVK+fDKEtnAf3D7oy2lPAJMtzJdANtaDP76fnCqKST
 TQLXHgqAVfuHbgwwOCz+zKpP4+28YZkYV1EYgX7MTJLjala1hqzDz63754o2/9H0J5rEAlyHlpr
 HmmI2GAr5R2kYGKlEXzxn+FLR3VR0OIXvPydHgAE/nsPGzAQKjJckjqEvuejJwza/qzFMbr9Xyr
 SaE9CjEX6xenpoxVx4fGuFXkzshnaaVp0eEce1k2g0clbs4RHuq030RTKW4DSOA=
X-Received: by 2002:a05:600c:1e1b:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-43eceee3375mr123883835e9.15.1744030511158; 
 Mon, 07 Apr 2025 05:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENE9w0iwv9k7OExJ9WZa/Oz5q3ZWpNVgnJdrwiJb/uv1uRxQ5YAxXaoKx+RwMYZlCQNGLKQg==
X-Received: by 2002:a05:600c:1e1b:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-43eceee3375mr123883515e9.15.1744030510822; 
 Mon, 07 Apr 2025 05:55:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795205sm133398395e9.30.2025.04.07.05.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 05:55:10 -0700 (PDT)
Message-ID: <313047ee-a63d-4396-9209-947138213630@redhat.com>
Date: Mon, 7 Apr 2025 14:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 5/9] qtest/bios-tables-test: Add test for -M
 virt,its=off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-6-philmd@linaro.org>
 <b905164a-e613-466a-9094-bac225cc96fc@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <b905164a-e613-466a-9094-bac225cc96fc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 4/4/25 5:00 AM, Gustavo Romero wrote:
> Hi Phil,
>
> On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
>> Add the use case reported as issue #2886 [*]. The test
>> passes while it shouldn't. We are going to fix that in
>> the following commits.
>
> I think this organization is not ideal. I like better your first
> version, i.e., adding the correct blobs that make the new test pass,
> as you did in:
>
> [PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M virt, its=o
> https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07081.html
>
> The way it is here if you checkout this commit and run the test
> (make check) the acpi test will _not pass_ because of the other changes
> in the APIC, FADT, and IORT tables caused by the other VM options
> (virtualization, gic-version, and iommu), as I pointed out in [0], even
> tho the bug is present and its=off does not take effect.

I do agree with Gustavo. This looks introduced in a non std way.

Found
https://lore.kernel.org/all/20241107123446.902801-6-Jonathan.Cameron@huawei.com/
as an example:
step1) create dummy entries for the variant table data + mark those as
ignored in tests/qtest/bios-tables-test-allowed-diff.h
<https://lore.kernel.org/all/20241107123446.902801-4-Jonathan.Cameron@huawei.com/#Z31tests:qtest:bios-tables-test-allowed-diff.h>
step2) create the new test
step3) Generate & store the new tables and remove lines in
bios-tables-test-allowed-diff.h
<https://lore.kernel.org/all/20241107123446.902801-6-Jonathan.Cameron@huawei.com/#Z31tests:qtest:bios-tables-test-allowed-diff.h>

Thanks

Eric
>
>
> Cheers,
> Gustavo
>
> [0] https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg00438.html
>
>
>> [*] https://gitlab.com/qemu-project/qemu/-/issues/2886
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test.c
>> b/tests/qtest/bios-tables-test.c
>> index 0a333ec4353..baaf199e01c 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -2146,6 +2146,25 @@ static void
>> test_acpi_aarch64_virt_tcg_topology(void)
>>       free_test_data(&data);
>>   }
>>   +static void test_acpi_aarch64_virt_tcg_its_off(void)
>> +{
>> +    test_data data = {
>> +        .machine = "virt",
>> +        .arch = "aarch64",
>> +        .tcg_only = true,
>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>> +        .cd =
>> "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>> +        .ram_start = 0x40000000ULL,
>> +        .scan_len = 128ULL * 1024 * 1024,
>> +    };
>> +
>> +    test_acpi_one("-cpu cortex-a57 "
>> +                  "-M virtualization=on,secure=off "
>> +                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
>> +    free_test_data(&data);
>> +}
>> +
>>   static void test_acpi_q35_viot(void)
>>   {
>>       test_data data = {
>> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>>               qtest_add_func("acpi/virt/topology",
>>                              test_acpi_aarch64_virt_tcg_topology);
>> +            qtest_add_func("acpi/virt/its_off",
>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>               qtest_add_func("acpi/virt/numamem",
>>                              test_acpi_aarch64_virt_tcg_numamem);
>>               qtest_add_func("acpi/virt/memhp",
>> test_acpi_aarch64_virt_tcg_memhp);
>
>



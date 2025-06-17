Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C578C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZgv-0007Hk-AD; Tue, 17 Jun 2025 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRZgt-0007HQ-82
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRZgp-0004Dz-Kh
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750179697;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaMKvH58Hm/XAUBbAWYf0p8rTkd3zwOJrBXUyRUG8fc=;
 b=LkahUzfyj1TRCg1h0z3ZHrjizpXWcODGKAoflIAfugVX9HuK6vFRGNrJNVC+iA6UyFUzAV
 B4Y+96SWdTF1zSJutr8m0enztgeaH3wySml0Zvl8MpDXPsHrLLKSRrVs629FVaHEKk96Rx
 TlLxm44DsozjumpSCaBNhNMIKaNYI/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-lzk_y9UFM9u9lHnC4korHQ-1; Tue, 17 Jun 2025 13:01:35 -0400
X-MC-Unique: lzk_y9UFM9u9lHnC4korHQ-1
X-Mimecast-MFC-AGG-ID: lzk_y9UFM9u9lHnC4korHQ_1750179694
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450db029f2aso28594235e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750179694; x=1750784494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LaMKvH58Hm/XAUBbAWYf0p8rTkd3zwOJrBXUyRUG8fc=;
 b=P5BwM/rRqfUnVDD5yWSdA4VY+V8D7s1Z3obsY1mZSVsFACiV7ks/slfTKymCjqWTMU
 JghsmQyok/nUGTxUvUMVf34crXDXapsVrWVKX1pg76HhVd8Xv1g1ul46JRHsFuPYAkkr
 IHPHzYjcFrkUaT+h+ElRJQhCNJ4v7kJCksuB3Uc3S3tlz2w2UX4UKd9/0emjRUAawyp0
 Wox03A/D/z1R8XZiXvZEtlNUc2tDrpEx94A2JS69ju8KNNzR6nXLaNnZ1+Z8pv3NzL9U
 KDb6nX369HMafgg+pccnpr+ILjHd1gfcwVGbzvbeWlILB0n+uNcHECZuH4pqbwNlnilM
 daXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8lP7R5TOM8RkSiJXUgcVsdwkyrImG42YgKB84UEE+K2SX5UofxQrroM4ihEgCOAuCWqgwnW1Yi1jC@nongnu.org
X-Gm-Message-State: AOJu0YxUlWER5uiz9nmiXuigqTjpIpZ50ftdNYleXAVmIOX235CM+pNL
 bTVQ9ZSGgzaroFMiJcAGszIjK3gy5SqovWG/tM9FcbDvVtbADun7v2vJtqW5wTViYpyUvIROGHj
 LLuUfaM4rgAPnICf5MqyqIJ7gXbmtEowIsXNhWXRRr69ID0olSdnWi/z8
X-Gm-Gg: ASbGncsq5sE7z53yQEzPorUqGGkB5jZogbj1Dh5g+IwLr9bNyOZ5AX2KMQqwfSLMeFq
 Wz6A7P9SdQd5GHsY8VBW0oy5BVvqkxE9L8itmrUq5vTGvM5+bwjYJ+NSA2+Xm6BfzuRwWfWJBNr
 5a0jD16p5hYaTPu+t+wZyf18/ITgVnY6tdhUYQN22R3FAlcI0XSxJ6HB0OzY5Ocnm55y3DigN3s
 WptiqnhWm3kM7YP6fJoVUClRxEvuSJyWKABl1WZjsVTYoBnUhG8jsyGi+D3W7WG+WwlKg/DEcKQ
 gpLHmY/bj98I1AqpO0ihXSJmOcWlc9510hSbFMsAj3ic1hW5AxVnpuCfqPKvNXBOdZlDUw==
X-Received: by 2002:a05:600c:6095:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-4535627dbe5mr20747055e9.8.1750179693182; 
 Tue, 17 Jun 2025 10:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnh2JhFWr0HS0k7Q4pe/iFppeSDPakzFI6SRugk4zUM4iWQPCx4cCB5dalE8KXtxFfD7z54g==
X-Received: by 2002:a05:600c:6095:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-4535627dbe5mr20745125e9.8.1750179691389; 
 Tue, 17 Jun 2025 10:01:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b18f96sm14621701f8f.66.2025.06.17.10.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 10:01:30 -0700 (PDT)
Message-ID: <80ef1248-4fb1-48d8-9c11-f42d08641e9d@redhat.com>
Date: Tue, 17 Jun 2025 19:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] qtest/bios-tables-test: Add test for when ITS is
 off on aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-6-gustavo.romero@linaro.org>
 <fe166574-9e53-4e27-9c12-c91f3fc774c7@redhat.com>
 <3881403f-c618-47d1-afec-27592bd7be99@linaro.org>
 <74c1948a-3c90-431b-805f-b5a4238beecb@redhat.com>
 <e1c05a4c-ead6-437e-9287-84b77fcc9df4@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e1c05a4c-ead6-437e-9287-84b77fcc9df4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/17/25 6:01 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 6/17/25 12:51, Eric Auger wrote:
>>
>>
>> On 6/17/25 5:12 PM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 6/17/25 10:34, Eric Auger wrote:
>>>> Hi Gustavo,
>>>>
>>>> On 6/16/25 3:18 PM, Gustavo Romero wrote:
>>>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>
>>>>> Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
>>>>> hardware introduced in GICv3 and, being optional, it can be disabled
>>>>> in QEMU aarch64 VMs that support it using machine option "its=off",
>>>>> like, for instance: "-M virt,its=off".
>>>>>
>>>>> In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
>>>>> table and the remappings from the Root Complex (RC) and from the SMMU
>>>> I would rephrase "and the remappings" by "while the RID mappings from
>>>> ..."
>>>
>>> hmm true. Do you think it would be even better to say something like:
>>>
>>> "while the RID and StreamID mappings from the RC and from the SMMU
>>> nodes
>>> to the ITS Group nodes are described in the IORT table."?
>>>
>>> I'm saying that because I understand the map from RC to ITS is from
>>> a RID to a DeviceID, while map from the SMMU to ITS is from a
>>> StreamID to
>>> a DeviceID, hence say "while the RID and StreamID". Does it make sense?
>> I think I won't bother and would simply talk about "ID mappings" which
>> is the generic term used in the IORT spec.
>
> But I just dove into it because you suggested to use "RID" (aka ReqID,
> aka
> Requestor ID, ah, I "love" these variations in specs), so I thought, well
> RIDs are related to RC and StreamIDs related to SMMU, so, actually,
> you meant
> "while the ID mappings from" instead of "while the RID mappings"?
Yes I meant "while the ID mappings from". sorry for the misunderstanding.

Eric
>
>
> Cheers,
> Gustavo
>
>>>
>>>>> nodes to the ITS Group nodes are described in the IORT table.
>>>>>
>>>>> This new test verifies that when the "its=off" option is passed to
>>>>> the
>>>>> machine the ITS-related data is correctly pruned from the ACPI
>>>>> tables.
>>>>>
>>>>> The new blobs for this test will be added in a following commit.
>>>>>
>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>    tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
>>>>>    tests/qtest/bios-tables-test.c              | 21
>>>>> +++++++++++++++++++++
>>>>>    2 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> b/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> index dfb8523c8b..a88198d5c2 100644
>>>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>>> I still fail to understand whether empty tables + update if the
>>>>
>>>> bios-tables-test-allowed-diff.h need to be done prior to adding the
>>>> new test.
>>>>
>>>>    * How to add or update the tests or commit changes that affect ACPI
>>>> tables:
>>>>    * Contributor:
>>>>    * 1. add empty files for new tables, if any, under tests/data/acpi
>>>>    * 2. list any changed files in
>>>> tests/qtest/bios-tables-test-allowed-diff.h
>>>>    * 3. commit the above *before* making changes that affect the
>>>> tables
>>>
>>> I think the best reference I have to it is the reply from Igor to me
>>> here:
>>>
>>> https://lore.kernel.org/qemu-devel/20250506173640.5ed03a16@imammedo.users.ipa.redhat.com/
>>>
>>>
>>>
>>> I understand there are two possibilities when adding a new test:
>>>
>>> 1) Like in the steps above, 1., 2., and 3., which are taken from the
>>> bios-tables-test.c.
>>>
>>> That gives option A:
>>>
>>> A Patch 1: New empty files uuder tests/data/acpi + list of them in
>>> tests/qtest/bios-tables-test-allowed-diff.h
>>> A Patch 2: New test (since the blobs are wrong but we added them in
>>> Patch 1 to allow list, there is no fail in test
>>> A Patch 3: Update blobs (actually you are adding the real blobs, or
>>> updating from empty to real one)
>>>
>>> or (what I'm doing here), option B:
>>>
>>> B Patch 1: (A Patch 1) + (A Patch 2)
>>> B Patch 2: Like (A Patch 3), i.e., just update the blobs (add the real
>>> ones)
>>>
>>> This is the sequence Igor confirmed it's ok:
>>>
>>>> - Patch 1     : Add the new test, add the empty blobs *.suffix files,
>>>> whitelist such a blobs
>>>> - Patch 2     : Update the blobs in Patch 1 with the ones that make
>>>> the new test pass and remove them from the whitelist
>>>
>>> Also, Igor says it's ok to add to the allow list the blobs that change
>>> at the same time
>>> we add test that changes the very same blobs even when updating an
>>> existing test (not adding a
>>> new one, which is slight variation):
>>>
>>>> - Patch 3     : Add the APIC.suffix blob to the whitelist (the table
>>>> that changes due to the fix)
>>>> - Patch 4 - n : Fix(es)
>>>
>>> "3 is not binary so it can be folded into 4 or be a separate patch
>>> (either way works for me)"
>>>   The important thingy is to follow the rules:
>>>
>>> 1) Don't make a commit which fails the tests
>>> 2) Don't fold a blob with the commit that changes the blob
>>>
>>> That's my current understanding about it.
>>>
>>> Let me know if that makes sense to you. We need to reach a consensus
>>> on this, confusing as
>>> these acrobatics may be! :)
>>
>> Actually I checked your patch and effectively it does not produce any
>> checkpatch error related to bios-tables-test rules so your patch is OK
>> (yesterday I discovered with the ACPI PCI HP series that checkpatch
>> points out infractions to bios-tables-test.c rules!). Since it results
>> in less patches I think it is better. May be worth to clarify that
>> directly in bios-tables-test.c though.
>>
>> Cheers
>>
>> Eric
>>>
>>>
>>> Cheers,
>>> Gustavo
>>>
>>>>> @@ -1 +1,3 @@
>>>>>    /* List of comma-separated changed AML files to ignore */
>>>>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
>>>>> +"tests/data/acpi/aarch64/virt/IORT.its_off",
>>>>> diff --git a/tests/qtest/bios-tables-test.c
>>>>> b/tests/qtest/bios-tables-test.c
>>>>> index 0b2bdf9d0d..4201ec1131 100644
>>>>> --- a/tests/qtest/bios-tables-test.c
>>>>> +++ b/tests/qtest/bios-tables-test.c
>>>>> @@ -2146,6 +2146,25 @@ static void
>>>>> test_acpi_aarch64_virt_tcg_topology(void)
>>>>>        free_test_data(&data);
>>>>>    }
>>>>>    +static void test_acpi_aarch64_virt_tcg_its_off(void)
>>>>> +{
>>>>> +    test_data data = {
>>>>> +        .machine = "virt",
>>>>> +        .arch = "aarch64",
>>>>> +        .variant =".its_off",
>>>> you have a checkpatch error here.
>>>
>>> ouch, thanks, will fix in v5.
>>>
>>>
>>> Cheers,
>>> Gustavo
>>>
>>>>> +        .tcg_only = true,
>>>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>>>> +        .cd =
>>>>> "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
>>>>> +        .ram_start = 0x40000000ULL,
>>>>> +        .scan_len = 128ULL * 1024 * 1024,
>>>>> +    };
>>>>> +
>>>>> +    test_acpi_one("-cpu cortex-a57 "
>>>>> +                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
>>>>> +    free_test_data(&data);
>>>>> +}
>>>>> +
>>>>>    static void test_acpi_q35_viot(void)
>>>>>    {
>>>>>        test_data data = {
>>>>> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>>>>>                               test_acpi_aarch64_virt_tcg_acpi_hmat);
>>>>>                qtest_add_func("acpi/virt/topology",
>>>>>                               test_acpi_aarch64_virt_tcg_topology);
>>>>> +            qtest_add_func("acpi/virt/its_off",
>>>>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>>>>                qtest_add_func("acpi/virt/numamem",
>>>>>                               test_acpi_aarch64_virt_tcg_numamem);
>>>>>                qtest_add_func("acpi/virt/memhp",
>>>>> test_acpi_aarch64_virt_tcg_memhp);
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>
>>
>



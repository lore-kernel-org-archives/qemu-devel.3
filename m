Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C976C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 06:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0E1o-0002QA-TD; Thu, 03 Apr 2025 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E1b-0002Mg-Bb
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:26:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0E1Y-0006sC-Vf
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 02:26:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fd89d036so6497005ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 23:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743661559; x=1744266359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvY/v9GlBbYEJQOv16O//o+YskB9tnAd+h+Ku5MXHJI=;
 b=l6GKYv9mOoH3/UsfmqHMp0svRNL/xDVOk2k7te30622yzPJcJzrFXnlXM1Oykt1Cfl
 kPpHMGhuAUu2EZpT/0xJm9pwsx12TBgCuB5J6SDikwacZQRZYYj7GE/fputv21oBQLyn
 JuKu4nDCCb9QXBBh5dm/S6ApLuStfF0UQLfZT06V7IaKuhj+TG33c+i0LdJiIf5Od5I9
 QY9Z6KnRFuSf8DJXNSn7vKzMQg5Cy93nSnSSFD6l+msjwjE9FcD7b2FqFNATUyQeO9UD
 bzypu/y40h63B7x6FTTaXBhTDcU7EKlvu7BBzUdmi3pvXVl+Kev7j6X3MW0EE/in1rJD
 1E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743661559; x=1744266359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvY/v9GlBbYEJQOv16O//o+YskB9tnAd+h+Ku5MXHJI=;
 b=G8MOQ5CtbQGx16dZjpY0Rn+0YfUzqRsAu/GXeDEvTQUZpmCbY9Vext7YjUPTzFY8ii
 Pd8m3lGEwx/SivMbhFPSK0mF2gA6mMZb9Ft3eYRjDsY1N1s4u9++Ks3Dmd8+8BFKNCu9
 zxFHO12kBcXs/OiKpEXeV/tMJ66MdrWaa9kbKZJiTwBe3vR2hanJscFHMv3KFrfY82EU
 6pT5QOdQHhaYUsBE2WBn0Odml2dMG3vMiaxq2rH+gMcov7YkXGAw2OySCkHCyxUGumhl
 /DeT2KRtS4/OOoMFQYzx/4/PHZ0IVPvazVxOpgrkXWmK4DetKnhDqR+NpJ/b6RV4U0vh
 bMGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFVkHaTkFuog8YAyNHnk0mahqQrpeKemAeUdx7VMdAaYbVHmu3bcOAsBqbEw0uHYculeP0xV/om203@nongnu.org
X-Gm-Message-State: AOJu0YyYXtzrcSMgbrqKTYSfYjnSrQ9zh13qaypMC7IG3uyalJw+t4/c
 DMY2SAPO+rJkKrX3/HpeUg3OFifVTH5oAC5LYq9LuPr2k2LVxgIcdiRprC+7MPQ=
X-Gm-Gg: ASbGncsUPWR203H1oTJy9AuWM7ISvn5KjfLLZYU99jY/bS7uz5HmwOHTOJtbEpS8MiY
 MUkpWIPt+plYNwDyfffESWsPrSTV3Ipz9RRud5vpAm47OgBZOblNeX1LN0IfWbQVcdkbU1Slufq
 4FpdKupNPiSpppYaGintmDcIlsQGHakVp3/orLSnvK6FM3wasAKrfQ+22zgu+rhU9nApxmnYfh3
 uATzw/T0AkWlCn2zLXbhFRie2vtQZfb3TKX5LyNgHapbzDaRJs+CuSCt6gKpJbnnFy4eEYYGnE7
 HrxXwx/qk8Y1GLkpfiWBUfl3q/ZuAO0y8gaB+rBogdJwwFia7h7vKob3
X-Google-Smtp-Source: AGHT+IFtlXtOko+BE5bANmHZLBb6ybVEYIMyyP9BFNQw6DDDrEJ5l2uG/W3t+zuBjyMraoBmp8NGBQ==
X-Received: by 2002:a17:902:f686:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-22977d8bd1amr19298655ad.16.1743661559151; 
 Wed, 02 Apr 2025 23:25:59 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978772816sm6525865ad.225.2025.04.02.23.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 23:25:58 -0700 (PDT)
Message-ID: <62bbeff2-f892-44d1-b190-8c4541acf16d@linaro.org>
Date: Thu, 3 Apr 2025 03:25:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M
 virt,its=off
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-2-philmd@linaro.org>
 <1d1362a0-b544-476c-a305-a7d2212db423@linaro.org>
 <d3059aa1-952b-46b9-bb96-dace60664f49@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <d3059aa1-952b-46b9-bb96-dace60664f49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Phil,

On 4/2/25 07:30, Philippe Mathieu-Daudé wrote:
> On 2/4/25 08:41, Gustavo Romero wrote:
>> Hi Phil,
>>
>> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Please, put commit message (body) into the commits.
>>
>> For example, the commit message here could quickly explain that the FACP table
>> changed because virtualization=on (due to PSCI conduit). I'm assuming
>> virtualization is set to on because gic-version=max and so GICv4 is selected for
>> testing. It also could be that  we want to exercise its=off when Arm Virtualization
>> Extensions are enabled, which is the common use case (I understand that ITS
>> can be used also with virtualization=off).
>>
>> Finally, the commit message could mention at the end which struct
>> vanishes in APIC table and why IO remapping table is affected by
>> ITS on/off.
>>
>> A good commit message always help in code spelunking :)
> 
> I simply copied the reproducer from the issue, so I'll mention that.
> (https://gitlab.com/qemu-project/qemu/-/issues/2886)
> 
>>
>>
>>> ---
>>>   tests/qtest/bios-tables-test.c            |  22 ++++++++++++++++++++++
>>>   tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 184 bytes
>>>   tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
>>>   tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 236 bytes
>>>   4 files changed, 22 insertions(+)
>>>   create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>>>   create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>>>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
>>>
>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables- test.c
>>> index 0a333ec4353..55366bf4956 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -2146,6 +2146,26 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>       free_test_data(&data);
>>>   }
>>> +static void test_acpi_aarch64_virt_tcg_its_off(void)
>>> +{
>>> +    test_data data = {
>>> +        .machine = "virt",
>>> +        .arch = "aarch64",
>>> +        .variant = ".its_off",
>>> +        .tcg_only = true,
>>> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>>> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
>>> +        .cd = "tests/data/uefi-boot-images/bios-tables- test.aarch64.iso.qcow2",
>>> +        .ram_start = 0x40000000ULL,
>>> +        .scan_len = 128ULL * 1024 * 1024,
>>> +    };
>>> +
>>> +    test_acpi_one("-cpu cortex-a57 "
>>> +                  "-M virtualization=on,secure=off "
>>> +                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
>>> +    free_test_data(&data);
>>> +}
>>> +
>>>   static void test_acpi_q35_viot(void)
>>>   {
>>>       test_data data = {
>>> @@ -2577,6 +2597,8 @@ int main(int argc, char *argv[])
>>>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>>>               qtest_add_func("acpi/virt/topology",
>>>                              test_acpi_aarch64_virt_tcg_topology);
>>> +            qtest_add_func("acpi/virt/its_off",
>>> +                           test_acpi_aarch64_virt_tcg_its_off);
>>>               qtest_add_func("acpi/virt/numamem",
>>>                              test_acpi_aarch64_virt_tcg_numamem);
>>>               qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
>>> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/ acpi/aarch64/virt/APIC.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
>>> GIT binary patch
>>> literal 184
>>> zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
>>> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/ acpi/aarch64/virt/FACP.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
>>> GIT binary patch
>>> literal 276
>>> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
>>> CVg~^L
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/ acpi/aarch64/virt/IORT.its_off
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
>>> GIT binary patch
>>> literal 236
>>> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
>>> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
>>> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>
>> I think the prescription for the acrobatics to update the ACPI expected
>> tables says the blobs here should be empty (blob files are added empty)
>> and at the same time they are listed in tests/qtest/bios-tables-test- allowed-diff.h:
>>
>>   * 1. add empty files for new tables, if any, under tests/data/acpi
>>   * 2. list any changed files in tests/qtest/bios-tables-test-allowed- diff.h
>>   * 3. commit the above *before* making changes that affect the tables
>>
>> (from tests/qtest/bios-tables-test.c header)
>>
>> If that's correct, this patch should be merged with the following one (2/5) and
>> IORT.its_off and FACP.its_off should also be listed in
>> tests/qtest/bios-tables-test-allowed-diff.h so the empty blobs won't trigger
>> a test failure.
> 
> I shouldn't have included the ACPI data in this patch but in the
> following. IIUC, if no data/$TABLE.$variant, then the generic
> data/$TABLE is used.

Yeah, it's correct that if no data/$TABLE.$variant is found then data/$TABLE is
used as a fallback. But my point actually was that in the first patch you should
create the blob .its_off variants for tables affected by the main change but
they must be empty, as per Step 1. in the prescription; and add them to the
"ignore list" (tests/qtest/bios-tables-test-allowed-diff.h) so they don't fail
the test, as per Step 2.

But on second thoughts I think Step 1. in prescription is confusing. Anyways,
what you're doing here is sensible.

Here (1/5), you're adding a new test, with new VM options. The new VM options
(different in comparison to the ¨baseline" data/$TABLE) cause changes to three
ACPI tables: APIC, FACP, and IORT, because:

- APIC: GICv2 is update to GICv4 due to gic-version=max + virtualization=on => GICv4
         and the addition of Subtable type 0xF for GIC ITS Structure (even tho its=off
         in the VM option, since that's the bug to be fixed down the road)

- FACP: Change of PSCI conduit due to virtualization=on option:
-                       Must use HVC for PSCI : 1
+                       Must use HVC for PSCI : 0 (use SMC instead)
because of logic in machvirt_init():
[...]
     } else if (vms->virt) { /* vms->virt is true is virtualization=on */
         vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
     }

- IORT: A new node is added for SMMUv3 due to option iommu=smmuv3.


I think it's correct to add the blobs for .its_off to this patch, otherwise the test will
fail and, moreover, they are the results of the options being used for the new test.
As an alternative, you could add the *.its_off to tests/qtest/bios-tables-test-allowed-diff.h
so the differences would be ignored and the test passes, but really I think it makes
more sense as you're doing here.

The next patch (2/5) becomes, as you said in the commit message, a preparation for the
real changes (the fix), which will break temporarily the test, hence in 2/5 you add it
to the "ignore list", which is actually what Step 2. in the prescription recommends.

Thus:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

>> Then patch 5/5 should add the expected/updated blobs and drop the *.its_off from
>> bios-tables-test-allowed-diff.h. Patches 3/5 and 4/5 are sandwiched
>> between (1/5 + 2/5) and (5/5).
>>
>> At least that's what I get from:
>>
>>   * The resulting patchset/pull request then looks like this:
>>   * - patch 1: list changed files in tests/qtest/bios-tables-test- allowed-diff.h.
>>   * - patches 2 - n: real changes, may contain multiple patches.
>>   * - patch n + 1: update golden master binaries and empty tests/qtest/ bios-tables-test-allowed-diff.h
>>
>> Otherwise the change looks good.
>>
>>
>> Cheers,
>> Gustavo
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F68AC678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLIW-0007U4-2B; Wed, 11 Jun 2025 09:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uPLIR-0007Q6-C1
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:15:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uPLIM-0006W9-JZ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:15:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23649faf69fso1256435ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749647707; x=1750252507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VqIGEOcDV2NrDDIyGDNi4yC42x12EluOFJPa5dLjvUw=;
 b=wdf0rCZ2sE/3HSz8fdAXYM7W+THFVAI7VOZ8WL7lcqeIPGkBk77W1dzEZJdn6Hy6u9
 w7BEL9c1yDttUtV4+pOTgRAj2yfD7xz574GUkfL/nJPzsBlo1zopSXis7o04zdiiz9PR
 IypZ8v6wLW3rIzuleu3sjKdOW1hwaj+8fZTQ2OgnkyySedttoqNm9a8npi93yY3T26ft
 xk4V68V8sGm2VNV4FLdBcNwMMz/8cFTNCMRItFPkDEdOfHtPEaOHA3+DFO+i19CHLUZ+
 PrMC9/FGqMmWEM4V/X14aOK3WgDg2mMv5XVi2JObAEH5V6kUKeJHFNn/obPS6D1McrZN
 Q/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749647707; x=1750252507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqIGEOcDV2NrDDIyGDNi4yC42x12EluOFJPa5dLjvUw=;
 b=uMSggYYbx0it2FP3Inp0hg/pvMPouI590GcDLd45IFjJIXFeFJbAuSI30JWXjAPTDh
 tk6r/o+ZyHjg8d2mhTkRHMCT5RriRVQ95BBgP8H/k4udPhf6eCdx19S1p8MRToMrxkSs
 IQWJ4SDNGOHZuO8KUArXCYKLt3t2QLosnT9XeIQg165eAEaBLvN84vRFcgny8JiSnHfm
 FU7vrmRqbFQY+ZsNrcza5kNiHgTuaErZqza3I8Lf6vm08mCQMlttBdH56SuQzhhwNveO
 8ZoE5nZ3D84Oe9HvERJmGG7Ire0w1GUlBqEVZhq6n5LlHZJg9Z6q1q9fUfcMxuO0GU2l
 TC9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRBm90wXVn/SM3GqlSKFtp1+ZjoVTNEQUS1TVeLROP6nVVWid14T/UxnHVFqc5sHSABjCIpbVXMdRL@nongnu.org
X-Gm-Message-State: AOJu0YzOm7GspC4/nfjwbY//PrWlz9KI4j8HXjnjTdOtX7khDyW5aI4Z
 Bp4KNh6ZnTlvPHm6B7s+vMkRQFyH/Z+cqqxXxpmOHIDUf6+/xyFMkiykpMYTgpsuxIY=
X-Gm-Gg: ASbGncvmp3q73nQGJgtISiFfeVPr2jkSEZEZPpKQ9kjNSs0XWBcOhwBW7TvL+Le0t44
 +cBXjEgziFJ+h71+C9h6ONzyA9wnbZaBS5cfzsJRAQfWrUNUdYC8OeIsroLca/RhOIn4/QVEOJ+
 tXOe7sLuHYqTJU7O+EtbOlYWF9NuRtknIGZkwRdnUbU7PV36CiYc3HB1SN4vWos/vHMOsRqIq4H
 c8E44bjnlRjKwSkMGpli0lHkhVj4ip+KQ84qn1//2p9RQ6g4Yom7sQGXVv6B8zs1x86xJyFClmG
 FwU/UhhE/YFIPtlhxGOCs7upkXeMB2UxFBEWOX3Smin+pD9Dd73I/jsQVfaWpqWr0Ko507djF6N
 oP6jzVjmV+dZi41eapBPA7J8g6C4rjqc3ThSafnU/mNP1Bw==
X-Google-Smtp-Source: AGHT+IEbyrepJ4ZWPpnVOLunUAT2Aytke5b/7mZTcD2XaPyeb9MvZL7PS6mRI5LoLBd6/7lnsbg0DA==
X-Received: by 2002:a17:90b:2245:b0:311:b0ec:134b with SMTP id
 98e67ed59e1d1-313af266ac9mr3770974a91.32.1749647707084; 
 Wed, 11 Jun 2025 06:15:07 -0700 (PDT)
Received: from [192.168.0.102] (200-162-224-156.static-corp.ajato.com.br.
 [200.162.224.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236034056f8sm87134895ad.161.2025.06.11.06.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 06:15:06 -0700 (PDT)
Message-ID: <848ad5cf-7e83-49bd-8547-ac757c918fdf@linaro.org>
Date: Wed, 11 Jun 2025 10:14:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
 <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
 <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
 <20250530135103.09030cf0@imammedo.users.ipa.redhat.com>
 <bcc200fb-fa45-44ac-9e36-4c829becbf1c@linaro.org>
 <e3bc87d8-5016-455e-933d-6cefae993c25@linaro.org>
 <20250611105437.5ecda7c9@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250611105437.5ecda7c9@imammedo.users.ipa.redhat.com>
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

Hi Igor,

On 6/11/25 05:54, Igor Mammedov wrote:
> On Tue, 10 Jun 2025 11:29:02 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Hi Igor,
>>
>> On 6/2/25 03:06, Gustavo Romero wrote:
>>> Hi Igor and Eric,
>>>
>>> I'm sending again this to the mailing list since it seems the first one
>>> got lost... I can't find it either in qemu-devel@ or in qemu-arm@ :(
>>>
>>> On 5/30/25 08:51, Igor Mammedov wrote:
>>>> On Wed, 28 May 2025 12:04:26 -0300
>>>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>>   
>>>>> Hi Igor,
>>>>>
>>>>> On 5/28/25 10:02, Igor Mammedov wrote:
>>>>>> On Wed, 28 May 2025 09:41:15 -0300
>>>>>> Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>>>>>> Hi Igor,
>>>>>>>
>>>>>>> On 5/28/25 06:38, Igor Mammedov wrote:
>>>>>>>> On Tue, 27 May 2025 09:40:26 +0200
>>>>>>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>>>>>>> From: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>>>>
>>>>>>>>> ACPI PCI hotplug is now turned on by default so we need to change the
>>>>>>>>> existing tests to keep it off. However, even setting the ACPI PCI
>>>>>>>>> hotplug off in the existing tests, there will be changes in the ACPI
>>>>>>>>> tables because the _OSC method was modified, hence in the next patch of
>>>>>>>>> this series the blobs are updated accordingly.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>
>>>>>>>> it would be better to test whatever default we end up with.
>>>>>>>> (like x86)
>>>>>>>
>>>>>>> hmm maybe there is a confusion here, Igor. We are actually planning what you
>>>>>>
>>>>>> perhaps, see my reply to Eric about my expectations wrt tests.
>>>>>
>>>>> Yip, I read it before my reply here.
>>>>>
>>>>>   
>>>>>> (i.e. default tests shouldn't have any explicit CLI options,
>>>>>> instead it should follow whitelist blobs/set new default patch/update blobs pattern)
>>>>>
>>>>> I see. I agree with that. But this patch is not about the new test. The new test is
>>>>> _not_ in this series. Patches 8/25, 10/25, and 24/25 are _not_ about the new test but
>>>>> about adapting the _legacy tests_ (native acpi) to the situation when ACPI HP becomes
>>>>> the default, because this series makes acpi-pcihp=on the default, hence the CLI option
>>>>> "acpi-pcihp=off" added to them. An update to the blobs are also necessary because of the
>>>>> change in _OSC method, even when acpi-pcihp=off.
>>>>>
>>>>>   
>>>>>>> said. This patch and the other two in this series related to the bios-tables-test
>>>>>>> (i.e., patches 8/25 and 10/25) are for actually making the current (legacy) test pass,
>>>>>>> since the new default as per this series will be acpi-pcihp=on. That's why here we're
>>>>>>> adapting the current test here to have acpi-pcihp=off.
>>>>>>>
>>>>>>> The new test that will test for acpi-pcihp=on (the new default) is not in this series
>>>>>>> and we decided to merge it separate. It's in the patch 4/5 and 5/5 of the follow series:
>>>>>
>>>>> We're doing the "blobs/set new default patch/update blobs pattern" in the new test, which
>>>>> we can merge later, once this series is merged, no? The step "set new default" then will
>>>>> not be necessary because the new test will be merged separate, after this series, so when
>>>>> acpi-pcihp=on is already the default.
>>>>>
>>>>> Please note that although we're using acpi-pcihp=on in the new test, it's not necessary,
>>>>> we can dropped this option, making it implicit as you say, and it will work. This is the
>>>>> new test:
>>>>>   
>>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
>>>>>
>>>>>
>>>>> Thus, there are to "acts" of modifying the bios-tables-test:
>>>>>
>>>>> 1) Adapt the current tests to when acpi-pcihp=on becomes the default (hence the addition
>>>>>       to them of "acpi-pcihp=off".
>>>>
>>>>
>>>> that's what I disagree with.
>>>>
>>>> 1) Instead adapting majority of tests to legacy before switching defaults,
>>>> just do whitelist/modify default/update so all of tests run with new default.
>>>>
>>>> and then
>>>>   
>>>>> There is also the need to update the blobs, but it's because
>>>>>       of the _OSC method change in DSDT table, which will change anyways, even with "acpi-pcihp=off¨,
>>>>>       hence the need for patch 10/25 in this series. This is _done is this series_.
>>>>
>>>>   
>>>>> 2) Add a new test for testing the default (i.e. acpi-pcihp-on). It follows what you're
>>>>>       saying above: "follow whitelist blobs/set new default patch/update blobs pattern",
>>>>>       because we can drop the acpi-pcihp-on option from the CLI in this test without any
>>>>>       prejudice to test. While the step "set new default patch" was actually done in 1).
>>>>
>>>> 2) add a separate test case for native pcie hoplug (preferably within this series)
>>>>
>>>> 3) even better would be to add #2 before #1 (right after 10/25),
>>>> this way will guarantee that old native hotplug tables stay
>>>> the same regardless of followup patches that add ACPI pcihp aml.
>>>
>>> Got it now, hopefully... 🙂
>>>
>>> OK, I'm trying to follow what you recommended in 3). I've pushed a series to:
>>>
>>> https://github.com/gromero/qemu/commits/v2_20250527_eric_auger_redhat_com/
>>>
>>> So, I understand we will need to add/update the blobs at three times,
>>> 2 times because of the changes in the DSDT generation (_OSC changes and when
>>> acpi-pci=on) and an additional one because of the new PCIe native hotplug test.
>>>
>>> I dropped this patch (Patch 24/25) from the series.
>>>
>>> So the overview of the organization would be the following:
>>>
>>>
>>> 3c302f7222 tests/qtest/bios-tables-test: Update DSDT blobs                                   #1c (update blob)    \
>>> 671f15f470 hw/arm/virt: Use ACPI PCI hotplug by default                                      #1b (modify default) |--- acpi-pcihp=on
>>> 9468f730e1 tests/qtest/bios-tables-test: Prepare for changes in the DSDT table               #1a (whitelist)      /
>>> c9ec0e0226 hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
>>> dc44749a34 hw/arm/virt: Let virt support pci hotplug/unplug GED event
>>> f667079260 hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>>> 46731e563b hw/acpi/ged: Support migration of AcpiPciHpState
>>> 4fa7b0e0f6 hw/acpi/ged: Call pcihp plug callbacks in hotplug handler implementation
>>> 587b001876 hw/acpi/ged: Prepare the device to react to PCI hotplug events
>>> b55183d128 hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI hotplug
>>> fe4c96b384 hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>>> 010c50dbc7 hw/i386/acpi-build: Introduce and use acpi_get_pci_host
>>> 5a1be727e6 hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to pcihp
>>> 14a172e192 hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>>> 5110ae8874 hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>>> 82c2aef672 hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>>> 6372fe7eef qtest/bios-tables-test: Update DSDT 'noacpipcihp' variant blob                    #2 (blob update for test), part 2 of 2 (update blob)  ]--- New PCIe native test
>>> 6fb29ba18d tests/qtest/bios-tables-test: Add aarch64 PCIe native hotplug test                #2 (pcie native hp test), part 1 of 2 (whitelist)     /
>>> 12c63a505e tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _OSC change            Patch 10/25 in this series (update blob)    \
>>> 779bd47749 hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method                       Patch  9/25 in this series (modify default) |--- _OSC change
>>> f260fd59c1 tests/qtest/bios-tables-test: Prepare for changes in the DSDT table               Patch  8/25 in this series (whitelist)      /
>>> b000677fd9 hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>>> a72f87b634 hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine downto gpex
>>> 77a87b6ba3 hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>>> 67e4dc2e7b hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to acpi_dsdt_add_pci_osc
>>> b89e69da54 hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>>> 74f1080a74 hw/arm/virt: Introduce machine state acpi pcihp flags and props
>>> 1048082f33 hw/i386/acpi-build: Make aml_pci_device_dsm() static
>>>
>>> See notes on the right for when the blobs are updated or added in the
>>> series. The new test for PCIe native hotplug (I prefer not calling it legacy,
>>> since it's not really legacy; it's just an alternative better in some scenarios,
>>> specially in virtualization) is now in the series (#2), "right after 10/25".
>>>
>>> Is something like that that you want?
>>
>> Igor, just a friendly ping on it. It would be quite helpful for us if you could
>> confirm I'm following what you recommended regarding the tests for this series.
> 
> spirit of above looks fine,

Thanks for confirming it.


> as for actual patches, it would depend on chosen default.
> Lets' see what submitted v3 would look like.

Agreed. Yep, I can adapt the tests the other way, depending on
the final chosen default. Let's way v3 ;)


BTW, why did we ultimately choose to commit blobs instead of the actual ACPI
code (as generated by iasl)? I'm just wondering if we could avoid committing
the blobs to 1) avoid committing binaries and 2) have the changes in the
ACPI code in the same commit that changes the ACPI itself.

If that's only for historical reasons maybe I can improve the bios-tables-test.c
to handle the ACPI code/struct in text format, avoiding the blobs, so I ask.

Thanks!


Cheers,
Gustavo

>>
>>
>> Thanks,
>> Gustavo
>>    
>>>
>>> Cheers,
>>> Gustavo
>>>    
>>>>   
>>>>> Cheers,
>>>>> Gustavo
>>>>>   
>>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
>>>>>>> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
>>>>>>>
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Gustavo
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
>>>>>>>>> ---
>>>>>>>>>      tests/qtest/bios-tables-test.c | 13 +++++++++----
>>>>>>>>>      1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>>>>>>>>> index 0a333ec435..6379dba714 100644
>>>>>>>>> --- a/tests/qtest/bios-tables-test.c
>>>>>>>>> +++ b/tests/qtest/bios-tables-test.c
>>>>>>>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>>>>>>>>>          };
>>>>>>>>>          data.variant = ".memhp";
>>>>>>>>> -    test_acpi_one(" -machine nvdimm=on"
>>>>>>>>> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>>>>>>>>>                        " -cpu cortex-a57"
>>>>>>>>>                        " -m 256M,slots=3,maxmem=1G"
>>>>>>>>>                        " -object memory-backend-ram,id=ram0,size=128M"
>>>>>>>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>>>>>>>>>          };
>>>>>>>>>          data.variant = ".numamem";
>>>>>>>>> -    test_acpi_one(" -cpu cortex-a57"
>>>>>>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>>>>>>> +                  " -cpu cortex-a57"
>>>>>>>>>                        " -object memory-backend-ram,id=ram0,size=128M"
>>>>>>>>>                        " -numa node,memdev=ram0",
>>>>>>>>>                        &data);
>>>>>>>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>>>>>>>>>           * to solve the conflicts.
>>>>>>>>>           */
>>>>>>>>>          data.variant = ".pxb";
>>>>>>>>> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
>>>>>>>>> +    test_acpi_one(" -machine acpi-pcihp=off"
>>>>>>>>> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>>>>>>>>>                        " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>>>>>>>>>                        " -drive file="
>>>>>>>>>                        "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
>>>>>>>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>>>>>>>>>          data.variant = ".acpihmatvirt";
>>>>>>>>> -    test_acpi_one(" -machine hmat=on"
>>>>>>>>> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>>>>>>>>>                        " -cpu cortex-a57"
>>>>>>>>>                        " -smp 4,sockets=2"
>>>>>>>>>                        " -m 384M"
>>>>>>>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>>>>>>>>>          data.smbios_cpu_max_speed = 2900;
>>>>>>>>>          data.smbios_cpu_curr_speed = 2700;
>>>>>>>>>          test_acpi_one("-cpu cortex-a57 "
>>>>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>>>>                        "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>>>>>>>>>          free_test_data(&data);
>>>>>>>>>      }
>>>>>>>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>>>>>>>>>          };
>>>>>>>>>          test_acpi_one("-cpu cortex-a57 "
>>>>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>>>>                        "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>>>>>>>>>          free_test_data(&data);
>>>>>>>>>      }
>>>>>>>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>>>>>>>>>          };
>>>>>>>>>          test_acpi_one("-cpu cortex-a57 "
>>>>>>>>> +                  "-machine acpi-pcihp=off "
>>>>>>>>>                        "-device virtio-iommu-pci", &data);
>>>>>>>>>          free_test_data(&data);
>>>>>>>>>      }
>>>>>   
>>>>   
>>>    
>>
> 



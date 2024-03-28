Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E09C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprqX-00021t-0F; Thu, 28 Mar 2024 11:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rprqV-00021R-8C
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rprqT-00071l-CL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711640352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Ir1QOcLha7reu+tFxxQv+hqjR0k2uICWZBFX5k/QE4=;
 b=E8w774st/ErHZtJCJtqONG9We5i1zhywLLKuBLsR3jU3I4Tq15Zylo31iR9qYJydSNTjbR
 fot0o5d9FX4cBMHKGJh4++F3/6SPH526XIkATkJ42bnRRWQCIP0rkeO8BGfMcsWixSGgbq
 aNiDaPjug6/FMMqFi04Qlz7RvSD8CaM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-y2RlK78lNceFaLAs8G3Bbg-1; Thu, 28 Mar 2024 11:39:09 -0400
X-MC-Unique: y2RlK78lNceFaLAs8G3Bbg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-414908c5403so5357455e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711640349; x=1712245149;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Ir1QOcLha7reu+tFxxQv+hqjR0k2uICWZBFX5k/QE4=;
 b=E7Z6kI7xVxGmeEuVp/bWs31OzSmA5KcFZjAJLN2iCBiSbsaGSYBD5HWmY0HOnsN1f5
 U/NhYYGhC6H24A2pWZw9LXYtzuJc/V3yCrRMCUinnKqaoR5xCm0WVzwXTayuoj6SOOEF
 31M/Ht3i5eratNxuteATs4Ols04NRL0Po9rQUFSS5rsziKOjfjjwuDQL2Iorh5jdmtJ/
 aikALyym3OCVXnkg3QdLVTzg6kJ6Ax+qCqf0pc4N0E1voI/1bzTOha6YLsNu8fcWByo/
 Aoa6+Vhtge+czuv/b+501CkN71SBaiPYb28gE1fE6GUyMnLFNrpzVI7qZGDTmKJISRY7
 oPdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm48FL831FfoG6IA5op8dZeM600VIL4Gz+43wfE0esJLw5QuGT/dLewhlDSXlYx2EPir/6HYKiJnPhzKaOs6nd4LxWVlw=
X-Gm-Message-State: AOJu0YybqfCv/49imu+UJjHTvQ817tOMHBQtc4uRCECCTgHzTb7IwWUU
 wk+AEKyopuMiBjzkQhDaYrGcjW5QIRKYn8rUfwvi/UfWewJOwaYCc52jorFBgJatcP7HdbCnx2/
 A4i3VIPrPsEJetvJGKn0euGj7oed309mHJ5AlJAS9Y9iyZyJOVzag
X-Received: by 2002:a05:600c:3505:b0:413:3160:840f with SMTP id
 h5-20020a05600c350500b004133160840fmr2687928wmq.0.1711640348911; 
 Thu, 28 Mar 2024 08:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEauUnFs30nU5FTwPhNc3Y/JNTt4Veie8oG0595D5YPZS2WD5ySEoqVicJUBsVqR5SYxJNn1g==
X-Received: by 2002:a05:600c:3505:b0:413:3160:840f with SMTP id
 h5-20020a05600c350500b004133160840fmr2687910wmq.0.1711640348410; 
 Thu, 28 Mar 2024 08:39:08 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-37.web.vodafone.de.
 [109.43.177.37]) by smtp.gmail.com with ESMTPSA id
 f10-20020a05600c154a00b004154596db0esm2147488wmg.19.2024.03.28.08.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 08:39:08 -0700 (PDT)
Message-ID: <179a8cbf-b645-4027-ad53-13c4beb4f099@redhat.com>
Date: Thu, 28 Mar 2024 16:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
 <70006b4e-b2ae-4d74-be22-4dabf46e0217@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <70006b4e-b2ae-4d74-be22-4dabf46e0217@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/03/2024 16.12, Mark Cave-Ayland wrote:
> On 27/03/2024 16:54, Philippe Mathieu-Daudé wrote:
> 
>> Per Daniel suggestion [*]:
>>
>>   > isapc could arguably be restricted to just 32-bit CPU models,
>>   > because we should not need it to support any feature that didn't
>>   > exist prior to circa 1995. eg refuse to start with isapc, if 'lm'
>>   > is present in the CPU model for example.
>>
>> Display a warning when such CPU is used:
>>
>>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu Westmere
>>    qemu-system-x86_64: warning: Use of 64-bit CPU 'Westmere' is deprecated 
>> on the ISA-only PC machine
>>    QEMU 8.2.91 monitor - type 'help' for more information
>>    (qemu) q
>>
>>    $ qemu-system-x86_64 -monitor stdio -S -M isapc -cpu athlon
>>    QEMU 8.2.91 monitor - type 'help' for more information
>>    (qemu) q
>>
>> [*] https://lore.kernel.org/qemu-devel/ZgQkS4RPmSt5Xa08@redhat.com/
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/deprecated.rst |  7 +++++++
>>   include/hw/i386/pc.h      |  1 +
>>   hw/i386/pc_piix.c         | 14 ++++++++++++++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 7b548519b5..345c35507f 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder 
>> to run the
>>   ``check-tcg`` tests. Unless we can improve the testing situation there
>>   is a chance the code will bitrot without anyone noticing.
>> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The ``isapc`` machine aims to emulate old PC machine without PCI was
>> +generalized, so hardware available around 1995, before 64-bit intel
>> +CPUs were produced.
>> +
>>   System emulator machines
>>   ------------------------
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 27a68071d7..2d202b9549 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -96,6 +96,7 @@ struct PCMachineClass {
>>       const char *default_south_bridge;
>>       /* Compat options: */
>> +    bool deprecate_64bit_cpu; /* Specific to the 'isapc' machine */
>>       /* Default CPU model version.  See x86_cpu_set_default_version(). */
>>       int default_cpu_version;
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 18ba076609..2e5b2efc33 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -182,7 +182,20 @@ static void pc_init1(MachineState *machine, const 
>> char *pci_type)
>>       }
>>       pc_machine_init_sgx_epc(pcms);
>> +
>>       x86_cpus_init(x86ms, pcmc->default_cpu_version);
>> +    if (pcmc->deprecate_64bit_cpu) {
>> +        X86CPU *cpu = X86_CPU(first_cpu);
>> +
>> +        if (cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
>> +            const char *cpu_type = object_get_typename(OBJECT(first_cpu));
>> +            int cpu_len = strlen(cpu_type) - strlen(X86_CPU_TYPE_SUFFIX);
>> +
>> +            warn_report("Use of 64-bit CPU '%.*s' is deprecated"
>> +                        " on the ISA-only PC machine",
>> +                        cpu_len, cpu_type);
>> +        }
>> +    }
>>       if (kvm_enabled()) {
>>           kvmclock_create(pcmc->kvmclock_create_always);
>> @@ -918,6 +931,7 @@ static void isapc_machine_options(MachineClass *m)
>>       pcmc->gigabyte_align = false;
>>       pcmc->smbios_legacy_mode = true;
>>       pcmc->has_reserved_memory = false;
>> +    pcmc->deprecate_64bit_cpu = true;
>>       m->default_nic = "ne2k_isa";
>>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> 
> The logic around checking CPUID_EXT2_LM looks good to me. Slightly curious 
> as to whether people feel updating PCMachineClass is necessary, or you can 
> simply do qdev_get_machine() and use object_dynamic_cast() to see if the 
> machine matches MACHINE_NAME("isapc") and warn that way?

Why don't you simply pass it as a parameter from pc_init_isa() instead? Or 
do the whole check in pc_init_isa() instead?

  Thomas



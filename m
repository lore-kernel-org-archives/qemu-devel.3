Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926A7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyCM-0004Wh-NS; Tue, 26 May 2026 16:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyCK-0004VR-BF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:16:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyCF-0000LE-Tn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:16:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so116313845e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779826574; x=1780431374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnaBl+1FHukFJ/irwy1iz0ljC0kbXilaPOYc+58MGqA=;
 b=MnQWhTi8fcFOgRoI4niIcCOH8k77RyzWcovUo8bzK31532hWCZh4OYgTMc4v7mNX4T
 v/4ZHnO6bTsjLaihoOoTCyQ7eiBmIPk38Qhhy2MHn3nLfWzLTZ9UYfX7zBFsIWv9nHjY
 CivMOc+FbasSvGMG9NGZtGCrq/mrk3NfWyqC3sgpUvbyTFyZS3ZMSti1eFoLgggx648L
 yx82twKogEz47+w2Jtcl2dXozAH+cb467OxXQ1MQ6UDvxvfxU80UGhjMUq9wXh6RltzW
 NytBL6Rv9d8yU310OuGRmhDIINnIucQYZmxBMaig4RtWnm439o56SuG7eio3bSl4/liD
 pQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826574; x=1780431374;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnaBl+1FHukFJ/irwy1iz0ljC0kbXilaPOYc+58MGqA=;
 b=nWmfYOpyGolfCV1vFzy7NIwuDLkiscSMJz2Q118hHPOnNn1saQecFiamsNWE9/YNiG
 XEDY6ix0gY5Zj1hy8GufAyPw195WEj0p+nXvuEKv+uXkCLL/bWPDHnRL4BnPEGJpOIS8
 qZf+ViwGS5N7zUuL1A7DgRfuhStwutdscPbsV9WgB60Sm/yP7S97nRyIUKPKZIID7Akp
 6eBlsos2fcALUClzOErjxFC16spHaHUdAWHpKoirPL8SPl35H5zpl4hkizlWbIh7qRz+
 w3ztNmnhbuDSe9E78eb4acE0g/ZTXyhYCxXLNiZgUOU3ggyxlxKo/bIwaiUkSCYuFbKI
 KtkQ==
X-Gm-Message-State: AOJu0YyuRYy9q9QvoyoeMMT5Gt7NOy70s5IlatxXOCU2ZnGKBYXqTLWl
 OorspaC8D5qeKxNfBaXvPFJW8jj+r8Cd8CjvvCSwDwgLBGSh4hlQwyVYuhWNsAzOO8AarAJRaQv
 8RXXwdeof/A==
X-Gm-Gg: Acq92OGKC+BBm3qwcqt4OnHNL/E+/WRECSfXoweled4ksvGlbJSEIc/GDy85lwF/DxF
 Eka/YRuSrEWiDLBPm8BvQPs/5mVQCd9/B0DwfLwHTvTWWe6Edw37BQmQ3TogsfXGP81A85KC5Ev
 onNvyZwZGvHEarqHh7WkB3RlZszdUBVl0eaMFKLV9uqjhKSO0kX/G51aKVbf6VAnAVH23UBiU2D
 RI5NQLjFogAYbsA31l/31K2KteM50skUpHEolzZQeuSKIrGyRqVnrM65h6s0q3LFH3oafS/Yw5+
 kfcD4pycGCPdv/mQm4ILLAJZbUEKvaygArAXmaTLiIXn2dRrqK7WratceFoAw3Rpv0OsXLyw4ZN
 730rrZN5ulG46Ggd/QDxWSdcE+LH/kr406gH4Pw8BwGYsz5lfNM815E+r6wY6Z2jILH0saki5uw
 a5ln0EjXqJMhVs07LnXitd5EPsLJTtTZeO7KrDGVY7LJxeT7VLF2KgWy180C9jLDGAFA==
X-Received: by 2002:a05:600c:46c6:b0:490:46df:a87a with SMTP id
 5b1f17b1804b1-49046dfa9c1mr351794795e9.1.1779826573876; 
 Tue, 26 May 2026 13:16:13 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490456274ebsm332587475e9.15.2026.05.26.13.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 13:16:13 -0700 (PDT)
Message-ID: <ae5c24c8-fa04-4368-8baf-9d56762c64cd@linaro.org>
Date: Tue, 26 May 2026 22:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mohammadfaiz Bawa <mbawa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260526164716.689664-1-mbawa@redhat.com>
 <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
 <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
 <aa810589-f2ab-43ac-a3a9-7717d06df92d@linaro.org>
In-Reply-To: <aa810589-f2ab-43ac-a3a9-7717d06df92d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+Paolo/Peter

On 26/5/26 21:45, Philippe Mathieu-Daudé wrote:
> +Richard/Pierrick
> 
> On 26/5/26 20:07, Mohammadfaiz Bawa wrote:
>> On Tue, May 26, 2026 at 11:13 PM Peter Maydell 
>> <peter.maydell@linaro.org> wrote:
>>>
>>> On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com> 
>>> wrote:
>>>>
>>>> memory_region_init_ram_device_ptr() requires the target page
>>>> size to be finalized, which has not happened during
>>>> instance_init. Calling it from tpm_tis_sysbus_initfn() causes
>>>> an assertion failure when the device is introspected without
>>>> being realized, for example:
>>>>
>>>>    $ qemu-system-aarch64 -device tpm-tis-device,help
>>>>    qemu-system-aarch64: ../system/physmem.c:2524:
>>>>    qemu_ram_alloc_internal:
>>>>    Assertion 'target_page.decided' failed.
>>>>    Aborted (core dumped)

I can not reproduce this error, however en macOS this command triggers:

(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = hit program 
assert
     frame #0: 0x000000019c642388 libsystem_kernel.dylib`__pthread_kill + 8
     frame #1: 0x000000019c67b848 libsystem_pthread.dylib`pthread_kill + 296
     frame #2: 0x000000019c584b50 libsystem_c.dylib`abort + 124
     frame #3: 0x000000019c583d84 libsystem_c.dylib`__assert_rtn + 284
   * frame #4: 0x0000000100a3870c 
qemu-system-aarch64`qemu_mutex_lock_impl.cold.1 at qemu-thread-posix.c:107:5
     frame #5: 0x0000000100981e78 
qemu-system-aarch64`qemu_mutex_lock_impl(mutex=<unavailable>, 
file=<unavailable>, line=<unavailable>) at qemu-thread-posix.c:107:5
     frame #6: 0x0000000100345d08 
qemu-system-aarch64`qemu_mutex_lock_ramlist at physmem.c:1454:5
     frame #7: 0x0000000100345ce4 
qemu-system-aarch64`ram_block_add(new_block=0x0000000133104f10, 
errp=0x000000016fdfe650) at physmem.c:2161:5
     frame #8: 0x0000000100346c34 
qemu-system-aarch64`qemu_ram_alloc_internal(size=16384, max_size=16384, 
resized=0x0000000000000000, host=0x000000013380c000, ram_flags=1, 
mr=0x000000013380a910, errp=0x0000000101c37c20) at physmem.c:2540:5
     frame #9: 0x00000001003469c8 
qemu-system-aarch64`qemu_ram_alloc_from_ptr(size=<unavailable>, 
host=<unavailable>, mr=<unavailable>, errp=<unavailable>) at 
physmem.c:2552:12 [artificial]
     frame #10: 0x000000010033b56c 
qemu-system-aarch64`memory_region_set_ram_ptr(mr=0x000000013380a910, 
size=1024, ptr=0x000000013380c000) at memory.c:1664:20 [inlined]
     frame #11: 0x000000010033b550 
qemu-system-aarch64`memory_region_init_ram_device_ptr(mr=0x000000013380a910, 
owner=<unavailable>, name=<unavailable>, size=1024, 
ptr=0x000000013380c000) at memory.c:1684:5
     frame #12: 0x00000001002ca594 
qemu-system-aarch64`tpm_tis_sysbus_initfn(obj=0x0000000133809400) at 
tpm_tis_sysbus.c:114:5
     frame #13: 0x00000001007e8e58 
qemu-system-aarch64`object_initialize_with_type(obj=0x0000000133809400, 
size=5680, type=0x0000000131f4e250) at object.c:504:5
     frame #14: 0x00000001007e964c 
qemu-system-aarch64`object_new_with_type(type=0x0000000131f4e250) at 
object.c:707:5
     frame #15: 0x00000001007e95fc 
qemu-system-aarch64`object_new_with_class(klass=<unavailable>) at 
object.c:716:12 [artificial]
     frame #16: 0x00000001008ca264 
qemu-system-aarch64`qmp_device_list_properties(typename="tpm-tis-device", 
errp=0x000000016fdfe8a0) at qom-qmp-cmds.c:206:11
     frame #17: 0x000000010034c7a0 
qemu-system-aarch64`qdev_device_help(opts=<unavailable>) at 
qdev-monitor.c:315:17
     frame #18: 0x000000010033179c 
qemu-system-aarch64`device_help_func(opaque=<unavailable>, 
opts=<unavailable>, errp=<unavailable>) at vl.c:1209:12 [artificial]
     frame #19: 0x000000010098aa10 
qemu-system-aarch64`qemu_opts_foreach(list=<unavailable>, 
func=(qemu-system-aarch64`device_help_func at vl.c:1208), 
opaque=0x0000000000000000, errp=0x0000000000000000) at qemu-option.c:1148:14
     frame #20: 0x000000010032d45c 
qemu-system-aarch64`qemu_process_help_options at vl.c:2642:9 [inlined]
     frame #21: 0x000000010032d408 
qemu-system-aarch64`qemu_init(argc=<unavailable>, 
argv=0x000000016fdff148) at vl.c:3738:5
     frame #22: 0x00000001008dcef8 
qemu-system-aarch64`main(argc=<unavailable>, argv=<unavailable>) at 
main.c:71:5
     frame #23: 0x000000019c2dab98 dyld`start + 6076

>>>>
>>>> Property introspection only calls instance_init, never
>>>> realizefn, so moving the memory region setup to realizefn
>>>> avoids the crash while keeping the device fully functional
>>>> when actually used in a VM.
>>>>
>>>> Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
>>>> and the corresponding sysbus_init_mmio() from
>>>> tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
>>>> them just before the existing vmstate_register_ram() call.
>>>>
>>>> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>>>> ---
>>>>   hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
>>>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>>>> index 6bec30c36f..33fe9e332c 100644
>>>> --- a/hw/tpm/tpm_tis_sysbus.c
>>>> +++ b/hw/tpm/tpm_tis_sysbus.c
>>>> @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>>>>   {
>>>>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>>>>       TPMState *s = &sbdev->state;
>>>> -    size_t host_page_size = qemu_real_host_page_size();
>>>
>>> This is asking about the host page size, so why does it wind up
>>> asserting about the target page size not being fixed ?
>>>
>>> thanks
>>> -- PMM
>>
>> The host_page_size line itself doesn't cause the crash -
>> qemu_real_host_page_size() is safe to call anywhere. It was
>> moved simply because it has no other consumers in initfn.
>>
>> The actual crash comes from memory_region_init_ram_device_ptr()
>> - which calls qemu_ram_alloc_internal(). In there, line 2522
>> evaluates TARGET_PAGE_SIZE: align = MAX(align, TARGET_PAGE_SIZE);
>>
>> With CONFIG_DEBUG_TCG, TARGET_PAGE_SIZE expands through
>> TARGET_PAGE_MASK which contains: assert(target_page.decided)
>>
>> That's where it blows up: the target page size hasn't been
>> finalized yet during instance_init.
>>
>> Thanks
>> -- Faiz
>>
>>
> 



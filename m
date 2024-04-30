Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10422C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kGW-0006ne-FX; Tue, 30 Apr 2024 05:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1kGU-0006mN-Ex
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:10 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1kGR-0000TG-9F
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-571be483ccaso6643921a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714471142; x=1715075942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJyajIO89AU+Rdmyk5sghcpIGatrdmXc8IUGjk8KgWE=;
 b=grlHntP3GDeJiltS5dbghLjkQ7UQ5Yl++Tf5gniavEcrNFWqKSkIoU7h/uN82atujT
 76Vhwv4p9Oz+f258TGC1jpMK4R2x8JicoMIovUbcdJMlHl+yODF6jBB+s3KkmAyMuS6L
 GPZ4Zna2RQWvpUYAlx3hJwNImiFANzxMiOusjN/O4fGDanJpMT3qO/kADTdcbWk3hSbl
 uzZmGR/rTHQUuefGKP49iWQ05JThlNSTQ910xleJyZoGuowChlbdfIkwOGHo15VX9mgX
 rK4nJ7ATNqUtdR4n8obhVjQRf4gKk4uSaKxImu5Uk99rey8OFf6yOGcG1j+7mavhwun0
 cx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714471142; x=1715075942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJyajIO89AU+Rdmyk5sghcpIGatrdmXc8IUGjk8KgWE=;
 b=utrs3XP0VhcZJUTY6dqOQgxni03vXjFna6budQuzz9ZI1y4S5Rx5K2uYmuVbYdDgEV
 9+xHJjC8Y8pjUra2SxVMgrUQLPYlLs+8ajSNMCpgp2NoDxOBg5RHvoO/tJ7YP7zGIlnu
 BgSSHNT+W/16zzNnSeEbkYOmHJH3LGiC3A/mBsfNOc1JvyHT9EMcwG2tb9l9bqfmFM/q
 ws1W88OOsNApZo9RpxL4O829SURIHMIRHvTuUIABemDQz4zTYLJAft6wPOW0FHoxhENo
 2VvDY9PqNO8ExOAuzvBK+F4cdpSVpVNXs/pvJOhRdAimLCfaxloeWAZYiIvPVpKUhY1W
 rECA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ8M40gHOhzFO2s8v+ZjTrYxYdzyQc4tbwFUm5+E+diXHGa00OYEnve3S88SP21467X1NQ8xLqeic24ZvXplwVae3b7ME=
X-Gm-Message-State: AOJu0Ywd627pFkz6GEmxPNPf4ElzOkggaXMHBCzHamjoMMEsJilnH/Hx
 PEWJNpKRFxnFsFHZdkXxnbGxv3vd6FDx8afmb8rM3Wvv6dbXffXrtPBhxkSlFE4=
X-Google-Smtp-Source: AGHT+IGVN939E9/y/cV3MYk9JTiVGbXWJlldr3wOQhuy6BDnIlcqy8AtQLwEO1mRYRmfcU3OdS6+qw==
X-Received: by 2002:a17:907:10c7:b0:a55:8f25:14f with SMTP id
 rv7-20020a17090710c700b00a558f25014fmr8958449ejb.40.1714471142188; 
 Tue, 30 Apr 2024 02:59:02 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 cb6-20020a170906a44600b00a58864c88aesm8097624ejb.225.2024.04.30.02.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:59:01 -0700 (PDT)
Message-ID: <e2e92c0a-5bb0-48c3-af54-da8b89130221@linaro.org>
Date: Tue, 30 Apr 2024 11:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] WHPX: Add support for device backed memory regions
To: Aidan Khoury <aidan@revers.engineering>, qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
References: <20220727180012.45615-1-aidan@revers.engineering>
 <ea20f155-4a43-a55d-6ae9-713c267617a1@zapateado.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ea20f155-4a43-a55d-6ae9-713c267617a1@zapateado.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

(old patch)

Cc'ing Paolo, Gerd
(and Laszlo for https://edk2.groups.io/g/discuss/topic/83941304)

On 30/7/22 10:39, Helge Konetzka wrote:
> Am 27.07.22 um 20:00 schrieb Aidan Khoury:
>> Due to skipping the mapping of read only device memory, Windows
>> Hypervisor Platform would fail to emulate such memory accesses when 
>> booting
>> OVMF EDK2 firmware. This patch adds ROM device memory region support
>> for WHPX since the Windows Hypervisor Platform supports mapping read-only
>> device memory, which allows successful booting of OVMF EDK2 firmware.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/513
>>            https://gitlab.com/qemu-project/qemu/-/issues/934
>> Buglink: https://bugs.launchpad.net/bugs/1821595
>>
>> Signed-off-by: Aidan Khoury <aidan@revers.engineering>
>> ---
>>   target/i386/whpx/whpx-all.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
>> index b22a3314b4..7a61df1135 100644
>> --- a/target/i386/whpx/whpx-all.c
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -2363,11 +2363,18 @@ static void 
>> whpx_process_section(MemoryRegionSection *section, int add)
>>       MemoryRegion *mr = section->mr;
>>       hwaddr start_pa = section->offset_within_address_space;
>>       ram_addr_t size = int128_get64(section->size);
>> +    bool is_romd = false;
>>       unsigned int delta;
>>       uint64_t host_va;
>>       if (!memory_region_is_ram(mr)) {
>> -        return;
>> +        if (memory_region_is_romd(mr)) {
>> +            is_romd = true;
>> +            warn_report("WHPX: ROMD region 0x%016" PRIx64 "->0x%016" 
>> PRIx64,
>> +                        start_pa, start_pa + size);
>> +        } else {
>> +            return;
>> +        }
>>       }
>>       delta = qemu_real_host_page_size() - (start_pa & 
>> ~qemu_real_host_page_mask());
>> @@ -2386,7 +2393,7 @@ static void 
>> whpx_process_section(MemoryRegionSection *section, int add)
>>               + section->offset_within_region + delta;
>>       whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, 
>> add,
>> -                        memory_region_is_rom(mr), mr->name);
>> +                        memory_region_is_rom(mr) || is_romd, mr->name);
>>   }
>>   static void whpx_region_add(MemoryListener *listener,
> 
> Test was successful on Windows 10 Pro, 21H1, build & test environment 
> MSYS2, MINGW64
> 
> Tested-by: Helge Konetzka <hk@zapateado.de>
> 
> Test execution after building and installing patched MSys2/Mingw64 package:
> 
> $ cp /mingw64/share/qemu/edk2-i386-vars.fd ./
> $ qemu-system-x86_64 \
>   -M q35 \
>   -m 1536 \
>   -accel whpx,kernel-irqchip=off \
>   -drive 
> file=/mingw64/share/qemu/edk2-x86_64-code.fd,if=pflash,format=raw,readonly=on \
>   -drive file=edk2-i386-vars.fd,if=pflash,format=raw,readonly=off \
>   -cdrom openSUSE-Leap-15.3-GNOME-Live-x86_64-Media.iso
> 
> Windows Hypervisor Platform accelerator is operational
> D:\msys64\mingw64\bin\qemu-system-x86_64.exe: warning: WHPX: ROMD region 
> 0x00000000ffc84000->0x0000000100000000
> D:\msys64\mingw64\bin\qemu-system-x86_64.exe: warning: WHPX: ROMD region 
> 0x00000000ffc00000->0x00000000ffc84000
> qemu: warning: WHPX: ROMD region 0x00000000ffc00000->0x00000000ffc84000
> qemu: warning: WHPX: ROMD region 0x00000000ffc00000->0x00000000ffc84000
> 



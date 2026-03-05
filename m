Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809ABEEF30A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy20h-0007ac-2d; Thu, 05 Mar 2026 01:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy20e-0007Xs-VK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:16:32 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vy20d-0002Mv-2c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:16:32 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-5ff1703cb9eso2114996137.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 22:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772691389; x=1773296189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wetarsDDx4hL0vxUu93kA2syxQHamQ2uPA0pOMoZdIU=;
 b=UIJOQfmvWV5TiSpZbT87rITfAv4CZWDJyWVj2i66s31wZuvNL9AZpxp9vhM3u+lHLI
 zX2jSa3BPQC9c1RFiGRu7AZmkPHQmedd7zK2CC4GnUDGyP4RxHJB9d3zE5fpyQ2qMQx8
 6hu2DFUJTv7AGpkuxptOjLhz60BanjO4Cg8sa4y0l/8K4mNQ+wOfEN28ShHxWAyV7q1r
 opYeb4ITkBJov7CR2ojr6G9NsaFyYeCgaxcWpySLY8gk4EtlSrdaQh7n+9lp1Fs1Ag/+
 4CMfkPP972OEbU7F0webkxsoEfSw3Z/RX6F4iKG/vi7eBXFpgKuJoCXVeCV+H6hMD2Ti
 45ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772691389; x=1773296189;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wetarsDDx4hL0vxUu93kA2syxQHamQ2uPA0pOMoZdIU=;
 b=tD7HxMbzcm9n2xGmRW7xj2G99cN2KnFbKoLcE8tywmFUvGKilIxHNHAFdRyX71fCvA
 modu8aDNl7u8cTjo9sDOi9Yw0mrK7nmplZb2krttSof4+kUgKzlsS6Z/gn02HK7plAdb
 4hsvVxr+Cl2kTIV21i+OvYOQwO/d5TTjGr39+5t9WLKTpyydJxhJziITagzJqTnZGgGt
 BCI40qMdzStaUovV3aH/XdhixHu9kjOUBrzAryvxXDNVjXuDe/e24+YTX6SCAYo1ZZ37
 RtZ6f2zDkS7XHRdAiG7iwqtiOJLCAfBTR0jirBZAN3ehdBv2JfOY3mFhJMISXPMOftn6
 Dh8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsFp5SrD5YmSxBswBUNUioS+u4uxunSyNoRtCEFM9C2cMlgsz8PajUBNTC/6oyeDa2tA0lkG9/DL9k@nongnu.org
X-Gm-Message-State: AOJu0Yyn5kWuTwXBiZUMYRp+czrrCaJfgSYVMN2lReT/YCvMVnjlHbZx
 hqQcv8xkCpIAUIeodOQJhImffjWM5uBsHvMND5JzmutTDaIknUe+h1tt+05X2H5B2zo=
X-Gm-Gg: ATEYQzxC4sZtlGAJ+u45h3AqP7GwELXZLI+9QO9kRH4cg+P18lskHlY9Bup/hG0AYzE
 1IF+Gdy3+qtPT5hjF9PDEcI7NKlLrbQ/xjmEe65v1M8hW2eTb9O12LVIviBUMwgCdZNxvFrkdzQ
 3q3hBX0DEcyVI7iN4RKeX1XQ2AExfzHDEOSHdGdcAuqCQt5fU4SJIfQ59jngYY6YRs5n6PAnB/H
 AyXTbeHahT8b9fPF+sTxyrei394zqpLFaRpPv9GdbTeoIU+UFXwugEyg43oyZdzvl9a82uaFwI8
 vqJtybG4gGsKdPRWVpxYy4Q8ZyGnO+QivM9xQ5oVMO+XJbwfCpOROhwr9X43Flu9C1g1zqfgdKO
 lQxzWLFteidPAtCdZc/NRRi8+bA+wKnjcRzss/yn6yyURjmhJ/1HXpE6M3+DKbDr5GbHwOB9VZj
 jYfWYrqB3D8wTpkngTv4FLaybgKi7dNO73XMlkyRLIuRI=
X-Received: by 2002:a05:6102:1620:b0:5ff:a16b:93f0 with SMTP id
 ada2fe7eead31-5ffaae25be8mr1811756137.22.1772691389397; 
 Wed, 04 Mar 2026 22:16:29 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ffd1d8983dsm132583137.8.2026.03.04.22.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 22:16:29 -0800 (PST)
Message-ID: <42b1b16b-2680-4200-bb62-7043bbfe7164@linaro.org>
Date: Thu, 5 Mar 2026 03:16:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/8] hw/core/machine: topology functions capabilities
 added
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
 <20260220141128.789-3-alireza.sanaee@huawei.com>
 <91570f1c-3579-4b82-8252-6d29bc7d2f6e@linaro.org>
Content-Language: en-US
In-Reply-To: <91570f1c-3579-4b82-8252-6d29bc7d2f6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2c.google.com
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

Hi Alireza,

On 3/3/26 23:39, Gustavo Romero wrote:
> Hi,
> 
> On 2/20/26 11:11, Alireza Sanaee wrote:
>> Add two functions one of which finds the lowest cache level defined in
>> the cache description input, and the other checks if a given cache
>> topology is defined at a particular cache level
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> ---
>>   hw/core/machine-smp.c    | 52 ++++++++++++++++++++++++++++++++++++++++
>>   include/hw/core/boards.h |  5 ++++
>>   2 files changed, 57 insertions(+)
>>
>> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
>> index 189c70015f..bef04aa2d7 100644
>> --- a/hw/core/machine-smp.c
>> +++ b/hw/core/machine-smp.c
>> @@ -406,3 +406,55 @@ bool machine_check_smp_cache(const MachineState 
>> *ms, Error **errp)
>>       return true;
>>   }
>> +
>> +/*
>> + * This function assumes L3 and L2 have unified cache and L1 is split 
>> L1d and
>> + * L1i.
>> + */
>> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState 
>> *ms,
>> +                                                   int 
>> *lowest_cache_level,
>> +                                                   CpuTopologyLevel 
>> topo_level)
>> +{
>> +    enum CacheLevelAndType cache_level;
>> +    enum CpuTopologyLevel t;
>> +
>> +    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
>> +         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
>> +        t = machine_get_cache_topo_level(ms, cache_level);
>> +        if (t == topo_level) {
>> +            /* Assume L1 is split into L1d and L1i caches. */
>> +            if (cache_level == CACHE_LEVEL_AND_TYPE_L1D ||
>> +                cache_level == CACHE_LEVEL_AND_TYPE_L1I) {
>> +                *lowest_cache_level = 1; /* L1 */
>> +            } else {
>> +                /* Assume the other caches are unified. */
>> +                *lowest_cache_level = cache_level;
>> +            }
>> +
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * Check if there are caches defined at a particular level. It 
>> supports only
>> + * L1, L2 and L3 caches, but this can be extended to more levels as 
>> needed.
>> + *
>> + * Return True on success, False otherwise.
>> + */
>> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
>> +                                         CpuTopologyLevel topology)
>> +{
>> +    enum CacheLevelAndType cache_level;
>> +
>> +    for (cache_level = CACHE_LEVEL_AND_TYPE_L1D;
>> +         cache_level < CACHE_LEVEL_AND_TYPE__MAX; cache_level++) {
>> +        if (machine_get_cache_topo_level(ms, cache_level) == topology) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
>> index edbe8d03e5..af5fd9f3cd 100644
>> --- a/include/hw/core/boards.h
>> +++ b/include/hw/core/boards.h
>> @@ -60,6 +60,11 @@ void machine_set_cache_topo_level(MachineState *ms, 
>> CacheLevelAndType cache,
>>                                     CpuTopologyLevel level);
>>   bool machine_check_smp_cache(const MachineState *ms, Error **errp);
>>   void machine_memory_devices_init(MachineState *ms, hwaddr base, 
>> uint64_t size);
>> +bool machine_defines_cache_at_topo_level(const MachineState *ms,
>> +                                         CpuTopologyLevel level);
>> +bool machine_find_lowest_level_cache_at_topo_level(const MachineState 
>> *ms,
>> +                                                   int *level_found,
>> +                                                   CpuTopologyLevel 
>> topo_level);
>>   /**
>>    * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid 
>> devices
> 
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

I'm actually taking it back.

The function prototypes for machine_defines_cache_at_topo_level and
machine_find_lowest_level_cache_at_topo_level in boards.h need to be
updated to match the function signature:

"CpuTopologyLevel level" -> "CpuTopologyLevel topology" and

"int *level_found" -> "int *lowest_cache_level"


Cheers,
Gustavo


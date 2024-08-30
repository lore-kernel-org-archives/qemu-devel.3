Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E03CA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 19:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk7NR-0003jK-Cd; Fri, 30 Aug 2024 15:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sk7NP-0003iH-Na
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:33:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sk7NN-0001xs-PG
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 15:33:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2053616fa36so7274485ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725046420; x=1725651220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQPnvZnxhPiqjZ0UknTjPakv9beERF3z0bzQ8Xg81ko=;
 b=ntN46DfQFIgsMG3T9ZBVxU3JJlNm/8HUbcX7MgIVBsf3A2O9wYTIuilff68mUFxPBa
 K5jIuDrQ5bf0TlDPu3sYsua1wDD9moHxtzN/25yDHJDNBx2mlqP6HWOrQJtNNxGEBrkI
 PH+DIMksJ8iKBEhVSP92ZRHpOvK3lt1pJgP1aFbgObp7hRDxAvgoFisNVodg4WGRbNPX
 Aw4sZRvUepV78nsBaWBv/w5EzvjbnZ/fmmmcTeW/Zn6QoEawDzeaO1i3ulnMLeDocMEk
 JyXx/f6eeA9X6k/0W8HciRcWva2L/6q5DXdrOPdomLf3Npr8JIJHdnqINQN86hPtGPyr
 1YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725046420; x=1725651220;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQPnvZnxhPiqjZ0UknTjPakv9beERF3z0bzQ8Xg81ko=;
 b=oe+6g9unaZC0yqnmRqEgZ7eB2LQX8/UbJ1PK3hO8+KwWcE74O80yqwN1+4j5gYzUOX
 Z9QFsVNV/aiR7uUxRgLD29b7LOdDNgO5h7FpOChgXWXsbrBdqDRU0VbASLXzKxzNOk5i
 W2eRBvhzYfUapu3jc2OHfeU2Bcd5N4a+t4F7pePbid5INTFGj6OYEoqp3qU481/b+mK6
 HEolxzDCkh3WGauqWLmR66RsL/5+yG1YyWh9t0xWtPVc7yFTgjQPjv+v9dEiCawPnsm9
 Cf3rOkBuyTP1ueHiGy2pxqiEaRxR2/nZwf3uzQEg9lwDyrnln4nQbwQPmzYxE3+6d4at
 T9hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5bs8EGJ31F3ocSdnBZqG5KK4ypBzUBsLPUG+2Ek337A1Q/qxPH9MeBokdhqVRWyziqGnycXLm4stH@nongnu.org
X-Gm-Message-State: AOJu0YzdSWTFPbKgy6zmmYx4f+TWU5w0kaSlm3RgKvN0IqdhurtH+sdn
 cdhrpmKm4r//ZRMHlilBgJ3q5jxJRf6P6I78MW/Q2ySzXUQfx1MF6o5lKWLfbg4=
X-Google-Smtp-Source: AGHT+IEFPNzDcXF8PjkbgbQduYEmFx9F/nK4F5Ep1EdRqtFwKi5ovhd27qiuQQQLmZKBL8gnRy2aeg==
X-Received: by 2002:a17:902:db12:b0:201:df6e:e4be with SMTP id
 d9443c01a7336-2050c354b95mr85931135ad.19.1725046420221; 
 Fri, 30 Aug 2024 12:33:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205155415a7sm30220295ad.183.2024.08.30.12.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 12:33:39 -0700 (PDT)
Message-ID: <31d95985-206a-4e67-8d61-3671b21f9fad@linaro.org>
Date: Fri, 30 Aug 2024 12:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: add API to read guest CPU memory from hwaddr
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240828063224.291503-1-rowanbhart@gmail.com>
 <20240828063224.291503-2-rowanbhart@gmail.com>
 <b2e9c814-36e2-49b6-8109-fbee788d4486@linaro.org>
In-Reply-To: <b2e9c814-36e2-49b6-8109-fbee788d4486@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

And by the way, feel free to integrate this with your other series (as 
it's a very similar topic) in a v3, so we can review both at the same time.

Thanks,
Pierrick

On 8/30/24 12:30, Pierrick Bouvier wrote:
> Hi Rowan,
> 
> thanks for this good complement on the virt address read function.
> 
> However, to be able to merge a new plugins API function, we must have a
> concrete usage of it, through one of the existing plugin.
> What could be a good demonstration of value brought by being able to
> read a physical address?
> 
> Thanks,
> Pierrick
> 
> On 8/27/24 23:32, Rowan Hart wrote:
>> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
>> ---
>>    include/qemu/qemu-plugin.h   | 22 ++++++++++++++++++++++
>>    plugins/api.c                | 17 +++++++++++++++++
>>    plugins/qemu-plugins.symbols |  2 ++
>>    3 files changed, 41 insertions(+)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index c71c705b69..25f39c0960 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -868,6 +868,28 @@ QEMU_PLUGIN_API
>>    int qemu_plugin_read_register(struct qemu_plugin_register *handle,
>>                                  GByteArray *buf);
>>    
>> +/**
>> + * qemu_plugin_read_cpu_memory_hwaddr() - read CPU memory from hwaddr
>> + *
>> + * @addr: A virtual address to read from
>> + * @data: A byte array to store data into
>> + * @len: The number of bytes to read, starting from @addr
>> + *
>> + * @len bytes of data is read starting at @addr and stored into @data. If @data
>> + * is not large enough to hold @len bytes, it will be expanded to the necessary
>> + * size, reallocating if necessary. @len must be greater than 0.
>> + *
>> + * This function does not ensure writes are flushed prior to reading, so
>> + * callers should take care when calling this function in plugin callbacks to
>> + * avoid attempting to read data which may not yet be written and should use
>> + * the memory callback API instead.
>> + *
>> + * Returns true on success and false on failure.
>> + */
>> +QEMU_PLUGIN_API
>> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
>> +                                          GByteArray *data, size_t len);
>> +
>>    /**
>>     * qemu_plugin_scoreboard_new() - alloc a new scoreboard
>>     *
>> diff --git a/plugins/api.c b/plugins/api.c
>> index 2ff13d09de..c87bed6641 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -527,6 +527,22 @@ GArray *qemu_plugin_get_registers(void)
>>        return create_register_handles(regs);
>>    }
>>    
>> +bool qemu_plugin_read_cpu_memory_hwaddr(uint64_t addr,
>> +                                        GByteArray *data, uint64_t len)
>> +{
>> +#ifndef CONFIG_USER_ONLY
>> +    if (len == 0) {
>> +        return false;
>> +    }
>> +
>> +    g_byte_array_set_size(data, len);
>> +    cpu_physical_memory_rw(addr, (void *)data->data, len, 0);
>> +    return true;
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>>    int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>>    {
>>        g_assert(current_cpu);
>> @@ -534,6 +550,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>>        return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
>>    }
>>    
>> +
>>    struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
>>    {
>>        return plugin_scoreboard_new(element_size);
>> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
>> index ca773d8d9f..5d9cfd71bb 100644
>> --- a/plugins/qemu-plugins.symbols
>> +++ b/plugins/qemu-plugins.symbols
>> @@ -20,6 +20,8 @@
>>      qemu_plugin_num_vcpus;
>>      qemu_plugin_outs;
>>      qemu_plugin_path_to_binary;
>> +  qemu_plugin_read_cpu_memory_hwaddr;
>> +  qemu_plugin_read_io_memory_hwaddr;
> 
> As you mentioned, you can remove the second one for v2.
> 
>>      qemu_plugin_read_register;
>>      qemu_plugin_register_atexit_cb;
>>      qemu_plugin_register_flush_cb;


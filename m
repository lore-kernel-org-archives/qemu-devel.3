Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B14DC27C65
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 04:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRbs-0004bD-Bv; Fri, 07 Jun 2024 00:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFRbl-0004aa-6a
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:53:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFRbj-0000fb-AI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:53:44 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so1785241a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 21:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717736020; x=1718340820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=46SwCQeAhK6KKlLnzzViCFDBhTL9A8RHps1J3boUrPY=;
 b=kjb6YRF7pyTC7SJ+mWo7w6GC1SfxxsFtsBEOh+sbxjByhceiM2SuTmoXJa4+T5B5kk
 AuT3v7GUXlXqMkF62DjBff/NWeV25o5ixajIir9Vtth5reYcv6BH5ye4u44KWsR3QuUP
 gPUB4JItayfIRodPXyv1nMJux5H58vDXXVvgWMwB0+YFHCj6LK/6zYLmrNTDSHHvwukA
 fikIR6JvIrqHfK70mjp2NhQiUJMyqbIto8xAvcR7kwE3ieY8o9J+h6vAx+Wm1cjwvD9O
 GAPlhUTjw6cgWGVcux27SLhek5c2P0YI8ORIGOomzxWjDOI1D8r15TqpMJ9JRhJhQzBg
 n1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717736020; x=1718340820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46SwCQeAhK6KKlLnzzViCFDBhTL9A8RHps1J3boUrPY=;
 b=PfsQaseCz48ocoohhOcUyUBUfJnJfzyq9uDbfiTkUOicmaIdi9q88p3yoccOiSuJQf
 X3lpuIhBppnvEvyA+2utQXbQeySMuPs7fhEtByVzFocdxjiJBSWz5Y7rz6uJmUDh5539
 cLcido+/IkESMQBxVNZwJvKCTCNGyR36tyHr76BSIaZ7Qp2QLSifzIfREvE7ChubfKPE
 riH+vfIRF3ztUFR4gF8N0vp10Vm89E1elnSw78JDcu+ZfEbeyowB9eJmy2HaGfnNTuXn
 bckSdy2w2jmgSnqeHZetDtb5cP1oVQPYlRXOTaprIBw7UUen2sJHDLyes2KNYlgoQRXn
 heMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxuRtpOESbDMz1ntFP+ILHQtqhh/2yaxflwQggmGLw9ko8f2gpGavxEMl7liloyiUEpo8nyVAjyaOMtYW16wxBNE/NMk0=
X-Gm-Message-State: AOJu0YxoXFWSYWDRnKKPA4n7fEAnYydqcDXoJwPZB5Yc0xO834hzlrFZ
 g4hPa1j0lCF7yhD9EsXPFSFYLngw+xBmOVxkFpO2Hlry/mcbLAML+m8ajsyptfA=
X-Google-Smtp-Source: AGHT+IF76pQcvWUT04OtLP9UUGzQdKbZzefcEgBpwQI8M0Skz7G3iSzVK1oBNjUfvk1XMmU5INXWvQ==
X-Received: by 2002:a17:907:9862:b0:a6b:45ab:db0e with SMTP id
 a640c23a62f3a-a6cd5eb8c8fmr90859966b.21.1717736020072; 
 Thu, 06 Jun 2024 21:53:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cc770sm187269466b.73.2024.06.06.21.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 21:53:39 -0700 (PDT)
Message-ID: <cc029923-bd07-4b48-ad8a-b68501a0e54d@linaro.org>
Date: Fri, 7 Jun 2024 06:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] plugins: Free CPUPluginState before destroying vCPU
 state
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240606124010.2460-1-philmd@linaro.org>
 <20240606124010.2460-3-philmd@linaro.org>
 <26cb32be-d5a6-48b9-98c9-ca94ac6ceafd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <26cb32be-d5a6-48b9-98c9-ca94ac6ceafd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 6/6/24 23:14, Pierrick Bouvier wrote:
> On 6/6/24 05:40, Philippe Mathieu-Daudé wrote:
>> cpu::plugin_state is allocated in cpu_common_initfn() when
>> the vCPU state is created. Release it in cpu_common_finalize()
>> when we are done.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qemu/plugin.h | 3 +++
>>   hw/core/cpu-common.c  | 5 +++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index bc5aef979e..af5f9db469 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -149,6 +149,9 @@ struct CPUPluginState {
>>   /**
>>    * qemu_plugin_create_vcpu_state: allocate plugin state
>> + *
>> + * The returned data must be released with g_free()
>> + * when no longer required.
>>    */
>>   CPUPluginState *qemu_plugin_create_vcpu_state(void);
>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>> index bf1a7b8892..cd15402552 100644
>> --- a/hw/core/cpu-common.c
>> +++ b/hw/core/cpu-common.c
>> @@ -283,6 +283,11 @@ static void cpu_common_finalize(Object *obj)
>>   {
>>       CPUState *cpu = CPU(obj);
>> +#ifdef CONFIG_PLUGIN
>> +    if (tcg_enabled()) {
>> +        g_free(cpu->plugin_state);
>> +    }
>> +#endif
>>       g_array_free(cpu->gdb_regs, TRUE);
>>       qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>>       qemu_mutex_destroy(&cpu->work_mutex);
> 
> To ensure I get it right, order of cpu init/deinit is:
> - init
> - realize
> - unrealize
> - finalize
> Is that correct?

Yes, this is valid for all QDev (CPU is based on it).

+ init: allocate state, expose configurable properties
. user configure properties
+ realize: consume properties to tune the object
+ reset: set default values
. object is used
+ unrealize: undo stuff from realize because the object
   might be realized again (unplug - plug)
+ finalize: release resources

See 
https://lore.kernel.org/qemu-devel/20240209123226.32576-1-philmd@linaro.org/

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!


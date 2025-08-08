Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC18CC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 22:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukVDG-0005VU-07; Fri, 08 Aug 2025 18:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukVDD-0005U6-Dm
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 18:05:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukVDB-0005y5-14
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 18:05:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76bd050184bso3697632b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754690715; x=1755295515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fto66Kyz9EveJiR7USXt3wrKqtzTMdh2jW+bkMLO15M=;
 b=u04tA8cPcw9GEQAGlAr6lewPNEk4IX8w8ySWEVNm6+yqcCPvQD2xsszXqG7jJaiyHH
 yvEVHyIH0YxM7gYKvw/APT3nGnfTK6VAECFJELbcgNi7C05EQx8mbaLCsb0WQZY1TDfR
 +fAKFlP/lKWIOHcwYiYWa9Q0yfTyu4EG5bTBqTFV20/E29h8zlx796s7Rzm5m/VM6s+/
 TwyTdC1fiCDqyNYSOK571Fe6WBC2PzHYErVOFPdYU+xlvqAhGLyk9X7A6TtabIaT8hWs
 yFfEt19fCzH57aPr96iiWXkgeRsK1F7fErJdTXFgYm2TwuiWGs0gLraA52uCOayS80m7
 83TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754690715; x=1755295515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fto66Kyz9EveJiR7USXt3wrKqtzTMdh2jW+bkMLO15M=;
 b=KsxxNwYH3ehZfF4QW+i4seZrPyOvBb5iC4yuv63+pLN91ZCEPUYssRRfBNaLQc0TIa
 /IBRNkcgt3I/LdngyTyTms8pGG3jH/UESiU4f7VpIfH0FZP+Ui1D+XGJflLsKxjwDL3L
 isYMhSu5ZGLF0lfV0IPArAW7PjW6QhcohjZNKxti4E4M/bTsxG7yBngHu/QCrmvuq+HX
 /PnsnnNSjckahIKCEbUgPK83g3xtkKqLaCQep2f7g0zU665w6wlAHkFo7zVDuILznwBF
 hLd6YXTEduSubUhEOdZdNqgQdVmu+99SS3TFqrARgLjUvohMhG/zaGAgGCd/2Rn09sNg
 Zj2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkhbgqQg+SHg9ehT4s5G7sBi7L5q9NP3EcWRr+T/+LDtUkXZgdcD74UR63KUZplSyDHUJGZAfSFG9Q@nongnu.org
X-Gm-Message-State: AOJu0Yx3bE7acU1qt4zGKmeOvlG3321L6bGj6m+qF2lbpDcZWCSZOwuP
 vveslz1whL+ybL49nYXUqM37kb8+tinqDE5OMEENTgazvDdAGU9rVwSZyd/xv2And+w=
X-Gm-Gg: ASbGncuTVJ/WIwfJuG0Y93qolG/kMA0KDIX92peKYDRltnnVA6w9DJx6ckX4WtVXiWB
 dEdq5wqdk/dGZl1lstbbeBkm2rrEH7la5DttadCsz9WSGizUORbxfCCLWiDMuDew8q/zKfLb2Kv
 jjJvd7fW0NYJDjJN6EAHK/tvrv/kpqjhjM+YIkbpLFI6JJOwQw6v1bJJHOxEotULtb/hMMXzDV3
 42EYQOckvLAoekINaREe6Es+mHx49wjU3dHLDxlLhuRNHNSaseyVTJ5tqvTcB+yabj3ZosV5tWt
 LBbyH3wVtI5xktE9LuYKCIvErJir+5i3ZXCnLhFamMOGBIlxDpDL4FrjkJM/C0hfBFyTLj/XKrQ
 opfwkau3WDtMPkDatWZgJTv2ikG8WOyGZ7L8=
X-Google-Smtp-Source: AGHT+IFXiVOvoA6yq9qzSYnnkUW6gD2QLqR4222V2kx2dcaGn42CwOJ6cX++Wvie2wophtgot+AlUQ==
X-Received: by 2002:a05:6a00:929b:b0:76b:e0d7:c3cf with SMTP id
 d2e1a72fcca58-76c46096402mr6480067b3a.4.1754690714742; 
 Fri, 08 Aug 2025 15:05:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bea205365sm16802282b3a.83.2025.08.08.15.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 15:05:14 -0700 (PDT)
Message-ID: <a0ae6c62-24d3-4772-aa4d-126fdf88df72@linaro.org>
Date: Fri, 8 Aug 2025 15:05:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] contrib/plugins/uftrace: implement tracing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <20250808204156.659715-5-pierrick.bouvier@linaro.org>
 <ef71cc03-53a3-4a9f-8052-eabf528227e4@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ef71cc03-53a3-4a9f-8052-eabf528227e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/8/25 2:45 PM, Philippe Mathieu-Daudé wrote:
> On 8/8/25 22:41, Pierrick Bouvier wrote:
>> We implement tracing, following uftrace format.
>> Trace is flushed every 32 MB, so file operations don't impact
>> performance at runtime.
>>
>> A different trace is generated per cpu, and we ensure they have a unique
>> name, based on vcpu_index, while keeping room for privilege level coming
>> in next commit.
>>
>> Uftrace format is not officially documented, but it can be found here:
>> https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    contrib/plugins/uftrace.c | 150 +++++++++++++++++++++++++++++++++++++-
>>    1 file changed, 149 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index bb775916270..830967c215b 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -12,6 +12,13 @@
>>    #include <qemu-plugin.h>
>>    #include <glib.h>
>>    #include <stdio.h>
>> +#include <sys/stat.h>
>> +#include <sys/time.h>
>> +#include <time.h>
>> +#include <unistd.h>
>> +
>> +#define MiB     (INT64_C(1) << 20)
>> +#define NANOSECONDS_PER_SECOND 1000000000LL
> 
> #define TRACE_FLUSH_SIZE (32 * MiB)
> 
> #define TRACE_ID_SCALE 100
> 
> (and use)
> 

Ok.

>> @@ -44,9 +59,41 @@ typedef struct {
>>        struct qemu_plugin_register *reg_fp;
>>    } Aarch64Cpu;
>>    
>> +typedef struct {
>> +    uint64_t timestamp;
>> +    uint64_t data;
>> +} UftraceEntry;
>> +
>> +typedef enum {
>> +    UFTRACE_ENTRY,
>> +    UFTRACE_EXIT,
>> +    UFTRACE_LOST,
>> +    UFTRACE_EVENT
> 
>          UFTRACE_EVENT,
>

Ok.

> (in case more types appear)
> 
>> +} UftraceRecordType;
> 
> 
>> +static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
>> +                            size_t depth, UftraceRecordType type)
>> +{
>> +    /* https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909 */
>> +    const uint64_t record_magic = 0x5;
>> +    uint64_t data = type | record_magic << 3;
> 
>          uint64_t data = type | (record_magic << 3);
>

There is nothing ambiguous here (by operator precedence), but I'll add 
it if it can help with readability.

>> +    data += depth << 6;
>> +    data += pc << 16;
>> +    UftraceEntry e = {.timestamp = timestamp, .data = data};
>> +    g_array_append_val(t->t, e);
>> +    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
>> +        trace_flush(t, true);
>> +    }
>> +}
> 
> 
>>    static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> @@ -297,6 +432,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>        cpu->ops.init(cpu);
>>        cpu->buf = g_byte_array_new();
>>    
>> +    g_assert(vcpu_index < UINT32_MAX / 100);
>> +    /* trace_id is: cpu_number * 100 */
>> +    uint32_t trace_id = (vcpu_index + 1) * 100;
>> +
>> +    g_autoptr(GString) trace_name = g_string_new(NULL);
>> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
> 
>     g_autofree char *trace_name = g_strdup_printf("cpu%u", vcpu_index);
> 
> and pass (const?) char * to trace_new().
>

I tried to do something clean with GString everywhere for 
dynamic/mutable strings, and const char* for immutable ones, favoring 
readability and clear memory ownership over C char pointer soup. It does 
not optimize anything important in this context since it's called only 
once during the program execution.

Thus, I would prefer to keep it as it is if that's acceptable for you.

>> +    cpu->trace = trace_new(trace_id, trace_name);
>> +    /* create/truncate trace file */
>> +    trace_flush(cpu->trace, false);
>> +
>>        cpu->cs = callstack_new();
>>    }
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 



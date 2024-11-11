Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA56D12D51
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVwa-0001Fe-9U; Mon, 11 Nov 2024 10:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVwR-0001FE-SL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:03:00 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVwO-0003h1-NA
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:02:58 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2a97c2681so3531868a91.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731337373; x=1731942173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+P9B1oP2qTAbEFkhTjBOlVF3AGZoSMi6eDAXd3DeeBw=;
 b=H9Yd4Pmm+vYuI7nN5zJ+Sqvqe5kkYn/p3/sPtu6YezZjN9vkqEIcAXgp1csLDtJuT6
 S60Js9WRJyXwnhbjA42m7D3xmpcv3+TfvPTFRG/Bn98aZS4/jUTR+6gXszOAsg0BgHZ7
 /zPA+Zn2g/uzoji63bS6uqZBgU4hNIcrWspmOTGBH8LhBz8xKs0FZvXMLb4VqrZd9Yt4
 xdYQYDJz3kk+WbAeBiSU85RuDCp9WLNM6CPS0nSryOaDOZXgkW5iO/OzeaKx66PYBcRl
 nkd4JliD3CYoJNZtnn8Kqf8wA6K21N4/TiGQj9AoUjFNBtZwonIkyJbLYtdh3tF0cYkS
 E7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731337373; x=1731942173;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+P9B1oP2qTAbEFkhTjBOlVF3AGZoSMi6eDAXd3DeeBw=;
 b=UuyKfaKh0wLSGJ6AFpWey84N8SGLwoof6KnLb5E3ooiBiO9q+5BuvSHa5tdz+WoSLp
 JpMKehm3jhr5zpOMltsIBLc9T3edOnnXo0gAHVKD6W0prU9KVLIhSNnmyAgB50VNxeYo
 Kbsp5xZU+UBewbgW+/xwQda5Xhg7LaVGFHKHMXqtE3ClKTgXeNu9zOjT+Jw/xSSGu7fU
 e12LF21FZuFBMF0kaa6wsrD88xrisEkKPJUBhvZwGdfEgqt6hHP6pIBhmt/aK2Ogjzw3
 WvPYLzLNO9iusKxjDooWHkzgf1PzdhVHmEE9w8PQNgcdygLnCwjEf8ibFpbfii7V6m3C
 07hA==
X-Gm-Message-State: AOJu0YwcYEG5tVNAd912GEMwTpGzJvtc1LPqRmf9l6PXX/2yUZK62J1m
 2Y7pLlTTsQPLJ6BZhivqCinBfd89rAvKpIjK/hXRupQvEsohenyuldK0jLI9QKuFjshPeoSBqWt
 F
X-Google-Smtp-Source: AGHT+IHZUPDRmGpqyySQNfxQn1D7ckYCHq5eYRzi7HFQlGOBGmvdfGR1AnXDZZIE1WBaZ5ENaT6vAQ==
X-Received: by 2002:a17:90b:3ecb:b0:2e0:7b2b:f6a with SMTP id
 98e67ed59e1d1-2e9b16aa954mr18484248a91.17.1731337373273; 
 Mon, 11 Nov 2024 07:02:53 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5fee67fsm8590448a91.49.2024.11.11.07.02.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 07:02:52 -0800 (PST)
Message-ID: <8b333c03-2794-40d8-a698-b983c5466d1e@linaro.org>
Date: Mon, 11 Nov 2024 07:02:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/strace: show TID instead of PID
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20241024-strace-v1-1-56c4161431cd@gmx.net>
 <10610014-c6d6-4d39-9df1-f66a0900c754@linaro.org>
Content-Language: en-US
In-Reply-To: <10610014-c6d6-4d39-9df1-f66a0900c754@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 11/11/24 06:59, Richard Henderson wrote:
> On 10/23/24 16:47, J. Neuschäfer wrote:
>> This aligns with strace, and is very useful when tracing multi-threaded
>> programs. The result is the same in single-threaded programs.
> 
> See also "-D log.%d -d tid -strace" which will split the output into per-tid files.
> 
>>
>> gettid() requires the _GNU_SOURCE feature test macro, so it might be
>> unavailable in rare cases. I don't expect it to be a problem though,
>> because it's implemented by both glibc and musl.
>>
>> Signed-off-by: J. Neuschäfer <j.neuschaefer@gmx.net>
>> ---
>>   linux-user/strace.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index c3eb3a2706a93fdcaf693b3413b13921a3c97e8e..93e8c73de8a4a307e6e0df5555bee4c769e41e64 
>> 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -4337,7 +4337,7 @@ print_syscall(CPUArchState *cpu_env, int num,
>>       if (!f) {
>>           return;
>>       }
>> -    fprintf(f, "%d ", getpid());
>> +    fprintf(f, "%d ", gettid());
> 
> Probably better as qemu_get_thread_id(), but otherwise

Or, without the syscall,

   get_task_state(env_cpu(env))->ts_tid


r~


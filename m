Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D669AC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddBC-0001lu-9J; Mon, 12 Aug 2024 18:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddBB-0001lP-3H
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:06:17 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddB8-0002Pd-47
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:06:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc587361b6so38679775ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723500372; x=1724105172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7uiMaWOWK5XTQFA/zUpzjC2fN+i49tqUT0nMIaPknAY=;
 b=IvAspAm2FFqykQIarfwzuL+e0JQZTc3th3oVkgoeR0aVvWu1iqTvPK1uqzczujfBFj
 G6fg55Erl50rJXM5RNomPl3U0I20HFLDKvsB3ebF6KafJNoCVPhXzKR91zKQgxPeYS/U
 BZJhgSXv+pw9+NwtJcTp0O3vIIjVZsWZESQsQgoj91aGC916pYjQdXuxV3lcn98763RX
 RMUKXRuN5AurfMP4YkamqfiprwKiDhv1+mD0nL8EgcOOxXwDiPGRiIf2dth7GLFFkd9U
 thqDgby9Nc/YIzDnAXvJU2whjyh/GnPksNfLUdXIklxBMuUz1pTAp/1jF4Os1ZEhmF5Z
 K86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723500372; x=1724105172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7uiMaWOWK5XTQFA/zUpzjC2fN+i49tqUT0nMIaPknAY=;
 b=bA7gq4LzaRyr553Cbvu+/YHJC/4NxKY4lTzCzU9IvyCMwpZpkTC0HSCoULkpEehE3K
 vrXBZF0YRsRYd7YhgjkxfjkkF+S69QJBYPkzUdLHXtAsOXdQxDIB5Xcr4T6kJ4GFG3iO
 hQiNUB1FJEYYag897b6FySGJUIva2KSATCDL/5QoXQX3wUBAiFtX3ke8+40+CEcnEXIb
 Q0Z1JhJRc5J0s0IB4401hs9vxAGoV5WC2yw5inivvqFyxi3oVlrTjLpFcWry4B6UEMuQ
 sNvQK+Nk9R8T5JBp61fcrUJFeqCvC+O0+faw02oXL4Mz4pEdSaPi9/0EEeP6QFT2xCM7
 3diw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQuy8cVhWLr326OX25HaE/NfZjmVFXXqnb8PHfHO/GzgV5RcJtVK7XA+qjVC+hbFaFDoyFG29aLj4rWV5LmyptNyBR6pE=
X-Gm-Message-State: AOJu0Yx0V4rBVFhSrLFscmq768urW+jav8f0arXtxLMPvLUqBGdJ3w4v
 /alR62AEz/bqLqV55Ghgm+wMeSREoybvUvxBXbhkepr2Yy6WjZUg/YW28Tv87vY=
X-Google-Smtp-Source: AGHT+IGhmHI9S2oUHdKib34qxXw1KSQCghYqbDUX85BfGddYjHzoe+NDn8zPh9XXRWS5FeA75lXQ+A==
X-Received: by 2002:a17:903:22d1:b0:1fc:726e:15a6 with SMTP id
 d9443c01a7336-201ca148718mr18939395ad.34.1723500371833; 
 Mon, 12 Aug 2024 15:06:11 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1d0ae2sm1492255ad.284.2024.08.12.15.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 15:06:11 -0700 (PDT)
Message-ID: <5442b27c-3ef4-408f-b847-8cdaf0c645b0@linaro.org>
Date: Mon, 12 Aug 2024 15:06:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix race condition with scoreboards
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
 <a416aab9-56fc-40ef-a94e-92a944248809@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a416aab9-56fc-40ef-a94e-92a944248809@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/28/24 20:30, Richard Henderson wrote:
> On 7/23/24 09:23, Pierrick Bouvier wrote:
>> A deadlock can be created if a new vcpu (a) triggers a scoreboard
>> reallocation, and another vcpu (b) wants to create a new scoreboard at
>> the same time.
>>
>> In this case, (a) holds the plugin lock, and starts an exclusive
>> section, waiting for (b). But at the same time, (b) is waiting for
>> plugin lock.
>>
>> The solution is to drop the lock before entering the exclusive section.
>>
>> This bug can be easily reproduced by creating a callback for any tb
>> exec, that allocates a new scoreboard. In this case, as soon as we reach
>> more than 16 vcpus, the deadlock occurs.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    plugins/core.c | 29 +++++++++++++++++++++++------
>>    1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/plugins/core.c b/plugins/core.c
>> index 12c67b4b4eb..e31a5c1c9cc 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -214,28 +214,45 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
>>    
>>    static void plugin_grow_scoreboards__locked(CPUState *cpu)
>>    {
>> -    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
>> +    size_t scoreboard_size = plugin.scoreboard_alloc_size;
>> +    if (cpu->cpu_index < scoreboard_size) {
>>            return;
>>        }
>>    
>>        bool need_realloc = FALSE;
>> -    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
>> -        plugin.scoreboard_alloc_size *= 2;
>> +    while (cpu->cpu_index >= scoreboard_size) {
>> +        scoreboard_size *= 2;
>>            need_realloc = TRUE;
>>        }
>>    
>> +    if (!need_realloc) {
>> +        return;
>> +    }
>>    
>> -    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
>> -        /* nothing to do, we just updated sizes for future scoreboards */
>> +    if (QLIST_EMPTY(&plugin.scoreboards)) {
>> +        /* just update size for future scoreboards */
>> +        plugin.scoreboard_alloc_size = scoreboard_size;
>>            return;
>>        }
>>    
>> +    /*
>> +     * A scoreboard creation/deletion might be in progress. If a new vcpu is
>> +     * initialized at the same time, we are safe, as the new
>> +     * plugin.scoreboard_alloc_size was not yet written.
>> +     */
>> +    qemu_rec_mutex_unlock(&plugin.lock);
>> +
>>        /* cpus must be stopped, as tb might still use an existing scoreboard. */
>>        start_exclusive();
>> +    /* re-acquire lock */
>> +    qemu_rec_mutex_lock(&plugin.lock);
>> +    /* in case another vcpu is created between unlock and exclusive section. */
>> +    scoreboard_size = MAX(scoreboard_size, plugin.scoreboard_alloc_size);
> 
> Rather than MAX, if a concurrent resize just completed, we don't need to resize again.
> 
> So:
> 
>     start_exclusive
>     lock
>     if (size < alloc_size) {
>        foreach
>        flush
>     }
>     unlock
>     end_exclusive.
> 

Added this check (it's size > alloc_size instead).

> 
> r~


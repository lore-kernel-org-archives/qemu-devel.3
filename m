Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA074C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4O0W-0001gt-B7; Tue, 07 May 2024 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4O0T-0001fg-H4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:49:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4O0R-0006tA-Vu
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:49:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f44dd41a5cso3254057b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715100570; x=1715705370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lX44hFHoGyJdhxLS0NE/Kdm4YsmtPvaYM02rzHR3WYA=;
 b=EkoN0XT4T3nR4aCfNpeiwq9ecVXyh82zFDxEmeMh2hI1PAu9ea5LG8TsAxL5+2iVgA
 kqmLEeojFaD6tLIAjIfisbtxB/0wq7yZW7+eXWNr7VFZsx1vwEzvxv2BGFbHBgtBHbP3
 bBO47BQM1r4UIvtijEPclGlIOkNZyt4H9spaQNs6koeB+6g0P+5BEFgxRzG3oRjFo1ka
 6VS/inK1zEkrnRLktYW9OQnRLA8qAWE/5hMPUJVqTpnYHJm9Q+ukbn/HblOQelENvYvu
 LJZM5MzXnAdXUe84WqklrH8cyFBWlWW2aguE9+RiqYV+/UkaxLdF05Ce4pLXPjoPiQO3
 7sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715100570; x=1715705370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lX44hFHoGyJdhxLS0NE/Kdm4YsmtPvaYM02rzHR3WYA=;
 b=oQVTfIFErqyCxSLhuj+aAA86jnSSsLyz6HmhI3EffWWN5uF+cQMV4QG3/ylYIcbtcF
 hUQTYRWgWymct5UdQsh0MNoFJ6lsiEj5a6u1N0nMwPsqw8Lij1wtyd4YTT4J0pfjFXG4
 3dPu9Yw+2LpdsZuTkp1aXyFLuOcEioWfC4Wq9s3v+06Wg7h+zu2HUZiW2JjwBeJ7qUR+
 59Rz5tD59iAC6j3LBVZk0+39VXEw/UQBoN6PiQThkkVoml8Ve8CjQ+tVA+AZ1oME5z2Y
 Dj+yfH4YJXSjFnUOeXPKeml/nTWc/xFchTABrz+uzokyrB7foJoC2Ml/IX4hl9/qgfPf
 XbzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2t7ld3iPOoqSvWpU+nRwnveIFbHpJUgySu0T/S8/SR2CveCj1z1omQh5Y7v7UQJO/oGv2tJRwFDn1dHRmGoYwZjyGxb8=
X-Gm-Message-State: AOJu0Yx1RKuh1IL+mPxs5jDiFNqOYR7vEucitgWk2Sbp8hr2DsldDMRf
 32x89Axaaxq2NpF0mzAGQVWYpTYcmsN0iv9iRghn4o6SRVgiQOvZVd0HkQ4PFlg=
X-Google-Smtp-Source: AGHT+IF3si1MbrWS48EVzpZGqfwInpo9+bygkhJmg6BdvOtKEQLyeyb/wDoO25bH47mHyCGJMTVqEA==
X-Received: by 2002:a05:6a00:b2b:b0:6f3:eb71:af9d with SMTP id
 d2e1a72fcca58-6f49c2bcdfbmr176463b3a.28.1715100570289; 
 Tue, 07 May 2024 09:49:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a62f20d000000b006f45831ac05sm6268259pfh.0.2024.05.07.09.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:49:29 -0700 (PDT)
Message-ID: <67e50ffb-b680-473b-aeda-bbab678d37c7@linaro.org>
Date: Tue, 7 May 2024 09:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/33] accel/tcg: Reorg translator_ld*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-5-richard.henderson@linaro.org>
 <aa92898b-860f-482f-b105-40d8b8c16a9e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <aa92898b-860f-482f-b105-40d8b8c16a9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 5/6/24 15:47, Philippe Mathieu-Daudé wrote:
> On 25/4/24 01:31, Richard Henderson wrote:
>> Reorg translator_access into translator_ld, with a more
>> memcpy-ish interface.  If both pages are in ram, do not
>> go through the caller's slow path.
>>
>> Assert that the access is within the two pages that we are
>> prepared to protect, per TranslationBlock.  Allow access
>> prior to pc_first, so long as it is within the first page.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/translator.c | 189 ++++++++++++++++++++++-------------------
>>   1 file changed, 101 insertions(+), 88 deletions(-)
> 
> 
>>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>>   {
>> -    uint64_t ret, plug;
>> -    void *p = translator_access(env, db, pc, sizeof(ret));
>> +    uint64_t raw, tgt;
>> -    if (p) {
>> -        plugin_insn_append(pc, p, sizeof(ret));
>> -        return ldq_p(p);
>> +    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
>> +        tgt = tswap64(raw);
>> +    } else {
>> +        tgt = cpu_ldl_code(env, pc);
> 
> cpu_ldq_code() ?

Oops, yes indeed.  Fixed.

r~


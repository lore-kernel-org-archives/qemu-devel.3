Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37740C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXb3e-00083f-T2; Wed, 07 Feb 2024 01:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXb3c-00081x-ME
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:05:16 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXb3b-0005No-8V
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:05:16 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fc22f372cso1951445e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 22:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707285913; x=1707890713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlAkDui8ndKUWZ4hSjwSD5+xj8WjzLwG3LtA02VJFPY=;
 b=GAOcOsz86WMcKGFj6sBXsfvPHV49lN/EzvPjJjnUdFF5d0lmqfYrwSNzd24h7tSx2I
 pgRJHcsm/0c7/Tj7Kfz58rEr9kYTTT8aqaDL1W5buZl2tPsF2h1QC/+co2KrhVFsEnIl
 BWXSYzCHA/aOelN8xnx/B6MwJEw8JqmlLzkBbkFzNAQE2QBzVtb4Hhz8Mp1zHgssYajt
 ql+hlYL+StvVYjLTY0XB/phSooV1td+RTNeVhrbYeEjaOiBzUMHxFJcNuKTA0RUO+j6W
 TmhOVflLRj6V/TTWs1HjNsxWDe5sPsnZjElQigLgiLjVAG4to5leG7mBc+eoAXSJ8SQd
 B5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707285913; x=1707890713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlAkDui8ndKUWZ4hSjwSD5+xj8WjzLwG3LtA02VJFPY=;
 b=TwWSviy/xxGAvod+GxAqKpV24FVsoKKwURy6hRW6DlANYMxz6xVUlJMn5bhYdaJcm+
 YDnu7Gs1qcD2+32ywGt1YhnwOSyc6/oYPEdORjdUwaTfAY//TIlK5taaVrVkdg/RSDmY
 tnX0cXgLGEcQEU8DUWQIv6VakwtlUZV3B/D0UGm5npPvMnA6ib0mzaJHGVcDOxJKMas8
 4cMjE37UmV701Frcb1SUKdptz36G5mmZxKrlWPj123B48Xb23bgSLjwUWn2qkmTGqYy2
 rSwYwvIPrmy5EzjBofp4/FI17yy0ecFYClHHCjoPBE5cnEEPC0XZ4WHvEwhx3Z4JVFyZ
 XG/A==
X-Gm-Message-State: AOJu0Ywi+Q7ooU/fjGpps3bnN8xWt+SUDJyaSf6ulQrLk+oDxev/jCtg
 /NyDkTuimqFGrjk0Z4/NYgAWlLrpp//hLoq6+nFr8YEQ30OAiJ/WxzjxmKnUokE=
X-Google-Smtp-Source: AGHT+IGv858eGcwyl2g0uMwwvbQS1Ykp+HlmcSqvNBG6yoUQLOZNkI04DMOYJYilXLydtGcIiKp3JQ==
X-Received: by 2002:a05:600c:4ec6:b0:40f:d25f:718d with SMTP id
 g6-20020a05600c4ec600b0040fd25f718dmr3018720wmq.37.1707285913511; 
 Tue, 06 Feb 2024 22:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxYds/N8ik0vcqevVTqkDW/aKQ4ddgwyq44kcIn4YAgYAgHl06u8uH2L9eZsugNcEhEEWfIi1sQ3Cq+nzrH5tZJisrN/IDiJAhXLF0nRciwPk65Bhoy/Iq/y/nucyLvCk79gaKbXPDsCHN8x3B6/9eTKOssNHaqe35xaiViZmgaPh7vqxuGR02CTL423er1OBqNWHqjyTs9gfJ3ZD2ehAN4RUcwSw2MGFXbfkZiBtnJaSjFA7f4lnMFx28LuHB14c5UcQXLFySv9hcrH4bB2k/n0qFJrKla/vzptj1FpUH6NkZWEMvdO/5bU8kzFKFsCYZg9azoAKUq1f5ktChn/qV
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a05600c1c8500b0040fc26183e8sm875043wms.8.2024.02.06.22.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 22:05:13 -0800 (PST)
Message-ID: <4cd886da-b5d9-4dd2-a644-42095184e3cf@linaro.org>
Date: Wed, 7 Feb 2024 10:05:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] plugins: add inline operation per vcpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-9-pierrick.bouvier@linaro.org>
 <4fbda293-3fc3-423f-b7d2-130042a7640a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4fbda293-3fc3-423f-b7d2-130042a7640a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/7/24 07:45, Richard Henderson wrote:
> On 2/6/24 19:24, Pierrick Bouvier wrote:
>> --- a/accel/tcg/plugin-gen.c
>> +++ b/accel/tcg/plugin-gen.c
>> @@ -442,6 +442,13 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
>>        char *ptr = cb->userp;
>>        size_t elem_size = 0;
>>        size_t offset = 0;
>> +    if (!ptr) {
>> +        /* use inline entry */
>> +        ptr = cb->inline_insn.entry.score->data->data;
> 
> This value will not survive the first resize.
> You need to add a pointer dereference from the first "data".
> 

If you look at scoreboard patch, you'll notice tb are flushed when we 
resize, and thus, invalidate the pointer.

We discussed this with Alex previously, and he recommended to implement 
this, instead of adding another indirection.

By the way, this is what created the need to fix cpu_init hook call 
site, to be able to call start/end exclusive. Thus the related patches 
at the beginning of the series.

> 
> r~


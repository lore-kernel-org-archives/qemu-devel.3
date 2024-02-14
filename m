Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38826C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 09:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raC09-0005HY-Rh; Wed, 14 Feb 2024 04:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1raC08-0005HO-QJ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 04:56:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1raC07-0005lX-9B
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 04:56:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411f895c8b6so816575e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707904581; x=1708509381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JgIuljPXb8hssa2JaryxrlpUWA0VED/rQv2d3DOTvMk=;
 b=rvflXAytlNgDOgz1Hqh8OqmmTyLsEumaIuR2qvoNYyK/NHJIPKTu0UnPnksdEUfFtS
 Z/NXdM+bk9tRmfaSZjXpm2w3fpUWZgHjR+h6dnQSIYYnnO0F2Xi9x3071/8UtSH6JzmZ
 +KGkb2F6z3o5Lcd9LMWY5+9lgXPwtY1SVpIdn3iLS/WpkaixqGPLxALVQdbo/V3eITA4
 OWT9JTV0qMYrBUDiWpQSEP0PVYBhgBNjRP0z2LsSWItRzGkZlMKArPBGzF8tNMii0b2K
 IUGOwrsB4+Twao3qCf692jYnQY2txBr321XcwywN9V1JyowAuT+7KxEL4pNUbf3G+uaO
 fCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707904581; x=1708509381;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JgIuljPXb8hssa2JaryxrlpUWA0VED/rQv2d3DOTvMk=;
 b=cbk+4tprGTUeVK+x8VbNds16BKrUrQyq67PQoQ4Jj32GeSOJPVp++devmvnrICrJYB
 2ZLetELiIwa4TJMrIgXGY4pqSIp0wWSBNe7YmGa7c5soVgLEeV9JUeYFTRVSgJHE5dXX
 nPz2TrqwKC3mhmZ596BAPV8x50lZ3EnMVOG/vUmBeUyhBjBLyD3yo/1ilep0zrdW1H3m
 l+FVKrA1JCP6DN/YfiA7+LK/uncbeOH68CuMK/ZOhG2QRBYHMpENBBb8FDSsy3EUKMNI
 uE1tGNQ5Y2mWO7ZB2Ikf7C7IXWY/zQtXSIkbdSSHG2UFtJYGF0vM/mcjXd8kQXO2wO5c
 C0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwM4NdgQFzCMZiy3D6a6ia+ae7AHm3AGkrv3j1Rcj1vQCaTvcupE5RNIy6z7dPQtz3+24d+MhFqOhUVXYu5og99FKGTs4=
X-Gm-Message-State: AOJu0YzoiEDgb4MGmDvJ94RFV54ErFHuK7w6gPiTmXxyAPn6XiKRNvZh
 dtlLzNwJtVmNEgG7a7QClWVY3fIeQxHtMsY77w/W6ab/DOMJ+ULz7C6Wc5L0hyKYkQfFGvQlV5L
 wWSA=
X-Google-Smtp-Source: AGHT+IFI7gaBBLRoY9CZlEIgV9sDt6x2kbVGqBo1YAuU+xh+PpawDIUdl4TjYetZKR4a8CzxqJoaTQ==
X-Received: by 2002:a05:600c:519b:b0:411:e5c1:e573 with SMTP id
 fa27-20020a05600c519b00b00411e5c1e573mr1074357wmb.7.1707904580685; 
 Wed, 14 Feb 2024 01:56:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWWVlucIMyKqKrMrw28Vgq1r7kFaKqBxUSBEDr26E7uRYjBsE/YOdVQoxsbrJtNlsLalw+d+4nLMaKp8DXCMUP77/zl12TS/7u3P5VF2mOPmc7vc8XY9/SGd6ylF8nHIQ0paA==
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d67c4000000b0033b888a0a63sm5757360wrw.0.2024.02.14.01.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 01:56:20 -0800 (PST)
Message-ID: <0cb0e0a0-d9b2-4363-b7aa-2f978aa203fe@linaro.org>
Date: Wed, 14 Feb 2024 13:56:19 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/18] plugins: remove non per_vcpu inline operation
 from API
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-17-pierrick.bouvier@linaro.org>
 <051cd462-ed28-4c52-aeb2-eaaa01956d82@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <051cd462-ed28-4c52-aeb2-eaaa01956d82@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/13/24 22:44, Richard Henderson wrote:
> On 2/12/24 23:40, Pierrick Bouvier wrote:
>> Now we have a thread-safe equivalent of inline operation, and that all
>> plugins were changed to use it, there is no point to keep the old API.
>>
>> In more, it will help when we implement more functionality (conditional
>> callbacks), as we can assume that we operate on a scoreboard.
>>
>> Bump API version as it's a breaking change for existing plugins.
>> Bump min API version too, as we removed some functions.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/qemu/qemu-plugin.h   | 58 ++++--------------------------------
>>    plugins/plugin.h             |  2 +-
>>    plugins/api.c                | 29 ------------------
>>    plugins/qemu-plugins.symbols |  3 --
>>    4 files changed, 6 insertions(+), 86 deletions(-)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index cdf1266d724..9b11098ff82 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -53,11 +53,15 @@ typedef uint64_t qemu_plugin_id_t;
>>     * symbol qemu_plugin_version which can be checked.
>>     *
>>     * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
>> + * version 3:
>> + * Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
>> + * Those functions are replaced by *_per_vcpu variants, which guarantees
>> + * thread-safety for operations.
> 
> You don't need to bump again, as we won't have a release in the middle of your patch set.
> 
I'll bump this once. Discussing with Alex, only release points are 
important. Users tracking master are expected to detect and fix this.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


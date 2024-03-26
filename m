Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3EBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5sl-0001mc-3i; Tue, 26 Mar 2024 08:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp5si-0001mT-OE
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:26:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rp5sg-0006wK-C3
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:26:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4148f497a2fso3245335e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711455975; x=1712060775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rtDF9bWhcP/iPCl83QtJH4DhC3d8UEVcukKwRviDNdY=;
 b=vmAzY3d9y9v6IRuZC2mytx4Ta2Al8TB2qy+nJkBctsbufMRu37Q6MFiGY8MGb5EU4q
 Dfu0wTs15nl7pH8vAKGD2InpVXqQdm1zeZZz42rRdUqMUYnp/n264hffN+FSWUmAiKtL
 6vR3Nkx/D6VlFLLnKVyJ/4VmyeNiPoqUQeERTAWNXJSTb27OLSBV8jbIhbSOiYZA/21R
 VGxQ1H8bS1z78YzzrTFM69VPw4tsPREIzZlzXfUrry1Z3rcYo/A1/wcvrJarWrOj89PK
 z7Qnh14RYMpV/AE+ARBasBdCQiYWgiX344URQGspNwJTTOuI+Dy3C2QRtPV5s4cXBo62
 EDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711455975; x=1712060775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rtDF9bWhcP/iPCl83QtJH4DhC3d8UEVcukKwRviDNdY=;
 b=FqpJicERSSs449UhWv3evFCP1bIjWh5ai4BMjQADDWslk8iVT79/JHPHvx7dLcMx0W
 LbiCpG3XRAWik0mJtv+zEbFsBBrXYSxA28gWvNKA9AR2QgBUO+sS2vz+RSgQKlKhL0GD
 3g2KtBE8OHqveRv2yNIjYCl48k0IVujbgB5tWwBsd1yKHVt4+sKNvAaOnPVFrEa9QxmI
 HDNRRehQBZ92Li5ss6OOEUAVFfz5SwGDsIM3RlYpzvhwi1KbvBO1JC+MgBhb6+hg6dK2
 TBGcML2ZPZVmlDlIlHwRpUkp5tcrEQJFxE9dFwU66ZOPLytOMgxkKbpCxCAmsWlVJGBY
 VIow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOxr7D9sbq9IIHYA3lXRRJVSb/e7fa/1exhhAy5VVBMCVEhv39mzjbPi71hH4RrnlE68+hhHeBCYSRSKZDg6eLks6sgzQ=
X-Gm-Message-State: AOJu0YyMFn/ZAGCdPE9o/EFN4svurpMnwV5evs4LFhjUNQf0c+bVikVQ
 aE9MootFQxuR7ltMP6DgUhb2Uz4SqxSkDK4hrlkm0t4zJFTUBeFQmLxP0r74h0I=
X-Google-Smtp-Source: AGHT+IGfXxAMiojoXUVmHV0Ehfdt2vJnmQKlfwkO0H+HsKl54AqSE1V9AW/ox9kkA28yvaQza4VQVQ==
X-Received: by 2002:a05:600c:358f:b0:414:6865:b5bc with SMTP id
 p15-20020a05600c358f00b004146865b5bcmr1728957wmq.28.1711455975330; 
 Tue, 26 Mar 2024 05:26:15 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a5d5585000000b0033ed7181fd1sm12056383wrv.62.2024.03.26.05.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:26:15 -0700 (PDT)
Message-ID: <479d5efe-37c8-4d69-9bdb-340452e49ba8@linaro.org>
Date: Tue, 26 Mar 2024 16:26:10 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] plugins: distinct types for callbacks
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-8-pierrick.bouvier@linaro.org>
 <32cec6a3-3535-4464-983a-894d3ba937bf@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <32cec6a3-3535-4464-983a-894d3ba937bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/25/24 23:23, Richard Henderson wrote:
> On 3/25/24 02:41, Pierrick Bouvier wrote:
>> To prevent errors when writing new types of callbacks or inline
>> operations, we split callbacks data to distinct types.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/qemu/plugin.h  | 46 ++++++++++++++-----------
>>    plugins/plugin.h       |  2 +-
>>    accel/tcg/plugin-gen.c | 58 +++++++++++++++++---------------
>>    plugins/core.c         | 76 ++++++++++++++++++++++--------------------
>>    4 files changed, 98 insertions(+), 84 deletions(-)
>>
>> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
>> index bb224b8e4c7..a078229942f 100644
>> --- a/include/qemu/plugin.h
>> +++ b/include/qemu/plugin.h
>> @@ -73,34 +73,40 @@ enum plugin_dyn_cb_type {
>>        PLUGIN_CB_INLINE_STORE_U64,
>>    };
>>    
>> +struct qemu_plugin_regular_cb {
>> +    union qemu_plugin_cb_sig f;
>> +    TCGHelperInfo *info;
>> +    void *userp;
>> +    enum qemu_plugin_mem_rw rw;
>> +};
>> +
>> +struct qemu_plugin_inline_cb {
>> +    qemu_plugin_u64 entry;
>> +    enum qemu_plugin_op op;
>> +    uint64_t imm;
>> +    enum qemu_plugin_mem_rw rw;
>> +};
> 
> Do you still need 'op' anymore here?
> It seems redundant with 'type'.
> 

You're right, removed it in a new commit, will post new series.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


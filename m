Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B27C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 18:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsnGU-0001TS-5z; Thu, 13 Mar 2025 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsnGJ-0001RX-Di
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:26:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsnGG-00010J-As
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 14:26:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso9292795e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741890385; x=1742495185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/yJ4bypxoYI2AF7GOB0h9IaaLeRrhK8kcnL/QNoeMV8=;
 b=nvyz4cYV4De9dRw4uTSQW0Dvp6jEaKQeFhGK4NPSDuit4n2j5kuDxunUc9vda/6+9d
 fXsy/jIUJNGN5eXGBKbkFg2v+/YweCcel/2YK1Jn9Li0p9TN30W9BWSVIss4UgE3KZCd
 4US0JqbMjM1xq0RrwESNEveiDgaQfTB0c8yFfMmBXjTqoCv0ZJlhtkUAw2ZdeN7hQMjB
 DPLbZvMYgLwv9p1fjfkd2EXwzjvfWjC4SXqzwcnnPFCt8YB6vMwHvMBN1qRlhnSdURW1
 HegUT4jIQZzYyb1AWUOCm3o1oNuf9yJDvCn6c4Mcnd2/rfY8ey7yi+g7AMD+gc2n1zeF
 PU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741890385; x=1742495185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/yJ4bypxoYI2AF7GOB0h9IaaLeRrhK8kcnL/QNoeMV8=;
 b=nVinwY6jUA9tUr+v5bjQxN5Sy0n1Z40tSNfvbB6JzrMNQ7Jfpd912gFf7WWJHhHXQE
 EgnTIuAB7qPwEBXYs+aIx+wIlDog9BRuzyPVIfuHqkBdEIX4sWxttUfV1SWaaLmoWZrQ
 UdQ9F8Ny6en9cj1AAtZEIlAMvJjCKcfxkqmxaJn7nxMfJ0dNw6oWZnAEJh1dm1maLX7F
 FB2c162uHaUU3/ug2wdDHhHwrIcBWLc2rkej+s/CSJksJMSwn6KLvAYDCgieyzYHLux9
 L7cnKEWr1I3RLnKCZWnsLBYwFaZxdsUj5VRE/75W01LLjG56eFKCpPQrzC5q4Z+jQ+xt
 kr5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfHRerzv+RDDO0qC/ILLWE9c7b2vWyfW3f/mUU+vyWcYYSTHNiJQVTRQKAs/fza7XEXtDTLJ2YRUPj@nongnu.org
X-Gm-Message-State: AOJu0YxM8UZ814ewMueyeburcxdxtFnwxLn15MlpbDXX61O8GYAd1E0U
 M7M9S9CTsrPitiiMqeFx7WacWkG60YqJTCtG3ocQ90hJjBuI3eASXT9vFiLFCEE=
X-Gm-Gg: ASbGncvfVemlkZNpXdccLjg3yh869G/pEZdJHIjZ4CFHBpHWInLv/r8wd+OrVJlGx7u
 9eplpM8Yysd8/T1GSfGRPjnV1RCazViVHXbABKyPungHGLlo4lmmAUWxeMK8bzEV8hZcpM9/wil
 GTXkqfUGdGNrF0GaTwhY8NhqCPI/HVbBwJzG9DNjdO2k9404sVA/ktCIhINR//o3UQifRVMBTHO
 AqJ/0W2m5v/w7x/2QPqgIdmzHj45huzIfXkuM37ktGOuSmk98h2KDZTo0COkN+1z4ES6Hu2t4t/
 HmTLTZTMnF9VvS4q5AR+Lohvws9idjen9L95geXk/kKAElwkeJFFnzmbN5pDmxo8BQGGQBLqDkr
 Cwsois+v6x3VJOBI=
X-Google-Smtp-Source: AGHT+IGBJstT3qVP7Dg/vW1JxCG3xO13tSc5v//IyGqSj8FDJxsMqqY3ALUiljgZq5FdVXAqwQTyiQ==
X-Received: by 2002:a05:600c:3b1a:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-43d1d8c6d50mr7026615e9.18.1741890385195; 
 Thu, 13 Mar 2025 11:26:25 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d188bb56csm28344555e9.20.2025.03.13.11.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 11:26:24 -0700 (PDT)
Message-ID: <e1941fdb-b7e9-4c58-8776-9ff576e9d07b@linaro.org>
Date: Thu, 13 Mar 2025 19:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
 <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
 <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 13/3/25 19:05, Richard Henderson wrote:
> On 3/13/25 09:59, Pierrick Bouvier wrote:
>>> +static inline int
>>> +cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>>> +                      int mmu_idx, uintptr_t ra)
>>> +{
>>> +    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);
>>
>> For my personal culture, is that strictly equivalent to doing the load 
>> with MO_BESW?
> 
> If you're asking if it's the same as passing MO_BESW to 
> tcg_gen_qemu_ld_i32(), yes.  The tcg code generator takes care of making 
> the value sign-extended.
> 
> If you're asking if it's the same as passing MO_BESW to cpu_ldw_mmu(), 
> no.  The core functions only handle unsigned values.  This older api 
> contained functions with a signed return value, so we preserve that.

Are these 2 APIs doing the same thing? What are the uses? Can we rename
the legacy one?


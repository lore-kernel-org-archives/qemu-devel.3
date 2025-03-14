Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6842C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 00:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tssaY-0003OL-54; Thu, 13 Mar 2025 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tssaW-0003Np-Bv
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:07:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tssaT-0004L1-ED
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 20:07:42 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fec3176ef3so2687456a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741910860; x=1742515660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YUZlxK+roiOl2/8eDP8cANTJOOqGZstmyKZvkJUycWQ=;
 b=rGYU0MwwTUtDJjwVr3nTtWwnf7RsNxlLqPStz9iZb9mbmuHvXzLIG24XT54tV/ezrY
 ucy3lNv6ilnvYtws7nom3QGcZSy34bZ8tB3+4o6KUGs+Zy30oPExQcz5RC0+crZWytuC
 yfiWRIOdxDF2XUtwHisMJFKB+9pa5gWUllnINpUXu3OCJbqJJEp5Um6Bd2pfptkZVarF
 FvYnBK0FXJed/OuB4p5yosnrdVPR/XHWjdDUy+L5vFVxJBuJcLEfATBJpHFKlaqYiD9G
 H4Z2G7P4OUUD29amRnlxTkNLoX5avMr3avHlgDh41wxGVhz3hJK1uuIRVYDoWdpOD0uZ
 6Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741910860; x=1742515660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUZlxK+roiOl2/8eDP8cANTJOOqGZstmyKZvkJUycWQ=;
 b=sI2DPlkiqc0/vaww7e4uBbGwXc2/uuG5xQYCLlMZkLFzj/F+5TjdLPcEcNaY4AFwzV
 4V+ml3JE7yATIn7t62ABU2/RvT4Z2qzl58TEVBdn+BWzK0aGu4vT6P79iF6XdhTY124E
 kAaXJwLQ90E2l6cw6nhWDSyDRdmsl9ghDMOquXA/7j9NeQvx6eyuiyQOQn9/p2pf48B/
 KZIqqYav5QpHhMqZe/EP5wVIbrBQZ1Jc0iDFbnqROvmhg4/V8oOKH/ougF64v8ebOc4R
 vMYMQy2e/eRYDY22rWxCcLurkWiUvTv8lFFjFCdxcWd7wKrMt3BcI3eUK7hI3wjotEzK
 ZB0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNQY5kX6q1sBdySAX88/h0gYRxJvhNw1jCBw69PO6x6VFWq03SCxODtQS6ZqUhjLsEmf/sZBBRfp2C@nongnu.org
X-Gm-Message-State: AOJu0YyUtbZBm3dV7+8OTZdczCIbY8Xs+AtrqALJ0zC5u/l7s1VBsSiw
 kJbyGh/0q/S3unHr1PCQcEHQjNgejRi4u8lS1kAsyAmJfJAbS8IZSeOZ8hhpA5M=
X-Gm-Gg: ASbGncuhXGG1mz6ltClKRQHYSZSZ7fZVdQb6OSflxDPPDunXug3NPJVCy5ty725kRCS
 9eC8DPc6hRT2fSPYtssSfSDddNvZfYR7LDMSPjs3APIuBb3LjGN8KlkpHVskXmDi5K8SxiFH7X+
 b/GxDo97+jwqDZ75gDyyp57uoLwBWU5UoC0CQoNuxNMwfAVHDW76rGP/EmuiJPJWGsklhw2UkAv
 GR8EKqINXASpzLoxLKiL9DolhVyiUcfYgpBemsx//Q0XEGoy8vopHBiIsbLmI8ig02+Y4xaLklE
 EZZ2B2qlHOfF555hjvinccpZLALi18tuXHUc42+RdhrVx+YybXl3U7hIox3z/kH0f6HLH3LR9JI
 gxGiSbEQHni3QF+LsZug=
X-Google-Smtp-Source: AGHT+IGBotO9+k3bFNMKqUL8PJcktIP7HKdwyJRpaz2qFK9yjJQIyoitoT5mk8KVUs2oFS5ldgCT+w==
X-Received: by 2002:a17:90b:5706:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-30151d7aef1mr561484a91.30.1741910859682; 
 Thu, 13 Mar 2025 17:07:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30138b3b4c6sm2025892a91.6.2025.03.13.17.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 17:07:39 -0700 (PDT)
Message-ID: <7b320c8e-8278-4962-ac31-6f7e6cc1882d@linaro.org>
Date: Thu, 13 Mar 2025 17:07:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] include/exec: Inline *_mmuidx_ra memory operations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-6-richard.henderson@linaro.org>
 <a6e79bf6-8b93-4b02-8888-6c2a417a34a2@linaro.org>
 <6d26b188-189c-4714-81a7-6061bb8a6ff6@linaro.org>
 <e1941fdb-b7e9-4c58-8776-9ff576e9d07b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e1941fdb-b7e9-4c58-8776-9ff576e9d07b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/13/25 11:26, Philippe Mathieu-Daudé wrote:
> On 13/3/25 19:05, Richard Henderson wrote:
>> On 3/13/25 09:59, Pierrick Bouvier wrote:
>>>> +static inline int
>>>> +cpu_ldsw_be_mmuidx_ra(CPUArchState *env, abi_ptr addr,
>>>> +                      int mmu_idx, uintptr_t ra)
>>>> +{
>>>> +    return (int16_t)cpu_lduw_be_mmuidx_ra(env, addr, mmu_idx, ra);
>>>
>>> For my personal culture, is that strictly equivalent to doing the load with MO_BESW?
>>
>> If you're asking if it's the same as passing MO_BESW to tcg_gen_qemu_ld_i32(), yes.  The 
>> tcg code generator takes care of making the value sign-extended.
>>
>> If you're asking if it's the same as passing MO_BESW to cpu_ldw_mmu(), no.  The core 
>> functions only handle unsigned values.  This older api contained functions with a signed 
>> return value, so we preserve that.
> 
> Are these 2 APIs doing the same thing? What are the uses? Can we rename
> the legacy one?

There are 4 apis doing the same thing:

   cpu_ld*_data()
   cpu_ld*_data_ra()
   cpu_ld*_mmuidx_ra()
   cpu_ld*_mmu()

It would be lovely to get rid of some of them.
A mere matter of coccinelle and lots of testing, I guess.


r~


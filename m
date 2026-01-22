Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC7BC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitKr-0006Km-EJ; Thu, 22 Jan 2026 06:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vitKp-0006Jt-KR
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:58:47 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vitKn-00059a-7e
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:58:46 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so559343f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769083123; x=1769687923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Spw04I2/n0gAv/QO2YXJeR75mEaBdXWF9Hf424f+8YE=;
 b=GwaY4+cOA9FJocprdMucaX/OeG80We4kos8aIDE8zqxsWq2jQGo+DCYfJk+GxN86xm
 V0SfnBWKxceg7OUaQuE5ROQKh+A+A/9JwjL+ZSxqunKRf3QmdmDwdtk1ZhBM9lAcEvEI
 0BqhZGS62hNOFyT9F6oJMdv9bfM3xFBAAKLM1XiOUCX3SsCOF0OfMEcBg2iJh5tYE5wY
 y5BMLdG0H9E2QUrVtOxEd6R+RpFLfaCHf1ukAtrJb7K3ZOe4CeYdSuZem39yhUG1jGz3
 jj49aKGQ+1f67FdzavWisGDL4W2P/HoLM/nxhcxMHx26xtrFIxoBPl4TmMk6J7K+pukl
 2Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769083123; x=1769687923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Spw04I2/n0gAv/QO2YXJeR75mEaBdXWF9Hf424f+8YE=;
 b=ner6TRlCXXr73jTamhuXBz2HxuJYU0BT1ZWK+0256USpl6lo5tK0R1SdZd65wOL6ih
 bYAWJevrmpKhHiQe7YBJXprofBFZSA8XvUPkTAqLVWV/Pt70Tyc6GoWphauL4GORVmOi
 hwxLhX3yQb/64pFh95qYS4NEZXxaU5QlcvpTxLEQXqrnyKs/v18B7UoE326uTZp0uwuN
 7Ci5t0/jkz8k+4fmdG+oseXf+nv3NMoB7CqWovfM5DGBJage2d2AXqZnQfNb68xllED/
 L2yU8S7czUJsbfUPVERkMvE8r63lRaDa8XmRyXsKkKM/Wp/Jf04L0MS4vwtegk00TEE0
 gM4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpacMmZv/I1b0rz1J/4kJOSFHowH+olceyCUOurAGzxJLRry8bssHLDqRghJsbdoR3U7XS59oOJpNq@nongnu.org
X-Gm-Message-State: AOJu0YxYoeey5kft1fAboSxOTbA9AdGwBJ1fhDWvHnShVhPrTBf98SuS
 hRaJ641TXueYA1OgdPe0Gi4M6C2dar/gJ5eARos2omWJ3lLNMJLSnTtp0sDEJ2gCVyI=
X-Gm-Gg: AZuq6aJIPItAs80kVbciLIDJBBZ8lFJzqnkRcWh9s2yMk6qKnpnmHUzwU4WLVX8YQrV
 278o7TdNuyh8RitVXBOw/RLbuDcw55J87wLVnmkVLKa8e845aS3p5NImgnk7kv3dRcwvCgd3lzG
 q6EsV0kZKqNQntYfbVAE0hb4INS9FqaPz2GpdYIMsrfDjyTU4fqIt6Aid1BI1jN8w2TJpGZ28YN
 bkv3LB0gVXP007lZ0WWzxV+SXlhg1uJHRURkqu/Sx2ghq4DUAIlOzFyEyX8co6Zn9Zhwx7Y3VgA
 XG5N2CSk63VhX1TX6th2FXRHpw0MLJ+05IXuxmI8umKDfU+Z0fayDyGSzMsASf8OrxZA6vemRUi
 rOnzhoDQ45zFleFdwk0kgH3QQaU4f+B68XgvLHr9jrsz36eobWI9hIL1rM9XmfG0p0cmENzs/Kx
 oKwg+IWptlA2Ac+ClY/mYyvqIhTP+5oftjM1tli1skPmcuefZsxOGW2w==
X-Received: by 2002:a05:6000:2dc1:b0:435:ad51:ac82 with SMTP id
 ffacd0b85a97d-435ad51ae7fmr2362144f8f.18.1769083123503; 
 Thu, 22 Jan 2026 03:58:43 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359314bbc6sm18566626f8f.12.2026.01.22.03.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 03:58:42 -0800 (PST)
Message-ID: <24fbbfe1-f614-495a-a442-63ca376a595a@linaro.org>
Date: Thu, 22 Jan 2026 12:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 20/22] target/ppc: Inline cpu_ldl_data_ra()
 calls in ICBI helper
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-21-philmd@linaro.org>
 <46a95197-4e21-4dda-8d1d-ea1c4e44c368@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <46a95197-4e21-4dda-8d1d-ea1c4e44c368@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/12/25 18:01, Richard Henderson wrote:
> On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
>> Inline the cpu_ldl_data_ra() call in preparation of
>> removing it. Since the returned value is discarded,
>> don't bother to set the access endianness.
>>
> 
> Hah!  The previous patch could have used the same comment.
> Or maybe moving that hunk here.

Ah indeed, I wanted the helper_icbiep() hunk here, thanks.

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/mem_helper.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>> index a43726d4223..cff385b6020 100644
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -344,14 +344,18 @@ void helper_dcbzl(CPUPPCState *env, target_ulong 
>> addr)
>>   void helper_icbi(CPUPPCState *env, target_ulong addr)
>>   {
>> +    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
>> +    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
>> +
>>       addr &= ~(env->dcache_line_size - 1);
>>       /*
>>        * Invalidate one cache line :
>>        * PowerPC specification says this is to be treated like a load
>>        * (not a fetch) by the MMU. To be sure it will be so,
>> -     * do the load "by hand".
>> +     * do the load "by hand". As the returned data is not consumed,
>> +     * endianness is irrelevant.
>>        */
>> -    cpu_ldl_data_ra(env, addr, GETPC());
>> +    cpu_ldl_mmu(env, addr, oi, GETPC());
>>   }
>>   void helper_icbiep(CPUPPCState *env, target_ulong addr)
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AB9C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 09:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkhcn-00039O-NB; Thu, 14 Mar 2024 05:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkhce-00038T-CN
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:43:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkhca-0003F2-Tp
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:43:35 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dddad37712so7513145ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710409410; x=1711014210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gaaAbTA5tRV4gPMsmIao5ciBCQXEY+DwURHPabcNaM0=;
 b=ZLt3Huk09/9e1b6crorO5b7ZqRwQTdVCynaBXBocChM3hY0+g5rHFVZqbQkVOYn1Fi
 xFanOA5Q94BXWYDhBJieenMC6Vx9P7w5nZThbIvs7vpmYk0zVD6f9wLbUIR+r9ol9pJ7
 Cg/SJKo9NpekJ7HPKqqugcEL3Vf5oXM2qnlYCQRJkBqfvaaq6ou0/L6XU588OxwXfFam
 +39FfjIyMJV9ytyl7QGphauAFKk51z4/u0ISKcrfyyS0SiNg8dpBF6sK/ZImb6ypsJPa
 wqDRA3QvGP89lBkHWk5/aMD+q4mJk3AsnAJbf7/A8leXkBcscH3KhDZHRIfQv38Ll6UI
 gndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710409410; x=1711014210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gaaAbTA5tRV4gPMsmIao5ciBCQXEY+DwURHPabcNaM0=;
 b=ihQuDZBUsgTM7U5SbB5n+k6kqishLBi2LXH0DtD3R7M9FFzNSHZGPaddAbKy3S2U9Q
 UrZet+Vt878Q+i6HKe+jbgh90fdVoD1PPH+6s61xQcq/V+59AYnnMn0/EW7skxgMOqul
 JBLNJ5g3vmYoCfGJTWh4HusKkvf4kCG4VodJPL4ZKrolVjinWpfsdM1PrKOitprTnuei
 4/MT7Ec/jLRjxszaeDzTXFEdbujcYfgoqao/Jac/FRILj8YoOkA2n216E9dzGrY6q9dT
 NkyxjDrz/C3T2QHYdN8awl/kp3K5ZardeHyiTpGetqYzOeKSBPx5QXHWcciqasOl2ovu
 aEDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfwqD+mEDBFJeS6jZVOCLRr7G9F6/MW5UsHzegw1cMA/E7WDygaoOYkCKPPQWc+f2hrZjwkNnIw2YcMIkHt4ApRNIX+2M=
X-Gm-Message-State: AOJu0YydNAtXxoLk8LtO4ZMhoD3cEL8nQlykgnoA3RpMtKbZpl69qeXI
 hj+o48FCL/8BvA2bfuBOqnT51L+FfllimGjptCQZN9yyumaXSatdw5jAyRX042w=
X-Google-Smtp-Source: AGHT+IGIbT5EU5fNi33lChcBypdVgNN+LyLjxikF1yS4RNTJ/MAgwja07Jx+wneJYXHlPaL8ulpGDw==
X-Received: by 2002:a17:902:7202:b0:1dc:d515:79c8 with SMTP id
 ba2-20020a170902720200b001dcd51579c8mr1149710plb.23.1710409409668; 
 Thu, 14 Mar 2024 02:43:29 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902e5cb00b001dc01efaec2sm1218212plf.168.2024.03.14.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 02:43:29 -0700 (PDT)
Message-ID: <b16862a5-f1ea-47ce-bd6a-70c2146b9bc4@ventanamicro.com>
Date: Thu, 14 Mar 2024 06:43:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 3/8] target/riscv: always clear vstart in
 whole vec move insns
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-4-dbarboza@ventanamicro.com>
 <5f882160-fdec-4f28-af23-3bda8bcb186b@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5f882160-fdec-4f28-af23-3bda8bcb186b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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



On 3/13/24 19:36, Richard Henderson wrote:
> On 3/13/24 12:01, Daniel Henrique Barboza wrote:
>> These insns have 2 paths: we'll either have vstart already cleared if
>> vstart_eq_zero or we'll do a brcond to check if vstart >= maxsz to call
>> the 'vmvr_v' helper. The helper will clear vstart if it executes until
>> the end, or if vstart >= vl.
>>
>> However, if vstart >= maxsz, the helper will be skipped, and vstart
>> won't be cleared since the helper is being responsible from doing it.
>>
>> We want to make the helpers responsible to manage vstart, including
>> these corner cases, precisely to avoid these situations. Move the vstart
>>> = maxsz cond to the helper, and be sure to clear vstart if that
>> happens. This way we're now sure that vstart is being cleared in the end
>> of the execution, regardless of the path taken.
>>
>> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
>>   target/riscv/vector_helper.c            | 5 +++++
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
>> index 8c16a9f5b3..52c26a7834 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -3664,12 +3664,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
>>                                vreg_ofs(s, a->rs2), maxsz, maxsz);        \
>>               mark_vs_dirty(s);                                           \
>>           } else {                                                        \
>> -            TCGLabel *over = gen_new_label();                           \
>> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
>>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
>>                                  tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
>>               mark_vs_dirty(s);                                           \
>> -            gen_set_label(over);                                        \
>>           }                                                               \
>>           return true;                                                    \
>>       }                                                                   \
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index ca79571ae2..cd8235ea98 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -5075,6 +5075,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
>>       uint32_t startb = env->vstart * sewb;
>>       uint32_t i = startb;
>> +    if (env->vstart >= maxsz) {
>> +        env->vstart = 0;
>> +        return;
>> +    }
> 
> I think you were right to be concerned about vlmax -- you need to use startb not vstart in this comparison, otherwise you've got mixed units on the comparison.

Hm, so it seems like the comparison is broken in the translation today as well ...


> 
>>       memcpy((uint8_t *)vd + H1(i),
>>              (uint8_t *)vs2 + H1(i),
>>              maxsz - startb);
> 
> Unrelated to this patch series, this has a big-endian host error.
> With big-endian, the bytes to be copied may not be sequential.

We're going for v15. Might as well fix this too.

At this point I'll rename the series to "riscv: vector fixes" since there's
a lot of stuff going on.

> 
>      if (HOST_BIG_ENDIAN && i % 8 != 0) {
>          uint32_t j = ROUND_UP(i, 8);
>          memcpy(vd + H(j - 1), vs2 + H1(j - 1), j - i);
>          i = j;
>      }
>      memcpy(vd + i, vs2 + i, maxsz - i);

I'll do an extra patch with it. Thanks,

Daniel

> 
> 
> r~


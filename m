Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE74C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6sX-0004X9-Rj; Fri, 16 Feb 2024 17:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rb6sV-0004WI-NW
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:40:19 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rb6sT-00078K-QU
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:40:19 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d7431e702dso25712505ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708123216; x=1708728016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqgERea+htXK7qX7a99Ltj1QSsoxR8UCIOOOAjOcIGs=;
 b=bySEM+PDpti0O4OcnNzgEby4losLdn1EfZbIcYAo+1ilzLUpmAKg3oqG1+4My9CoCY
 oFF1QwlCdmF/Gdvk2hp8nKZ+49LZ4vygpBS6lamzqpu5Qg9yuVf4urR7JzyS2cKV9xHr
 gjv7Ilx1zzXUj3eBWn0VrjeMaadkQax5eTth98MwERDopZvWQQWmfeDPGRKD9IOmMNn4
 GoEZx8J5kZ/Diok/0icgClhdi2D9kO22tfhQWIfcVc1nZ80IbP1brdYfXKy9SMQkC8Md
 zjBmi9ZiNyCTeX8NjLhvTLBDZOJumOPRT8TjrvTTGERg1QJO5WrWJWOCbtETmDaFHkl7
 VLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123216; x=1708728016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqgERea+htXK7qX7a99Ltj1QSsoxR8UCIOOOAjOcIGs=;
 b=xLnjeHR7B/efe6Z0v3p3fip0tHpszcTSNbtePJbAOPgtdph87pv/hNSwMA9GsOwyLe
 yCm0eCs6pejJaiMjAxxau+EBPnmKNNnyPHyzBrV+x2dMJQqrXYQrkS9AJ5LRHVcWLeSJ
 0L6qv0snldgxJCv8mcQDauLzr/cRzkwRZYGeqyYQ3REJvxLYeyeTKNRIdXmUAyB8w8iz
 dyy/R8U2Nt3U+xOM3HbBkA/W9fmyWwejNiAq+SOgZ6FVOJ0Jj9r/dyPiy2DrRo8A94Ao
 Ii7/1EFnKGXbQ/kmRoXNDFB9rDLGV7/25U5OvBFUJK24RLYF3fwKSjFQbAKDW2chH96w
 xOuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCfPEUXnWPgsvQIWjFSH9dw7jKEBHlR8AovmrQ8BJYFp+2Ltzu5u8u8qWEpylD4I2w9xxixq6AuzYEI7kBtjHnivRnK00=
X-Gm-Message-State: AOJu0YwxBrizVol2nsWdhaOSc0avfkMs+hw22P+btzDMktpMXxY7Gr56
 jYFE4x1FMLG7+7dV0ZeAke+Rj30ys64r2UlP9lyqdJQJu+EENWy2K2cjOS//UUY=
X-Google-Smtp-Source: AGHT+IG2WY0D5VYjTOVCO3cKqojuERdIv4QZ5P3LSgyT9eZniZgq+p84XpGdZdGCUoNzGCK5mMvhQQ==
X-Received: by 2002:a17:902:f7d1:b0:1db:5c84:9523 with SMTP id
 h17-20020a170902f7d100b001db5c849523mr5281478plw.67.1708123216084; 
 Fri, 16 Feb 2024 14:40:16 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 sb5-20020a17090b50c500b0029724370ea9sm501774pjb.47.2024.02.16.14.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 14:40:15 -0800 (PST)
Message-ID: <04a3c3d3-fc2f-4b1e-9845-f5345e062c7b@ventanamicro.com>
Date: Fri, 16 Feb 2024 19:40:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv/translate.c: set vstart_eq_zero in
 mark_vs_dirty()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
 <20240216135719.1034289-4-dbarboza@ventanamicro.com>
 <16087154-b3d2-4cab-938f-4a04fc8dd166@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <16087154-b3d2-4cab-938f-4a04fc8dd166@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/16/24 15:56, Richard Henderson wrote:
> On 2/16/24 03:57, Daniel Henrique Barboza wrote:
>> The 'vstart_eq_zero' flag which is used to determine if some insns, like
>> vector reductor operations, should SIGILL. At this moment the flag is
>> being updated only during cpu_get_tb_cpu_state(), at the start of each
>> translation block.
>>
>> This cadence isn't enough and we're facing situations where a vector
>> instruction successfully updated 'vstart' to zero, but the flag was
>> still marked as 'false', resulting in a SIGILL because instructions are
>> checking the flag.
>>
>> mark_vs_dirty() is called after any instruction changes Vector CSR
>> state, making it a good place to update 'vstart_eq_zero'.
>>
>> Fixes: 8e1ee1fb57 ("target/riscv: rvv-1.0: add translation-time vector context status")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1976
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/translate.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 177418b2b9..f9ff7b6173 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -652,6 +652,8 @@ static inline void mark_fs_dirty(DisasContext *ctx) { }
>>    */
>>   static void mark_vs_dirty(DisasContext *ctx)
>>   {
>> +    TCGLabel *vstart_zero = gen_new_label();
>> +    TCGLabel *done = gen_new_label();
>>       TCGv tmp;
>>       if (ctx->mstatus_vs != EXT_STATUS_DIRTY) {
>> @@ -669,6 +671,24 @@ static void mark_vs_dirty(DisasContext *ctx)
>>               tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
>>           }
>>       }
>> +
>> +    /*
>> +     * We can safely make 'vl_eq_vlmax = false' if we marked
>> +     * VS as dirty with non-zero 'vstart', i.e. there's a fault
>> +     * to be handled. If 'vstart' is zero then we should retain
>> +     * the existing 'vl_eq_vlmax' - it'll be recalculated on the
>> +     * start of the next TB or during vset{i}vl{i} (that forces a
>> +     * TB end).
>> +     */
>> +    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vstart, 0, vstart_zero);
>> +    ctx->vstart_eq_zero = false;
>> +    ctx->vl_eq_vlmax = false;
>> +    tcg_gen_br(done);
>> +
>> +    gen_set_label(vstart_zero);
>> +    ctx->vstart_eq_zero = true;
>> +
>> +    gen_set_label(done);
> 
> This is very confused, apparently generating code to test vstart at runtime, and then set some translation time variables in the branches.
> 
> Afaik, the only way vstart != 0 is an explicit set to the CSR or exiting a load via exception.  Therefore you have no need to have any sort of brcond here -- just set
> ctx->vstart_eq_zero = true.
> 
> Also, you need to move the ifdefs from around mark_vs_dirty, because it is now relevant to user-only.
> 
> It may be worth a rename, because it does more than mark vs dirty, and therefore is different than mark_fs_dirty.
> 
> You need to review all instances of
> 
>      TCGLabel *over = gen_new_label();
>      tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> ...
>      gen_set_label(over);
>      return true;
> 
> because this *should have* set vstart = 0.  With vstart < vl, this is done in the helper function, but every place using a conditional branch needs attention.

After reading the reviews of patches 1 and 3 what I'm considering here is:

1 - drop patch 1;

2 - there's a patch from Ivan Klokov sent 2 months ago:

"[PATCH 1/1] target/riscv: Clear vstart_qe_zero flag"
https://lore.kernel.org/qemu-riscv/20231214111851.142532-1-ivan.klokov@syntacore.com/

His patch is closer to what you suggested than mine. He already renamed mark_vs_dirty()
to finalize_rvv_inst() and made it set start_eq_zero unconditionally. It needs a
little work (i.e. remove the ifds from the function) that I'll do myself.

3 - I'll keep patch 2 to reduce the redundant calls to the now finalize_rvv_inst();

4 - Add another patch to through all "gen_set_label(over)" cond branches and set
vstart = 0 && vstart_eq_zero manually when we're doing the jump.

In fact, shouldn't we return earlier if we're not taking the branch? Otherwise
we'll set vstart twice in case we didn't get the branch. E.g:

       TCGLabel *over = gen_new_label();
       tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
       (...)
       finalize_rvv_insn();
       return true;

       gen_set_label(over);
       /* some TCG ops to set cpu_vstart to zero. Perhaps a helper?  */
       s->vstart_eq_zero = true;
       return true;




Thanks,

Daniel







> 
> 
> r~


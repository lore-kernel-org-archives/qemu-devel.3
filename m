Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F78C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWJz-0002fK-A2; Wed, 13 Mar 2024 17:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWJx-0002ey-V2
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:39:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWJu-0000bv-Bx
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:39:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29c23f53eabso291180a91.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710365966; x=1710970766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rOE2en3s/h/7OZhxHr35LZl/sY4HpXAo7AN0SBGBBiQ=;
 b=HWuiU1DnbCLd0pjzisG/Pu1YsuV+n9y/8dMg7+saDAaVDOuW4Uucu+6+o2Qj6Tg4yF
 9d0kMyCwx7DQoT8jpPkPkJJvBTTAvGZ7f7r591tMaUUd0ajyUIed8yhZbiLreS8uibW8
 W9rTzuL3fEtJaQAsO0SxmzQhpOfMZInvy1gZBLRO3kUPEfua2BaOzzsDdVDCsE7Rd0lG
 pxfDrIzAkRO8+RHdOp+ZpY57FrodV/MUuLSZQr9spkPrVSYOzNpCyIFFwtfkA6qGQlIc
 qc2H05vsZumnxBxZD5OFvDpIg9fv1339PPN/r9ejtUCMpeaKi26MkFqLvaDWIhPiQ4zM
 bfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365966; x=1710970766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rOE2en3s/h/7OZhxHr35LZl/sY4HpXAo7AN0SBGBBiQ=;
 b=En0Wpgjyjl8C6T/Ei0E3JarHU1TkEVl8GcHfM1Q+t/nvMJftLT9vmyTQG7k4YNMda8
 67aGK5bbe3rmevx9qYWTeD5BoWucPWxznp7pBiOxbwr0pcZTYDDcEL5UK/HIE8FdGIWM
 iUYG3bZ78Wl6g1ZkxMOOvzLlEOTg/77VN0L3aQuRFi6Ijz4IsADVUcQbkP7o8auNHGdz
 UCA6zEya6cXQuNE+dKgVZIJDD+wJC04ZUpKDwU9m7xvQn7iXsTJvLew+VlSuDwLInaIa
 XnDNywB05s3wFpDe3meD/Q1IVXtpgx6ikalawKyn0FxgvI9lGiq63Y9qudILqtRGTfqa
 TlFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRPYwSzmzSXwZfZbFMc9TCe35USj+xzJFVYFSjhLoIqTG8j58xw+XCAps+GaYtZtDFBIwWUG268zmB2vCC6Xnkuf47Y3g=
X-Gm-Message-State: AOJu0YyUFXMfaCZFgt1slzWydJFmlZHAPMQLWpU8I+Mk7xmWbB637a6r
 eVFc2AKIUR2KTZcYlVDiNjCaDxpQ3+oQ6nIU8BMjroSvDZIcFQQqazYrnrn4P28=
X-Google-Smtp-Source: AGHT+IHo9MACZWddMFb4dCt5FE5KsqfLZ0wp4SRJ07bEZKcg2FsZp10ufJ3afHTkBOUv5ZiTm3MzZg==
X-Received: by 2002:a17:90b:4b09:b0:29c:7cd:24b3 with SMTP id
 lx9-20020a17090b4b0900b0029c07cd24b3mr9062832pjb.38.1710365966120; 
 Wed, 13 Mar 2024 14:39:26 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 qc12-20020a17090b288c00b0029bad32fe5csm105456pjb.16.2024.03.13.14.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:39:25 -0700 (PDT)
Message-ID: <1fc1db23-6942-4968-8978-40999c50936c@ventanamicro.com>
Date: Wed, 13 Mar 2024 18:39:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v13 4/8] target/riscv: always clear vstart in
 whole vec move insns
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240313193059.405329-1-dbarboza@ventanamicro.com>
 <20240313193059.405329-5-dbarboza@ventanamicro.com>
 <87936b8f-4900-4a5f-a63d-266c1550c9a1@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <87936b8f-4900-4a5f-a63d-266c1550c9a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 3/13/24 18:16, Richard Henderson wrote:
> On 3/13/24 09:30, Daniel Henrique Barboza wrote:
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
>> happens.  This way we're now 100% sure that vstart is being clearer in
>> the end of the execution, regardless of the path taken.
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
>> index b4360dbd52..7260a5972b 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -5163,6 +5163,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
>>       VSTART_CHECK_EARLY_EXIT(env);
>> +    if (env->vstart >= maxsz) {
>> +        env->vstart = 0;
>> +        return;
>> +    }
> 
> Did you need the VSTART_CHECK_EARLY_EXIT here then?
> It certainly seems like the vstart >= vl check is redundant...

Hmm right. I thought about maxsz being calculated via vlmax, and vlmax not necessarily
being == vl ... but vlmax will be always >= vl. So the vstart >= vl check s supersed
by vstart >= maxsz.


I'll re-send. Thanks,

Daniel

> 
> 
> r~


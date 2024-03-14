Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6659C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkl81-0007K6-N9; Thu, 14 Mar 2024 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkl7w-0007JV-IS
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:28:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkl7u-0007GS-05
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:28:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ddbad11823so9174455ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710422884; x=1711027684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eaft4xU4LyM1C8QsJTdWugT0L2ZSUwRSmcJEHTLQCkY=;
 b=msIjTbRJ0zAq7jxEcN8MaGpyJp/1VoG29redCg45VncH5HuH2gogCBO+5hMJQ9JVAo
 p0NzDr+AQSoUQ/en1011tTVGtfnSWSNchU5tAM5ErP8Ygr7WULLsh4EhpGxPRm7Q3S5N
 LukiGGTx0VUCGw0vFYugVtLMbGFsYqt9WyfrkYoBF9S1gQtug7hxyxzNFrEuwY4Lxv3c
 aIDAW62IRGJ2yk/2bHyygLfZilxsoVzmyobuy7tJlsu5D7s49CMW5V7QcPUGGKJCG3GJ
 pYQaz2Z18eLw6XpprVJP4iOTvsH+0XFlaKoOeOVUKqpldPeLSkab8sXA8pSVVfHtvtJW
 q3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710422884; x=1711027684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eaft4xU4LyM1C8QsJTdWugT0L2ZSUwRSmcJEHTLQCkY=;
 b=b1AJRPzAICn5XEC7Sizil7A7DFu8QTOxIeY7gQaVjJOVxwComMFjJUtKgDsHA/4b3E
 BUUbrcWMCmTbB9Ifak1p2CsHy74Pm8gu+r8j/+5BAjFn0pl01QPRcO/RfIUCHC52Pgbr
 7mep50ncUu9dVeG/P5trv+sLyM5tr3aj2UGA18ZQeqUhPsn5ltaunnoIwijznzyBljsH
 vir+VyWM2z2IlhLMIIHkUd/5EtXM1rltEq0XjAotGf4wxAwFBJZnrnRH4Uzb+T0zU9dN
 7rP1AmaELGBO5KItZ2l0PBUmFHEkfD6MUcnzZTN4UfC2xbwTJ6UTQIzVpYUClMMty67/
 9YOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHrQBx3vPayGZUuaz7aNNV1EHsir0vcYHi9fQS9PXaWDWv+96u9yPy4dHoB/2vcxHS1efb8o1kIF2MVjr2OaZTCjQmisQ=
X-Gm-Message-State: AOJu0Yyn/k96Qc6QCc2KEr/pFx87L7QbGwZNXOpuGEgJWNm7Qw3I3Nf2
 pdX4txUg5ZUxmXf+W2DB2uIbiPXjrQ5QMsUaS/nPYVYYTPPnOzObEsKhxR2Ic98=
X-Google-Smtp-Source: AGHT+IHxbzV/YBh7Am6og6pFfhEFLw13tcPH3asuVVGvkpQJjLPKeDQcDTUihdNmci9eve0F8lUR5A==
X-Received: by 2002:a17:903:11d0:b0:1dc:8f19:8344 with SMTP id
 q16-20020a17090311d000b001dc8f198344mr1990244plh.27.1710422883727; 
 Thu, 14 Mar 2024 06:28:03 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a170902ec8500b001dc3ef7aa2bsm1673770plg.49.2024.03.14.06.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 06:28:02 -0700 (PDT)
Message-ID: <fb4fb4ce-4739-4a05-ac3c-42ba7440abfa@ventanamicro.com>
Date: Thu, 14 Mar 2024 10:27:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early
 exit when vstart >= vl
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-5-dbarboza@ventanamicro.com>
 <eb716a53-fe06-4df0-96cb-7428ec6639bc@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <eb716a53-fe06-4df0-96cb-7428ec6639bc@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 3/14/24 10:14, Max Chou wrote:
> According v spec section 7.9. Vector Load/Store Whole Register Instructions
> 
> "The instructions operate with an effective vector length, evl=NFIELDS*VLEN/EEW, regardless of current settings in vtype and vl. The usual property that no elements are written if vstart ≥ vl does not apply to these instructions. Instead, no elements are written if vstart ≥ evl."
> 
> The VSTART_CHECK_EARLY_EXIT in vext_ldst_whole function may causes unexpected result. We may replace the VSTART_CHECK_EARLY_EXIT function by
> 
> - VSTART_CHECK_EARLY_EXIT(env); + if (env->vstart >= ((vlenb * nf) >> log2_esz)) { + env->vstart = 0; + return; + }

Do we need to do an early exit in this case? If the function is able to handle
gracefully whatever env->vstart value it faces (it seems to be the case) then we
should just remove the exit entirely.

In fact I removed all the early exits from all helpers that are guarded
by vstart_eq_zero: vcpop_m(), vfirst_m(), vmsetm(), GEN_VEXT_VIOTA_M(),
GEN_VEXT_VCOMPRESS_VM(), GEN_VEXT_RED() and GEN_VEXT_FRED(). For these case
the helpers can either do nothing if vl = 0 or throw some exception like
vcpop and first does.


Thanks,

Daniel



> 
>> @@ -572,6 +580,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>>       uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
>>       uint32_t max_elems = vlenb >> log2_esz;
>>   
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       k = env->vstart / max_elems;
>>       off = env->vstart % max_elems;
>>   
>> @@ -877,6 +887,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>       uint32_t vta = vext_vta(desc);                            \
>>       uint32_t i;                                               \
>>                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>> +                                                              \
>>       for (i = env->vstart; i < vl; i++) {                      \
>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>> @@ -909,6 +921,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>>       uint32_t vta = vext_vta(desc);                                       \
>>       uint32_t i;                                                          \
>>                                                                            \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                        \
>> +                                                                         \
>>       for (i = env->vstart; i < vl; i++) {                                 \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
>>           ETYPE carry = vext_elem_mask(v0, i);                             \
>> @@ -944,6 +958,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>       uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
>>       uint32_t i;                                               \
>>                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>> +                                                              \
>>       for (i = env->vstart; i < vl; i++) {                      \
>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>> @@ -982,6 +998,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
>>       uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
>>       uint32_t i;                                                 \
>>                                                                   \
>> +    VSTART_CHECK_EARLY_EXIT(env);                               \
>> +                                                                \
>>       for (i = env->vstart; i < vl; i++) {                        \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
>>           ETYPE carry = !vm && vext_elem_mask(v0, i);             \
>> @@ -1078,6 +1096,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
>>       uint32_t vma = vext_vma(desc);                                        \
>>       uint32_t i;                                                           \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>               /* set masked-off elements to 1s */                           \
>> @@ -1125,6 +1145,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
>>       uint32_t vma = vext_vma(desc);                          \
>>       uint32_t i;                                             \
>>                                                               \
>> +    VSTART_CHECK_EARLY_EXIT(env);                           \
>> +                                                            \
>>       for (i = env->vstart; i < vl; i++) {                    \
>>           if (!vm && !vext_elem_mask(v0, i)) {                \
>>               /* set masked-off elements to 1s */             \
>> @@ -1187,6 +1209,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>       uint32_t vma = vext_vma(desc);                            \
>>       uint32_t i;                                               \
>>                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>> +                                                              \
>>       for (i = env->vstart; i < vl; i++) {                      \
>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>> @@ -1252,6 +1276,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
>>       uint32_t vma = vext_vma(desc);                                  \
>>       uint32_t i;                                                     \
>>                                                                       \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
>> +                                                                    \
>>       for (i = env->vstart; i < vl; i++) {                            \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>>           if (!vm && !vext_elem_mask(v0, i)) {                        \
>> @@ -1799,6 +1825,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
>>       uint32_t vta = vext_vta(desc);                                   \
>>       uint32_t i;                                                      \
>>                                                                        \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>> +                                                                     \
>>       for (i = env->vstart; i < vl; i++) {                             \
>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
>>           *((ETYPE *)vd + H(i)) = s1;                                  \
>> @@ -1823,6 +1851,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
>>       uint32_t vta = vext_vta(desc);                                   \
>>       uint32_t i;                                                      \
>>                                                                        \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>> +                                                                     \
>>       for (i = env->vstart; i < vl; i++) {                             \
>>           *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
>>       }                                                                \
>> @@ -1846,6 +1876,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
>>       uint32_t vta = vext_vta(desc);                                   \
>>       uint32_t i;                                                      \
>>                                                                        \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>> +                                                                     \
>>       for (i = env->vstart; i < vl; i++) {                             \
>>           ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
>>           *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
>> @@ -1870,6 +1902,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>>       uint32_t vta = vext_vta(desc);                                   \
>>       uint32_t i;                                                      \
>>                                                                        \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>> +                                                                     \
>>       for (i = env->vstart; i < vl; i++) {                             \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
>>           ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
>> @@ -1915,6 +1949,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
>>                uint32_t vl, uint32_t vm, int vxrm,
>>                opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>>   {
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       for (uint32_t i = env->vstart; i < vl; i++) {
>>           if (!vm && !vext_elem_mask(v0, i)) {
>>               /* set masked-off elements to 1s */
>> @@ -2040,6 +2076,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
>>                uint32_t vl, uint32_t vm, int vxrm,
>>                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
>>   {
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       for (uint32_t i = env->vstart; i < vl; i++) {
>>           if (!vm && !vext_elem_mask(v0, i)) {
>>               /* set masked-off elements to 1s */
>> @@ -2837,6 +2875,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>       uint32_t vma = vext_vma(desc);                        \
>>       uint32_t i;                                           \
>>                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>> +                                                          \
>>       for (i = env->vstart; i < vl; i++) {                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>>               /* set masked-off elements to 1s */           \
>> @@ -2880,6 +2920,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
>>       uint32_t vma = vext_vma(desc);                        \
>>       uint32_t i;                                           \
>>                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>> +                                                          \
>>       for (i = env->vstart; i < vl; i++) {                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>>               /* set masked-off elements to 1s */           \
>> @@ -3466,6 +3508,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>>       uint32_t vma = vext_vma(desc);                     \
>>       uint32_t i;                                        \
>>                                                          \
>> +    VSTART_CHECK_EARLY_EXIT(env);                      \
>> +                                                       \
>>       if (vl == 0) {                                     \
>>           return;                                        \
>>       }                                                  \
>> @@ -3987,6 +4031,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>       uint32_t vma = vext_vma(desc);                            \
>>       uint32_t i;                                               \
>>                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>> +                                                              \
>>       for (i = env->vstart; i < vl; i++) {                      \
>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>> @@ -4027,6 +4073,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
>>       uint32_t vma = vext_vma(desc);                                  \
>>       uint32_t i;                                                     \
>>                                                                       \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
>> +                                                                    \
>>       for (i = env->vstart; i < vl; i++) {                            \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>>           if (!vm && !vext_elem_mask(v0, i)) {                        \
>> @@ -4220,6 +4268,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>>       uint32_t vta = vext_vta(desc);                            \
>>       uint32_t i;                                               \
>>                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>> +                                                              \
>>       for (i = env->vstart; i < vl; i++) {                      \
>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>           *((ETYPE *)vd + H(i)) =                               \
>> @@ -4386,6 +4436,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>       uint32_t i;                                           \
>>       TD s1 =  *((TD *)vs1 + HD(0));                        \
>>                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>> +                                                          \
>>       for (i = env->vstart; i < vl; i++) {                  \
>>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>> @@ -4472,6 +4524,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>>       uint32_t i;                                            \
>>       TD s1 =  *((TD *)vs1 + HD(0));                         \
>>                                                              \
>> +    VSTART_CHECK_EARLY_EXIT(env);                          \
>> +                                                           \
>>       for (i = env->vstart; i < vl; i++) {                   \
>>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
>>           if (!vm && !vext_elem_mask(v0, i)) {               \
>> @@ -4544,6 +4598,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>       uint32_t i;                                           \
>>       int a, b;                                             \
>>                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>> +                                                          \
>>       for (i = env->vstart; i < vl; i++) {                  \
>>           a = vext_elem_mask(vs1, i);                       \
>>           b = vext_elem_mask(vs2, i);                       \
>> @@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
>>       uint32_t vl = env->vl;
>>       int i;
>>   
>> +    if (env->vstart >= env->vl) {
>> +        env->vstart = 0;
>> +        return 0;
>> +    }
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (vm || vext_elem_mask(v0, i)) {
>>               if (vext_elem_mask(vs2, i)) {
>> @@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
>>       uint32_t vl = env->vl;
>>       int i;
>>   
>> +    if (env->vstart >= env->vl) {
>> +        env->vstart = 0;
>> +        return 0;
>> +    }
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (vm || vext_elem_mask(v0, i)) {
>>               if (vext_elem_mask(vs2, i)) {
>> @@ -4632,6 +4698,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
>>       int i;
>>       bool first_mask_bit = false;
>>   
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (!vm && !vext_elem_mask(v0, i)) {
>>               /* set masked-off elements to 1s */
>> @@ -4704,6 +4772,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>>       uint32_t sum = 0;                                                     \
>>       int i;                                                                \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>               /* set masked-off elements to 1s */                           \
>> @@ -4737,6 +4807,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
>>       uint32_t vma = vext_vma(desc);                                        \
>>       int i;                                                                \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>               /* set masked-off elements to 1s */                           \
>> @@ -4772,6 +4844,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>       uint32_t vma = vext_vma(desc);                                        \
>>       target_ulong offset = s1, i_min, i;                                   \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       i_min = MAX(env->vstart, offset);                                     \
>>       for (i = i_min; i < vl; i++) {                                        \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>> @@ -4805,6 +4879,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>       uint32_t vma = vext_vma(desc);                                        \
>>       target_ulong i_max, i_min, i;                                         \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
>>       i_max = MAX(i_min, env->vstart);                                      \
>>       for (i = env->vstart; i < i_max; ++i) {                               \
>> @@ -4847,6 +4923,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>>       uint32_t vma = vext_vma(desc);                                          \
>>       uint32_t i;                                                             \
>>                                                                               \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                           \
>> +                                                                            \
>>       for (i = env->vstart; i < vl; i++) {                                    \
>>           if (!vm && !vext_elem_mask(v0, i)) {                                \
>>               /* set masked-off elements to 1s */                             \
>> @@ -4896,6 +4974,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>>       uint32_t vma = vext_vma(desc);                                            \
>>       uint32_t i;                                                               \
>>                                                                                 \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                             \
>> +                                                                              \
>>       for (i = env->vstart; i < vl; i++) {                                      \
>>           if (!vm && !vext_elem_mask(v0, i)) {                                  \
>>               /* set masked-off elements to 1s */                               \
>> @@ -4971,6 +5051,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>>       uint64_t index;                                                       \
>>       uint32_t i;                                                           \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>               /* set masked-off elements to 1s */                           \
>> @@ -5014,6 +5096,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>       uint64_t index = s1;                                                  \
>>       uint32_t i;                                                           \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>               /* set masked-off elements to 1s */                           \
>> @@ -5048,6 +5132,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>>       uint32_t vta = vext_vta(desc);                                        \
>>       uint32_t num = 0, i;                                                  \
>>                                                                             \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>> +                                                                          \
>>       for (i = env->vstart; i < vl; i++) {                                  \
>>           if (!vext_elem_mask(vs1, i)) {                                    \
>>               continue;                                                     \
>> @@ -5100,6 +5186,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
>>       uint32_t vma = vext_vma(desc);                               \
>>       uint32_t i;                                                  \
>>                                                                    \
>> +    VSTART_CHECK_EARLY_EXIT(env);                                \
>> +                                                                 \
>>       for (i = env->vstart; i < vl; i++) {                         \
>>           if (!vm && !vext_elem_mask(v0, i)) {                     \
>>               /* set masked-off elements to 1s */                  \
>> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
>> index 12f5964fbb..996c21eb31 100644
>> --- a/target/riscv/vector_internals.c
>> +++ b/target/riscv/vector_internals.c
>> @@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
>>       uint32_t vma = vext_vma(desc);
>>       uint32_t i;
>>   
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (!vm && !vext_elem_mask(v0, i)) {
>>               /* set masked-off elements to 1s */
>> @@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
>>       uint32_t vma = vext_vma(desc);
>>       uint32_t i;
>>   
>> +    VSTART_CHECK_EARLY_EXIT(env);
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (!vm && !vext_elem_mask(v0, i)) {
>>               /* set masked-off elements to 1s */
>> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
>> index 842765f6c1..9e1e15b575 100644
>> --- a/target/riscv/vector_internals.h
>> +++ b/target/riscv/vector_internals.h
>> @@ -24,6 +24,13 @@
>>   #include "tcg/tcg-gvec-desc.h"
>>   #include "internals.h"
>>   
>> +#define VSTART_CHECK_EARLY_EXIT(env) do { \
>> +    if (env->vstart >= env->vl) {         \
>> +        env->vstart = 0;                  \
>> +        return;                           \
>> +    }                                     \
>> +} while (0)
>> +
>>   static inline uint32_t vext_nf(uint32_t desc)
>>   {
>>       return FIELD_EX32(simd_data(desc), VDATA, NF);
>> @@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>>       uint32_t vma = vext_vma(desc);                     \
>>       uint32_t i;                                        \
>>                                                          \
>> +    VSTART_CHECK_EARLY_EXIT(env);                      \
>> +                                                       \
>>       for (i = env->vstart; i < vl; i++) {               \
>>           if (!vm && !vext_elem_mask(v0, i)) {           \
>>               /* set masked-off elements to 1s */        \


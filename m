Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA900C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rklLr-0003no-77; Thu, 14 Mar 2024 09:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rklLp-0003nT-Sq
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:42:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rklLk-0001Py-W6
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:42:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so925898b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710423742; x=1711028542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1i2oH1h+xXYmU+QvCS/HmxHnYKIfe8DzO6t3pTlP9c=;
 b=DfQwewK8PHRW75mms2vDQjgQ3WXCSQ/V+RZ+MiQIQiiHe1/Y8kDfdna30W1a6c2oee
 TRjYfwlqzXpjUV6Q7AiYXc5urZofXOdz7I3VuBxGtyiz4cyTjcp7c9W82Q6MCuW4119c
 y+7So+KE6PttsLb8PeKVy8AZyENulIQD8dZJ4QpxYbt+Zyhrgj4R0QLgfqkY5XC+GZ9Q
 mvUdQ/9b4D1muMkXcTbPU1EZr4NrcH3aWMPDZxx2ZDV+6HKbLB9i64aHf52zeYyyLf3l
 SothftoLItn9V236DaXmQHZxJ3J8YF3bzbXdvSjFQ5GfuBR1dda1WBuipRFDDM4hHYmP
 TxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710423742; x=1711028542;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1i2oH1h+xXYmU+QvCS/HmxHnYKIfe8DzO6t3pTlP9c=;
 b=kE1c5yCZ/HqSf9MWRtNpe1VSVVF824Zz5sO3fa2AH1IZ2AQgwyHVorM3gKOFVZT0mu
 Ge5kYOIUGnVclvx6HqTdx4dofj4r4RAoE524nnXXMOpE9otHqLwuyupJ6tIxS6U+eCtN
 y+Ysv69hx+XoAVvmh4gqQt2Jk0gYGMPrQ4Qc1ldlJUbNsdXacph4r94Dt9Vq4J2eEFvs
 nfAyLqpnxv4hBLOHcKw+0FHaYy/CIesYepmcfgiSqGhAm3z0AeTqUzhajTfaOgEAZ6RI
 lluY5tTnQ050oGeCJboI5b83gNwbuI2Q2PTtdqraVrgJUoGtk1NL6CjzRJJ+Gwsh1PKj
 bSoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8rPDYmS9egLTzELL7Ki9fU79NgazQCvxYeaQ26XEpf80uaU+kdRFqysqOjPnytHR3Bq0mPAAofxdX+eTBq7VXLl/hlyI=
X-Gm-Message-State: AOJu0YyX1uG9Ft9m+0KHbwV8s0NwCRefuuGKdwd9za3bqxiNIhzNVpIW
 dITZ2hY4H4O5rN11Vg7FiXOWz0Mz+lsq6WgnHQHrpZ6639m0bBFQyMVAgVZr39Ae5yKqifL9rlE
 g
X-Google-Smtp-Source: AGHT+IH96NeOFgvGih5nmBKZ5VLby4t0SA78qvNu0M3xXxmm6JTxq1gq0n0GyFHJyutRoK2FwoNsIw==
X-Received: by 2002:a05:6a20:958c:b0:1a3:3d4e:136c with SMTP id
 iu12-20020a056a20958c00b001a33d4e136cmr2167597pzb.22.1710423741636; 
 Thu, 14 Mar 2024 06:42:21 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 lb15-20020a056a004f0f00b006e6b9dd81bdsm1500352pfb.99.2024.03.14.06.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 06:42:21 -0700 (PDT)
Message-ID: <736bf0f8-80ff-467e-b40c-b067991763c7@ventanamicro.com>
Date: Thu, 14 Mar 2024 10:42:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early
 exit when vstart >= vl
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-5-dbarboza@ventanamicro.com>
 <eb716a53-fe06-4df0-96cb-7428ec6639bc@sifive.com>
 <fb4fb4ce-4739-4a05-ac3c-42ba7440abfa@ventanamicro.com>
In-Reply-To: <fb4fb4ce-4739-4a05-ac3c-42ba7440abfa@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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



On 3/14/24 10:27, Daniel Henrique Barboza wrote:
> 
> 
> On 3/14/24 10:14, Max Chou wrote:
>> According v spec section 7.9. Vector Load/Store Whole Register Instructions
>>
>> "The instructions operate with an effective vector length, evl=NFIELDS*VLEN/EEW, regardless of current settings in vtype and vl. The usual property that no elements are written if vstart ≥ vl does not apply to these instructions. Instead, no elements are written if vstart ≥ evl."
>>
>> The VSTART_CHECK_EARLY_EXIT in vext_ldst_whole function may causes unexpected result. We may replace the VSTART_CHECK_EARLY_EXIT function by
>>
>> - VSTART_CHECK_EARLY_EXIT(env); + if (env->vstart >= ((vlenb * nf) >> log2_esz)) { + env->vstart = 0; + return; + }
> 
> Do we need to do an early exit in this case? If the function is able to handle
> gracefully whatever env->vstart value it faces (it seems to be the case) then we
> should just remove the exit entirely.

Nevermind. Here's the guard that I am removing in the next patch for vext_lsdt_whole:

-    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);

If we just remove it and put nothing else in its place we'll end up breaking it.

To preserve the existing behavior we'll have to change the early exit to

if (vstart >= evl) {...}


'evl' is being calculated as

     uint32_t evl = s->cfg_ptr->vlenb * nf / width;


So yeah, your suggestion to exit the helper early with:

+ if (env->vstart >= ((vlenb * nf) >> log2_esz)) {
+     env->vstart = 0;
+     return;
+ }

Is correct. I'll change it in v15.


Thanks,


Daniel

> 
> In fact I removed all the early exits from all helpers that are guarded
> by vstart_eq_zero: vcpop_m(), vfirst_m(), vmsetm(), GEN_VEXT_VIOTA_M(),
> GEN_VEXT_VCOMPRESS_VM(), GEN_VEXT_RED() and GEN_VEXT_FRED(). For these case
> the helpers can either do nothing if vl = 0 or throw some exception like
> vcpop and first does.
> 
> 
> Thanks,
> 
> Daniel
> 
> 
> 
>>
>>> @@ -572,6 +580,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>>>       uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
>>>       uint32_t max_elems = vlenb >> log2_esz;
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       k = env->vstart / max_elems;
>>>       off = env->vstart % max_elems;
>>> @@ -877,6 +887,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>>       uint32_t vta = vext_vta(desc);                            \
>>>       uint32_t i;                                               \
>>>                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>>> +                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                      \
>>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>> @@ -909,6 +921,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>>>       uint32_t vta = vext_vta(desc);                                       \
>>>       uint32_t i;                                                          \
>>>                                                                            \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                        \
>>> +                                                                         \
>>>       for (i = env->vstart; i < vl; i++) {                                 \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
>>>           ETYPE carry = vext_elem_mask(v0, i);                             \
>>> @@ -944,6 +958,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>>       uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
>>>       uint32_t i;                                               \
>>>                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>>> +                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                      \
>>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>> @@ -982,6 +998,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
>>>       uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
>>>       uint32_t i;                                                 \
>>>                                                                   \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                               \
>>> +                                                                \
>>>       for (i = env->vstart; i < vl; i++) {                        \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
>>>           ETYPE carry = !vm && vext_elem_mask(v0, i);             \
>>> @@ -1078,6 +1096,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
>>>       uint32_t vma = vext_vma(desc);                                        \
>>>       uint32_t i;                                                           \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>>               /* set masked-off elements to 1s */                           \
>>> @@ -1125,6 +1145,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
>>>       uint32_t vma = vext_vma(desc);                          \
>>>       uint32_t i;                                             \
>>>                                                               \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                           \
>>> +                                                            \
>>>       for (i = env->vstart; i < vl; i++) {                    \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                \
>>>               /* set masked-off elements to 1s */             \
>>> @@ -1187,6 +1209,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>>       uint32_t vma = vext_vma(desc);                            \
>>>       uint32_t i;                                               \
>>>                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>>> +                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                      \
>>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>> @@ -1252,6 +1276,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
>>>       uint32_t vma = vext_vma(desc);                                  \
>>>       uint32_t i;                                                     \
>>>                                                                       \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
>>> +                                                                    \
>>>       for (i = env->vstart; i < vl; i++) {                            \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                        \
>>> @@ -1799,6 +1825,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
>>>       uint32_t vta = vext_vta(desc);                                   \
>>>       uint32_t i;                                                      \
>>>                                                                        \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>>> +                                                                     \
>>>       for (i = env->vstart; i < vl; i++) {                             \
>>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
>>>           *((ETYPE *)vd + H(i)) = s1;                                  \
>>> @@ -1823,6 +1851,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
>>>       uint32_t vta = vext_vta(desc);                                   \
>>>       uint32_t i;                                                      \
>>>                                                                        \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>>> +                                                                     \
>>>       for (i = env->vstart; i < vl; i++) {                             \
>>>           *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
>>>       }                                                                \
>>> @@ -1846,6 +1876,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
>>>       uint32_t vta = vext_vta(desc);                                   \
>>>       uint32_t i;                                                      \
>>>                                                                        \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>>> +                                                                     \
>>>       for (i = env->vstart; i < vl; i++) {                             \
>>>           ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
>>>           *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
>>> @@ -1870,6 +1902,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>>>       uint32_t vta = vext_vta(desc);                                   \
>>>       uint32_t i;                                                      \
>>>                                                                        \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
>>> +                                                                     \
>>>       for (i = env->vstart; i < vl; i++) {                             \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
>>>           ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
>>> @@ -1915,6 +1949,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
>>>                uint32_t vl, uint32_t vm, int vxrm,
>>>                opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>>>   {
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       for (uint32_t i = env->vstart; i < vl; i++) {
>>>           if (!vm && !vext_elem_mask(v0, i)) {
>>>               /* set masked-off elements to 1s */
>>> @@ -2040,6 +2076,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
>>>                uint32_t vl, uint32_t vm, int vxrm,
>>>                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
>>>   {
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       for (uint32_t i = env->vstart; i < vl; i++) {
>>>           if (!vm && !vext_elem_mask(v0, i)) {
>>>               /* set masked-off elements to 1s */
>>> @@ -2837,6 +2875,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>>       uint32_t vma = vext_vma(desc);                        \
>>>       uint32_t i;                                           \
>>>                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>>> +                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>>>               /* set masked-off elements to 1s */           \
>>> @@ -2880,6 +2920,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
>>>       uint32_t vma = vext_vma(desc);                        \
>>>       uint32_t i;                                           \
>>>                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>>> +                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>>>               /* set masked-off elements to 1s */           \
>>> @@ -3466,6 +3508,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>>>       uint32_t vma = vext_vma(desc);                     \
>>>       uint32_t i;                                        \
>>>                                                          \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                      \
>>> +                                                       \
>>>       if (vl == 0) {                                     \
>>>           return;                                        \
>>>       }                                                  \
>>> @@ -3987,6 +4031,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>>>       uint32_t vma = vext_vma(desc);                            \
>>>       uint32_t i;                                               \
>>>                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>>> +                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                      \
>>>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>> @@ -4027,6 +4073,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
>>>       uint32_t vma = vext_vma(desc);                                  \
>>>       uint32_t i;                                                     \
>>>                                                                       \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
>>> +                                                                    \
>>>       for (i = env->vstart; i < vl; i++) {                            \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                        \
>>> @@ -4220,6 +4268,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>>>       uint32_t vta = vext_vta(desc);                            \
>>>       uint32_t i;                                               \
>>>                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                             \
>>> +                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                      \
>>>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>>>           *((ETYPE *)vd + H(i)) =                               \
>>> @@ -4386,6 +4436,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>>       uint32_t i;                                           \
>>>       TD s1 =  *((TD *)vs1 + HD(0));                        \
>>>                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>>> +                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                  \
>>>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {              \
>>> @@ -4472,6 +4524,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>>>       uint32_t i;                                            \
>>>       TD s1 =  *((TD *)vs1 + HD(0));                         \
>>>                                                              \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                          \
>>> +                                                           \
>>>       for (i = env->vstart; i < vl; i++) {                   \
>>>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
>>>           if (!vm && !vext_elem_mask(v0, i)) {               \
>>> @@ -4544,6 +4598,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>>>       uint32_t i;                                           \
>>>       int a, b;                                             \
>>>                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                         \
>>> +                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                  \
>>>           a = vext_elem_mask(vs1, i);                       \
>>>           b = vext_elem_mask(vs2, i);                       \
>>> @@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
>>>       uint32_t vl = env->vl;
>>>       int i;
>>> +    if (env->vstart >= env->vl) {
>>> +        env->vstart = 0;
>>> +        return 0;
>>> +    }
>>> +
>>>       for (i = env->vstart; i < vl; i++) {
>>>           if (vm || vext_elem_mask(v0, i)) {
>>>               if (vext_elem_mask(vs2, i)) {
>>> @@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
>>>       uint32_t vl = env->vl;
>>>       int i;
>>> +    if (env->vstart >= env->vl) {
>>> +        env->vstart = 0;
>>> +        return 0;
>>> +    }
>>> +
>>>       for (i = env->vstart; i < vl; i++) {
>>>           if (vm || vext_elem_mask(v0, i)) {
>>>               if (vext_elem_mask(vs2, i)) {
>>> @@ -4632,6 +4698,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
>>>       int i;
>>>       bool first_mask_bit = false;
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       for (i = env->vstart; i < vl; i++) {
>>>           if (!vm && !vext_elem_mask(v0, i)) {
>>>               /* set masked-off elements to 1s */
>>> @@ -4704,6 +4772,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>>>       uint32_t sum = 0;                                                     \
>>>       int i;                                                                \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>>               /* set masked-off elements to 1s */                           \
>>> @@ -4737,6 +4807,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
>>>       uint32_t vma = vext_vma(desc);                                        \
>>>       int i;                                                                \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>>               /* set masked-off elements to 1s */                           \
>>> @@ -4772,6 +4844,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>>       uint32_t vma = vext_vma(desc);                                        \
>>>       target_ulong offset = s1, i_min, i;                                   \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       i_min = MAX(env->vstart, offset);                                     \
>>>       for (i = i_min; i < vl; i++) {                                        \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>> @@ -4805,6 +4879,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>>       uint32_t vma = vext_vma(desc);                                        \
>>>       target_ulong i_max, i_min, i;                                         \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
>>>       i_max = MAX(i_min, env->vstart);                                      \
>>>       for (i = env->vstart; i < i_max; ++i) {                               \
>>> @@ -4847,6 +4923,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>>>       uint32_t vma = vext_vma(desc);                                          \
>>>       uint32_t i;                                                             \
>>>                                                                               \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                           \
>>> +                                                                            \
>>>       for (i = env->vstart; i < vl; i++) {                                    \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                                \
>>>               /* set masked-off elements to 1s */                             \
>>> @@ -4896,6 +4974,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>>>       uint32_t vma = vext_vma(desc);                                            \
>>>       uint32_t i;                                                               \
>>>                                                                                 \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                             \
>>> +                                                                              \
>>>       for (i = env->vstart; i < vl; i++) {                                      \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                                  \
>>>               /* set masked-off elements to 1s */                               \
>>> @@ -4971,6 +5051,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>>>       uint64_t index;                                                       \
>>>       uint32_t i;                                                           \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>>               /* set masked-off elements to 1s */                           \
>>> @@ -5014,6 +5096,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>>>       uint64_t index = s1;                                                  \
>>>       uint32_t i;                                                           \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>>>               /* set masked-off elements to 1s */                           \
>>> @@ -5048,6 +5132,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>>>       uint32_t vta = vext_vta(desc);                                        \
>>>       uint32_t num = 0, i;                                                  \
>>>                                                                             \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
>>> +                                                                          \
>>>       for (i = env->vstart; i < vl; i++) {                                  \
>>>           if (!vext_elem_mask(vs1, i)) {                                    \
>>>               continue;                                                     \
>>> @@ -5100,6 +5186,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
>>>       uint32_t vma = vext_vma(desc);                               \
>>>       uint32_t i;                                                  \
>>>                                                                    \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                                \
>>> +                                                                 \
>>>       for (i = env->vstart; i < vl; i++) {                         \
>>>           if (!vm && !vext_elem_mask(v0, i)) {                     \
>>>               /* set masked-off elements to 1s */                  \
>>> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
>>> index 12f5964fbb..996c21eb31 100644
>>> --- a/target/riscv/vector_internals.c
>>> +++ b/target/riscv/vector_internals.c
>>> @@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
>>>       uint32_t vma = vext_vma(desc);
>>>       uint32_t i;
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       for (i = env->vstart; i < vl; i++) {
>>>           if (!vm && !vext_elem_mask(v0, i)) {
>>>               /* set masked-off elements to 1s */
>>> @@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
>>>       uint32_t vma = vext_vma(desc);
>>>       uint32_t i;
>>> +    VSTART_CHECK_EARLY_EXIT(env);
>>> +
>>>       for (i = env->vstart; i < vl; i++) {
>>>           if (!vm && !vext_elem_mask(v0, i)) {
>>>               /* set masked-off elements to 1s */
>>> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
>>> index 842765f6c1..9e1e15b575 100644
>>> --- a/target/riscv/vector_internals.h
>>> +++ b/target/riscv/vector_internals.h
>>> @@ -24,6 +24,13 @@
>>>   #include "tcg/tcg-gvec-desc.h"
>>>   #include "internals.h"
>>> +#define VSTART_CHECK_EARLY_EXIT(env) do { \
>>> +    if (env->vstart >= env->vl) {         \
>>> +        env->vstart = 0;                  \
>>> +        return;                           \
>>> +    }                                     \
>>> +} while (0)
>>> +
>>>   static inline uint32_t vext_nf(uint32_t desc)
>>>   {
>>>       return FIELD_EX32(simd_data(desc), VDATA, NF);
>>> @@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>>>       uint32_t vma = vext_vma(desc);                     \
>>>       uint32_t i;                                        \
>>>                                                          \
>>> +    VSTART_CHECK_EARLY_EXIT(env);                      \
>>> +                                                       \
>>>       for (i = env->vstart; i < vl; i++) {               \
>>>           if (!vm && !vext_elem_mask(v0, i)) {           \
>>>               /* set masked-off elements to 1s */        \


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E51C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 13:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkl05-0005S9-BC; Thu, 14 Mar 2024 09:20:01 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rkl03-0005Rl-1g
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:19:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rkkv7-0004T8-Jw
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 09:14:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e62c65865cso789597b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710422092; x=1711026892; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcrzNFDhKGSNILDRMBDyepl3/JA/z8jwxHsBNypKx/4=;
 b=T9DqxC7UTLj7mGuliU/7y4NYco05bWm1nxDn+GUNPbekaqSpEJTESbCfwQSRAS4l+L
 QpGF6DPpXvinvbOcCC8up8vslOc725AtKM8UXgSYpUdtxwMR9DIM+dBVmJYoNUzXxkQj
 qRwY0T1uK3ZaOMhTlsnnD9H61weuetnzhCs0Shp5odPZ77U0jb3/MfH4E092qW600yu8
 hd3uu+Vtz5b0PsBemT1bKS2v3osclgf+Kg9TagTleeBKbzRRLcXU5CaHYabGEIfoR0kv
 SjGpuDsfwOY33ik+B2p6hg0PpYuI++h4sbxxHibvlooQaWcSjHuaPf8HvR8EzXyOnWKp
 gL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710422092; x=1711026892;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YcrzNFDhKGSNILDRMBDyepl3/JA/z8jwxHsBNypKx/4=;
 b=KFTToYf50mzDcSJxgr8kdovb/7M47v8IzItSGAggPYbmxRPnnaeYZ8JAjl4gt3Bgbw
 0AMjNmxph7GpgsSh/cagzRjKrh/N9yRkh4gf/SGU4kn/r1fws5GtAkaJPoP1NaseJ8Dp
 0Jo4Avro1whYbTExIrLII+zgQGBiiVZFP4tEmmBaociwE3uSHQ2ySYSoOnjqGaFSgqXp
 3fp90PtTJ74PulkGUe7gllcljWD2+7wroe+c8pkoSEQKOejkR6KwPSUzZ/kTXl5+abMh
 8kH4+SVkW4ofo7OR/DjxtivTdPbS7jNnqf6puzYXwQjXK068pyM2X1EJOLZSyFNMhw6e
 0h7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHcvu8edgUZNWL6paAeH0ZlVUffJWzrrpGVpnHTQI9lG9599u7xXL7fRtCILK95vP65qYCCoaCgbJ3WGJnIkpoqKcdLY4=
X-Gm-Message-State: AOJu0YxbdfcTtKakHkFGq1EUJZUr/pl+o3n95xLTXWIfMjnWFHOMxGoM
 tzmz6FXcHwztoIQab6cY8qtb60HF2kZyOE34j9S8Gk0exd9yHqi8rf9xN1PhYvu+h5hUUHhMRrO
 iiiQ=
X-Google-Smtp-Source: AGHT+IE/xt+GrltFXJmG8fXAu5kR63SSxz9MG9HvwW4pDwiFu0soocGLtW8idQdHSfylBv4UO7QlSQ==
X-Received: by 2002:a05:6a00:3c8c:b0:6e5:d82b:83b9 with SMTP id
 lm12-20020a056a003c8c00b006e5d82b83b9mr1855451pfb.7.1710422091756; 
 Thu, 14 Mar 2024 06:14:51 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.240.175])
 by smtp.gmail.com with ESMTPSA id
 fn24-20020a056a002fd800b006e6b415b405sm1422854pfb.36.2024.03.14.06.14.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 06:14:51 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------5l0CvRDT9x8UWXb20tvyTdFi"
Message-ID: <eb716a53-fe06-4df0-96cb-7428ec6639bc@sifive.com>
Date: Thu, 14 Mar 2024 21:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early
 exit when vstart >= vl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-5-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20240313220141.427730-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------5l0CvRDT9x8UWXb20tvyTdFi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

According v spec section 7.9. Vector Load/Store Whole Register Instructions

"The instructions operate with an effective vector length, 
evl=NFIELDS*VLEN/EEW, regardless of current settings in vtype and vl. 
The usual property that no elements are written if vstart ≥ vl does not 
apply to these instructions. Instead, no elements are written if vstart 
≥ evl."

The VSTART_CHECK_EARLY_EXIT in vext_ldst_whole function may causes 
unexpected result. We may replace the VSTART_CHECK_EARLY_EXIT function by

- VSTART_CHECK_EARLY_EXIT(env); + if (env->vstart >= ((vlenb * nf) >> 
log2_esz)) { + env->vstart = 0; + return; + }

> @@ -572,6 +580,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>       uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
>       uint32_t max_elems = vlenb >> log2_esz;
>   
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       k = env->vstart / max_elems;
>       off = env->vstart % max_elems;
>   
> @@ -877,6 +887,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>       uint32_t vta = vext_vta(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>       for (i = env->vstart; i < vl; i++) {                      \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> @@ -909,6 +921,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
>       uint32_t vta = vext_vta(desc);                                       \
>       uint32_t i;                                                          \
>                                                                            \
> +    VSTART_CHECK_EARLY_EXIT(env);                                        \
> +                                                                         \
>       for (i = env->vstart; i < vl; i++) {                                 \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
>           ETYPE carry = vext_elem_mask(v0, i);                             \
> @@ -944,6 +958,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>       uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
>       uint32_t i;                                               \
>                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>       for (i = env->vstart; i < vl; i++) {                      \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> @@ -982,6 +998,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
>       uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
>       uint32_t i;                                                 \
>                                                                   \
> +    VSTART_CHECK_EARLY_EXIT(env);                               \
> +                                                                \
>       for (i = env->vstart; i < vl; i++) {                        \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
>           ETYPE carry = !vm && vext_elem_mask(v0, i);             \
> @@ -1078,6 +1096,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
>       uint32_t vma = vext_vma(desc);                                        \
>       uint32_t i;                                                           \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -1125,6 +1145,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
>       uint32_t vma = vext_vma(desc);                          \
>       uint32_t i;                                             \
>                                                               \
> +    VSTART_CHECK_EARLY_EXIT(env);                           \
> +                                                            \
>       for (i = env->vstart; i < vl; i++) {                    \
>           if (!vm && !vext_elem_mask(v0, i)) {                \
>               /* set masked-off elements to 1s */             \
> @@ -1187,6 +1209,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>       uint32_t vma = vext_vma(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>       for (i = env->vstart; i < vl; i++) {                      \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> @@ -1252,6 +1276,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
>       uint32_t vma = vext_vma(desc);                                  \
>       uint32_t i;                                                     \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
> +                                                                    \
>       for (i = env->vstart; i < vl; i++) {                            \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>           if (!vm && !vext_elem_mask(v0, i)) {                        \
> @@ -1799,6 +1825,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
>       uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
>           *((ETYPE *)vd + H(i)) = s1;                                  \
> @@ -1823,6 +1851,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
>       uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>       for (i = env->vstart; i < vl; i++) {                             \
>           *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
>       }                                                                \
> @@ -1846,6 +1876,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
>       uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
>           *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
> @@ -1870,6 +1902,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
>       uint32_t vta = vext_vta(desc);                                   \
>       uint32_t i;                                                      \
>                                                                        \
> +    VSTART_CHECK_EARLY_EXIT(env);                                    \
> +                                                                     \
>       for (i = env->vstart; i < vl; i++) {                             \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
>           ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
> @@ -1915,6 +1949,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
>                uint32_t vl, uint32_t vm, int vxrm,
>                opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
>   {
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       for (uint32_t i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -2040,6 +2076,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
>                uint32_t vl, uint32_t vm, int vxrm,
>                opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
>   {
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       for (uint32_t i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -2837,6 +2875,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t vma = vext_vma(desc);                        \
>       uint32_t i;                                           \
>                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>       for (i = env->vstart; i < vl; i++) {                  \
>           if (!vm && !vext_elem_mask(v0, i)) {              \
>               /* set masked-off elements to 1s */           \
> @@ -2880,6 +2920,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
>       uint32_t vma = vext_vma(desc);                        \
>       uint32_t i;                                           \
>                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>       for (i = env->vstart; i < vl; i++) {                  \
>           if (!vm && !vext_elem_mask(v0, i)) {              \
>               /* set masked-off elements to 1s */           \
> @@ -3466,6 +3508,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>       uint32_t vma = vext_vma(desc);                     \
>       uint32_t i;                                        \
>                                                          \
> +    VSTART_CHECK_EARLY_EXIT(env);                      \
> +                                                       \
>       if (vl == 0) {                                     \
>           return;                                        \
>       }                                                  \
> @@ -3987,6 +4031,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
>       uint32_t vma = vext_vma(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>       for (i = env->vstart; i < vl; i++) {                      \
>           ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
> @@ -4027,6 +4073,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
>       uint32_t vma = vext_vma(desc);                                  \
>       uint32_t i;                                                     \
>                                                                       \
> +    VSTART_CHECK_EARLY_EXIT(env);                                   \
> +                                                                    \
>       for (i = env->vstart; i < vl; i++) {                            \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
>           if (!vm && !vext_elem_mask(v0, i)) {                        \
> @@ -4220,6 +4268,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
>       uint32_t vta = vext_vta(desc);                            \
>       uint32_t i;                                               \
>                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                             \
> +                                                              \
>       for (i = env->vstart; i < vl; i++) {                      \
>           ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
>           *((ETYPE *)vd + H(i)) =                               \
> @@ -4386,6 +4436,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t i;                                           \
>       TD s1 =  *((TD *)vs1 + HD(0));                        \
>                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>       for (i = env->vstart; i < vl; i++) {                  \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
>           if (!vm && !vext_elem_mask(v0, i)) {              \
> @@ -4472,6 +4524,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
>       uint32_t i;                                            \
>       TD s1 =  *((TD *)vs1 + HD(0));                         \
>                                                              \
> +    VSTART_CHECK_EARLY_EXIT(env);                          \
> +                                                           \
>       for (i = env->vstart; i < vl; i++) {                   \
>           TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
>           if (!vm && !vext_elem_mask(v0, i)) {               \
> @@ -4544,6 +4598,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>       uint32_t i;                                           \
>       int a, b;                                             \
>                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                         \
> +                                                          \
>       for (i = env->vstart; i < vl; i++) {                  \
>           a = vext_elem_mask(vs1, i);                       \
>           b = vext_elem_mask(vs2, i);                       \
> @@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
>       uint32_t vl = env->vl;
>       int i;
>   
> +    if (env->vstart >= env->vl) {
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (vm || vext_elem_mask(v0, i)) {
>               if (vext_elem_mask(vs2, i)) {
> @@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
>       uint32_t vl = env->vl;
>       int i;
>   
> +    if (env->vstart >= env->vl) {
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (vm || vext_elem_mask(v0, i)) {
>               if (vext_elem_mask(vs2, i)) {
> @@ -4632,6 +4698,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
>       int i;
>       bool first_mask_bit = false;
>   
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -4704,6 +4772,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
>       uint32_t sum = 0;                                                     \
>       int i;                                                                \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -4737,6 +4807,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
>       uint32_t vma = vext_vma(desc);                                        \
>       int i;                                                                \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -4772,6 +4844,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t vma = vext_vma(desc);                                        \
>       target_ulong offset = s1, i_min, i;                                   \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       i_min = MAX(env->vstart, offset);                                     \
>       for (i = i_min; i < vl; i++) {                                        \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
> @@ -4805,6 +4879,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint32_t vma = vext_vma(desc);                                        \
>       target_ulong i_max, i_min, i;                                         \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       i_min = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
>       i_max = MAX(i_min, env->vstart);                                      \
>       for (i = env->vstart; i < i_max; ++i) {                               \
> @@ -4847,6 +4923,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>       uint32_t vma = vext_vma(desc);                                          \
>       uint32_t i;                                                             \
>                                                                               \
> +    VSTART_CHECK_EARLY_EXIT(env);                                           \
> +                                                                            \
>       for (i = env->vstart; i < vl; i++) {                                    \
>           if (!vm && !vext_elem_mask(v0, i)) {                                \
>               /* set masked-off elements to 1s */                             \
> @@ -4896,6 +4974,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
>       uint32_t vma = vext_vma(desc);                                            \
>       uint32_t i;                                                               \
>                                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env);                                             \
> +                                                                              \
>       for (i = env->vstart; i < vl; i++) {                                      \
>           if (!vm && !vext_elem_mask(v0, i)) {                                  \
>               /* set masked-off elements to 1s */                               \
> @@ -4971,6 +5051,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       uint64_t index;                                                       \
>       uint32_t i;                                                           \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -5014,6 +5096,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>       uint64_t index = s1;                                                  \
>       uint32_t i;                                                           \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vm && !vext_elem_mask(v0, i)) {                              \
>               /* set masked-off elements to 1s */                           \
> @@ -5048,6 +5132,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
>       uint32_t vta = vext_vta(desc);                                        \
>       uint32_t num = 0, i;                                                  \
>                                                                             \
> +    VSTART_CHECK_EARLY_EXIT(env);                                         \
> +                                                                          \
>       for (i = env->vstart; i < vl; i++) {                                  \
>           if (!vext_elem_mask(vs1, i)) {                                    \
>               continue;                                                     \
> @@ -5100,6 +5186,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
>       uint32_t vma = vext_vma(desc);                               \
>       uint32_t i;                                                  \
>                                                                    \
> +    VSTART_CHECK_EARLY_EXIT(env);                                \
> +                                                                 \
>       for (i = env->vstart; i < vl; i++) {                         \
>           if (!vm && !vext_elem_mask(v0, i)) {                     \
>               /* set masked-off elements to 1s */                  \
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 12f5964fbb..996c21eb31 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
>       uint32_t vma = vext_vma(desc);
>       uint32_t i;
>   
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> @@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
>       uint32_t vma = vext_vma(desc);
>       uint32_t i;
>   
> +    VSTART_CHECK_EARLY_EXIT(env);
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (!vm && !vext_elem_mask(v0, i)) {
>               /* set masked-off elements to 1s */
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
> index 842765f6c1..9e1e15b575 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -24,6 +24,13 @@
>   #include "tcg/tcg-gvec-desc.h"
>   #include "internals.h"
>   
> +#define VSTART_CHECK_EARLY_EXIT(env) do { \
> +    if (env->vstart >= env->vl) {         \
> +        env->vstart = 0;                  \
> +        return;                           \
> +    }                                     \
> +} while (0)
> +
>   static inline uint32_t vext_nf(uint32_t desc)
>   {
>       return FIELD_EX32(simd_data(desc), VDATA, NF);
> @@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
>       uint32_t vma = vext_vma(desc);                     \
>       uint32_t i;                                        \
>                                                          \
> +    VSTART_CHECK_EARLY_EXIT(env);                      \
> +                                                       \
>       for (i = env->vstart; i < vl; i++) {               \
>           if (!vm && !vext_elem_mask(v0, i)) {           \
>               /* set masked-off elements to 1s */        \
--------------5l0CvRDT9x8UWXb20tvyTdFi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="monospace">According v spec section 7.9. Vector
        Load/Store Whole Register Instructions<span
        style="white-space: pre-wrap">
</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">"The instructions operate with an effective vector length, evl=NFIELDS*VLEN/EEW, regardless of current settings in vtype and vl.
 The usual property that no elements are written if vstart ≥ vl does not apply to these instructions.
 Instead, no elements are written if vstart ≥ evl."</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">The VSTART_CHECK_EARLY_EXIT in vext_ldst_whole function may causes unexpected result.
We may replace the VSTART_CHECK_EARLY_EXIT function by</span></font></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">-    VSTART_CHECK_EARLY_EXIT(env);
+    if (env-&gt;vstart &gt;= ((vlenb * nf) &gt;&gt; log2_esz)) {
+        env-&gt;vstart = 0;
+        return;
+    }    </font>
</span></p>
    <blockquote type="cite"
      cite="mid:20240313220141.427730-5-dbarboza@ventanamicro.com">
      <pre class="moz-quote-pre" wrap="">@@ -572,6 +580,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t vlenb = riscv_cpu_cfg(env)-&gt;vlenb;
     uint32_t max_elems = vlenb &gt;&gt; log2_esz;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     k = env-&gt;vstart / max_elems;
     off = env-&gt;vstart % max_elems;
 
@@ -877,6 +887,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -909,6 +921,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
     uint32_t vta = vext_vta(desc);                                       \
     uint32_t i;                                                          \
                                                                          \
+    VSTART_CHECK_EARLY_EXIT(env);                                        \
+                                                                         \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                 \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
         ETYPE carry = vext_elem_mask(v0, i);                             \
@@ -944,6 +958,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -982,6 +998,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                \
     uint32_t i;                                                 \
                                                                 \
+    VSTART_CHECK_EARLY_EXIT(env);                               \
+                                                                \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                        \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
         ETYPE carry = !vm &amp;&amp; vext_elem_mask(v0, i);             \
@@ -1078,6 +1096,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t vma = vext_vma(desc);                                        \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -1125,6 +1145,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,      \
     uint32_t vma = vext_vma(desc);                          \
     uint32_t i;                                             \
                                                             \
+    VSTART_CHECK_EARLY_EXIT(env);                           \
+                                                            \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                    \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                \
             /* set masked-off elements to 1s */             \
@@ -1187,6 +1209,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -1252,6 +1276,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                   \
+                                                                    \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                        \
@@ -1799,6 +1825,8 @@ void HELPER(NAME)(void *vd, void *vs1, CPURISCVState *env,           \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                             \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                           \
         *((ETYPE *)vd + H(i)) = s1;                                  \
@@ -1823,6 +1851,8 @@ void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,         \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                             \
         *((ETYPE *)vd + H(i)) = (ETYPE)s1;                           \
     }                                                                \
@@ -1846,6 +1876,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                             \
         ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
@@ -1870,6 +1902,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
     uint32_t vta = vext_vta(desc);                                   \
     uint32_t i;                                                      \
                                                                      \
+    VSTART_CHECK_EARLY_EXIT(env);                                    \
+                                                                     \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                             \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
         ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
@@ -1915,6 +1949,8 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env-&gt;vstart; i &lt; vl; i++) {
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2040,6 +2076,8 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (uint32_t i = env-&gt;vstart; i &lt; vl; i++) {
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2837,6 +2875,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
@@ -2880,6 +2920,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
     uint32_t vma = vext_vma(desc);                        \
     uint32_t i;                                           \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {              \
             /* set masked-off elements to 1s */           \
@@ -3466,6 +3508,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+                                                       \
     if (vl == 0) {                                     \
         return;                                        \
     }                                                  \
@@ -3987,6 +4031,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                      \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
@@ -4027,6 +4073,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
+    VSTART_CHECK_EARLY_EXIT(env);                                   \
+                                                                    \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                            \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                        \
@@ -4220,6 +4268,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     uint32_t vta = vext_vta(desc);                            \
     uint32_t i;                                               \
                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                             \
+                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         *((ETYPE *)vd + H(i)) =                               \
@@ -4386,6 +4436,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                  \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {              \
@@ -4472,6 +4524,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
+    VSTART_CHECK_EARLY_EXIT(env);                          \
+                                                           \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {               \
@@ -4544,6 +4598,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                         \
+                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
         b = vext_elem_mask(vs2, i);                       \
@@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env-&gt;vl;
     int i;
 
+    if (env-&gt;vstart &gt;= env-&gt;vl) {
+        env-&gt;vstart = 0;
+        return 0;
+    }
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
@@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env-&gt;vl;
     int i;
 
+    if (env-&gt;vstart &gt;= env-&gt;vl) {
+        env-&gt;vstart = 0;
+        return 0;
+    }
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {
@@ -4632,6 +4698,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     int i;
     bool first_mask_bit = false;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -4704,6 +4772,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -4737,6 +4807,8 @@ void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
     uint32_t vma = vext_vma(desc);                                        \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -4772,6 +4844,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong offset = s1, i_min, i;                                   \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     i_min = MAX(env-&gt;vstart, offset);                                     \
     for (i = i_min; i &lt; vl; i++) {                                        \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
@@ -4805,6 +4879,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint32_t vma = vext_vma(desc);                                        \
     target_ulong i_max, i_min, i;                                         \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     i_min = MIN(s1 &lt; vlmax ? vlmax - s1 : 0, vl);                         \
     i_max = MAX(i_min, env-&gt;vstart);                                      \
     for (i = env-&gt;vstart; i &lt; i_max; ++i) {                               \
@@ -4847,6 +4923,8 @@ static void vslide1up_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                          \
     uint32_t i;                                                             \
                                                                             \
+    VSTART_CHECK_EARLY_EXIT(env);                                           \
+                                                                            \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                    \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                                \
             /* set masked-off elements to 1s */                             \
@@ -4896,6 +4974,8 @@ static void vslide1down_##BITWIDTH(void *vd, void *v0, uint64_t s1,           \
     uint32_t vma = vext_vma(desc);                                            \
     uint32_t i;                                                               \
                                                                               \
+    VSTART_CHECK_EARLY_EXIT(env);                                             \
+                                                                              \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                      \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                                  \
             /* set masked-off elements to 1s */                               \
@@ -4971,6 +5051,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint64_t index;                                                       \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5014,6 +5096,8 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     uint64_t index = s1;                                                  \
     uint32_t i;                                                           \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5048,6 +5132,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t num = 0, i;                                                  \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env);                                         \
+                                                                          \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                                  \
         if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
@@ -5100,6 +5186,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
     uint32_t vma = vext_vma(desc);                               \
     uint32_t i;                                                  \
                                                                  \
+    VSTART_CHECK_EARLY_EXIT(env);                                \
+                                                                 \
     for (i = env-&gt;vstart; i &lt; vl; i++) {                         \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {                     \
             /* set masked-off elements to 1s */                  \
diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 12f5964fbb..996c21eb31 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -44,6 +44,8 @@ void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -68,6 +70,8 @@ void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vma = vext_vma(desc);
     uint32_t i;
 
+    VSTART_CHECK_EARLY_EXIT(env);
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 842765f6c1..9e1e15b575 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -24,6 +24,13 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 
+#define VSTART_CHECK_EARLY_EXIT(env) do { \
+    if (env-&gt;vstart &gt;= env-&gt;vl) {         \
+        env-&gt;vstart = 0;                  \
+        return;                           \
+    }                                     \
+} while (0)
+
 static inline uint32_t vext_nf(uint32_t desc)
 {
     return FIELD_EX32(simd_data(desc), VDATA, NF);
@@ -151,6 +158,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
     uint32_t vma = vext_vma(desc);                     \
     uint32_t i;                                        \
                                                        \
+    VSTART_CHECK_EARLY_EXIT(env);                      \
+                                                       \
     for (i = env-&gt;vstart; i &lt; vl; i++) {               \
         if (!vm &amp;&amp; !vext_elem_mask(v0, i)) {           \
             /* set masked-off elements to 1s */        \
</pre>
    </blockquote>
  </body>
</html>

--------------5l0CvRDT9x8UWXb20tvyTdFi--


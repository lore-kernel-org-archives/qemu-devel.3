Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2E1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfGe-0006Sj-KE; Thu, 13 Mar 2025 05:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfGa-0006SH-4L
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:54:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfGY-0006wK-2H
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:54:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so6007035e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741859650; x=1742464450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oHqU8RjxewFiNxjqPyRf41dTIb+QssiyOfMTnQW8P8Y=;
 b=N2hZbO35HDBxQeG7byXKGk2UA2lrF7ljrZ0O7Q1hrvqSpV6UGl54OJjPbtXjllOeN/
 iC0WtLVPmXcdRVanv2HX0u7XOj1CWnL9fmviafpu6w5ub8mPVzfckBVBTTS1Ihj8iKro
 orVUBdeUVAgFBjXHQsobs8ygbDJv8f2TK2MnBcG34S1EIp5Zd5UYOjKnECr+H3YgLGni
 dXsJifliMX0Uml0qXd/BkeM4jYBJey1sRoADpnKJnl+SacddEyy/RytJcDBYbv6rFXCT
 4V0mZKE+D1jsOKlec3sPYvSA2y2XGUH3AfKS0sXwxZtii8mOog9PukxMnuw5w/F4q7mK
 c1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741859650; x=1742464450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHqU8RjxewFiNxjqPyRf41dTIb+QssiyOfMTnQW8P8Y=;
 b=Rcmb6ItMAOj7X/jrfR+YJ0aOohE/koIynRADsFM2jWF1bMgSuMp2YeyEIKO8uTsb1g
 UkVlOr0Os5tnkPsA+yA+Z37EDE2oSwloOf7lMRYcRoOFQpGpDXAidWf7WGKE8+youVYE
 BVG5QU+sYcL6G+0u1jXybkxNz29NvKuZOvbcM4udBTieCgLXhNtKpYuwrhc7iw908gBL
 /sZ55e7+X1Oq7DKuAOB4cM+oD17S8Zh3NNCNJTgcvn9g9RrxkfS2Z43KZ/T2vClIHdlI
 FEyAbYitI8e7XRn3SuGO+XR3l9+AOoqcKkocKCuIj7fOfVkVHPWfj9LaYCKWvjzjKV5j
 tS6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfZ+HMj/4+grpfm7SI7bM0QptDHnXryryhppI6fBrG5Y8EL9avTDlV5MO3MDDv3C33XaIdNhN+d72/@nongnu.org
X-Gm-Message-State: AOJu0YzbwzIEzz2bm5SORS5jk5GH25d2cEiMewlu3Hzm4lIjZLwMmiyt
 DQNbHN166PMYNiIDBbmSOBdLVVvFYyZpE4o1znE5rWx6V8hLBrfgK4/RJmj7XYw=
X-Gm-Gg: ASbGncu7YDOgky5Mr2Ly1NUm6ZHwgIQBUC0J8PnUf2+ynF7AX5yzvQnaEPCtB0zvv1l
 /ajtatvtRPVGTEgI+B9Sd23OLqDBVjXF/xZUUJyXfvvzeOttcNAoUiEzGpTcWfJnvS1lpe2SBgp
 Hrowg5W8YkHjvRMtNUDuOJnG0BRtTv+YyfdgMZth+mVkuAq3wupuQ/x7SsdBqXPUI32P+RNMfqV
 TxiRa+xyu2wEyQxlhb9mUhMnb9siQ6dk/aJzg25N9UdEi1tOP7z7B8pP4Z1YxolJGuY2teTuZvr
 rwCgi23bp7ZI2+hxEq9XML98bcUx5gwm5dR3DsVQVfkMF5aKMc/2M3Aav4Vhb2xarpI6kpzHj0z
 yf8NtLukg/A==
X-Google-Smtp-Source: AGHT+IECLAvFtEiv6KjO/Zlh/iCUxbFrpbQ52hcJoYY1hOiveEhRmEE5pGZBUW0Ycyg1sdWBbUM45w==
X-Received: by 2002:a05:600c:1d1a:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-43ce70d4664mr144155275e9.19.1741859649902; 
 Thu, 13 Mar 2025 02:54:09 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm1544358f8f.73.2025.03.13.02.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:54:09 -0700 (PDT)
Message-ID: <d36bc719-555c-486e-a4c4-a0e00702eefc@linaro.org>
Date: Thu, 13 Mar 2025 10:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/37] accel/tcg: Use cpu_ld*_code_mmu in translator.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Richard,

On 13/3/25 04:44, Richard Henderson wrote:
> Cache the mmu index in DisasContextBase.
> Perform the read on host endianness, which lets us
> share code with the translator_ld fast path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h |  1 +
>   accel/tcg/translator.c    | 57 ++++++++++++++++++---------------------
>   2 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index d70942a10f..205dd85bba 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -73,6 +73,7 @@ struct DisasContextBase {
>       int max_insns;
>       bool plugin_enabled;
>       bool fake_insn;
> +    uint8_t code_mmuidx;
>       struct TCGOp *insn_start;
>       void *host_addr[2];
>   
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 0260fb1915..64fa069b51 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -11,10 +11,9 @@
>   #include "qemu/log.h"
>   #include "qemu/error-report.h"
>   #include "exec/exec-all.h"
> +#include "exec/cpu-ldst-common.h"
>   #include "exec/translator.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/plugin-gen.h"
> -#include "exec/cpu_ldst.h"
>   #include "exec/tswap.h"
>   #include "tcg/tcg-op-common.h"
>   #include "internal-target.h"
> @@ -142,6 +141,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
>       db->host_addr[1] = NULL;
>       db->record_start = 0;
>       db->record_len = 0;
> +    db->code_mmuidx = cpu_mmu_index(cpu, true);
>   
>       ops->init_disas_context(db, cpu);
>       tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
> @@ -457,55 +457,50 @@ bool translator_st(const DisasContextBase *db, void *dest,
>   
>   uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint8_t raw;
> +    uint8_t val;
>   
> -    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        raw = cpu_ldub_code(env, pc);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UB, db->code_mmuidx);
> +        val = cpu_ldb_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return raw;
> +    return val;
>   }
>   
>   uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint16_t raw, tgt;
> +    uint16_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap16(raw);
> -    } else {
> -        tgt = cpu_lduw_code(env, pc);
> -        raw = tswap16(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UW, db->code_mmuidx);

Could we pass MO_TE rather than calling tswap()?

> +        val = cpu_ldw_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));

So recorded bytes are in host endianness, is it still OK w.r.t.
translator_st() use?

>       }
> -    return tgt;
> +    return tswap16(val);
>   }
>   
>   uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint32_t raw, tgt;
> +    uint32_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap32(raw);
> -    } else {
> -        tgt = cpu_ldl_code(env, pc);
> -        raw = tswap32(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
> +        val = cpu_ldl_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap32(val);
>   }
>   
>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> -    uint64_t raw, tgt;
> +    uint64_t val;
>   
> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
> -        tgt = tswap64(raw);
> -    } else {
> -        tgt = cpu_ldq_code(env, pc);
> -        raw = tswap64(tgt);
> -        record_save(db, pc, &raw, sizeof(raw));
> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
> +        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
> +        val = cpu_ldq_code_mmu(env, pc, oi, 0);
> +        record_save(db, pc, &val, sizeof(val));
>       }
> -    return tgt;
> +    return tswap64(val);
>   }
>   
>   void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)



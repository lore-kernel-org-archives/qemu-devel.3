Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A32DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9t8-0005w3-IL; Wed, 14 Aug 2024 05:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se9t3-0005qX-Js
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:01:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se9t2-0008TN-0g
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:01:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso61506395ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723626100; x=1724230900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPy2JHM1tbG6p1gt/0qA1Cv/ek4s+eznM+OJu+Bdyzk=;
 b=TBWvzCDs+Z0UY7BwYUMkgowv6AA+b2nDXR/tmjg7qATQXIBwYx0WY2TcnFAAGkaobZ
 VqtTV8/etOw2NwXL1HoUt9PiNIkJlhRcWQyKCjqpqxAHjvD1LnSUjfx+pLhgwKD6euyh
 TzYYJeDCV27praVYK3x/gwoMFEaCjBqflyiB7NkPXSROgYP2WGnjJogSBYXr3wXhmSn4
 GPVIjBaSMR3UxvFS6zZ6qiX3wOZYPnEXEpTp6lUh9mkKfXXIBw6TWLdFIVfAPTXS9fDO
 XCoVmdYiwb2ay3OGfJ3Y36WtXpBV17Ev5vDwZe6G2ukxjwe0QKo7VM/WdMLAQ2sr4E7H
 XDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723626100; x=1724230900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPy2JHM1tbG6p1gt/0qA1Cv/ek4s+eznM+OJu+Bdyzk=;
 b=u5KkiFR9JT393xeJ3ZoRH2DSg3I5qa21iJ5vMhVb9KN5bniu6VamMla8NKvn+6cZiw
 VxTTTi0+cQkU3l3BImmexpVHk46Rwka8wJuHk8GWc9o4zOV4WcA1mLz1jnTXwcAO/Hz7
 5fTyNtXy3pObuf6KtN9ThLhas8x6J4aw9vh6osqMDH0QFSj3cLzYB3S9iAQgHPhoXW9X
 1SK+A1irCHsc5H7YNIGclDMHj3tuCWx65fT2SA6KTr4D1GtWvYGD+locUL5HXvRMnFnM
 YUuZ6QynvFrCaxnaTHpctjCYC3n0JrfV4gOrXYBwjEjjYz1FmeDNx+f6ldQXqquAGm1R
 WdWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb266DjYhJFMXXEFLbIUdBIpKfO28ejcPNgcf4qJDbbFNuInlgw2cjLC1xksyAEuRk+VNOyab6R/MV6qwMrhAjMwsCcm8=
X-Gm-Message-State: AOJu0Yw24xWGbI+LE3oimrAk3UuxB2QLSeqM+54G+tWS6zH7mJO9B2Qi
 PyvSrEk8dRXZ/HrBP963lx1auZ0spwaW7px+dJw8gC333KEo1S9GwNdP4QXtHfc=
X-Google-Smtp-Source: AGHT+IH+XFjX1rLMlMnJwG3ECMmLjtHIQViEquRc8j98h4NmIiLwUIWhIvLm4DNibdFszEos+b2eJw==
X-Received: by 2002:a17:902:cf0b:b0:1fd:664b:224 with SMTP id
 d9443c01a7336-201d64d0260mr23480555ad.56.1723626100370; 
 Wed, 14 Aug 2024 02:01:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201e64ffb2dsm16915ad.29.2024.08.14.02.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:01:39 -0700 (PDT)
Message-ID: <2ecd1ccc-ce2b-4432-a2a1-9af2dc70f037@linaro.org>
Date: Wed, 14 Aug 2024 19:01:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/15] tcg/riscv: Implement vector load/store
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-7-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-7-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> @@ -827,14 +850,59 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
>   static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
>                          TCGReg arg1, intptr_t arg2)
>   {
> -    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
> +    RISCVInsn insn;
> +
> +    if (type < TCG_TYPE_V64) {
> +        insn = type == TCG_TYPE_I32 ? OPC_LW : OPC_LD;
> +    } else {
> +        tcg_debug_assert(arg >= TCG_REG_V1);
> +        switch (prev_vece) {
> +        case MO_8:
> +            insn = OPC_VLE8_V;
> +            break;
> +        case MO_16:
> +            insn = OPC_VLE16_V;
> +            break;
> +        case MO_32:
> +            insn = OPC_VLE32_V;
> +            break;
> +        case MO_64:
> +            insn = OPC_VLE64_V;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
>       tcg_out_ldst(s, insn, arg, arg1, arg2);

tcg_out_ld/st are called directly from register allocation spill/fill.
You'll need to set vtype here, and cannot rely on this having been done in tcg_out_vec_op.

That said, with a little-endian host, the selected element size doesn't matter *too* much. 
  A write of 8 uint16_t or a write of 2 uint64_t produces the same bits in memory.

Therefore you can examine prev_vtype and adjust only if the vector length changes.  But we 
do that -- e.g. load V256, store V256, store V128 to perform a 384-bit store for AArch64 
SVE when VQ=3.

Is there an advantage to using the vector load/store whole register insns, if the 
requested length is not too small?  IIRC the NF field can be used to store multiples, but 
we can't store half of a register with these.


r~


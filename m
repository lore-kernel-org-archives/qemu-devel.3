Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C9CEE57D7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 22:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soWHI-0002IN-2T; Wed, 11 Sep 2024 18:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soWHE-0002AT-4k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 18:57:32 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soWHB-0000a7-Hj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 18:57:31 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so268405a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726095447; x=1726700247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hms1SAkIOfWAL3J7k1Qd/XA716SP78WuWlBwClCoQF0=;
 b=Sl2CmR9od4ui7NuUyAmHNIDgc7vn3dZHLf237lYkNo1K8TG1lxYr2wiouLsbGJL9cT
 kLKCCTjE0QmdvxKJXQsV23+0VUIZFO8hIU7Eqa1XOR9MhD7D2uZfLdNl9YLbUVKdBG0T
 jNA0SAMu34vk+nsObmotjfzSnBaj+viCBz1H7jDy3Je/1DJ3ITtyPs9IMhPuv3QMy9v8
 l318KN8yLUbR0sA1+AGcBG84PsPOjzYZFujjB9Yw4J2Ewe1GDxzCUj7q32G84KR/7wAU
 59BeQNLMBcAemPa5C8ez9p54Wy7lOMPf/IshsUqcuJ64h1ADQ0NLg8OCECfZ+vTKpDAj
 attA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726095447; x=1726700247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hms1SAkIOfWAL3J7k1Qd/XA716SP78WuWlBwClCoQF0=;
 b=cEVuys2uw/XwDG5zWttXKAsrIBj/DlRvxoQAmkKUq+lyLI25bH/lNOM4vwIUw3lQdr
 ai/BylnFyuDJye0TTe6DgKn98XxYRGbIe+SdPk00hikkXYIs/tdRGUEeWGxrv4EuLNOa
 hmuPiwQLJqiN64RUGIzKF9QVgxOnO2E6d9k8al4Fg+HVLWoNBiu2g8HI3byNisdypC85
 rfDQnxh+b4cQdpnJuW7cfYXySxfGpf6wdQcEVHUOIujH9Zq8l8f9RRibkIQ9NtMQB5dq
 ufnBPGUqWPlBslmUfE/NOeuK41bDoVKExB8lWL4N7rqLwAsglMYkwO0GbtNF2queiLcj
 saAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyZwjugHmh/zeQPGOUNQv7TvqUEi1EfVEzM91KvolfQLs3G3Bg2NZYEdRnljfBdzLW30suxSzaQYGE@nongnu.org
X-Gm-Message-State: AOJu0Yybp+5GmH2gvwO+7nhwZBcONpokCwtJ2IIkPGYRs6FxNOJ5j9m3
 AVJjF2EWaMZYdlO2xhjcWKXYkgBKhscYvRtjFogvPm7YNRGVsd+JATEFTW6YFKM=
X-Google-Smtp-Source: AGHT+IHG97dCvxrQjESY6tJziTZ1kuLf5bn8oUS7owMM6k5wboHvjR2wdM52x/LYdBI2FOmvtUNa7A==
X-Received: by 2002:a05:6a21:e88:b0:1cf:4d4e:532b with SMTP id
 adf61e73a8af0-1cf76249ff0mr852803637.43.1726095447092; 
 Wed, 11 Sep 2024 15:57:27 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fbc0992sm504315a12.51.2024.09.11.15.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 15:57:26 -0700 (PDT)
Message-ID: <2f24a36d-8910-4eeb-9d4f-ff2c96dc41ba@linaro.org>
Date: Wed, 11 Sep 2024 15:57:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240911132630.461-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 9/11/24 06:26, LIU Zhiwei wrote:
> +static bool lmul_check(int lmul, MemOp vsew)
> +{
> +    /*
> +     * For a given supported fractional LMUL setting, implementations must
> +     * support SEW settings between SEW_MIN and LMUL * ELEN, inclusive.
> +     * So if ELEN = 64, LMUL = 1/2, then SEW will support e8, e16, e32,
> +     * but e64 may not be supported.
> +     */
> +    if (lmul < 0) {
> +        return (8 << vsew) <= (64 / (1 << (-lmul)));
> +    } else {
> +        return true;
> +    }
> +}

While the spec uses language like "may not be supported", but it then goes on to use an 
example of VLEN=32 and LMUL=1/8 not being valid because that leaves only one 4 bit element.

In our case...

> +
> +static void set_vtype(TCGContext *s, TCGType type, MemOp vsew)
> +{
> +    unsigned vtype, insn, avl;
> +    int lmul;
> +    RISCVVlmul vlmul;
> +    bool lmul_eq_avl;
> +
> +    s->riscv_cur_type = type;
> +    s->riscv_cur_vsew = vsew;
> +
> +    /* Match riscv_lg2_vlenb to TCG_TYPE_V64. */
> +    QEMU_BUILD_BUG_ON(TCG_TYPE_V64 != 3);
> +
> +    lmul = type - riscv_lg2_vlenb;

We know VLEN, and LMUL is bounded by TCG_TYPE_V64.  Since SEW=64 will never be smaller 
than LMUL*VLEN, I expect the lmul_check function to be entirely unneeded: all SEW should 
always work.

If for some strange reason that is not the case, the correct solution not to *assume* that 
it might not work, as you are doing, but to *probe* for it at startup.  For instance, it 
would be easy to loop over each SEW to find the minimal LMUL for which VSETVL returns a 
positive VL, i.e. VILL not set.

> +    if (lmul < -3) {
> +        /* Host VLEN >= 1024 bits. */
> +        vlmul = VLMUL_M1;
> +        lmul_eq_avl = false;
> +    } else if (lmul < 3) {
> +        /* 1/8, 1/4, 1/2, 1, 2, 4 */
> +        if (lmul_check(lmul, vsew)) {
> +            vlmul = lmul & 7;
> +        } else {
> +            vlmul = VLMUL_M1;
> +        }
> +        lmul_eq_avl = true;

lmul_eq_avl incorrectly set here for !lmul_check.

> +        if (type >= riscv_lg2_vlenb) {
> +            static const RISCVInsn whole_reg_ld[] = {
> +                OPC_VL1RE64_V, OPC_VL2RE64_V, OPC_VL4RE64_V, OPC_VL8RE64_V
> +            };
> +            unsigned idx = type - riscv_lg2_vlenb;
> +
> +            tcg_debug_assert(idx < sizeof(whole_reg_ld));
> +            insn = whole_reg_ld[idx];
> +        } else {
> +            static const RISCVInsn unit_stride_ld[] = {
> +                OPC_VLE8_V, OPC_VLE16_V, OPC_VLE32_V, OPC_VLE64_V
> +            };
> +            MemOp prev_vsew = set_vtype_len(s, type);
> +
> +            tcg_debug_assert(prev_vsew < sizeof(unit_stride_ld));

Both sizeof are incorrect; you need ARRAY_SIZE().
Likewise in tcg_out_st.

>   static void tcg_out_tb_start(TCGContext *s)
>   {
> +    s->riscv_cur_type = TCG_TYPE_COUNT;
>       /* nothing to do */
>   }

Remove the out-of-date comment.


r~


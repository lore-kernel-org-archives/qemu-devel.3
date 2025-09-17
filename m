Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD993CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqT8-0004DQ-Bi; Wed, 17 Sep 2025 07:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqT4-0004Cm-Fo
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:36:58 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqT2-00084c-2e
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:36:58 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d603a269cso43716487b3.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758109015; x=1758713815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+0fIO5QYep8ESCFZccAhR1SrpA2963VFE92xZX3msdY=;
 b=B2Ggz1SAlBMHY9TCpqCqU7RXx+OA9s9DIwjKsoS9RWKpNORKrZ8gtdCx5S7OG7WhpW
 4BtLB+V6eorUYtVJmCVny2TrF+/d7y4oi9PgESp7QO44ZmBoiYdLM1zvbjpwfxUAYdww
 EE7CLD5f3ZEzWOjUQvZrcdxODdTB2mEiBDbNMJux7T7doXJhHk9GU+iCWqTfeWqVg8bK
 Qz/3KK014oi2QNN6OgPt9ibNShVCdxB6bL6beDRvn7norozI3evEQKxJ/rbfZS1XlSod
 ihTpa/LHOiO+7tH+seqoWN8nT3qzenDoUks64KHKbBNGrYU0loHGAQaQu5U7I6CKv+lY
 tFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758109015; x=1758713815;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+0fIO5QYep8ESCFZccAhR1SrpA2963VFE92xZX3msdY=;
 b=rTPyRd/4Khgleup1WzqlHC4OrVJouMpSHg5vYrmheeaycgFIKL2vovdeQOSl+7F6jF
 snAka7pyHusX9gL9VlWxHwjtg/paQj83fm0eEBPrLZrFmZ6xDN6F0Wq4M/ABXj76YHUd
 f/NdRttlug09D8LEdqF5CV85IG8zKpgArnsKhMV8Y4KEWkGdY7v9H3+tSif7mGlqZ2jc
 SMyIol6imZQ+r5UtPzU9xktBIrG2LHqgbVKPPKmV6fNld4Zq+wns5dJNmyZCQf5BFDI+
 EPneB2W2cny4K8WV+j8ww9vNNYnQ6CkTNLVcu5uEcna77mLzJTyF7TnDWXVr96yck/0a
 /PBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP5wbnhEumtw+8L4EBAbJYVIQKvbKTatcjGe9yBcQtafV8CG3uneHKV9FqsYFHFX7JB6C8sLMts+YK@nongnu.org
X-Gm-Message-State: AOJu0YyflZ8tV5xrN966p7RILC/qLWoBZJfH0qSx3rbWKau4OhTvSP5j
 BJ5G6neXxq/Ngi6kJ0RVrfoJBwNpH+MC3JjtkkC8PF+R+eK1NYisgTamLDaIhVsjIAc=
X-Gm-Gg: ASbGncu5FxuFJ2/D/Zttw1JFBZ3IOecitSUG/Ptf7KCBO1/mZFV0UnOcj7MATalRK1Y
 ZVPB3tVQRL6g2srUEI69ibO2j8q9fbYcCOjaJEKqJadzPy+K6qZm/gfjRDuOTikohy7LLREwj3i
 K/22lmGi3DKmRfEAJvisjfy+glz3LTP4x+66kyKIycKMYY5T5pRoPhbtk0dx2cmlYLjJ24scTir
 9jWyg9wpglRFXG4ZkcRD+Yayu9BanyyIWNZBG69b1XK0kTXDV2pLvo14iannmMbQjncd/s+c8HZ
 Lf15/nLy34piX1m8CfcL2J3nlKRrlxfGqoSxASbilsD+DSKYwaJ4oiAKINTZlLpn5EpaWXxIKb0
 8Z6k049aydmt6shw+femudQ01MDDvWu87PjDYW+vpmJJ6OeXvgm4nagG3CM1eknGrFsl2iI3Gwv
 7i
X-Google-Smtp-Source: AGHT+IEptVo9o6olaU9LNWCyaCw8yx4uyh+s1YUENrc1kTTpOXdJcWbPvSzbEcgjO/Fz5TLDnq62rw==
X-Received: by 2002:a05:690c:f03:b0:732:f9d3:53b5 with SMTP id
 00721157ae682-73892f4a5e0mr11929337b3.38.1758109014540; 
 Wed, 17 Sep 2025 04:36:54 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea?
 ([2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-72f7632ed5csm47699057b3.6.2025.09.17.04.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:36:53 -0700 (PDT)
Message-ID: <f7ffd3ff-ed18-4c92-8fba-690ca1c59aeb@ventanamicro.com>
Date: Wed, 17 Sep 2025 08:36:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] target/riscv: Implement SMMPT fence instructions
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-5-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-5-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/9/25 10:25 AM, LIU Zhiwei wrote:
> This patch completes the SMMPT implementation by adding support for the
> new fence instructions: `mfence.spa` and `minval.spa`.
> 
> According to the specification, these instructions act as memory ordering
> fences for MPT updates. In QEMU's TCG model, this is conservatively
> implemented by flushing the entire TLB, which ensures that any subsequent
> memory accesses will re-evaluate permissions and see the effects of any prior
> MPT modifications.
> 
> The instructions are privileged and will cause an illegal instruction
> exception if executed outside of M-mode.
> 
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn32.decode                    |  2 ++
>   .../riscv/insn_trans/trans_privileged.c.inc   | 30 +++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9..cf58f1beee 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -120,6 +120,8 @@ sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
>   wfi         0001000    00101 00000 000 00000 1110011
>   sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> +mfence_spa  1000011    ..... ..... 000 00000 1110011 @sfence_vma
> +minval_spa  0000011    ..... ..... 000 00000 1110011 @sfence_vma
>   
>   # *** NMI ***
>   mnret       0111000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 8a62b4cfcd..5ec6bf5991 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -160,3 +160,33 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
>   #endif
>       return false;
>   }
> +
> +#define REQUIRE_SMSDID(ctx) do {          \
> +    if (!ctx->cfg_ptr->ext_smsdid) {      \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool do_mfence_spa(DisasContext *ctx)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    REQUIRE_SMSDID(ctx);
> +    if (ctx->priv != PRV_M) {
> +        return false;
> +    }
> +    decode_save_opc(ctx, 0);
> +    gen_helper_tlb_flush_all(tcg_env);
> +    return true;
> +#endif
> +    return false;
> +}
> +
> +static bool trans_mfence_spa(DisasContext *ctx, arg_mfence_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}
> +
> +static bool trans_minval_spa(DisasContext *ctx, arg_minval_spa *a)
> +{
> +    return do_mfence_spa(ctx);
> +}



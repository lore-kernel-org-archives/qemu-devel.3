Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596FE108B91E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DDN-0004RK-IM; Tue, 24 Mar 2026 21:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5DDL-0004Qn-Uw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:39:19 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5DDJ-0008No-Mr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:39:19 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so4908544a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774402756; x=1775007556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WgETYKRUZDrkXEHCsOEJS7i8mCHsuiLy2L493DWB41M=;
 b=KUU2H0QKQOVhWiJgVcIdfIusLDQBagT9wShCz4zvhveieEYjsynGZNVItJdgXME6MT
 mO7eVLD3f36AgGhVzgwpSDrWE2gWwLVZXZO9Ink3V3zUEvDnqkxusUMNvJFqfab9a8xX
 NyfPq/0G1RcuLbAcAKH3DDYR6kTcqHzcXun71Sy7e4SZ7TArEkekIXZ2RBInTa6+4vix
 dTuURqVFmJsg5mJNoA+qsK1ibKIQjeMhjZYa0t2mygxm9yntLA/z83Run37tpP0qIgEd
 tYfyh0kF6djRkAPGxfXkUISuOYIkJ21sn4H7nZuKvGmRlP2LCXRsJAMperKjYyXiq4lJ
 1HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774402756; x=1775007556;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WgETYKRUZDrkXEHCsOEJS7i8mCHsuiLy2L493DWB41M=;
 b=Ta+tZPmAN0fjKLYAyBvy101EQBnv94kagDzMInCBOu2/Vm8OFMurtFvrDkxGZ1GVnz
 Kb158Ke/9f2rY3lImotFxAW+b/gHzapzjQjjRWImewaEYNv1fAl3JOIjsyvfSa4kgEZj
 flnMiY+NYh49N0eMB4y1Fd6L9iTM47LjLPe9R+gX/Sf2KYPqv3q5fxaFsN1OgFTbhXEG
 J/O02WTcLNDCi2fHdlbsKniLkXRQqvWPz2kXqFlayTChryxy8GuLAR7NMQyyaO6btLP7
 bQIMZiA6+PXfk/1caPAl17Vk4ZjQ2QC6dKLmoVcLR6PF97QQkzINnJhuygmD8AFHE899
 3IYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+kLl9BBmQoVt8QqkEjYnkUcL/orc/9eDCsg3MMMDggnZLMa+8ePKUj0O7E2pLDaUlehtRqlAn6Y52@nongnu.org
X-Gm-Message-State: AOJu0YykNg1QVSBTxVvFUqqPpZfvJmmJ9yqo/SXggTo1pkTqqgrtMBHg
 EH21kf7CHKwr8PWRODxEBMV5Iv2MdTDptqj7FHDmZ7cZFiGKJxADiT44eChm6YpAsEjTmHK5t5M
 mFOSSpYU=
X-Gm-Gg: ATEYQzz14k9h3eFvsN8PkHkKf5lWi5Y0rmhj8EQcnQ0HNG2Y2jz8yAJ7mX5/lWrdqjk
 6xiJW2SHqngnMwZJ8H2mFuTVka2/lNQ+eH421JfnIptT5mR3aMImkfXmcUC2CVQXX7EXUnQ56dm
 66+rDilVmEkvWEr9wTh7FpJmQhc6yqWiHOYsI5Xhg+/3uGSGDKZfIHE07GJu5CDzIg4FcgEvtz2
 CzXF8Yz5rmjXZWvnALJ6L0+Kqz0BcbwLO1die4kVsmrlwIugLPz2RmC5WPK7AEGehF73DRpVbDR
 mdOrit4HfsA25FMxtdTwg025cuxMPQQjMKeCUVsdYh+uVK6LxgbRxd1uUTqzvxS8ADQUGO36/jG
 s495tB4rjOGT/jzuyqAWwdVqqD3C4VKBnarJXxnRyX0QtRG9/IO3K4XtBoZ/q/n8YSimsFfQ8n1
 YxYgm7Q3ORjQCQLieCdS9QiZKf7IlJ15duDgwcZajGw9ohxLhbhJ0zHQ61BY4K+GjlkV2xtahyg
 cR33T0=
X-Received: by 2002:a17:903:440f:b0:2b0:700e:fc9b with SMTP id
 d9443c01a7336-2b0b0aea735mr18871615ad.34.1774402755577; 
 Tue, 24 Mar 2026 18:39:15 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08365a62bsm215324575ad.46.2026.03.24.18.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 18:39:15 -0700 (PDT)
Message-ID: <456faa09-4889-43e2-a35a-449888f9249e@linaro.org>
Date: Tue, 24 Mar 2026 18:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] tcg: Pass host-endian values to
 plugin_gen_mem_callbacks_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260325004052.1026892-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325004052.1026892-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

On 3/24/26 5:40 PM, Richard Henderson wrote:
> If the host does not support swapped-endian loads and stores,
> then we emulate those within the tcg expanders with explicit
> bswap operations.
> 
> However, we were passing values to the plugin interface in
> the middle of those bswap operations, which meant that we
> would pass values of the wrong endianness to plugins when
> running on hosts without swapped-endian loads and stores.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Hi Pierrick,
> 
> On IRC I expressed the opinion that there was an additional
> big-endian bug with how we treat neg.plugin_mem_value_low,
> but I now see that isn't true, because of how we adjust the
> store address in plugin_gen_mem_callbacks_i32.
>

Yes, we store the value directly swapped, so there is no further 
transformation needed.

> 
> r~
> ---
>   tcg/tcg-op-ldst.c | 52 ++++++++++++++++++++++++-----------------------
>   1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
> index 354d9968f9..22211ccb45 100644
> --- a/tcg/tcg-op-ldst.c
> +++ b/tcg/tcg-op-ldst.c
> @@ -262,9 +262,6 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
>       addr_new = tci_extend_addr(addr);
>       copy_addr = plugin_maybe_preserve_addr(addr);
>       gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
> -    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
> -                                 QEMU_PLUGIN_MEM_R);
> -    maybe_free_addr(addr, addr_new);
>   
>       if ((orig_memop ^ memop) & MO_BSWAP) {
>           switch (orig_memop & MO_SIZE) {
> @@ -280,6 +277,10 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
>               g_assert_not_reached();
>           }
>       }
> +
> +    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
> +                                 QEMU_PLUGIN_MEM_R);
> +    maybe_free_addr(addr, addr_new);
>   }
>   
>   void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
> @@ -290,10 +291,10 @@ void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
>       tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
>   }
>   
> -static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
> +static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
>                                       TCGArg idx, MemOp memop)
>   {
> -    TCGv_i32 swap = NULL;
> +    TCGv_i32 val = orig_val;
>       MemOpIdx orig_oi, oi;
>       TCGTemp *addr_new;
>   
> @@ -302,29 +303,29 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
>       orig_oi = oi = make_memop_idx(memop, idx);
>   
>       if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
> -        swap = tcg_temp_ebb_new_i32();
> +        val = tcg_temp_ebb_new_i32();
>           switch (memop & MO_SIZE) {
>           case MO_16:
> -            tcg_gen_bswap16_i32(swap, val, 0);
> +            tcg_gen_bswap16_i32(val, orig_val, 0);
>               break;
>           case MO_32:
> -            tcg_gen_bswap32_i32(swap, val);
> +            tcg_gen_bswap32_i32(val, orig_val);
>               break;
>           default:
>               g_assert_not_reached();
>           }
> -        val = swap;
>           memop &= ~MO_BSWAP;
>           oi = make_memop_idx(memop, idx);
>       }
>   
>       addr_new = tci_extend_addr(addr);
>       gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
> -    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
> +    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
> +                                 QEMU_PLUGIN_MEM_W);

It works, but it is still not clear to me why the value orig_val (which 
is not swapped and in target-endian order) gets stored swapped correctly 
in neg.plugin_mem_value_low.

I would expect it to be in target-endian order, since 
plugin_gen_mem_callbacks_i32 uses tcg_gen_st_i32(val, env, ... 
neg.plugin_mem_value_low) which does not perform any swap.

>       maybe_free_addr(addr, addr_new);
>   
> -    if (swap) {
> -        tcg_temp_free_i32(swap);
> +    if (val != orig_val) {
> +        tcg_temp_free_i32(val);
>       }
>   }
>   
> @@ -360,9 +361,6 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
>       addr_new = tci_extend_addr(addr);
>       copy_addr = plugin_maybe_preserve_addr(addr);
>       gen_ld_i64(val, addr_new, oi);
> -    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
> -                                 QEMU_PLUGIN_MEM_R);
> -    maybe_free_addr(addr, addr_new);
>   
>       if ((orig_memop ^ memop) & MO_BSWAP) {
>           int flags = (orig_memop & MO_SIGN
> @@ -382,6 +380,10 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
>               g_assert_not_reached();
>           }
>       }
> +
> +    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
> +                                 QEMU_PLUGIN_MEM_R);
> +    maybe_free_addr(addr, addr_new);
>   }
>   
>   void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
> @@ -392,10 +394,10 @@ void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
>       tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
>   }
>   
> -static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
> +static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
>                                       TCGArg idx, MemOp memop)
>   {
> -    TCGv_i64 swap = NULL;
> +    TCGv_i64 val = orig_val;
>       MemOpIdx orig_oi, oi;
>       TCGTemp *addr_new;
>   
> @@ -404,32 +406,32 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
>       orig_oi = oi = make_memop_idx(memop, idx);
>   
>       if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
> -        swap = tcg_temp_ebb_new_i64();
> +        val = tcg_temp_ebb_new_i64();
>           switch (memop & MO_SIZE) {
>           case MO_16:
> -            tcg_gen_bswap16_i64(swap, val, 0);
> +            tcg_gen_bswap16_i64(val, orig_val, 0);
>               break;
>           case MO_32:
> -            tcg_gen_bswap32_i64(swap, val, 0);
> +            tcg_gen_bswap32_i64(val, orig_val, 0);
>               break;
>           case MO_64:
> -            tcg_gen_bswap64_i64(swap, val);
> +            tcg_gen_bswap64_i64(val, orig_val);
>               break;
>           default:
>               g_assert_not_reached();
>           }
> -        val = swap;
>           memop &= ~MO_BSWAP;
>           oi = make_memop_idx(memop, idx);
>       }
>   
>       addr_new = tci_extend_addr(addr);
>       gen_st_i64(val, addr_new, oi);
> -    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
> +    plugin_gen_mem_callbacks_i64(orig_val, NULL, addr, orig_oi,
> +                                 QEMU_PLUGIN_MEM_W);
>       maybe_free_addr(addr, addr_new);
>   
> -    if (swap) {
> -        tcg_temp_free_i64(swap);
> +    if (val != orig_val) {
> +        tcg_temp_free_i64(val);
>       }
>   }
>   

This solves the problem, thanks!

I'll probably add another patch to document that better in plugin api, 
and remove the additional swapping done in tests/tcg/plugins/mem.c.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks for the patch,
Pierrick


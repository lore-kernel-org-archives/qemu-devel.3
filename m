Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1704CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbpqc-0006AV-J7; Wed, 07 Aug 2024 19:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbpqa-00068g-IY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:13:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbpqW-0003FE-UI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:13:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fda7fa60a9so4175555ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723072411; x=1723677211;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NoPjbxgzGcsHYP/uvuUyXgL07AU8rDM/2SwmB3LhywY=;
 b=spgHoa2RL+63oIApfKD19v3vUv5LolykNMQXxS1H+TwuNYCQstXt8g6F3qIWQorlkJ
 UN1uSsQBpl+l9g33sKfF5PQJfJmbB+3TwMUYQlIBeC8MDzmK2g3MUJI/vG0RiQlz9CR6
 IhIM/UM27ac5HJw5CjxriXrGj6PCa8GtS7VkhPP/S0WApRyCj3jq3BATecIsA3CAQMlD
 ENv95DfCKj0+ePJH/Y1JwZTQ+7f9YTjKh9HYlKg+I2Xy1G2XyBnkadIfp7TXAWMbhYQ7
 UddSmdus06wBJfgAhvSMwGW7hMI1BQ9fLViitliP6kVp1OfYIH8MqItutUcHhaU+75Fd
 Glyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723072411; x=1723677211;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NoPjbxgzGcsHYP/uvuUyXgL07AU8rDM/2SwmB3LhywY=;
 b=WGT5wCgftVS67SrgtoxzttmLAteYeNGwrt7uCjq0qBMWTdj10nqpuxLgxEfnXHFjE+
 QeUQhJqoZMAZtetrBa/ZiaxsIa9b3enipIvgpl2DNX/JL9UtyqKAq68+TDpYG2WQuZMS
 hGyOqbhEurXaeOq7NfBaq5UYXS5mDnYXdq8Ws2VLD3gzgZrx8LXOp6/WpPCXtv8Fcwoi
 5MjjVbG83GBfV5maL6cDxgmaT3XItbsnZ9pfqPYL4CIpRFH64HAmXp1gBIrT0kQ72nld
 T+JjsNmGV20d6ZfZ+esSY2+7/YLlSFK6sETmSaYAJz0n0rokjr7BTKWGYo/Ue/cjun4u
 oHKw==
X-Gm-Message-State: AOJu0Yzp+ac5503ShspZ1fN+NhU10i1t8agSbshLQveYC552uLfcoUGp
 OrS5977XNLgXmshA+4L2Th1FdJwF39J4s04Oqyn6ZGN1XTZP27ObRmggN/PGk40=
X-Google-Smtp-Source: AGHT+IFUNchuCSLiUiboyPgJLrDnNFHiFa4VGNxkmfcH4tqcg3u6sL4C50jU6DZZDxCVVer552Ro/A==
X-Received: by 2002:a17:902:d485:b0:1fb:8a0e:7730 with SMTP id
 d9443c01a7336-2009526336fmr2999375ad.26.1723072410740; 
 Wed, 07 Aug 2024 16:13:30 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f29fb0sm111884715ad.22.2024.08.07.16.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 16:13:30 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:13:28 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3 15/20] target/riscv: shadow stack mmu index for shadow
 stack instructions
Message-ID: <ZrP/mCyYiOXTG0wl@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-16-debug@rivosinc.com>
 <26d37287-b4e3-42b8-818d-b96bcf128a75@linaro.org>
 <ZrPl4fFyLX5N2WUs@debug.ba.rivosinc.com>
 <eed6673a-0877-4e4e-8b86-7a7d7b770b7a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eed6673a-0877-4e4e-8b86-7a7d7b770b7a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 08, 2024 at 08:57:47AM +1000, Richard Henderson wrote:
>On 8/8/24 07:23, Deepak Gupta wrote:
>>On Wed, Aug 07, 2024 at 12:43:31PM +1000, Richard Henderson wrote:
>>>On 8/7/24 10:06, Deepak Gupta wrote:
>>>>Shadow stack instructions shadow stack mmu index for load/stores.
>>>>`MMU_IDX_SS_ACCESS` at bit positon 3 is used as shadow stack index.
>>>>Shadow stack mmu index depend on privilege and SUM bit. If shadow stack
>>>>accesses happening in user mode, shadow stack mmu index = 0b1000. If
>>>>shaodw stack access happening in supervisor mode mmu index = 0b1001. If
>>>>shadow stack access happening in supervisor mode with SUM=1 then mmu
>>>>index = 0b1010
>>>>
>>>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>>---
>>>> target/riscv/cpu.h                            | 13 ++++++++++
>>>> target/riscv/cpu_helper.c                     |  3 +++
>>>> target/riscv/insn_trans/trans_rva.c.inc       |  8 ++++++
>>>> target/riscv/insn_trans/trans_rvzicfiss.c.inc |  6 +++++
>>>> target/riscv/internals.h                      |  1 +
>>>> target/riscv/translate.c                      | 25 +++++++++++++++++++
>>>> 6 files changed, 56 insertions(+)
>>>>
>>>>diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>>>index 6da94c417c..3ad220a9fe 100644
>>>>--- a/target/riscv/cpu.h
>>>>+++ b/target/riscv/cpu.h
>>>>@@ -615,6 +615,19 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
>>>> FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
>>>> /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
>>>> FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
>>>>+/*
>>>>+ * zicfiss shadow stack is special memory on which regular stores aren't
>>>>+ * allowed but shadow stack stores are allowed. Shadow stack stores can
>>>>+ * happen as `sspush` or `ssamoswap` instructions. `sspush` implicitly
>>>>+ * takes shadow stack address from CSR_SSP. But `ssamoswap` takes address
>>>>+ * from encoded input register and it will be used by supervisor software
>>>>+ * to access (read/write) user shadow stack for setting up rt_frame during
>>>>+ * signal delivery. Supervisor software will do so by setting SUM=1. Thus
>>>>+ * a TB flag is needed if SUM was 1 during TB generation to correctly
>>>>+ * reflect memory permissions to access shadow stack user memory from
>>>>+ * supervisor mode.
>>>>+ */
>>>>+FIELD(TB_FLAGS, SUM, 31, 1)
>>>
>>>This is already encoded into the mmu_idx as MMUIdx_S_SUM.
>>
>>This is where I need some help / suggestion and clarifications.
>>
>>`riscv_env_mmu_index` is the which does mode --> mmu index translation and that's
>>where `MMUIdx_S_SUM` is set.
>>
>>Although above function assumes following things
>>    -- Only loads ands stores are supposed to do read and write.
>>    -- Translates env/priv --> mmu index
>>
>>In case of shadow stack, we need to hold following true:
>>Shadow stack are not writeable via regular stores but are allowed to be readable.
>>Shadow stack are writeable only via shadow stack instruction.
>>Shadow stack instructions can't operate on non-shadow stack memory.
>>
>>This let me to create a new mmu index (as you saw in patches). This mmu index is only
>>setup by shadow stack instruction and thus has to be known at translation time
>
>All good so far.
>
>>There is no way of telling in `riscv_env_mmu_index` about whether mmu index is requested
>>for regular load/store or some other instruction (in this case shadow stack instruction).
>>If that is available then I think I can use `riscv_env_mmu_index`.
>
>What you miss is that the result of riscv_env_mmu_index is stored
>
>  ctx->mem_idx

Yeah, that's right. thanks.

>
>So that takes care of U, S, SUM, M, VS, VU, etc.  All you need at
>this point is to or in your shadow stack bit:
>
>  ctx->mem_idx | MMU_IDX_SS_ACCESS


>
>(Perhaps SS_WRITE is a better name, since read access is never prohibited?)

Yeah MMU_IDX_SS_WRITE is probably more self-explainatory.

>
>Note that you can do this without ifdefs -- user-only will happily 
>accept and ignore the mmu index.  Also note that user-only will *not* 
>be able to restrict access to the shadow stack pages in the way the 
>spec describes.  We rely on the host mmu for read/write permission for 
>user-only.  For now -- changing that is a long term goal.

Ok, didn't know user-only will ignore.
I'll remove ifdef and simply do

ctx->mem_idx =| MMU_IDX_SS_WRITE

>
>
>>Question:
>>I see that `riscv_env_mmu_index` could be called from a bunch of places in (like
>>`accel/tcg/ldst_common.c.inc` as well. Does it exclude loads, stores which calculate mmu
>>indexes during translation (like shadow stack load, stores) ?
>
>It means you cannot use the legacy interfaces for the shadow stack.
>The current interfaces:
>
> *        cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
> *        cpu_ld{sign}{size}{end}_mmu(env, ptr, oi, retaddr)
>...
> *        cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
> *        cpu_st{size}{end}_mmu(env, ptr, val, oi, retaddr)
>
>take the mmu_idx as a parameter.
>
>But as it happens, the shadow stack instructions are simple enough to 
>implement all inline, so you won't need to call the out-of-line 
>load/store functions from cpu helpers.

Thanks for explaining this.

>
>
>r~


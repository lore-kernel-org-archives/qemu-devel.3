Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0411C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 21:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbo8Q-0000z3-4s; Wed, 07 Aug 2024 17:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbo8O-0000sC-CO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:23:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbo8M-0005uI-A8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:23:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso281472b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723065828; x=1723670628;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=67dD1CqQJNguArHNkmKZf4A2zUv5efkTEt8ROsaaWPs=;
 b=g4+k0BSI5SOHGlTdOpxhdhjqrBiJwsca/eDz53/QozXLVPg+LsntcBfxkmrH1Xoy+G
 Fo9mBehPRE472i9lwS26DnSVYsYqT4O/9T11hMwo/zvohwbQ9SKTTIx4lyy3Sfy7IEoh
 nWriE1mgq86IwVmsMQ2ArtUjuPtP8uD8xktvudvzjD58pGiLWS98ifdGx1OujmJL0r8y
 EU/OK12Qw0Wa9u/Ffyk7NK2u1pDgQMf1lvahDzY+BLHOqvHl5xf3GPFqmRIpFygscL+x
 W2JBGgOpdR1ZJVqE+ssr9FIgjmzMQf1St8goFyPp+Z/MnCkvrimaXKWzV/NNm1H9fnOy
 tJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723065828; x=1723670628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67dD1CqQJNguArHNkmKZf4A2zUv5efkTEt8ROsaaWPs=;
 b=LphL80D34Jdbl3kYREweIvrocyG0vyE6pv5w1CukfZaA5CmmvEcBb5r2k3XNKpnfvw
 WHysL3CXUZb6w3Z093OzynId7vfpMUSXsTx2p6TV0iW8EMRA9VHlW8aZhG0CUlobZqzD
 4UwGXxa56qDGP11RIU9DSN0S7S71Nb8EMv5Yy8I+920xS0uA70Jrx+2QBtg7q1ENbdJw
 AzBbul9MFRQZbmuZAQ5eqcCB5n6JXtx1TWzSO8oSoI0q35QXQnuXiPGdhLG5icAMyHl1
 8Y/QN1ZloTj294GACeoL8pd3gLAwVdiamU6drDfcY1lK8+EAkpuU2dtL6ARPukuGZGEO
 vqKA==
X-Gm-Message-State: AOJu0YwbGe/wnn0jfwYkTEtauzhq1p1rKS/ux3kQYQTLir9xYn7WKwBB
 4Zj9VnTFEPxkPIjHVm8I00c39sQOwspfarXN3sOwmS7nz2NLS8Rd9VO897XNYGs=
X-Google-Smtp-Source: AGHT+IG2XGU+VyZWOqXsRFEHnOvqXZIEDNj9nHdijyWxQEcWJTmob7pyWveTb8/UOcigGZyHAal9yA==
X-Received: by 2002:a05:6a00:2289:b0:70d:2af7:849d with SMTP id
 d2e1a72fcca58-7106d082021mr20778372b3a.23.1723065828286; 
 Wed, 07 Aug 2024 14:23:48 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec1604asm8822528b3a.35.2024.08.07.14.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 14:23:47 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:23:45 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3 15/20] target/riscv: shadow stack mmu index for shadow
 stack instructions
Message-ID: <ZrPl4fFyLX5N2WUs@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-16-debug@rivosinc.com>
 <26d37287-b4e3-42b8-818d-b96bcf128a75@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <26d37287-b4e3-42b8-818d-b96bcf128a75@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 12:43:31PM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>Shadow stack instructions shadow stack mmu index for load/stores.
>>`MMU_IDX_SS_ACCESS` at bit positon 3 is used as shadow stack index.
>>Shadow stack mmu index depend on privilege and SUM bit. If shadow stack
>>accesses happening in user mode, shadow stack mmu index = 0b1000. If
>>shaodw stack access happening in supervisor mode mmu index = 0b1001. If
>>shadow stack access happening in supervisor mode with SUM=1 then mmu
>>index = 0b1010
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  target/riscv/cpu.h                            | 13 ++++++++++
>>  target/riscv/cpu_helper.c                     |  3 +++
>>  target/riscv/insn_trans/trans_rva.c.inc       |  8 ++++++
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  6 +++++
>>  target/riscv/internals.h                      |  1 +
>>  target/riscv/translate.c                      | 25 +++++++++++++++++++
>>  6 files changed, 56 insertions(+)
>>
>>diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>index 6da94c417c..3ad220a9fe 100644
>>--- a/target/riscv/cpu.h
>>+++ b/target/riscv/cpu.h
>>@@ -615,6 +615,19 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
>>  FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
>>  /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
>>  FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
>>+/*
>>+ * zicfiss shadow stack is special memory on which regular stores aren't
>>+ * allowed but shadow stack stores are allowed. Shadow stack stores can
>>+ * happen as `sspush` or `ssamoswap` instructions. `sspush` implicitly
>>+ * takes shadow stack address from CSR_SSP. But `ssamoswap` takes address
>>+ * from encoded input register and it will be used by supervisor software
>>+ * to access (read/write) user shadow stack for setting up rt_frame during
>>+ * signal delivery. Supervisor software will do so by setting SUM=1. Thus
>>+ * a TB flag is needed if SUM was 1 during TB generation to correctly
>>+ * reflect memory permissions to access shadow stack user memory from
>>+ * supervisor mode.
>>+ */
>>+FIELD(TB_FLAGS, SUM, 31, 1)
>
>This is already encoded into the mmu_idx as MMUIdx_S_SUM.

This is where I need some help / suggestion and clarifications.

`riscv_env_mmu_index` is the which does mode --> mmu index translation and that's
where `MMUIdx_S_SUM` is set.

Although above function assumes following things
    -- Only loads ands stores are supposed to do read and write.
    -- Translates env/priv --> mmu index

In case of shadow stack, we need to hold following true:
Shadow stack are not writeable via regular stores but are allowed to be readable.
Shadow stack are writeable only via shadow stack instruction.
Shadow stack instructions can't operate on non-shadow stack memory.

This let me to create a new mmu index (as you saw in patches). This mmu index is only
setup by shadow stack instruction and thus has to be known at translation time
(and that's why SUM TB flag)

There is no way of telling in `riscv_env_mmu_index` about whether mmu index is requested
for regular load/store or some other instruction (in this case shadow stack instruction).
If that is available then I think I can use `riscv_env_mmu_index`.

Question:
I see that `riscv_env_mmu_index` could be called from a bunch of places in (like
`accel/tcg/ldst_common.c.inc` as well. Does it exclude loads, stores which calculate mmu
indexes during translation (like shadow stack load, stores) ?

>
>
>r~


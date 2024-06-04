Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436AAC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 17:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEXdB-0003lh-EB; Tue, 04 Jun 2024 13:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEXdA-0003lO-6x
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:07:28 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEXd8-0001yE-1S
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:07:27 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6cc3e134f88so1058756a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717520844; x=1718125644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4/hXIl2upNsIk+PSBjoDEplaMxj2H1I6IAo7dmUw1A=;
 b=BOnfn3eOwG+6vvqlxBMSk2A5ujkoba71kWQm4xy/GTZ0VifSdhdllw5B8Anjqwb0bf
 VZkHsTvp0Sod1AI6pEg7Ic7AXarIJ9XzMXG1BPkVN9V6dETLgXvUIFSCp/astd0R+fNV
 DoUSHQvIDWUgr/2VL5afbYLrkxXA8mzFq7W6mRSz/V5NYrj05RHr0PX+f/K9xSRZWSpP
 8Qk3UQRU5Uok69owMxzzeNaD4XXHScRy3O6uKTIezPxrbsV/qSmgVIhTbjP0eKBD7zFv
 V5nY1I+ULrSgv6mzQMjq6va+IhrZPrAOy45lO3SazT/rgJ/+fYvV+E8wRY69nmlgbeE/
 VN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717520844; x=1718125644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4/hXIl2upNsIk+PSBjoDEplaMxj2H1I6IAo7dmUw1A=;
 b=okL/mq/tyYJKNFsrh2Yxv2dpKekBmHsHSeI3+RCDulNpZuoKaPjbKC8TEu/WWo2QwU
 hUt8BtXHydNF3RUqO41dPRIM3/pBB8wzr3oBIG/eXHpglKPQouA7q8WUzzl3JSOgu3F5
 uobtUh+7bG5YLmBMNpJcLWwAyH5NprYIOj0OhMxB74LI0g4TTymt6+mN9OdXQdRARtVu
 YTNrOzY8I4EzJ7IKClJYTMynl4rcXvvt9+C5j3YmXZhtY2wDBo7q03WyRmhwV8FyHyTJ
 RYzSa6rk04WCRB7OHCwqgZE7I6vaLPySMC4QVOuby3/vjJOnVW/jQ38HNQZ3h6YpHVTN
 VJvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG2LrOLeIHQUcL3w+WH/xzGKWttc18YivubG0xdTl5IsagYhqMvAgRHFiiNdzkAjQ3NQu0P10eTraXzrU9Be5l5lWa+v8=
X-Gm-Message-State: AOJu0Yw/MjCeHAfaFLFPdUrCyqmlv850onZ7h0LSFiuLrKRBjsB7QPgl
 5j+DgqkUEj77y74uAsHp62elp0NhwEPeErZ/pFGBXIvhkBjaNqNyTj0msTisDp8=
X-Google-Smtp-Source: AGHT+IHB4w1qcpuGdwRvkgoDXO42/dRiWKMAJSvG/U+2T1wu4qIStiwEGQRYrXs/ljRc69ttofFyoQ==
X-Received: by 2002:a17:90b:68b:b0:2bd:7935:a14e with SMTP id
 98e67ed59e1d1-2c27db4fb41mr44329a91.30.1717520844222; 
 Tue, 04 Jun 2024 10:07:24 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775f8cbsm10185098a91.11.2024.06.04.10.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 10:07:23 -0700 (PDT)
Message-ID: <09c0cefe-efd4-4d82-b1c3-fb17d8fbe84e@sifive.com>
Date: Wed, 5 Jun 2024 01:07:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-7-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240529160950.132754-7-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x530.google.com
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


Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
> CTR entries are accessed using ctrsource, ctrtarget and ctrdata
> registers using smcsrind/sscsrind extension. This commits extends
> the csrind extension to support CTR registers.
>
> ctrsource is accessible through xireg CSR, ctrtarget is accessible
> through xireg1 and ctrdata is accessible through xireg2 CSR.
>
> CTR supports maximum depth of 256 entries which are accessed using
> xiselect range 0x200 to 0x2ff.
>
> This commits also adds properties to enable CTR extension. CTR can be
> enabled using smctr=true and ssctr=true now.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.c |   4 ++
>   target/riscv/csr.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 156 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 30bdfc22ae..a77b1d5caf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> @@ -1473,6 +1475,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>       MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>       MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 888084d8e5..15b953f268 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2291,6 +2291,11 @@ static bool xiselect_cd_range(target_ulong isel)
>       return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
>   }
>   
> +static bool xiselect_ctr_range(target_ulong isel)
> +{
> +    return (CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST);
> +}
> +
>   static int rmw_iprio(target_ulong xlen,
>                        target_ulong iselect, uint8_t *iprio,
>                        target_ulong *val, target_ulong new_val,
> @@ -2336,6 +2341,118 @@ static int rmw_iprio(target_ulong xlen,
>       return 0;
>   }
>   
> +static int rmw_xctrsource(CPURISCVState *env, int isel, target_ulong *val,
> +                          target_ulong new_val, target_ulong wr_mask)
I prefer naming the function as rmw_ctrsource(), since this register 
name does not have a mode prefix.
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * TOS                                 H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        *val = 0;
val may be NULL.
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_src[idx];
> +    }
> +
> +    env->ctr_src[idx] = (env->ctr_src[idx] & ~wr_mask) | (new_val & wr_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_xctrtarget(CPURISCVState *env, int isel, target_ulong *val,
> +                          target_ulong new_val, target_ulong wr_mask)
I prefer naming the function as rmw_ctrtarget(), since this register 
name does not have a mode prefix.
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        *val = 0;
val may be NULL.
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_dst[idx];
> +    }
> +
> +    env->ctr_dst[idx] = (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_xctrdata(CPURISCVState *env, int isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
I prefer naming the function as rmw_ctrdata(), since this register name 
does not have a mode prefix.
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t mask = wr_mask & CTRDATA_MASK;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        *val = 0;
val may be NULL.
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_data[idx];
> +    }
> +
> +    env->ctr_data[idx] = (env->ctr_data[idx] & ~mask) | (new_val & mask);
> +
> +    return 0;
> +}
> +
>   static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                            target_ulong isel, target_ulong *val,
>                            target_ulong new_val, target_ulong wr_mask)
> @@ -2486,6 +2603,38 @@ done:
>       return ret;
>   }
>   
> +static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    bool ext_sxctr = false;
> +    int ret = -EINVAL;
> +
> +    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG3) {
> +        ext_sxctr = riscv_cpu_cfg(env)->ext_smctr;
> +    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG3) {
> +        ext_sxctr = riscv_cpu_cfg(env)->ext_ssctr;
> +    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG3) {
> +        ext_sxctr = riscv_cpu_cfg(env)->ext_ssctr;
> +    }
> +
> +    if (!ext_sxctr) {

I think [s|vs]ireg4/5/6 are read-only 0 and accesses on them should not 
trigger exceptions.

Please refer to chapter 3.

Exceptions should be triggered when both smctr and ssctr are disabled.

> +        return -EINVAL;
> +    }
> +
> +    if (csrno == CSR_MIREG || csrno == CSR_SIREG || csrno == CSR_VSIREG) {
MIREG* are not used by CTR.
> +        ret = rmw_xctrsource(env, isel, val, new_val, wr_mask);
> +    } else if (csrno == CSR_MIREG2 || csrno == CSR_SIREG2 ||
> +               csrno == CSR_VSIREG2) {
MIREG* are not used by CTR.
> +        ret = rmw_xctrtarget(env, isel, val, new_val, wr_mask);
> +    } else if (csrno == CSR_MIREG3 || csrno == CSR_SIREG3 ||
> +               csrno == CSR_VSIREG3) {
MIREG* are not used by CTR.
> +        ret = rmw_xctrdata(env, isel, val, new_val, wr_mask);
> +    }
> +
> +    return ret;
> +}
> +
>   /*
>    * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
>    *
> @@ -2497,11 +2646,13 @@ static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
>                                 target_ulong isel, target_ulong *val,
>                                 target_ulong new_val, target_ulong wr_mask)
>   {
> -    int ret = -EINVAL;
>       bool virt = csrno == CSR_VSIREG ? true : false;
> +    int ret = -EINVAL;
>   
>       if (xiselect_cd_range(isel)) {
>           ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (xiselect_ctr_range(isel)) {
MIREG* are not used by CTR. We can check:
else if (csrno < CSR_MIREG && xiselect_ctr_range(isel))
> +        ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
>       } else {
>           /*
>            * As per the specification, access to unimplented region is undefined


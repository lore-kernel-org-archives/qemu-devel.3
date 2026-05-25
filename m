Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4594BCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRMu8-0006oC-Ax; Mon, 25 May 2026 00:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMty-0006nB-33
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:26:55 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wRMtw-00072e-6t
 for qemu-devel@nongnu.org; Mon, 25 May 2026 00:26:53 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304545f5206so3396431eec.0
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 21:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779683207; x=1780288007; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pWRvNRNtzk1L5iutmlGx5AaSFrydZzZbLe8RXqavrVw=;
 b=qIuHMkiE4P+jp6sSWgT6BMyc8KZ80oJGwObA863BS1FYKZbzCstefJ/ReRFBEXBCTw
 p0IUnq35sIFaUi3BF1hggkc3LuJT3pnNuSST7s7Tbri0PU+drIzCj/bI3PBdIYT5D0fF
 VmKeqxlyhW+7/fBDaA8+ik4Dz87/3aZBnyPp6hhUQd0wd7Ok4Ypi8Qhx6fqjVz9/yP+p
 +A/XwWCBzg17UcgSwKfdLV6pxZJ1zDQQqdbax2QHyQt5np9G1eTANK8F7JjNh0U5/4Wd
 2F4tEaCUg6GLk50gE7ObXdvqPtHaCDDssecFbt+xDTjy4g+f7wRooNJdpYCeSNQ3nIGG
 cc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779683207; x=1780288007;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWRvNRNtzk1L5iutmlGx5AaSFrydZzZbLe8RXqavrVw=;
 b=jwkAdkRLNqbwT5vei1CuYtc5UAk/VfAnWUV9yyhcOmqBxZTDkxu0O0pYtOW8vcB+QM
 NbQHaoP2GXGDwBx32+y4Z80+KoYYc32aM1HjIJHsYPlvG6e6lc1wSLpWMHu/ySENLXaH
 qqFCfzxJJK17/FXQ5R8lErSUhM7LTfGOap9BC9xOB0/u79QcBNIYfbti1S6RmLXv8Z4y
 xuVn5lB30AlEWlNE+I9kni3hemNlHQB8SXCJmi2Ueg77+M0hQENKKJaY9sndbmX4PHb+
 meTKG27UbI8oiNInv3RZe0PAaHvGlWaJzBcDu/k6mn8xLJyoFAkAInyNdk9yTRFX3HLH
 Z/aQ==
X-Gm-Message-State: AOJu0YzYAWstDv0WBr9p+ACMWOP0nSkOuiIralL2osVngabpaDvCoDJS
 YQuJn8LB/X93xxEZCGS3NtdRtEUwYdSJtUywQQJgIX2n5BQF+gku7BJY
X-Gm-Gg: Acq92OGF5lp5nKRaiOMJZZBCxtdiuc5Hzom+CRASPZIvMu/YHafdUcXlh7EJIoqhwBa
 xxLyRmEcxOSKrA46tijRAyWApKLK4S/QmOx4tn+tNhPCNl95/4/qaThQy98thqAMerHKAgrv2RP
 SPi79qW64o3eFWLysYYP6pK8KB0Zeirz5+46wap3kxJnjz/nc+5KxLcu+ixfF5M3qr1mOANkAv1
 2Oz8D6nAlr7tirNeltHH8g4RSoNx+Mb0x48zsmR8J/dsWhUIAJKe+fpsjgkdtLDEfFnbam/jJ3A
 tPfWQ6EJkQiGwxZDgrXbt1KUpwcfx2aUaIJf2UnVHVe+IMdGeJfwjtdlqUrV1vGQkN4gZRG+KAA
 m8FkcnSZpXhR401fNxYaYRytLDXFnUxbmsMwpj3k8Y6p1/+RzoTWiFuxqD40hB8u6f9urRGCk7m
 KrSoxBp7Gut/VUb7Rioz9f/JrqQTIUDS2NuYQFUO3H2lmuRx1Rwfk2NWBqj+4=
X-Received: by 2002:a05:7301:169a:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-30449102827mr5221828eec.21.1779683207156; 
 Sun, 24 May 2026 21:26:47 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522547fesm7239536eec.21.2026.05.24.21.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 21:26:46 -0700 (PDT)
Date: Mon, 25 May 2026 12:26:44 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] target/riscv/cpu_helper.c: add PMA access fault
Message-ID: <ahPPc0nO065iIJam@ChaodeMacBook-Pro.local>
References: <20260522172502.320529-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522172502.320529-1-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 22, 2026 at 02:25:02PM +0800, Daniel Henrique Barboza wrote:
> We're not doing anything special w.r.t PMA (Physical Memory Access)
> related faults, handling them like regular faults that will eventually
> turn to be regular page faults.
> 
> Turns out we can't do that.  Priv spec section "Virtual Address
> Translation Process" mentions:
> 
> "If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
> PMA or PMP check, raise an access-fault exception corresponding to the
> original access type."
> 
> This means that we should handle PMA violations with access faults, like
> we're already doing with PMP.  One clear code path where we should throw
> a PMA failure, exposed by [1], is the error return from
> address_space_ld* call.
> 
> There's a separated issue with the error code being returned by them (it
> always return DECODE_ERROR even with 'rejected' reads) that we're going
> to work around it by assuming that we did a good job with the PTE
> address sanitization beforehand, and interpret that the error here is
> related to PMA.  This is of course not ideal but fixing this QEMU API is
> out of scope for this work.
> 
> All this said, we'll set the new pmp_pma_violation flag when we have
> either a PMP or a PMA fault, and everything else shall fall into place.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/work_items/3502
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3502
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/cpu.h        |  3 ++-
>  target/riscv/cpu_helper.c | 34 +++++++++++++++++++++++++---------
>  2 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7d79c7a5a7..e5e1687177 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -131,7 +131,8 @@ enum {
>      TRANSLATE_SUCCESS,
>      TRANSLATE_FAIL,
>      TRANSLATE_PMP_FAIL,
> -    TRANSLATE_G_STAGE_FAIL
> +    TRANSLATE_G_STAGE_FAIL,
> +    TRANSLATE_PMA_FAIL,
>  };
>  
>  /* Extension context status */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 17305e1bb7..5303d9f7f4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1424,7 +1424,22 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>          }
>  
>          if (res != MEMTX_OK) {
> -            return TRANSLATE_FAIL;
> +            /*
> +             * The result of address_space_* APIs above does not take into
> +             * consideration reject reads, putting all errors in the same
> +             * cathegory (DECODE_ERROR), although there's a clear
> +             * distinction between a rejected read versus other errors
> +             * (see memory_region_dispatch_read() ->
> +             * memory_region_access_valid()).  This is something that
> +             * we might have to deal with core QEMU logic some other
> +             * day.
> +             *
> +             * For this particular error path, given that we made checks
> +             * w.r.t legal PTE address before calling those APIs, we'll
> +             * assume that anything != MEMTX_OK means a rejected read,
> +             * i.e. a PMA error.
> +             */
> +            return TRANSLATE_PMA_FAIL;
>          }
>  
>          if (riscv_cpu_sxl(env) == MXL_RV32) {
> @@ -1668,7 +1683,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>  }
>  
>  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> -                                MMUAccessType access_type, bool pmp_violation,
> +                                MMUAccessType access_type,
> +                                bool pmp_pma_violation,
>                                  bool first_stage, bool two_stage,
>                                  bool two_stage_indirect)
>  {
> @@ -1676,7 +1692,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>  
>      switch (access_type) {
>      case MMU_INST_FETCH:
> -        if (pmp_violation) {
> +        if (pmp_pma_violation) {
>              cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
>          } else if (env->virt_enabled && !first_stage) {
>              cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
> @@ -1685,7 +1701,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>          }
>          break;
>      case MMU_DATA_LOAD:
> -        if (pmp_violation) {
> +        if (pmp_pma_violation) {
>              cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
>          } else if (two_stage && !first_stage) {
>              cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
> @@ -1694,7 +1710,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>          }
>          break;
>      case MMU_DATA_STORE:
> -        if (pmp_violation) {
> +        if (pmp_pma_violation) {
>              cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
>          } else if (two_stage && !first_stage) {
>              cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
> @@ -1820,7 +1836,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      vaddr im_address;
>      hwaddr pa = 0;
>      int prot, prot2, prot_pmp;
> -    bool pmp_violation = false;
> +    bool pmp_pma_violation = false;
>      bool first_stage_error = true;
>      bool two_stage_lookup = mmuidx_2stage(mmu_idx);
>      bool two_stage_indirect_error = false;
> @@ -1921,8 +1937,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          }
>      }
>  
> -    if (ret == TRANSLATE_PMP_FAIL) {
> -        pmp_violation = true;
> +    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
> +        pmp_pma_violation = true;
>      }
>  
>      if (ret == TRANSLATE_SUCCESS) {
> @@ -1949,7 +1965,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
>                               wp_access, retaddr);
>  
> -        raise_mmu_exception(env, address, access_type, pmp_violation,
> +        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
>                              first_stage_error, two_stage_lookup,
>                              two_stage_indirect_error);
>          cpu_loop_exit_restore(cs, retaddr);
> -- 
> 2.43.0
> 


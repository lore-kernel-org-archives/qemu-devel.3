Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5F2CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrn2-0005uC-5R; Wed, 17 Jun 2026 11:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wZrn0-0005tf-0N
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:02:50 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wZrmy-0003zm-D9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:02:49 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-30beab3af9eso88556eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781708567; x=1782313367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp6Zkww7MpGLFD9bZwQWmEwrlaRhCI4LGPfR2owRqNU=;
 b=gfuAk7mv/bLavycEBMoJxGn9lRG1fPiAfmeMjIpN3Q7pQDYTgHuQQLsShOBBllHfhu
 Aom61hi2RtRMZHcPOCxJ6ODGpJ+jxZ/HlfYNdxelT9I6ke/UIeNQB8G1q+N/0AhDduiR
 m2xHDUtzikmkWPAKGOY1qx0wmjmF/+e8NG/yW+CMYqvMWLwvs6qJyWnytX+u8uyacVb5
 neruMJByRBFGLz9DsggB5y6h4jzk/DYCn0nEPF1cUumVwVDCg7zbWd6EztXaqjAVCWq2
 os9VNhgHaGjHX4lFjdTjWStr5eKoz1Bt3ComFoFlpwWiduzIo794L7lyp081X5tedjT9
 bviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708567; x=1782313367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tp6Zkww7MpGLFD9bZwQWmEwrlaRhCI4LGPfR2owRqNU=;
 b=Ipyih3Apl9zz3XiX/cYSb3+I+fc8RC4DzC/w5IGuhH4YZ5LHSyUaLCYD8KNjsVDexm
 K8c44o53QvulOp/FFlUqUg7lMHytMukl3AF3mAEAvU6iQ1A7lMGdD+D8MF+frsn8hG9C
 xkyX20J8N/G4eAUy0mnsctm0Lx1XDwbo88UZ6J3+ZU2888s5cODQS2aG972ynGtYnXtm
 3rOciv5qMjqFIBUQFdT6nzA3F/fkyEsgV553bkBl5SFmfh1/Zr3b848av+UOYmN4xXFQ
 pNso1FlHUXB5FPpizN/gpGTwBBwl+rW1K8EC1PDu/NzQkKIgZbQFukVc4RFt20wGbXME
 q0yw==
X-Gm-Message-State: AOJu0Yzr50VOUyZQcyWA47Yzp3PJK04VsOnem+YVPYeG8WRiC4LC+96a
 r9cB0G6C8AUZzrwGrQCcGrp0cWp0vx88Tkq1vmcKyBWIuE9HkTWj2UN9
X-Gm-Gg: AfdE7clWOTZjqzWWTQp1afI2w9wslWUlDXL8nhJWOJB4lFsmkDL65v9n9iCnW4jfceC
 RW6x9YoZcGEW8J3WsHNLfYSAH9EmzW4BHBXTLE/7ODPSfsYl808HeoqlI3iYOmktJhG7ka1E7xl
 CdfRhEBPzVhv8Ut5T9NwX8YT8AqrtUIRxx5Syy3vB4bY6dUoF0to1/Xw00r7txdemvYtZXloyZf
 6Wy1Pk4EoCfF6dUU5zfsta6T/e3750xNsjhTI0Bb0REVa5p4FusQuQVbjvyhX39KL1VkZIybDwh
 bBJvXnodMyF9kCr3/iMcw3LLRaa62SH4CsUthqdHJ8n7qeURqfb1u3MsPZBpE+iZmgJQ8H0i6i1
 JwBDgYkMlbA4QAByEy+D92dgTXM7SVo3G5dnbf2t22+lIybvgDpgz4qCHwN5iQ73XSOEq32qH3i
 WFbUwIWjNo2KNdWS44woShdgrI/JAvl0lwBU6BCNZYGMkXTnZIcX10D49JgkxcEOMh
X-Received: by 2002:a05:693c:20c1:10b0:30b:eca2:be75 with SMTP id
 5a478bee46e88-30beca2c50fmr37547eec.8.1781708564747; 
 Wed, 17 Jun 2026 08:02:44 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([64.186.250.142])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e4898c0sm23989791eec.3.2026.06.17.08.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:44 -0700 (PDT)
Date: Wed, 17 Jun 2026 23:02:35 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Message-ID: <ajK2_Glu65YgDr87@ZEVORN-PC.localdomain>
References: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AFB2247001B0C72775E3DE202C43F5126107@qq.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jun 16, 2026 at 11:33:26PM +0800, ZhengXiang Qin wrote:
> check_zicbom_access() probes the cache block with MMU_DATA_LOAD and
> returns early for any result other than TLB_INVALID_MASK.  This treats
> TLB_MMIO as a successful load access.
> 
> For Zicbom, a TLB_MMIO result does not provide a RAM host pointer for the
> cache block operation and should not be treated as a successful access.
> Raise a store/AMO access fault instead of silently completing the CBO
> instruction.
> 
> This fixes sv39_zicbom_exceptions_Smode.S, where cbo.clean/cbo.flush and
> cbo.inval access a block mapped to a physical address without PMA
> permissions.  Before this change, the CBO instruction completed and the
> following addi was executed.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/op_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81873014cb..6c9bd5c102 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -218,6 +218,7 @@ static void check_zicbom_access(CPURISCVState *env,
>      void *phost;
>      int ret;
>  
> +    target_ulong fault_addr = address;
>      /* Mask off low-bits to align-down to the cache-block. */
>      address &= ~(cbomlen - 1);
>  
> @@ -235,6 +236,10 @@ static void check_zicbom_access(CPURISCVState *env,
>       */
>      ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
>                               mmu_idx, true, &phost, ra);
> +    if (ret == TLB_MMIO) {
> +        env->badaddr = fault_addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
> +    }
>      if (ret != TLB_INVALID_MASK) {
>          /* Success: readable */
>          return;
> -- 
> 2.43.0
> 


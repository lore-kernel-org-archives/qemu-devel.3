Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFDBEF8FE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmId-0004Bh-BK; Wed, 04 Mar 2026 08:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxmIU-0004Ay-Gg
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:29:54 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxmIS-0002fB-SR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:29:54 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so3691548eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772630991; x=1773235791; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HXyQn2EyQQuaZZRL/ptfYnjBGCZlRHfQndfnXGBRd+M=;
 b=M7StszUE5UfuLqbFnyQ9dQgNuKLnMNEKmkmdDUAc7WXpl6UQj79tEvh1lfTT0NMkhE
 yfyQcH5K7fHf/Vc1FB0cgKios1dQrxCXXUnsw3/RtJIUcceBMXYVgK75Pa2BmOydlBAM
 bR6Tqt0a17qE2Chguf51ePLTfiepsfaxIyzmG+Chlurj2BDc6w/LX4aZ1fzJTXZEI70F
 IH781QvglpBbRyJiGLAQjfFCXN2eoTjh9cEzfntn0Cix7MQLB+IpbcVS7T4Ujun8wArn
 kEzN/H8bY+aNuToeflbqdYV6Feiny5e5WQ9dUg3QKDJIOaTYN25QxlKU1YGjTwKlcmXy
 FxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630991; x=1773235791;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HXyQn2EyQQuaZZRL/ptfYnjBGCZlRHfQndfnXGBRd+M=;
 b=fpGuQEQtnSjoG4NbvvVfHF73m/l8duVei7wsydx7qM6z4rBjbVX88XKubgQ2aEK75K
 4L2/6E9/Ctd6nqcfXcxizIg7Z50CAJ4wdYHHrEULBkjx6rP19/WYSe4IQZgvlyrxHdUK
 ucVod9M/OsSrC5seqe55Yc6t48AKVR/5UzIuuuB1MQq8+LOXQ9M9kYDluqQQ5WREZmpl
 /sOzRgTO8C4o74JZtaQZDNiSpb3tNCR8Jzsb62hbE+9pS02Hz2/LeXMzF1zjoCOFnApy
 th7c2r4vtZYkKMn0U6sH23ofq10IyQmDNr9cHbudcJ9u79qfcushLnYA5rWD0GZ0SPW/
 wO0w==
X-Gm-Message-State: AOJu0YyzCTxMjhg4HO+dDnCoBMvYJpkzNdPv7TwYN25vCEkvuGrNM5wn
 UeGAQUTlJCG3N/YQJdLuQCp0LfF69HSnd8pv857l4fVq6DhJDCSVFk3j
X-Gm-Gg: ATEYQzxpCjMqw9D3WPcyVP4oAE2WbrPzgoT+vI52+HdgBRZ1yk2HWpa1MvIe19nZhHc
 SyiPK8Ldw7zKAlLNmCLvWgrNXg5YnZjl5FEGQEZ6PpMjrPMYUfg8TJfuwRgzKF5/g6vlxYJdYld
 MARymPRweoYWD0Q5TxrBFZAtCJis9kthhA+jXjRdkafhKieE3i1GTfzLmWLHke/i9Mi4VScE6Z1
 wuoeCx99uid/xsjJFsnEvHM/OtJUG1lTpkA9PhAtAjMNigiEwg4Vmz2+SbA2Pq1Clwi08EIklxZ
 CZf1fpEXKK8znRx5/UuyOZsieRumhTaWe90qemJf1bXoiPu5h+ZQm7cortO+t1lBzp/PO23Ip3l
 Pc2yap34kliBY8jassIzGXxRF4fXX6L7NCuw0CuzTSDzQfVLp8tUCl8xMTVNr2i/GAkAfIRlc0h
 S3tLqkmqlsiPLq9aQpa9EWMfCjb3mNyLmgHr6/RivOj+nnz7GwDWIHCZOJWwnqFHMY0xXzLsdIb
 i/XR/9TyQijz9KrzEZ3AOI6lrngsog=
X-Received: by 2002:a05:7300:fd0e:b0:2ba:6458:b325 with SMTP id
 5a478bee46e88-2be3108f17fmr792342eec.23.1772630991215; 
 Wed, 04 Mar 2026 05:29:51 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789962f89sm18004555c88.0.2026.03.04.05.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:29:50 -0800 (PST)
Date: Wed, 4 Mar 2026 21:29:25 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu: Add IPSR.PMIP RW1C support
Message-ID: <aagxv6L1-q_kyrSM@ZEVORN-PC.localdomain>
References: <20260304040959.47267-1-jay.chang@sifive.com>
 <20260304040959.47267-3-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304040959.47267-3-jay.chang@sifive.com>
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

On Wed, Mar 04, 2026 at 12:09:59PM +0800, Jay Chang wrote:
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
The commit message has no body text. Please add a short
description of what PMIP is and why RW1C support is needed,
similar to patch 1's commit message style.

You can copy the second point of the cover letter too:

2. Add proper RW1C (Read/Write 1 to Clear) support for the IPSR.PMIP
   (Performance Monitor Interrupt Pending) bit, which was missing from
   the IPSR register implementation.

> ---
>  hw/riscv/riscv-iommu-bits.h | 1 +
>  hw/riscv/riscv-iommu.c      | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 47fe01bee5..a938fd3eb4 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -189,6 +189,7 @@ enum riscv_iommu_ddtp_modes {
>  #define RISCV_IOMMU_REG_IPSR            0x0054
>  #define RISCV_IOMMU_IPSR_CIP            BIT(0)
>  #define RISCV_IOMMU_IPSR_FIP            BIT(1)
> +#define RISCV_IOMMU_IPSR_PMIP           BIT(2)
>  #define RISCV_IOMMU_IPSR_PIP            BIT(3)
>  
Good, BIT(2) matches the IOMMU spec for PMIP.

>  enum {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 98345b1280..610cdebac2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2153,6 +2153,10 @@ static void riscv_iommu_update_ipsr(RISCVIOMMUState *s, uint64_t data)
>          ipsr_clr |= RISCV_IOMMU_IPSR_FIP;
>      }
>  
> +    if (!(data & RISCV_IOMMU_IPSR_PMIP)) {
This works correctly in practice because `data` (the val
computed by riscv_iommu_write_reg_val) is always 0 for
IPSR writes — regs_wc is ~0 and regs_ro is 0, so the
formula yields data & ~data = 0. The condition
`!(0 & PMIP)` is always true, so PMIP is always cleared.

That said, since `data` is always 0 here, you could
simplify this to just:

    ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;

without the conditional. This would also be more
consistent with the effective behavior of the CIP/FIP/PIP
branches (which always take the "else" / clear path for
the same reason).

Not a blocker — the current code is correct. Just a
suggestion for clarity.


Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu
> +        ipsr_clr |= RISCV_IOMMU_IPSR_PMIP;
> +    }
> +
>      if (data & RISCV_IOMMU_IPSR_PIP) {
>          pqcsr = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_PQCSR);
>  
> -- 
> 2.48.1
> 


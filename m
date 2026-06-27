Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C02C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdRTp-0006NT-Ff; Sat, 27 Jun 2026 07:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdRTn-0006MT-10
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:45:47 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wdRTl-0006Qo-Fy
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 07:45:46 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so3083985eec.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2026 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782560744; x=1783165544; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rkXv6D9auk3lZVZiM3IZFGQaMX84TJkTgZbecVDR0CI=;
 b=ZvLlG+h4h2YKa4CWRXolXZdH6rs7CC4aklswvwXals2SzYU6bPBCkYf1e5x+95uH1p
 pUKQ3Fhweum1Fxiw75cp0sZSGF6oboz9zFoxkRkR/2voLLFDBEsfCjkIkrBqIH7IDBGz
 D8ZzEBMHZBOj/YI4cJYVd21HA7l8smpNPHwPDN3xeIjWMccsmJe8wM5ZRV8X0E1vlkvl
 Gz9gOB6Q4AnZBqgrUgZv4GfLSDX3JPW724Z619UgdB+GqMGD/mT2lo7wf86EBSSaaF1Y
 CFRPaHCicd5vNeV1VCnumlwlfrQ3q8Ht0InlXVRAMNBhrYk95RaMd+lkQxuKMU2vyMaT
 WxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782560744; x=1783165544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkXv6D9auk3lZVZiM3IZFGQaMX84TJkTgZbecVDR0CI=;
 b=SoQyqWhs07YeBTZvPCeYwebzrYmFHHO98P9v6RF72yOxyNNj6bRIKy+Gt74eFdloJU
 JSujFpoygRFh1J2gfW+LytEi1MQufts3wZbVdMi6UsWjOm4RwNNVvBozW2scVe/FWBqh
 aReOUpSj+4809zMohN04+sOxPxatkDkOGxD6s9uH1YnihVFcGABukBveDX44bHIjupIe
 iJgMJAES31a1NLjEDHPc97cFTW3EOJHnI1kp6i0hCs76IdA1t0ENSnThGxx2eg/DAhLo
 Pp4T25OVtknisowU1+VBjtczheKijCTdtHF3qXNqnQKG3qS/SJCiaXLfmWU2M1bDjXmH
 02Ow==
X-Gm-Message-State: AOJu0YxaNMx8TM5JF8I+WgVwpF9j0zv5VfHKEcLt44ZpUehMU5IPBa5n
 sDOdyL4KA/FS5leDc1u/Nl1aciVV7UisSRRxvDcoLebHQpXrU9+2/HeT
X-Gm-Gg: AfdE7cmCawke60mPQmVl0+DYVcsNsnr9bY3/DTd0YqWJjluob260ST/HDTSV3BbNxDu
 71R26KlsOoO7WdBkLjGGgADMHyNk2pPrEdVzln6EQ8lTsLmyl546JRzzByKP3EQAFByf+4RwpsU
 xWH6813iBp/0jth3rjbSS2rZeWpZ9rPd23qvuOka4SKbk8vxTeyxmZUM4UjnKm/J0K6w2tFU6Xv
 yHJtNp+t/luLW9/dw3Dx5mnzXqwnNh9m/aSqn7heaRZYnhzonF19e3BbU9ZcYjyYSSXF98MVDmO
 j4Jt5McaFKeVLCSYl4vZBaijBxBKaGgr2Whg4MxRRmDCr3srPZ4N8ObXQ+VlQxJSP3oUxsg/0zE
 t/sRtN9TxcRVPRJg0cZLLPGm8Pjf0/lRNgfzzzBFNnD/PMTiyk5WXAna9L6cc5dqPAp4tjYdTek
 jpm+Z44Sut2IxoNN7PWgEglao2wkqt/MecFGgp8+u2iQ2IIzlD
X-Received: by 2002:a05:7022:6b9d:b0:136:6883:c4bf with SMTP id
 a92af1059eb24-139dbb3030cmr8449782c88.15.1782560743569; 
 Sat, 27 Jun 2026 04:45:43 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139f5901f73sm600345c88.4.2026.06.27.04.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 04:45:43 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:45:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 03/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Message-ID: <aj-311xeb7JZe4CY@ChaodeMacBook-Pro.local>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
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

On Mon, Jun 22, 2026 at 04:31:19PM +0800, Daniel Henrique Barboza wrote:
> The PMP emulation isn't present in the KVM driver.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/machine.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index ba96ceceef..bd93d6f3a8 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -20,6 +20,7 @@
>  #include "cpu.h"
>  #include "qemu/error-report.h"
>  #include "system/kvm.h"
> +#include "system/tcg.h"
>  #include "migration/cpu.h"
>  #include "exec/icount.h"
>  #include "target/riscv/debug.h"
> @@ -29,6 +30,10 @@ static bool pmp_needed(void *opaque)
>  {
>      RISCVCPU *cpu = opaque;
>  
> +    if (kvm_enabled()) {
> +        return false;
> +    }
> +
>      return cpu->cfg.pmp;
>  }
>  
> @@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id)
>      int i;
>      uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
>  
> -    for (i = 0; i < pmp_regions; i++) {
> -        pmp_update_rule_addr(env, i);
> +    if (tcg_enabled()) {
> +        for (i = 0; i < pmp_regions; i++) {
> +            pmp_update_rule_addr(env, i);
> +        }
> +        pmp_update_rule_nums(env);
>      }
> -    pmp_update_rule_nums(env);
>  
>      return 0;
>  }
> -- 
> 2.43.0
> 


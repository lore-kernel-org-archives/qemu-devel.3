Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30Y1-0005td-Kg; Sun, 28 Sep 2025 19:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30Y0-0005tO-5L
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:11:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30Xq-0000ON-G8
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:11:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b3194020e86so639930766b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759101057; x=1759705857; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mog8oUm3GfSh/a1W7fWPJzrqCB9h73CM8E7faKrW9eE=;
 b=aN/Q7jSlJn7534dNqxtKgFFtdJpfZSLxyQ63AyArQV/g36/hYSN6b5XMSpmjmdS2nt
 cpeAvBd357yjM+X2oey+DzVtw63v/MDUKD0RQk3KTpFEf1pV969KHsqtfcJNcUFOX8xx
 itKa1kDw/vHtgkFqPe3UlELSsdoVEuVsyc33azWcIc1nHVKVlIEjSi04gBhjprtmJ2HD
 Mm4wTiqhKUYtxBvGQNGv3zr+23IcWApg6Rf7QnYIlgLuG9AuJk0PDO3ABmryEFeuHMlP
 5jDB/b/Cg3iuPCNZjja/Z3BAIOInkpsWKapL5dgBXemuVLwOP7juitceLQ1jmxWHMb8f
 toeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759101057; x=1759705857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mog8oUm3GfSh/a1W7fWPJzrqCB9h73CM8E7faKrW9eE=;
 b=hPbj2FP9FwuWkgFIFyEHmrFwaOMZAfedh+/wNUO8X2ZhYjAXgH//pqmkpoHFhp/XSv
 P0f8yUxuVmSqJ/6eQo+2ZRNWIkfs/d7GHmXGFBYbcaqlMKg6zD3B1chPjcYe75IrW/8F
 PrD0aEbO5rmhNHhlqW7oIsCe0JwfbkbYffkP5oTIChvE8iFOHe2zzFQE9NIrGhkHUev4
 jqrotPJXWKuurYp754P2f4V/Hyz+LRvIKlvdh2l6H8I0jFCfDXmPFsgsmMnE+sNGxbfc
 v6ppQmCO2Hut7jBNPFZrF2UDRP2dJ/8foQ4VWzRuYf4Kj9b4SA8HOeyJRakM8Ia3Wne8
 Lybg==
X-Gm-Message-State: AOJu0YxUIyd+mv4LbtlusXLAQy8x/aYuzS4BDS0jiUv7zx/hxzHGxAOR
 VcjVlQy4fHWCdqe0Ax4n0sTXRsILuHvo5eVWjUTqlceVfoSInCPhlHSR8B1ssP/MWLT1lLQGG+K
 ve7DCZ/rTXiNxdKSQ2BQUi1sK+YaaCNw=
X-Gm-Gg: ASbGnctjYyhVJs5d3hhHINHAtIqTr8PXwd9/ShsJVYmMtuYLr+jSO2Z8H/VrK4T7/0w
 hCXkAsnRNaUM6hab/tdKpHJyfLcwj7um3G6olEUDuwru1+E9nGp0gNP0CwYtNP6S7G4N/Gqj8Jy
 zh56H0FYujvBuYyIaWjJ0PBS3EnGk7F6m6duEF7mKbi6H1OZVL0olbHZa4NPlKUtyUU1LO5lh1S
 //EHALh8mWwZeuZ3O3SrGbQGCNg+8ccRzFuDoxOWsosaPb8EpF82UNuX26/yTeOgiY=
X-Google-Smtp-Source: AGHT+IF+S5bZdlBglMeEnZu1MlyGT6JihY1PP8pGsNeu03U+934BflgcrpcpssOARukQmW/JaJ8MD7Tnpv9Kg97R+E8=
X-Received: by 2002:a17:907:9404:b0:b0e:bb58:652b with SMTP id
 a640c23a62f3a-b34bbbd99camr1573491666b.39.1759101056622; Sun, 28 Sep 2025
 16:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-5-richard.henderson@linaro.org>
In-Reply-To: <20250923023922.3102471-5-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:10:28 +1000
X-Gm-Features: AS18NWBFjmti2V3rqLKnHCQKD8Uc7KWrVBCeXeHF1qMwbP1Mjqr-Zqja4dzrcOg
Message-ID: <CAKmqyKPbkLHOL-qhWxFMwj99Oc-Jdrijh7R=ZqFn0RN35A65zA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 23, 2025 at 12:43=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The tb_flush within write_misa was incorrect.  It assumed
> that we could adjust the ISA of the current processor and
> discard all TB and all would be well.  But MISA is per vcpu,
> so globally flushing TB does not mean that the TB matches
> the MISA of any given vcpu.
>
> By recording misa in the tb state, we ensure that the code
> generated matches the vcpu.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: qemu-riscv@nongnu.org
> ---
>  target/riscv/csr.c         | 3 ---
>  target/riscv/tcg/tcg-cpu.c | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8842e07a73..3c8989f522 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -25,7 +25,6 @@
>  #include "pmu.h"
>  #include "time_helper.h"
>  #include "exec/cputlb.h"
> -#include "exec/tb-flush.h"
>  #include "exec/icount.h"
>  #include "accel/tcg/getpc.h"
>  #include "qemu/guest-random.h"
> @@ -2173,8 +2172,6 @@ static RISCVException write_misa(CPURISCVState *env=
, int csrno,
>          env->mstatus &=3D ~MSTATUS_FS;
>      }
>
> -    /* flush translation cache */
> -    tb_flush(env_cpu(env));
>      env->xl =3D riscv_cpu_mxl(env);
>      return RISCV_EXCP_NONE;
>  }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 78fb279184..143ab079d4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -191,7 +191,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>
>      return (TCGTBCPUState){
>          .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc=
,
> -        .flags =3D flags
> +        .flags =3D flags,
> +        .cs_base =3D env->misa_ext,
>      };
>  }
>
> --
> 2.43.0
>
>


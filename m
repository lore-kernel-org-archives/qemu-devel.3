Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46433CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJK-0000Fi-3K; Thu, 28 Aug 2025 13:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureMb-0007uC-Q5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:16:40 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureMV-0006Qp-95
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:16:33 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d71bcab69so7602817b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394180; x=1756998980; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ysTN/Xxe44UFssslbTkxrDqj0xje1ZnmPrgfbk5B+U8=;
 b=Adom9l5Y+KhPHLjwHiz8gS7MilZr4RMS1Ei8K4KD7kjxOV81Dwp7+BFcY9HNSzmOLR
 taBkfabz/urKi7fQvqki56AKe7zNpyJ33A8DW4DmL2wsDP/dkDtQlTsgPv9r9X0+dAMS
 BMSQ8jlaocdWI+NsO9qOWazeB7mxd4yFdZ4vxvqy9LBAk4N4hIJuXH4f3cjY4/ixqAAF
 1mNU7zLbAnZXqv6OYoWnG+x4RU9lxtplKN6JwCaBgyD/FNuPlyyIHqshmS2e9U1VDyqp
 q2OtUeqlRm5lAcEanuZ+BkW9mFGGPTpOItsBmxYUfu1ZKzsbXfeqVAEN1/B8usZieTXQ
 Rccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394180; x=1756998980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ysTN/Xxe44UFssslbTkxrDqj0xje1ZnmPrgfbk5B+U8=;
 b=EdVXcYGB/xnPYDkH8GLEazXCvn0OxCZbhwFZ+eNw04Vv1EBP7k8G4zhu0lHnnD3rFq
 TCxxErxTLat27t73lCxHXyvWsfbny8cos2BnT69zScM5UKY49KXFFlCREO+0NcIjKXti
 Aijj6axgmSNHzbEQ8JpP6t8RrFOFCFS6T+0k5jB38i8pmkoIqZ/C7sIar/mtCfm6X3tj
 1jCfeuG5B8lw4WYBeOQKPF5stMY2kgmJNiBPHgPKKqmvAmzuv/WUcBnb5JHuH2KdBoTj
 u3/cFN+5K9TYIbDGhsGW/htGHkGsphKOgdiXB+50qxk8Mupweg45h/jUN1+mlH4EZRNf
 jPsw==
X-Gm-Message-State: AOJu0YwKnBMAnPMakPqjTwrLnOo9p32EBi3PfnzMc/jxpQbW0tGjyZ2/
 xrBii66APObNtkc4OSC0HqhwXJNkvp3jIVvvQm88b7p4Z/Bi1BPG113xOqSIDdI4Z/2IJp9yv84
 RKScHjTNttBhXgnW/ZTeyjqSXLYASsb5nkG2z2dFh2g==
X-Gm-Gg: ASbGncu+9rx+gs2n8zp3K9DiqZ8bjdIjnBoOFDN3gSveYwkReoNnK9um9r30PrlVWx3
 V4RNQm1IOF46hvRmIH5uSLqkNVdrNQvVqlfY4Xx1dSEu2Bgln0vmgElMAF/eY3q/fF4k/oJB3XL
 jF+hEqwVDtD7mUc0rxYetzOCulXbnq+5Gr7fku6QGzS7i/bulwe4P6OlMJUq+QqT/aqWLNwtGEn
 ZO2rGpHY8l8sRganQc=
X-Google-Smtp-Source: AGHT+IGOx+XD2JSIkKKsGOp3eDj9cZwM36/037eqV5VvgR4bzwhLpABv47Ui1pJxfteWWwx5V8sHqMNL2OsewJJhIAA=
X-Received: by 2002:a05:690c:6803:b0:71f:b944:1033 with SMTP id
 00721157ae682-71fdc43970emr289905957b3.48.1756394180193; Thu, 28 Aug 2025
 08:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-53-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:16:08 +0100
X-Gm-Features: Ac12FXyoUmqcd0R_d397CvTB9TbNrcBTmoBA1eDPawIn_fFlr8hsK2K0Ci4itJk
Message-ID: <CAFEAcA8P_8FRCQSPvV+WH4MELX10LQ5y1kmG8tMrnOAoM2WusQ@mail.gmail.com>
Subject: Re: [PATCH v3 52/87] linux-user/s390x: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> This lets us drop the ugly cast to uint32_t* in the middle.
>
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/s390x/target_elf.h | 12 +++++++-----
>  linux-user/s390x/elfload.c    | 28 +++++++---------------------
>  2 files changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/linux-user/s390x/target_elf.h b/linux-user/s390x/target_elf.h
> index b7d863ee66..670c7b3eed 100644
> --- a/linux-user/s390x/target_elf.h
> +++ b/linux-user/s390x/target_elf.h
> @@ -8,15 +8,17 @@
>  #ifndef S390X_TARGET_ELF_H
>  #define S390X_TARGET_ELF_H
>
> +#include "target_ptrace.h"
> +
>  #define HAVE_ELF_HWCAP          1
>  #define HAVE_ELF_CORE_DUMP      1
>
> -typedef abi_ulong target_elf_greg_t;
> -
> -/* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
> -#define ELF_NREG                27
> +/*
> + * See linux kernel: arch/s390/include/asm/elf.h, where
> + * elf_gregset_t is typedef'd to struct s390_regs.
> + */
>  typedef struct target_elf_gregset_t {
> -    target_elf_greg_t regs[ELF_NREG];
> +    struct target_s390_regs pt;
>  } target_elf_gregset_t;
>
>  #endif
> diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
> index 4113273b72..27109279e2 100644
> --- a/linux-user/s390x/elfload.c
> +++ b/linux-user/s390x/elfload.c
> @@ -68,29 +68,15 @@ const char *elf_hwcap_str(uint32_t bit)
>      return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
>  }
>
> -#define tswapreg(ptr)   tswapal(ptr)
> -
> -enum {
> -    TARGET_REG_PSWM = 0,
> -    TARGET_REG_PSWA = 1,
> -    TARGET_REG_GPRS = 2,
> -    TARGET_REG_ARS = 18,
> -    TARGET_REG_ORIG_R2 = 26,
> -};
> -
>  void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
>  {
> -    int i;
> -    uint32_t *aregs;
> -
> -    r->regs[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
> -    r->regs[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
> -    for (i = 0; i < 16; i++) {
> -        r->regs[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
> +    r->pt.psw.mask = tswapal(env->psw.mask);
> +    r->pt.psw.addr = tswapal(env->psw.addr);
> +    for (int i = 0; i < 16; i++) {
> +        r->pt.gprs[i] = tswapal(env->regs[i]);
>      }
> -    aregs = (uint32_t *)&(r->regs[TARGET_REG_ARS]);
> -    for (i = 0; i < 16; i++) {
> -        aregs[i] = tswap32(env->aregs[i]);
> +    for (int i = 0; i < 16; i++) {
> +        r->pt.acrs[i] = tswap32(env->aregs[i]);
>      }

This cleans up that suspicious cast, which is nice.

> -    r->regs[TARGET_REG_ORIG_R2] = 0;
> +    r->pt.orig_gpr2 = 0;
>  }
> -

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


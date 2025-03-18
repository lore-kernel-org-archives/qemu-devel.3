Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CB3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 16:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaFR-0006PY-L6; Tue, 18 Mar 2025 12:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaF5-0006O5-90
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:56:41 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaF3-0002WK-Hc
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 12:56:39 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso4657795276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742316996; x=1742921796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGqkqVo0mVjp3+qrB6oL0JhqJb9fnlJ86z6khneLleI=;
 b=mPZcptiYkpjyU0gP5sea54b38QmksMoJcnJXgevgGTgoa59AppDk/nLPMRzut+OxqU
 1KHSVX2FRsb3j/40tpDtV8rBKrxGNvfJL3bbtye5FDJsxakpmkD/gvJsOP+6uxoHHV+x
 GAJA5htGk5kiO3cCHJ4VUoO6I0gkNaSNPnp/C/NcRWKFPpAtDtyofOEogfpmmx2gMDrM
 BQ7CudZtyI3J6ZsLh/aNLqLRXtYdYqy9ju5bQDmiqgyoA0s3N+lZro11kVnRJSJZm7Fx
 YaWH7qWGtUAyIu5CD6k88qs4LiRmEdLw71dLvG7Eui858e/uqLuUnYpDQw49HA0nVCM5
 mYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742316996; x=1742921796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGqkqVo0mVjp3+qrB6oL0JhqJb9fnlJ86z6khneLleI=;
 b=HLTz/Z+BLYeSdqTdkL4y+QKal7pOn8aJdWdysV4Si6mfMS+adT9EPHEGTJtGKRFfce
 6e6jdSxZGWLg4uHU0U4ywwZ8QDkPKG9GfQUxq359dnJ5KUVyuag+46hbI7gM1tlaoH+n
 4Eu+3W91gVg2PxMCcD/UODHITFiRtXwCAi/2FWFoR3C14I7Sx70UakJijSfiEB3rzQCF
 5UoH4jgcQISmJrC4TqBt/Gak/WNH5TmNYAM3XB79KrgKGByk+g8hYNTf/8cv++aVVHa9
 WOBq4AZ15pGri4KtfK7+EcXz+qC0LKoOGWXam0nmifnJoE2Y0C/8+Ys+viqMXnWEHwbx
 Nf1Q==
X-Gm-Message-State: AOJu0Yx681n+MD/UlasSsUNve2Om/vBF7BVajJHvZ+kiRFtn+xt3cBXY
 TkDIMa58SFmxnbmK4pc/WkLWaDKGDsHN4MlevVxlSNLVaCFZtYAIR5Dh8qOjJ/VI4CoYcDX0Hpw
 Ygr3rEty3eHH01pY317YTZrWBis9dFz7W8aPaRw==
X-Gm-Gg: ASbGnculvdwzSj9a3xtSzVPXTOH2wuinwArrYA/Nqyo47WaKs01uHE54UKsvhAYA+mQ
 Ztt+YdnqV0EqPj2z1yLH+A63IC4NyokzXLQ9sq62LRHslHCp2WWRhvFCEUZ3lm7Ti6uL2AumQaV
 SFGLSyvc7PqyUzvLkES7OpthYmxY4=
X-Google-Smtp-Source: AGHT+IGMAosZhGvHezA4Xdvf8nNSylCOkSXaZnMFwahn7bkwmwFHjOm1woJQcIfwpkaSHaa40NF+CUXrgROnmWL1oKk=
X-Received: by 2002:a05:6902:1791:b0:e5e:1034:db93 with SMTP id
 3f1490d57ef6-e66793820b2mr16795276.34.1742316995641; Tue, 18 Mar 2025
 09:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250315132030.95209-1-zenghui.yu@linux.dev>
In-Reply-To: <20250315132030.95209-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 16:56:24 +0000
X-Gm-Features: AQ5f1JoXO7yYZB4iU_D_j1pag8a2rtan5Md7OkaC-e-6uH3nta9x3Df79mofxYI
Message-ID: <CAFEAcA9YUmXA=bA4FERwqSEP86RFUhUKUcLvVVSV64p_QJKnbA@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Sat, 15 Mar 2025 at 13:21, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
> by implementing emulation for a few system registers. ICC_RPR_EL1 was
> defined but not plugged in the sysreg handlers (for no good reason).
>
> Fix it.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>  target/arm/hvf/hvf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 87e35c1b71..650b7f4256 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1359,6 +1359,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
>      case SYSREG_ICC_IGRPEN0_EL1:
>      case SYSREG_ICC_IGRPEN1_EL1:
>      case SYSREG_ICC_PMR_EL1:
> +    case SYSREG_ICC_RPR_EL1:
>      case SYSREG_ICC_SGI0R_EL1:
>      case SYSREG_ICC_SGI1R_EL1:
>      case SYSREG_ICC_SRE_EL1:
> @@ -1673,6 +1674,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
>      case SYSREG_ICC_IGRPEN0_EL1:
>      case SYSREG_ICC_IGRPEN1_EL1:
>      case SYSREG_ICC_PMR_EL1:
> +    case SYSREG_ICC_RPR_EL1:
>      case SYSREG_ICC_SGI0R_EL1:
>      case SYSREG_ICC_SGI1R_EL1:
>      case SYSREG_ICC_SRE_EL1:

ICC_RPR_EL1 is a read-only register. But hvf_sysreg_read_cp()
and hvf_sysreg_write_cp() do not check the .access field of the
ARMCPRegInfo to ensure that they forbid writes to registers that
are marked with a .access field that says they're read-only
(and ditto reads to write-only registers). So either we should
not list ICC_RPR_EL1 in this list in hvf_sysreg_write(), or
else we should add the .access checks to hvf_sysreg_read_cp()
and hvf_sysreg_write_cp().

I would favour the second of those two options, because it's
more robust and means we only need to care about the access
permissions of a register in one place. Plus we already get
this wrong for some registers: for instance ICC_SGI1R_EL1
is write-only but we will permit the guest to read it.

So I suggest a 2-patch series:
 * patch 1: add the checks on .access to hvf_sysreg_read_cp()
   and hvf_sysreg_write_cp(): they need to call
   cp_access_ok() to check this
 * patch 2: can then be this patch without modification

thanks
-- PMM


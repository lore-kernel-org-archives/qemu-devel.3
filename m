Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E73606D53C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oRQQ/fvw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQkeV-00017s-JG; Tue, 10 Nov 2026 07:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQkeT-00016U-5b
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:08:37 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQkeQ-0003La-KC
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:08:36 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b33de9d2b1so14680947b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794312512; cv=none;
 d=google.com; s=arc-20260327;
 b=B7bIW6s5RTs9Jln+q9WuA6gJEMsD6dpML7wXLnEmyVK1sgYsPZbQNEe8qHuudGugDz
 nFKqvPE+zb8bhwHReIRkxJHGvMUyD/Ox5b3d4lCO302NI8gjUb6AKWiJ98UJVXBAYxJN
 AVf9ZtW1DWaYTdNZrSd86RRCXIb5uGhuFw8iQmihNENpoEJq8x00VXkfrlkLUPaOXcrP
 iwRdM0OLbXKgVPOQgu32gCgLdV26A5esDHviILLJZVc9yXZHJk9naH8RzFLTg8CxV6/j
 MPy1pm2YImHMYXuYMu9hMFrI2sXUdrL+1f6adYdWWeObqxtAcEVrQfgMnbPIkGZezGjP
 eqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Ovxb/H6Av1ushcU6sYw24es8QRANyTyddIE/T88Au8=;
 fh=lqyx/ROEiAKbmucG7LyGUG4oW1bWpCrnBF6Q9zlVur0=;
 b=joeZcRiJtJIYepr/KaF7v0RK9dSInicVGkxRb5QLAdWYv4PLrup0vkgnsoL1NqY7EY
 gMfMWfQLLWmRHy74uSKiv9D1pC7030LDXviYfmOS63PCDhmkT8G/JM2XtxEiqfIr6r/2
 7FCvAp63+i6ZFz/hkKoA09s2s2ku2IhalA9G4ruWnGJ1KyNIhIXJPmrdxezarq5rcXZj
 FJ6gcf9c/CfJA8prX1Y1YM3hhQESN3dJvxTClZy6UA4Fx0N64A/RRiLfIJ/0lN7Pw9Yl
 cnSVXOnxul99KCUgxwgLLGYliu7xztrVQsBBjLmPmY0/CiOSqDZv/6yE0EaWn+qkNn+L
 gDlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794312512; x=1794917312; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9Ovxb/H6Av1ushcU6sYw24es8QRANyTyddIE/T88Au8=;
 b=oRQQ/fvwrSZgYljQ7TEV+eCJvCRrsMT/mAgvBaHktMmiqVJZzbwsrmKTlAZlm2EcM6
 01Pdl6uwtFXn50xlh/FgD5AnY8dm7rxohKG8t7HDsUlJvX1Pjh1hM9lgmzQTCpg/Tg2z
 BtHitcGyDYcG7oDS5Dos6jDuks+X/q15FovssCYnqXwGA7iVMYQCh/v03wEPhcx/o7mX
 Bmgo79KrdzkK+kh6Ta48X7/FgezycvP/apr5MAQhY4K7fPT/S+MClm+iOdlBHOGfFkyO
 iAun4w3weyLKV8djgn7zrPwbdQ94w2xehGeFQJojrw1M1YpPll3KwiGMqmaN0PBVV/QD
 39NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794312512; x=1794917312;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Ovxb/H6Av1ushcU6sYw24es8QRANyTyddIE/T88Au8=;
 b=gUI3WYT6eAPR4Qfzz6znWYO5up6lTfsLmfonraf2P0Jw8suJxQ1bScRRG+KJyVL0lH
 nr5TSveVB3iWoYy/gvyQR3oF/wFLJpQUEdNJ6/VcmAcX4WrAktv8uosb9kjQrGx+UDI5
 VmzZ8NQ6JXE8xEgT2iY3jCLFXfpmF/QNWAgEMyO3n5DqSCeX/7Z69jAXK9StU4MnaKge
 gAkRGOuM+DedIx676fcWpQVyo42lHIrjXWR+onfZFi8TJsByOJc6Jp/izujfDbsobZGt
 LJKAhiz73QBDeF0EUgQ1Dcw9RH+e4rnUQ5KF2wnLGpyS37L8lwdGwnNAbSRFGYkbmyHf
 cmxQ==
X-Gm-Message-State: APuU4Z9ynwdbB8ECyVs4m3ExTR0L4YFti9EXP0QMdDrztoaptAsHqS1I
 yc1w9nLo6qZQgyxUiubV4KFsBNpCrhwxvyB9Qnmik6Rzz3r/xJO7JSBxgnk/DjIjjKy6vaTbm3O
 1VLnGrFTTZBP16sAhITjfN//3ljvVrYs5C4rNmL+hDg==
X-Gm-Gg: AYBFou2NxAvL2F/4d1ffr0h2VrN7DNuWYD0SV9R/g1/NB0Z9D1GvVh/ULfvFcx2XGT3
 6HT5HZtiCriAK1Qhk/lvjtaINCVGJ6tg+SAgiLJa3XJDCR5rnT+kugY+0cUJwjcW+UR+XlKjNKz
 1a4K1kFhun5DCV+/7EvTBDTlpH/U4ToTOPpHgw1ZtUAaX7NMB7V/6TI8jJ1w9aLoR10nRlNliz2
 T6jBsgOlAwx2heNei7S0Lyxgax4SeQAcI7B1H5T+4+fd97Bdr8UdbQSjN46tVMwD11tD9xLugon
 +JubkJ21l1dz/aeNHa9e8I9LaOJX8KgIHHUDmkynzuMBl5DyCYNbarkvPBDz/cF3Hg4Rnk4VOYn
 ljyo3x3ccL5qApxuyiZklR7MuPN3WXlUOxtDu5H3JOC0lot9dC3FSWYJstEKCI0sJJFkvfStz2u
 iIzvao03zRJLWvlnMwAvAr
X-Received: by 2002:a05:690e:1309:b0:679:b444:a344 with SMTP id
 956f58d0204a3-67c56608700mr1265838d50.4.1794312512472; Tue, 10 Nov 2026
 04:08:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
 <20240209105813.3590056-35-alistair.francis@wdc.com>
In-Reply-To: <20240209105813.3590056-35-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 12:08:19 +0000
X-Gm-Features: AclHuK_4EVKHEXGRSxqp8MZfgdx_EfT0X8uxmDoPNc5UuWq_iokmjCtZWyipu84
Message-ID: <CAFEAcA8RFU+1DE80+QfaTUS+AYN9R1SPDEGF2EnkJZ_6hK9FOw@mail.gmail.com>
Subject: Re: [PULL 34/61] target/riscv/cpu.c: remove cpu->cfg.vlen
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 9 Feb 2024 at 11:14, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> There is no need to keep both 'vlen' and 'vlenb'. All existing code
> that requires 'vlen' is retrieving it via 'vlenb << 3'.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20240122161107.26737-14-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Hi; I was looking at this code while investigating a Coverity
issue (CID 1467672) and noticed something a little odd:

> @@ -1816,22 +1815,21 @@ static void prop_vlen_set(Object *obj, Visitor *v, const char *name,
>          return;
>      }

This property setter forbids values that aren't a power of 2:
    if (!is_power_of_2(value)) {
        error_setg(errp, "Vector extension VLEN must be power of 2");
        return;
    }
and that implicitly includes ruling out 0. But...

> -    if (value != cpu->cfg.vlen && riscv_cpu_is_vendor(obj)) {
> +    if (value != cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
>          cpu_set_prop_err(cpu, name, errp);
>          error_append_hint(errp, "Current '%s' val: %u\n",
> -                          name, cpu->cfg.vlen);
> +                          name, cpu->cfg.vlenb << 3);
>          return;
>      }
>
>      cpu_option_add_user_setting(name, value);
> -    cpu->cfg.vlen = value;
>      cpu->cfg.vlenb = value >> 3;

...here we shift the user-provided value right by 3 without checking
that it's still non-zero. So the user can pass '2', for example, and
get past the validity check and set cfg.vlenb to 0 anyway.

> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b580b83f9a..5618769a00 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -298,7 +298,9 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
>  static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>                                   Error **errp)
>  {
> -    if (cfg->vlen > RV_VLEN_MAX || cfg->vlen < 128) {
> +    uint32_t vlen = cfg->vlenb << 3;
> +
> +    if (vlen > RV_VLEN_MAX || vlen < 128) {
>          error_setg(errp,
>                     "Vector extension implementation only supports VLEN "
>                     "in the range [128, %d]", RV_VLEN_MAX);

Here it looks like we will catch the 0 later, but it seems inconsistent
to do half the property validity check in the setter function and
then half of it later on in realize. Plus the property and its setter
are present in the base class, but we only do the realize-time validity
checks for TCG.

(The Coverity issue is in code that implicitly is relying on
cfg->vlenb being non-zero, because it passes it to ctzl() to get
a shift count, so vlenb == 0 would be UB. I'm going to mark it
a false positive because we do still sanitize vlenb in the
TCG realize function.)

thanks
-- PMM


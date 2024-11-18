Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617F1D4921D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD2nL-000418-2f; Mon, 18 Nov 2024 09:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD2nI-00040U-UU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:32:00 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD2nH-0004ul-9a
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 09:32:00 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9ef275b980so533803166b.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940317; x=1732545117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MhAdaVPB17968gemREtUHRV2S7Vpyh9Kc7ffCpxcGyQ=;
 b=cRpeqoIfd0/9oH0toF4cofY3RqMlm2BZq6vq3iLIg9HvPnk3mdTJVqELgVlRZW1Xwb
 4mgBPQ1+SgMLuzLb6KrOX9SZClX55U4yS4/cRzWb23hn6igrN+5WsWClHIGep9l30UYh
 W6hQlR7XFEMm7y/q7CRR60qN0ez4PlrhRpN+rMy9DvjHoq1r5erd6aU0baR57zOBNq9j
 xb3QTGUhioGRrPuQ/K3KeTTbEU4h2/57r4Lt67WUJLFf/DIZa69izdCOc1YpAgYWqWt2
 vreL0QYBobBcgKhYF5k5DcCDsxzQvF/2Ce63OcFk2cJAoe9FOkr7zmA1wv7O1BWlb5Nv
 llwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940317; x=1732545117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MhAdaVPB17968gemREtUHRV2S7Vpyh9Kc7ffCpxcGyQ=;
 b=G5HHsBJo+V4Rg0Z3VfreCQ/KB4iCFCTK5VDkNAmuoz5W6tBQeongR2OaS/aMYuOVOQ
 SMwFnC5SxnyIr6IveabkvSiSZm+sgnMw+zCjzchIOQY3Jktbz//P6DcswthED/jgOxRk
 wA0+WpnBx+/04Iypxma/h5hG8yqhhnv1AC0P+8L6Vr4yRNVz6FIWU95mvyl0Qy3BrEug
 S3qX42Fy8GemuTIC0ifM8NA/y8wMSzwzEyS20PplyIS1jl3FQGpyIadrd8jRLmSl5YHf
 gTTH4CPmudfpYg8mJnPEerwjFBqILHGQrpKV2aaLml+dQGh9uYzA/pHWy7+3XDsx1rEY
 k8DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2eVzzYYeAW24afe4UZgqceBEcku8080O1qtBasRgmAVpyftosqOablb4qonItGr1xv6BX/WpgfqWJ@nongnu.org
X-Gm-Message-State: AOJu0YwZIi+nwqG2QZcMfOHersUWGTB7RcDyn2ho/yxRA0RgECukUgxT
 adrHoM77PBU5Tojv5WL8Ar+qEQrz89+2SIPD8Etjok3jaxDnNeM8kCEzJBnN4kjTEJfTLueJvM3
 G76epoUWbZzNrZZ9ER+V+kLZ90wiMLewT5MO5Sw==
X-Google-Smtp-Source: AGHT+IHJMXigDsWQWVnTr6w4TtfnbaJCa3ZvwHOy2mlh0FRGysAwORdnomcIttYfcWdjJnnk7NQP5i7cE++b5N4sekw=
X-Received: by 2002:a17:907:d19:b0:a99:f861:ebd with SMTP id
 a640c23a62f3a-aa48340fc14mr1108960566b.14.1731940317282; Mon, 18 Nov 2024
 06:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20241117134931.37249-1-paskripkin@gmail.com>
 <20241117135022.37508-1-paskripkin@gmail.com>
In-Reply-To: <20241117135022.37508-1-paskripkin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 14:31:46 +0000
Message-ID: <CAFEAcA8ez9hQXJAPc+s8NpkFs_3_SAybe+HCizBm1mzsmJD-EA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm/ptw: use get_S1prot in get_phys_addr_v6
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Sun, 17 Nov 2024 at 13:50, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> To share missing SCTRL.{U}WXN and SCR.SIF in short format walker, use
> get_S1prot instead of open-coded checks.
>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  target/arm/ptw.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 50eed0f811..0d003a9f7d 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -85,6 +85,10 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
>                                GetPhysAddrResult *result,
>                                ARMMMUFaultInfo *fi);
>
> +static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
> +                      int user_rw, int prot_rw, int xn, int pxn,
> +                      ARMSecuritySpace in_pa, ARMSecuritySpace out_pa);
> +
>  /* This mapping is common between ID_AA64MMFR0.PARANGE and TCR_ELx.{I}PS. */
>  static const uint8_t pamax_map[] = {
>      [0] = 32,
> @@ -1148,7 +1152,6 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
>      hwaddr phys_addr;
>      uint32_t dacr;
>      bool ns;
> -    int user_prot;
>
>      /* Pagetable walk.  */
>      /* Lookup l1 descriptor.  */
> @@ -1243,13 +1246,13 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
>      if (domain_prot == 3) {
>          result->f.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      } else {
> -        if (pxn && !regime_is_user(env, mmu_idx)) {
> -            xn = 1;
> -        }
> -        if (xn && access_type == MMU_INST_FETCH) {
> -            fi->type = ARMFault_Permission;
> -            goto do_fault;
> -        }
> +        int ap_usr;
> +        int ap_priv;
> +        ARMSecuritySpace out_space = ARMSS_NonSecure;
> +
> +        /* NS bit is ignored in NWd. */
> +        if (result->f.attrs.space == ARMSS_Secure && !ns)
> +            out_space = ARMSS_Secure;

Instead of doing this, I think we should align the code a bit
more closely to how we do it in the lpae codepath. So before
"if (domain_prot == 3)" put

     out_space = ptw->in_space;
     if (ns) {
        /*
         * The NS bit will (as required by the architecture) have no effect if
         * the CPU doesn't support TZ or this is a non-secure translation
         * regime, because the output space will already be non-secure.
         */
         out_space = ARMSS_NonSecure;
     }

and then delete the current "if (ns)" code block at the end of
get_phys_addr_v6() and replace it with an unconditional

    result->f.attrs.space = out_space;
    result->f.attrs.secure = arm_space_is_secure(out_space);

That way we're determining the output space in exactly one
place, and the code at the end that updates result->f.attrs
is the same as the way we do it in the lpae function.

(PS: note that QEMU coding style mandates braces on if()
statements even if there is just one statement in the body.)

Otherwise I think this looks good -- thanks for doing
the refactoring.

-- PMM


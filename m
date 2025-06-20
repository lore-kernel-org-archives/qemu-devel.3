Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EABC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSYWA-0006FK-MM; Fri, 20 Jun 2025 05:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uSYW5-0006EF-Hh
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:58:37 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uSYW3-00030f-Qp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:58:37 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-712be7e034cso12781057b3.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750413513; x=1751018313; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YLMpxmJTIvKKwBh79n8bqkktkv0LVOtvZ+t75HK4Dw=;
 b=pcAJaDTxPCvor5MELN2Rf8iz2NUKP4peW74s0jsrz8Iob4SD3/zw17CvlRE6dtCNcR
 rb6p+wjhak/GSjcg3l+KHUuE/yXJzO4ZK2AldBK+2S8R/dI+aOxnfNhWQhBfYUNW+sFQ
 exYM6+56N5FZYHL+svwTs2hEFVn/VYauWkrF13mfXKXGlsT94VXp+S+ACeonjghj64u8
 aiJLLcZHQwNdCxwEp+6EZNTYpaAUADzwYBvOZs0rfjmJn3GI983U//aeG//A4GYaL2dW
 Z3Nm57c5wOteg3i8I1U4HgOm6tMp+cd3nBUvmCgxju/MtFlf1ZAUjHcSm4DINZMFnAsO
 Hfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750413513; x=1751018313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YLMpxmJTIvKKwBh79n8bqkktkv0LVOtvZ+t75HK4Dw=;
 b=pOfxU8cevI032AwrEYxAkbp5wk766+WvciwGIlHFTYfXhGJ3dneTQu55xv3rDUrcZX
 gjml5BQJ+JUXiLEW8M4tVGPOw6EZnVZ4yg5qfB/1AlD0sH3hwzhcEvNQ3e+BmO7xyygh
 ykQwWAGdUMdvagK7sp7kE08Tfr6crv0L+so354LEJLEdHKcooSYnfim5MEEHHe2JYENO
 UktcUD3rlveyffc0jqrmxAutBmnVBGSZYE9ZMyRTKOHJa7xnH2rXRnl8g5TwwtJQTqTq
 5Hs+syEfsOSzMC7Mo2uw8Z+vPbgIbtWRmYkXqoGhVx9vdjVydusDQ+vzSjVdtWXGT7l5
 0tGw==
X-Gm-Message-State: AOJu0Yz/3rXcKnEskzzW+qqi/JU9fWu+aFO9UFJtQRGeHj0v4vDVFHQe
 blLKDK8ptU1+/KFSVbHcn6+d/JL10xoqihBTL+YcGkl5VZ647GpDJrIJYpPi55pkopXMHgr59I0
 5m+78RgyUW0ig5eOgLhUSGHeOHkPa9fkV+pUimgZYuw==
X-Gm-Gg: ASbGncuLQLSOEWPmPQI8KbVqBd/ptpI8/3U2lahSix1xhy6akd7uvbE1k/3/Lx7b+ax
 JBXrvlv6qHbHqOrjK24E7ejGcEIUpxKyB4lg1Dp6GxmubG2kBeH0I+fhzWrCPp7SOKuAi+GNlS3
 6YE33qtwT8dmgIJzLh2awEmm/nzAxEbwlZqpIiv69AkrPM
X-Google-Smtp-Source: AGHT+IHypTntkrIn7m/7EnO9BcMBztrc5tZ1KQFuiKowtjsxe+0Vi2vxqm9ZXXv27ttWBkiiJA71HJGwlslqE4XQK4Y=
X-Received: by 2002:a05:690c:350f:b0:705:750e:37b7 with SMTP id
 00721157ae682-712c639d784mr27942687b3.5.1750413512819; Fri, 20 Jun 2025
 02:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250616201042.2196127-1-alex.bennee@linaro.org>
In-Reply-To: <20250616201042.2196127-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jun 2025 10:58:21 +0100
X-Gm-Features: AX0GCFsYW_4j0_l5oo3XSEtKfWysXqR7l_BSGuCUpGioIEyS5XSj29ocU7SKi1c
Message-ID: <CAFEAcA_TODi-ZAkA900eV02TyKKD+gib4YxscUomoDt=q+RT7g@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: clamp value to account for RES0 fields
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM cores" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Jun 2025 at 21:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> If the user writes a large value to the register but with the bottom
> bits unset we could end up with something illegal. By clamping ahead
> of the check we at least assure we won't assert(bpr > 0) later in the
> GIC interface code.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 4b4cf09157..165f7e9c2f 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1797,6 +1797,9 @@ static void icc_bpr_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>      trace_gicv3_icc_bpr_write(ri->crm =3D=3D 8 ? 0 : 1,
>                                gicv3_redist_affid(cs), value);
>
> +    /* clamp the value to 2:0, the rest os RES0 */
> +    value =3D deposit64(0, 0, 3, value);

Should be extract64(), as RTH notes (or just &=3D 7 if you like).

> +
>      if (grp =3D=3D GICV3_G1 && gicv3_use_ns_bank(env)) {
>          grp =3D GICV3_G1NS;
>      }
> @@ -1820,7 +1823,7 @@ static void icc_bpr_write(CPUARMState *env, const A=
RMCPRegInfo *ri,
>          value =3D minval;
>      }
>
> -    cs->icc_bpr[grp] =3D value & 7;
> +    cs->icc_bpr[grp] =3D value;
>      gicv3_cpuif_update(cs);

Yes, I agree we should do the "work only on the 3 bit field"
part before we do the "enforce the minimum value" logic.

The handling in icv_bpr_write() has a similar issue.

(Why was your guest writing garbage to this register?)

-- PMM


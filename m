Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E4DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD6Ej-00089R-Ow; Fri, 31 May 2024 13:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD6Eh-000891-Aj
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:40:15 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD6Ee-0006ju-Qd
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:40:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45eso2739123a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717177211; x=1717782011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gKWccaTWNBdJjFqoDLNh+dn28z3jkomPFk/ID1JrTs=;
 b=u3o6iE5d5NuNFZts+7+7mmG7+RxxmTST9dKRaKDO9tyIdDJGDUIt5wHHI7wUviZC/P
 WARAt0aOmrt0N8apzo21fX6q9M64boPKINYlB+StO+5fX3GrcPjgtQ1iVXipGtLfZErT
 BoKQD+xuH4Mf1E2QoO22f7VZk7bc7W+FWIf7qwEvY9hlKcv84ahGprtJ7OKaZ97si6Te
 5SpQzzKWMcG4jz/NJu/wmTOAXvgKYTU4kpnm77D2Aoi7+pdgJDtA2+QavhAMGNfFmv+B
 ZYPHKTbQugZXqxL+0OcAIVh1xhtp/qt2Rbjlato8x1MGE5+n/wILWgYuIrDC/Hbu7Eqy
 82Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717177211; x=1717782011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gKWccaTWNBdJjFqoDLNh+dn28z3jkomPFk/ID1JrTs=;
 b=t7pyuo7YyToYAwopRx4IbagRRmAo2SyT5fgCm3R6B+tXKdYCEa432N/KQIFRk+zkT1
 WIpApM/8TDIGwFjQaen/xaPbqMeWSfKbFg62rMmBXP2NdKgU+A90DNs1hTaBO/NCHSbC
 S9gQAn5SJYfZYYt7y3Ut0G411K+NiqK3CoTgtmmgInI6xKu5vb5I7D5e96qxtnrmTD6l
 I6LkIkCdyAf1U63YqJXtB17NdlgVwWYff7kSj2qmceTPB822R9OTwWCtWSJzN7gCKVVc
 bA7eCA+2R6gj+Mi65iERVLWrnjqC7CXEM3RdrSuHvBpsHNzBFoksQc7mGYdGOPzgV030
 CLhg==
X-Gm-Message-State: AOJu0Yz33u5PxUeFKI4RW2Cb1FAy49Sgi3yGLK8tVD1gTrJ4gMfTFaVp
 8tNB+HV8T/IVqxyiXY3+/4Vq5EIdygnhvnnYawVprBzMu2Q12Mm+y/fHk8TvFPDOM5bHRPLHN0i
 FvhfXZpcI7Z5mydNz9rcxDuE1oE9sqe9KjQntxw==
X-Google-Smtp-Source: AGHT+IHPs35W9cvtz3+zSESyKGm2mFB4VRfWZmH0q/A9RKzN+qLpyBz4nfaR14kTa3NDTLC8rBhVy5dPvLw4lMj6C1E=
X-Received: by 2002:a50:9359:0:b0:578:e202:137 with SMTP id
 4fb4d7f45d1cf-57a364b52aamr2153980a12.20.1717177210684; Fri, 31 May 2024
 10:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240303140643.81957-1-arnaud.minier@telecom-paris.fr>
 <20240303140643.81957-6-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240303140643.81957-6-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 18:39:58 +0100
Message-ID: <CAFEAcA92fO-Yi1eioFNb4rZhBOcS9NR5NWT0Cg6JFxUUsQC-mQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] hw/misc/stm32l4x5_rcc: Handle Register Updates
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, 3 Mar 2024 at 14:08, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Update the RCC state and propagate frequency changes when writing to the
> RCC registers. Currently, ICSCR, CIER, the reset registers and the stop
> mode registers are not implemented.
>
> Some fields  have not been implemented due to uncertainty about
> how to handle them (Like the clock security system or bypassing
> mecanisms).
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Hi; somebody has reported a bug in this change, which they found
using a fuzzer:

https://gitlab.com/qemu-project/qemu/-/issues/2356

> +static void rcc_update_cfgr_register(Stm32l4x5RccState *s)
> +{
> +    uint32_t val;
> +    /* MCOPRE */
> +    val =3D FIELD_EX32(s->cfgr, CFGR, MCOPRE);
> +    assert(val <=3D 0b100);

You can't assert() things about guest register values,
because then if the guest writes that value QEMU will fall over.
For "this is something the spec says is invalid", the right
thing to do in a device model is to qemu_log_mask(LOG_GUEST_ERROR, ...)
the situation, and proceed as best you can (eg treat the value
as if it was some valid one, or disable the clock entirely).

> +    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
> +                         1, 1 << val);
> +
> +    /* MCOSEL */
> +    val =3D FIELD_EX32(s->cfgr, CFGR, MCOSEL);
> +    assert(val <=3D 0b111);

Similarly here. (The obvious behaviour for "invalid clock
source selected" would be "treat as clock disabled".)

> +    if (val =3D=3D 0) {
> +        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
> +    } else {
> +        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
> +        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
> +                             val - 1);
> +    }

thanks
-- PMM


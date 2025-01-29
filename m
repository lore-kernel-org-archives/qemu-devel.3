Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01199C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwR6-0004sN-74; Tue, 28 Jan 2025 20:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwR3-0004qN-1X; Tue, 28 Jan 2025 20:00:05 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwR1-0004rz-BW; Tue, 28 Jan 2025 20:00:04 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4b9486a15a0so128526137.0; 
 Tue, 28 Jan 2025 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112402; x=1738717202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkdmX8gPEFyvj0m3HEF0go/A8M0DJshISK66TH0tYi8=;
 b=lmVufwg1CU2h2p8M+LKHg09qgjS6D0bLCdYgiqW0cy2Uc8yhw6g5N7tS6+boBVgYgj
 OrAWZqCBQJl6xvxBcmn7Nf3+354lXHcePSWUDJdMyQjUAAhl0GJ5TcL+N+nq8oFuz/Vp
 6NYfrO02Gla12UaO66BZ9EW78UY8RIcrnPSMmHd1Voqqphi4NQxQiQlFDQtDIfaQZXHc
 SVP6F7BCR2rjJ9zzakGQ6uKUq5TYfRZHhD1XheN++l+QOhxMBA/2n9HOa0SUH4CqBytO
 HBQT3eHtHfyJVKD4/+U1GmOxtx/tTw7wBldKgpsBBIC1EulrFxVzF2CFFw5Np96ujVhZ
 YCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112402; x=1738717202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkdmX8gPEFyvj0m3HEF0go/A8M0DJshISK66TH0tYi8=;
 b=vz5jXF204ZOGdgvQv6NifFiu7J3+nIXIFncF+4jgjbnd4BO9TxmIqVJ03gG/UihrES
 365SYLDUCY82ndV3eRPITVko5IV5E1XKymMgyR2VJ4foQ8DsZU3ufKBapFIaM/43ckjQ
 gf2AufKIqZfdhw8WYWl/eqofkK3dnaKRF+Sbwo1O0P9q3SnfmWetm6ieWuvFor582V64
 9eR9ytQ/QoscY/bMxnkz9G7kJgMi/ZIFy6bm1qw96Sm+glcAT1pSXz4/lxdGrT48NV2B
 WvzKmGZvTeA3Eq8CtTrIz7/tz86Z4uUHC6U6kuuRFAKrDvgsGpxRLU1m3L486d2x0SVo
 3C7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+nNRHz52KgPXmD9+IaLaiMYCAJ808goyuTAsbPk8Qkv+oCRhLpBTaVyqRZlpBSxAWa0yJX23Eoi5w@nongnu.org
X-Gm-Message-State: AOJu0YzlD2aN6t4fNeFHB0aLk3dWaI+kkhPvV8e1NFwaZE4FK7Mgdhza
 xpmdhCnWvfudGRGXtwbPUQ/p82K+ntd7Qf4tFiwRXNk4ASi33+TOlO97bYFzq6lbCWVPTH19W4E
 7YEjhG5GThAtYoW1qKYQ5Hwk1gig=
X-Gm-Gg: ASbGncuzfc060r1qS3GVI1WjXZTodAvS4g1uRajfyJwM2MMKv1PIkJlSVltEahiRicB
 iJwL4eSidl9tgSS7deWqbawjftznWN/0vNSfyR8yd61Un35Vyp2KgjssiGaC1BEh1SOpwH5PaIH
 FJrx8deDHUB2XfVAyWsFBMs02xiA==
X-Google-Smtp-Source: AGHT+IG7lXvX0zEqIGUUTvCRXAolTHF479WJCiPGZt8O8z5KVl5HZ/q6zEa0yorvGefyzI38OaSX82XHTjGJ7WCNk7w=
X-Received: by 2002:a05:6102:5798:b0:4b6:99c:dd8f with SMTP id
 ada2fe7eead31-4b9a3d936bfmr1611703137.10.1738112401908; Tue, 28 Jan 2025
 17:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
 <20250121184847.2109128-6-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:59:35 +1000
X-Gm-Features: AWEUYZk6TWtwTg8cPOEvSszN2evaXozmKciSxtGwAuMU6sbH_HUWlQiAeiWgPpE
Message-ID: <CAKmqyKM5-E7pF8YR+DQSCRciYvb=TERce6mCx_Uo_ASZNHX-sQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] target/riscv/cpu_helper.c: fix bad_shift in
 riscv_cpu_interrupt()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 22, 2025 at 4:49=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity reported a BAD_SHIFT issue in the following code:
>
>  > 2097
>  >>>>      CID 1590355:  Integer handling issues  (BAD_SHIFT)
>  >>>>      In expression "hdeleg >> cause", right shifting by more than 6=
3
>        bits has undefined behavior.  The shift amount, "cause", is at lea=
st 64.
>  > 2098         vsmode_exc =3D env->virt_enabled && (((hdeleg >> cause) &=
 1) || vs_injected);
>  > 2099         /*
>
> It is not clear to me how the tool guarantees that '"cause" is at least
> 64', but indeed there's no guarantees that it would be < 64 in the
> 'async =3D true' code path.
>
> A simple fix to avoid a potential UB is to add a 'cause < 64' guard like
> 'mode' is already doing right before 'vsmode_exc'.
>
> Resolves: Coverity CID 1590355
> Fixes: 967760f62c ("target/riscv: Implement Ssdbltrp exception handling")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..64d1d68550 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -2095,7 +2095,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      mode =3D env->priv <=3D PRV_S && cause < 64 &&
>          (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : =
PRV_M;
>
> -    vsmode_exc =3D env->virt_enabled && (((hdeleg >> cause) & 1) || vs_i=
njected);
> +    vsmode_exc =3D env->virt_enabled && cause < 64 &&
> +        (((hdeleg >> cause) & 1) || vs_injected);
> +
>      /*
>       * Check double trap condition only if already in S-mode and targeti=
ng
>       * S-mode
> --
> 2.47.1
>
>


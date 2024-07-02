Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A2FC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnNE-0007Rm-0N; Tue, 02 Jul 2024 19:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnNC-0007RI-A3; Tue, 02 Jul 2024 19:57:22 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOnN7-0007DI-MC; Tue, 02 Jul 2024 19:57:22 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4ef2006dcdbso1531611e0c.3; 
 Tue, 02 Jul 2024 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719964635; x=1720569435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mmGuU4HcCGcVuevecQuOch9qT0FPUYkZqIv7a4Gq8I=;
 b=L12m0qZ80gxizoLdK5GLDO4NS/Gslf6JO98Rpsc3AfV0aM5c8U6UH5wnLvdPGyjrr/
 C+4jwdikjKm9Nf+TJXx7zuVX/dEeTucjxtGnqhVUL75SEoYV2GaDS7G6J1wt8omaz+JS
 Gkhgz7uQPcwrtDxPPESUeKd0rwfHsGqYlVGdyzB6m+W1L6gJF7TJDhYf9/wSg1JDvkw0
 pxavAZGSGsLHsQ2mbf3WSraO3kkK6ApY8VVDCr2NuVsTREBRoEkCQMboWedXJIxzXfhn
 PToykWzAhJdXWa5ocf2+JH7GrUDpv9QBC0+OIbyEu3eaaa0iPmakgdGv4DX1LarFlIaN
 Mb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964635; x=1720569435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mmGuU4HcCGcVuevecQuOch9qT0FPUYkZqIv7a4Gq8I=;
 b=GP9/iCO00nJmpVyNPFiVZinVdrn58hhNzGVxPoMaUy3E+qoHDAKpXiSjRHEAZuZLki
 vAvc16NRdVS/WijP6r0WiwQ3aRJR4cTDmrWK1u+UYrOrnT8hFy9MVSvOopipna22ZvU4
 7h2h68N1kgouIfdG1VJGXEkHYOz1VwpY1S75FjNVQWBwuhqUYam3HqQ4aB20TFlRev3g
 nfeEawx+VwE4vrHdukJWIvY8AUpVu/3PArySB208G4WouB6rePfiuqOs+3hQM93tb8PA
 4czj0G8u46pYwL4e4U1fDPVvSDcZBvID0oNmi0qqql0tkiIhij5vlCqTP2NdCc6PnRO9
 gK6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxOoKeBtuW4pwSR4kXv9jDTw+uZGNNzQkpyeLVUi9MNxVwdDtepDeHrUSjDqZx41pXjAH9vMMjw7sKsu9ruPHzdSceD2w=
X-Gm-Message-State: AOJu0YwfgREprMpd9QgBnijPJiDvncML4u/h2HPFUKs8O945kHgagZbo
 WCjNEXoprRVECCczzNJBSiA9+tlE59jvUZHGmb1OrrudgE1yqGZ0zqCTWpn4C6AlnOUsKm13Cic
 8JqZkl/spU24ascG6qxK3g/TFPiOmoOdm
X-Google-Smtp-Source: AGHT+IHYIanUlBOfwAeR0rumUESVUGQTY/o8/h42TbacMn7mi9YG5nbdzO7Y/eI6r8GWDM0Kn5+cHYOC5IK1M8YqfFE=
X-Received: by 2002:a05:6122:4b0d:b0:4ef:56d8:9e62 with SMTP id
 71dfb90a1353d-4f2a565f73dmr12588314e0c.5.1719964635256; Tue, 02 Jul 2024
 16:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240627180350.128575-1-richard.henderson@linaro.org>
 <20240627180350.128575-3-richard.henderson@linaro.org>
In-Reply-To: <20240627180350.128575-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 09:56:49 +1000
Message-ID: <CAKmqyKPHi5+rYoEfcz3xxc=_-Q=ssxLNaGjbEHUrZCj3qWnR1A@mail.gmail.com>
Subject: Re: [PATCH 2/3] util/cpuinfo-riscv: Support OpenBSD signal frame
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, brad@comstyle.com, Alistair.Francis@wdc.com, 
 palmer@dabbelt.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 28, 2024 at 4:06=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reported-by: Brad Smith <brad@comstyle.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/cpuinfo-riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 6b97100620..abf799794f 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -13,7 +13,14 @@ static void sigill_handler(int signo, siginfo_t *si, v=
oid *data)
>  {
>      /* Skip the faulty instruction */
>      ucontext_t *uc =3D (ucontext_t *)data;
> +
> +#ifdef __linux__
>      uc->uc_mcontext.__gregs[REG_PC] +=3D 4;
> +#elif defined(__OpenBSD__)
> +    uc->sc_sepc +=3D 4;
> +#else
> +# error Unsupported OS
> +#endif
>
>      got_sigill =3D 1;
>  }
> --
> 2.34.1
>
>


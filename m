Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBDDC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 14:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUp4u-00030s-GF; Tue, 30 Jan 2024 09:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUp4l-0002tX-4p
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:26:59 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rUp4j-0001Ac-Eu
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:26:58 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-295bbf1a691so350476a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706624814; x=1707229614; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dmx4Ka9DN5RWmqmUXFKpQu1J7Mcpktk2XY6Vm2aAUE=;
 b=R7KfKXe1tSrq1WZhBrmahYGkGxbwI4e5eNdxFjpwgKfw5o0DoYBsf4O0DQCFjUKTnr
 hgG8XEhBewOEuTAAGCMbJCtXBShrkYwv9uz5lseudSdikFAvN1ssT8WTg9cMHBw9pJKa
 UI3t/0OD6u7d8hsk+JbNJxMrEF4XFQjgFEcC+1qfRch7LHISKYehDP7BqmhzP4ySB8bR
 g8rNcctxzdaPPTbbBO/BhRuF3bt/NAbNCe1bOI8l4JZkVBiDKN4PEQEgv2oR/TBKvTbm
 viegQtPo3wgLUvES5vy0YPyn/FHdHZWHrJEPLjMhWsCEZ2cezsYNV5MYfxnvaRPAl6hM
 c2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706624814; x=1707229614;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dmx4Ka9DN5RWmqmUXFKpQu1J7Mcpktk2XY6Vm2aAUE=;
 b=ZZmMQvVnXhMiVPILTm+tIt5qLCogbU1ll0XNVNEdUzNmVBad8rNb6TSIsGBlS57T+M
 tWQC3FjbNl7yI3GKQPsbsmO3Yf0xyF5+0mkXxCWXoWH5CLU+KtlQjVCtgm4osu3tL7iL
 PgmLOF0Fv0PLsT8hHzkMdFn6LfAu7U89Pxv8tu9E/LGS/iwkE4KnVoHZzdIzqIrWiauZ
 rV/c5o3wia0S6FyUeIwqI/L9wWywowopZDfFmfI/xXSf9H/FD1K5AClNZG0S9wSZ2a0Q
 WyPN5e4SqineUYFigMOi0iuZB0H3CiXwnJ/TWow/jnhEcT2GiZAsMrLTnBQKUX/WtGFB
 fOjA==
X-Gm-Message-State: AOJu0YyxKDYHb1SPObkKFncXrjyU67MV+Apv/FO6RV88S8OMkhDstRm2
 5isZSysvSfvqBlQsabK/TE/INnpKRubyunt8+S5uqMyfNWybxCCem+R/9Eoz2z9Jh8ihib21TgN
 U8yvLBawJ0d0KpbaE5B1/7XXMzjGEvuh9/xFy
X-Google-Smtp-Source: AGHT+IFs6jjAf5ZxQl371W80z8gC8l30FwHEyY8NvJC1xpXdPtChSBQ5eWeBbnp1+d0X8BUuh95kOyUgU/K1EdBuUbw=
X-Received: by 2002:a17:90a:6503:b0:293:f16d:e53f with SMTP id
 i3-20020a17090a650300b00293f16de53fmr5853742pjj.0.1706624814592; Tue, 30 Jan
 2024 06:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20240130113102.6732-1-philmd@linaro.org>
 <20240130113102.6732-3-philmd@linaro.org>
In-Reply-To: <20240130113102.6732-3-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 30 Jan 2024 15:26:43 +0100
Message-ID: <CAJ307EhCyuiO3w=2-BhAOAmCuzCTaifer-1ixKgrsr_DmZNphw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sparc/leon3: Remove duplicated code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jan 30, 2024 at 12:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Since commit b04d989054 ("SPARC: Emulation of Leon3") the
> main_cpu_reset() handler sets both pc/npc when the CPU is
> reset, after the machine is realized. It is pointless to
> set it in leon3_generic_hw_init().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks for those cleanups !
Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>


> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 2dfb742566..1ae9a37583 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -343,8 +343,6 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>
>              bootloader_entry =3D memory_region_get_ram_ptr(prom);
>              write_bootloader(env, bootloader_entry, entry);
> -            env->pc =3D LEON3_PROM_OFFSET;
> -            env->npc =3D LEON3_PROM_OFFSET + 4;
>              reset_info->entry =3D LEON3_PROM_OFFSET;
>          }
>      }
> --
> 2.41.0
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F4AC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNew-0007nB-Ql; Wed, 12 Mar 2025 11:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNeu-0007mk-Lj
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:06:12 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNei-00078Z-94
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:06:10 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e637edaa652so3403883276.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741791957; x=1742396757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4PeiiA3S0CdjAkERUDy+gTPML/kLhpIaBwfs+maPpw=;
 b=HyOeRpZcLOBO1PYxY4jXSjcSKTxfIUjOEqBnsy5K3JaOiypOKihFIS1EbtagXQCcR7
 A5Tm5syfdIMJ3qJ3GK7X6aKZG1GBMY/zNw9MpgoTxq9NDlEbz1aVZ/5Yye+u8yTgI9Wf
 XFZhDyj1Fh+9qHQXUpY4w0Qf532ObZWD2aWxeOjRgPXCbDqfNw9B/3qIb1qP2tvEzpIg
 BYN+zqTKJnpiFykDtS0qSI1VKIoH+QvjpOD+BlH1lvU1L/jMPASUqGcDQ0WI2sS/esZM
 IJ1hWCBwlBCvUx85rrndHvQ2zi/zFqza/Lz7OrkAER7YloycG5VkhAFSWGMqAr0ZowYO
 ssKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741791957; x=1742396757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4PeiiA3S0CdjAkERUDy+gTPML/kLhpIaBwfs+maPpw=;
 b=CBVwIfXuPO2cGoqpIaDpFZGW0MuVq1zkZZbwJ6xWhcpIJEGKFA26SLvt+YnUvfAZzG
 pgBs7ymuESQHWlMHpqpSAz7H6rn5Q7qd6tov353j+jzJTVTiwntCt39+suFhGg+w7JST
 We2ZhhP2b0tKqWAO2NFGI5p526whrzMxUzX8CKSBt4lyQDHpil5sgkYdN1V0h2HXnkvQ
 SJHbZhUM5NyXsvKTPXNrH4J/cmZ8OZ9TduZb7p7UBHAspCHe4p2fUdAv9DhiksceeDKV
 VT0ABdejfEFhc8vnzLG3IEctRjEnI02oSEagxRnBG0QbTBB/ap2opchyKf5YG0P52G3l
 6pjw==
X-Gm-Message-State: AOJu0YwZF5cFnC7UBrPHwJPIjvcXWpZI0EqOuWpGJPszjS9nHhaSU7U7
 aLL7nc6e48iDrZedz+pqDlDhLMlHkgoSyQt+oc7UNoN28Dbseivr5uw1vN3t6z0BGJzeUfsE/kT
 UAvexp2meVDJSLhDXJYpIvJyBhc2dIXyLAGTvVQ==
X-Gm-Gg: ASbGncuUMmwra97mX/vmSTr3/y7QVWy1ow7/pWprqsKcxKJp0PwAQprpxmGqAnHKFwT
 7BJkntk+pmkl50a2TQn/BAOZIZxvcZkcUh0dcjMl7Ikeyf0O0OVrBBPGMetZz8xIY4jsf/OktSR
 Zw/qoipVQxITbXc+S6uBrRdciK3to=
X-Google-Smtp-Source: AGHT+IHROczhO/1lAXeJPg+bHDc3ZTmheA9EYZwq6Sll/xjfzfTIMvU+lM3s0NNcYFSiSYUpdKO/0Qw89jSaTspPiBc=
X-Received: by 2002:a05:6902:100d:b0:e57:3d4f:47e4 with SMTP id
 3f1490d57ef6-e635c1d6628mr24151527276.37.1741791957118; Wed, 12 Mar 2025
 08:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250226170246.1971355-1-aleksandar.rakic@htecgroup.com>
 <20250226170246.1971355-4-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-4-aleksandar.rakic@htecgroup.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 15:05:44 +0000
X-Gm-Features: AQ5f1JoJerH9yFCQkvARsvDnb3H-oVsrz4LE2_GRHeaGk8G0eRwCR0A8Xumj1dw
Message-ID: <CAFEAcA8RjNTZsuhShFwFUHa+YP5VKBUw2RneUPwAJ9eOVAL5Vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "arikalo@gmail.com" <arikalo@gmail.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Wed, 26 Feb 2025 at 17:03, Aleksandar Rakic
<aleksandar.rakic@htecgroup.com> wrote:
>
> From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
>
> Skip NaN mode check for soft-float since NaN mode is irrelevant if an ELF
> binary's FPU mode is soft-float, i.e. it doesn't utilize a FPU.
>
> Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6
> from https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  linux-user/mips/cpu_loop.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 462387a073..07c1ebe287 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -304,8 +304,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
>      if (env->insn_flags & ISA_NANOMIPS32) {
>          return;
>      }
> -    if (((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
> -        ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0)) {
> +    if (info->fp_abi != MIPS_ABI_FP_SOFT
> +        && ((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
> +           ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0))
> +      {
>          if ((env->active_fpu.fcr31_rw_bitmask &
>                (1 << FCR31_NAN2008)) == 0) {
>              fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n");

Unless I'm misreading the code, the kernel's MIPS ELF loader
does not look at the fp_abi to decide how to handle the
NAN2008 bit:

https://elixir.bootlin.com/linux/v6.13.6/source/arch/mips/kernel/elf.c#L154

I think QEMU should handle this bit the same way as the kernel's
loader.

thanks
-- PMM


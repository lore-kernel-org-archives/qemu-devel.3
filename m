Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 08:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYLp2-0002RE-9U; Mon, 29 Jul 2024 04:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sYLoy-0002QE-Cp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:33:32 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sYLov-0000cF-PX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 04:33:31 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so1763294a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1722242008; x=1722846808; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRgpx0MqN25oroOswKhbxy9tzgZBjWKhFUXlERF55xI=;
 b=IDWAmOjoTJkuAD5+f2w3+ecofg4PK+ogIywZnyoDiGV4ZntVJ5AZ1Px3R+PfSZyFTo
 5j8eB/FPYj9D5OPJutWJ/l1caitWzti15NmNhYzla8S7VAf8FO83OudPv0AFRUQCtyly
 o+qwFeu3KOoK54UDmGc8eGjQ+PApBsP+mUf9MwpE5ygPm1NQxYGOfmrzF4XanRTPS3+U
 ZHbGd07fFK8vl/AVN4tCUfz1iE3I7/5VLiGU99Hb2zrESK/jCPraRE/XCUSRh4+VQU7q
 tFVb0rJCj1qkTzcAxmzTeVKEFMjjCl/KqlztpHAbH/0W754dou/Sfz0x6XW3TMzBhg5A
 wHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242008; x=1722846808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRgpx0MqN25oroOswKhbxy9tzgZBjWKhFUXlERF55xI=;
 b=V5mEuy+gr8yjne0LFmB1xkHjEzjdj6xchoJ7P7Tq+gURqsnnnEETbZMlofLk/f3BAl
 aM5Q7YVkswWae0AMARJn76l67PnrXu0CkN+O1hMbML+aJPXB7+7ISt+AUK+cwr6WkOe0
 hJ0Z0s1K0oopsQO22u8y/NoV/0XC+k/a0EMk+XMO642Ni5GHTJ1Y7g3x9bOZGbV3LKwv
 cdTvr3lEkFDXWH1/QJ/SZIoAWjL+14SfS68KplZKRiOO7XUfwmhNSd3nNS5utngdXUYt
 PW/8fXR2/K0h6Yi1Ym6oZ7hSKjmvpcdfFDixS4WN7VBqGV202opP4oz8z3aQwx4HyoTL
 +Y2g==
X-Gm-Message-State: AOJu0YxfPm58oUDEfXtoMHc92oOyeygfhZCzWSnyEmexN8/UuPLKtsC4
 HFFe4Y79SbzM/07WZKjfbkQAJpo7AdUfrdlwRT44IvZoeaturEAIv4M1M5UATUDRKJC9ntmctX/
 Z8HT72qifb+gJk7+jrTDds7I/Y9fwvKOnE6uuUOzGntEjDFg=
X-Google-Smtp-Source: AGHT+IGio02sCHmr95nP7xYbE/xd2QHq9RcBwY1IJoVb5TVJH5aKx0cRPteeCLCZt+RPTSGCC2VJXb3GE0zS7P06+hc=
X-Received: by 2002:a17:90a:3f82:b0:2c8:5055:e24f with SMTP id
 98e67ed59e1d1-2cf7ce885a8mr11017576a91.2.1722242007851; Mon, 29 Jul 2024
 01:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084639.983127-1-chigot@adacore.com>
In-Reply-To: <20240715084639.983127-1-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 29 Jul 2024 10:33:16 +0200
Message-ID: <CAJ307EhvEYa6owtcXmjnBp_9k3HQXbbpbQck9pgS5d9wXgxfGw@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52b.google.com
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

Hi,

Gentle ping + CC missing maintainers.

Thanks Cl=C3=A9ment

On Mon, Jul 15, 2024 at 10:46=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacor=
e.com> wrote:
>
> The BookE decrementer stops at 0, meaning that it won't decremented
> towards "negative" values.
> However, the current logic is inverted: decr is updated solely when
> the resulting value would be negative.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
> ---
>  hw/ppc/ppc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index e6fa5580c0..9fc85c7de0 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCState=
 *env, int64_t now,
>      int64_t decr;
>
>      n =3D ns_to_tb(tb_env->decr_freq, now);
> -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
> +
> +    /* BookE timers stop when reaching 0.  */
> +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
>          decr =3D 0;
>      } else {
>          decr =3D next - n;
> --
> 2.25.1
>


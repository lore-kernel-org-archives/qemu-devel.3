Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FA8C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuGx-0006t9-IO; Fri, 01 Aug 2025 14:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsh2-0003GY-Qs
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:33:19 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsh1-0001oz-60
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:33:16 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8e1ae319c6so961095276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754065993; x=1754670793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XmL7nih4YCXnsagdk5u4ElZjXKzj4y+qqLmDY2TtXTk=;
 b=y1suVV/teBWolwcxhQZqruBmDEBrvLIn4yFP7ReOZZoinK91Y31DJGow/vC5+ONGWN
 +pQvcShT+BqPQVcbaXaPEitNvIXt8Inm2B/BRHFZ0iAW1jTs/YPjIX1zweVRtU7FNpzd
 X1TlIwRPhQ0XFxe93YuLEBCPiN3fJ/4AxoQk8yn50pyby1hDA1NjA1QoObQASazlkNT5
 H2AhC2g5nx2d5JjKf0wum2Yr6eJ/hxANXpFAJ978Ko/0O6i5WWJACmHStfpAAI8eZS7J
 s/GWyaoIGx9Trp6am+j9TgdsEbPZCgpTAAE+KFeNcNpfpxJisHW7QURqRDaMUquB9MSV
 06mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754065993; x=1754670793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmL7nih4YCXnsagdk5u4ElZjXKzj4y+qqLmDY2TtXTk=;
 b=XQgq9hV39XN7qydJkNaPWGVjRwSU2KlrYxtSl27S3sojAxyBLHn+qA5zqP2r9o5D+r
 R/wenFekUs5MffWHgmXo7ug/TcIw3aB1r0yg0mm8nm/SpP1MKEx4fn3jlf5PX150ZfJ2
 2n9qzysmCikaCZNYXk9YX8fmxjjFd15ctzIySI6+PYW/9/vO51SRqhplcRtDdD9FO7Ct
 1Ef5K37O4HhMXxGFWyt+wi4rm5KWQkb2Z1KklLkFv5El6NmcQfkz8BT0HHhKzpq841AQ
 TAcjPahYnmF435mpFhdd58bMHak8NWgSobEXQAhX5/W+LlS1FgbR6ViDehsaBi7yalkh
 0R3w==
X-Gm-Message-State: AOJu0YwxCG0dT8rmi3nCy5yTlly7WA3EoO8l92UBp5p2QtBPD1AuVLnQ
 Ebmk189TYsTGFFxzLrHMU5mKP+ZwpMFbIGIQdSlauFb1tsOrtqmlLAML20lI+uVyLA8xlbQtPOG
 gwETKxkV+ecNSyyQZ05AMeoBi67NmNGX/aymguhN2Rw==
X-Gm-Gg: ASbGncuDBkl4YA5UOelNazyGl4IAmidO4yN+7N3+raaUuiZDKaIS/rRUas9LcuMzk4K
 c+jpUeE8JW/1Vbllx0Xna5VSPaOKp2+zjJPblP5VSlt0W1LZKzrr2NcWfIGFWDOaI/W2WRdJgql
 fecGOMbTjIaSkQmqfRJ0MezAkkaYsEn5md0JCT2etEEYk3ZFdWohv3zhN8pWctY0LO0OhnyNe8l
 hbrjZmonqaLDLM/aKo=
X-Google-Smtp-Source: AGHT+IEPU4i/S6Ivrg1uupx9Z4uWuWhF++k3Yy0VUyfigBGXT+ora13zP0qefSfM2crD6dT64QeOCAgGKlaOwL7aD3Y=
X-Received: by 2002:a05:690c:6d0e:b0:71a:183e:bfe6 with SMTP id
 00721157ae682-71b7ef6f308mr4557227b3.31.1754065993525; Fri, 01 Aug 2025
 09:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-25-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:33:02 +0100
X-Gm-Features: Ac12FXwMIX50dwoN_Lpf-r7Xtwh9JGG-EivSWG3NPhequCiVsoPZkbCBOZfszYc
Message-ID: <CAFEAcA9mJ4EanfdW3PuV2ntN7_PgX7HqP-RbZUwpbDMJ7bomdA@mail.gmail.com>
Subject: Re: [PATCH 24/89] linux-user/arm: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 30 Jul 2025 at 01:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 53 ++++++++++++++++++++++++++++++++-------
>  linux-user/elfload.c      | 41 +-----------------------------
>  2 files changed, 45 insertions(+), 49 deletions(-)
>
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 1f3bb96484..8974b35e8d 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -480,19 +480,54 @@ void cpu_loop(CPUARMState *env)
>      }
>  }
>
> -void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
> +void init_main_thread(CPUState *cs, struct image_info *info)
>  {
> -    cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
> -               CPSRWriteByInstr);
> -    for (int i = 0; i < 16; i++) {
> -        env->regs[i] = regs->uregs[i];
> +    CPUARMState *env = cpu_env(cs);
> +    abi_ptr stack = info->start_stack;
> +    abi_ptr entry = info->entry;
> +
> +    cpsr_write(env, ARM_CPU_MODE_USR | (entry & 1 ? CPSR_T : 0),
> +               CPSR_USER | CPSR_EXEC, CPSRWriteByInstr);
> +
> +    env->regs[15] = entry & 0xfffffffe;
> +    env->regs[13] = stack;
> +
> +    /* FIXME - what to for failure of get_user()? */
> +    /* FIXME - a modern kernel does not do this? */
> +    get_user_ual(env->regs[2], stack + 8); /* envp */
> +    get_user_ual(env->regs[1], stack + 4); /* envp */

This seems to have originally been in the kernel as
a half-hearted attempt to support a.out format:
kernel commit acfdd4b1f7590d0 from 2013 removed the
setting up of r1 and r2 along with the rest of that
partial a.out handling. (The commit message explains the
confused kernel handling of r0 which is the origin of our
"/* XXX: it seems that r0 is zeroed after ! */" comment.)

QEMU has never supported a.out binaries, so we should
clean this up too...

Anyway, this patch is just moving code around, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


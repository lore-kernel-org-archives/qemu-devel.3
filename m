Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C7FC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI1d-0006uc-10; Mon, 03 Jun 2024 20:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI1b-0006u3-JP; Mon, 03 Jun 2024 20:27:39 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI1a-00037g-2v; Mon, 03 Jun 2024 20:27:39 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eb236e27adso373623e0c.2; 
 Mon, 03 Jun 2024 17:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717460856; x=1718065656; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWTOe/tfjCXcGk0EYbvwZ35kxJOpjCa7a+Qs0WXKG6c=;
 b=OixzbgKaUsRk8kbqe55RTcJCUHh5HL83905NJPPmk9Ey+1EoBUAlHWWS/m/TUel7hl
 46Iu8IYeC26nOSo6YUmt8jSVSr5PDA78YDGpqsf9dLxHj//9WJMjCe1oPtB4+UOkGF9E
 esViN3owWzl5cBIbL+8EUclRwsogR8NLbttDJs8Jk0lOHb4yaGKJktFjCz86+lMUXLXX
 jCldMU6CAHsrvl/ZyA6qvyKmdiNVs+0IegxNI2X5DDd/JTNg/Op8EKXXDbfxdUfZQmOp
 3Tu9rlfjHcrhXEFvzmVD2We2EfuTCfjGHXNQ/EOW7g9FVbZiGP6EECA2pQySv+ogUVGv
 w30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717460856; x=1718065656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWTOe/tfjCXcGk0EYbvwZ35kxJOpjCa7a+Qs0WXKG6c=;
 b=NlAy4g/F8y+x4wGzTYrl7OeAumMQVeFeSkOUv19o+jBlZcJDU+eijTq9+wbqWPyMDB
 Z+GyAQkvhQ8MDpZJ8bjKuu9ipXXoIDgShm378dAhOP3O2zAHDnGsJEX9oDFizKvXhPA4
 5SsVcdWYtQg929YtkzFtD9fntTDjSMQGj2X/K/2clLUe0Y+mEK0+4mfTySaOn9PTsvip
 RxwTeG+ogqpjorCucfopYT6sLBMpTihTwjelrD1Kx+moI0tRC7OzBP+6gg+Bu2ATXiks
 tCodmPAupMJfWVBG39JrKeNIJ6hRg91ENNpQ8VQ3yrai6d9a6pXCbpjS6HDSbqMvBIhF
 zuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSCkZWpCwGZFDWpISRMLL65AwpwQUHmHdAhKVlSKcG1+01ASFbFTBRWAyu+VbuWWBn4OjzuedeLTqqNShhdzTGnTODb0o=
X-Gm-Message-State: AOJu0YyJD4m8cEZ/afRY9eL70tcF2nPbuAEiVB9gJvrqqmGC7mf35Lfa
 AJj6aUNyYfo+sYRjICsEntcprJNP9gX6dxdno/Q34HI66StaJGQPHb6YlUsoBY6UFO7pmmP4ieM
 uQz0QNBQ6F9vp6xYddn6HrbDTKEXlGg==
X-Google-Smtp-Source: AGHT+IFXWlQpNPABdImP9NmpdxYMillxWqogf9cC0uWf6POiY40zlfOo9zfm8xrPG4EQkphCCdeQLfZBZLYUo2L0y7A=
X-Received: by 2002:a05:6122:3126:b0:4eb:1219:b8c4 with SMTP id
 71dfb90a1353d-4eb1219e5d8mr7490982e0c.5.1717460854741; Mon, 03 Jun 2024
 17:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240227012405.71650-1-alvinga@andestech.com>
 <20240227012405.71650-4-alvinga@andestech.com>
In-Reply-To: <20240227012405.71650-4-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:27:08 +1000
Message-ID: <CAKmqyKMZN4Re05PoLWcWvDPJWZ_CuK9BDuoj2-CcFz9fZDzggQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] target/riscv: Apply modularized matching
 conditions for watchpoint
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Tue, Feb 27, 2024 at 11:26=E2=80=AFAM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> We have implemented trigger_common_match(), which checks if the enabled
> privilege levels of the trigger match CPU's current privilege level.
> Remove the related code in riscv_cpu_debug_check_watchpoint() and invoke
> trigger_common_match() to check the privilege levels of the type 2 and
> type 6 triggers for the watchpoints.
>
> This commit also changes the behavior of looping the triggers. In
> previous implementation, if we have a type 2 trigger and
> env->virt_enabled is true, we directly return false to stop the loop.
> Now we keep looping all the triggers until we find a matched trigger.
>
> Only load/store bits and loaded/stored address should be further checked
> in riscv_cpu_debug_check_watchpoint().
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index b7b0fa8945..9f9f332019 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -899,13 +899,12 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs,=
 CPUWatchpoint *wp)
>      for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
>          trigger_type =3D get_trigger_type(env, i);
>
> +        if (!trigger_common_match(env, trigger_type, i)) {
> +            continue;
> +        }
> +
>          switch (trigger_type) {
>          case TRIGGER_TYPE_AD_MATCH:
> -            /* type 2 trigger cannot be fired in VU/VS mode */
> -            if (env->virt_enabled) {
> -                return false;
> -            }
> -
>              ctrl =3D env->tdata1[i];
>              addr =3D env->tdata2[i];
>              flags =3D 0;
> @@ -918,10 +917,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, =
CPUWatchpoint *wp)
>              }
>
>              if ((wp->flags & flags) && (wp->vaddr =3D=3D addr)) {
> -                /* check U/S/M bit against current privilege level */
> -                if ((ctrl >> 3) & BIT(env->priv)) {
> -                    return true;
> -                }
> +                return true;
>              }
>              break;
>          case TRIGGER_TYPE_AD_MATCH6:
> @@ -937,17 +933,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, =
CPUWatchpoint *wp)
>              }
>
>              if ((wp->flags & flags) && (wp->vaddr =3D=3D addr)) {
> -                if (env->virt_enabled) {
> -                    /* check VU/VS bit against current privilege level *=
/
> -                    if ((ctrl >> 23) & BIT(env->priv)) {
> -                        return true;
> -                    }
> -                } else {
> -                    /* check U/S/M bit against current privilege level *=
/
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        return true;
> -                    }
> -                }
> +                return true;
>              }
>              break;
>          default:
> --
> 2.34.1
>
>


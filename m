Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F7DC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 13:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqXii-0000hp-FJ; Fri, 07 Mar 2025 08:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqXie-0000hV-UF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:26:31 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqXid-0007Fb-5S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:26:28 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so1399640276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741353985; x=1741958785; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zSDIgEnwut/0cuVmGxS3WfG5GsPK27jE0q3te0D2oOE=;
 b=s2ZS772f1ltaxo6a6LxmzlcUgdxbFuC/ZhGALWf1Dm5/nwPwN6Fgh8GX9kMyl0amxI
 Vu0QUT4Ud0AR4sPCoj2wHlOTDyZbtxi3LQYaeFEwp9mYdSh9iKOG+cERCVoMXZp3UlQE
 WlKrv7xff+Zb5zR9TSWFt5rQQtLyZGQEvY4WDa8MdUinfiQHinBoxQuGy6X53LjQN872
 XO6xvqM/leghiWh7hmsPdBb6Xq08QBNma2xmHAwaIX3BJ0byRHTJ5QTTGYUn5NLMqv6q
 52RVxh9iv0NDG4vR54ZXf5BUvKREQZPmVjplre8ydEaYtsjhTPMZ0Dxn2z2wWb3971bT
 MFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741353985; x=1741958785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zSDIgEnwut/0cuVmGxS3WfG5GsPK27jE0q3te0D2oOE=;
 b=dnNImCLufwchqWC35DjvvOFCi6j3nfpoXnhED+xeSvkQ6M4ErpE8yyoHgZTrRxWe/c
 68x48caQjcSOeyUCpkL89aa3gF0ByJxGNHqASnUqxUrLHax3VEUi908MwoyPU7IyLk0V
 KcdnegdsmU8oZ7xOpESI68EWtnPfk6VmuntbNEDTv585wk7k4BL0wGqHKrMpARb+GN8z
 nCLRRCBgzRE2jjQzO9ZNFaYwZ1ELmk3cN+ZlAG9tSae8TdC4aUCGCegOqBXz4w3g6ymV
 JSyHZImMqGQBYvVG7eROSsLOCkYFZw5of+vlrUowRh/ELlOFVp5lO1RU48dj4MzXszdn
 70mQ==
X-Gm-Message-State: AOJu0YxRlQK5Jn+v2y+6KTd6AoRVVZO2vCvFNG4WGjhCkPvz7xoxLjLg
 JEVtXn31r5IldW2CBPZMc6XZpDnjMqKt6eiVaXQlA+lAyA5ZJK8KClFiHJIHUw9RrwaYS4ofIEZ
 GyO606KA3qcJjYiU6bYWNHmvofUX2OFNdy5TZdxEcL+eFug4y
X-Gm-Gg: ASbGnctvoJbKkRCmplYpbnmEIbb34+6g1DDzpi4Ay2eOpBBPt1mByuPHTWtyewQ/D8B
 y2jeXh5E3VtM/DPusjU6k3yLCjd55a2XtzEaxEgoyxjygUMLcoBBkFO8R/vlczRRuPzy9uhKfmY
 PmSiVRK/0SdbR5tM32gZIgyr/t72Q=
X-Google-Smtp-Source: AGHT+IGpaaPKCgD6dGSgHh8MPsESAxvuLrvOuT8AY+A3Q8WEdecXZMm3/DJY56E/suCnUYB/+jiLn31FI18ZQAykudw=
X-Received: by 2002:a05:6902:e0f:b0:e5d:cdc6:7acf with SMTP id
 3f1490d57ef6-e635c1d7c51mr3868593276.31.1741353985523; Fri, 07 Mar 2025
 05:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-4-keithp@keithp.com>
In-Reply-To: <20250218212103.2024039-4-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 13:26:14 +0000
X-Gm-Features: AQ5f1Jp_B0srcvbhBQlDFs6uBkGUUstmJJw-XOcbkWU4je_rrbQ_V0uFhWeYnOY
Message-ID: <CAFEAcA-YDsGJNyARdv4_3TmzvDyT06xykzLCxyVXY3YZCk6bCA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/rx: Reset the CPU at qemu reset time
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 18 Feb 2025 at 21:22, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> This ensure that the CPU gets reset every time QEMU resets. Use either
> the kernel entry point or the reset vector if no kernel was loaded.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  hw/rx/rx-gdbsim.c | 36 +++++++++++++++++++++++++++++++++++-
>  target/rx/cpu.c   |  9 ++-------
>  target/rx/cpu.h   |  3 +++
>  3 files changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
> index 4afd77efd5..9e395ae345 100644
> --- a/hw/rx/rx-gdbsim.c
> +++ b/hw/rx/rx-gdbsim.c
> @@ -22,6 +22,7 @@
>  #include "qemu/guest-random.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "exec/cpu_ldst.h"
>  #include "hw/loader.h"
>  #include "hw/rx/rx62n.h"
>  #include "system/qtest.h"
> @@ -56,6 +57,34 @@ DECLARE_OBJ_CHECKERS(RxGdbSimMachineState, RxGdbSimMachineClass,
>                       RX_GDBSIM_MACHINE, TYPE_RX_GDBSIM_MACHINE)
>
>
> +static void rx_cpu_reset(void *opaque)
> +{
> +    RXCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +    CPURXState *env = cpu_env(cs);
> +
> +    cpu_reset(cs);
> +
> +    if (env->use_reset_pc) {
> +        /*
> +         * Load the PC with the starting address for the kernel
> +         */
> +        env->pc = env->reset_pc;
> +    } else {
> +        /*
> +         * Load the initial PC from the reset vector. If there is
> +         * a ROM containing that vector use that, otherwise read
> +         * it from target memory.
> +         */
> +        uint32_t *resetvec_p = rom_ptr_for_as(cs->as, 0xfffffffc, 4);
> +        if (resetvec_p) {
> +            env->pc = ldl_p(resetvec_p);
> +        } else {
> +            env->pc = cpu_ldl_data(env, 0xfffffffc);
> +        }
> +    }
> +}

Unless there's a strong reason for doing something different,
I would favour following the same pattern arm does for this.
(Or were you following existing code in some other target?
I certainly wouldn't be surprised if we already did this in
multiple different ways...)

Anyway, Arm splits up the work like this:
 * the CPU reset function does the "load initial PC from
   reset vector table" part (including using rom_ptr_for_as()
   to decide whether to do cpu_ldl_data() or not)
 * the board boot code's reset function does:
    cpu_reset();
    if (need to override the start PC because of the image loaded) {
        cpu_set_pc(cs, image_pc);
    }
    /* and any other CPU setup that's specific to kernel load etc */

That way if the user chooses to use the 'generic loader'
(-device loader) to load their guest image rather than
-kernel, we will correctly load the reset PC out
of their image.

You might then prefer to put the initial image_pc into
the RxGdbSimMachineState instead of the CPURXState,
since the code that cares about it directly is all
in hw/rx/ rather than target/rx/.

thanks
-- PMM


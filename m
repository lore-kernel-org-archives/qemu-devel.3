Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABFCC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2Ia-0005W9-SD; Fri, 14 Mar 2025 06:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2IY-0005Vx-TX
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:29:50 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2IW-0005R8-HA
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:29:50 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e63c3a53a4cso1636577276.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741948186; x=1742552986; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dOhW+BbCDJrnLdg7ZGblCW3fBpI0xRzuTSx8nnuc4P4=;
 b=rzEZ8QSERoSUHhoWhtH37Cb7KW0ct4/t82htGoWhwJZYTuOHK2IPcFpCjqBR2cbLJo
 XWVxc8nKWI3r6eH/YqcGVDgpnxE4jZxUBNh0cGTWxBA4U9/bJbKe5yx3nQ+s7FpZypES
 zBZTFS1ptIDbf1GSMZlU6TPsPSJTJBbxgOW0Ulzt+MKu/qj1m/vHqL7gpO1dfoapNjJv
 WC4Cy51Fd5NJd5rMN9f2d0DdPGA4Buif0Tj3u8V5JfSsdJBUE6/VKmWZHe9SWM/dEIPM
 NKK5zu4HXe2QMa5wgmIXcsJD5W0XpwBmtsYQekSER3F6b1QBfO5fnkAIlM0wiLM/CUxE
 jvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741948186; x=1742552986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dOhW+BbCDJrnLdg7ZGblCW3fBpI0xRzuTSx8nnuc4P4=;
 b=C7j1SBj3dRHIAmZyVS+Lscis0dEbI4xv2bhnJePPWgdp17/mQ/QM63784fRgzknRbs
 uhg8rYze4uuO7c6GtysyGrMmmNrYhQmjXQdzPA5wQ7GpR99XceCvVCIffoW6xIPLWCvt
 QaIwlAZS0V7NkNz5hORJEjr2xnuj8jW7fvoqmbwiPKUF6vIHbYmEw2xt7exTxc20tAMw
 ZSJDolg57rS0n5uPAAM+e6xGOHwjD1KW/jWZ+vaUP+XL6aP/bA5b9zw7m5x3Bq6KK2tM
 QTNWgruy4NsCFrVguk/QIItLx8BT4Hjh7SQpCg5c2Y6AdNMJCfmGiB7V9Olgx4ee/MsZ
 8obw==
X-Gm-Message-State: AOJu0YzJ4oQX0YGFDrRzbDk+HcFVJ4dipnZB/Qz93OQFmdScXvUY4IyJ
 6aKxftBdWrVh09dCVwEWMT+4TCcPdMzDeOSwmFwVXUVlLM+RvqLE1U2K0lrCxXpZQ5BH1AkH9y5
 WBTnJ/xyIuOj0EU/9540PqoOpl3IydABYdKWK+Q==
X-Gm-Gg: ASbGnctDKM5NXE8UfBPEbIe0riJzRfX7qPoZAw9AjAnowC2ZxgHZhgl+kfY35+3Ca6h
 6lcAw5osiwxVl6rCy64KAcSfqpksNJYmc0X31HG7B1uDA8cl1MiR8rP0jTLuVk1yuu8N3WavXDm
 Q39brRcE9OWGwXKM7NCW0ixgq+nQg=
X-Google-Smtp-Source: AGHT+IGO13mXOwPU5ekZ/xA+exeey1mo/vTiY16lwzpuBXok5uMJQqPGSjmOEgZVeOVnHtNQnWTRM/8uoCupLDBU0pw=
X-Received: by 2002:a05:6902:10c4:b0:e5d:bcc5:c33a with SMTP id
 3f1490d57ef6-e63f65c36b7mr2262883276.43.1741948186641; Fri, 14 Mar 2025
 03:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
 <CAFEAcA9yKETtDhJroC7RD5itUjsYAkj0fVXHJaUxoU_bce7Gvw@mail.gmail.com>
 <52ffbdcb-abdc-459e-8d49-a0c9e1a5de92@daynix.com>
In-Reply-To: <52ffbdcb-abdc-459e-8d49-a0c9e1a5de92@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Mar 2025 10:29:34 +0000
X-Gm-Features: AQ5f1JoOy3YqSTajzehdP8eUYxULBISmp4a_tdqI7WP_WgM0_LZ0nHeWaurMtHU
Message-ID: <CAFEAcA8KVogRXr1PAocWPJzj0nLzCiQc9SQ1n9rWHHF3P=ZEVA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Define raw write for PMU CLR registers
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
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

On Fri, 14 Mar 2025 at 10:24, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
>
>
> On 2025/03/14 19:22, Peter Maydell wrote:
> > On Fri, 14 Mar 2025 at 08:13, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>
> >> Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
> >> default write function, which clears written bits instead of writes the
> >> raw value.
> >>
> >> PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
> >> had ARM_CP_NO_RAW. target/arm/cpregs.h suggests this flag usage is
> >> inappropriate:
> >>> Flag: Register has no underlying state and does not support raw access
> >>> for state saving/loading; it will not be used for either migration or
> >>> KVM state synchronization. Typically this is for "registers" which are
> >>> actually used as instructions for cache maintenance and so on.
> >>
> >> PMINTENCLR and PMINTENCLR_EL1 have underlying states and can support
> >> raw access for state saving/loading. Flagging a register with
> >> ARM_CP_NO_RAW has a side effect that hides it from GDB.
> >
> > No, the CLR registers don't have their own underlying state:
> > all the state is handled by the SET registers, and it just
> > happens that you can read it via the CLR registers.
> >
> >> Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
> >> PMINTENCLR and PMINTENCLR_EL1.
> >
> > I think the correct fix is to mark all the CLR registers as NO_RAW.
>
> My understanding is that ARM_CP_ALIAS is ignored for KVM to avoid making
> an assumption what aliases KVM implement at cost of migrating one state
> multiple times. The CLR registers should also remain as possible
> sources/targets of raw values.

Why? There's nothing you can do by doing a raw write to the CLR
register that you shouldn't have done by doing a raw write to
the SET register instead.

thanks
-- PMM


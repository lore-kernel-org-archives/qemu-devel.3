Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027A5C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxpV-0001qd-3I; Mon, 17 Feb 2025 04:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tjxpP-0001qH-8o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:54:15 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tjxpM-00047t-T9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:54:14 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so2993651276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739786051; x=1740390851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IwGinL/otRWsi6z9nxR1HVwxb+/Db7dXINUceubg6bk=;
 b=zBQ8J4O9UYojCsVubvAw6NbyjcFVQnq+e4aQoKhwEA3PiHn5GclphZvGBM68dVPr6e
 uY2WYOWvDMyxYHoVIk9ksPR2Je2ATdv0kQ72gJpOTu3mfxuREYJMrR03MYwlumiQG8E1
 pCektnOLVuN3bamoof0inhzZvZ/q4PkYUzuHUAZFTxJATOEIGZUdWkJINFXEaWviFrtB
 lD1lVbqqFjyrUGuHvZkUuSGyKjij4iztSn8XToUZ/Vy6C9M01fDKm+HuRVLTlAjNQXkP
 TmwIwRaR/j4poD6K3JysYc4OZMV67rqGqhWEEAFE19b3J3T99dlZHm7QDEBhzo1icjX6
 BTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739786051; x=1740390851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwGinL/otRWsi6z9nxR1HVwxb+/Db7dXINUceubg6bk=;
 b=rPMeDFkjFhMJtitDFxC9fu3qL7u3hilV4mQ3GvUaNZsdOnBmvw5T1YYBj0TLf5MNLG
 HYf/YFJe54XxSHa+faNoSS7glwqNb6xIJiMdqM+PFignj1EVAj1Sfj5tcmlRXXLyRVA/
 Vs67wRK7OW+ptbvNFpMTiUoxOAZfG4par+Rn7tY+Wo5wIPv9xVqvhO/jS9slNIBsq1ih
 vO13jFNexphSBx92neGG+F21hfP4ESvkTI3ahhAyfU1TCt8vXQkiJy8w6OiT7Hd/VMel
 cCK284TUiX9W8nwwYKUmSowLOSmLf03h4rNeLvAk32RGYWpSCUZuynwlTYO4Uz14gRcL
 LyFg==
X-Gm-Message-State: AOJu0YygBDPUQYNHNLQ2jXB3evzu95VEDTLUPdEhJVhGkZe/WifQLcp6
 Q0Hnvb2RBa1+LjDHekWN7y6VswZjYv4eDlYCnmGeSa0uvxRBCH3xKPtPJutE9QU5VGPdbreaeWv
 O6cAih9t7WWtDwpgf0LKrHwtfLCtDIWpyse/5IUpZxZiBvO6+
X-Gm-Gg: ASbGnctP6qpoPEURGzwaDjHubpfmVrKcfpUy6RtT7hcvX2UsOrLEIIEay38zbirYsp9
 CAdGbLkcB6CHjy+lY1ZtMze7ole4wnQCtbc3wF58oagHUsYo8Kp92mD4Dqeq4GCd7IwrmfqqeJw
 ==
X-Google-Smtp-Source: AGHT+IGRmcsy3Z9FlMDMUosqgdS/u/4JVs6gUidAZo3e2pf6WIPpvkyIlVr5SAe+Tn7a/voEMJv/QnDUWATvjuTAqas=
X-Received: by 2002:a05:6902:2b8b:b0:e5d:aa04:5da3 with SMTP id
 3f1490d57ef6-e5dc90706fcmr6222758276.23.1739786051146; Mon, 17 Feb 2025
 01:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-4-keithp@keithp.com>
In-Reply-To: <20250215021654.1786679-4-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 09:53:58 +0000
X-Gm-Features: AWEUYZnJmx9XHsCS8qww0qh-LkyP9Nd77TcUQHOxZRrfQdv1kE1ysWB3ld79jnY
Message-ID: <CAFEAcA-Z13YZaHWfdp0xnW2tQL88OtxwF0nTdSoj2eJkULSbFw@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/rx: Reset the CPU at qemu reset time
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Sat, 15 Feb 2025 at 02:17, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> This ensure that the CPU gets reset every time QEMU resets.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/rx/cpu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 37a6fdd569..04dd34b310 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -27,6 +27,7 @@
>  #include "hw/loader.h"
>  #include "fpu/softfloat.h"
>  #include "tcg/debug-assert.h"
> +#include "system/reset.h"
>
>  static void rx_cpu_set_pc(CPUState *cs, vaddr value)
>  {
> @@ -129,6 +130,13 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>      return oc;
>  }
>
> +static void rx_cpu_reset(void *opaque)
> +{
> +    RXCPU *cpu = opaque;
> +
> +    cpu_reset(CPU(cpu));
> +}
> +
>  static void rx_cpu_realize(DeviceState *dev, Error **errp)
>  {
>      CPUState *cs = CPU(dev);
> @@ -142,9 +150,10 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
>      }
>
>      qemu_init_vcpu(cs);
> -    cpu_reset(cs);
>
>      rcc->parent_realize(dev, errp);
> +
> +    qemu_register_reset(rx_cpu_reset, RX_CPU(cs));
>  }

Reset of devices not plugged into buses (of which CPUs
are the most common kind) is a mess. But having them
call qemu_register_reset() themselves in their own
realize method isn't the usual workaround. Instead we
get the board code to do it (usually in the same function
that handles arranging to sort out the in-QEMU boot
loader, see eg hw/arm/boot.c).

thanks
-- PMM


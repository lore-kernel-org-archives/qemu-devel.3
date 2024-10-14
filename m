Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235D2D1625B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0KUd-0002sY-Uf; Mon, 14 Oct 2024 08:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0KUa-0002s7-6t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:48:08 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0KUY-0004rD-IS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:48:07 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so39590511fa.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728910084; x=1729514884; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kM79TXHsfWWOp3PAaFsigm/WkHWpSm/qj9ntAPFzurg=;
 b=v775J4tSb4kZ8xSxq//YE/A+ATsbgWGmb4S5UAdb4aniZ51N1BnO5qIyHDWZUzDnJ2
 GnFwNdyGcN8jZ46sZk7l3ch7PVS6DX89QRsSYuvTBpAeWkLVIGYoVWATIWWuXaTmdMez
 L7+hjpCKjqvm5Y8ChGIyKY+B9QEPuVR6MJFkrxX+UUvMzhzSPpp3FOff4d6tvoo0aVqw
 haxmqyGZfoB3JVyT+jhpwvzsHp+6s3qcAtIgyHqnyMlyK9mTDprL3z1ePCUsQIfka6+c
 Wcyx3FnjG/Gk8X6236+Q0XneTc1jY5DGRe+vhaz8qfNAEFKELPEWAtW3jtOzzvaIknWV
 q4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728910084; x=1729514884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kM79TXHsfWWOp3PAaFsigm/WkHWpSm/qj9ntAPFzurg=;
 b=v+I/37vbiKePWwHZ6BH8F2XHbd3/9AfWnpm/Gzz5k1Yu7K9RCc+bwczKZKFFRI2+Vg
 cxbg34DPAulaMAcx3K2/grr7siZVDOq3KfGNxxuJjLBjlDhCen5PMfRaCqs5aiMUXhhQ
 vmWrF+8Rc+IoM5wVXWj09BzaTyD+TmJ/ZoOPXf5siBU9YZULBr/cfznI5wm0WnfvAHCA
 MN1jOyRQ87rsq7OVdTbiudX0Cge+SHnL1vetbD6lL6WTB8BtGAyrRmNdeQa6tfLSF+Ju
 mLt4tBzkP7DCuzBJY3w9wDuDxKXwhheAiPlU66z+wRDPUzotVtBDWTb9hJRGCKCD/Rt3
 BouQ==
X-Gm-Message-State: AOJu0YzhY85oklvy/GWcDP5cHvflCl/5U9UKtnVGksl0FsPEnVxL3Ha+
 cVOz3sXtAaaCKJCz62kT2seHkUoEYgprR8sDC+RyTzN69A5ukCERGog2QbuZrejVNpDjpdyFWcP
 HareiJuY9jbgmEjSFOO+Bmd9bIhVZ/m6o9nxRvA==
X-Google-Smtp-Source: AGHT+IEZbkD6XyJC0hZgfTW8diZRCTA9oNbOp2+T47wWEH1w2QEDXEo3OfuJ2tVVywE24pE6uTsbl9mpeD1I2ndSiDM=
X-Received: by 2002:a2e:4e11:0:b0:2fb:5060:7037 with SMTP id
 38308e7fff4ca-2fb506070e0mr12484231fa.41.1728910083959; Mon, 14 Oct 2024
 05:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241005205748.29203-1-shentey@gmail.com>
 <20241005205748.29203-2-shentey@gmail.com>
In-Reply-To: <20241005205748.29203-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 13:47:52 +0100
Message-ID: <CAFEAcA_2EU8Q+=Zm7pKJpO42=nAeGf9jpCsoM8ped1ngw66gKw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/net/lan9118: Extract lan9118_phy
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Sat, 5 Oct 2024 at 21:57, Bernhard Beschow <shentey@gmail.com> wrote:
>
> A very similar implementation of the same device exists in imx_fec. Prepare for
> a common implementation by extracting the code into its own files.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/net/lan9118_phy.h |  31 ++++++++
>  hw/net/lan9118.c             | 133 ++++++-----------------------------
>  hw/net/lan9118_phy.c         | 117 ++++++++++++++++++++++++++++++
>  hw/net/Kconfig               |   4 ++
>  hw/net/meson.build           |   1 +
>  5 files changed, 174 insertions(+), 112 deletions(-)
>  create mode 100644 include/hw/net/lan9118_phy.h
>  create mode 100644 hw/net/lan9118_phy.c
>
> diff --git a/include/hw/net/lan9118_phy.h b/include/hw/net/lan9118_phy.h
> new file mode 100644
> index 0000000000..50e3559b12
> --- /dev/null
> +++ b/include/hw/net/lan9118_phy.h
> @@ -0,0 +1,31 @@
> +/*
> + * SMSC LAN9118 PHY emulation
> + *
> + * Copyright (c) 2009 CodeSourcery, LLC.
> + * Written by Paul Brook
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_NET_LAN9118_PHY_H
> +#define HW_NET_LAN9118_PHY_H
> +
> +#include "hw/irq.h"
> +
> +typedef struct Lan9118PhyState {
> +    uint32_t status;
> +    uint32_t control;
> +    uint32_t advertise;
> +    uint32_t ints;
> +    uint32_t int_mask;
> +    IRQState irq;
> +    bool link_down;
> +} Lan9118PhyState;

This takes state that was in a QOM object, and moves it
into something that's kind of a device but not a QOM
object. I think we should avoid that, because at some
point somebody's going to have to QOMify this.

Making this a QOM device is a bit awkward for migration
compatibility, unfortunately.

thanks
-- PMM


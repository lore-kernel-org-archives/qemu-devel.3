Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D193C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 15:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdX2k-0005cU-SB; Mon, 12 Aug 2024 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdX2j-0005bc-Iq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:33:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdX2a-0001AX-T7
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 11:33:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso598146a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723476778; x=1724081578; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zh+tcHdNJStvkyZi7SCX0p4WIPRkVyIGm6MjrcYoKk0=;
 b=jjUeNOJUVHzdeRRa7IDLnKxDBcIcttvWkIFKV8DOa8Vbu7LegOMLoI88eJQEv8KtQX
 wM5sFcdc0SB1GuRo0SuNTR8uOV0PaRJ+py86P7Ls+BZ3dalA2grQl5tzskunejjFyXQ5
 jBBdzqgEctNmG/61QOgOoQkz5qQoxHaUc3zd+tsbgxw+5DqRQ0cSIzjLl9FPJaAkQFig
 FLF+G1vFqX9rUe1kXtUoSg91prBfcqptL5+mnJHvr0MhNbk5/H+/J8pOht82ygmtHDzZ
 /sfvV89eW9jluNBjk6BrkMq1BZ/7UNYl7N8yFiaCHna8U1PmmAZmKuN9KRbComiJTKjv
 tG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723476778; x=1724081578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zh+tcHdNJStvkyZi7SCX0p4WIPRkVyIGm6MjrcYoKk0=;
 b=ZOyMRcGgJbzeZDDjrUvRoiiIjoUGJZH6VkuAGygK2sPEMQAhGQjYSbi8qhO3iEUbY9
 y9vMf3KnHn1FjBQiiuNfe2VBFGN1/ppl/OsNJmj/R7/A2Rw4hYJvSDCi0qUf6yOLLC0i
 JVQN0N+6A/rMH5KUtr0G+9nrbaSLl8fee04EY8/PJSm/XkjnVsTpVlGJ7JlB3C+CZTjf
 cbWSTLUeHJuwDLY1AjgB/q92AqqAqInmX6ZTsUj2tkffEv4ueL8z96w2+81MiPmksrIB
 IZ1H7NzS/5fG1vbPIjpHviLNxkVRj6qH7zPaIMn5WdWvT/8ffvhijrD+sq+fxeA9gDgU
 YRww==
X-Gm-Message-State: AOJu0YxwNnBhk9DshlLtEDYsQkZhCndByqmGedUZ3EB8s0t3mHGKikWh
 PqFlKR7V18h2i+hq2qCjgezrg04/dRO8NntxrnIvolUI/SQ/QruKeVVzuc0hQeIQvSyW/FM91Pr
 O8P5t++srF6EQavORUU3PezrNyfreHi/pIGXACqwwcJygJJoJ
X-Google-Smtp-Source: AGHT+IEdX+pzzAuuzCSkxd4huzXwbL3Jd14+XATfxnuAQOBhZagp/wcphaR16mQ9LmjE/yEzIelzvsilJCnN5ehsGX0=
X-Received: by 2002:a05:6402:5246:b0:5b8:4a95:2fe7 with SMTP id
 4fb4d7f45d1cf-5bd46176b0bmr34501a12.1.1723476777666; Mon, 12 Aug 2024
 08:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-6-tavip@google.com>
In-Reply-To: <20240805201719.2345596-6-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 16:32:46 +0100
Message-ID: <CAFEAcA8w47gZYV8GBQa3fNf1cBWNtm_k4DAdnOVt4RWBdSrghg@mail.gmail.com>
Subject: Re: [RFC PATCH 05/23] hw: add register access utility functions
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
>
> Add register access utility functions for device models, like checking
> aligned access and reading and writing to a register backstore.


> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  include/hw/regs.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 include/hw/regs.h
>
> diff --git a/include/hw/regs.h b/include/hw/regs.h
> new file mode 100644
> index 0000000000..8d0da0629d
> --- /dev/null
> +++ b/include/hw/regs.h
> @@ -0,0 +1,89 @@
> +/*
> + * Useful macros/functions for register handling.
> + *
> + * Copyright (c) 2021 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_REGS_H
> +#define HW_REGS_H
> +
> +#include "exec/hwaddr.h"
> +#include "exec/memattrs.h"
> +
> +#define BITS(hi, lo)       (BIT(hi + 1) - BIT(lo))
> +#define BIT_IS_SET(v, b)   (((v) & BIT(b)) != 0)

To the extent we need these we should be putting them in
bits.h with the other bit-related operations. (But
prefer the existing MAKE_64BIT_MASK over adding a
second macro that evaluates to a mask with a given
run of bits set).

> +
> +/*
> + * reg32_aligned_access
> + * @addr: address to check
> + * @size: size of access
> + *
> + * Check if access to a hardware address is 32bit aligned.
> + *
> + * Returns: true if access is 32bit aligned, false otherwise
> + */
> +static inline bool reg32_aligned_access(hwaddr addr, unsigned size)
> +{
> +    if (size != 4 || addr % 4 != 0) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/*
> + * reg32_write
> + * @base: base address
> + * @addr: register offset in bytes
> + * @val: value to write
> + * @wr_bits_array: RW bitmask array
> + *
> + * Update the RW/WO bits of a 32bit register backstore with a given value
> + * (discarding updats to the RO bits). The RW/WO bits are encoded in the
> + * @wr_bits_array with bits set being RW and bits unset being RO.
> + *
> + * Usage example:
> + *
> + * wr_bits_array[] = {
> + *    [REG1_ADDR/4] = 0xFF000000, // MSB byte writable
> + *    [REG2_ADDR/4] = 0xFF,       // LSB byte writable
> + *    // all other registers are read-only
> + * };
> + *
> + * // backstore is updated to 0x12000000
> + * reg32_write(&backstore, REG1_ADDR, 0x12345678, wr_bits_array);
> + * // backstore is updated to 0x78
> + * reg32_write(&backstore, REG2_ADDR, 0x12345678, wr_bits_array);
> + */

This seems like it's reimplementing include/hw/register.h
functionality. I'm not personally a super-fan of that API,
but I definitely would prefer it if we didn't have more than
one way to do this.

> +static inline uint32_t reg32_write(void *base, uint32_t off, uint32_t val,
> +                                   const uint32_t *rw_bits_array)
> +{
> +    uint32_t *ptr = base + addr;
> +    uint32_t old_value = *ptr;
> +    uint32_t mask = rw_bits_array ? rw_bits_array[addr / 4] : 0xFFFFFFFF;
> +
> +    /* set WO/RW bits */
> +    *ptr |= val & mask;
> +    /* clear RO bits */
> +    *ptr &= val | ~mask;
> +
> +    return old_value;
> +}
> +
> +/*
> + * reg32_read
> + * @base: base address
> + * @addr: register offset in bytes
> + *
> + * Returns: 32bit value from register backstore
> + */
> +static inline uint32_t reg32_read(void *base, uint32_t addr)
> +{
> +    return *(uint32_t *)(base + addr);
> +}

Pointer type handling looks suspicious here -- if
the thing we're accessing is really a uint32_t* then
we should take that; if it isn't then casting it to
one and dereferencing might be reading unaligned memory.

thanks
-- PMM


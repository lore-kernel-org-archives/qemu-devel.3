Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404C0F4BB86
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuyqW-00028q-6v; Tue, 24 Feb 2026 15:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuyqR-00028Z-N6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:17:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuyqP-0007WO-TD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:17:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aaf9191da3so38448075ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771964240; x=1772569040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbSACKEyZKX18CDdz8H88eTcevbsXKp5IRYpQJMzGes=;
 b=JCcc3wgum+1TF2ucB4fwEB/koYND0sXynYbHSxRWymEHbDzOPeyKDXGZoYlsVM/NH2
 ZJ5OkY8/phczfqAS4uQb6X9ZmTNLxeWhra5yY/BUFMe3TF66yhRfVkJ8mPti6ooyOrV7
 junXX2IoROOO5SOzrIJqBQNKeVn3SNtSM9WteIviF+UcMGYXcBhlEeG/J3m4omgCN2Ky
 0n7qUfJUH6fs7pJl8LyUs0jnnqxLQqy/D2pS58v2zwfSk2knltpJ1e71tkIgmOfYH7+c
 GsrLHtapnKhDEsycEm7kJqTjJHbhRU+RiI9GMBaxr+Phs7rcaSqx1uYBKJnR0+xdELva
 IWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771964240; x=1772569040;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MbSACKEyZKX18CDdz8H88eTcevbsXKp5IRYpQJMzGes=;
 b=SYe4eJkzmB+ARW7gI8beo519gNGu8+7ONNni5cZhoeGv0HEqN3550or8lTc8iKSDRp
 LX3Plyvq98t+2kFoaCL8Oxz8gU9t6fAkBQNKkA7cOBL76/CCLDKvjbKPC87szoLjGD1f
 S0aobnJC5ufRKfqIGXYQl9D72/tqLPhdd07HncC+QqUZc6LROjORrcAUezJPhy9p1Utm
 1+Qv+2kKElydLCpkEav/yTo0Iky3aRt1t3rrJiLHX7rZ4N/lkJA4Ttq/v/XUuwScCI45
 XbN8IxECWq8op/86aFsmAM+R/HSNL4VIB1Lx6TLklaBVrImRk2nidS44bl80iNuoRbwu
 5R/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMG4IjCq42YyQDF37cVRn/IecHias4JeWzFmBDqPfvHD9HGLgiw61QcS9PoS8BR7VyzR2pDKPwTpTk@nongnu.org
X-Gm-Message-State: AOJu0YxfMvQH2uqMdiGJToKzQsq/4uV/ZJVy2DLHIUP29bvbXpmw2xJE
 589HhK3RJbzyCDOR7S/7jbsLOuKvqNB33VquwLF7lZ5MnTqhxrPwZ2fqCDI9XwelJdA=
X-Gm-Gg: ATEYQzwhIoXfz09fOVCbyxIF68aKQNWq1wOjqVozor0VbK4NBq1T1JrNJDCdF+EhC6W
 rhjvygX+93IeMNBiWdIvfPoOYTWX+FtKEMHCDvbgWdJc960JoVQs1YtMRZu7sKGDVEeLwJ4jdMP
 ANTBZTkDPYDyyX+gm/raMHENozs34jEaMKnoK63tZQhzTQ+9UsvamJpqpFt15FjXpckP3AiJZfS
 pEwDdkgdHlGb9zasFug+eUSfYsgMOn39ojhrQiRuoghvoYIFjTc4yLpRuhsEgqzWzSECju4KaPs
 5z5Caws9R897JI7VE9rXU84bD1g0aXfUz5YghsLju9lC2eISIzXcNDgEXa1hu+kj/VndMT2QQhC
 ZLeh59qg76lrx0+c5Z0rnBWQzrX7ypOGmsQ9kLl7tm5zQtVarKfK4pFvBjvOAvkSUWxOijN3Z8c
 6HUnhKfJTdRrSHgnfAkdNoeV/OmP0KVcz4GnRLvCyTdtrqlRlM9bgdxwD2CsPM3L1B+ab6
X-Received: by 2002:a17:902:f652:b0:2a9:5f11:3a34 with SMTP id
 d9443c01a7336-2ad7441c3c4mr99658185ad.13.1771964240129; 
 Tue, 24 Feb 2026 12:17:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e350a9sm113785985ad.15.2026.02.24.12.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 12:17:19 -0800 (PST)
Message-ID: <889129d1-0f0e-4f89-83b0-aa9415f636fc@linaro.org>
Date: Tue, 24 Feb 2026 12:17:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] tests/tcg/plugins: test register readonly feature
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <e6be7001-491f-4f5b-9aeb-3d27727d7b9a@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e6be7001-491f-4f5b-9aeb-3d27727d7b9a@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/24/26 7:58 AM, Florian Hofhammer wrote:
> This commit tests the readonly feature for registers exposed via the
> plugin API introduced earlier in the patch series.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   tests/tcg/plugins/meson.build |  1 +
>   tests/tcg/plugins/registers.c | 68 +++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>   create mode 100644 tests/tcg/plugins/registers.c
> 
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index c5e49753fd..5005aa8dc9 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -6,6 +6,7 @@ test_plugins = [
>   'insn.c',
>   'mem.c',
>   'patch.c',
> +'registers.c',
>   'reset.c',
>   'syscall.c',
>   ]
> diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
> new file mode 100644
> index 0000000000..a7bd692225
> --- /dev/null
> +++ b/tests/tcg/plugins/registers.c
> @@ -0,0 +1,68 @@
> +/*
> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +#include "glib.h"
> +#include <inttypes.h>
> +#include <assert.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +/*
> + * This callback is called when a vCPU is initialized. It tests whether we
> + * successfully read from a register and write value back to it. It also tests
> + * that read-only registers cannot be written to, i.e., we can read a read-only
> + * register but writing to it fails.
> + */
> +static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    g_autoptr(GArray) regs = qemu_plugin_get_registers();
> +    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
> +    bool success = false;
> +
> +    /* Make sure we can read and write an arbitrary register */
> +    qemu_plugin_reg_descriptor *reg_desc = &g_array_index(regs,
> +            qemu_plugin_reg_descriptor, 0);
> +    g_assert(reg_desc->is_readonly == false);
> +    success = qemu_plugin_read_register(reg_desc->handle, buf);
> +    g_assert(success);
> +    success = qemu_plugin_write_register(reg_desc->handle, buf);
> +    g_assert(success);
> +
> +    /*
> +     * Reset the buffer and find a read-only register. On each architecture, at
> +     * least the PC should be read-only because it's only supposed to be
> +     * modified via the qemu_plugin_set_pc() function.
> +     */
> +    g_byte_array_set_size(buf, 0);
> +    for (size_t i = 0; i < regs->len; i++) {
> +        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
> +        if (reg_desc->is_readonly) {
> +            success = qemu_plugin_read_register(reg_desc->handle, buf);
> +            g_assert(success);
> +            break;
> +        } else {
> +            reg_desc = NULL;
> +        }
> +    }
> +    /* Make sure there is a read-only register and we cannot write to it */
> +    g_assert(reg_desc != NULL);
> +    success = qemu_plugin_write_register(reg_desc->handle, buf);
> +    g_assert(!success);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
> +    return 0;
> +}

Looks great, and nice to have a test for this.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


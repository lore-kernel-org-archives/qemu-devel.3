Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C273C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugxI-0001Bx-1d; Tue, 18 Mar 2025 20:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tugx8-0001Ap-Cl
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:06:34 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tugx0-00040o-W4
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:06:29 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86d6fd581f4so181750241.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742342784; x=1742947584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epCRWuiXBCyESFHRb7fV+2SlFXfsYPzJ7Nl3cJ3bU4o=;
 b=k5wgtPAlWX7lBwPwz3G1Akl+UdxTyChEUzcxpnAhk+ogfDxCG6f72aiT9qL/HWg+H/
 krkvYMMzXG/pyOvYAqvneToN5AT422xotsCtH/S5YTR5QBy3C08aiKVb1pU8qC1I5hE+
 GdkwbpqiNif40VwTUaVXKn6t7FYBkmGl6v6+hTey6D1g8A084L8+5qqXkAH50raeGcq/
 UrnJlzyaH6GSyjfiRhyiIR0AtSTqxKjDXF4t6IskenlVZyazjYoH7YI0k71zNIHjzkAV
 6cwszpIwIC7ySl9ZOPnrBMYDxggX6fFKJSYrcsJsHG4JwpZTzieOMRZMMLJ/Hm5pViRm
 Vf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742342784; x=1742947584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epCRWuiXBCyESFHRb7fV+2SlFXfsYPzJ7Nl3cJ3bU4o=;
 b=QyrDO7FsqapEqOe7uE3Bl4jzF3t8LBb5DAwGO+gBR7pTTqP6/RvSBtJ0wTWEsECjYe
 ikzwz+6nmSqmxHiFwXaE+2k7b6uuyDwT+tPjaFS5USAxVrOzifut/HGBYOw2h023jbR8
 fDir7c11AYj+SF7u6veoixTWKuGa2ho4ISPkr0Nkzfv6u+8LYpHsfO8sjNR4vK0Ns5+I
 KQJynFiqDySkMFsu0SadJBWzSj2/uCUEziSMcnrKO+Vv3FTKgWcDXk4lKCTrgGIIbs8/
 Je+7d2gNItDMJRg781jSV6m23zmyBEi6ZukRaWNLw+zYgGUOjgPR8tQoA+GUmz0QgmLa
 +UbA==
X-Gm-Message-State: AOJu0YwaVif2LYoZDmKqaxWiLapWyo31RuwmYujXve2hsaZRUhiCYRWm
 UzUZIHWlnr/BT44ujb13bgcW0sY0+eb+WU7L25RXTH5mVQVjB6GFDjYIIINpnGKhOF9quSfyEG0
 qSZBBLKFIGiKj5iHWylMzbfUulev2yy1w
X-Gm-Gg: ASbGncs8bXYbAZzUY4LwbpkREN5pzZaMAS2r3+5D9hNA8+Fshp6JlQLowQwgQxBP9tK
 3PhZv5ZHw3y5hciEofM7ZwS+im1mPnIAIx0swW4/hol3t5wqKRSpy9Hty9NnJjtm3rR53YyhC6u
 Atf1iSTcegeujULu+qe0s0DX4fdR7d8T1C1HipVg2MyIJCczXG3rZkB90=
X-Google-Smtp-Source: AGHT+IHSA5En1LPQvXgjq6wS0QyW3LJVzMJbyljyduPzZPFAe+W8G2q4b1ANttqXpAWGAbI2u02MwddKuEWzNe3QsT4=
X-Received: by 2002:a05:6102:570d:b0:4c0:435b:5dd2 with SMTP id
 ada2fe7eead31-4c4da49d31fmr4805733137.1.1742342784501; Tue, 18 Mar 2025
 17:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
In-Reply-To: <20250318213209.2579218-12-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 10:05:58 +1000
X-Gm-Features: AQ5f1JolVppkqqWtJPtof-1vZu7E3h6NYVQZh6gGdk8qV7KRDa2apuc0MZNKQE4
Message-ID: <CAKmqyKMhh0m1RdTSo627h4YWsiLCw3jrQjY2oCzdk1r9qz01kg@mail.gmail.com>
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Perform aligned atomic reads in translator_ld, if possible.
> According to
>
> https://lore.kernel.org/qemu-devel/20240607101403.1109-1-jim.shu@sifive.c=
om/
>
> this is required for RISC-V Ziccif.

Thanks Richard!!

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/translator.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index ef1538b4fc..157be33bf6 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -265,12 +265,14 @@ static bool translator_ld(CPUArchState *env, DisasC=
ontextBase *db,
>
>      if (likely(((base ^ last) & TARGET_PAGE_MASK) =3D=3D 0)) {
>          /* Entire read is from the first page. */
> -        memcpy(dest, host + (pc - base), len);
> -        return true;
> +        goto do_read;
>      }
>
>      if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) =3D=3D 0)) {
> -        /* Read begins on the first page and extends to the second. */
> +        /*
> +         * Read begins on the first page and extends to the second.
> +         * The unaligned read is never atomic.
> +         */
>          size_t len0 =3D -(pc | TARGET_PAGE_MASK);
>          memcpy(dest, host + (pc - base), len0);
>          pc +=3D len0;
> @@ -329,7 +331,39 @@ static bool translator_ld(CPUArchState *env, DisasCo=
ntextBase *db,
>          host =3D db->host_addr[1];
>      }
>
> -    memcpy(dest, host + (pc - base), len);
> + do_read:
> +    /*
> +     * Assume aligned reads should be atomic, if possible.
> +     * We're not in a position to jump out with EXCP_ATOMIC.
> +     */
> +    host +=3D pc - base;
> +    switch (len) {
> +    case 2:
> +        if (QEMU_IS_ALIGNED(pc, 2)) {
> +            uint16_t t =3D qatomic_read((uint16_t *)host);
> +            stw_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +    case 4:
> +        if (QEMU_IS_ALIGNED(pc, 4)) {
> +            uint32_t t =3D qatomic_read((uint32_t *)host);
> +            stl_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#ifdef CONFIG_ATOMIC64
> +    case 8:
> +        if (QEMU_IS_ALIGNED(pc, 8)) {
> +            uint64_t t =3D qatomic_read__nocheck((uint64_t *)host);
> +            stq_he_p(dest, t);
> +            return true;
> +        }
> +        break;
> +#endif
> +    }
> +    /* Unaligned or partial read from the second page is not atomic. */
> +    memcpy(dest, host, len);
>      return true;
>  }
>
> --
> 2.43.0
>
>


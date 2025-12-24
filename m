Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C27E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUGr-0005oY-0D; Wed, 24 Dec 2025 14:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUGo-0005o9-Lh
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:11:38 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUGm-0004yK-WA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:11:38 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so715513a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603495; x=1767208295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsMugTANubwzO8+MQNcvXEyznuIm+0njVtKa2TEcCHk=;
 b=Qvb+dmQB9XZuWh8XIjRQzM19+paKv4QOFkJqWkjdjt7NwPGD21+CV8coeX0qHL8ibd
 kgLgPwYv8fWqv+lFaQJjYhk3pnWYHMeGUwPI4weeiCmzxLf+Owt0J/mS482tvNwmUoIR
 +Os1QyC0gxQ8PefU0f+Jukr9dEq37KLOwhNf01N9HTk5a0TQYS+kjLAKfuDSdY1AqZbs
 xIGtdZl6M224VC41x6i/ZDy1vxEVCwSYyk+mK7zDpBuDZaMb6x/2RuMzA4nR35e5Fd+0
 TwQa607v3kt3vk3Day3cV+oEV6IAhAYYPvX+UBR597LbUp07yABxgkbhPcL21YFhJVbv
 b60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603495; x=1767208295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gsMugTANubwzO8+MQNcvXEyznuIm+0njVtKa2TEcCHk=;
 b=qzKoQ8js05Jf11wX1c4Gqeo0XfL2RH+R8mlfSFkPdY8qy+NxPuZZUtCpxL8C5mCou9
 Ya0yho/61x1DJP+W3rH16kBd8Bos/dLctusdAL6OFARwd7axEJ+RywfcTErF/G7dz+Xr
 ig4y6HzErXD+y/KLb5WjdR93RymH6+h/wAqaVEor2txY/RFJRGKNGAWnEGn/MEiwktjb
 0iS0d+N+/FpJyyUJ79U82kVFMo7HsYehSphjBQ6qjFyAykluOSoIKSWcXKSDpOm04aFQ
 kPIJOuep+2S6YUn5CTfhBZwFBLMrSjqYaHg+FGkOmOlewt4Vy99LAy1ijOWVmo+AQTQ8
 Ju7A==
X-Gm-Message-State: AOJu0YzrSuDs5txJ09cAD7c11A/TPfdW30miaJEfoqhjMUap4JRmTcqt
 ivc613SM8Qff1twC6VhMBwkad5866Hwm8GvQVp8J8U6wOq/Vb1BWjYtU1J56j/eaZRuh/3jJZiS
 q9SCBDob4ntiuZQzNXfvgc66W4ZfyueObZaJZuuS7eg==
X-Gm-Gg: AY/fxX7qWUIwOp6nX0oBwswvuHXVjWCxvpAmzJYcQtkTJim079cahk9DZvQjhDR0g/x
 lqYVDLpeeFZJz2gh55njBcZ26X68rb/TCsO8SjGp+JRoBs9ln4jD5gGnCWWPLcoT0qlkf7fmN0T
 D0rlWKGIZNunCwN3PJD43lcveOgrfeUhpv0ICopC5TyvoTx7UT4D6ZcbPbMYzNkLjpKpO091dsu
 oeezZhnkXQYpn4pa0Z5aYqzTHAENY9xYcJ7gBJzu5SZtRhlHOXaUTzKS5aqtXUcnQKB9Bc=
X-Google-Smtp-Source: AGHT+IHFIlUMxbJJsl0dIa8zCxLr0rtRwTDV/jMGvqbgJBfCo0YXKdfYQVpJSBzOQLBpy5oHbvjWJD/X1F0Sx+22qAA=
X-Received: by 2002:a17:907:fdc1:b0:b7d:266a:772c with SMTP id
 a640c23a62f3a-b803574c34fmr2003485966b.21.1766603494895; Wed, 24 Dec 2025
 11:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-16-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-16-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:11:08 +0200
X-Gm-Features: AQt7F2oEpvBr1J4aYzWHwGpLVlw2TJd7YgV5K8frX8bnn93TQZXTDyPmCFrcKBg
Message-ID: <CAAjaMXYAfB=LXd0OAtJugTJ=vQvfkLFt2HAd-9Ar+qptN+QEfA@mail.gmail.com>
Subject: Re: [PATCH v3 15/25] system: Allow restricting the legacy
 ld/st_phys() 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Anton Johansson <anjo@rev.ng>,
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, Dec 24, 2025 at 5:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
>
> Since all targets can check the definition, do not poison it.
>
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  include/system/memory_ldst_phys.h.inc | 2 ++
>  scripts/make-config-poison.sh         | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memor=
y_ldst_phys.h.inc
> index f4c91dc7a91..66bbd3061c2 100644
> --- a/include/system/memory_ldst_phys.h.inc
> +++ b/include/system/memory_ldst_phys.h.inc
> @@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, h=
waddr addr, uint8_t val)
>                                      MEMTXATTRS_UNSPECIFIED, NULL);
>  }
>
> +#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
>  #define ENDIANNESS
>  #include "system/memory_ldst_phys_endian.h.inc"
> +#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
>
>  #define ENDIANNESS  _le
>  #include "system/memory_ldst_phys_endian.h.inc"
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.s=
h
> index 937357b3531..b4d61e8bc9e 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -11,6 +11,7 @@ exec sed -n \
>    -e '/CONFIG_USER_ONLY/d' \
>    -e '/CONFIG_SOFTMMU/d' \
>    -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
> +  -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
>    -e '/^#define / {' \
>    -e    's///' \
>    -e    's/ .*//' \
> --
> 2.52.0
>


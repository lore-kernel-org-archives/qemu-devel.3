Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD4AE776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUAk-0002u1-9l; Wed, 24 Dec 2025 14:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUAi-0002tT-DS
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:05:20 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUAg-000490-Do
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:05:20 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1232229666b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603116; x=1767207916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3LrPdmwZQ2IQevPWFlsOlCRpY6OrwN7Txb/bOm3K54=;
 b=azz0G0hOoxwkoGcQVc80bzJxgPXAxbmSDKZ899hsMl+zqf/m2BynYBmPkUCNudHaGg
 x9Wv5Hr8Bgq5pJozJSd1002FjuGeYI337/5qI8ia1Ro8svI7ucV4FQTwd180nouPfRFR
 SCicoL/3Gk6+hwK9xcLacENKzwhqZnBWp1wtlm/17E/PmTONHni2yr9KAG+6YeZ08XMo
 o7lwVGs2anuaJKeeY1FHoMoCwLs4GFNj5854zUZ7cpF3zC7DdtlY0wiaOwryU8n7MVvh
 QfETjeO/+Pu7zvkmXil2zqeEUpqQrppviRHim9kR5CoRVbEoQ1nZpDG41F6A8EuaZXBT
 xqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603116; x=1767207916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/3LrPdmwZQ2IQevPWFlsOlCRpY6OrwN7Txb/bOm3K54=;
 b=s6aQltExJnPxeK/HnzHcZ6Ax7vZZqx74FI09freztxx8bijHIcrLwqpqNI8N813T13
 htBuyre/I9MJB3BW3jsQM1kwmpxQwK9ZRnl8tfrRHNYgzqBknEFyUIdlpfB9maXXkx/f
 kP2QM7egeksf+s2slIB31TgVSpRc90sSft53wA/IQppPQ5LcxhNLNF/Kab2U54U89fsH
 0J/Ag7uY/bv8x4olfhTPOBDkrIxm/eoYoHr93Z9iGDiS44+vIvFr8Wf52WX1CpBQlJpw
 saKSfHrP/4RBfO0I6GnQoDGrd0uzvCIa6gbHdEBMu+eLaVjpIzCbZrgmZ8fJoJZF4i1q
 zYag==
X-Gm-Message-State: AOJu0YxfoUBaO16yMU/S5N1R1BEmHZbh1rcYFvQdnqZl80Nb5HG0D27G
 zz85ZE0KTUed+pzYN0d5Y6Scy/DF9HPrxj7Q0Ip9yC1m/RJ07ApCYn30w2tez+jCIC9h5BngAPM
 o2yIYR0p1SvgUVXNu8pzZVbSOXH62cu3Ys81Hn1gYnw==
X-Gm-Gg: AY/fxX6lEDW7xwO5K5zGSJVgr5kNF7ChJU5w/9obELWT7w+yKsyuK+hu9acRKqFzQNw
 Y0XWMBotB8I2AeuWmF2ZuI7u9k+5Tg4XMQ+cxz3rHeu9MapJ3b3y4XMbtG49BSSd18045C6fDnL
 BU+t/7vdA3MMt2ZewKSvOdJIb4dCrflJhDUDKfySdsi8LdHVO5XprN5a0mK2QaK4a+wrl/RNjLp
 dBbwI6vFRNrsSYO6iaBkX9+RgeZ85rmp1NTw/RSHZPzlKfBCeNwvBHqxUnkG0UyugvrB/0=
X-Google-Smtp-Source: AGHT+IHTEM0Fp5x822N93qOeIGDe0if+eL5WTlA6J1GbAReP86/8dbkdVK/1xPKRPqc5paGXKZKZSzFfHXVX3s1PRCk=
X-Received: by 2002:a17:907:9447:b0:b71:df18:9fb6 with SMTP id
 a640c23a62f3a-b8036f5bb39mr1976463066b.26.1766603115785; Wed, 24 Dec 2025
 11:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-6-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:04:49 +0200
X-Gm-Features: AQt7F2rTDphEmD9a-S-zSYImdklqI_N3fsH068SLhL_mFEzC5oh4Ju5BmUEA7hc
Message-ID: <CAAjaMXb3SZJswpMMVq_oN6Ow5XYMpHY1srHAbYiRgMx6AyjjaA@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] system/memory: Move *ldst* headers from exec/ to
 system/ namespace
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Anton Johansson <anjo@rev.ng>,
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, Dec 24, 2025 at 5:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Keep all system memory APIs under the system/ namespace.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  MAINTAINERS                                       |  1 +
>  include/system/memory.h                           |  4 ++--
>  include/system/memory_cached.h                    | 10 +++++-----
>  include/{exec =3D> system}/memory_ldst.h.inc        |  0
>  include/{exec =3D> system}/memory_ldst_cached.h.inc |  0
>  include/{exec =3D> system}/memory_ldst_phys.h.inc   |  0
>  6 files changed, 8 insertions(+), 7 deletions(-)
>  rename include/{exec =3D> system}/memory_ldst.h.inc (100%)
>  rename include/{exec =3D> system}/memory_ldst_cached.h.inc (100%)
>  rename include/{exec =3D> system}/memory_ldst_phys.h.inc (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c299b84d418..f984891ac2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3255,6 +3255,7 @@ S: Supported
>  F: include/system/ioport.h
>  F: include/exec/memop.h
>  F: include/system/memory.h
> +F: include/system/memory_ldst*
>  F: include/system/memory_cached.h
>  F: include/system/physmem.h
>  F: include/system/ram_addr.h
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 692c2f67dd3..2a966397931 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2848,13 +2848,13 @@ MemTxResult address_space_write_rom(AddressSpace =
*as, hwaddr addr,
>  #define SUFFIX
>  #define ARG1         as
>  #define ARG1_DECL    AddressSpace *as
> -#include "exec/memory_ldst.h.inc"
> +#include "system/memory_ldst.h.inc"
>
>  #ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
>  #define SUFFIX
>  #define ARG1         as
>  #define ARG1_DECL    AddressSpace *as
> -#include "exec/memory_ldst_phys.h.inc"
> +#include "system/memory_ldst_phys.h.inc"
>  #endif
>
>  void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwa=
ddr len);
> diff --git a/include/system/memory_cached.h b/include/system/memory_cache=
d.h
> index 1a07774b6ad..587e8a1453a 100644
> --- a/include/system/memory_cached.h
> +++ b/include/system/memory_cached.h
> @@ -52,7 +52,7 @@ struct MemoryRegionCache {
>  #define SUFFIX       _cached_slow
>  #define ARG1         cache
>  #define ARG1_DECL    MemoryRegionCache *cache
> -#include "exec/memory_ldst.h.inc"
> +#include "system/memory_ldst.h.inc"
>
>  /* Inline fast path for direct RAM access.  */
>  static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache=
,
> @@ -78,18 +78,18 @@ static inline void address_space_stb_cached(MemoryReg=
ionCache *cache,
>  }
>
>  #define ENDIANNESS
> -#include "exec/memory_ldst_cached.h.inc"
> +#include "system/memory_ldst_cached.h.inc"
>
>  #define ENDIANNESS   _le
> -#include "exec/memory_ldst_cached.h.inc"
> +#include "system/memory_ldst_cached.h.inc"
>
>  #define ENDIANNESS   _be
> -#include "exec/memory_ldst_cached.h.inc"
> +#include "system/memory_ldst_cached.h.inc"
>
>  #define SUFFIX       _cached
>  #define ARG1         cache
>  #define ARG1_DECL    MemoryRegionCache *cache
> -#include "exec/memory_ldst_phys.h.inc"
> +#include "system/memory_ldst_phys.h.inc"
>
>  /**
>   * address_space_cache_init: prepare for repeated access to a physical
> diff --git a/include/exec/memory_ldst.h.inc b/include/system/memory_ldst.=
h.inc
> similarity index 100%
> rename from include/exec/memory_ldst.h.inc
> rename to include/system/memory_ldst.h.inc
> diff --git a/include/exec/memory_ldst_cached.h.inc b/include/system/memor=
y_ldst_cached.h.inc
> similarity index 100%
> rename from include/exec/memory_ldst_cached.h.inc
> rename to include/system/memory_ldst_cached.h.inc
> diff --git a/include/exec/memory_ldst_phys.h.inc b/include/system/memory_=
ldst_phys.h.inc
> similarity index 100%
> rename from include/exec/memory_ldst_phys.h.inc
> rename to include/system/memory_ldst_phys.h.inc
> --
> 2.52.0
>


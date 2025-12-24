Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159F4E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUIh-0007to-LX; Wed, 24 Dec 2025 14:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUIg-0007tc-Oe
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:13:34 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUIe-00058r-VW
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:13:34 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so1124576466b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603611; x=1767208411; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGnAyWHRFg9a0sBAG7XjUI3VcIfaqGtFarp1D57U+Lg=;
 b=L8KsNitcnQuY81fNEbVn2qd/3NiRuTsGfWzXPti+KfcABxl41oNraAjM2W38ai0qIX
 2cp2+5MMLpn06+bDeXAXSVRernOJG95yn6B8psxFa8l1lFkXw0DxaCxbyjUveMC6aTVC
 Y9AmmaDzNSslYXnshz0ZGTKwBM90KTa1yAZuT+FQHGv/lY2kPlUXAC3eEjDKOUhBAZeo
 6MwOdi9VdDJ0CcoCVnB+mgD80Ex+/DpCs3/hfFIb6Tv4EEJKyIUQaPH53l+ySb1RSsgD
 Ul9YuK4Kj6VWTISpaSFnXQEL4odHl4AzvaOfnpFcOTmzs1g3VBYDMCOoWUSRQz9Z2xuL
 F3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603611; x=1767208411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oGnAyWHRFg9a0sBAG7XjUI3VcIfaqGtFarp1D57U+Lg=;
 b=mxHXbBMN6q6Kw772eJx+DlIi8nDChl0Dtof6FAcDeGAaN1157WKTZbQyWv6WZ8Khab
 J8J4XM4+yeGJDLbqp8kzARo2n82DKMNBDmgKcjvb300Q6RzMeJ4Yq3gV3dt9AhJCtuNu
 0x9AgKg//JK0OfYRpCUcU0XPfMxi35UABR722gGFkn9z4k8cD7ppV9bj1ju7Kgm+IYcX
 ufk/ZuBmLwJWJ1A3K/hfdr2oiSGaqXnqN9BYW2Y1OyedgXDuGb9LAG0OxIZUCpK0pa4N
 oJb/moilRuQ6VldlHf629xUUb4cl8cGrzdfsG0KShemVZfKRX0nOa4iDrOKElET/1EyN
 ctEg==
X-Gm-Message-State: AOJu0Ywbdex9QaSdnQzAC1z9Y0+FIXUrQS+rDFSjX58kYY0JjbE9IGjp
 mKOlhFBve0Z6TJ0mh44JpueihDpnlqAi57RqroWtmcCRa0s/sv9x/FIiazr9jKe5ggzRZhZ6L3v
 QlbEu98HpAgMpzyYKnqt+mNekOVszN6Yy6U0MeoTfDuuXkOJXGSHdLko=
X-Gm-Gg: AY/fxX4ilmJikyIax9l81/yQ+MqVFJHOwybAehtVD9IPLZp8lz0Q8jpPtLrjwHS3tvp
 W5Yt4iG84OIMLTJAUKvmyRNXSh3qvON9a5thM7B+3D3WA/4cw7v2er2h+WRqywnu2bXYJUC+R4x
 GU870Zgj1TNIhpZfTrXCQoqd4mSohz6X3MXTnk3hrKlpxDVdUxuakIq73qqlaE21J0NLm2/upia
 zqrgzff16jCEkpHgUE5fBZWftZntoDajQFfkLNBi4F/hFkz/BWDcVhDIkOHJrYDnK63xHk=
X-Google-Smtp-Source: AGHT+IEjS1VHrJ7/svr4MoSqLmbwcvj9/7ByEA7SnBxSTlE6pz0onFRaItYI8NWGw4AaMkvCE9G1YAFRcNk87YeLqoI=
X-Received: by 2002:a17:907:984:b0:b6d:6f46:9047 with SMTP id
 a640c23a62f3a-b803722ba21mr1904672066b.59.1766603611366; Wed, 24 Dec 2025
 11:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-2-philmd@linaro.org>
In-Reply-To: <20251224160040.88612-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:13:05 +0200
X-Gm-Features: AQt7F2pPtKs2ar1gaW7NvYGI9GHj6dD83uhwyKJGzNk2mC8EbeftDCfDLLR-QTA
Message-ID: <CAAjaMXYak9gnXXf5H6CoONvFSLRY5E_QcvMtnwjrbEaLE2=19Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/alpha: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Wed, Dec 24, 2025 at 6:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The Alpha architecture uses little endianness. Directly
> use the little-endian LD/ST API.
>
> Mechanical change running:
>
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' hw/alpha/);
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/alpha/dp264.c   | 11 +++++------
>  hw/alpha/typhoon.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index b6155646ef7..203b9ce92d7 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -194,12 +194,11 @@ static void clipper_init(MachineState *machine)
>              load_image_targphys(initrd_filename, initrd_base,
>                                  ram_size - initrd_base, NULL);
>
> -            address_space_stq(&address_space_memory, param_offset + 0x10=
0,
> -                              initrd_base + 0xfffffc0000000000ULL,
> -                              MEMTXATTRS_UNSPECIFIED,
> -                              NULL);
> -            address_space_stq(&address_space_memory, param_offset + 0x10=
8,
> -                              initrd_size, MEMTXATTRS_UNSPECIFIED, NULL)=
;
> +            address_space_stq_le(&address_space_memory, param_offset + 0=
x100,
> +                                 initrd_base + 0xfffffc0000000000ULL,
> +                                 MEMTXATTRS_UNSPECIFIED, NULL);
> +            address_space_stq_le(&address_space_memory, param_offset + 0=
x108,
> +                                 initrd_size, MEMTXATTRS_UNSPECIFIED, NU=
LL);
>          }
>      }
>  }
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 4c56f981d71..0a039dc8a31 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -622,8 +622,8 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask=
, IOMMUTLBEntry *ret)
>     translation, given the address of the PTE.  */
>  static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
>  {
> -    uint64_t pte =3D address_space_ldq(&address_space_memory, pte_addr,
> -                                     MEMTXATTRS_UNSPECIFIED, NULL);
> +    uint64_t pte =3D address_space_ldq_le(&address_space_memory, pte_add=
r,
> +                                        MEMTXATTRS_UNSPECIFIED, NULL);
>
>      /* Check valid bit.  */
>      if ((pte & 1) =3D=3D 0) {
> --
> 2.52.0
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EB0CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEJ-00076w-KT; Thu, 28 Aug 2025 13:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbbq-0000XH-2m
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:20:06 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbbm-000105-Hp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:20:05 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-afede1b3d05so151050066b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383599; x=1756988399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP1oX//JogB+yj029WpipeMcfb1TSlDgVIydR79J6PI=;
 b=Uxot33e38rrrIdjrOs1i3Ipg+2DcA1LyfnlOr/VQxOrG3vaSYup/nclpHM7rGedYRA
 z8jJZP/odbdcvUwm1KVVlf2zyxPPG0YsuZKXKe9F2AEvFce+LuaPkmDwvMJdT05IBxvD
 VxN4yQOtmeiT3jqKwBbvhgwsF0wvVTouAC8mpy/WkNjQ5/XZwhjQwS/UpH2KBXU3L/U3
 Pa/gasfRlHplnACfBJMMRFxU/HTsio8JI3bDwKExToVKoUgPflpGShq1nyfvRkgJkRWI
 i4hgkWwJo8Zm5WPibYBdFJDjh0DRBaAXtBom+VCrhJD4z1KJpMht3xOrVex4qecCxKVA
 1PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383599; x=1756988399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP1oX//JogB+yj029WpipeMcfb1TSlDgVIydR79J6PI=;
 b=sgMgo7KvOBMMjribexQO7AFdDMec6L+Xkt9WarbeIakm28xMszpgMOpDO8xeKFgBM9
 qkknkX8v3ZYjKObsRADYxXa2iJIo3bCp08ZKOWBtuXLFc4P6Xus6BQaP217gEQj9GUvz
 msNS6nKObyn2H/T2mDT4uLqwuwgKlFo6sODk2H1byPQybANTFA3IQgIP/OOZzCd/4bts
 oAYgNEIqRu8W+ni7SIc8+t0wIVI1yzOp+4pzD4NGJfz+1vpk3NajYDqP4CICi2RNyfG6
 Huaf2F05btjR93mzZ6DqpNTsJvlmqUNvXdKpn7pLWuaI9Naa7PS09oeFQt2aXS+TuM0/
 2MkQ==
X-Gm-Message-State: AOJu0Yzw2bvCoJ48Igp4PfKlbLnw4RxZgppTgm2yNJKlBHaxCFriqz+Q
 5TfqS8B053CseStHC9VwBwOFIYPvKaPqATvp0wwaxrZkblWY8QruJBVhXerSff7qbSMQ/2p5Al2
 hYVv3XFPh0q6Nxf4Jb8G2rPG7UR2WJEfqcf7mpvrOVw==
X-Gm-Gg: ASbGnctPsEmDuf69n2Scdw2mQwyqJRb7DzATqV4OGcpsmgOcaGtSOAHY1SHwzXpxXje
 JXDRTRi5ZlXc6z/2fBRZwzmkPDQCdN1TIeJyFDWNFNDsgVj/NGo6nzrkpTF5Dc42i7UyKxjf1pq
 iZEbCiULpRXqPpty4JoC2OgILPbQwa8OLzDqDcTxecen/F4kWAQ56aRTJrsBtZPegVfPrUec2wU
 QgINULedQEjI6QIn4Q=
X-Google-Smtp-Source: AGHT+IEW3z00nzsXRkuCtuLC2Oo6cmCcZVmHV0p55/Bnt7SBM1h/b9a4KDTABJSr3Z5leW7oh9E+1r8uz5wj4u5XBmI=
X-Received: by 2002:a17:906:c515:b0:afe:8c69:4c3a with SMTP id
 a640c23a62f3a-afe8c6957d3mr868123566b.37.1756383598624; Thu, 28 Aug 2025
 05:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-3-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-3-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 Aug 2025 15:19:31 +0300
X-Gm-Features: Ac12FXzLhPPJ2A01WHQar2XM-CyhOTd35Zn97IkLCl952i9WUtFrrcj6biQqZYI
Message-ID: <CAAjaMXZHfmy6i_23YdKLVbgjruz=myK4uujTeAj9e2iO30Ekog@mail.gmail.com>
Subject: Re: [PATCH 02/61] target/arm: Move compare_u64 to helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 27, 2025 at 4:07=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will use this function beyond kvm.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/internals.h |  3 +++
>  target/arm/helper.c    | 11 +++++++++++
>  target/arm/kvm.c       | 11 -----------
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1b3d0244fd..08e2acdb99 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1981,4 +1981,7 @@ void vfp_clear_float_status_exc_flags(CPUARMState *=
env);
>  void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)=
;
>  bool arm_pan_enabled(CPUARMState *env);
>
> +/* Compare uint64_t for qsort and bsearch. */
> +int compare_u64(const void *a, const void *b);
> +
>  #endif
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0c1299ff84..d230f9e766 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -40,6 +40,17 @@
>
>  static void switch_mode(CPUARMState *env, int mode);
>
> +int compare_u64(const void *a, const void *b)
> +{
> +    if (*(uint64_t *)a > *(uint64_t *)b) {
> +        return 1;
> +    }
> +    if (*(uint64_t *)a < *(uint64_t *)b) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>  uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      assert(ri->fieldoffset);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 6672344855..9e569eff65 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -718,17 +718,6 @@ void kvm_arm_register_device(MemoryRegion *mr, uint6=
4_t devid, uint64_t group,
>      memory_region_ref(kd->mr);
>  }
>
> -static int compare_u64(const void *a, const void *b)
> -{
> -    if (*(uint64_t *)a > *(uint64_t *)b) {
> -        return 1;
> -    }
> -    if (*(uint64_t *)a < *(uint64_t *)b) {
> -        return -1;
> -    }
> -    return 0;
> -}
> -
>  /*
>   * cpreg_values are sorted in ascending order by KVM register ID
>   * (see kvm_arm_init_cpreg_list). This allows us to cheaply find
> --
> 2.43.0
>
>


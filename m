Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC76CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rcu-00036F-0s; Tue, 14 Oct 2025 22:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rci-00035M-MF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:52:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rcV-0006j2-Vu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:52:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso13562065a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760496722; x=1761101522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrYATmWBAX2GR6ZMhMA7RmRp8c2zVgLxLVX3yrwBUEU=;
 b=JPMlEsS1FIv6YW1EhtHIV8Nmwko+ve8fISn5p+u3f9d4UAbeaH5fSQJ/Y15+2byUWx
 bkoUXCCVeLl7lm+bSrycjrzIrtk4vn0ep3PpfgOx3d9Fipn1A8VSDaOaV7TKpyLUan9/
 gHxCjgCjAXR9xSC7A5+GxZb8gFQH6rA+kQgGKks9ONN2no6Lq8WvxKYiaelEG9xOXUZZ
 uOVUMnzzclpcvznU+MTRrP3SeIrMO16XT50f7hq1QTTjEgCiS6yqaheny7eTf56Z/6Gy
 D4Sug9TZWcWq9PXzHq/ztjqulCHqvlTgyQiKujvcXg4OnLD23geoL887MzuGjYh4h/WB
 UtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760496722; x=1761101522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrYATmWBAX2GR6ZMhMA7RmRp8c2zVgLxLVX3yrwBUEU=;
 b=ZMQteSWRgB1sRgdB6pJyGBjy+V1aoVwKTdByx2IfCcnaMErzSe5K9IVG1YQcOOwSVM
 J3waJfp6ccLN9yD5Y27Fn4aYue995tq0eyzOoIOwrIvBSvIttSoqb2ZbkUgrfo5azhL/
 UJ/aKU4Z/S753k77BkD+A6S+pX16oSc//VasNyWCznipA60Z0EQ7K7bflUdFHdC+ZrZQ
 6FrWviwWfO1h2lwcEwY2HXBzHaQS+LlIYKK98r5qn4zdW4wjDhxdZ4+dtTJJFmxLT2yJ
 zHtxUmGNu2+3ZMhgiJZv2T+oI3zQefyvnV9yhWU31LZ9qtcVT+yUNZqBaGNUPssEbYq6
 T47g==
X-Gm-Message-State: AOJu0Yzcmrh4FoVC3b38AIfObH4lKdqdizDd4xz4rfnbdrXPMB3QHoeH
 y8YBPd1IEG2kKb0x2Lbee1Aoo4VGbglSW/6xnSFwSFjDCDvu4bNogt+6SDzr4LE+oLkOupvCfcD
 CVF9ZVHRtK7medtlE8UK+veawsLu//tsZPw==
X-Gm-Gg: ASbGncvjnN9y5c0xrnzJZesueUYj/j5GO8tMmSCE6RchbVy8sTTh9lvpY4IEGNTfsQL
 1AQNMpWtwLAvR+D6HSvjtTNHcxOo1vxvEDA7acsYSMAXaYyninpY3tXatTeAq6aeIUe2PJNnjql
 daQqC6h39/H/oeCrjD361QmEaYuLq1L0JxItHQagKquCFJtRbh1WWsKWUTpbfCPyJx2hHFPQ2YA
 OTaTrSUjCf4NmhFQ7meLnr/ZPpjXRohwanUEp3iJZjhOIZnG/Hpk0aU
X-Google-Smtp-Source: AGHT+IHfdiazKAbx3IzJ0+Yac/K58inmUv1XsIBrE0OCc+SfRlMNaRiS7aEv5XbNypPb0qc6WRbYd9uawaSR9g5s9FQ=
X-Received: by 2002:a05:6402:2789:b0:63b:ee26:546d with SMTP id
 4fb4d7f45d1cf-63bee265665mr584877a12.12.1760496721892; Tue, 14 Oct 2025
 19:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251010134226.72221-1-philmd@linaro.org>
 <20251010134226.72221-14-philmd@linaro.org>
In-Reply-To: <20251010134226.72221-14-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:51:34 +1000
X-Gm-Features: AS18NWBwVRqB-drBRL_aG1NiBUYL6uW6v4KzuNNNosV6WccScC7pzNA2dGBiVuE
Message-ID: <CAKmqyKPtjuAa=-fTukwE0-x5Ds5YLLotCHzxk=_TJaqzxuGwqA@mail.gmail.com>
Subject: Re: [PATCH 13/16] target/riscv: Replace HOST_BIG_ENDIAN #ifdef with
 runtime if() check
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 10, 2025 at 11:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Replace compile-time #ifdef with a runtime check to ensure all code
> paths are built and tested. This reduces build-time configuration
> complexity and improves maintainability.
>
> No functional change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c            | 32 ++++++++++++-------------
>  target/riscv/insn_trans/trans_rvv.c.inc | 16 ++++++-------
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 41ea2231067..2de3358ee86 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -235,26 +235,26 @@ vext_continuous_ldst_host(CPURISCVState *env, vext_=
ldst_elem_fn_host *ldst_host,
>                          void *vd, uint32_t evl, uint32_t reg_start, void=
 *host,
>                          uint32_t esz, bool is_load)
>  {
> -#if HOST_BIG_ENDIAN
> -    for (; reg_start < evl; reg_start++, host +=3D esz) {
> -        ldst_host(vd, reg_start, host);
> -    }
> -#else
> -    if (esz =3D=3D 1) {
> -        uint32_t byte_offset =3D reg_start * esz;
> -        uint32_t size =3D (evl - reg_start) * esz;
> -
> -        if (is_load) {
> -            memcpy(vd + byte_offset, host, size);
> -        } else {
> -            memcpy(host, vd + byte_offset, size);
> -        }
> -    } else {
> +    if (HOST_BIG_ENDIAN) {
>          for (; reg_start < evl; reg_start++, host +=3D esz) {
>              ldst_host(vd, reg_start, host);
>          }
> +    } else {
> +        if (esz =3D=3D 1) {
> +            uint32_t byte_offset =3D reg_start * esz;
> +            uint32_t size =3D (evl - reg_start) * esz;
> +
> +            if (is_load) {
> +                memcpy(vd + byte_offset, host, size);
> +            } else {
> +                memcpy(host, vd + byte_offset, size);
> +            }
> +        } else {
> +            for (; reg_start < evl; reg_start++, host +=3D esz) {
> +                ldst_host(vd, reg_start, host);
> +            }
> +        }
>      }
> -#endif
>  }
>
>  static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index f4b5460340e..2a487179f63 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3351,19 +3351,19 @@ static void load_element(TCGv_i64 dest, TCGv_ptr =
base,
>  /* offset of the idx element with base register r */
>  static uint32_t endian_ofs(DisasContext *s, int r, int idx)
>  {
> -#if HOST_BIG_ENDIAN
> -    return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
> -#else
> -    return vreg_ofs(s, r) + (idx << s->sew);
> -#endif
> +    if (HOST_BIG_ENDIAN) {
> +        return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
> +    } else {
> +        return vreg_ofs(s, r) + (idx << s->sew);
> +    }
>  }
>
>  /* adjust the index according to the endian */
>  static void endian_adjust(TCGv_i32 ofs, int sew)
>  {
> -#if HOST_BIG_ENDIAN
> -    tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
> -#endif
> +    if (HOST_BIG_ENDIAN) {
> +        tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
> +    }
>  }
>
>  /* Load idx >=3D VLMAX ? 0 : vreg[idx] */
> --
> 2.51.0
>
>


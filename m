Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF4CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 23:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiB1-0000PQ-9s; Wed, 22 Oct 2025 19:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiAz-0000P5-0u
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:23:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBiAw-0008D1-AZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 19:23:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so261616a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761175404; x=1761780204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+ceShRLFZow0JTINuJNX7q1xI9j/hqEL/kVRxqlQek=;
 b=bnxt624Js4R0IhWMdo0GvYpmL1Nb+X+bvtC7sVS35v8EDqFsCd6yGAXwxumZWmrGJ6
 9+5rbuSfIbFJvFaNeQuGGv6iO02zqlAQ8hY+Ym35tl2tgkOEOPCAVFg6FuJdtH75YYgm
 8KvmpWclbKtlSIyd+iEgPtAgmvLfwJeu9khEJ7HoAYOxpR1JOu3qTLkJ3gnZByJLunBe
 SpRgqs4eA5SWQN0tJrbtpx4xN/x+q7dcdnGkwaEwHgFz5liKByquM/9blcGfgioXmLUJ
 R3ZKA768jauoxf8ZF3inwoTB+m2VupjEfeA2lzDOAuJM2VDIrpHVYzqZ8JIhTk2zQkiX
 Awmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761175404; x=1761780204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+ceShRLFZow0JTINuJNX7q1xI9j/hqEL/kVRxqlQek=;
 b=hZ0XDJLY/Q+okD7l4UiIC1lVjkoL/wgwbZzUoDHBatqJ/PTkMoTemm6kQVTtpPQecO
 HYgCaFdBJWMUjuEMzM9vIzoo6uq78dD0aDN5Af0BuAxV8+QO2FaGzQNpVQv/EgkUnCXh
 4Q7Sn3jQX0fmnkDcdi9oit4XOaSnCFDFHO+3jcjg2OfKQyy3SLIrWx+0z/8zEpj8snR0
 gUnK7/STKFf6Sd0mgKAgFQGHNYGFFa/no3fvrfC8mEZcVtLB/1K5DuVlSpeMpIyVnlbb
 ZrtCwrVLT8W/wSCf9UzMi0DiRyjx1IC5AF+Rzz+P9m8kQlIKpA75g4OqLIfZsW2Hr6EB
 R1Dw==
X-Gm-Message-State: AOJu0YyGDQ9i4bsk57hpPr6x30erW+bkV09ZzvEgNdrEAB0vEmv+ozwp
 hsvTnE+njR2SdYl4ii1U4+7XDHXZxtvlhmH6hcE9Yqh0vy0S1ZiiF2zoIWW0i62rpFqloz2HEOz
 PZOHR49bi6YTk4epQxpXHtEDZ5dBCV/Y=
X-Gm-Gg: ASbGncthZ1aUSloEJJPt+T33tvU/rmm1oqeM4YSxsOeDqmqdABpLcZvFIGgfJi6KXgM
 XyFl38fQx7D/gmS7lW2GtYtVROh3nlAFqZ7Rj/jGMlCttyu3k42xZ3PYURESOHnkwa5tQEhxJMW
 VQJ4aEYALBLEPvYv1xZRAydpoQXGk6jrQHXUEOvA7qC4cHfq9p/+FMGNA3DTWueI7X5kSW6qHyX
 8p1DUfoJXC8CklsEDO9Vw2NFDrHX2Lz+dFhheFCcu/XmjoK2ezaYJ7jbMYw5/Wz1g+3lcFyosvO
 clOQ6r0QLsZ9ESSGo6Bc0PEgjQ==
X-Google-Smtp-Source: AGHT+IFWxV2oz2kwz6PZE+UDVhRMt0/2BGSGs7KPYv1O6OIC6H/KK9BJc1dptN1NEl7efWtDbksY2UbHKV6+hc5cfO8=
X-Received: by 2002:a05:6402:2552:b0:63b:f59b:e607 with SMTP id
 4fb4d7f45d1cf-63c1f6364demr21458365a12.2.1761175403670; Wed, 22 Oct 2025
 16:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251022125643.588947-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251022125643.588947-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 23 Oct 2025 09:22:57 +1000
X-Gm-Features: AS18NWDbSXMs1hj05SGqKZOBZuwsoAHKmIcfkndKP0MXD6RvUnySUqtpssPKz4Y
Message-ID: <CAKmqyKOABiCN_aazC4WaOskWavx2B7OB0s=4-o4JvG3nXemQRw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/riscv-qmp-cmds.c: coverity-related fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Wed, Oct 22, 2025 at 10:57=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity CID 1641401 reports that, in reg_is_ulong_integer(), we're
> dereferencing a NULL pointer in "reg1" when using it in strcasecmp()
> call. A similar case is reported with CID 1641393.
>
> In theory that will never happen - it's guaranteed that both "reg1" and
> "reg2" is non-NULL because we're retrieving them in compile-time from
> static arrays. Coverity doesn't know that though.
>
> To make Coverity happier and add a bit more clarity in the code,
> g_assert() each token to make it clear that those 2 values aren't
> supposed to be NULL ever. Do that in both reg_is_ulong_integer() and
> reg_is_u64_fpu().
>
> We're also taking the opportunity to implement suggestions made by Peter
> in [1] in both functions:
>
> - use g_strsplit() instead of strtok();
> - use g_ascii_strcasecmp() instead of strcasecmp().
>
> [1] https://lore.kernel.org/qemu-devel/CAFEAcA_y4bwd9GANbXnpTy2mv80Vg_jp+=
A-VkQS5V6f0+BFRAA@mail.gmail.com/
>
> Coverity: CID 1641393, 1641401
> Fixes: e06d209aa6 ("target/riscv: implement MonitorDef HMP API")
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes from v1:
> - use g_auto(GStrv) instead of g_autofree
> - v1 link: https://lore.kernel.org/qemu-riscv/20251022110524.483588-1-dba=
rboza@ventanamicro.com/
>
>
>  target/riscv/riscv-qmp-cmds.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index c499f9b9a7..d5e9bec0f8 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -273,12 +273,13 @@ static bool reg_is_ulong_integer(CPURISCVState *env=
, const char *name,
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        g_autofree char *reg_name =3D g_strdup(reg_names[i]);
> -        char *reg1 =3D strtok(reg_name, "/");
> -        char *reg2 =3D strtok(NULL, "/");
> +        g_auto(GStrv) reg_name =3D g_strsplit(reg_names[i], "/", 2);
>
> -        if (strcasecmp(reg1, name) =3D=3D 0 ||
> -            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
> +
> +        if (g_ascii_strcasecmp(reg_name[0], name) =3D=3D 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) =3D=3D 0) {
>              *val =3D vals[i];
>              return true;
>          }
> @@ -294,12 +295,13 @@ static bool reg_is_u64_fpu(CPURISCVState *env, cons=
t char *name, uint64_t *val)
>      }
>
>      for (int i =3D 0; i < 32; i++) {
> -        g_autofree char *reg_name =3D g_strdup(riscv_fpr_regnames[i]);
> -        char *reg1 =3D strtok(reg_name, "/");
> -        char *reg2 =3D strtok(NULL, "/");
> +        g_auto(GStrv) reg_name =3D g_strsplit(riscv_fpr_regnames[i], "/"=
, 2);
> +
> +        g_assert(reg_name[0]);
> +        g_assert(reg_name[1]);
>
> -        if (strcasecmp(reg1, name) =3D=3D 0 ||
> -            (reg2 && strcasecmp(reg2, name) =3D=3D 0)) {
> +        if (g_ascii_strcasecmp(reg_name[0], name) =3D=3D 0 ||
> +            g_ascii_strcasecmp(reg_name[1], name) =3D=3D 0) {
>              *val =3D env->fpr[i];
>              return true;
>          }
> --
> 2.51.0
>
>


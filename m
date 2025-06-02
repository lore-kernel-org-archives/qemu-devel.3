Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58724C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 00:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLtTL-0005ev-7K; Sun, 01 Jun 2025 20:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLtTJ-0005eH-54; Sun, 01 Jun 2025 20:56:13 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLtTH-00071G-FR; Sun, 01 Jun 2025 20:56:12 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86fbb48fc7fso676261241.2; 
 Sun, 01 Jun 2025 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748825769; x=1749430569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sokfjRU3Ey34Z1h/Om9Ak0EDkRmMihKTCc+4CArsuz0=;
 b=bCpeCFd2vSndzPAwCpWHIIR5YRCCh9iP2q9KFRr7XcBLzQ3mPESBRmzD4gJPsucHmL
 u4S602ZPVENLB4kDOzwMZPbw9/9U4Ih1PDAuz7rSSOO+ozOm/6ZSeVmT8XbxZjad2jZu
 qNZIz/XIVzRzs2+r3gI/fnfm3xSbsVqGmkH1JWswURiUFgb7nLIKgt+9sTGISh4GE32T
 aH5sEI7DRbVkZWjRlTaJffJXSw7zAYOHkLbQHi/0bT479laAsvIhdv3DyrBnkZeQOzke
 Aq5geTM/yM9eHcZzltVHb57H1aCG+ZKMVjugeigNat/KYQJSLUgk5ZXY+zc0z0FnEg/N
 DnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748825769; x=1749430569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sokfjRU3Ey34Z1h/Om9Ak0EDkRmMihKTCc+4CArsuz0=;
 b=ZdFmNJMxO4ZS3JkMNYLJnoazLoDDzviGcAzAEZZuUWijhlfBttAVutPs4e9tLC2aIZ
 z15KsvebedM202tVElDOhJE2N4zcUyvC0rc/hmq533vet9yFP9z0MTiNUkbyQ09XU3et
 oz7yTwa2yXrFMuy0bKgZPJDoDnEWKSwkxzWR4jTVlV0qIR/k+n626pARD2ZUw3jp2CAs
 U9md9Kx1VXbhi0GkBf2+Nylfox/ghOGSS5v7mkxwu5rZ472M4Ghx+ul3fN5r8rUKJUjQ
 tdOGjQox+wGQ09xPtYfhRbWnzqeuit5KYIWmzQUBek7RUZIK37B5kTvl9o7srvpUcZvF
 J8Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvTMQHwdxtNIOJwka2kNDwiVaYte1n3COWLV6WOhbU6KkJmXHMLDIOTmx/xtbDm+BENz8dCrDgWBIM@nongnu.org
X-Gm-Message-State: AOJu0Yw6rCCqTopecd2tFQ18DGVu1G0Iqt4qqKJ6RVLx7/h53LRBfpqz
 A8AWknbZPL1H2+jWCzda8oQoLRlj78qQxdcJufTdC7KQUptJjEHrbDHaTmJPE3ZecQK2sFLHfSJ
 zT6/6mUv3IiVgL5vZdTXp6fdR9vYvs0c=
X-Gm-Gg: ASbGncskVZMl81tYPYJmJ/ud5N3/1I0Tjww9+rl3A1O9gOBImHG87ac8VamBR4QQm2F
 MPqiRjwqJWSahqIsgsALhvsIb36UXELMgqDCZ/0Ik1A10IfGo26bH+hrD4vBNabpPIrtNbG121u
 Wu2DSmIzAhhuuaqd6ndjjcfnWMcEejI9MNyIMV1GPgAGo+im2BuWQvN3OafUC2e3k=
X-Google-Smtp-Source: AGHT+IGQS1kABGVS7AQWZWUD+Aa44Ik9SUypLav+ZFYvsOPusghSP1VBuOiiU9pskmXFyDDzD45QHtvmAOg4CJ5Zg8I=
X-Received: by 2002:a05:6102:26cb:b0:4e1:48ee:6f36 with SMTP id
 ada2fe7eead31-4e701cb0c2cmr3481172137.19.1748825769600; Sun, 01 Jun 2025
 17:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 10:55:43 +1000
X-Gm-Features: AX0GCFvX8E2Pg0ciZth2Gzni6fWovQkeQprQU-b2bsnwnpitV5RgPkkwNAIBk98
Message-ID: <CAKmqyKOpXKAeazo3iNKMyjziDucQVthZH0LE-PLH9Gc8OVWubg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: remove capital 'Z' CPU properties
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Fri, May 30, 2025 at 11:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> These properties were deprecated in QEMU 8.2, commit 8043effd9b.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c         | 17 -----------------
>  target/riscv/cpu.h         |  1 -
>  target/riscv/tcg/tcg-cpu.c | 31 +------------------------------
>  3 files changed, 1 insertion(+), 48 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fe21e0fb44..7c6e0844d0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1387,23 +1387,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_featu=
res[] =3D {
>      { },
>  };
>
> -/* Deprecated entries marked for future removal */
> -const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] =3D {
> -    MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
> -    MULTI_EXT_CFG_BOOL("Zicsr", ext_zicsr, true),
> -    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
> -    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
> -    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
> -    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
> -    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
> -    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
> -    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
> -    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
> -
> -    { },
> -};
> -
>  static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
>                               Error **errp)
>  {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2a6793e022..17bf4e7579 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -951,7 +951,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_extensi=
ons[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
> -extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
>
>  typedef struct isa_ext_data {
>      const char *name;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 66929f2e8d..8ebffe55bc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1416,25 +1416,6 @@ static void riscv_cpu_add_profiles(Object *cpu_obj=
)
>      }
>  }
>
> -static bool cpu_ext_is_deprecated(const char *ext_name)
> -{
> -    return isupper(ext_name[0]);
> -}
> -
> -/*
> - * String will be allocated in the heap. Caller is responsible
> - * for freeing it.
> - */
> -static char *cpu_ext_to_lower(const char *ext_name)
> -{
> -    char *ret =3D g_malloc0(strlen(ext_name) + 1);
> -
> -    strcpy(ret, ext_name);
> -    ret[0] =3D tolower(ret[0]);
> -
> -    return ret;
> -}
> -
>  static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
>  {
> @@ -1447,13 +1428,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Vis=
itor *v, const char *name,
>          return;
>      }
>
> -    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
> -        g_autofree char *lower =3D cpu_ext_to_lower(multi_ext_cfg->name)=
;
> -
> -        warn_report("CPU property '%s' is deprecated. Please use '%s' in=
stead",
> -                    multi_ext_cfg->name, lower);
> -    }
> -
>      cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
>
>      prev_val =3D isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
> @@ -1489,14 +1463,13 @@ static void cpu_add_multi_ext_prop(Object *cpu_ob=
j,
>                                     const RISCVCPUMultiExtConfig *multi_c=
fg)
>  {
>      bool generic_cpu =3D riscv_cpu_is_generic(cpu_obj);
> -    bool deprecated_ext =3D cpu_ext_is_deprecated(multi_cfg->name);
>
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
>                          NULL, (void *)multi_cfg);
>
> -    if (!generic_cpu || deprecated_ext) {
> +    if (!generic_cpu) {
>          return;
>      }
>
> @@ -1539,8 +1512,6 @@ static void riscv_cpu_add_user_properties(Object *o=
bj)
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
>      riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
>
> -    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
> -
>      riscv_cpu_add_profiles(obj);
>  }
>
> --
> 2.49.0
>
>


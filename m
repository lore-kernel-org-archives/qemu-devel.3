Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0208DC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdeZB-00075B-Q3; Thu, 30 Jan 2025 19:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeZ9-00074E-KR; Thu, 30 Jan 2025 19:07:23 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeZ7-0006KN-Fh; Thu, 30 Jan 2025 19:07:23 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4afe2f6cecdso1518710137.1; 
 Thu, 30 Jan 2025 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738282040; x=1738886840; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkRJ32UQwlOmg2UlgJl6oGlXZTX2gNp2GGn8mbRcFDY=;
 b=leTSBnnM2Do2p1HMFUCCbczFxzmOIjU2TUJZPgwq8ApHZi/3oe16BkUxF4KV3/bTVv
 ExlLajPdGDlZsZoEG/789jkgh9meZbhNIFanBfuJB8JHd6mH+SoYyHvjc9a/muCRZdUO
 cMRZQvcAjAEEro0Rl7zqZD09iBJLU9TCxs2+d8wbUBsmrZCrX+Wy1tZB8M7C7EPKKvN9
 Z2NVCq0glwbd2/iw///2nbjM5cA6XtQ4mgB9KRMs+eTzs6yhy3UsHBNtVi9GD3CF4QBy
 MUqI7fBgRJ8M7eakPXdDVGLxdy7IKfGpocPxnkSvDoX/YPQfbEJ7RpWj0O+yBWgBGdd6
 5IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282040; x=1738886840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkRJ32UQwlOmg2UlgJl6oGlXZTX2gNp2GGn8mbRcFDY=;
 b=VI50CIRFOxqx6AXu+PlJgsykDzEDAfY9GGTY8GCPPg6Nz1N3CTeES7RzRltFI9WIsU
 Qi8a51Ak5D+EBZYIyPB3bPD9rXcjHOrSEsUrZZ9Y7izFieVScqzMnGPg5Xlq7ps142oS
 dkX7MLtZYO22v4aMexZ3Jxh0JCgh+x6QIkHtcVy+d7Z/Ggj74ov5A6W0ESCcIZZBmQF8
 ACzMvd0gQOPAmPAbLQl0sjR8/aEko3veQsNMNkD8+2+7P6yhe2UjAjbwSOpB0RSQ6x9s
 OcM53a1JM9NhSJ3XKWVGPcuxqttw8sEgz2sKPDUzzCGYarDFBJlqznWoLyZ6t++R9qyh
 MXIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUYBIy89b7MV8j6R/HUKNECAs137iRNNpr9qmOiVHHR50I/Obc33+yhF0xNjJH6qb25nbELtgMILqR@nongnu.org
X-Gm-Message-State: AOJu0Yw+vDrtofFdkqDu3uWII9GqT2L/fmB4CmtLwmyKoONXqYqdSIh+
 Ps/1UiEQQ5f9s6HLIriKH35CGi6DcE9kEiZtpujDZ8vGSj78eSofCTeqrZB3vVwkD20BjDx0YYz
 XVjh/xj+asQiSv4COw03LCiVDmBiSuQ==
X-Gm-Gg: ASbGncvYicKG6t4yZDXw9RybmIfhpcp78bp7vpvWmcWn8ip6OoarHbdPUaSFFa8G6Ae
 hw3gn3J9F0Q56BzVLe2UeO094o+NsDQlaoLOpjr++v4F0N0TG7NWioKd1cmxJY2XwP/SJ61H2pp
 LcOUCC4ETL/TCiTw8WGRPBQ0sN4eo=
X-Google-Smtp-Source: AGHT+IH8+7tWV/eESYp+r5Itd0TYInRlESoOEj5+q8nL7k+PxJDw7NdHy6MgD0/cZGNgqqHIiuYwj8iB7uLx3jGzGv4=
X-Received: by 2002:a05:6102:571b:b0:4b6:8cf4:9a23 with SMTP id
 ada2fe7eead31-4b9c865a812mr1408395137.0.1738282039889; Thu, 30 Jan 2025
 16:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:06:53 +1000
X-Gm-Features: AWEUYZnW89WvjprnGrjHTXe1cARiNxX5R-owBEGo54eVvlFc7q5r9IPU4yLEhIE
Message-ID: <CAKmqyKNcifQYB3faJUvt0gmSimb+WYXcw-yQNvFna8SSv-e_pw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/riscv: add profile u_parent and s_parent
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Thu, Jan 16, 2025 at 4:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The current 'parent' mechanic for profiles allows for one profile to be
> a child of a previous/older profile, enabling all its extensions (and
> the parent profile itself) and sparing us from tediously listing all
> extensions for every profile.
>
> This works fine for u-mode profiles. For s-mode profiles this is not
> enough: a s-mode profile extends not only his equivalent u-mode profile
> but also the previous s-mode profile. This means, for example, that
> RVA23S64 extends both RVA23U64 and RVA22S64.
>
> To fit this usage, rename the existing 'parent' to 'u_parent' and add a
> new 's_parent' attribute for profiles. Handle both like we were doing
> with the previous 'parent' attribute, i.e. if set, enable it. This
> change does nothing for the existing profiles but will make RVA23S64
> simpler.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         |  6 ++++--
>  target/riscv/cpu.h         |  3 ++-
>  target/riscv/tcg/tcg-cpu.c | 35 ++++++++++++++++++++++++++---------
>  3 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6fb4d5f374..e215b1004d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2349,7 +2349,8 @@ static const PropertyInfo prop_marchid =3D {
>   * doesn't need to be manually enabled by the profile.
>   */
>  static RISCVCPUProfile RVA22U64 =3D {
> -    .parent =3D NULL,
> +    .u_parent =3D NULL,
> +    .s_parent =3D NULL,
>      .name =3D "rva22u64",
>      .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>      .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
> @@ -2381,7 +2382,8 @@ static RISCVCPUProfile RVA22U64 =3D {
>   * The remaining features/extensions comes from RVA22U64.
>   */
>  static RISCVCPUProfile RVA22S64 =3D {
> -    .parent =3D &RVA22U64,
> +    .u_parent =3D &RVA22U64,
> +    .s_parent =3D NULL,
>      .name =3D "rva22s64",
>      .misa_ext =3D RVS,
>      .priv_spec =3D PRIV_VERSION_1_12_0,
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97713681cb..986131a191 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -81,7 +81,8 @@ const char *riscv_get_misa_ext_description(uint32_t bit=
);
>  #define CPU_CFG_OFFSET(_prop) offsetof(struct RISCVCPUConfig, _prop)
>
>  typedef struct riscv_cpu_profile {
> -    struct riscv_cpu_profile *parent;
> +    struct riscv_cpu_profile *u_parent;
> +    struct riscv_cpu_profile *s_parent;
>      const char *name;
>      uint32_t misa_ext;
>      bool enabled;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 48be24bbbe..c060b65fbc 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -713,13 +713,29 @@ static bool riscv_cpu_validate_profile_satp(RISCVCP=
U *cpu,
>  }
>  #endif
>
> +static void riscv_cpu_check_parent_profile(RISCVCPU *cpu,
> +                                           RISCVCPUProfile *profile,
> +                                           RISCVCPUProfile *parent)
> +{
> +    const char *parent_name;
> +    bool parent_enabled;
> +
> +    if (!profile->enabled || !parent) {
> +        return;
> +    }
> +
> +    parent_name =3D parent->name;
> +    parent_enabled =3D object_property_get_bool(OBJECT(cpu), parent_name=
, NULL);
> +    profile->enabled =3D parent_enabled;
> +}
> +
>  static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>                                         RISCVCPUProfile *profile)
>  {
>      CPURISCVState *env =3D &cpu->env;
>      const char *warn_msg =3D "Profile %s mandates disabled extension %s"=
;
>      bool send_warn =3D profile->user_set && profile->enabled;
> -    bool parent_enabled, profile_impl =3D true;
> +    bool profile_impl =3D true;
>      int i;
>
>  #ifndef CONFIG_USER_ONLY
> @@ -773,12 +789,8 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu=
,
>
>      profile->enabled =3D profile_impl;
>
> -    if (profile->parent !=3D NULL) {
> -        parent_enabled =3D object_property_get_bool(OBJECT(cpu),
> -                                                  profile->parent->name,
> -                                                  NULL);
> -        profile->enabled =3D profile->enabled && parent_enabled;
> -    }
> +    riscv_cpu_check_parent_profile(cpu, profile, profile->u_parent);
> +    riscv_cpu_check_parent_profile(cpu, profile, profile->s_parent);
>  }
>
>  static void riscv_cpu_validate_profiles(RISCVCPU *cpu)
> @@ -1181,8 +1193,13 @@ static void cpu_set_profile(Object *obj, Visitor *=
v, const char *name,
>      profile->user_set =3D true;
>      profile->enabled =3D value;
>
> -    if (profile->parent !=3D NULL) {
> -        object_property_set_bool(obj, profile->parent->name,
> +    if (profile->u_parent !=3D NULL) {
> +        object_property_set_bool(obj, profile->u_parent->name,
> +                                 profile->enabled, NULL);
> +    }
> +
> +    if (profile->s_parent !=3D NULL) {
> +        object_property_set_bool(obj, profile->s_parent->name,
>                                   profile->enabled, NULL);
>      }
>
> --
> 2.47.1
>
>


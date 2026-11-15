Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA4606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfRPX0M1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSZTl-00074G-6S; Sun, 15 Nov 2026 07:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xSZTg-00073W-81
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 07:37:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xSZTe-0004y1-31
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 07:36:59 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b633ddfad6so4074001a12.3
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 04:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794746216; cv=none;
 d=google.com; s=arc-20260327;
 b=qTFDY9KW3dAbrsNdyTGayRi0zJp4d5lXSfLY2H8GnuIKvLuEj6npLLjIzFvAGmg6fY
 tRox9W3f1/F9BC5yA47b0I2hBVRmZ4y683xsO15UBZ9nxcCP+zSDFmbC8mQOpZccZBc+
 MGzF3Kkg1e9j65yU+Gl30TsUSWKbIvjCIOLAJvOCI9QYVhp72kp3bCJKimXHzhqvlxIo
 27mGIthf6B48f6zUEK2RynefqfIVGrgnuybmGP9YIek5+KcZJhKKjhissDQE7a8eAmX5
 bqqLrqz9ba2PUjSgpGHJylCjYBAy/fJ1KyLHc3B1vdaNqw9OPVbHwRWzxWpZbNvN1udY
 Dm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=OkdAOsx+yWXDDyFyjSOqsYVadQDnmdXUz5uWJDobODY=;
 fh=nix4+GlRgdmrBdIsvTlJ4IdWZHfR0KZEXFDPSgynqEk=;
 b=QgKHL8AKFpSeZ9SLJBMFXT9/53qSZupLGsfMMv3J+MyQyps3YZgFSFj9TFafW2D40+
 YmQAldXXfKuADkr0fcgXpERFfNIrMKHYpPjmDexyBkJLAO8lmuAFyga1TklbZ9c3ndSg
 OijYqkqo0bPf2Zlb2F3kG8xQpiExh1d2xufeKCJP60jnjGBluPwuxETbB7bldg/vw4jL
 ikf99oq2W+KkDNBOLFDoRrJuXIPDcQ2UE1qWzOwA7QL+BOxWHjrCuvWmo3yNROffrOWL
 OzbDMz2/HYMBPsniVUPLDqwxhGk4EX20c07n2U4QseaOL5jVMxuTnv7bKyQ9A8x3/7cJ
 j/rA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794746216; x=1795351016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OkdAOsx+yWXDDyFyjSOqsYVadQDnmdXUz5uWJDobODY=;
 b=tfRPX0M1GZ3DvRb2FhI9PG+1uDZS8qkPfK+cW1FDN8014q4wHJEYYg6jc72n69goxB
 6yuTiP2NOd55zkUvgOfcHegUTNfT3OEO/HDljMD6WL8kf+y3Smdv0cmg4eIL75VqvW39
 Ifz8Qq+jU/lmbJmkYcvKfQE+MHAUjysFTiT4lzUZ9xorwNIkIM8CoBav///HdSG8mlVO
 /JSxjkjvoOZuAZDr+XSxgGEhgBzovMF3YRcGKhpT9bZBcYmnLF7LHirdhFLndY17iMox
 dn5Ia2o5M2vJnMyjRtZM6yV0m61nfDheyFkfe24hKQ/NuRnNz41hRh6vcPN5FBiy0PUE
 +zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794746216; x=1795351016;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OkdAOsx+yWXDDyFyjSOqsYVadQDnmdXUz5uWJDobODY=;
 b=n47igMjzEcslvofxdd0iqW+NM4trDdmOwhmwUGB6pXrRfFxmSC7WqL/yaSXdmB43sP
 1pV2dGDL9K+T395Q6TEveX9Ut0V5I5l/+cXYRro5ehufiPTUaCzA1JKqiBAr4Cdf6vAl
 w9sEquvNCDHuKzZY2buJ7Yke3AAYwX5ACiEmu15xNwL95yIATZXBVeA6IT3/EuAbXjrO
 t4Ki9EeAssuJI+eaDvgh0Z82d7wAwfjE7IUQCzY1zzazaqlhx32Q5i6XAqR8oeTxN63S
 j6OTQOwJxxrSXVDJfXCnCFugas81bo+P+dhsAKULRB4VCpCD91fvBz8DzeCxj01NMbkf
 9gEg==
X-Gm-Message-State: APuU4Z8KPB53aqn9iBVznL1eHXhJDTa4WdqAqAJirfnqcnG+5Y3lKaEI
 JNHJof05Zt27h9Xy5xRYpexbQVp75cW5XAfMFg8KH/w9ObnzVDJvADBIvUUhRoRFbvDt5233pK4
 GoE3/759c2Q2BK5gVe1e59M22Bc3cC4k=
X-Gm-Gg: AYBFou3sJs3id0SqzWGODPqkfY4MOheSiXlWX/jKNW3wmnQW7wv7wSSsXCaC0d4G5T+
 iAb/P6PwnfIihedFnRh/0crG5MhCpwJDT9kcCyg1KiMC5VFxPUjbMAFt9AGOmb4e8yTycHdzsRV
 NpnAY2Tij/9s93hMp5192Q5hah1H4XyYYAt7JWIT9+HY4+WajfuiMacJjWMUL1hgHqPqvrlGm6A
 HrmdUVastZmh/gtHlGCRek04VHY548odXzev3Y7Hw24cjoYo4btcz+VDWYuySER4EH/uH5s9QJi
 oIHlN+IuGK7drMekvRK8ixOhTF+4EjgCphzWlBFYxtZDs3TKu1zaxIHMQxAhgRRGgL/1mWmhtU1
 URUO/1KURSkJaEhkRGTAzevMPr9ZdtZc/3lUV
X-Received: by 2002:a05:6402:a6c4:10b0:6b4:7b28:858b with SMTP id
 4fb4d7f45d1cf-6b7c0be1709mr3992012a12.19.1794746215766; Sun, 15 Nov 2026
 04:36:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-5-berrange@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 15 Nov 2026 20:36:41 +0800
X-Gm-Features: AclHuK9zWqrGavQfJKERJQpNZqWySWahjtbbjJmW65ul6bPmNMOBnVaW9sCNUrk
Message-ID: <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 9:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> All QOM types must have a globally unique typename, however, for
> user convenience, some might also want to have aliases which are
> permitted to be ambiguous. Define an "Aliased" interface which
> can be implemented by types which want to support aliases.
>
> When resolving an alias, if there are multiple QOM types with a
> matching alias this is considered an error. Ambiguity can be
> resolved by matching system state, with the selected target
> being the currently implemented filter.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>
> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfa=
ces.h
> index d222a3d7481..010e37d63f7 100644
> --- a/include/qom/object_interfaces.h
> +++ b/include/qom/object_interfaces.h
> @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPE=
CIFIC,
>
>  typedef struct TargetSpecific TargetSpecific;
>
> +#define TYPE_ALIASED "aliased"
> +
> +typedef struct AliasedClass AliasedClass;
> +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
> +                       TYPE_ALIASED)
> +#define ALIASED(obj) \
> +     INTERFACE_CHECK(Aliased, (obj), \
> +                     TYPE_ALIASED)
> +
> +typedef struct Aliased Aliased;
> +
>  /**
>   * UserCreatableClass:
>   * @parent_class: the base class
> @@ -242,4 +253,70 @@ bool target_specific_class_creatable(ObjectClass *oc=
);
>  ObjectClass *target_specific_class_check(ObjectClass *oc,
>                                           Error **errp);
>
> +/**
> + * AliasedClass
> + * @parent_class: the base class
> + *
> + * Interface for classes that want to declare they have aliases
> + * for their primary type name.
> + *
> + * While QOM type names are required to be unique, aliases allow
> + * for ambiguity across classes. The ambiguity is resolved at
> + * runtime based on system state, typically by the selection of
> + * a specific target. If ambiguity cannot be resolved, the user
> + * will need to use the unique QOM type name instead.
> + */
> +struct AliasedClass {
> +    InterfaceClass parent_class;
> +
> +    const char *const *aliases; /* NULL terminated list of typenames */


Hi Daniel,
I have a though that can we specify the target for each alias, so for examp=
le
"aarch64-virt" will pair with QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64)
and
"arm-virt" will pair with QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM),
so that when select name aarch64-virt, we will automatically infer the
QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64) out.

Also
"virt" will pair with QEMU_ARCH_ALL, this is for single-target binary.
So that the paired target can be either QEMU_ARCH_ALL or single
QEMU_ARCH_BIT(target_arch).
After this design,  the TYPE_TARGET_SPECIFIC won't be needed anymore and
we can use machine names to select "target_arch" in an explicit way(As
each alias name is
mapped to explicit QEMU_ARCH_BIT(target_arch)). for QEMU_ARCH_ALL is
only work for single-target binary.

And we can add some helper macro to generate the pair easily.

> +};
> +
> +
> +/**
> + * aliased_class_matches:
> + * @oc: the class object to check
> + * @typename: the possible type name alias to check
> + *
> + * Determine whether @oc implements the Aliased interface
> + * and has declared an alias that matches @typename.
> + *
> + * Returns: true if @oc implements Aliased and has an
> + * alias named @typename, false otherwise
> + */
> +bool aliased_class_matches(ObjectClass *oc,
> +                           const char *typename);
> +
> +
> +/**
> + * aliased_class_resolve:
> + * @implements: a parent type to validate
> + * @typename: a type name to search for
> + * @errp: pointer to a NULL initialized error object
> + *
> + * Search all registered QOM types that implement
> + * both @implements and the Aliased interface for
> + * one that declares an alias @typename.
> + *
> + * If there is a single QOM class with a matching alias
> + * it will be returned.
> + *
> + * If there are multiple QOM classes with a matching
> + * alias an error will be raised about the ambiguous
> + * match.
> + *
> + * If the QOM class also implements the TargetSpecific
> + * interface and the current system target does not
> + * match the declared supported targets, aliases for
> + * that QOM class will be ignored. This is usually
> + * sufficient to resolve ambiguity between types.
> + *
> + * Returns: a unique QOM class with an alias @typename,
> + * or NULL if zero or multiple aliases match, with @errp
> + * set.
> + */
> + ObjectClass *aliased_class_resolve(const char *implements,
> +                                    const char *typename,
> +                                    Error **errp);
> +
>  #endif
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index f523a55b93a..136629f88b2 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -305,6 +305,57 @@ ObjectClass *target_specific_class_check(ObjectClass=
 *oc,
>  }
>
>
> +bool aliased_class_matches(ObjectClass *oc, const char *typename)
> +{
> +    AliasedClass *alc =3D
> +        (AliasedClass *)object_class_dynamic_cast(
> +            oc, TYPE_ALIASED);
> +
> +    return alc && alc->aliases && g_strv_contains(alc->aliases, typename=
);
> +}
> +
> +
> +ObjectClass *aliased_class_resolve(const char *implements,
> +                                   const char *typename,
> +                                   Error **errp)
> +{
> +    g_autoptr(GSList) objs =3D object_class_get_list(implements, false);
> +    GSList *el;
> +    ObjectClass *ret =3D NULL;
> +    g_autofree const char **matches =3D NULL;
> +    size_t nmatches =3D 0;
> +
> +    for (el =3D objs; el; el =3D el->next) {
> +        ObjectClass *oc =3D el->data;
> +
> +        if (aliased_class_matches(oc, typename) &&
> +            target_specific_class_creatable(oc)) {
> +            matches =3D g_renew(const char *, matches, nmatches + 2);
> +            matches[nmatches] =3D object_class_get_name(oc);
> +            matches[nmatches + 1] =3D NULL;
> +
> +            ret =3D oc;
> +        }
> +    }
> +
> +    if (nmatches > 1) {
> +        g_autofree char *matchesstr =3D g_strjoinv(", ", (char **)matche=
s);
> +        error_setg(errp,
> +                   "Object alias '%s' is not unique, matches %s",
> +                   typename, matchesstr);
> +        return NULL;
> +    }
> +
> +    if (!ret) {
> +        error_setg(errp, "Object '%s' not found, no child of '%s' regist=
ered",
> +                   typename, implements);
> +        return NULL;
> +    }
> +
> +    return ret;
> +}
> +
> +
>  static void register_types(void)
>  {
>      static const TypeInfo uc_interface_info =3D {
> @@ -317,9 +368,15 @@ static void register_types(void)
>          .parent        =3D TYPE_INTERFACE,
>          .class_size =3D sizeof(TargetSpecificClass),
>      };
> +    static const TypeInfo al_interface_info =3D {
> +        .name          =3D TYPE_ALIASED,
> +        .parent        =3D TYPE_INTERFACE,
> +        .class_size =3D sizeof(AliasedClass),
> +    };
>
>      type_register_static(&uc_interface_info);
>      type_register_static(&ts_interface_info);
> +    type_register_static(&al_interface_info);
>  }
>
>  type_init(register_types)
> --
> 2.56.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo


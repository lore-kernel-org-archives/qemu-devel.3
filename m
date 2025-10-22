Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970CFCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWZw-0001Mo-5P; Wed, 22 Oct 2025 07:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWZl-0001K4-3M
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:19 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBWZf-0005OU-Mj
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:00:14 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4e8a25d96ecso15130301cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761130809; x=1761735609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McTDMmm6QPenYAkMV4SaAW97+I5j3duQ0g7xC+IiEwI=;
 b=iQ+ZNAvdeShLaDq1mBvhAuZTscsyqZ6ZNJ409D4F9YIamxWplF2j/cnzv+G6pKbYTK
 jJh7ggmAsFCU67eOJ7NDT52Nf3E3Flw2EpPGzLnyRPYiGwZ0BiiJkdDCjUSRn9+EZ44T
 8STQyoe0j0BYYtZddGZLTwaEZ0EuXJH20y44JGhC55/mMMgPWamNt/YNrzIULTrA6j4W
 95ZBbVh+r73foGW0qwPWTwp6QCYG5vDRSF5NUNoVyA4c6hp4AQYA8JP5Y8ZJpf91XauV
 cH9+LwT6QoPzZNNz2KDg8YMbCgfiB8wacbxhUXA9yGFdGZWnl5+2eA3myl6Jhd0FLOYj
 TpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761130809; x=1761735609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McTDMmm6QPenYAkMV4SaAW97+I5j3duQ0g7xC+IiEwI=;
 b=w8kAHF1ZxrArC9/tPrbszoxxeI/42axOOxcK77nAcknX5UJkl+bLdQiQJkCb0qZHH/
 Mf9OYh+wf+r0rehjcMN+xzi2PipBP9spSGK581OVsl+1nAswirpSPgUA862y0SANV7Hz
 JKNvCG226enMuiVnT5cYCAIe+FYFN20caJKy3g9F8IniGa0V5Sb0ePQ0u27u2yFE+/+K
 vELeEd6O0RWnL/4ZIH+KxNgwzguqAoxtdEb3jmIHPl1TQXFbCY6NrhM+A/rxs6wFvXB9
 bj59yz50eTQKQPFRrsncUo53CqczUkLSLcAuNpOy3/pj7Rime4OokYGjc4M9vljO6SDV
 AlXg==
X-Gm-Message-State: AOJu0Yz18lhctcHH1DyDr6EkWnXR/JBtTNAyJ2rsBHSaj0SvkgJ/yyKp
 xSOEckJ/rQienY/ERUvmVy7OK4NpphkvW0lrY7gP14oW9MRImMY6ortINeC/sxuqornJunX3N06
 SifcL9YdcOYdTy1n08Vt0nDUJRb1S24Q=
X-Gm-Gg: ASbGncseAiZyz6t0LibnA5Qer14Otp/kLl7j/GAyjcxz7/fJJCyGMtyuNGBIIvSqyYL
 KDL3mtvUX+JZEjJFKcNbozXjh9AjKluEthuZnydtKGvVQP9Ct4FwtnRD1ReL/q+cSx1IpFgbIKm
 sEyL6izE0AAuptJEuPTeRTOCCX9OOgU1knjqGy41IxjlNt6IW9H4D7JLUJ5w0yuLQr/Lj+s2uL0
 EGMoiMHxaE/zBXn5FNAeqjio5WYjuXTgMPv65vHFetV3bMRl1q7bGSMQENK/IxErjPpofVTpSnH
 ksC2yiFh3ujK8PH6
X-Google-Smtp-Source: AGHT+IF4IlP1X9kDdTlBiAkd/WKzj5+sD3cEI9qiDVDRw4AdO0y3C6GZuZDVgb42xhVBjuV1RM4D0OMrijVdJGrO614=
X-Received: by 2002:a05:622a:650:b0:4e8:aa22:def3 with SMTP id
 d75a77b69052e-4e8aa22e558mr209278511cf.19.1761130809120; Wed, 22 Oct 2025
 04:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-2-armbru@redhat.com>
In-Reply-To: <20251022101420.36059-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Oct 2025 14:59:57 +0400
X-Gm-Features: AS18NWC226YaEfJj8jIJ_JUYlWqUBznfYtVZ4gvBYwl-wRC2vdO0Kl6SLnj1-Ng
Message-ID: <CAJ+F1CKdasvQ14r+e2OEKFk+=4Yu2Mgg8EqSe_ZNQJDVoyiEKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] qdev: Change PropertyInfo method print() to return
 malloc'ed string
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

Hi

On Wed, Oct 22, 2025 at 2:15=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Simpler (more so after the next commit), and no risk of truncation
> because the caller's buffer is too small.  Performance doesn't matter;
> the method is only used for "info qdev".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/qdev-properties.h     | 2 +-
>  hw/core/qdev-properties-system.c | 7 +++----
>  hw/core/qdev-properties.c        | 9 ++++-----
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 0197aa4995..60b8133009 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -34,7 +34,7 @@ struct PropertyInfo {
>      const char *description;
>      const QEnumLookup *enum_table;
>      bool realized_set_allowed; /* allow setting property on realized dev=
ice */
> -    int (*print)(Object *obj, const Property *prop, char *dest, size_t l=
en);
> +    char *(*print)(Object *obj, const Property *prop);
>      void (*set_default_value)(ObjectProperty *op, const Property *prop);
>      ObjectProperty *(*create)(ObjectClass *oc, const char *name,
>                                const Property *prop);
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index 1f810b7ddf..4e1afaac82 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -865,15 +865,14 @@ out:
>      visit_end_alternate(v, (void **) &alt);
>  }
>
> -static int print_pci_devfn(Object *obj, const Property *prop, char *dest=
,
> -                           size_t len)
> +static char *print_pci_devfn(Object *obj, const Property *prop)
>  {
>      int32_t *ptr =3D object_field_prop_ptr(obj, prop);
>
>      if (*ptr =3D=3D -1) {
> -        return snprintf(dest, len, "<unset>");
> +        return g_strdup("<unset>");
>      } else {
> -        return snprintf(dest, len, "%02x.%x", *ptr >> 3, *ptr & 7);
> +        return g_strdup_printf("%02x.%x", *ptr >> 3, *ptr & 7);
>      }
>  }
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index b7e8a89ba5..422a486969 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1117,12 +1117,11 @@ static void qdev_get_legacy_property(Object *obj,=
 Visitor *v,
>                                       Error **errp)
>  {
>      const Property *prop =3D opaque;
> +    char *s;

Why not g_autofree ?

>
> -    char buffer[1024];
> -    char *ptr =3D buffer;
> -
> -    prop->info->print(obj, prop, buffer, sizeof(buffer));
> -    visit_type_str(v, name, &ptr, errp);
> +    s =3D prop->info->print(obj, prop);
> +    visit_type_str(v, name, &s, errp);
> +    g_free(s);

otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  }
>
>  /**
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


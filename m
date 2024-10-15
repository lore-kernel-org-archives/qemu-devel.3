Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C560CFC278
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dGO-00069Y-Q2; Tue, 15 Oct 2024 04:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0dGN-00068m-0x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0dGL-0007uf-A8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVLMMV0ZOS4bQWNgNykli4jhI57kMtV/Y2QFmeFqF+4=;
 b=NPdmP4LoqOelnxhilULjipn6KiIVEJxyLW3j3rVs0oJasgVH3bxSdzEwih3FPGJY8c6pHU
 gZj47h9L7tFo9mf+UUc1yI9Z7KQUItAxDGK8KugHfb1ATx6NsXHFVAKVd8JkgmJaCTcBih
 F7hfFSQ7a5KqYny8CDX/IlIhFLYHeRw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-qFw4n7_tMoa4OsdxMFxmFw-1; Tue, 15 Oct 2024 04:50:38 -0400
X-MC-Unique: qFw4n7_tMoa4OsdxMFxmFw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46049917c2dso95993131cf.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 01:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728982238; x=1729587038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVLMMV0ZOS4bQWNgNykli4jhI57kMtV/Y2QFmeFqF+4=;
 b=LZW2YDoAnGRnXUfKJMqklQ/tv7a/0ou39PCaINRJSlJXM+q/eDEnxU0liBPp9gqFXd
 iwg5fSnWkubygwfRKK/vNlr6iYorP+Wqo2Gqm8Mncu4CyTFODBVMbisdVq5sUcHOhivE
 1de0ppsOrDLlFkCgHUN6i/RjOgYcSCPG69DlQjLdEvtHmGo8Y9kSELfD+J1/HyKXxzSX
 sHNGcsW24hM3Dqo6FLiuwY+m+hhZto4MSZZcgMVysmPG1WOhvk2QDolIva+Nm+8gVt/d
 ehWa3mqLzMbivMl1fhHJRnpkvyjEOmnq+nMxJTLf7FPrbHEQadfkWkOQ1O3UiYg3prXA
 uwBw==
X-Gm-Message-State: AOJu0YwJ/2Uut/h76Kz2XUxmP5GAQdC9WOx8HJtwwqab74Sxkmtz1EoJ
 nDXog0o8DQQ06qN1z4WB5mw7VxgrR6l+Dl/xbAVZDwCz+sRkdD5E+Ou57wv/d2RziSS0X6Sd4bq
 YKxPzF7EYOgwu5/5gliLbON2MRIHO1MD9xqCU7NWzL5fcitcynY+dn99NgH+r8VpUeigFg+iq37
 d/omSRvPLm3tMzchpcEjMspWg0qjU=
X-Received: by 2002:ac8:7f16:0:b0:45c:a605:1dae with SMTP id
 d75a77b69052e-460584d0a4emr204875991cf.46.1728982238023; 
 Tue, 15 Oct 2024 01:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB0UU5qyyRgut5UGwCpcGyB1oxvy+4fAWzuBD3oZm6XsdVgUKyPJrHJwwtNxfOwiaIK4x/V4ZRzq99t03Copo=
X-Received: by 2002:ac8:7f16:0:b0:45c:a605:1dae with SMTP id
 d75a77b69052e-460584d0a4emr204875871cf.46.1728982237682; Tue, 15 Oct 2024
 01:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-9-r.peniaev@gmail.com>
In-Reply-To: <20241014152408.427700-9-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Oct 2024 12:50:26 +0400
Message-ID: <CAMxuvazSjsWF1JQw28b4LnS+ysO-paCv5wq8dgugMiUbsU=bQg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] tests/unit/test-char: implement a few mux remove
 test cases
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 14, 2024 at 7:26=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> This patch tests:
>
> 1. feasibility of removing mux which does not have frontends attached
>    or frontends were prior detached.
> 2. inability to remove mux which has frontends attached (mux is "busy")
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/unit/test-char.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index f273ce522612..2837dbb863a8 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>
> +#include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> @@ -184,6 +185,21 @@ static void char_mux_test(void)
>      char *data;
>      FeHandler h1 =3D { 0, false, 0, false, }, h2 =3D { 0, false, 0, fals=
e, };
>      CharBackend chr_be1, chr_be2;
> +    Error *error =3D NULL;
> +
> +    /* Create mux and chardev to be immediately removed */
> +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
> +                            1, &error_abort);
> +    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
> +    qemu_opt_set(opts, "size", "128", &error_abort);
> +    qemu_opt_set(opts, "mux", "on", &error_abort);
> +    chr =3D qemu_chr_new_from_opts(opts, NULL, &error_abort);
> +    g_assert_nonnull(chr);
> +    qemu_opts_del(opts);
> +
> +    /* Remove just created mux and chardev */
> +    qmp_chardev_remove("mux-label", &error_abort);
> +    qmp_chardev_remove("mux-label-base", &error_abort);
>
>      opts =3D qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
>                              1, &error_abort);
> @@ -334,7 +350,13 @@ static void char_mux_test(void)
>      g_free(data);
>
>      qemu_chr_fe_deinit(&chr_be1, false);
> -    qemu_chr_fe_deinit(&chr_be2, true);
> +
> +    error =3D NULL;

Unnecessary assignment,

> +    qmp_chardev_remove("mux-label", &error);
> +    g_assert_cmpstr(error_get_pretty(error), =3D=3D, "Chardev 'mux-label=
' is busy");

However, error_free() is missing.
I'll touch on commit

thanks

> +
> +    qemu_chr_fe_deinit(&chr_be2, false);
> +    qmp_chardev_remove("mux-label", &error_abort);
>  }
>
>
> --
> 2.34.1
>



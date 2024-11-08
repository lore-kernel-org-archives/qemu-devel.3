Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0875BD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9T6K-0006yP-5b; Fri, 08 Nov 2024 12:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9T6H-0006xJ-PX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:48:49 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9T6G-0000Ii-De
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:48:49 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fc0209e87so873990241.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731088127; x=1731692927; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EexUenQHOA1OJGYb7/WbOletI9MGChC6quLK6xQWfU=;
 b=iiMByLyyTwi8fuwF/SMN/1J/+Nu6J1T+zFjVo89aBeSj//SugxHj90fV8XMFl3ZET7
 4M7fhGmPShbN6zDip+x1mSkt+Vd0vu6k/ztEO4Zpdz/fRX6ZPZj1PVGfVbDtN5W73eBV
 XXVeapsf/pQjJwGn+y1H0yCxI99N0HCAQc16+VvEfiStqWACu8DxgaEfZXoqGndVdW3f
 B/jzPOvty0rjcUgif8cwZ6Rgk2Y0Ji1qqDPOnv1WRCjgYRe1aEk3JD46lnvmEvAJYHsL
 sQPrQOi5R6wa63CH70IQoXLfGgcgaARBkAZlptSNlz4vkrzxgTmC5ZmEoXPCoMlcZNY4
 is1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088127; x=1731692927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EexUenQHOA1OJGYb7/WbOletI9MGChC6quLK6xQWfU=;
 b=g8UF2qCl7qY+JXDmACx5XGGCPKqkZwOOwmZoEhv6gW2IjRHC01/f/ZmYwfgtwScK5k
 v6Xoc2Ajw+A3wTT1jzJcC3WFS8XhkE4p6EMstn7MBnsWOk1sFQkj0fHDbzuQxsDC3ZB7
 D/IXjKNRBdan6mrlTZmnptphmjyKUhSr8foiGfwwiCMyRTJZO3kkkCkHX9cTj1tWzDtX
 d9sfC+/7Zu2ENaf2rkde5XCxr8deVW/ZymXDMVdRUcK4o2KHH0ybGcagW3Sd5G2AEA7i
 i8qvvE6wvQ9akAdWRszI3MBQjeR6QaIqYK/vPXoZ67E2jrhxEjmKJeOeUOtrniXsIin2
 j16w==
X-Gm-Message-State: AOJu0Yx40Z1zc2JNwIx0C5QSaLs+HZFxNSJQaGHkDf7GwGx37KnbamYY
 uOH1GrzSJXS1di+VLkCdSOLhgVkdD2U+yVTDV5NZPCH8ub3P/jHA1zVpEA8/4bBU/ikWkzfVXOV
 F/a0jTGBTBBeOtYQEEWBxvaqJSbY=
X-Google-Smtp-Source: AGHT+IGLt3vicU9c0CQ5BqAYIQIRvg+VJ8pfAzK1ybh/wCvd8w0PMTmvRM8Q5WsPOdvyQ+LRffK4g6DUKxREe3roJrU=
X-Received: by 2002:a05:6102:5121:b0:4a4:79cf:be83 with SMTP id
 ada2fe7eead31-4aae139186bmr4178415137.10.1731088127220; Fri, 08 Nov 2024
 09:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20241108173828.111454-1-pbonzini@redhat.com>
 <20241108173828.111454-7-pbonzini@redhat.com>
In-Reply-To: <20241108173828.111454-7-pbonzini@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 8 Nov 2024 23:48:50 +0600
Message-ID: <CAFfO_h7-1KMJoM46a=W8wv4-5VzKcYHEgTmT3GpFVg7E6tHyxg@mail.gmail.com>
Subject: Re: [PULL 06/13] eif: cope with huge section sizes
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92b.google.com
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

On Fri, Nov 8, 2024 at 11:38=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Check for overflow as well as allocation failure.  Resolves Coverity CID =
1564859.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
>
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index 61329aacfe1..7a8c657f23a 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -119,6 +119,10 @@ static bool read_eif_header(FILE *f, EifHeader *head=
er, uint32_t *crc,
>
>      for (int i =3D 0; i < MAX_SECTIONS; ++i) {
>          header->section_sizes[i] =3D be64_to_cpu(header->section_sizes[i=
]);
> +        if (header->section_sizes[i] > SSIZE_MAX) {
> +            error_setg(errp, "Invalid EIF image. Section size out of bou=
nds");
> +            return false;
> +        }
>      }
>
>      header->unused =3D be32_to_cpu(header->unused);
> @@ -278,7 +282,12 @@ static bool get_signature_fingerprint_sha384(FILE *e=
if, uint64_t size,
>      struct cbor_load_result result;
>      bool ret =3D false;
>
> -    sig =3D g_malloc(size);
> +    sig =3D g_try_malloc(size);
> +    if (!sig) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>      got =3D fread(sig, 1, size, eif);
>      if ((uint64_t) got !=3D size) {
>          error_setg(errp, "Failed to read EIF signature section data");
> @@ -320,7 +329,12 @@ static bool get_signature_fingerprint_sha384(FILE *e=
if, uint64_t size,
>          error_setg(errp, "Invalid signature CBOR");
>          goto cleanup;
>      }
> -    cert =3D g_malloc(len);
> +    cert =3D g_try_malloc(len);
> +    if (!cert) {
> +        error_setg(errp, "Out of memory reading signature section");
> +        goto cleanup;
> +    }
> +
>      for (int i =3D 0; i < len; ++i) {
>          cbor_item_t *tmp =3D cbor_array_get(pair->value, i);
>          if (!tmp) {
> @@ -503,7 +517,11 @@ bool read_eif_file(const char *eif_path, const char =
*machine_initrd,
>                  goto cleanup;
>              }
>
> -            ptr =3D g_malloc(hdr.section_size);
> +            ptr =3D g_try_malloc(hdr.section_size);
> +            if (!ptr) {
> +                error_setg(errp, "Out of memory reading kernel section")=
;
> +                goto cleanup;
> +            }
>
>              iov_ptr =3D g_malloc(sizeof(struct iovec));
>              iov_ptr->iov_base =3D ptr;
> @@ -528,7 +546,11 @@ bool read_eif_file(const char *eif_path, const char =
*machine_initrd,
>                  goto cleanup;
>              }
>              size =3D hdr.section_size;
> -            *cmdline =3D g_malloc(size + 1);
> +            *cmdline =3D g_try_malloc(size + 1);
> +            if (!cmdline) {
> +                error_setg(errp, "Out of memory reading command line sec=
tion");
> +                goto cleanup;
> +            }

I was looking into doing some changes on top of the original patch and
this check above should be if (!(*cmdline)), right?

Regards,
Dorjoy


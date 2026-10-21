Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F7606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MM3KRmCl;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MxngqhH6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYn6-000354-Q7; Wed, 21 Oct 2026 12:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xJYmF-0002Rm-Vv
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xJYmD-0003Fa-G7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792598571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z28FUQ3KbXY8NJ9Eq9XSzHMXna27UXegoFkJbSHJLYA=;
 b=MM3KRmClvMv5bXxNOEjZkFf1Fo0zU7OrDflTYV8t/iQg/vexqqezkYGdBe6dYmWJ19ODbG
 KZk9jq8Y09PniFVvoTpFQpeueOx9xmXK9SzPRzRmcQh71+TDcrYaou4dzmyeXjpkzfuBQr
 lshMY92QgcdD0kzjATKXSQryzCyib2M=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-xHpD62LTOviicA7B5gdNrA-1; Wed, 21 Oct 2026 16:02:49 +0000
X-MC-Unique: xHpD62LTOviicA7B5gdNrA-1
X-Mimecast-MFC-AGG-ID: xHpD62LTOviicA7B5gdNrA_1792598568
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6790b1d37e7so1538070d50.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792598568; cv=none;
 d=google.com; s=arc-20260327;
 b=F+KrFFrF7v4DQzsl8jMrLXwAlY5gyfXzf7nt+MZDXvlrG9rLMmZto3dKFQ8i1sXXQF
 BwFc4JXTk3AbhC4AyGIcOOQeC7cqfxBlQR8VnHEauqFpxxVQQWncz2eK3ifzFMjBug3t
 1i8egOwdAztSmUG9zXBJDgPIDtfsOHr/NYN0kGScyc1tv6o0m/7dsB4tzNuQasjgz2WQ
 zWhdsUWosCIbkvhf4OitBmVCy4lazVQIrUzj8d8sZ/e57K8zSPX6ojQkPINWWe+OuyrD
 bC2s049ugNlRP6pc4gZ4bRrwXveDEezVmxNci1+vKfEohwH9Z3X7Db3/6CVMzRUGTlo7
 dMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z28FUQ3KbXY8NJ9Eq9XSzHMXna27UXegoFkJbSHJLYA=;
 fh=WoI/ACOhU3eHZYq9MTnqXgqLXSFenIguNnbSsHkimMc=;
 b=i5RnfpuCAKKDuJQj+zX4iqbIko2huz1GZwIZuD/VVqcTnU48/C0vypbzSLeV1vOKAG
 w2gWeQcT6oTgEoYfJqLrNtPrxT24dqoM1xJxRQ6p4/AFHChFylHII/LJkSrWjul61UDB
 sVC0+84aA6gRO50plaYGA38H8yatk7eb5Ck7HNCWOzxKoBrIy2HBq27Aqg8KJItqxdKz
 DbFWrcz7tammN/2ZrZxlHRy6RZTFjtMaIrX6aCvdiuU78I3EAbwaikN4sNx7RCaQYWZd
 k+y6vPI/e+bBajJMEd8WlNcWwzZulkoPRsrSQoq0IqX/mHyHwE7nZ3iCQut0x0YdcnJQ
 a/XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792598568; x=1793203368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z28FUQ3KbXY8NJ9Eq9XSzHMXna27UXegoFkJbSHJLYA=;
 b=MxngqhH6EABwjBDn+uB+hJy+piDK5iG/5+YzjelV1DbG97qxcLrUDWGz7YldJkLVLx
 g6CRysuOpZ1VtbAoPSOitzmvRNzP5X1/dPKzAzAPMPJ1vy5hXIteYiK3kdpuJcBfk51O
 Bf60cAvpSvGCGI4Uxj7WaKQogVaUTDaWOyV9l7ixhM2PgjiwQIB047LrpI1HA3W8BXW3
 JA3UELRam9qnc2aB/eGtLtFVt8y7OUDyS5fOTr/Pa8futAFq79Na1L8TDST67iidLqJk
 Pw1kE1RnNR7wVU/xVhGMkr4TBF8oQl366FJXKfaem5ydhYXXd3Rm4TCnLhTXF3PoGLZd
 JZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598568; x=1793203368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z28FUQ3KbXY8NJ9Eq9XSzHMXna27UXegoFkJbSHJLYA=;
 b=czxH2O3oQtNE4M5jTcixxu2f5xMx3axJDdH/5ZshR2kxjTZS+veRLBLL//Hsj9+nug
 Yp+34rOUOD1ncplMD5aST2k2L3hLJVaqdLrxDt7gQxhS4j6yowBa0lJrAdJfnyRGLhdl
 bQHIkdE28jbnuz2MnDuBb1ww0TYEALK91p3NBgjw6eQPI5FcShAJGNvopAkJBlbIP9+N
 A0oNojC1PEFmSYPN2o2nbZrzXyICDnbtsTYGqVKkOe8GqgF/ZClu9ygKm30+20USPizA
 RHtRgWGaaw924QSdA6135D4f6yjvNcZFs41IY9ae/FrMcw6ftCGS3Oc2QIm757YRNLtI
 D8yQ==
X-Gm-Message-State: AFq9FYJdvN2yBs9Nv84vW37gRmcvzPlFF9N38ePtyw0sX/7g6W4mikR2
 E0PJ1EKo7VkdEqMDZ0Vc2BSFtF/B5Ko7L44n5H8YmvkspcCjRUVXDmNn41eQzOLc55ac08SIDTs
 ZMeaB7uuJayG8bmONV6N43wnNwOQqZw6bCTEB+sivoK9jNEE5g7h6FOrxd3qZeKcUHm0L/9p31v
 utcMv291FsflDKUdOmwlQj8jW7n9RRwA8=
X-Gm-Gg: AYBFou2hr5PgvbcNYxeC11EqRH4muJf7+Hjlfe6bHD6KvhHOUfJCQJysKndlk3Ckc6l
 AGthgstVzvjFwLKdxFN943+i+qBThWt5XmOoEjdXi2e07V6Up0Hm4Iu04p2zuh/wVuyxPMFvaiq
 /OHK7sBqQsNyzOV87mvcUMcOFrvbIM8cr791uYs8ys4wgAFnCU2fAOixnZeZIOh7vxjpu2CEtA1
 JFEt5xLxr0MyWBA
X-Received: by 2002:a53:d6cf:0:b0:675:5c06:8a4f with SMTP id
 956f58d0204a3-67a0e58069bmr890264d50.105.1792598568243; 
 Wed, 21 Oct 2026 09:02:48 -0700 (PDT)
X-Received: by 2002:a53:d6cf:0:b0:675:5c06:8a4f with SMTP id
 956f58d0204a3-67a0e58069bmr890220d50.105.1792598567556; Wed, 21 Oct 2026
 09:02:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021063105.102520-1-kraxel@redhat.com>
In-Reply-To: <20261021063105.102520-1-kraxel@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 21 Oct 2026 12:02:36 -0400
X-Gm-Features: AclHuK8x0RKq-GNNxl6buHRmnaENy8PrgNlr_c0gv6sfpuitKw7-wkVzt16bJ8w
Message-ID: <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 2:31=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> w=
rote:
>
> Reduce memory footprint by mapping the kernel into memory instead of
> reading into allocated memory in the common case (no -dtb $file on the
> qemu command line).
>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: John Snow <jsnow@redhat.com>

Using this patch, I shifted about 19MiB of resources from RssAnon to
RssFile. This theoretically allows sharing resources between multiple
QEMU instances in the trivial case using -kernel and -initrd. This
matches how we already load initrd.

--js

> ---
>  hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index fa18bf1aeceb..25e141aa8537 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
>      }
>
>      setup  =3D g_malloc(setup_size);
> -    kernel =3D g_malloc(kernel_size);
>      fseek(f, 0, SEEK_SET);
>      if (fread(setup, 1, setup_size, f) !=3D setup_size) {
>          fprintf(stderr, "fread() failed\n");
>          exit(1);
>      }
> -    fseek(f, 0, SEEK_SET);
> -    if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> -        fprintf(stderr, "fread() failed\n");
> -        exit(1);
> +    if (dtb_filename) {
> +        /* read kernel into allocated memory, so we can realloc for the =
dtb */
> +        kernel =3D g_malloc(kernel_size);
> +        fseek(f, 0, SEEK_SET);
> +        if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> +            fprintf(stderr, "fread() failed\n");
> +            exit(1);
> +        }
> +    } else {
> +        /* mmap kernel */
> +        GMappedFile *mapped_file;
> +        GError *gerr =3D NULL;
> +
> +        mapped_file =3D g_mapped_file_new(kernel_filename, false, &gerr)=
;
> +        if (!mapped_file) {
> +            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
> +                    kernel_filename, gerr->message);
> +            exit(1);
> +        }
> +        kernel =3D (uint8_t *)g_mapped_file_get_contents(mapped_file);
>      }
>      fclose(f);
>
> --
> 2.56.0
>



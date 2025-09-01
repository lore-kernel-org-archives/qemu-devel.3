Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A3CA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut5Ag-000641-Ht; Mon, 01 Sep 2025 10:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut5Ad-0005zH-PB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:06:07 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut5AZ-0007pg-9R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:06:07 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b042cc397dcso124596166b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756735561; x=1757340361; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dVCqf8Omc57edO6ZGy5stUhcPri4shQMFyY5oMwnIg=;
 b=nhZn3ougvAZTV/BD18IR2ZHz/L7FrTrarklJQdD3750TEJoJyFI/Btjlh2epT/ammK
 cXli6V2ceJd3f46IjLvTQyipVZQ/DoicUq2N/eEI8WE/EINKMl5fVWk1ZGnaeXCCMxf3
 TWQCD6VokNQe8ra4tiXHofvT6QljASXAdIyn7JtxkUbDWsNisHEDsFP4P5IfMJdxuulI
 1jFfpS0yE7b/CGmvbIkdBzwmnqzZIyizGy5s3WU1oxeyrFLJ9oRuboGgvEpXuXVTmAHp
 YVSNbm1VDhMks22e9zn82sEQKTPCv7/S2YtwStpT1G9bjBfzC8g94ISO+tbcvSaXWVlj
 0gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756735561; x=1757340361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dVCqf8Omc57edO6ZGy5stUhcPri4shQMFyY5oMwnIg=;
 b=iFn2C12xKyacLX2EK5mj1mrUBazNr24eKLnv5Q3U44AsvXh1Jsngp7yQz8f1MhQPix
 caIDMQuwCgsVPCfW2FW7IlHMr54rZi1Yn2x2eKhxFeHguk2T/3Ltz5zR9uE/kJyzfgoH
 dLmvTaDjdYJcbUtVX25C1KYTqOgIXVc7WE7bAvtROmz7J9nJKtep/XOUhMPqdYg6iOxu
 zkB/eHU7SOi0G5dhQbcwaLbr3/UUO2bdmLJcuvcqJg5ufTA8MssWbNY0cN4sqn6U8qxG
 fCl9f2KxivyuMzOxWChMPq1KYvnTHqzQL28WZBKkRllnxOZRxfQ8e/5/zp2ReeLTg9tt
 2XXA==
X-Gm-Message-State: AOJu0YxN6Udo+V8cTcC9Dc2n5mmVvyjxTKmKNBqRmsFUZGvWItOBWDBj
 YEUkNghcKqd7iMY0dbODYVpE17NEhY7sEarNpdh0XULizR2ezQ5/FbdP5rTzA/03kj5gstfL0mx
 +8YOFIbMWHOV2qfoYFLV3+RvlLv9cImF2wstq5xchqQ==
X-Gm-Gg: ASbGncuqzoVKVF2D0q12+nzaXgDGjLViFTYplVEzJqvp4A8Nj9C003LCDmemkuH0MgX
 sFnnJfFNF0BmtjvMSXXsfZn612rCkEW2k0l/l92cIpC2iLrUiDXie1Hq66a3YDSWETIlbUW1+Lv
 cRyCKLZUVE6oeFGlDZJmQ9N3r2htWT1Xy2w1b6kcvPGb+nCezMxJuvwUXkO/o5yBrw2vqgVKLt2
 Rp8y09MRaFYf1/whZo=
X-Google-Smtp-Source: AGHT+IGMeylbGJEekwN2ny17r3fJ+X/GcbBYAcRcZM87PGqLjW5l6AKwKuc5xgj8Pb9qGNIdZ245B42T8nqD2u5a9Cg=
X-Received: by 2002:a17:907:1c9f:b0:afd:d62f:aa4a with SMTP id
 a640c23a62f3a-b010817fdf5mr782036466b.9.1756735560902; Mon, 01 Sep 2025
 07:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250901132626.28639-1-philmd@linaro.org>
 <20250901132626.28639-4-philmd@linaro.org>
In-Reply-To: <20250901132626.28639-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 17:05:34 +0300
X-Gm-Features: Ac12FXxpkS8-8lPh-jGklotJxuIKPXB7BvPFc2gMZW6beg-1Gs9p0zFbwrCtuCk
Message-ID: <CAAjaMXbDSwXjTFb5nPrK7tWyjbDtxm3mgxOwUK7yMUOG61y6qQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs/devel/style: Mention alloca() family API is
 forbidden
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org, 
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 1, 2025 at 4:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  docs/devel/style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index d025933808e..941fe14bfd4 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -446,8 +446,8 @@ Low level memory management
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
>  Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
> -APIs is not allowed in the QEMU codebase. Instead of these routines,
> -use the GLib memory allocation routines
> +or ``alloca/g_alloca/g_newa/g_newa0`` APIs is not allowed in the QEMU co=
debase.
> +Instead of these routines, use the GLib memory allocation routines
>  ``g_malloc/g_malloc0/g_new/g_new0/g_realloc/g_free``
>  or QEMU's ``qemu_memalign/qemu_blockalign/qemu_vfree`` APIs.
>
> --

If you wanna dust off your perl, you could also add this to checkpatch.pl :=
)


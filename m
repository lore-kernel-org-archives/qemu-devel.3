Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45963CFC26E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 06:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0b8V-0002yb-JL; Tue, 15 Oct 2024 02:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0b8T-0002xr-Qj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 02:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t0b8S-0004MT-EU
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 02:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728974062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWoLAexgKt+KtGIu1vYGD9SIRBif7/L5/x+cHtkKMiM=;
 b=GkPcZYgpKmjcOlKv2BFUDnbv7HM/4yHxOdWj2LnLv4x2PktydPlTZiJ5LT/4P0bRkeHLiS
 GPbCx6MvnRgPrb5L4G1EoGpNGiok/UKXotpsfDGmi2pnhdL/xls4qT1FtVyCjVVxKH8Oj1
 TJ+BjYrQDrObPwreXqcDSGOusrjelkM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-IZ28FZDYP3u4eSUZs5jYjQ-1; Tue, 15 Oct 2024 02:34:21 -0400
X-MC-Unique: IZ28FZDYP3u4eSUZs5jYjQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4606fdde841so31164631cf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 23:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728974060; x=1729578860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWoLAexgKt+KtGIu1vYGD9SIRBif7/L5/x+cHtkKMiM=;
 b=dtC4u3wb5JSyGc55V/nB3W74wX4mdb+oEZtPRK9ijWy3/CqD+ovdBDPMEMaEQFp33r
 OOcZ+H4uPwDKeGmuwNIKRwZLn90ROdJZIPktfuJEyNnVujAWmECCTKAG1l29Ax5/Pnet
 wC8dAf8qUuTcpXaWUc30zqQBui0HbG2IH8P0R9PnoMR+MWU7IS6zDSkAaEbNtsNXSyVm
 V9C1zl/UnbAXwVRSH+5HGeJO5nAe8AImFs+aQU3CuM+dHoPTPYnWxTBOw+4tqJOeUGJ6
 C71Icwy1qzuit+OTASFT60yYfcs9lt+i6oddzLfQwJQO3AR3wBxA+UY40hcR94Z0blVC
 /vqQ==
X-Gm-Message-State: AOJu0YycVyxY3WI0Asm4IQLW1uV7iew574vRnc8LdxgBsL+tHu+71WdF
 k9Pholg7HQExDqf/fv5DPagt26V0ODGGM0XL4ETZqmfy9retGgKM5qJcPMO7Wxjg5MkJ0GyDbjt
 uOmsENPp1SQjO+sjib1vbAahChucBTBDNgEdYfpRQJD9wAkHh3imzDCBrLLutPLzYRUjBxzdVjV
 4w1xHvv8672LZ0ZCjXyfDBDZNGDeA=
X-Received: by 2002:a05:622a:228d:b0:45e:ffaa:35b2 with SMTP id
 d75a77b69052e-4604bbccbacmr228749311cf.30.1728974060559; 
 Mon, 14 Oct 2024 23:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF47Jb0lJzjAeGZgBA7VP9TjzhyCl0lMkO3bDvaPR2n9X7FOdn/ekKyVBk2pzUaYIY1nQk+QC/DMVe+ve27bD4=
X-Received: by 2002:a05:622a:228d:b0:45e:ffaa:35b2 with SMTP id
 d75a77b69052e-4604bbccbacmr228749181cf.30.1728974060301; Mon, 14 Oct 2024
 23:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241014151023.85698-1-thuth@redhat.com>
In-Reply-To: <20241014151023.85698-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Oct 2024 10:34:09 +0400
Message-ID: <CAMxuvazGdkhM_BBnzSZnzf=fniQ6J6Vb4-9tR8VbHW_kWasP8A@mail.gmail.com>
Subject: Re: [PATCH] ui/console-vc: Silence warning about sprintf() on OpenBSD
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

On Mon, Oct 14, 2024 at 7:10=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> The linker on OpenBSD complains:
>
>  ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
>  warning: sprintf() is often misused, please use snprintf()
>
> Using snprintf() is certainly better here, so let's switch to that
> function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/console-vc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 8393d532e7..336a1520eb 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -821,9 +821,9 @@ static void vc_putchar(VCChardev *vc, int ch)
>                      break;
>                  case 6:
>                      /* report cursor position */
> -                    sprintf(response, "\033[%d;%dR",
> -                           (s->y_base + s->y) % s->total_height + 1,
> -                            s->x + 1);
> +                    snprintf(response, sizeof(response), "\033[%d;%dR",
> +                             (s->y_base + s->y) % s->total_height + 1,
> +                             s->x + 1);
>                      vc_respond_str(vc, response);
>                      break;
>                  }
> --
> 2.46.1
>



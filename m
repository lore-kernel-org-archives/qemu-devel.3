Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33884C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtS0-0000zE-A5; Tue, 25 Feb 2025 06:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tmtRw-0000xk-T9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:50:09 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tmtRu-00054f-2f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:50:08 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46c8474d8daso47799121cf.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740484204; x=1741089004; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPAXJ6BAhluC/wqz77rNwGPnRNX0egyINsJEGGnGHbQ=;
 b=mb6aCBJ3IjLzSaX+p/8UkjlcVfk7VC0RhiCHyf28IuSKV4ic5Df8LOP3A5Mx3XcpOI
 uUGVi7v/03oeILT5OpFbgnEydh6c0CDRhgCcFFsbsYxTk/mzWtosxNRXsycwCPZCv2/b
 Wvfjb6Y/mCdqp1mjckinzRdcj7ONyh3cifHlUrz1rOsaG/1vD3hmxkgbys7AYrCpdj5M
 r/cjyPVcI9JCTFkmIaUVZASsNk3RzNRQXhfPrLVysII0cNbHOAN+G5xW6W2LDkKWTVgV
 ZL7QI8QJf5NA/Z8CeMfw/EvQwSodImv+cdyFXc2vXd0ocD8bwSLBz18cgbZjV7G/3lfZ
 yDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740484204; x=1741089004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPAXJ6BAhluC/wqz77rNwGPnRNX0egyINsJEGGnGHbQ=;
 b=lBWOGXJTaJ0FN8Jgs40PjHDJTmByH7iEJJrdd+ypjwprmhbxfCGfkHbCAZPm5yaeae
 QrShp9ohbfqdF5eJxMwSHcId5njeQ2WAq434PDPI6mzr0Xf0McqnnyGq2xjeulUHPsbK
 e6fnBSiauOdkAFArDCULJc09LNGCl2xJX3vB4UzJnStBRivbw+wkFZlGBroHdtBzUa0/
 y7c4giwtNnlQhA5gNqyQxtyJq2WtA+N/1voL9vbcZs6V25Ch4gTm3ei7C5K7f0Dn/EWW
 feMphUR9l5Jp1IbTwjOEb0DXfMimwQ18ILMtiIOJUpH8xJB0WpRfAjQLOyN/j7dcI1Z1
 cfRA==
X-Gm-Message-State: AOJu0YyzACAADPYQIgHyMGl+k/GcEJN+cn8iLd4MS5odM8xBKPu6E9oS
 AdNQ+wY5rCCvFh3Lv7Tgll3Jz7GyN1RuhsxDm9U5M/nM7jSWDo9jfB3XIIhPhwxN7impT8+U7Lb
 0QLT2hrRorpllLX1zcffVDQ0FfEY=
X-Gm-Gg: ASbGncvpxlfl4sL5sASi93CPF1PwKaA6D9WfPzUPNzWnulVux21P9CRerYdWC5hiUvy
 sO0LjWxZ8rKudpghbpstCf4BSVXGMKw/7ZYwOqvKDsuZ6eo6EFFQoOrFxSiVEV3nVbltXD1EIH3
 Uv8RR8CYBtXdKkr5qMTUbL0uUB4EkL3i+ywRAjsOMh
X-Google-Smtp-Source: AGHT+IFzem9bhfv1dXJXe67Yc/KYSjPYoJ3jdn3DvF+VH6ijvOsXUJgI8r1BMXqVEyFfkEta33791MMwt0rVmW6S7ME=
X-Received: by 2002:a05:622a:34c:b0:472:801:3e71 with SMTP id
 d75a77b69052e-47224716cdbmr256781321cf.1.1740484204365; Tue, 25 Feb 2025
 03:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20250225104526.2924175-1-haoqian.he@smartx.com>
In-Reply-To: <20250225104526.2924175-1-haoqian.he@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Feb 2025 15:49:52 +0400
X-Gm-Features: AWEUYZl0nfl3EeTfxCbj6x1biaL3Z9n5jOQN66m08gSRBnNBUKYG8PXDRbGo2M0
Message-ID: <CAJ+F1CLTXwgbJzxNiK7ZyrK_-ToD2ibwU8WR27y3w4Mj5O+eVw@mail.gmail.com>
Subject: Re: [PATCH] chardev: use remoteAddr if the chardev is client
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Feb 25, 2025 at 2:47=E2=80=AFPM Haoqian He <haoqian.he@smartx.com> =
wrote:
>
> If the chardev is client, the socket file path in localAddr may be NULL.
> This is because the socket path comes from getsockname(), according
> to man page, getsockname() returns the current address bound by the
> socket sockfd. If the chardev is client, it's socket is unbound sockfd.
>
> Therefore, when computing the client chardev socket file path, using
> remoteAddr is more appropriate.
>
> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
> ---
>  chardev/char-socket.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 91496ceda9..2f842f9f88 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -571,9 +571,13 @@ static char *qemu_chr_compute_filename(SocketChardev=
 *s)
>
>      switch (ss->ss_family) {
>      case AF_UNIX:
> -        return g_strdup_printf("unix:%s%s",
> -                               ((struct sockaddr_un *)(ss))->sun_path,
> -                               s->is_listen ? ",server=3Don" : "");
> +        if (s->is_listen) {
> +            return g_strdup_printf("unix:%s,server=3Don",
> +                                   ((struct sockaddr_un *)(ss))->sun_pat=
h);
> +        } else {
> +            return g_strdup_printf("unix:%s",
> +                                   ((struct sockaddr_un *)(ps))->sun_pat=
h);
> +        }
>      case AF_INET6:
>          left  =3D "[";
>          right =3D "]";
> --
> 2.48.1
>
>

This patch doesn't change anything, and I don't understand the problem
you are trying to fix.

Can you provide more details or a test scenario?

thanks

--=20
Marc-Andr=C3=A9 Lureau


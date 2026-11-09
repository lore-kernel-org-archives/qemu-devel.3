Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBE606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfC82SHw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQJHc-0005gV-Fl; Mon, 09 Nov 2026 01:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xQJHZ-0005fv-TP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:55:09 -0500
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xQJHY-0005Iw-AW
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:55:09 -0500
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-3700ed8dbe3so1352061eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 22:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794207306; cv=none;
 d=google.com; s=arc-20260327;
 b=KPD18qhQENbMvpySimhoZ6hEDt9BcrSxa8Q6ZxQyUbS1KxqvpJRLMCQSaTgkK2zfYa
 VtUS5/IRbR2hCsKUM+xN9mWsYQq/BzLV+0hgEEG4GAfYfWaYZAwtFAc2brNlQM5wIkLB
 0lrTKtN3yuTBICSXf6gmri82ztV6DNzVFw9MF//5PZIwLULrPuS8/h1Y1clPAXy1V6md
 eDLjNcRHyadN6csUWN4Gs42ME52/kDcVQ5sUdlnLTkBClOpImh2z6iqgkmHRfMGjpWEI
 scyvP/MSqhp5Y4OgKzhPIQEiEG5AAxmkin0qgRAQPiGNGupkPJ7l8bixiBxl2YDSfZ0O
 aShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pEP6n3UHjTsjTHqvF7Z47jJuAvgH+tdDSJ5OrfE0C+I=;
 fh=NpyVAgOMiTOwEiShWM16nHoPt1Q+/ENF3zIhDVXWVHA=;
 b=lUDuFQNxVTE5vXxcBXPZx/tFZmq/Jk2XuYEHyxnQp9SXCmk0FtbTge+05HUev5Xc26
 W6zFL0tXPFJUDG5QgOM8L2n29FtbEl2CKJBYz7xGVnUUu6ItCFMmf4x9zPSp8+15FZ4o
 S+YonG85qa3dpZQ68aJ4vdPl6uJGpj5HBoY8E1PBBHlANa/Xzxu57gnzyGKozxTDqF3+
 2uJO5/6HmSUDA0helUuEqRBVzs00RWVM32wbZLc2QJsNx5ck9VZYAv7Y/hHrzib+F0eF
 1ZILcbfYYOokkG2myFWwxIATCQwnrq1VRMENuA4WjEkj+3Nl3gZK6yX400y5nbi36cdG
 3Big==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794207306; x=1794812106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pEP6n3UHjTsjTHqvF7Z47jJuAvgH+tdDSJ5OrfE0C+I=;
 b=xfC82SHwBRoDVpivqeOGwLvzNqFPre7vgn99xrtMecbcVABoQ6wMosSxOvEll+RRl5
 HxXsDc1qdd5GmR/Tkb+kStVH2r+oCSb9vBFazYeieNsfuttqGDLZe/6OmccDfeQdEMwf
 WT99Aq+Opg6HfIZeGR5Yjzc6Z9VEKst9Z5SSIt9a15pTtvzj5Lov++OC21Qhkg3o2H6l
 5KRPLkgOks7h9vKbVX5Uw/GW/Gis1ZQpaRmyYoS2KaKhc9zPKJmnYAxvoOKH7CANO7le
 YHZ2z70wxQYJOv28wgWNg395XHbZJSSpgjgVVaEFwkwIs2BleTKAiuMw8HLkHXsDoWIJ
 rQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794207306; x=1794812106;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pEP6n3UHjTsjTHqvF7Z47jJuAvgH+tdDSJ5OrfE0C+I=;
 b=yb3gFebxknqxPojJkSTcvWV6MF6bqIOPxN3ssq2M40Szk6JEhvC6G/0+6B0MHUHxum
 VdhLPWw0aA2gaXXOPnpd2Q99E7MA4m1CJCLLyjm0h9FyAnSztRmxvaJojR28PCYChvcj
 bXoV76niyOsXmi/c5YnUJSfMoiJPJJnDM+WzROcrWdExoDnI3lZEwEDS5c4yyW8hVj2l
 a5ptmZjceQlZ5y5aW5TGrVnP7W4RvjMZXmIDlNRA4nPCCtj/3W4H5W+nAKnnfu3diWSR
 tGlSwJoS8m8Uzu479aqX5fMhcCvAn1yWCp2VBJfU+N7mgymvKtJpD3kr0c8TXhN8pOCZ
 XKvQ==
X-Gm-Message-State: APuU4Z//2dHgMbl033UsVV9TXqDzjDMU7OxGFnEcDqDuHkUeaXxxsbln
 EzxTp/kMaSvsxiSQs7gWK94Id8cPkNrZ8A+x7Wppr1pbdacgVgoQjkHPuMsunYKdWiKDGfR1oWL
 Jn+WRdS+/SzyFxqEKHzL1QD2qU7jQbnk=
X-Gm-Gg: AYBFou1S/gWdLsBBgKguN8e6tRF0fV2K0mAkJU43JLjNBXcU3Mfw5MOVZNMssR3SxJJ
 tr1A23NyC/cDpenXmw8c/RX2Cegpt9VoCmM9AOXVzaBvGQ78CS6kML4gTkIolVZ8vKiAlfMXQua
 wKksJe6GNY7YE9b++K9TnHNZL2qHNQL8giFGPdhe8nyt8rnR9EsYQVn1rW+Jj3uLfi5v5I2cfaH
 OgLu4rwViMrRknU5U18o6q6lDmnwGTVUD1bEM3v/Dvz1iE3pyaLjOHlyOKFyPHengJqNNEPmVLa
 W/cUW/93D1y90hN7ua0H9LrzSKyVCOgfG6hR3Hb6mwZqoPR4ezc1ni320a5+DxUVZpYCKfNrJin
 3+U27905YqjG0v+Z2dCNzcQivqAQKiwWU+Bs5yHYVJReqV7aMm0pwwNDXv+sMFc3ZGUMO
X-Received: by 2002:a05:693c:41c1:10b0:35d:4185:5395 with SMTP id
 5a478bee46e88-3725dd59d99mr5790089eec.16.1794207306073; Sun, 08 Nov 2026
 22:55:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108193433.225841-1-jpaulma23@gmail.com>
In-Reply-To: <20261108193433.225841-1-jpaulma23@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Nov 2026 10:54:54 +0400
X-Gm-Features: AclHuK-8OoobdZhw04j6rdvWsAWgfGqKDwwriuZBLtL3XxoAqsVekih34hWbBTs
Message-ID: <CAJ+F1CKDOCkMyV7EePwsTWynAQ-FL4XJ4aBewja4D3uQVUp5Qg@mail.gmail.com>
Subject: Re: [PATCH] contrib/vhost-user-bridge/vhost-user-bridge: Convert
 calloc to g_new0
To: jiputer <jpaulma23@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132a.google.com
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 12:40=E2=80=AFAM jiputer <jpaulma23@gmail.com> wrote=
:
>
> In the function, vubr_new, calloc was converted to g_new0.
>
> Signed-off-by: jiputer <jpaulma23@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> This patch belongs to this issue:
> https://gitlab.com/qemu-project/qemu/-/work_items/1798
>
>  contrib/vhost-user-bridge/vhost-user-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhos=
t-user-bridge/vhost-user-bridge.c
> index a6f7ec226c..e3b979b462 100644
> --- a/contrib/vhost-user-bridge/vhost-user-bridge.c
> +++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
> @@ -540,7 +540,7 @@ vubr_accept_cb(int sock, void *ctx)
>  static VubrDev *
>  vubr_new(const char *path, bool client)
>  {
> -    VubrDev *dev =3D (VubrDev *) calloc(1, sizeof(VubrDev));
> +    VubrDev *dev =3D g_new0(VubrDev, 1);
>      struct sockaddr_un un;
>      CallbackFunc cb;
>      size_t len;
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


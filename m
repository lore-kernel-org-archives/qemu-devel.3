Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A32C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmIMl-0006JH-4M; Mon, 18 Mar 2024 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rmIMj-0006HB-PV
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rmIMf-0005SG-3x
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710788978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kShZ0f8Cwr4bs5F/k6UZsBMSJk3B4gV3T+1MR2srdSU=;
 b=Rn7EnhopiWluzwn7kAIUR8mF09HPL1BDOinQNYD6XZne805bXFRnPXhF45UYF7PDZLuMph
 pyc2RMtap+yjqv5lYIQgDvXM2rg9v4aY6lsv751j1Zwfh4Hlm/cQMcostHqEQ92NuQXkTd
 wV4FBS71OEI4zV9BWNwjhoH7QBj2vks=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-7YJUB-kYM7inPHejk0WYXg-1; Mon, 18 Mar 2024 15:09:36 -0400
X-MC-Unique: 7YJUB-kYM7inPHejk0WYXg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d480b8dd54so34843271fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710788975; x=1711393775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kShZ0f8Cwr4bs5F/k6UZsBMSJk3B4gV3T+1MR2srdSU=;
 b=tGpLi794pqkhz2vYIcp6p1pHc6wV4WbUyFOFRi53DrXNu5OkLameznr+rPHYGXE1wL
 mPcKWwB8gFFjI0DzYcdT18Z8st6rFyWQkEcq3ZgWJIWLIoJsTWqdXNh/uSv8226UtExt
 7ef4N9Gd1RA25vdq8ZMqWBI2aqKxTU0YeOgwU9MMg1VNtbED8auyKLepeLkQPvikYLEw
 HpTxN7cbXSGXKQYyVNiKSpXVt5A0XrjLA/SWbDofiDZEw1gTUcxbCh27CcurQTFXEGlp
 WFcyINTLEKLX5PqSRy9oicVkaYNwWrvEYD7xMO6pK5rcAJB3dhr7upn1VTWfWuOZ8OV2
 iC7Q==
X-Gm-Message-State: AOJu0YydLl/DOEE2jOPUMMR7kTqcTT5nbsFkQKfsbn0VjEyZ2oFaQ/CL
 /mszOe/JJYf+0jkqE2c3zMo5vc1dswjdLaTPlkPzQnHvRnPhfgxvbkXi4ThCOTtYrlT9UEc55l2
 nYyRctQ1RmzIsPwjz7eqNqkVlqvtpzLbrTTMU4xy7GgwbyeBCj5pWZC0phIzXzUZ4PoGl+FxFe+
 Wa1YAPsTq4lX2UPlNADy8URGCo5Uc=
X-Received: by 2002:a05:651c:1025:b0:2d4:7264:c5c6 with SMTP id
 w5-20020a05651c102500b002d47264c5c6mr7813141ljm.51.1710788975294; 
 Mon, 18 Mar 2024 12:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQKW99T7YfDtypHSeqi2x2UZm8yY2cRzyEWvw21wvh7IVUDX6u+UgRySSCSkkyPShbmNoSTWAXCqzh/y6V3Jw=
X-Received: by 2002:a05:651c:1025:b0:2d4:7264:c5c6 with SMTP id
 w5-20020a05651c102500b002d47264c5c6mr7813127ljm.51.1710788974864; Mon, 18 Mar
 2024 12:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240318182330.96738-1-berrange@redhat.com>
 <20240318182330.96738-3-berrange@redhat.com>
In-Reply-To: <20240318182330.96738-3-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Mar 2024 23:09:23 +0400
Message-ID: <CAMxuvaz6_pRAaNX8zD-EGdTvhPhGcTEs8n+=tZOAYNLVAAc8hw@mail.gmail.com>
Subject: Re: [PATCH 2/3 for 9.0] Revert "chardev/char-socket: Fix TLS io
 channels sending too much data to the backend"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 18, 2024 at 10:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> This commit results in unexpected termination of the TLS connection.
> When 'fd_can_read' returns 0, the code goes on to pass a zero length
> buffer to qio_channel_read. The TLS impl calls into gnutls_recv()
> with this zero length buffer, at which point GNUTLS returns an error
> GNUTLS_E_INVALID_REQUEST. This is treated as fatal by QEMU's TLS code
> resulting in the connection being torn down by the chardev.
>
> Simply skipping the qio_channel_read when the buffer length is zero
> is also not satisfactory, as it results in a high CPU burn busy loop
> massively slowing QEMU's functionality.
>
> The proper solution is to avoid tcp_chr_read being called at all
> unless the frontend is able to accept more data. This will be done
> in a followup commit.
>
> This reverts commit 1907f4d149c3589ade641423c6a33fd7598fa4d3.

Actually 462945cd22d2bcd233401ed3aa167d83a8e35b05 upstream.

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  chardev/char-socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 2c4dffc0e6..812d7aa38a 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
>          s->max_size <=3D 0) {
>          return TRUE;
>      }
> -    len =3D tcp_chr_read_poll(opaque);
> -    if (len > sizeof(buf)) {
> -        len =3D sizeof(buf);
> +    len =3D sizeof(buf);
> +    if (len > s->max_size) {
> +        len =3D s->max_size;
>      }
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
>      if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
> --
> 2.43.0
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58883C52D7D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 04:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdN3y-0002P7-R7; Mon, 12 Aug 2024 00:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sdN3u-0002Nz-P6
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 00:53:43 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sdN3l-0001da-0X
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 00:53:34 -0400
Received: by mail-vs1-xe41.google.com with SMTP id
 ada2fe7eead31-49297fca3c2so1311013137.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723438411; x=1724043211; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0h/W2x2q4ObXrJFBTA0aDSpIgn15x7M+Dby8P9r317g=;
 b=kJZzH65kIAKnFqmYAc6H5COcnIFwUSEWuCDgo0vqzKE/QK7euVH5CzaWGzqwSkvltB
 Y5eyaALV0a7AODG8tVr/y09LZKPzYsL+GZ6dCpLMGMnDHt+ijaiw7GTt/LZhjBzDv9QS
 iR2iG+fViFoHVHGcJzvOm4oXs+iIZrqByTmQH6VPi7g80KdLa/HjmRHjWKJiuo9nW4Ng
 bHOUxu5Nsnu8iT5GN3dMw+KOVgNwF88z5GrKS9qzYl7v0W2wOrAkt5nmejwce5Y6TIZn
 +O741IbjcMqTK4rvW8qBHL6q8Dyn0MfvLn3CMCMC/T+oDDrPOtpZW71L95b9LDot52Ys
 vjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723438411; x=1724043211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0h/W2x2q4ObXrJFBTA0aDSpIgn15x7M+Dby8P9r317g=;
 b=Ti9zhcjlHqBbXnMxn1zjZiTTCjZ5ikthM5SxGqqaF9VwjnZoRt51rVgeoAON5MTGRp
 +NsPePpat9Bn9fuFAGHln2UdHyM8Oy1FZQ/qpNjBRYzMBJguwSflgAUabIhOCu+EkLsU
 563cfogi8E+fz1D1mEYbQI2+QnThWSnsuMzCXxaY+ZBFhe0b4pmxJXXp03zamNYvAKd3
 mvQhDYfVskyp0jXxUL3zLd4zbrI4sT+rjff7kv/7Izem4WexiDepnCD6uL6nrAbhxaou
 3EEfgLEnxcAYz/ulwXIy+lvHb/YvINXPTbysiZaJPckDYFa6vmKYUNu/Z2L8+IgOv4ne
 NIBQ==
X-Gm-Message-State: AOJu0Yy6LQ2w+hiM0KmNGUhkMaGrOOEgyXAK36wDRWXoqd5LzrZavvIg
 LtjO9sVYkGyW6qribmA3uW8RKz3Swuqe/opl/dR+bkEtzUxg7fAj+ob9zFwj7hy69xzc52Kx1fh
 TsKFIrUwz7lCeb8nHQhUnzu2PRtW6om7bOGE=
X-Google-Smtp-Source: AGHT+IFTb+PW4HCk38inADegYH+gZT12powtgCN4oejmIC0OrtIzlDXMkdkRsK0SR1cv3kBRoOU0H+Np+BJeSYeU23U=
X-Received: by 2002:a05:6102:4422:b0:495:6b7f:1eb0 with SMTP id
 ada2fe7eead31-495d8404016mr10780133137.8.1723438411121; Sun, 11 Aug 2024
 21:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240804154859.28342-1-luzhixing12345@gmail.com>
In-Reply-To: <20240804154859.28342-1-luzhixing12345@gmail.com>
From: =?UTF-8?B?6ZmG55+l6KGM?= <luzhixing12345@gmail.com>
Date: Mon, 12 Aug 2024 12:53:19 +0800
Message-ID: <CAKQy51AyXGb+8Qi6J-6r4gj-USWeAm1qwzurqq0vkFFB8EuLhA@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add NEED_REPLY flag
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000498cb1061f7546a6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=luzhixing12345@gmail.com; helo=mail-vs1-xe41.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000498cb1061f7546a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, can someone review this patch?
I find requests which call  vhost_user_get_u64 does not set NEED_REPLY flag

luzhixing12345 <luzhixing12345@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=884=
=E6=97=A5=E5=91=A8=E6=97=A5 23:50=E5=86=99=E9=81=93=EF=BC=9A

> Front-end message requests which need reply should set NEED_REPLY_MASK
> in flag, and response from slave need clear NEED_REPLY_MASK flag.
>
> ---
>  hw/virtio/vhost-user.c                    | 2 +-
>  subprojects/libvhost-user/libvhost-user.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..edf2271e0a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev=
,
> int request, uint64_t *u64)
>      int ret;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D request,
> -        .hdr.flags =3D VHOST_USER_VERSION,
> +        .hdr.flags =3D VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>      };
>
>      if (vhost_user_per_device_request(request) && dev->vq_index !=3D 0) =
{
> diff --git a/subprojects/libvhost-user/libvhost-user.c
> b/subprojects/libvhost-user/libvhost-user.c
> index 9c630c2170..40f665bd7f 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg
> *vmsg)
>  {
>      /* Set the version in the flags when sending the reply */
>      vmsg->flags &=3D ~VHOST_USER_VERSION_MASK;
> +    vmsg->flags &=3D ~VHOST_USER_NEED_REPLY_MASK;
>      vmsg->flags |=3D VHOST_USER_VERSION;
>      vmsg->flags |=3D VHOST_USER_REPLY_MASK;
>
> --
> 2.34.1
>
>

--000000000000498cb1061f7546a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, can someone review this patch?<br>I find requests whic=
h call=C2=A0

vhost_user_get_u64 does not set NEED_REPLY flag</div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">luzhixing12345 &lt;<a href=
=3D"mailto:luzhixing12345@gmail.com">luzhixing12345@gmail.com</a>&gt; =E4=
=BA=8E2024=E5=B9=B48=E6=9C=884=E6=97=A5=E5=91=A8=E6=97=A5 23:50=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Front-end message requests which need reply should set NEED_REPLY_MASK<br>
in flag, and response from slave need clear NEED_REPLY_MASK flag.<br>
<br>
---<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0subprojects/libvhost-user/libvhost-user.c | 1 +<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
index 00561daa06..edf2271e0a 100644<br>
--- a/hw/virtio/vhost-user.c<br>
+++ b/hw/virtio/vhost-user.c<br>
@@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev, =
int request, uint64_t *u64)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0VhostUserMsg msg =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.hdr.request =3D request,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hdr.flags =3D VHOST_USER_VERSION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hdr.flags =3D VHOST_USER_VERSION | VHOST_USER=
_NEED_REPLY_MASK,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vhost_user_per_device_request(request) &amp;&amp; d=
ev-&gt;vq_index !=3D 0) {<br>
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvho=
st-user/libvhost-user.c<br>
index 9c630c2170..40f665bd7f 100644<br>
--- a/subprojects/libvhost-user/libvhost-user.c<br>
+++ b/subprojects/libvhost-user/libvhost-user.c<br>
@@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vm=
sg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Set the version in the flags when sending the reply =
*/<br>
=C2=A0 =C2=A0 =C2=A0vmsg-&gt;flags &amp;=3D ~VHOST_USER_VERSION_MASK;<br>
+=C2=A0 =C2=A0 vmsg-&gt;flags &amp;=3D ~VHOST_USER_NEED_REPLY_MASK;<br>
=C2=A0 =C2=A0 =C2=A0vmsg-&gt;flags |=3D VHOST_USER_VERSION;<br>
=C2=A0 =C2=A0 =C2=A0vmsg-&gt;flags |=3D VHOST_USER_REPLY_MASK;<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000498cb1061f7546a6--


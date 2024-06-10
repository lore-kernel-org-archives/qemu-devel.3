Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD98C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 07:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGZhe-0006v5-27; Mon, 10 Jun 2024 03:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sGZhb-0006u8-Fe
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 03:44:27 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sGZhZ-0002aO-PA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 03:44:27 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4405e343dd8so7003181cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718005464; x=1718610264; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bioTmJR5ImMvBKpLJY3UUtW0cfJyvq8k7lwwj4ITz54=;
 b=nevnjT4zeT0EXZkgXjuQU1Su7vBHDk+jcu/ZKOsmWpdZQf/k5O+zngg6b8+p+AYKNa
 lsn9TBNv+FHNkhd0njswCLtjucxWHdcRQu7zCox/maUSNQcYQyLKgLsls9M/xUcHHZH4
 5CuZm4HRRRtQa2CNcDCAGqS8yrHFkUkfn6y2XrcQIGTHwCcUBmG02Ur9B9HHoOzl52bF
 Ynr/81RIdF2Hm1s/EXvzPfoSpLE/8em5XLPD9V6G2SXidcFvw2J35NK00gKP8BcUsN+e
 p+Y6H6HoPcjaMiJweaAWWmNxDf7r5bkDlLg8hPDo5uZLGcwqklmqkZ5ZWywVIaAwEYBb
 SLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718005464; x=1718610264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bioTmJR5ImMvBKpLJY3UUtW0cfJyvq8k7lwwj4ITz54=;
 b=fjWMuppRb6FOF0a+QifTOv5spwpOTN8k41iZ7VHD9cWPq/3pdfnjjReldlQH6GG/EM
 aWhWmOq8ShG9L99p8cpIB/pevvtCfIJ+sgV3EZsD++1qfAXFZy1QyC3h/4bN5BYpTdOz
 YJetnA2aEV0GoX23gojrFlVQRirMc5d8W00+YwKZ08q/4F3zOQjY3NpHLr6wpUFa+VTZ
 m0K43pNgNYKqHLw6gGb8Za/sMcXu5Kt1miN2mLRtSHPYqMPnun2Kc+SDNhkuv6jd2Bo2
 EDxdHjwJ74FFJ22TMISzpYBE+j47Yxkkb99QrM65Cn2hn4wvdT/0TyP8jCtaF+F4ROfz
 izLQ==
X-Gm-Message-State: AOJu0YwgMs4Pcw8k2DrnkddJk45xtuuWzCVxD1Z+BCU2S6CEJn+4USie
 vWS8tjNUOKjYzCKErCMH1ampLmigKTthFyTI8Z+d/4AmSzke03FSslgd7TJZB9Q27bOWx+Z7spW
 11kl/YHD0SQRN88xgronoJH6+p84=
X-Google-Smtp-Source: AGHT+IHyEq3cKyGJ79XLccragJsewImEP1oQekiB8IpisSn6WTCw/CNjL9ON0psbyhpUDGnwXDvsgWFF4Kg4v0Vw0y0=
X-Received: by 2002:a05:622a:178d:b0:441:785:a90b with SMTP id
 d75a77b69052e-4410785a9bcmr9147641cf.1.1718005463895; Mon, 10 Jun 2024
 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
 <20240605152832.11618-2-weifeng.liu.z@gmail.com>
In-Reply-To: <20240605152832.11618-2-weifeng.liu.z@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jun 2024 11:44:12 +0400
Message-ID: <CAJ+F1C+oVSeAGRvbE3pbgyj66JRf0vDbcd9AbRTYZk4+xpuu_g@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio-gpu: rutabaga: Properly set stride when
 copying resources
To: Weifeng Liu <weifeng.liu.z@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 Huang Rui <ray.huang@amd.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: multipart/alternative; boundary="00000000000065d6f3061a8451b7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000065d6f3061a8451b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 5, 2024 at 7:30=E2=80=AFPM Weifeng Liu <weifeng.liu.z@gmail.com=
> wrote:

> The stride is not correctly assigned when copying pixel data, causing
> images being displayed incomplete when using 2d component of rutabaga.
>
> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c
> b/hw/display/virtio-gpu-rutabaga.c
> index 17bf701a21..2ba6869606 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -53,6 +53,7 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct
> virtio_gpu_scanout *s,
>      transfer.z =3D 0;
>      transfer.w =3D res->width;
>      transfer.h =3D res->height;
> +    transfer.stride =3D res->width * 4;
>

ok, stride defined by QEMUCursor layout


>      transfer.d =3D 1;
>
>      transfer_iovec.iov_base =3D s->current_cursor->data;
> @@ -273,6 +274,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct
> virtio_gpu_ctrl_command *cmd)
>      transfer.z =3D 0;
>      transfer.w =3D res->width;
>      transfer.h =3D res->height;
> +    transfer.stride =3D pixman_image_get_stride(res->image);
>      transfer.d =3D 1;
>

ok (destination image stride)


>      transfer_iovec.iov_base =3D pixman_image_get_data(res->image);
> @@ -382,6 +384,7 @@ rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
>      transfer.z =3D 0;
>      transfer.w =3D t2d.r.width;
>      transfer.h =3D t2d.r.height;
> +    transfer.stride =3D t2d.r.width * 4;
>

here however, it's unclear to me what the stride could be, I think it could
depend on resource format (virgl doesn't set stride either).

Gurchetan?



>      transfer.d =3D 1;
>
>      result =3D rutabaga_resource_transfer_write(vr->rutabaga, 0,
> t2d.resource_id,
> --
> 2.45.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000065d6f3061a8451b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 7:30=E2=80=
=AFPM Weifeng Liu &lt;<a href=3D"mailto:weifeng.liu.z@gmail.com">weifeng.li=
u.z@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">The stride is not correctly assigned when copying pixel data, =
causing<br>
images being displayed incomplete when using 2d component of rutabaga.<br>
<br>
Signed-off-by: Weifeng Liu &lt;<a href=3D"mailto:weifeng.liu.z@gmail.com" t=
arget=3D"_blank">weifeng.liu.z@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-rutabaga.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutab=
aga.c<br>
index 17bf701a21..2ba6869606 100644<br>
--- a/hw/display/virtio-gpu-rutabaga.c<br>
+++ b/hw/display/virtio-gpu-rutabaga.c<br>
@@ -53,6 +53,7 @@ virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct vi=
rtio_gpu_scanout *s,<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D res-&gt;width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D res-&gt;width * 4;<br></blockquote><div>=
<br></div><div>ok, stride defined by QEMUCursor layout<br></div><div>=C2=A0=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0transfer_iovec.iov_base =3D s-&gt;current_cursor-&gt;da=
ta;<br>
@@ -273,6 +274,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio=
_gpu_ctrl_command *cmd)<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D res-&gt;width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D res-&gt;height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D pixman_image_get_stride(res-&gt;image);<=
br>
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br></blockquote><div><br></div><div>o=
k (destination image stride)<br></div><div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0transfer_iovec.iov_base =3D pixman_image_get_data(res-&=
gt;image);<br>
@@ -382,6 +384,7 @@ rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0transfer.z =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0transfer.w =3D t2d.r.width;<br>
=C2=A0 =C2=A0 =C2=A0transfer.h =3D t2d.r.height;<br>
+=C2=A0 =C2=A0 transfer.stride =3D t2d.r.width * 4;<br></blockquote><div><b=
r></div><div>here however, it&#39;s unclear to me what the stride could be,=
 I think it could depend on resource format (virgl doesn&#39;t set stride e=
ither).</div><div><br></div><div>Gurchetan?<br></div><div><br></div><div>=
=C2=A0 <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0transfer.d =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0result =3D rutabaga_resource_transfer_write(vr-&gt;ruta=
baga, 0, t2d.resource_id,<br>
-- <br>
2.45.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000065d6f3061a8451b7--


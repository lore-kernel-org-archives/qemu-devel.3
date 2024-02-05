Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917B5C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvkZ-0005sD-KA; Mon, 05 Feb 2024 04:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rWvkX-0005ry-Iv
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rWvkT-0008Ih-Eq
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707127124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UV5hHSakWv+rtuHOvv5Zcyn8okUkefKpkqhHokMj8eY=;
 b=N8wt90VlYG7YzxmGyGrzSpP8TIFebVS6cZrPqHBoIDYzwH5S0cvR01pB9/UvDdVe30f8YZ
 PV01Y+0VPyS67BMq3d5NJrOPgUnQarXhj6S85Qwqso9dNGJY5Ssi7IUBL/UIXMClXhX27M
 x0ulUhfDOMVnkXDveSfrEoTF4EfSd20=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Rls5mdfmOP-Fx882oIDLzw-1; Mon, 05 Feb 2024 04:58:42 -0500
X-MC-Unique: Rls5mdfmOP-Fx882oIDLzw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e0382c0448so1334970b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 01:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707127121; x=1707731921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UV5hHSakWv+rtuHOvv5Zcyn8okUkefKpkqhHokMj8eY=;
 b=oA5eBQEs0CShqJQn79as0yJ1ej1fqmucaFdzLD7HdJ6rvpcGQr2cmrRvtS2NfFPXHg
 ADR9OzK30NcpRivcQZPng6soqNlB/V8ousQ00hV5MAQef2OEekLosQdZz6DgZAYgKiZx
 sW4mXS4+6kYJ01Qs+hL6La/ZWtO6iyZqfrE8WUUYjH1+RcnJtKcVhFAeY7No1keYLXwA
 lXH+2Mwgu76HZ4nIBjzSI6TmOIHtCAYhSUMztVr81+3vMLu2xjZIB5GwQ/psK8JDLF9S
 E2ZV3slLKNhQoXOCajvJw1ch/xuyXf42CjOKqAsVcfH/skahg/2DCU4NGOZWTEl3HjAN
 UP6Q==
X-Gm-Message-State: AOJu0YwL10TgHQb+3KV9QNAGKfJnTvXI321aBjxVJHyytPldmnnFlxKM
 kpA1kLjXVfIZxOqt/YFRIfeNGFX/eM3vQw+IZ4sfIKBGqQbnQEnHMspXTILtLW6xlmoZtENrsi0
 8s9y0O+sPsrNMZjlfIVchcqhWTLWeUFpsEzr51EtRUSMGfXZXrLo7f1o8j8C8Kp46O7Xdbbmoe9
 NPU/JEbp2+7r9zHA2Xxs0qgFW97j7Am9VzBgQ=
X-Received: by 2002:a05:6a20:c526:b0:19c:74d1:b314 with SMTP id
 gm38-20020a056a20c52600b0019c74d1b314mr10686705pzb.17.1707127121491; 
 Mon, 05 Feb 2024 01:58:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBP5C449axAAAWRdG3CePLpBokWQjf2wllyArv/HYft55gg4w4llPPqR7ww5x33qd6o0rCrLxx8c/NWWGoDmg=
X-Received: by 2002:a05:6a20:c526:b0:19c:74d1:b314 with SMTP id
 gm38-20020a056a20c52600b0019c74d1b314mr10686695pzb.17.1707127121173; Mon, 05
 Feb 2024 01:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20240109125614.220293-1-aesteve@redhat.com>
In-Reply-To: <20240109125614.220293-1-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 5 Feb 2024 10:58:29 +0100
Message-ID: <CADSE00+9aokGPszqqr_EMWuR_KZ_fVR-aQSuW3JDDRrOB-6cHw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Virtio dmabuf improvements
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 marcandre.lureau@gmail.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a4f04b06109f81e5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000a4f04b06109f81e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly reminder & bump

Is this series waiting to be picked up, or is there anything left to do?

BR,
Albert




On Tue, Jan 9, 2024 at 1:56=E2=80=AFPM Albert Esteve <aesteve@redhat.com> w=
rote:

> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014615.html
> v2 -> v3
>   - Documented the new owner check for shared object removal
>   - Updated test function names error in the last patch
>
> Various improvements for the virtio-dmabuf module.
> This patch includes:
>
> - Check for ownership before allowing a vhost device
>   to remove an object from the table.
> - Properly cleanup shared resources if a vhost device
>   object gets cleaned up.
> - Rename virtio dmabuf functions to `virtio_dmabuf_*`
>
> Albert Esteve (3):
>   hw/virtio: check owner for removing objects
>   hw/virtio: cleanup shared resources
>   hw/virtio: rename virtio dmabuf API
>
>  docs/interop/vhost-user.rst       |  4 +-
>  hw/display/virtio-dmabuf.c        | 36 ++++++++++++---
>  hw/virtio/vhost-user.c            | 31 ++++++++++---
>  hw/virtio/vhost.c                 |  3 ++
>  include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------
>  tests/unit/test-virtio-dmabuf.c   | 77 ++++++++++++++++++++++---------
>  6 files changed, 141 insertions(+), 53 deletions(-)
>
> --
> 2.43.0
>
>

--000000000000a4f04b06109f81e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Friendly reminder &amp; bump<div><br></div><div>Is this se=
ries waiting to be picked up, or is there anything left=C2=A0to do?</div><d=
iv><br></div><div>BR,</div><div>Albert<br clear=3D"all"><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><p style=3D"color:rgb(0,0,0);font-family:RedHatText,sans-serif;font-w=
eight:bold;margin:0px;padding:0px;font-size:14px"><br></p></div></div></div=
><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, Jan 9, 2024 at 1:56=E2=80=AFPM Albert Esteve &lt;<a href=
=3D"mailto:aesteve@redhat.com">aesteve@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">v1: <a href=3D"https://www=
.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html" rel=3D"noreferrer"=
 target=3D"_blank">https://www.mail-archive.com/qemu-devel@nongnu.org/msg10=
05257.html</a><br>
v2: <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg101461=
5.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/q=
emu-devel@nongnu.org/msg1014615.html</a><br>
v2 -&gt; v3<br>
=C2=A0 - Documented the new owner check for shared object removal<br>
=C2=A0 - Updated test function names error in the last patch<br>
<br>
Various improvements for the virtio-dmabuf module.<br>
This patch includes:<br>
<br>
- Check for ownership before allowing a vhost device<br>
=C2=A0 to remove an object from the table.<br>
- Properly cleanup shared resources if a vhost device<br>
=C2=A0 object gets cleaned up.<br>
- Rename virtio dmabuf functions to `virtio_dmabuf_*`<br>
<br>
Albert Esteve (3):<br>
=C2=A0 hw/virtio: check owner for removing objects<br>
=C2=A0 hw/virtio: cleanup shared resources<br>
=C2=A0 hw/virtio: rename virtio dmabuf API<br>
<br>
=C2=A0docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br=
>
=C2=A0hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 ++++++++++=
++---<br>
=C2=A0hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 31 =
++++++++++---<br>
=C2=A0hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 3 ++<br>
=C2=A0include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------<br>
=C2=A0tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 77 ++++++++++++++++++++=
++---------<br>
=C2=A06 files changed, 141 insertions(+), 53 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000a4f04b06109f81e5--



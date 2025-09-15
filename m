Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4A1CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy5M4-00019e-TH; Mon, 15 Sep 2025 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1uy5M1-000199-Qm
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1uy5Lq-0006Z2-K9
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 05:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757927894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nupJgd1x0JdbOIQmlL4i3PZeQdIjVeKg1giAHactmtc=;
 b=N238lUs9GcRHH89al7E162aAFj/tLgb8tJWm83+VYe24Rh/vyv3oaUF6vgp884IkA30WOP
 0eZfNAksR97aE+QFkK0gaQfrn5cYXgmwCknqcxCGq5lrTIo2Q/Uuq8sIMcsUFVNA5ISZ5G
 ydtoVY90AD9TROZZegqkqtuagFHhGI8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-U9j29XgzPkuIcYGIathpyg-1; Mon, 15 Sep 2025 05:16:41 -0400
X-MC-Unique: U9j29XgzPkuIcYGIathpyg-1
X-Mimecast-MFC-AGG-ID: U9j29XgzPkuIcYGIathpyg_1757927801
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-42404bb4284so10260485ab.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 02:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757927801; x=1758532601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nupJgd1x0JdbOIQmlL4i3PZeQdIjVeKg1giAHactmtc=;
 b=uolSITA87+pgwthQDlLa9i0YhbS+cQahdVI/jOm+HSrk5poWTxPoVKTrJAihLafVvH
 S3ds19EAoLbjwjidA9wbAMxUrBPKmRsv5GAKdboBlmdwq1/AlI3dZ18acz5Z1pTy5RcU
 X2Uvy+Fi0wUHd729z+L6znJ+zKXKhoB3B2F/ZDRs6Dd3GAxnx2v7efxTqZi9YyDKfXRL
 Wg0Y8OnJelMq38PExNuTkVksP+wGMrrs5mnhQG6Pf4cpmbLsYiA3RhTk04T6Qi3UtRxU
 NzZCOMLAR23xfsn1SOR1jOtxlFs+oC5vD7waL4uiM3c6PXDbzNb+jbdW4MuTX9o/mj9t
 Nsgw==
X-Gm-Message-State: AOJu0YxDVlVFSpy6fLZqMEYqEbDFDdTKj58Jo66hkVFhcllTLbEs8Ljo
 SpKNU8bSCkTUf2aBusgRXRPrVm/SmK28c6wyzOx2N+yzQ7gWkXLxH9TwFF3IrR6eGZZLfpXQcH5
 YdbksPdCYoWDEnBxcu9Ximqn/YgTmdlgnEv2+4yes4qieT4kQ9MbyqKHm3671YeqDIZNJzVwVmJ
 l/jLqpmBAQYzwIK+OuSvmXhb1uzzEmbTQ=
X-Gm-Gg: ASbGncvR/A2s8pzyHMh/moCdEqbnrQOp8bzAh89CJTfeuX1CfAUoTsyBJM0rrh+FShG
 BABhBa2mS4MN9CiSo9khBieno+xYA0fIQOkv87l8a1vJ//cRRYHkZj1NrLjLBgVFB5tnD98mC8m
 18DQj0wCCJlJUi0kLgQ9/j8xI=
X-Received: by 2002:a05:6e02:1aa2:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-420a4268714mr126361295ab.27.1757927800709; 
 Mon, 15 Sep 2025 02:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvICMap2pd6a2bo0Q8XXJWmbNVvEW9h4CGRObhG3YoPPDfZmt8IvfMtqve5C9wrfhI/dBpmSs3nS61qx3MkSQ=
X-Received: by 2002:a05:6e02:1aa2:b0:3f2:a771:9fb3 with SMTP id
 e9e14a558f8ab-420a4268714mr126361185ab.27.1757927800392; Mon, 15 Sep 2025
 02:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241107180309.1713601-1-dbassey@redhat.com>
 <v5p6ztswg7wrooyg4fnenbvbnwf2svm6j6jg7dm4pavwocft3x@ub5mgg5e3dyo>
In-Reply-To: <v5p6ztswg7wrooyg4fnenbvbnwf2svm6j6jg7dm4pavwocft3x@ub5mgg5e3dyo>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Mon, 15 Sep 2025 11:16:29 +0200
X-Gm-Features: AS18NWAmMseFDEogem8DABUVSQfJjEN83Nogv4YKDMxUdp4p9LFQaMmo6dwXwSg
Message-ID: <CACzuRyy5urdAzPqRQ__VOZ6R-43LKLFzqj1w_+hsZYs+ovHxtg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, aesteve@redhat.com, marcandre.lureau@redhat.com, 
 Michael Tsirkin <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000157086063ed37659"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000157086063ed37659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Albert and Michael,

seems this patch fell through the cracks, It was posted but never picked
up. Could you help push it? thanks!

BR,
Dorinda.

On Fri, Nov 8, 2024 at 10:29=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com>
wrote:

> On Thu, Nov 07, 2024 at 07:00:31PM +0100, Dorinda Bassey wrote:
> >In `virtio_add_resource` function, the UUID used as a key for
> >`g_hash_table_insert` was temporary, which could lead to
> >invalid lookups when accessed later. This patch ensures that
> >the UUID remains valid by duplicating it into a newly allocated
> >memory space. The value is then inserted into the hash table
> >with this persistent UUID key to ensure that the key stored in
> >the hash table remains valid as long as the hash table entry
> >exists.
> >
> >Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
> >
> >Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> >---
> > hw/display/virtio-dmabuf.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> >
> >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> >index 3dba4577ca7..5e0395be77c 100644
> >--- a/hw/display/virtio-dmabuf.c
> >+++ b/hw/display/virtio-dmabuf.c
> >@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid,
> VirtioSharedObject *value)
> >     if (resource_uuids =3D=3D NULL) {
> >         resource_uuids =3D g_hash_table_new_full(qemu_uuid_hash,
> >                                                uuid_equal_func,
> >-                                               NULL,
> >+                                               g_free,
> >                                                g_free);
> >     }
> >     if (g_hash_table_lookup(resource_uuids, uuid) =3D=3D NULL) {
> >-        g_hash_table_insert(resource_uuids, uuid, value);
> >+        g_hash_table_insert(resource_uuids,
> >+                            g_memdup2(uuid, sizeof(*uuid)),
> >+                            value);
> >     } else {
> >         result =3D false;
> >     }
> >--
> >2.47.0
> >
>
>

--000000000000157086063ed37659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Albert and Michael,</div><div><br></div><div>seems=
 this patch fell through the cracks, It was posted but never picked up. Cou=
ld you help push it? thanks!</div><div><br></div><div>BR,</div><div>Dorinda=
.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Nov 8, 2024 at 10:29=E2=80=AFAM Stefa=
no Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.com">sgarzare@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Thu, Nov 07, 2024 at 07:00:31PM +0100, Dorinda Bassey wrote:<br>
&gt;In `virtio_add_resource` function, the UUID used as a key for<br>
&gt;`g_hash_table_insert` was temporary, which could lead to<br>
&gt;invalid lookups when accessed later. This patch ensures that<br>
&gt;the UUID remains valid by duplicating it into a newly allocated<br>
&gt;memory space. The value is then inserted into the hash table<br>
&gt;with this persistent UUID key to ensure that the key stored in<br>
&gt;the hash table remains valid as long as the hash table entry<br>
&gt;exists.<br>
&gt;<br>
&gt;Fixes: faefdba847 (&quot;hw/display: introduce virtio-dmabuf&quot;)<br>
&gt;<br>
&gt;Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com"=
 target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt;---<br>
&gt; hw/display/virtio-dmabuf.c | 6 ++++--<br>
&gt; 1 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
Reviewed-by: Stefano Garzarella &lt;<a href=3D"mailto:sgarzare@redhat.com" =
target=3D"_blank">sgarzare@redhat.com</a>&gt;<br>
<br>
&gt;<br>
&gt;diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br=
>
&gt;index 3dba4577ca7..5e0395be77c 100644<br>
&gt;--- a/hw/display/virtio-dmabuf.c<br>
&gt;+++ b/hw/display/virtio-dmabuf.c<br>
&gt;@@ -35,11 +35,13 @@ static bool virtio_add_resource(QemuUUID *uuid, Vir=
tioSharedObject *value)<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (resource_uuids =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_uuids =3D g_hash_table_new_f=
ull(qemu_uuid_hash,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uuid_equal_func,<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0g_free,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 g_free);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (g_hash_table_lookup(resource_uuids, uuid) =3D=
=3D NULL) {<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids, uuid, =
value);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_hash_table_insert(resource_uuids,<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_memdup2(uuid, sizeof(*uuid)),<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;-- <br>
&gt;2.47.0<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000157086063ed37659--



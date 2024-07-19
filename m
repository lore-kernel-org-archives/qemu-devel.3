Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FEAC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUjKr-0001RK-Mn; Fri, 19 Jul 2024 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUjKj-0001QI-MZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUjKg-0005R0-IV
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721379074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBBvtq2bNJL/D/HJgGmKF05OiPvc5WAN++pieVKvg+Y=;
 b=gS3g8o3wqYbx4cqUstq00v/bhkVpxkPr0rML5m7ntsPlja5RYiS/jR6J4BoCymeBVDaZon
 jF3iTnWewMnd/5yjAmrvKE+CP/CJh6mUQV8wjmKG7WROH3xktJ5jib5UGtI9ThuOXQqz3H
 rdUNDw97YDy5hJ0xyv++/Srkp05V09A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-WMkmMqW0PIiGaxQqQqm58A-1; Fri, 19 Jul 2024 04:51:11 -0400
X-MC-Unique: WMkmMqW0PIiGaxQqQqm58A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-664bc570740so28413737b3.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 01:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721379071; x=1721983871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBBvtq2bNJL/D/HJgGmKF05OiPvc5WAN++pieVKvg+Y=;
 b=P6hZu9Dcphu61Wn8O7y0gLgAGIIhJm5kwH/FiaVoc1mGZPyk9PTJo/Be8Bf6JFo4Gc
 LupDESZQjuZCC/ww8dljWuYhmA8gWhrV+JtbRxW7JhpbUDeYxqliMjhjtGo0jYMB9ZFs
 mQTZ04GBtFExWxs7y7QJ3XXGjDwmUrkD4HAV1U5nS8+0jigZySuqn0hXkgG4vFSar1Vi
 WatGIbm736JhLmTA2Zi9ucekqYS3xABp5e35HPb4CoBLFj6yyx1r8dv/jdkJBLkeheV7
 Tuh3rMYmLW+9Dnazi3i+9vUaU6F6D2ilcEjKbp+avwENIeJ7QJ54an6P0WyQ+zVGlO/C
 K50Q==
X-Gm-Message-State: AOJu0YzYj7RJUR0SP7Bxy3DQVjw432Ub0LqxlxBWvC4JNueF7DMH/Inj
 S5EHbB/Czk7714Vz3ZcVp2RxHAnD3wriuVGXYj0f4fzEVCt/lRpjB937d5848mPWsO3KwIRsmUi
 5OaWa4p4IvvGC/JzHJPptHQy31e8v75W4ElfQa5qgSHsk8afw5JXxqEJClEGOht+X0K0j5NPqK/
 gRU5czQLifFIbndwwQpydv0Bqsk0Y=
X-Received: by 2002:a81:9e0d:0:b0:631:3cea:4f02 with SMTP id
 00721157ae682-66609d6a777mr40098297b3.17.1721379071099; 
 Fri, 19 Jul 2024 01:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA5SzbWCLw+WGE166BajXZ+qrH0jEcWgJBdMdl8+YZM0ltdvCdy8NISpIhzp9xtSB3839gfphlWUut1tABJLw=
X-Received: by 2002:a81:9e0d:0:b0:631:3cea:4f02 with SMTP id
 00721157ae682-66609d6a777mr40098257b3.17.1721379070813; Fri, 19 Jul 2024
 01:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240718140407.444160-1-t.lamprecht@proxmox.com>
In-Reply-To: <20240718140407.444160-1-t.lamprecht@proxmox.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 11:51:00 +0300
Message-ID: <CAPMcbCrcSBNN7fiP7ga0kZLbB+0Ucb9H5Q7Fd1yx0oM5U29mFg@mail.gmail.com>
Subject: Re: [PATCH] guest-agent: document allow-rpcs in config file section
To: Thomas Lamprecht <t.lamprecht@proxmox.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000a4165061d95cc00"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000000a4165061d95cc00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jul 18, 2024 at 5:05=E2=80=AFPM Thomas Lamprecht <t.lamprecht@proxm=
ox.com>
wrote:

> While the `allow-rpcs` option is documented in the CLI options
> section, it was missing in the section about the configuration file
> syntax.
>
> And while it's mentioned that "the list of keys follows the command line
> options", having `block-rpcs` there but not `allow-rpcs` seems like
> being a potential source of confusion; and as it's cheap to add let's
> just do so.
>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> ---
>  docs/interop/qemu-ga.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 72fb75a6f5..dd4245ece8 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -131,6 +131,7 @@ fsfreeze-hook  string
>  statedir       string
>  verbose        boolean
>  block-rpcs     string list
> +allow-rpcs     string list
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
>  See also
> --
> 2.39.2
>
>
>
>

--0000000000000a4165061d95cc00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 18, 2024 at 5:05=E2=
=80=AFPM Thomas Lamprecht &lt;<a href=3D"mailto:t.lamprecht@proxmox.com">t.=
lamprecht@proxmox.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">While the `allow-rpcs` option is documented in the CLI=
 options<br>
section, it was missing in the section about the configuration file<br>
syntax.<br>
<br>
And while it&#39;s mentioned that &quot;the list of keys follows the comman=
d line<br>
options&quot;, having `block-rpcs` there but not `allow-rpcs` seems like<br=
>
being a potential source of confusion; and as it&#39;s cheap to add let&#39=
;s<br>
just do so.<br>
<br>
Signed-off-by: Thomas Lamprecht &lt;<a href=3D"mailto:t.lamprecht@proxmox.c=
om" target=3D"_blank">t.lamprecht@proxmox.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qemu-ga.rst | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index 72fb75a6f5..dd4245ece8 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -131,6 +131,7 @@ fsfreeze-hook=C2=A0 string<br>
=C2=A0statedir=C2=A0 =C2=A0 =C2=A0 =C2=A0string<br>
=C2=A0verbose=C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean<br>
=C2=A0block-rpcs=C2=A0 =C2=A0 =C2=A0string list<br>
+allow-rpcs=C2=A0 =C2=A0 =C2=A0string list<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
<br>
=C2=A0See also<br>
-- <br>
2.39.2<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000000a4165061d95cc00--



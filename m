Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D021CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraQM-0003Ek-QQ; Tue, 02 Apr 2024 05:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rraQK-0003E2-NQ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rraQ0-00075m-V6
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712050019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gnCUhixkIHzZcZ+u/7WnD86OdGTI43oJjXIdxKbIbg=;
 b=NxUxXZsV1QVeBESZna9v1QdgigOtT74KlHCkR+UIqH1IuGs3CuNWQYx6/F6W475mxL6PHW
 GbKjSUi6skI4J5ioVjVP9SXCiKlWn+OoqHOSZRuJfUcmvmgNIwPoT6835+y/NqYr9ttjM4
 NwGNgnUQBoHQP9S822/lUd22JCkjcgQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Ot0MNA2qMJGGpPeMAGXvFw-1; Tue, 02 Apr 2024 05:26:57 -0400
X-MC-Unique: Ot0MNA2qMJGGpPeMAGXvFw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d4a0c99d66so33284441fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712050015; x=1712654815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gnCUhixkIHzZcZ+u/7WnD86OdGTI43oJjXIdxKbIbg=;
 b=AZ5/Gq8bx6ZVjRe4WFdx6N+LhScwkL4KS17PwjLG7Ssb0t9OXRy5O3UodlkZs2RNsx
 sbl1uuTybOeHI81mBlDKW29T6/M7WqIf/Plc0uiNpr/ihTEPq8avFu0c20hfjcUW3Ob4
 uCaDIrAnIdXoKRNNJ/aqJ3KAXFfNeGX9C6wYjduXWTgZWHbNsLBt7brzZ664AIz/U87S
 7Y++BQX19qeNMNr99vvwh+L9NLLtBnN5ymQLL3E7wIesyJk0Bg5ruzfQcwsqNGK0ROzJ
 gZYkFZcMWgYdExU6yPoXBV9gb8kri5cjQh6oD34qBY8esxTrSTF7q+LSO9AZ5LuAxFId
 ly2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVkUJiheeONXUczr0OCXjtKlv9mPKEzolqpzURETx8J8v4VJofUEFNB7vY9JvWK6Dn2U9PngrIOrz3C+1IUB97YyOe8ts=
X-Gm-Message-State: AOJu0YxAh5B/aJ+3hcUycFCEpF58IHkIhco4gDaOkLsEUgwT21W5FnVg
 RVIxJn1DwmdwRSoDprgSCv0jJQI+iXjFttY9Y2aaZiqD5jT+gdQFgwChtUVPhgtc/Aap/6HlMTo
 lbKdleMp+dxTatkNdzfKnOHcRLAsHPJsgOmb2+s7/2hMygsBBzTSHtSYQRJPL8srbI070Ifoupl
 kfsw0CVGrhD63aPfsJ+upk+T2iQ8s=
X-Received: by 2002:a05:651c:168c:b0:2d6:ba96:b9a8 with SMTP id
 bd12-20020a05651c168c00b002d6ba96b9a8mr7047597ljb.27.1712050015676; 
 Tue, 02 Apr 2024 02:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHyhoy3b6z4cza/FDoimY2IsuXT5UAnpbivutt2HxGczD7APlIjv2EOEALIlf1BK8EAbdfHFHRBSJB4+thh0k=
X-Received: by 2002:a05:651c:168c:b0:2d6:ba96:b9a8 with SMTP id
 bd12-20020a05651c168c00b002d6ba96b9a8mr7047588ljb.27.1712050015307; Tue, 02
 Apr 2024 02:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240329153155.17840-1-aidan_leuck@selinc.com>
 <20240329153155.17840-2-aidan_leuck@selinc.com>
 <7eadc494-866f-4126-8f9d-5407a8003371@linaro.org>
In-Reply-To: <7eadc494-866f-4126-8f9d-5407a8003371@linaro.org>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 2 Apr 2024 12:26:44 +0300
Message-ID: <CAPMcbCpEhzN3+-nY=YKzMV31bTRUaU6cZTkk+Nzzud+uVM1J0Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] qga: Refactor common functions between POSIX and
 Windows implementation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000024f6061519b547"
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

--0000000000000024f6061519b547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 29/3/24 16:31, aidan_leuck@selinc.com wrote:
> > From: aidaleuc <aidan_leuck@selinc.com>
> >
>
> "In preparation of a Windows implementation, move the
>   non-POSIX specific code to commands-common-ssh."
>
> > Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
>
> As in v5
> (
> https://lore.kernel.org/qemu-devel/63600417-9187-4d0b-8bcc-db7e965ff008@l=
inaro.org/
> ):
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > ---
> >   qga/commands-common-ssh.c | 50 ++++++++++++++++++++++++++++++++++++++=
+
> >   qga/commands-common-ssh.h | 10 ++++++++
> >   qga/commands-posix-ssh.c  | 47 +-----------------------------------
> >   qga/meson.build           |  1 +
> >   4 files changed, 62 insertions(+), 46 deletions(-)
> >   create mode 100644 qga/commands-common-ssh.c
> >   create mode 100644 qga/commands-common-ssh.h
>
> Kostiantyn, if you take this patch, please amend the commit
> description and prefix the subject with 'qga: ' :)
>

I will do this.

Best Regards,
Konstantin Kostiuk.



> Thanks,
>
> Phil.
>
>

--0000000000000024f6061519b547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 2, 2024 at 12:23=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 29/3/24 16:31, <a href=3D"mailto:aidan_leuck@selinc.com" t=
arget=3D"_blank">aidan_leuck@selinc.com</a> wrote:<br>
&gt; From: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=3D=
"_blank">aidan_leuck@selinc.com</a>&gt;<br>
&gt; <br>
<br>
&quot;In preparation of a Windows implementation, move the<br>
=C2=A0 non-POSIX specific code to commands-common-ssh.&quot;<br>
<br>
&gt; Signed-off-by: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" =
target=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
<br>
As in v5 <br>
(<a href=3D"https://lore.kernel.org/qemu-devel/63600417-9187-4d0b-8bcc-db7e=
965ff008@linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.ker=
nel.org/qemu-devel/63600417-9187-4d0b-8bcc-db7e965ff008@linaro.org/</a>):<b=
r>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qga/commands-common-ssh.c | 50 +++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A0qga/commands-common-ssh.h | 10 ++++++++<br>
&gt;=C2=A0 =C2=A0qga/commands-posix-ssh.c=C2=A0 | 47 +---------------------=
--------------<br>
&gt;=C2=A0 =C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A04 files changed, 62 insertions(+), 46 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 qga/commands-common-ssh.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 qga/commands-common-ssh.h<br>
<br>
Kostiantyn, if you take this patch, please amend the commit<br>
description and prefix the subject with &#39;qga: &#39; :)<br></blockquote>=
<div><br></div><div>I will do this.<br><br clear=3D"all"><div><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div=
>Konstantin Kostiuk.</div></div></div></div><br><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div>

--0000000000000024f6061519b547--



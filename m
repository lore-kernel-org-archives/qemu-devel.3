Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21598C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 21:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trkeU-00024k-M4; Mon, 10 Mar 2025 17:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkeK-00022a-9J
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkeH-0000Op-Fi
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741642014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBgTnzq8CmGioyx12idZE9bJKysF8m1qDM2zwh1f3xw=;
 b=F9QvWnp107XIygmGygN8/p4+cY6NO6doe8plAKoWI+s9s30e3ncnKcHuyMupgWOwGJ8hcF
 seq9ySzU7KfzvKVRAqLGGRdak2ZRw6Iudz14X2hNmTfB4BL+e+nqfbe7Ro+CiX9TKe1YP1
 /d8BMKiZdajaZLM/9h+PQdWN/nmO8R0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-f9VQHStaNKuEHQFGlHKMzQ-1; Mon, 10 Mar 2025 17:26:50 -0400
X-MC-Unique: f9VQHStaNKuEHQFGlHKMzQ-1
X-Mimecast-MFC-AGG-ID: f9VQHStaNKuEHQFGlHKMzQ_1741642010
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff55176edcso8186790a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741642010; x=1742246810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBgTnzq8CmGioyx12idZE9bJKysF8m1qDM2zwh1f3xw=;
 b=bFiRE7e7FcTpIU+HyDVVwWdWQwEehS8V+dbtv2CFfSpsBXmMMc1scEE8Px38ERbQNb
 jeziHNPetUyOK325Vq1qPjwW8q6uFACJfwkI6uls9HRUpRl/tZLWHixAq92gU9+a7fbI
 ChDyA9znvZ9SkJKe5UAC1nXoKivqErkvWlk5Smphylahn4oU+fK9hx2FSICPIN+pJh2C
 7FHuXizM3cXNKR0wmrVigmlF0qdFU9AKwCMXxxy4AsQNXdYDIeBAV6WbzxM3C4HqvuUZ
 RJOEu6UFXLzSEm2YagilK+Wrrd8o3vSUriKj0HLqfMg3kypdJroLFr3d7/I/pdfYgMHL
 45Fg==
X-Gm-Message-State: AOJu0Yx0qkaKkmTBhGvuEXfMFEiyh0tbWFynVU6Qh88z9sLjr0onWpt6
 mXvDFCiBsSWqsaYe332vemq+X/2NN4d16YuQLTgPE7mG7g8IpetOCERImiHOpivJIs7KgD+c1Ry
 q9drDJ3IBGKsWMx6l82dIb6T+uLaQFQw8AilzmggiSNywbYmhcrVqMaUZzrOSJuQJ5AeVn33gPh
 +LA8ckHC4TMLArqNhDoW+DNO0MH4E=
X-Gm-Gg: ASbGnctdrKGCtMVFKFj5/rQzlZseQqc8lHO2Jsigpf5mmd88e2OthiksSbQkZLWERLH
 gFZWNrxYnhjbmPajNAkbzWRYARRjQmIp1CvwJNb3oq29TKdmlPwRKR1XIcNwEOYsIxrx1n3jlPy
 R/n1fEj71vjJKXI2pSVhoAyThH7Bd+
X-Received: by 2002:a17:90b:1a8c:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2ff7ce6f36emr21320182a91.1.1741642009800; 
 Mon, 10 Mar 2025 14:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMnPg+7AAsl263wOuzo26hBkcbShCI+aM0oVkhEqt+yUNeoAVLTx5evelWzPSjwwOw3d2nV9Md2HRKyMUj1Wc=
X-Received: by 2002:a17:90b:1a8c:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2ff7ce6f36emr21320166a91.1.1741642009566; Mon, 10 Mar 2025
 14:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-57-jsnow@redhat.com>
 <874j01ykdj.fsf@pond.sub.org>
In-Reply-To: <874j01ykdj.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:26:37 -0400
X-Gm-Features: AQ5f1JoZy3am3nWldbJApOnAbLf9wzs-ld84q_88S8NvN9jSeSO0cVvBToqMq4I
Message-ID: <CAFn=p-ZPw66UL9_veFSJ5yEi3K+AHdXsXv65r46k-reHGRx8mw@mail.gmail.com>
Subject: Re: [PATCH v2 56/62] docs/qapidoc: add intermediate output debugger
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004e7606063003a1f6"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--0000000000004e7606063003a1f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:17=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add debugging output for the qapidoc transmogrifier - setting DEBUG=3D1
> > will produce .ir files (one for each qapidoc directive) that write the
> > generated rst file to disk to allow for easy debugging and verification
> > of the generated document.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> You wrote you intend to advertise this debugging feature in the
> transmogrifier doc and/or extend the doc-writing section of the qapi
> code gen doc.  If you did this, pointer, please.  If not, no worries, it
> can be done at a later time.


Still working on the doc. For rc1.

--0000000000004e7606063003a1f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 5:17=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add debugging output for the qapidoc transmogrifier - setting DEBUG=3D=
1<br>
&gt; will produce .ir files (one for each qapidoc directive) that write the=
<br>
&gt; generated rst file to disk to allow for easy debugging and verificatio=
n<br>
&gt; of the generated document.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
You wrote you intend to advertise this debugging feature in the<br>
transmogrifier doc and/or extend the doc-writing section of the qapi<br>
code gen doc.=C2=A0 If you did this, pointer, please.=C2=A0 If not, no worr=
ies, it<br>
can be done at a later time.</blockquote><div><br></div><div>Still working =
on the doc. For rc1. <br></div></div></div>

--0000000000004e7606063003a1f6--



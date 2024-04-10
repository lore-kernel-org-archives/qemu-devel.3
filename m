Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D44CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVuS-0006h4-GM; Wed, 10 Apr 2024 07:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVuR-0006gl-Dg
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:14:31 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruVuP-0000su-RV
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:14:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso8773431a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712747668; x=1713352468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94RVQwcYAG4eFmMmGTmocKdyi2FDWMMAMoG0R8BdJRo=;
 b=REAXYuWjWoEFtU5FxhZeTrL8EIUTgFBE5PR30UwM0GsinO+YdLqkeyae3ToSur7OPI
 jZB5wHErABfIOyxKnLSzlMRwlEscARThdPYB0SmDXviKZ7WZjh5GZ3MiWXHrXeMb5sET
 gY5GcSB8lDQRdtJmz7/gWghR6rRv1ONjraIB2D9+ojRlqHTbVizssxFqtHY6VH2hyaEa
 2lqtELJEIpDSMdnVq4b7dc2YaAK0wMVKpdtD6Sc5G6Sl+AjqBdAXMoo1nLz+ypFV4jL9
 AN5qSBz4kVgTVUdIR/nfp8DO+o2DsVoyDVTBPr327cYQ4PUI9hlTP5+voFnTe0yOoine
 1ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747668; x=1713352468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94RVQwcYAG4eFmMmGTmocKdyi2FDWMMAMoG0R8BdJRo=;
 b=AxKENZmOP7/e1q8d/aOjqlvPNokQirM9m5KDxNbCJjhJB/WgH3DaU14NPFG9FEQwmN
 SlRfDPLSNupEMyt+OuDq/YIXn0gHMhybp3ZF/mFTL+GzzQGv62LObOW3FNiv5GDNDbZG
 HmkjKJcil0PojSKbYT7tv2NBpZPe6UQmECzFH7JbWprxAaSuGWETBoo7//JW/NXQgqMP
 SIJqQ7TF1lR+CLtTYa06PH2hYak49OVlfGa2UHRA836tQyCdhZT/xk54fr1YBWhFJbLM
 HerFzLxw1ogP/n6B/2QJZ2TxSEMSf4uZTqMLLycTo4i3HMsUpYDjlXcs07FRHhqIMY7L
 rIXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCYJW8Za4qO6NBCIFbR8eOIzfOm5iGwbw4RWA3pCPVDN3Cydz/02m6aizM2hoP/27m1ujDDWfIS9ryvzLTXWfXVQj0wRs=
X-Gm-Message-State: AOJu0Ywa6Nrth1hNgayBQ5gpYbqvTm40clX4xGiBQzX1GxGiDXmrdiIu
 8J2ZCoz5Pd/aVlAG7Y0W5DnWQ5jBicAjV7lkOsls6Rmqk18cn2Nys4TuFjVxsLt7N7yZEeaImwu
 fZ4I6Jpn/DUcVorG60jDVM6CIGds=
X-Google-Smtp-Source: AGHT+IHZUo6Pt6cHPn2HE+zPZFOJvm6Ppz12wUMJIHfV1gr9Dy/wFeCvOTGykeUz1W16/FiVEwX1BlwUryFYMPLE4VE=
X-Received: by 2002:a50:d5d9:0:b0:568:8e22:4eff with SMTP id
 g25-20020a50d5d9000000b005688e224effmr1525770edj.37.1712747668168; Wed, 10
 Apr 2024 04:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-5-vikram.garhwal@amd.com>
 <87o7bx5187.fsf@draig.linaro.org>
In-Reply-To: <87o7bx5187.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 13:14:16 +0200
Message-ID: <CAJy5ezrG0m6_5hKD1axpOSYLp-jk14=E+XPo9=oThyY-TN-7TQ@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 4/7] xen: let xen_ram_addr_from_mapcache() return
 -1 in case of not found entry
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Vikram Garhwal <vikram.garhwal@amd.com>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, 
 jgross@suse.com, Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: multipart/alternative; boundary="00000000000059e8be0615bc2419"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000059e8be0615bc2419
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:08=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Vikram Garhwal <vikram.garhwal@amd.com> writes:
>
> > From: Juergen Gross <jgross@suse.com>
> >
> > Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
> > case it can't find a matching entry for a pointer value. Both cases
> > are bad, so change that to return an invalid address instead.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >  hw/xen/xen-mapcache.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index dfc412d138..179b7e95b2 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -396,13 +396,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> >          }
> >      }
> >      if (!found) {
> > -        trace_xen_ram_addr_from_mapcache_not_found(ptr);
> > -        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> > -
> trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
> > -                                                   reventry->vaddr_req=
);
> > -        }
>
> If these tracepoints aren't useful they need removing from trace-events.
> However I suspect it would be better to keep them in as they are fairly
> cheap.
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

--00000000000059e8be0615bc2419
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Mar 1, 2024 at 6:08=E2=80=AFPM Al=
ex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@li=
naro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Vikram Garhwal &lt;<a href=3D"mailto:vik=
ram.garhwal@amd.com" target=3D"_blank">vikram.garhwal@amd.com</a>&gt; write=
s:<br>
<br>
&gt; From: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" target=3D"_=
blank">jgross@suse.com</a>&gt;<br>
&gt;<br>
&gt; Today xen_ram_addr_from_mapcache() will either abort() or return 0 in<=
br>
&gt; case it can&#39;t find a matching entry for a pointer value. Both case=
s<br>
&gt; are bad, so change that to return an invalid address instead.<br>
&gt;<br>
&gt; Signed-off-by: Juergen Gross &lt;<a href=3D"mailto:jgross@suse.com" ta=
rget=3D"_blank">jgross@suse.com</a>&gt;<br>
&gt; Reviewed-by: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kern=
el.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/xen/xen-mapcache.c | 11 +++--------<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c<br>
&gt; index dfc412d138..179b7e95b2 100644<br>
&gt; --- a/hw/xen/xen-mapcache.c<br>
&gt; +++ b/hw/xen/xen-mapcache.c<br>
&gt; @@ -396,13 +396,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!found) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_xen_ram_addr_from_mapcache_not_foun=
d(ptr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_FOREACH(reventry, &amp;mapcache-&g=
t;locked_entries, next) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_xen_ram_addr_from_map=
cache_found(reventry-&gt;paddr_index,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reventry-&gt;vaddr_req);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
If these tracepoints aren&#39;t useful they need removing from trace-events=
.<br>
However I suspect it would be better to keep them in as they are fairly<br>
cheap.<br>
<br>
Otherwise:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a =
href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></=
div><div><br></div></div></div>

--00000000000059e8be0615bc2419--


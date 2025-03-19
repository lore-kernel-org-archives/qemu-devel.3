Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA19C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwej-0002LO-6d; Wed, 19 Mar 2025 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tuweb-0002DE-Ih
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tuweV-0004az-Ua
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742403139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8vrEXBZMjIcHMuQEVOPs5AtHpQ8Sd/RerkPvQyK5CCc=;
 b=MscfGiv+0vy2Jb2Zf4llxNKvKAafrvnJiPNm1RlMlKFgqbkHZ7vX2HNa0DeoKlqA/u9efK
 VlT9vE12FNsM5wy83lMYT+7CoDteM9EhwErqQeqbKoAnhPUl13ab+9uJU/Wh/DC6JBDzCg
 2m/WlBAnZRigwKZKD3nng526oI4rzzw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-4PWBy4hBNpK00PtsH3NcEQ-1; Wed, 19 Mar 2025 12:52:17 -0400
X-MC-Unique: 4PWBy4hBNpK00PtsH3NcEQ-1
X-Mimecast-MFC-AGG-ID: 4PWBy4hBNpK00PtsH3NcEQ_1742403137
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e900f6dcadso152958096d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403137; x=1743007937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vrEXBZMjIcHMuQEVOPs5AtHpQ8Sd/RerkPvQyK5CCc=;
 b=KZSFrjUmq80giUjLl2eX582ix6Y+V8xiD9zxTZkAnAUXl/LcnDg8jCvyjIcR7xfIqF
 prMcZ16HehT4OV9pk6Lohzoca1R4+iMTIN0Sj20TER5U6++f0PyDai1z9EO15nGMGXZK
 3M63UCh2sfunRoQPi/7nTpfY7nIl1XvBoQoknKZNrmQjmx8rg2yJqlDqpe0qrvghoH8S
 9KVGHX1mIRPc8g7WSwM+8TrwUCr3fqanr5li2zyv+M6n0dY/IZtWcYHhbORE2p5Kuc+z
 veo378qtnlQ6zo79U+BCYG0vItwbqk/fWUiRSxGKjAg7hZeMCkr6DunrhBsIFAFGve2Z
 U72Q==
X-Gm-Message-State: AOJu0YycLqtYnQGXVS2aPZENkN4B80ljEjhPt8+ALW5dkhHmVuEo3F72
 KrjrtwfIMujNHUCZhNLLqJ1Eu4DfuZxSt3IFfhH5cmZbkncsf8M8G2KO5bXIQuhz2VkCUMz5Da+
 ucbz318pRlYpVxHevR3EJ7NtdaTdaIxehSHKL9qqXa7e9BXAtUWR0X7fG6LH1OmlAjyQEqSfgdM
 rgCez64Zn5W4xwb8PlbEf83IejzYo=
X-Gm-Gg: ASbGncs745SzWg9+M4yuBTdN00tF2Bxmkl+EKEnDF8bBo07R5NKm2YrlbvN7jx/aq0z
 /kQRqP90J9aQOP98n9YSaCTtdwe9OoiQBHz1Fjls1fl+WEYThP4uijP/f3Aoan0pyEgvPqumEeY
 U=
X-Received: by 2002:a05:6214:2581:b0:6ea:d604:9e56 with SMTP id
 6a1803df08f44-6eb2926afb4mr43577856d6.9.1742403136930; 
 Wed, 19 Mar 2025 09:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb6H1l1LVEHoghOdiHjg5NwTQHgLVWIMVeemiy3ie5dag7AyEXq5PV7ihWCy5+3c1bfouNRwiocjhFR8GNV0Y=
X-Received: by 2002:a05:6214:2581:b0:6ea:d604:9e56 with SMTP id
 6a1803df08f44-6eb2926afb4mr43577466d6.9.1742403136506; Wed, 19 Mar 2025
 09:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250314113847.109460-1-kkostiuk@redhat.com>
 <20250314113847.109460-2-kkostiuk@redhat.com>
 <Z9rchyQO5vNcrfmN@redhat.com>
In-Reply-To: <Z9rchyQO5vNcrfmN@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 19 Mar 2025 18:52:05 +0200
X-Gm-Features: AQ5f1JpAliu2B-SCXYrFE23TOf8B6KmQ-IIw433BqlQls71tzKEKI83hf2nlHYY
Message-ID: <CAPMcbCokNo6kf72vkuaty8wERm=FhvLPJL_sWoWMKOpXTiUbfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga-win: implement a 'guest-get-load' command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000001e16d0630b4d8a7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000001e16d0630b4d8a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Mar 14, 2025 at 01:38:46PM +0200, Konstantin Kostiuk wrote:
> > Windows has no native equivalent API, but it would be possible to
> > simulate it as illustrated here (BSD-3-Clause):
> >
> >   https://github.com/giampaolo/psutil/pull/1485
> >
> > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> > ---
> >  qga/commands-win32.c   | 140 +++++++++++++++++++++++++++++++++++++++++
> >  qga/guest-agent-core.h |  10 +++
> >  qga/main.c             |  39 ++++++++++++
> >  qga/meson.build        |   2 +-
> >  qga/qapi-schema.json   |   4 +-
> >  5 files changed, 192 insertions(+), 3 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> > +GuestLoadAverage *qmp_guest_get_load(Error **errp)
> > +{
> > +    if (ga_get_load_avg_pdh_query(ga_state) =3D=3D NULL) {
> > +        /* set initial values */
> > +        load_avg_1m =3D 0;
> > +        load_avg_5m =3D 0;
> > +        load_avg_15m =3D 0;
> > +
> > +        if (init_load_avg_counter(errp) =3D=3D false) {
> > +            return NULL;
> > +        }
> > +    }
>
> Nice idea. So we avoid running the load average logic
> until such time as a mgmt app actually asks for it.
>
> The load avg won't be very accurate initially, but
> assuming any interested mgmt app will ask for this
> repeatedly over the entire life of the VM, this looks
> like a good mitigation.
>
> Perhaps worth a commenting explaining why we're doing
> this.
>
>
Will add comments

Also, this allows the mgmt app to capture errors in the initialization
process. Otherwise, it should somehow parse logs.


>
> > +
> > +    GuestLoadAverage *ret =3D NULL;
> > +
> > +    ret =3D g_new0(GuestLoadAverage, 1);
> > +    ret->load1m =3D load_avg_1m;
> > +    ret->load5m =3D load_avg_5m;
> > +    ret->load15m =3D load_avg_15m;
> > +    return ret;
> > +}
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000001e16d0630b4d8a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 19,=
 2025 at 5:02=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Fri, Mar 14, 2025 at 01:38:46PM +020=
0, Konstantin Kostiuk wrote:<br>
&gt; Windows has no native equivalent API, but it would be possible to<br>
&gt; simulate it as illustrated here (BSD-3-Clause):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/giampaolo/psutil/pull/1485" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/giampaolo/psutil/pu=
ll/1485</a><br>
&gt; <br>
&gt; Signed-off-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-win32.c=C2=A0 =C2=A0| 140 +++++++++++++++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 qga/guest-agent-core.h |=C2=A0 10 +++<br>
&gt;=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 39 ++++++++++++<br>
&gt;=C2=A0 qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br=
>
&gt;=C2=A0 qga/qapi-schema.json=C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 5 files changed, 192 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
&gt; +GuestLoadAverage *qmp_guest_get_load(Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (ga_get_load_avg_pdh_query(ga_state) =3D=3D NULL) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* set initial values */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 load_avg_1m =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 load_avg_5m =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 load_avg_15m =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (init_load_avg_counter(errp) =3D=3D fa=
lse) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Nice idea. So we avoid running the load average logic<br>
until such time as a mgmt app actually asks for it.<br>
<br>
The load avg won&#39;t be very accurate initially, but<br>
assuming any interested mgmt app will ask for this<br>
repeatedly over the entire life of the VM, this looks<br>
like a good mitigation.<br>
<br>
Perhaps worth a commenting explaining why we&#39;re doing<br>
this.<br>
<br></blockquote><div><br></div><div>Will add comments<br></div><div><br></=
div><div>Also, this allows the mgmt app to capture errors in the initializa=
tion <br></div><div>process. Otherwise, it should somehow parse logs. <br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 GuestLoadAverage *ret =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D g_new0(GuestLoadAverage, 1);<br>
&gt; +=C2=A0 =C2=A0 ret-&gt;load1m =3D load_avg_1m;<br>
&gt; +=C2=A0 =C2=A0 ret-&gt;load5m =3D load_avg_5m;<br>
&gt; +=C2=A0 =C2=A0 ret-&gt;load15m =3D load_avg_15m;<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--00000000000001e16d0630b4d8a7--



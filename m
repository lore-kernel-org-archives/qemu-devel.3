Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE3DC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 16:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVC8h-0007Xb-SA; Fri, 27 Jun 2025 12:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uVC8c-0007UH-Dk
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uVC8Z-0006nT-Fo
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751042474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfuQyJZ27FnKR2bNj0/HzNwHn58UGMW9wGj6qg8kceg=;
 b=ViU2mCt8EcWDqb9lbQyWt2gHIvKWqoXAy7L+5NtPgUjhKKSQLRi4OmILqQZ5/mnsari2fA
 W7ofjzA/ytqpLaZqhMAvA/PEe+rt8lH5bQxhtpXs9Kia8MexgFhoCmgHaZR1KJqC9hdW7h
 A8yE+de0tU0ZKhZ+XuKTH//FhH3VDlo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-TEekfSWePfqolVcFAHDDFA-1; Fri, 27 Jun 2025 12:41:12 -0400
X-MC-Unique: TEekfSWePfqolVcFAHDDFA-1
X-Mimecast-MFC-AGG-ID: TEekfSWePfqolVcFAHDDFA_1751042471
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b2c36d3f884so20057a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 09:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042471; x=1751647271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfuQyJZ27FnKR2bNj0/HzNwHn58UGMW9wGj6qg8kceg=;
 b=uWg2TFqHivQwlVV8BDDmXL5qrnnIDmAHoD7n6/ROi/4wHqGlfblp3CrBG5mHR8xWCA
 8yPIXf7tTXVPun1BTO6jjANWJwlDjMLf3/BCKBEtOzNd4coCiHDBHytlUSL6kSQcqCYG
 jdmyKpTxd6MUtwy1mL9Rqz9fNTLf2PCc6F9YPfTvZ4gyq5y/OToKOFNyHktOttkL/VlI
 DoUKsLr/J39fo46bLBLGI25u+nJulIYfu0FJP1sC+oJekLICAbjWdM2iQf8EsqITsrV7
 pVvB8lb8vGDVLWe8uSCjByqeBhDnxFyb0Lru9+i6k9IuLjosJSmG1ZWMCSXNbQueLe9L
 q7ig==
X-Gm-Message-State: AOJu0Yxe2PV91ZGy95TaA87GxNKLmSJLwVnoBH2HbZAngg/SaL+8VWHv
 hboRZ0m8RKm9UIqn7yqOo1zp8hYc9hBIM5syVI5nod50oYWZtpEMuPJ6/WMDieB8OlU71C7BJ4C
 XNW4tmf5/g6f+R3iv1Ly+QyEHQfjm2G2LEaV/bSInZmc8Ui9p93FUACPYJ/SmN1VsnolDJoWSWZ
 lOuaAQVc51gxsxaQoS9aQurcmLhVWgdzc=
X-Gm-Gg: ASbGnctSGpY45tUlAlEn4Dl/KTG0YJY6ZCFfOH5T4fxqUUvmxSmxvuklcxbyINIhcrN
 nf8Eex8VWYRuWF4SGtzHcy7zFwQXbIAl+NTb+TIVnMjiEjdy8QsiJQGLpOjyhEujtCcY7WRuLCK
 MRSElrWGYN20jR6QntN35gnb6ZRSYo0njbIM4=
X-Received: by 2002:a17:90b:1b12:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-318c9314696mr6600207a91.33.1751042470960; 
 Fri, 27 Jun 2025 09:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMe48UOaORPcZ+DNOIHaPFtwXp7wDRNU+lWk1Lau4YFgw0FmoqVXG3ty2q47q1Mjsn4eU7yOVS0A5b5QYPwcs=
X-Received: by 2002:a17:90b:1b12:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-318c9314696mr6600159a91.33.1751042470541; Fri, 27 Jun 2025
 09:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-3-jsnow@redhat.com>
 <87y0tdmrw6.fsf@pond.sub.org>
In-Reply-To: <87y0tdmrw6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 27 Jun 2025 12:40:58 -0400
X-Gm-Features: Ac12FXwXMQw0L757wYqSXqs374VSelB3WwQ0fWENj7B3SHswbelGlE8P_eULJgw
Message-ID: <CAFn=p-a=iYsGeDrndJAnC+WK3b2tuJ2a1ose0w_DfuSAGT0RmA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] docs/sphinx: parse @references in freeform text
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jiri Pirko <jiri@resnulli.us>,
 Fan Ni <fan.ni@samsung.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Kashyap Chamarthy <kchamart@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, 
 Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Content-Type: multipart/alternative; boundary="00000000000071a0900638905816"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000071a0900638905816
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025, 5:54=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Oversight in the new qapidoc transmogrifier: @references in freeform
> > documentation blocks were not being transformed to literals. This fixes
> > that, and the next patch ensures that we're testing for this O:-)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 5374dee8fad..adc14ade456 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -218,6 +218,11 @@ def generate_field(
> >          typ =3D self.format_type(member)
> >          self.add_field(kind, member.name, body, info, typ)
> >
> > +    @staticmethod
> > +    def reformat_arobase(text: str) -> str:
>
> What's an "arobase"?  Inquiring mind wants to know!
>

French for "at symbol thingie" :)

(Intentionally obtuse as an oblique joke, forgive my humor)


> > +        """ reformats @var to ``var`` """
> > +        return re.sub(r"@([\w-]+)", r"``\1``", text)
> > +
> >      # Transmogrification helpers
> >
> >      def visit_paragraph(self, section: QAPIDoc.Section) -> None:
> > @@ -361,8 +366,7 @@ def visit_sections(self, ent: QAPISchemaDefinition)
> -> None:
> >
> >          # Add sections in source order:
> >          for i, section in enumerate(sections):
> > -            # @var is translated to ``var``:
> > -            section.text =3D re.sub(r"@([\w-]+)", r"``\1``", section.t=
ext)
> > +            section.text =3D self.reformat_arobase(section.text)
> >
> >              if section.kind =3D=3D QAPIDoc.Kind.PLAIN:
> >                  self.visit_paragraph(section)
> > @@ -405,7 +409,7 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
> >
> >          assert len(doc.all_sections) =3D=3D 1, doc.all_sections
> >          body =3D doc.all_sections[0]
> > -        text =3D body.text
> > +        text =3D self.reformat_arobase(body.text)
> >          info =3D doc.info
> >
> >          if re.match(r"=3D+ ", text):
>
>

--00000000000071a0900638905816
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27, 2025, 5:54=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Oversight in the new qapidoc transmogrifier: @references in freeform<b=
r>
&gt; documentation blocks were not being transformed to literals. This fixe=
s<br>
&gt; that, and the next patch ensures that we&#39;re testing for this O:-)<=
br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 10 +++++++---<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 5374dee8fad..adc14ade456 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -218,6 +218,11 @@ def generate_field(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.format_type(member)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_field(kind, <a href=3D"http=
://member.name" rel=3D"noreferrer noreferrer" target=3D"_blank">member.name=
</a>, body, info, typ)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 @staticmethod<br>
&gt; +=C2=A0 =C2=A0 def reformat_arobase(text: str) -&gt; str:<br>
<br>
What&#39;s an &quot;arobase&quot;?=C2=A0 Inquiring mind wants to know!<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Frenc=
h for &quot;at symbol thingie&quot; :)</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">(Intentionally obtuse as an oblique joke, forgive my humor)<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; reformats @var to ``va=
r`` &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return re.sub(r&quot;@([\w-]+)&quot;, r&q=
uot;``\1``&quot;, text)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_paragraph(self, section: QAPIDoc.Section=
) -&gt; None:<br>
&gt; @@ -361,8 +366,7 @@ def visit_sections(self, ent: QAPISchemaDefinition=
) -&gt; None:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Add sections in source order:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, section in enumerate(sections=
):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # @var is translated to ``v=
ar``:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D re.sub(r&q=
uot;@([\w-]+)&quot;, r&quot;``\1``&quot;, section.text)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D self.refor=
mat_arobase(section.text)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind =3D=3D=
 QAPIDoc.Kind.PLAIN:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vis=
it_paragraph(section)<br>
&gt; @@ -405,7 +409,7 @@ def visit_freeform(self, doc: QAPIDoc) -&gt; None:=
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert len(doc.all_sections) =3D=3D =
1, doc.all_sections<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 body =3D doc.all_sections[0]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D body.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D self.reformat_arobase(body.text)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D <a href=3D"http://doc.info"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">doc.info</a><br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match(r&quot;=3D+ &quot;, text=
):<br>
<br>
</blockquote></div></div></div>

--00000000000071a0900638905816--



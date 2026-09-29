Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E9C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYc9-00025p-1v; Tue, 29 Sep 2026 10:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYc7-00025g-9C
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYc4-00007e-M9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790691317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TcKTnY5OBkZwVuCW3JLbg5ruebOCYk8NUFM4iSMLh9g=;
 b=cUoPlIiJ2xfPGFMl4wBjVj674/vHLrGVXaC0afcbUURyktBJVbs4TM9tcfL/V6xzDTBGHn
 Suv68M48SC/nThSESEi6u08J35puEiHUombh1Sw4rhQtTPO18Sl5iy2HvBY8QmnmO2T+J5
 Es30/VA0F6gHH/d+3MZbl5MPgRk6xHo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-phV8VlZxOhqlrb1F3ETB_A-1; Tue, 29 Sep 2026 10:15:04 -0400
X-MC-Unique: phV8VlZxOhqlrb1F3ETB_A-1
X-Mimecast-MFC-AGG-ID: phV8VlZxOhqlrb1F3ETB_A_1790691304
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66cdb701595so6182948d50.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691304; cv=none;
 d=google.com; s=arc-20260327;
 b=lKpQuRiuirCinUBpZe8d6dlcuhHgmFbkg47Mm2kxiHmozWFwz6oTxQljZIRZPY/vml
 eB5sc7PnZ3kJzomYTYXjUtXIF8eVMCoQxnbE54wYDM4VKzWBWE+HWM5SM5Dha/bnDwWQ
 X8zdcRiw/nWuZsvDaZG6XEiVu69EgNXA/BHIz9fV0aLBvgWSBNgSTo1M7dolbsepOrrg
 jyCiXI9uc0iNQIEti7cLQbhXrIe7lWpF8rVjL9E5Tf77UJGDBhJ8/bblcs+T8BTzvFBb
 8HbJFgs7WXax4i03rkCYikOCR+TnREjmn1vgVR341M7UmLP83oaeRewRJNJVwgn4Q1Zw
 HQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TcKTnY5OBkZwVuCW3JLbg5ruebOCYk8NUFM4iSMLh9g=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=T5C4dJv2e4ejhni4DZfLmBGfotAeLyPr0Fvt1odLgVxdS4rc4mP+n/DyuaNrmKbhP/
 YGOsJPCHmovWqPDvlB8nRJUT/teh05BGTKeUgW0Pwd0DXylxzfl7r32rp0latG2g/WTY
 siLg3UnDZEJqDRrKgfMqViRKNBzCleSnBBx2w1YyhyPIbgWZVHb8/z5L/Eo3wVVqCpgq
 vu9It1W2WHVbUhpFtNueYEr9v0L7Bmi6iCb/iCrT/ZYxj9sd0kWOFRg1NmmGno4tnHcr
 xJwc3IhQY1i2Gv04ImUOUaZJmCQS6FIRJ/ZP9/aa/yKmIBFU87mWcYpoL9yyKVTerM7I
 iysw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790691304; x=1791296104; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TcKTnY5OBkZwVuCW3JLbg5ruebOCYk8NUFM4iSMLh9g=;
 b=cG65B+ngUccs+KPB03PYAoH2GsVzruHyM6soRtMll2ltyF9H4aM8eRH4pwilYEv8W1
 UWIiXedHCe63L9iUI/Q8QlaLEHjGn0rCaaGXItaoHDWNbEr0veq4O6pj9hIn8kqCV4mZ
 qAq6U+YTNeqUnM8EAVbN8j/MDBkp8ALtoi0f1r1UZws7fXXQRQhawPgs1hwD7rls/y0o
 krvlCoqFPfJtCqouD+YQhOb5FAukGm7a8rm7gbow/uJpswQUYxrtJ+aOBR1FfBtMiYnz
 8fRFFOxU+n7ggPbVsDjDr9Y1wX0DAArjhLHUxu55U6TxlfrIa+xF4WhIAAg9mT4dapFn
 1WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691304; x=1791296104;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TcKTnY5OBkZwVuCW3JLbg5ruebOCYk8NUFM4iSMLh9g=;
 b=d1VpzA+oxg+7foYgkYej1q96Qoj1yk1Mbj3duGLxl7ReKdLS6caLDtwsjBENCpsI/M
 PA3LZxUb2DU0+buGmDapMf4aBv6IjUsSso3dXMv5tnK8JniK3oXACUo02QmQqtS/A4BZ
 0Nt40aICNPdgaSVuzBw/qyCn869zhfpOyrcHkTNJoF+nUSlR4WiZpZG1JBkXw1LldOpH
 1oLl3ILgE4zxrqStoU/qlR2w/zKXTkwd6Kfd7a7DKH2DTQQIMeM+X7PRmFY70UP/eqQC
 m5hbkktmz903K+tE8SLhshtGYQ869VnPIfmjw4Tr8PubD+mU6nksbtxMSsDP1fUUP3gI
 ny/g==
X-Gm-Message-State: AFq9FYJB40hyWSDoTVwyDEeI9KTQyuoMuJp4UYbqML01pS9RBm33sruN
 3/cIA+wnzySi9lg63/6WhBPFeLWsOcw8oBXDN36M+JGPN8Kx2w0hDZvQnO3pHBS4IJdmIBBHsGU
 VFoNDwgnoFE0N/JcMq4/F8lgWVjVhbXqg00x/XUlekLeRfMr5bE6OJIh4wCBTzfHiNKzKekbraT
 ah6S95S98yDqxoDPUDzBHjOSYX6+evx3I=
X-Gm-Gg: AYBFou3VrNqZy6gV6z07oyV7bi73VBalQrH7VTleudyGD/7CkhTxLQVQZyPWATyT5OB
 g5M92KY4BKC5fTFAke6fB6QWjuPGO8DLDKfvdT7NKs9+aymYENbe6YobE1su6QqTZqb5TjirTgb
 c6m3dXl2Wnk3QDVIF4sw7uddQrEPZu9+sM9CaGV+n0N8eV1tIrjgKy1bo8oWSz1cHK4hPjQMRks
 EaIZfPI6PgQp+0=
X-Received: by 2002:a05:690e:4886:20b0:675:6168:8be3 with SMTP id
 956f58d0204a3-6756168911bmr794968d50.24.1790691303645; 
 Tue, 29 Sep 2026 07:15:03 -0700 (PDT)
X-Received: by 2002:a05:690e:4886:20b0:675:6168:8be3 with SMTP id
 956f58d0204a3-6756168911bmr794905d50.24.1790691303000; Tue, 29 Sep 2026
 07:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-11-jsnow@redhat.com>
 <87qzicw5js.fsf@pond.sub.org>
In-Reply-To: <87qzicw5js.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:14:51 -0400
X-Gm-Features: AclHuK8Jd7wj7GjvfDExFkwqy0vKz2lUyfrS1Mud0n4Y2RjES81aEuJ9DepR-qA
Message-ID: <CAFn=p-YN-AqL335UF1U1eMDKNm+xFR7e9zVDfANJsMFU7qzkJA@mail.gmail.com>
Subject: Re: [PATCH 10/14] qapi/parser: add _append() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex@shazbot.org>, Kashyap Chamarthy <kchamart@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000050431065c9fcf44"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000050431065c9fcf44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 9:28=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This method is intended to become the sole point of appending new
> > sections to the section list, prohibiting outside callers from
> > accessing the list of sections directly.
> >
> > A forthcoming commit will actually convert the "all_sections" field to
> > be a private field to begin enforcing that no outside callers are
> > manipulating the section list from outside of this class.
>
> This suggests you merely add the method now.  Not true, you also put it
> to use.
>

Didn't mean to suggest such a thing! I'll try to reword.

I mean only to convey that at this point, this doesn't *quite* become the
sole access point as intended, due to some transitional code that this
series is on its way to remove.

I'm trying to justify the partial conversion.


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 50 ++++++++++++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 19 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 5fc9c18c81d..0dca1acba4c 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -542,7 +542,7 @@ def get_doc(self) -> 'QAPIDoc':
> >              if not symbol:
> >                  raise QAPIParseError(self, "name required after '@'")
> >              doc =3D QAPIDoc(info, symbol)
> > -            doc.all_sections.append(QAPIDoc.Section(info,
> QAPIDoc.Kind.INTRO))
> > +            doc.new_tagged_section(info, QAPIDoc.Kind.INTRO)
> >              line =3D self.get_doc_indented(doc)
> >              no_more_args =3D False
> >              last_ordered_section =3D QAPIDoc.Kind.INTRO
> > @@ -772,6 +772,33 @@ def __init__(self, info: QAPISourceInfo, symbol:
> Optional[str] =3D None):
> >      def has_features(self) -> bool:
> >          return bool(self._features)
> >
> > +    def _append(self, section: 'QAPIDoc.Section') -> None:
>
> Maybe name it _append_section()?  We already have append_line()...
>

Eh, why not, sure.


> > +        """
> > +        Primary internal interface for adding a new section.
> > +
> > +        It is intended to become the sole access point for adding new
> > +        sections to the QAPIDoc section list, but we are currently in
> > +        a transitional phase where other methods access the section
> > +        list directly to do insertions of generated sections at
> > +        targeted points.
>
> Yes: ._insert_near_kind().
>
> > +        """
>
> This comment will soon change to
>
>            """
>            Primary internal interface for adding a new section.
>
>            All other methods/helpers/etc ultimately use this and only
>            this interface for appending a new section.
>            """
>
> There's a bit of redundancy.  Suggest
>
>            """
>            Add a new section at the end.
>
>            It is intended to ...
>            """
>
> now, and
>
>            """
>            Add a new section at the end.
>
>            All other ...
>            """
>
> later.
>

More or less correct, though "at the end" isn't really true, it's
contextually sensitive.

"Add a new section" is more correct.

Actually, why don't we name it _add_section() to make it clear that it
isn't *always* an append?


> > +        if section.kind =3D=3D QAPIDoc.Kind.RETURNS:
> > +            if self._returns:
> > +                raise QAPISemError(
> > +                    section.info, "duplicated '%s' section" %
> section.kind)
> > +            self._returns =3D section
> > +        elif section.kind =3D=3D QAPIDoc.Kind.ERRORS:
> > +            if self._errors:
> > +                raise QAPISemError(
> > +                    section.info, "duplicated '%s' section" %
> section.kind)
> > +            self._errors =3D section
> > +        elif section.kind =3D=3D QAPIDoc.Kind.SINCE:
> > +            if self.since:
> > +                raise QAPISemError(
> > +                    section.info, "duplicated '%s' section" %
> section.kind)
> > +            self.since =3D section
> > +        self.all_sections.append(section)
> > +
> >      def end(self) -> None:
> >          for section in self.all_sections:
> >              section.text =3D section.text.strip('\n')
> > @@ -797,7 +824,7 @@ def ensure_untagged_section(self, info:
> QAPISourceInfo) -> None:
> >
> >          # start new section
> >          section =3D self.Section(info, kind)
> > -        self.all_sections.append(section)
> > +        self._append(section)
> >
> >      def new_tagged_section(
> >          self,
> > @@ -805,22 +832,7 @@ def new_tagged_section(
> >          kind: 'QAPIDoc.Kind',
> >      ) -> None:
> >          section =3D self.Section(info, kind)
> > -        if kind =3D=3D QAPIDoc.Kind.RETURNS:
> > -            if self._returns:
> > -                raise QAPISemError(
> > -                    info, "duplicated '%s' section" % kind)
> > -            self._returns =3D section
> > -        elif kind =3D=3D QAPIDoc.Kind.ERRORS:
> > -            if self._errors:
> > -                raise QAPISemError(
> > -                    info, "duplicated '%s' section" % kind)
> > -            self._errors =3D section
> > -        elif kind =3D=3D QAPIDoc.Kind.SINCE:
> > -            if self.since:
> > -                raise QAPISemError(
> > -                    info, "duplicated '%s' section" % kind)
> > -            self.since =3D section
> > -        self.all_sections.append(section)
> > +        self._append(section)
> >
> >      def _new_description(
> >          self,
> > @@ -834,7 +846,7 @@ def _new_description(
> >          if name in desc:
> >              raise QAPISemError(info, "'%s' parameter name duplicated" =
%
> name)
> >          section =3D self.ArgSection(info, kind, name)
> > -        self.all_sections.append(section)
> > +        self._append(section)
> >          desc[name] =3D section
> >
> >      def new_argument(self, info: QAPISourceInfo, name: str) -> None:
>
>

--000000000000050431065c9fcf44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 9:28=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This method is intended to become the sole point of appending new<br>
&gt; sections to the section list, prohibiting outside callers from<br>
&gt; accessing the list of sections directly.<br>
&gt;<br>
&gt; A forthcoming commit will actually convert the &quot;all_sections&quot=
; field to<br>
&gt; be a private field to begin enforcing that no outside callers are<br>
&gt; manipulating the section list from outside of this class.<br>
<br>
This suggests you merely add the method now.=C2=A0 Not true, you also put i=
t<br>
to use.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Didn&#39;t mean to suggest such a thing! I&#39;ll try to reword.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I mean only to convey that =
at this point, this doesn&#39;t *quite* become the sole access point as int=
ended, due to some transitional code that this series is on its way to remo=
ve.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;m trying to ju=
stify the partial conversion.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 50 ++++++++++++++++++++++++++----------=
------<br>
&gt;=C2=A0 1 file changed, 31 insertions(+), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 5fc9c18c81d..0dca1acba4c 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -542,7 +542,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not symbol:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PIParseError(self, &quot;name required after &#39;@&#39;&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D QAPIDoc(info, =
symbol)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.all_sections.append(QAP=
IDoc.Section(info, QAPIDoc.Kind.INTRO))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.new_tagged_section(info=
, QAPIDoc.Kind.INTRO)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_=
indented(doc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_more_args =3D False=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_ordered_section =
=3D QAPIDoc.Kind.INTRO<br>
&gt; @@ -772,6 +772,33 @@ def __init__(self, info: QAPISourceInfo, symbol: =
Optional[str] =3D None):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def has_features(self) -&gt; bool:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return bool(self._features)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def _append(self, section: &#39;QAPIDoc.Section&#39;) -=
&gt; None:<br>
<br>
Maybe name it _append_section()?=C2=A0 We already have append_line()...<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Eh, =
why not, sure.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Primary internal interface for adding a n=
ew section.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 It is intended to become the sole access =
point for adding new<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sections to the QAPIDoc section list, but=
 we are currently in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 a transitional phase where other methods =
access the section<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 list directly to do insertions of generat=
ed sections at<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 targeted points.<br>
<br>
Yes: ._insert_near_kind().<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
<br>
This comment will soon change to<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Primary internal interface for add=
ing a new section.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0All other methods/helpers/etc ulti=
mately use this and only<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0this interface for appending a new=
 section.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
There&#39;s a bit of redundancy.=C2=A0 Suggest<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Add a new section at the end.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0It is intended to ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
now, and<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Add a new section at the end.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0All other ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
later.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">More or less correct, though &quot;at the end&quot; isn&#39;t really =
true, it&#39;s contextually sensitive.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">&quot;Add a new section&quot; is more correct.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Actually, why don&#39;t we name it _a=
dd_section() to make it clear that it isn&#39;t *always* an append?=C2=A0</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if section.kind =3D=3D QAPIDoc.Kind.RETUR=
NS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._returns:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <a href=3D"http://section.info" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">section.info</a>, &quot;duplicated &#39;%s&#39; section&quot; % secti=
on.kind)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._returns =3D section<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QAPIDoc.Kind.ERR=
ORS:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._errors:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <a href=3D"http://section.info" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">section.info</a>, &quot;duplicated &#39;%s&#39; section&quot; % secti=
on.kind)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._errors =3D section<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif section.kind =3D=3D QAPIDoc.Kind.SIN=
CE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.since:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 <a href=3D"http://section.info" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">section.info</a>, &quot;duplicated &#39;%s&#39; section&quot; % secti=
on.kind)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.since =3D section<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def end(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for section in self.all_sections:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text =3D secti=
on.text.strip(&#39;\n&#39;)<br>
&gt; @@ -797,7 +824,7 @@ def ensure_untagged_section(self, info: QAPISource=
Info) -&gt; None:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, kind)=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._append(section)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def new_tagged_section(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; @@ -805,22 +832,7 @@ def new_tagged_section(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: &#39;QAPIDoc.Kind&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, kind)=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if kind =3D=3D QAPIDoc.Kind.RETURNS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._returns:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._returns =3D section<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif kind =3D=3D QAPIDoc.Kind.ERRORS:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._errors:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._errors =3D section<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif kind =3D=3D QAPIDoc.Kind.SINCE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.since:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISem=
Error(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 info, &quot;duplicated &#39;%s&#39; section&quot; % kind)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.since =3D section<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._append(section)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def _new_description(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; @@ -834,7 +846,7 @@ def _new_description(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if name in desc:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPISemError(inf=
o, &quot;&#39;%s&#39; parameter name duplicated&quot; % name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.ArgSection(info, ki=
nd, name)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._append(section)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc[name] =3D section<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def new_argument(self, info: QAPISourceInfo, name:=
 str) -&gt; None:<br>
<br>
</blockquote></div></div></div>

--000000000000050431065c9fcf44--



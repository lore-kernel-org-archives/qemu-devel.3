Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D132FC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKi4c-0005qS-BP; Fri, 21 Jun 2024 13:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKi4b-0005nW-1Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKi4Y-0007TC-Sj
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718990953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pYpBtUzB1Q8jcWdiw/NQcqkSgabRjHc7mP7OnAqGhYU=;
 b=ac9LpbDvHZdaV0r78/0/ucOtuqivws3J5qPjey4j+QGhfiIKZrHQDYeULwD0UFknMfBXar
 t08Sf4XG3YJvI6jHI5U1Ed2/l8OadpDMKejRUirwwlFyJi0IsDBZYeVEDk7yCg6Ef+FOKY
 QOr1HrwDEzo7Tx5gW8MnGqRvkdNrKJU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yK-EyufnOx2W63tdxcEnNg-1; Fri, 21 Jun 2024 13:29:11 -0400
X-MC-Unique: yK-EyufnOx2W63tdxcEnNg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7430b3c4bso2441543a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718990950; x=1719595750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pYpBtUzB1Q8jcWdiw/NQcqkSgabRjHc7mP7OnAqGhYU=;
 b=e9PRgM7cqruzSAsB/9Q6uJvO7BbTv5P/KdlYhu8dK+S0qVkZUEA7ieyZtQscNAaDOS
 OPpGKDoubmLKnzGZDxeRK/xlM63qNeoXIVhxPME/6qcMpu5gK0JVv+NIbaVH5BF6o47B
 N3F+n67BWfrJzi3Smv/etNxehPHhlJD5F2DQW+SlyueKYyeH1fyaTZPgBAg3tjl3WE1a
 HMH36RSVxLELwzBb8x7b2DTx+otC4sLs7lQ8wyxwx0WO7CB8CmQ74jKcvwNHCRvw+ioZ
 MlUYKFguMeXx3QLqqLE+8ihLcU+g5VKeLpshTnUOxd7ANwvdj9R4F1YQusTOLZ6sSq9H
 9Siw==
X-Gm-Message-State: AOJu0YzIBqjy7hyX6E9A66/erll63ftNDcKFpTqayhy7OaSbJefvfSy7
 WNTiAFAI06JRhgFfLTWtPTUGnr3m15vG28yJkdAs/3ynXP7yLqUsYOFVUpyIfR2ixJo9KMPZAcu
 X1SlxD1Ofi/0RNy3Bd1I5xD8P9RdcR8tgd5DTY76KX+dYU6HeWYJ1lLxOxnRr/wbQzp9CrdSPpx
 KaUFB+tKld/sA693sZC1OuLmfddwo=
X-Received: by 2002:a17:90a:3908:b0:2c7:2fdf:57b7 with SMTP id
 98e67ed59e1d1-2c7b5dcd506mr8453862a91.46.1718990950094; 
 Fri, 21 Jun 2024 10:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIpfqy/GENYvTr3nX1ptq+m1lF/XyndUbMkyovrpbj63dh0oSahHkYJg20XanoRPf0G+x3s60WKgMVI/xaB1Y=
X-Received: by 2002:a17:90a:3908:b0:2c7:2fdf:57b7 with SMTP id
 98e67ed59e1d1-2c7b5dcd506mr8453839a91.46.1718990949705; Fri, 21 Jun 2024
 10:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-5-jsnow@redhat.com>
 <878qz12l87.fsf@pond.sub.org>
 <CAFn=p-YUUfaSKWwEwdR=+3q-TrKR6v0HmYNUk75AvmFEjpviAQ@mail.gmail.com>
 <87h6dnsldn.fsf@pond.sub.org>
 <CAFn=p-bdtS=u6upkjD6+Vn_7cC1cysd-DLKvrg6T5SPrucQpLg@mail.gmail.com>
 <87plsareai.fsf@pond.sub.org>
In-Reply-To: <87plsareai.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Jun 2024 13:28:57 -0400
Message-ID: <CAFn=p-YHowgTn52K+UE14ieaPjxZzqESM7eEzHa3p3Q3Av9_ZA@mail.gmail.com>
Subject: Re: [PATCH 04/13] qapi/parser: preserve indentation in QAPIDoc
 sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ee00f6061b69c4e8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

--000000000000ee00f6061b69c4e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 2:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Jun 20, 2024, 11:07=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com>
> wrote:
> >> >
> >> >> John Snow <jsnow@redhat.com> writes:
> >> >>
> >> >> > Change get_doc_indented() to preserve indentation on all
> subsequent text
> >> >> > lines, and create a compatibility dedent() function for qapidoc.p=
y
> to
> >> >> > remove that indentation. This is being done for the benefit of a
> new
> >> >>
> >> >> Suggest "remove indentation the same way get_doc_indented() did."
> >> >>
> >> >
> >> > Aight.
> >> >
> >> >
> >> >> > qapidoc generator which requires that indentation in argument and
> >> >> > features sections are preserved.
> >> >> >
> >> >> > Prior to this patch, a section like this:
> >> >> >
> >> >> > ```
> >> >> > @name: lorem ipsum
> >> >> >    dolor sit amet
> >> >> >      consectetur adipiscing elit
> >> >> > ```
> >> >> >
> >> >> > would have its body text be parsed as:
> >> >>
> >> >> Suggest "parsed into".
> >> >>
> >> >
> >> > Why? (I mean, I'll do it, but I don't see the semantic difference
> >> > personally)
> >> >
> >>
> >> "Parse as <language>" vs. "Parse into <representation>".
> >>
> >> >> > (first and final newline only for presentation)
> >> >> >
> >> >> > ```
> >> >> > lorem ipsum
> >> >> > dolor sit amet
> >> >> >   consectetur adipiscing elit
> >> >> > ```
> >> >> >
> >> >> > We want to preserve the indentation for even the first body line
> so that
> >> >> > the entire block can be parsed directly as rST. This patch would
> now
> >> >> > parse that segment as:
> >> >>
> >> >> If you change "parsed as" to "parsed into" above, then do it here,
> too.
> >> >>
> >> >> >
> >> >> > ```
> >> >> > lorem ipsum
> >> >> >    dolor sit amet
> >> >> >      consectetur adipiscing elit
> >> >> > ```
> >> >> >
> >> >> > This is helpful for formatting arguments and features as field
> lists in
> >> >> > rST, where the new generator will format this information as:
> >> >> >
> >> >> > ```
> >> >> > :arg type name: lorem ipsum
> >> >> >    dolor sit amet
> >> >> >      consectetur apidiscing elit
> >> >> > ```
> >> >> >
> >> >> > ...and can be formed by the simple concatenation of the field lis=
t
> >> >> > construct and the body text. The indents help preserve the
> continuation
> >> >> > of a block-level element, and further allow the use of additional
> rST
> >> >> > block-level constructs such as code blocks, lists, and other such
> >> >> > markup. Avoiding reflowing the text conditionally also helps
> preserve
> >> >> > source line context for better rST error reporting from sphinx
> through
> >> >> > generated source, too.
> >> >>
> >> >> What do you mean by "reflowing"?
> >> >>
> >> >
> >> > Poorly phrased, was thinking about emacs too much. I mean munging th=
e
> text
> >> > post-hoc for the doc generator such that newlines are added or
> removed in
> >> > the process of re-formatting text to get the proper indentation for
> the new
> >> > rST form.
> >> >
> >> > In prototyping, this got messy very quickly and was difficult to
> correlate
> >> > source line numbers across the transformation.
> >> >
> >> > It was easier to just not munge the text at all instead of munging i=
t
> and
> >> > then un-munging it.
> >> >
> >> > (semantic satiation: munge munge munge munge.)
> >>
> >> Is this about a possible alternative solution you explored?  Keeping
> >> .get_doc_indented() as is, and then try to undo its damage?
> >>
> >
> > precisamente. That solution was categorically worse.
>
> Since .get_doc_indented() removes N spaces of indentation, we'd want to
> add back N spaces of indentation.  But we can't know N, so I guess we'd
> make do with an arbitrary number.  Where would reflowing come it?
>
> I'd like you to express more clearly that you're talking about an
> alternative you rejected.  Perhaps like this:
>
>   block-level constructs such as code blocks, lists, and other such
>   markup.
>
>   The alternative would be to somehow undo .get_doc_indented()'s
>   indentation changes in the new generator.  Much messier.
>
> Feel free to add more detail to the last paragraph.
>

Eh, I just deleted it. I recall running into troubles but I can't
articulate the precise conditions because as you point out, it's a doomed
strategy for other reasons - you can't reconstruct the proper indentation.

This patch is still the correct way to go, so I don't have to explain my
failures at length in the commit message ... I just like giving people
clues for *why* I decided to implement things a certain way, because I
often find that more instructive than the "how". In this case, the "why" is
probably more properly summarized as "it's a total shitshow in that
direction, trust me"

--js

--000000000000ee00f6061b69c4e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 2:38=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Jun 20, 2024, 11:07=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster &lt;<=
a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>=
&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; Change get_doc_indented() to preserve indentation on=
 all subsequent text<br>
&gt;&gt; &gt;&gt; &gt; lines, and create a compatibility dedent() function =
for qapidoc.py to<br>
&gt;&gt; &gt;&gt; &gt; remove that indentation. This is being done for the =
benefit of a new<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Suggest &quot;remove indentation the same way get_doc_ind=
ented() did.&quot;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Aight.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; qapidoc generator which requires that indentation in=
 argument and<br>
&gt;&gt; &gt;&gt; &gt; features sections are preserved.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Prior to this patch, a section like this:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt; @name: lorem ipsum<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; would have its body text be parsed as:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Suggest &quot;parsed into&quot;.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Why? (I mean, I&#39;ll do it, but I don&#39;t see the semanti=
c difference<br>
&gt;&gt; &gt; personally)<br>
&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt; &quot;Parse as &lt;language&gt;&quot; vs. &quot;Parse into &lt;rep=
resentation&gt;&quot;.<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; (first and final newline only for presentation)<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt; lorem ipsum<br>
&gt;&gt; &gt;&gt; &gt; dolor sit amet<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; We want to preserve the indentation for even the fir=
st body line so that<br>
&gt;&gt; &gt;&gt; &gt; the entire block can be parsed directly as rST. This=
 patch would now<br>
&gt;&gt; &gt;&gt; &gt; parse that segment as:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; If you change &quot;parsed as&quot; to &quot;parsed into&=
quot; above, then do it here, too.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt; lorem ipsum<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; This is helpful for formatting arguments and feature=
s as field lists in<br>
&gt;&gt; &gt;&gt; &gt; rST, where the new generator will format this inform=
ation as:<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt; :arg type name: lorem ipsum<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur apidiscing elit<br>
&gt;&gt; &gt;&gt; &gt; ```<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; ...and can be formed by the simple concatenation of =
the field list<br>
&gt;&gt; &gt;&gt; &gt; construct and the body text. The indents help preser=
ve the continuation<br>
&gt;&gt; &gt;&gt; &gt; of a block-level element, and further allow the use =
of additional rST<br>
&gt;&gt; &gt;&gt; &gt; block-level constructs such as code blocks, lists, a=
nd other such<br>
&gt;&gt; &gt;&gt; &gt; markup. Avoiding reflowing the text conditionally al=
so helps preserve<br>
&gt;&gt; &gt;&gt; &gt; source line context for better rST error reporting f=
rom sphinx through<br>
&gt;&gt; &gt;&gt; &gt; generated source, too.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; What do you mean by &quot;reflowing&quot;?<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Poorly phrased, was thinking about emacs too much. I mean mun=
ging the text<br>
&gt;&gt; &gt; post-hoc for the doc generator such that newlines are added o=
r removed in<br>
&gt;&gt; &gt; the process of re-formatting text to get the proper indentati=
on for the new<br>
&gt;&gt; &gt; rST form.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; In prototyping, this got messy very quickly and was difficult=
 to correlate<br>
&gt;&gt; &gt; source line numbers across the transformation.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; It was easier to just not munge the text at all instead of mu=
nging it and<br>
&gt;&gt; &gt; then un-munging it.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (semantic satiation: munge munge munge munge.)<br>
&gt;&gt;<br>
&gt;&gt; Is this about a possible alternative solution you explored?=C2=A0 =
Keeping<br>
&gt;&gt; .get_doc_indented() as is, and then try to undo its damage?<br>
&gt;&gt;<br>
&gt;<br>
&gt; precisamente. That solution was categorically worse.<br>
<br>
Since .get_doc_indented() removes N spaces of indentation, we&#39;d want to=
<br>
add back N spaces of indentation.=C2=A0 But we can&#39;t know N, so I guess=
 we&#39;d<br>
make do with an arbitrary number.=C2=A0 Where would reflowing come it?<br>
<br>
I&#39;d like you to express more clearly that you&#39;re talking about an<b=
r>
alternative you rejected.=C2=A0 Perhaps like this:<br>
<br>
=C2=A0 block-level constructs such as code blocks, lists, and other such<br=
>
=C2=A0 markup.<br>
<br>
=C2=A0 The alternative would be to somehow undo .get_doc_indented()&#39;s<b=
r>
=C2=A0 indentation changes in the new generator.=C2=A0 Much messier.<br>
<br>
Feel free to add more detail to the last paragraph.<br></blockquote><div><b=
r></div><div>Eh, I just deleted it. I recall running into troubles but I ca=
n&#39;t articulate the precise conditions because as you point out, it&#39;=
s a doomed strategy for other reasons - you can&#39;t reconstruct the prope=
r indentation.</div><div><br></div><div>This patch is still the correct way=
 to go, so I don&#39;t have to explain my failures at length in the commit =
message ... I just like giving people clues for *why* I decided to implemen=
t things a certain way, because I often find that more instructive than the=
 &quot;how&quot;. In this case, the &quot;why&quot; is probably more proper=
ly summarized as &quot;it&#39;s a total shitshow in that direction, trust m=
e&quot;</div><div><br></div><div>--js<br></div></div></div>

--000000000000ee00f6061b69c4e8--



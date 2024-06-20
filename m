Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BF5C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJV1-0002il-VI; Thu, 20 Jun 2024 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJV0-0002iW-SR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJUy-0006le-Rr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718896491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vee36bjo4YTrsrQunpYwVc1kn0MUFPjWt7boTHbKMI=;
 b=H8GqyP2hWpCrhrN0/QUQMcdqLwo77ksoWHf88C6MjzBIZUWq9ku7g/iLBrAhYalI7dMKDK
 i0E3nolu6PRSarMS3UEQXzPmI+48V9lU93ZmqxwIdtPZ96lX2chn+oP3KZe0W3oixodd6L
 ccDPYe1KTve4Q0Eh4x5hjFry7VskIA8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-SqNbHuTLPdi0RIYZeodnkw-1; Thu, 20 Jun 2024 11:14:49 -0400
X-MC-Unique: SqNbHuTLPdi0RIYZeodnkw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-704d99cb97aso965754a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896487; x=1719501287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Vee36bjo4YTrsrQunpYwVc1kn0MUFPjWt7boTHbKMI=;
 b=k4uor1HgxDM0AqpU5trMmpfEZPyYpS/h38PAmJYV6I522M7xto7xQrcWovE+ghY9lz
 QcnWn6bxCUuv8SAox53re25oDQtdXqkR96wqgcOq7GKVMFAQaMXByzxOpaS3k+cLi791
 YNuqpRAz997rnYI5jA0V6/pnoslwLqao1lzleW1zBo6R31lyPn0K7IMZJhLPaxEqFq2y
 2S4TwnCv8wmg65qSCPnHjXogEeCdGZfmnOQ8qtwsKRtM/sQ0H9SGjVcii2SFORU6zGsl
 HgjMuWI2+HDWhQpkvJMwoUYZyItO5iCcv7sly7pte+5MEvnORsqnK18f08WcWymNmxxO
 /jxg==
X-Gm-Message-State: AOJu0Ywmg6eQ/XJH5nTyOasbmfPL1TeOd89zYaHhaxNYyIqC+DOXeM5m
 wW1zJLyeqK0+db+gvCCWbClzGevJs2JTylItwvzmolcMhVND5udGsdwUMajtrl1YYhJ7hqzJ2i9
 2j8gZwodIN8+oiHYCAfJoI9g5vD6NK7w15bXTj2MddkuiLcERv5wIXzw4V1XbxsbeCE/KfsCeth
 ZGz5xU8QuYA5dsTVC0QqCjBqC5frE=
X-Received: by 2002:a17:90b:613:b0:2c7:8a94:215d with SMTP id
 98e67ed59e1d1-2c7b5b7aaa7mr5457839a91.12.1718896487025; 
 Thu, 20 Jun 2024 08:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH66P2v9S/p6s1cNcO49qC5zaa0Y2SkVSsqhmQqglH2JjT15D5G+syr+Wri8z8PJosL6VbIh8hTkMHX3/ckW/U=
X-Received: by 2002:a17:90b:613:b0:2c7:8a94:215d with SMTP id
 98e67ed59e1d1-2c7b5b7aaa7mr5457789a91.12.1718896486667; Thu, 20 Jun 2024
 08:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-5-jsnow@redhat.com>
 <878qz12l87.fsf@pond.sub.org>
 <CAFn=p-YUUfaSKWwEwdR=+3q-TrKR6v0HmYNUk75AvmFEjpviAQ@mail.gmail.com>
 <87h6dnsldn.fsf@pond.sub.org>
In-Reply-To: <87h6dnsldn.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:14:32 -0400
Message-ID: <CAFn=p-bdtS=u6upkjD6+Vn_7cC1cysd-DLKvrg6T5SPrucQpLg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000007e6cd9061b53c6e3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--0000000000007e6cd9061b53c6e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024, 11:07=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Change get_doc_indented() to preserve indentation on all subsequent
> text
> >> > lines, and create a compatibility dedent() function for qapidoc.py t=
o
> >> > remove that indentation. This is being done for the benefit of a new
> >>
> >> Suggest "remove indentation the same way get_doc_indented() did."
> >>
> >
> > Aight.
> >
> >
> >> > qapidoc generator which requires that indentation in argument and
> >> > features sections are preserved.
> >> >
> >> > Prior to this patch, a section like this:
> >> >
> >> > ```
> >> > @name: lorem ipsum
> >> >    dolor sit amet
> >> >      consectetur adipiscing elit
> >> > ```
> >> >
> >> > would have its body text be parsed as:
> >>
> >> Suggest "parsed into".
> >>
> >
> > Why? (I mean, I'll do it, but I don't see the semantic difference
> > personally)
> >
>
> "Parse as <language>" vs. "Parse into <representation>".
>
> >> > (first and final newline only for presentation)
> >> >
> >> > ```
> >> > lorem ipsum
> >> > dolor sit amet
> >> >   consectetur adipiscing elit
> >> > ```
> >> >
> >> > We want to preserve the indentation for even the first body line so
> that
> >> > the entire block can be parsed directly as rST. This patch would now
> >> > parse that segment as:
> >>
> >> If you change "parsed as" to "parsed into" above, then do it here, too=
.
> >>
> >> >
> >> > ```
> >> > lorem ipsum
> >> >    dolor sit amet
> >> >      consectetur adipiscing elit
> >> > ```
> >> >
> >> > This is helpful for formatting arguments and features as field lists
> in
> >> > rST, where the new generator will format this information as:
> >> >
> >> > ```
> >> > :arg type name: lorem ipsum
> >> >    dolor sit amet
> >> >      consectetur apidiscing elit
> >> > ```
> >> >
> >> > ...and can be formed by the simple concatenation of the field list
> >> > construct and the body text. The indents help preserve the
> continuation
> >> > of a block-level element, and further allow the use of additional rS=
T
> >> > block-level constructs such as code blocks, lists, and other such
> >> > markup. Avoiding reflowing the text conditionally also helps preserv=
e
> >> > source line context for better rST error reporting from sphinx throu=
gh
> >> > generated source, too.
> >>
> >> What do you mean by "reflowing"?
> >>
> >
> > Poorly phrased, was thinking about emacs too much. I mean munging the
> text
> > post-hoc for the doc generator such that newlines are added or removed =
in
> > the process of re-formatting text to get the proper indentation for the
> new
> > rST form.
> >
> > In prototyping, this got messy very quickly and was difficult to
> correlate
> > source line numbers across the transformation.
> >
> > It was easier to just not munge the text at all instead of munging it a=
nd
> > then un-munging it.
> >
> > (semantic satiation: munge munge munge munge.)
>
> Is this about a possible alternative solution you explored?  Keeping
> .get_doc_indented() as is, and then try to undo its damage?
>

precisamente. That solution was categorically worse.


> [...]
>
>

--0000000000007e6cd9061b53c6e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 20, 2024, 11:07=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:j=
snow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&=
gt; writes:<br>
<br>
&gt; On Wed, Jun 19, 2024, 8:03=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redh=
at.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Change get_doc_indented() to preserve indentation on all subs=
equent text<br>
&gt;&gt; &gt; lines, and create a compatibility dedent() function for qapid=
oc.py to<br>
&gt;&gt; &gt; remove that indentation. This is being done for the benefit o=
f a new<br>
&gt;&gt;<br>
&gt;&gt; Suggest &quot;remove indentation the same way get_doc_indented() d=
id.&quot;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Aight.<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt; qapidoc generator which requires that indentation in argument=
 and<br>
&gt;&gt; &gt; features sections are preserved.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Prior to this patch, a section like this:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt; @name: lorem ipsum<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; would have its body text be parsed as:<br>
&gt;&gt;<br>
&gt;&gt; Suggest &quot;parsed into&quot;.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Why? (I mean, I&#39;ll do it, but I don&#39;t see the semantic differe=
nce<br>
&gt; personally)<br>
&gt;<br>
<br>
&quot;Parse as &lt;language&gt;&quot; vs. &quot;Parse into &lt;representati=
on&gt;&quot;.<br>
<br>
&gt;&gt; &gt; (first and final newline only for presentation)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt; lorem ipsum<br>
&gt;&gt; &gt; dolor sit amet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; We want to preserve the indentation for even the first body l=
ine so that<br>
&gt;&gt; &gt; the entire block can be parsed directly as rST. This patch wo=
uld now<br>
&gt;&gt; &gt; parse that segment as:<br>
&gt;&gt;<br>
&gt;&gt; If you change &quot;parsed as&quot; to &quot;parsed into&quot; abo=
ve, then do it here, too.<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt; lorem ipsum<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This is helpful for formatting arguments and features as fiel=
d lists in<br>
&gt;&gt; &gt; rST, where the new generator will format this information as:=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt; :arg type name: lorem ipsum<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 consectetur apidiscing elit<br>
&gt;&gt; &gt; ```<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ...and can be formed by the simple concatenation of the field=
 list<br>
&gt;&gt; &gt; construct and the body text. The indents help preserve the co=
ntinuation<br>
&gt;&gt; &gt; of a block-level element, and further allow the use of additi=
onal rST<br>
&gt;&gt; &gt; block-level constructs such as code blocks, lists, and other =
such<br>
&gt;&gt; &gt; markup. Avoiding reflowing the text conditionally also helps =
preserve<br>
&gt;&gt; &gt; source line context for better rST error reporting from sphin=
x through<br>
&gt;&gt; &gt; generated source, too.<br>
&gt;&gt;<br>
&gt;&gt; What do you mean by &quot;reflowing&quot;?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Poorly phrased, was thinking about emacs too much. I mean munging the =
text<br>
&gt; post-hoc for the doc generator such that newlines are added or removed=
 in<br>
&gt; the process of re-formatting text to get the proper indentation for th=
e new<br>
&gt; rST form.<br>
&gt;<br>
&gt; In prototyping, this got messy very quickly and was difficult to corre=
late<br>
&gt; source line numbers across the transformation.<br>
&gt;<br>
&gt; It was easier to just not munge the text at all instead of munging it =
and<br>
&gt; then un-munging it.<br>
&gt;<br>
&gt; (semantic satiation: munge munge munge munge.)<br>
<br>
Is this about a possible alternative solution you explored?=C2=A0 Keeping<b=
r>
.get_doc_indented() as is, and then try to undo its damage?<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">precisamente. Th=
at solution was categorically worse.<br></div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000007e6cd9061b53c6e3--



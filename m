Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BBFC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHl7q-0001sE-F9; Thu, 13 Jun 2024 10:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHl7o-0001rp-Mt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sHl7m-0001Ri-Le
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718287700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GflUhjBJ3vugqG+lco5DL6CeTRnjho+pyybikhpHSEw=;
 b=cDND/0hQj6yqa9kahSF/HYahZyHWjuxGa+to927Y/84ycSvQgKVHMXDSObM/TJd4eMxSZV
 ZWGHYGE1Ipb8djKfcIWLGUHl8WiOOnGL84PZ4siuO0tyOWwk9vA7B7z6cO8Engd4a9EerW
 jaFAc80RoNbL6lppu2RWrx/N6OTbkJU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-3iEqGhcNNGu319j8Prh86Q-1; Thu, 13 Jun 2024 10:08:10 -0400
X-MC-Unique: 3iEqGhcNNGu319j8Prh86Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6716094a865so891302a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 07:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718287689; x=1718892489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GflUhjBJ3vugqG+lco5DL6CeTRnjho+pyybikhpHSEw=;
 b=TjkgxEvd+Ib5m0ORZU8C9MId5u6G98qmQymI6lDjtEsgZ38P8xYhtUROwTIG2FDceh
 NlH2H3+rH9JFBTEjVtNiDNr680ugcpA6Ccoaiy1C8StjaO08LtWqvLGB+l6Z4t1ZZ4xY
 2rDHueMTUJBliR0lSUcs64plJAjadvOnGWx7mDbyAv9svZBnY15miVV9azm3wVl54n7O
 5nG/kxHfZ6u0X2+4xYglKiuFAMikJKJZAJ3WPYjih3Bm0l9FaGsN0v/w0P66ybtMaP7K
 kYxt5ohtd19j3crnLqPCEkVhlGJU/gIk7T03xkLRQgYva/blb3c1nXkxJVkknTkE+cDy
 00zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTn5nwP0WrIm7UnIV3RSVqZMXB59E8vmrwEw3B3ibqxgWkdzcftYU9PwTc6oHKj4uVngOZ9PbfaPgSUHg1y5z1gADCjzQ=
X-Gm-Message-State: AOJu0YwuHy3fR7wsFDNlX56r5VyoTph0WLQwAFeguVgSoQkWI93npgL2
 YCOrHLu3XaJtnL3ruoAZo17OQToo6K70juwS+zifyjT7dbvBcybMJiu/XAgvp8h79pH5PaaopDR
 KTeRHmjHkb8HmCXt9DiRtgtjWtv/gR98ZXferapDPVWdv8lIjE+u8FShwtORjUfCgRFlgZ7D2KL
 i1HGrtx0hoG0ZDoRcDrpxYbOJ3d8A=
X-Received: by 2002:a17:902:e808:b0:1f7:3163:831d with SMTP id
 d9443c01a7336-1f83b626324mr59549645ad.14.1718287689293; 
 Thu, 13 Jun 2024 07:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaNap7Rp5ai94Vzed+8oKoX6fevt7GiBKViDN0Xgmz4RyH+FPXm1ctH6xrI96VPywVJdIdDYpCa0Yv2NoksgE=
X-Received: by 2002:a17:902:e808:b0:1f7:3163:831d with SMTP id
 d9443c01a7336-1f83b626324mr59548805ad.14.1718287688531; Thu, 13 Jun 2024
 07:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
 <c826b3dc-2a49-493f-8e6d-efffbfc74f70@linaro.org>
In-Reply-To: <c826b3dc-2a49-493f-8e6d-efffbfc74f70@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Jun 2024 10:07:56 -0400
Message-ID: <CAFn=p-bhiN1ig1t++6FWNc5waYdGvgr_iL3TSHOSUcmwO9GDpA@mail.gmail.com>
Subject: Re: Sample 'qapi-schema-diff' output for v9.0.0 vs origin/master
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004c1c76061ac6077e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000004c1c76061ac6077e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024, 4:50=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@l=
inaro.org>
wrote:

> Hi John,
>

Hi Phil!


> On 12/6/24 20:40, John Snow wrote:
> > Hiya, here's some draft output of a script I'm working on to summarize
> > QMP wire format differences between QEMU versions.
> >
> > This script works in terms of the QMP *wire format*, not the QAPI
> > *specification*. As a consequence, *almost* all type names are stripped
> > from this output and all nested structures are fully inlined - so
> > changes to shared data structures, enums, etc will manifest as many
> > independent changes. Similarly, changes to type names and type
> > factorings that do not change the wire format will not appear in this
> > report at all.
>
> Do you include changes on unstable features or are you skipping them?
>
> Possible feature request: skip them by default until a --unstable
> CLI option is used.
>

In this early draft, I do include such changes. I might want to /opt-in/ to
hiding them (maybe: --hide-unstable), but it can be done.

(A summary mode that hides itemized changes may also be useful for
observing broad-changes-at-a-glance and might be worth adding, too.
--no-detail or --brief or some such.)

I assume we want to hide anything that has the unstable feature flag at the
command *root* and any command or event named with the x- prefix. (unstable
fields on stable commands ... tbd.)

I still need to implement full support for if/features, so this idea can
come along for the ride when I flesh out those details.

(features/if for top-level definitions are recorded, but are likely missing
for various nested fields. The diff output will remark on what changed on
the summary line where it says "(arguments)" or "(arguments, returns)" with
the tokens "if" or "features", but it doesn't break it out into discrete
elements like everything else does, yet - and it still likely only catches
those differences when they occur at the definition root.)


> >
> > This is still a WIP: if conditionals and features may not be fully
> > represented in this summary report.
>
> Regards,
>
> Phil.
>

Thanks for the suggestion!

BTW, I sent a new mail out to the list with a link to gitlab for source and
sample output for this tool and other goodies; the URL is
https://gitlab.com/jsnow/externalized-qapi - see the other mail for details
on what's in here, if curious.

--js

>

--0000000000004c1c76061ac6077e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 13, 2024, 4:50=E2=80=AFAM Philippe Mathieu=
-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hi John,<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Hi Phil!</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
On 12/6/24 20:40, John Snow wrote:<br>
&gt; Hiya, here&#39;s some draft output of a script I&#39;m working on to s=
ummarize <br>
&gt; QMP wire format differences between QEMU versions.<br>
&gt; <br>
&gt; This script works in terms of the QMP *wire format*, not the QAPI <br>
&gt; *specification*. As a consequence, *almost* all type names are strippe=
d <br>
&gt; from this output and all nested structures are fully inlined - so <br>
&gt; changes to shared data structures, enums, etc will manifest as many <b=
r>
&gt; independent changes. Similarly, changes to type names and type <br>
&gt; factorings that do not change the wire format will not appear in this =
<br>
&gt; report at all.<br>
<br>
Do you include changes on unstable features or are you skipping them?<br>
<br>
Possible feature request: skip them by default until a --unstable<br>
CLI option is used.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">In this early draft, I do include such changes. I might =
want to /opt-in/ to hiding them (maybe: --hide-unstable), but it can be don=
e.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">(A summary mode t=
hat hides itemized changes may also be useful for observing broad-changes-a=
t-a-glance and might be worth adding, too. --no-detail or --brief or some s=
uch.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">I assume we want t=
o hide anything that has the unstable feature flag at the command *root* an=
d any command or event named with the x- prefix. (unstable fields on stable=
 commands ... tbd.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">I st=
ill need to implement full support for if/features, so this idea can come a=
long for the ride when I flesh out those details.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">(features/if for top-level definitions are record=
ed, but are likely missing for various nested fields. The diff output will =
remark on what changed on the summary line where it says &quot;(arguments)&=
quot; or &quot;(arguments, returns)&quot; with the tokens &quot;if&quot; or=
 &quot;features&quot;, but it doesn&#39;t break it out into discrete elemen=
ts like everything else does, yet - and it still likely only catches those =
differences when they occur at the definition root.)</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt; <br>
&gt; This is still a WIP: if conditionals and features may not be fully <br=
>
&gt; represented in this summary report.<br>
<br>
Regards,<br>
<br>
Phil.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Thanks for the suggestion!</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">BTW, I sent a new mail out to the list with a link to gitlab for =
source and sample output for this tool and other goodies; the URL is <a hre=
f=3D"https://gitlab.com/jsnow/externalized-qapi">https://gitlab.com/jsnow/e=
xternalized-qapi</a> - see the other mail for details on what&#39;s in here=
, if curious.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--js</div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
</blockquote></div></div></div>

--0000000000004c1c76061ac6077e--



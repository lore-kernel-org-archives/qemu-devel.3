Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86947C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 21:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQBd7-0007yY-NM; Fri, 13 Jun 2025 17:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBd4-0007yG-JG
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 17:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBd1-0000Md-SW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 17:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749848875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r92FoZ6ZCENuevCJqmk7ir4uhkS+Z6unUDCa7or88/s=;
 b=OOkI6FEMU6F25AevOLxcqiLb6Bx2WjAz/cYCCvi47evPyjETsbcwuS9p8/VjexZMfpOULM
 gzL014k4O+9FNW+xzegN+PzD2rcsKmhNmI/ZPjnsWQF68sHCw/O1qqMQlU77aq3CTUMzGH
 JTyM3ToHIUX9Y38BO+8WBIpfMgnAefQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-j94UlNO-MxKqsC5gnLB0Iw-1; Fri, 13 Jun 2025 17:07:53 -0400
X-MC-Unique: j94UlNO-MxKqsC5gnLB0Iw-1
X-Mimecast-MFC-AGG-ID: j94UlNO-MxKqsC5gnLB0Iw_1749848873
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31332dc2b59so2138187a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 14:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749848872; x=1750453672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r92FoZ6ZCENuevCJqmk7ir4uhkS+Z6unUDCa7or88/s=;
 b=NHvQ4okA726KD+OPi/NV4F+VYuuIkiYRxENju7ffuMqk31Xt1BZHV5IpIgmC52u4ak
 kbPVuBgWIZmZ6a4M2+23j6NKOOksxvdk4MwNe60vnMBkrWi4gVY5bjiruqXnufSo6LLh
 nZrvpFN+XlPEstwkURnP5syvQS5LvEuXO+akKn2siegz7okhnMeI858SmNpXnOD2adrj
 hDJkQcvl873SsQCjPI8C5yq0jzsqKilI3VgcFqY8DdXij/8iwjly2zGuFQG7mA/dIbEm
 WaLIH83S7T7trvM2n94fu8/gvLCam+djS4fWutczyGF8u33NQU+EneYUJHP43HuuU7nS
 Vo3Q==
X-Gm-Message-State: AOJu0YwWnJOsWjnlRrbqBAriDtMKatKD2TScAQkEQMEhn5enc4ZM4ajK
 rdTOsnNU2cjEMo2pRAllbhnBgZRjRGvIUt0U3ajl0XFuFS2tKWOF3I2n3oE8a+F5s1FV6a7zwnH
 jeyNTFhmMkmeJHVrGo4bTmCZfI67iLuCK59wPH9HX9J1uPKgwAi4vqO84h3oMkd0xVwEpcjvUTx
 pAdysKY67N0jox3iGBrc9ugCba61NnfV4dQgcOVTPB5SKa
X-Gm-Gg: ASbGnct2FdLWqxrifM4vJf/BiHy7bz69KGmG4BYQwWzucK/SRvlBm+WoiX92Wm9Ncus
 sV13HSmPhk15gDsTtyxoVWoipWqUBi5FE3+IMLM5mWwo90OJ8v3sgxARQh4HUSuTKpAvT6nLZSV
 Y4/qlMQe/uwuEeEexJ2m/rzMVgNnm0P1ybX+o=
X-Received: by 2002:a17:90b:134f:b0:311:e8cc:425d with SMTP id
 98e67ed59e1d1-313f1c00e26mr1634242a91.10.1749848872283; 
 Fri, 13 Jun 2025 14:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKLCimMk8Qo10ih+/c2QWIquiXrVgoL7101y1enx+1RwhXMcr0fgHmbdVSJmPcmsZr1XlBHthIyXWoGZZlNPw=
X-Received: by 2002:a17:90b:134f:b0:311:e8cc:425d with SMTP id
 98e67ed59e1d1-313f1c00e26mr1634207a91.10.1749848871846; Fri, 13 Jun 2025
 14:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
In-Reply-To: <20250523180809.41211-2-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 13 Jun 2025 17:07:40 -0400
X-Gm-Features: AX0GCFvrbBD4cA5l9FuXdgpbNobn-90sduOtXApcr8-652Y-CCz0n1c0Mdzt28Y
Message-ID: <CAFn=p-ZjWxODCxvPu8xAjanq5XX+PueZdYK3tGqZgA8+9Dupcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006aea2806377a7044"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006aea2806377a7044
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 2:08=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> This patch changes the "by type" categorization in favor of using
> sub-categories of a literal "By type" category instead. A new "By
> module" categorization is also added that follows a similar pattern.
>
> Alphabetical sorting has been improved and will sort in a case
> insensitive manner for all categories, now.
>
> Lastly, the "main" QAPI Index (qapi-index.html) is altered to index
> *everything* from all namespaces, adding disambiguation where necessary
> to do so.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
>

...

So, what would we like to keep here and what would we like to scrap? I'm
basically fine either way, I just need to plan for what I'm going to clean
up and submit and what I'm going to scrap. Not against adding a "TODO" for
a later addition or a GSoC/Outreachy project etc either.

I recall that we want the alphabetization fix no matter what, so I will do
that. What about everything else?


Before this patch, what we have currently, is:
https://www.qemu.org/docs/master/qapi-qmp-index.html

> Alternates | Commands | Enums | Events | Modules | Objects | A | ... | Z

Entries in Alternates/Commands/Enums/Events/Modules/Objects are just the
name.
Entries under A..Z have a (type) suffix that clarifies what type of entry
it is.
There is no "global" qapi index, and any definitions that don't get
included in a "namespace" will actually just be dropped.

After this patch, the top level categories we have are:

>  By module | By type | A | ... | Z

with "By module" having collapsible sections for each module, with entries
that use the (type) suffix.
and "By type" split into collapsible subsections for
Alternate/Command/Enum/Event/Module/Object, entries have no suffix.
The alphabetical entries cover absolutely everything and use the "(type)"
suffix.

The other major change creates a "global QAPI" index, which I only really
created for the sake of completionism, just in case you really wanted to
know every last thing about QMP that we offer all in one place.

- By module, with subcategories being named "module, namespace" instead of
just "module". Individual entries are suffixed with "(type)".
- By type, subcategories have no suffix, but individual entries have a
"(namespace)" suffix.
- Alphabetical entries use a "(type, namespace)" suffix.

One thing I'll volunteer that I don't actually like is that there's no way
to hyperlink specifically to the list of commands/events in particular,
though I do kind of like that the subsections are collapsible and I like
that two-tier organization.

I am not currently aware of any mechanisms to help make the indices
fancier, and probably cannot afford to spend time investigating it further.

Is consensus to just apply the alphabetization fix by itself and leave it
at that for now?

--js

--0000000000006aea2806377a7044
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 23,=
 2025 at 2:08=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">=
jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">This patch changes the &quot;by type&quot; categorization i=
n favor of using<br>
sub-categories of a literal &quot;By type&quot; category instead. A new &qu=
ot;By<br>
module&quot; categorization is also added that follows a similar pattern.<b=
r>
<br>
Alphabetical sorting has been improved and will sort in a case<br>
insensitive manner for all categories, now.<br>
<br>
Lastly, the &quot;main&quot; QAPI Index (qapi-index.html) is altered to ind=
ex<br>
*everything* from all namespaces, adding disambiguation where necessary<br>
to do so.<br>
<br>
Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"=
_blank">jsnow@redhat.com</a>&gt;<br></blockquote><div><br></div><div>...</d=
iv><div><br></div><div>So, what would we like to keep here and what would w=
e like to scrap? I&#39;m basically fine either way, I just need to plan for=
 what I&#39;m going to clean up and submit and what I&#39;m going to scrap.=
 Not against adding a &quot;TODO&quot; for a later addition or a GSoC/Outre=
achy project etc either.<br></div><div><br></div><div>I recall that we want=
 the alphabetization fix no matter what, so I will do that. What about ever=
ything else?</div><div><br></div><div><br></div><div>Before this patch, wha=
t we have currently, is: <a href=3D"https://www.qemu.org/docs/master/qapi-q=
mp-index.html">https://www.qemu.org/docs/master/qapi-qmp-index.html</a></di=
v><div><br></div><div>&gt; Alternates | Commands | Enums | Events | Modules=
 | Objects | A | ... | Z <br></div><div><br></div><div>Entries in Alternate=
s/Commands/Enums/Events/Modules/Objects are just the name.</div><div>Entrie=
s under A..Z have a (type) suffix that clarifies what type of entry it is.<=
/div><div>There is no &quot;global&quot; qapi index, and any definitions th=
at don&#39;t get included in a &quot;namespace&quot; will actually just be =
dropped.</div><div><br></div><div>After this patch, the top level categorie=
s we have are:</div><div><br></div><div>&gt;=C2=A0 By module | By type | A =
| ... | Z <br></div><div><br></div><div>with &quot;By module&quot; having c=
ollapsible sections for each module, with entries that use the (type) suffi=
x.</div><div>and &quot;By type&quot; split into collapsible subsections for=
 Alternate/Command/Enum/Event/Module/Object, entries have no suffix.</div><=
div>The alphabetical entries cover absolutely everything and use the &quot;=
(type)&quot; suffix.</div></div><div class=3D"gmail_quote gmail_quote_conta=
iner"><br></div><div class=3D"gmail_quote gmail_quote_container">The other =
major change creates a &quot;global QAPI&quot; index, which I only really c=
reated for the sake of completionism, just in case you really wanted to kno=
w every last thing about QMP that we offer all in one place.</div><div clas=
s=3D"gmail_quote gmail_quote_container"><br></div><div class=3D"gmail_quote=
 gmail_quote_container">- By module, with subcategories being named &quot;m=
odule, namespace&quot; instead of just &quot;module&quot;. Individual entri=
es are suffixed with &quot;(type)&quot;.</div><div class=3D"gmail_quote gma=
il_quote_container">- By type, subcategories have no suffix, but individual=
 entries have a &quot;(namespace)&quot; suffix.</div><div class=3D"gmail_qu=
ote gmail_quote_container">- Alphabetical entries use a &quot;(type, namesp=
ace)&quot; suffix.</div><div class=3D"gmail_quote gmail_quote_container"><b=
r></div><div class=3D"gmail_quote gmail_quote_container">One thing I&#39;ll=
 volunteer that I don&#39;t actually like is that there&#39;s no way to hyp=
erlink specifically to the list of commands/events in particular, though I =
do kind of like that the subsections are collapsible and I like that two-ti=
er organization.</div><div class=3D"gmail_quote gmail_quote_container"><br>=
</div><div class=3D"gmail_quote gmail_quote_container">I am not currently a=
ware of any mechanisms to help make the indices fancier, and probably canno=
t afford to spend time investigating it further.</div><div class=3D"gmail_q=
uote gmail_quote_container"><br></div><div class=3D"gmail_quote gmail_quote=
_container">Is consensus to just apply the alphabetization fix by itself an=
d leave it at that for now?</div><div class=3D"gmail_quote gmail_quote_cont=
ainer"><br></div><div class=3D"gmail_quote gmail_quote_container">--js</div=
></div>

--0000000000006aea2806377a7044--



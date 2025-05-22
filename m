Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B700C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBKy-0003Qr-Ap; Thu, 22 May 2025 15:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBKq-0003Po-If
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBKm-0007Wd-JX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747941123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pko78+Uk6F70uJ2LWHD9NqI2yujQ83ekpm+7PZ61Yn4=;
 b=Qsp4787VSso9DaZVdpVsF5+gVr2n1o7iVzlpTmu4n2KqUKFj7CLmAH5fZXTuE/5YfxVJhI
 9J4NzVzm9VG4rKPKPUd4NLLuYgb7DhbzLh8nYHS0Rlhs0gBsWwc/ynAz6g5Qgd/lk8MMNP
 259XMSHjDRX850MPTnrVNyWoX3YjFFU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-cKqcuuH8OYWFrtT8B16wbQ-1; Thu, 22 May 2025 15:12:01 -0400
X-MC-Unique: cKqcuuH8OYWFrtT8B16wbQ-1
X-Mimecast-MFC-AGG-ID: cKqcuuH8OYWFrtT8B16wbQ_1747941120
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2322e8c4dc5so49576365ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747941120; x=1748545920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pko78+Uk6F70uJ2LWHD9NqI2yujQ83ekpm+7PZ61Yn4=;
 b=ZhGmagZmz2TNmWDlAgE6BX5lU9k8HGsb3n/u6A92aT8j8UqsKIICC5MdUaVCjPjI39
 IVEg1P/2FRPumQQbku2c/H/1F+NpltsxY6ITEoQ3ulI6El3b5kuWVhUivuHvW+f8omPY
 a5o9wagra/t8rmg/K/XpP+xS7etpXb+tw9sEZ+ouSqy2dWghhu5ZermFWOIfJ8n0/WAS
 kpBbRDRcCbSLQ1K6EfNWlHMw2pIBnEtAFtY0ucTldQgIxKq07zm0uc3+1Xnb6b8OtWH5
 zcaYykWNFUed4trvKnbM8q16hjZdGwtGBWeAytzuXSB/ps0umJ9/vWodpGnoXBloUacx
 rAqw==
X-Gm-Message-State: AOJu0YyNjYJOr1AyKxVbIrtuY/RP6RImz+e+wOVTfSe2cHcXxyn/bwgD
 cDCoMQr/pBs4UZjnJH0keS1VG3EqF/pYNrvbY15VHEBKmDbygo/UC+cZNho6uo+K2PSB2dscfTC
 hkjf4XbEdoobezhVvLp+ZcDPeweJqscww5vwdL3Vz0IDSzTLstbfNShvnRmEqGxcy3LxwDJ3/El
 QrdJamGKYdayfE+MmqymnkLArj0KjT6QM=
X-Gm-Gg: ASbGnct0m/leSiUyH8GA9lp6s5DvdLpfP+Kn2o4+ymS8qnUuwq/TRko3yIgJSqVbLMc
 nrNYkMglJN4io5pavkCkBeSU8UzjDW7CsglXjJMB53QcFjLr555AVEKaA9+JfSDiijVAraX76wd
 B3jx0EUCOQyH58HixVv/4asZf6
X-Received: by 2002:a17:902:ea01:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-231d43bb574mr376387805ad.21.1747941120409; 
 Thu, 22 May 2025 12:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEOLvmOyI+P6ndjI7COgmCAgOASIgPO3ZxZGmzpXBaxnPArDvafMYn4ufS6qD26/CSKHojBlWHStqCz4Nr/s=
X-Received: by 2002:a17:902:ea01:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-231d43bb574mr376387475ad.21.1747941120116; Thu, 22 May 2025
 12:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-5-jsnow@redhat.com>
 <87wmabab0n.fsf@pond.sub.org>
In-Reply-To: <87wmabab0n.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 May 2025 15:11:48 -0400
X-Gm-Features: AX0GCFtaMg8peqAtun1naFei8vDjv42SiPOkcB8p-DW0QwrxMIpSbdGylFs3Lzc
Message-ID: <CAFn=p-b899jvLSfr0q3ZLo3EsChzbM6OnJS1YWoOjSnjVqRipw@mail.gmail.com>
Subject: Re: [PATCH 4/8] python: use 3.9+ builtin type hints
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Maksim Davydov <davydov-max@yandex-team.ru>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008db3590635be41ce"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008db3590635be41ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:26=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch changes type hints that have built-in equivalents as of
> > Python 3.9. The versions we currently use, imported from the typing
> > module, have been deprecated since 3.9 and may be removed at any time -
> > though to my knowledge, they are not scheduled for removal in 3.14.
> >
> > The type hints to update are:
> >
> > typing.Dict  =3D> dict
> > typing.List  =3D> list
> > typing.Tuple =3D> tuple
> > typing.Set   =3D> set
> > typing.Type  =3D> type
> >
> > I performed this change the dumb way (I couldn't work out for the life
> > of me how to beg ls-files to exclude subprojects and empty directories,
> > desipte it having an option which claims to do precisely that. Suggest =
a
> > nicer way to do this if you'd like.)
> >
> > git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v
> 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Dict\[/dict\[/g'
> > git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v
> 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/List\[/list\[/g'
> > git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v
> 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Tuple\[/tuple\[/g'
> > git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v
> 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Set\[/set\[/g'
> > git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v
> 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Type\[/type\[/g'
> >
> > I then used "git add -p" and excluded changes by hand that weren't
> > appropriate. I then reviewed all of the changed files by hand to review
> > the imports and update them accordingly.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> I'd expect to catch mistakes in the manual parts.  I gave scripts/qapi/
> an eye-over anyway, and it looks good to me.
>

I've prepared an alternate series that's vastly more automated, using
"pyupgrade", "autoflake", and isort. As a downside it touches a lot more
than just the type hints, removing other outdated pythonisms. As an upside
it's way, way less manual.


>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
>

--0000000000008db3590635be41ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 20,=
 2025 at 5:26=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch changes type hints that have built-in equivalents as of<br>
&gt; Python 3.9. The versions we currently use, imported from the typing<br=
>
&gt; module, have been deprecated since 3.9 and may be removed at any time =
-<br>
&gt; though to my knowledge, they are not scheduled for removal in 3.14.<br=
>
&gt;<br>
&gt; The type hints to update are:<br>
&gt;<br>
&gt; typing.Dict=C2=A0 =3D&gt; dict<br>
&gt; typing.List=C2=A0 =3D&gt; list<br>
&gt; typing.Tuple =3D&gt; tuple<br>
&gt; typing.Set=C2=A0 =C2=A0=3D&gt; set<br>
&gt; typing.Type=C2=A0 =3D&gt; type<br>
&gt;<br>
&gt; I performed this change the dumb way (I couldn&#39;t work out for the =
life<br>
&gt; of me how to beg ls-files to exclude subprojects and empty directories=
,<br>
&gt; desipte it having an option which claims to do precisely that. Suggest=
 a<br>
&gt; nicer way to do this if you&#39;d like.)<br>
&gt;<br>
&gt; git ls-files | grep -v &#39;roms/&#39; | grep -v &#39;subprojects/&#39=
; | grep -v &#39;tests/lcitool/libvirt-ci&#39; | xargs sed -i -e &#39;s/Dic=
t\[/dict\[/g&#39;<br>
&gt; git ls-files | grep -v &#39;roms/&#39; | grep -v &#39;subprojects/&#39=
; | grep -v &#39;tests/lcitool/libvirt-ci&#39; | xargs sed -i -e &#39;s/Lis=
t\[/list\[/g&#39;<br>
&gt; git ls-files | grep -v &#39;roms/&#39; | grep -v &#39;subprojects/&#39=
; | grep -v &#39;tests/lcitool/libvirt-ci&#39; | xargs sed -i -e &#39;s/Tup=
le\[/tuple\[/g&#39;<br>
&gt; git ls-files | grep -v &#39;roms/&#39; | grep -v &#39;subprojects/&#39=
; | grep -v &#39;tests/lcitool/libvirt-ci&#39; | xargs sed -i -e &#39;s/Set=
\[/set\[/g&#39;<br>
&gt; git ls-files | grep -v &#39;roms/&#39; | grep -v &#39;subprojects/&#39=
; | grep -v &#39;tests/lcitool/libvirt-ci&#39; | xargs sed -i -e &#39;s/Typ=
e\[/type\[/g&#39;<br>
&gt;<br>
&gt; I then used &quot;git add -p&quot; and excluded changes by hand that w=
eren&#39;t<br>
&gt; appropriate. I then reviewed all of the changed files by hand to revie=
w<br>
&gt; the imports and update them accordingly.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
I&#39;d expect to catch mistakes in the manual parts.=C2=A0 I gave scripts/=
qapi/<br>
an eye-over anyway, and it looks good to me.<br></blockquote><div><br></div=
><div>I&#39;ve prepared an alternate series that&#39;s vastly more automate=
d, using &quot;pyupgrade&quot;, &quot;autoflake&quot;, and isort. As a down=
side it touches a lot more than just the type hints, removing other outdate=
d pythonisms. As an upside it&#39;s way, way less manual.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000008db3590635be41ce--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21D9C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 19:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP544-0003Yk-Lp; Tue, 10 Jun 2025 15:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uP53z-0003Xw-KQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 15:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uP53w-0006gF-B9
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 15:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749585310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0AsNVd3r8bR5sfrE+Z/gArVjUFQXbK1PJd9Nm/M3vE=;
 b=Ps00r67e2pHGBnKxQO8wGvzkxnTcnpNzX35K74ZS+nUmatU9u3KWoRgIVom/MM1PKI81yl
 zb8LH7WEIr61r2etprA396bje5yQ9CMMsMZl2pEunv7M7gg3ewm7+GJks3lwYbuX3Hx3dz
 OveesIb7++bCVNwDJtqXmgVf0eHISVQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-zH5vyYS8Mzuyf7uamcMMmg-1; Tue, 10 Jun 2025 15:55:08 -0400
X-MC-Unique: zH5vyYS8Mzuyf7uamcMMmg-1
X-Mimecast-MFC-AGG-ID: zH5vyYS8Mzuyf7uamcMMmg_1749585308
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31332dc2b59so5278907a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 12:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749585307; x=1750190107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0AsNVd3r8bR5sfrE+Z/gArVjUFQXbK1PJd9Nm/M3vE=;
 b=eVMsv0JZ91+yHeo9xZLgYsTLcsC/zrzD1RpcqVzRYEsfjg/27gNK/Cdmnn4QtsUVTb
 ps7pnVs1wwQZhYB23V15kLWVylactgY+kmEfTtunrBwgoFrpHo+3MJgd2wH5BHS4oajR
 GHwnMi+UFJw2Zl080BR/aBlWEFHrxpGSfUudZagEV24tfqkO8xpUKhQ2Rwos96R6+Yo1
 wqi4/WRjRcALOuF7w34Ptz5VZmnNo5YVDy5kkdvbrelBsU6ghmXzKDXY6zmhizd93hYX
 MoioDrarWyuzsA+7MgDssCc+K0nUyqeuNw4VKwN68E6F1LlDs2t6MELyNHfVwH+wrIDX
 iX5g==
X-Gm-Message-State: AOJu0YwFdhOtcD3a7htJNxoAsppysiUipvNjMOqSa8UI4aBS+6rh0qX+
 C0bCl4SlntU01hUp7HFWyO7XfrfNbbMXZd7U8vWLT7VpGx07zDkkHThKxwxiWxHXWVz0wYmc/aB
 OCYxJZ0LxSkWPYVvT58b1bP71X3pNV2tronDDMuvBXdxiw1xxWsEDcsezU1rLGbVIsitfS2UGid
 JNfdFmXTk9ikeMdALjGz4VwJ0a0Ttzpuw=
X-Gm-Gg: ASbGnctO0NOUOqTjKgN62lnREsbpAYoWVwiLMWWrvkGamPbxEG2LFenHB6YeTdyI0Fw
 Y7FAt1HmWTRnEDMry/rzqk7DVaII8swFZyaHrYXsJ4hygMTeseiOOwSlGN+vHGNSZouSj7Yq4/g
 yiSmnxnA9uHRbvBAzYoq0EPuSPMeVmG7yi3HY=
X-Received: by 2002:a17:90b:224f:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-313af11cbbfmr1242154a91.13.1749585307080; 
 Tue, 10 Jun 2025 12:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmdvgYi5xV9Sv1Wx/iF0lAufl7h4kodi4oetjVi51g0+WjZdv4HUO4L8IYEqnM6uW/itCWX9dbWmymPfQRQZ8=
X-Received: by 2002:a17:90b:224f:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-313af11cbbfmr1242114a91.13.1749585306625; Tue, 10 Jun 2025
 12:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1742401551.git.pkrempa@redhat.com>
 <aEgnsqTpcX0Fp3vx@angien.pipo.sk>
In-Reply-To: <aEgnsqTpcX0Fp3vx@angien.pipo.sk>
From: John Snow <jsnow@redhat.com>
Date: Tue, 10 Jun 2025 15:54:54 -0400
X-Gm-Features: AX0GCFuer1K6fFnuIdHDggDjmf92pAkItP4nlncJx0mbBOAngf_e2Pj2WzJCxpA
Message-ID: <CAFn=p-aYMQb-StChaph_m-2qXY_1AW4PTx_ZkAOE1bTLchq=Hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] scripts: render_block_graph: Fix with new python
 and improve argument parsing
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Pavel Hrdina <phrdina@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b5173606373d1213"
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

--000000000000b5173606373d1213
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:40=E2=80=AFAM Peter Krempa <pkrempa@redhat.com> w=
rote:

> On Wed, Mar 19, 2025 at 17:28:06 +0100, Peter Krempa wrote:
> > New python doesn't like '\l' escapes from the 'dot' language.
> >
> > While at it improve usability of the script by employing proper argumen=
t
> > parsing.
> >
> > v2:
> >  - use mutually exclusive group instead of hardcoding it (Pavel)
> >
> > Peter Krempa (3):
> >   scripts: render_block_graph: Fix invalid escape sequence warning with
> >     python 3.12
> >   scripts: render_block_graph: Implement proper argument parser
> >   scripts: render_block_graph: Avoid backtrace on error from virsh
>
> Ping :)


Ah darn, guess that's me.

Tempted to just say "LGTM!" but lemme give it the once over here ... If you
don't hear back within a day or two just ping my email box directly to nag
me, please-and-thank-you.

--js

--000000000000b5173606373d1213
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 10,=
 2025 at 8:40=E2=80=AFAM Peter Krempa &lt;<a href=3D"mailto:pkrempa@redhat.=
com">pkrempa@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Wed, Mar 19, 2025 at 17:28:06 +0100, Peter Krempa=
 wrote:<br>
&gt; New python doesn&#39;t like &#39;\l&#39; escapes from the &#39;dot&#39=
; language.<br>
&gt; <br>
&gt; While at it improve usability of the script by employing proper argume=
nt<br>
&gt; parsing.<br>
&gt; <br>
&gt; v2:<br>
&gt;=C2=A0 - use mutually exclusive group instead of hardcoding it (Pavel)<=
br>
&gt; <br>
&gt; Peter Krempa (3):<br>
&gt;=C2=A0 =C2=A0scripts: render_block_graph: Fix invalid escape sequence w=
arning with<br>
&gt;=C2=A0 =C2=A0 =C2=A0python 3.12<br>
&gt;=C2=A0 =C2=A0scripts: render_block_graph: Implement proper argument par=
ser<br>
&gt;=C2=A0 =C2=A0scripts: render_block_graph: Avoid backtrace on error from=
 virsh<br>
<br>
Ping :)</blockquote><div><br></div><div>Ah darn, guess that&#39;s me.</div>=
<div><br></div><div>Tempted to just say &quot;LGTM!&quot; but lemme give it=
 the once over here ... If you don&#39;t hear back within a day or two just=
 ping my email box directly to nag me, please-and-thank-you.</div><div><br>=
</div><div>--js</div></div></div>

--000000000000b5173606373d1213--



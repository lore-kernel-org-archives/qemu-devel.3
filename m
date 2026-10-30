Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ibJoCa6L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpdR-00084F-7X; Fri, 30 Oct 2026 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulsheer@gmail.com>)
 id 1xMpdN-00083x-GW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:39:17 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paulsheer@gmail.com>)
 id 1xMpdL-00012g-Sg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:39:17 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-91c162febb9so9769306d6.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793378354; cv=none;
 d=google.com; s=arc-20260327;
 b=ko6GuEYEH3AwYoi0G5/qtXQBsSiqu/Wx0UT3PDBsNiOqp7/RtHR2WoOMAPFvJ+PJ/T
 MQElFOgIOtM75exsDXuUCUDVvOTG349MtEWcN/oOD0TnYdoStU0tuNqjdmp8FhGgBs2h
 zJGhH+pOV4cpKulZShjLT/v6v5BRYh01ImPKs4mWC4aya9IPCoSMwyocGhX7ue4osA4t
 RhdONrxXFaNXzR51iQXc5EgbbHW27Lycih7EP+8Q7FybtgNy7Z6yJ+RFtGoQwHa9SImf
 vvbWvDve9Vf1JWfBOmQPh4fTnOP+W8PzMC9obV9n81GlUlcXgO8og7v469jm+880oLMu
 zYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=Cjq1ZoLmw2xrFNoGkVnArGDx/IYBh01nAx9oDAFqDLY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=ikOouf67QlSAXJu+G9L3yELe/szEBHnfcA4ZC70Hx3VRJPFmHBbKLiHu6ZmvlwjMIn
 whHirWRvCkMThvV3uLUxrtK5FPFi2MdvRNisvXH0yI7iM57WoIw/XuV+qmLyPtFDIiSt
 ZNhNq+PabCawzonr4uEqduusNi11jQ6QPp5UAcrAVCJxq9ubuX/WgH4gTrXquAwnYE4c
 QXWS/g2vXY9kcCZVtKaK1EMW4Nnija1MTnfCPIY38sxO4aynNioGHAQL9FO80MJ3uqk6
 3nKDSJTg24lLctUNp4o6IzUOLK3/wx9+dKMBj4LleWsZxYbpDjk/yR7tbwfJneAa3hei
 qKPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793378354; x=1793983154; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cjq1ZoLmw2xrFNoGkVnArGDx/IYBh01nAx9oDAFqDLY=;
 b=ibJoCa6LD12gWL+MyXUtZSD/tFrfYsMlAog1oX0LsKpFP2yPFQGyavG/EjfK06iKbP
 uuYuTMgIUUf7XCmpvtzgAuSn6C12yvFt+ihymjFWgP1sWTOixRJP64dreyhYhdRCOC+3
 Ke42oikTJ4U9rKhRaZeDjRzeCr5CEDZAwmZsusvjt1e3aGtayOSTfkluyhoWprtrI7AO
 Bmrrvyk0SkUkPHkdlyIJPsyo3e3ZOtXxQdE92gJ3wuJvhwDtfsWsvuzBD1ObNh5E47U1
 HBeqLlaw2brbFogoXxRs6vZvwaX4ogV6SMv60fa2eTnOvFVZ5S5uUZmw2+Ma+op/aPFN
 GBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378354; x=1793983154;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cjq1ZoLmw2xrFNoGkVnArGDx/IYBh01nAx9oDAFqDLY=;
 b=YdrOatvKCyQJmxz5EeaQA4Y1JThZdBFamA3ZTGdLocSmmRaql8zbm8gaeyxAMef2Du
 /51i/NxwhxsLfep3G18GrdxnEiB/nQbSlzUBgPsolYBcv0agc1KXStlf/+kbQPke+cRu
 C82QVBKJ22AVQOkO0T6AkQahmtoefsdAKRcANGxUU5UcGtfp+PmVjOxxsb7RBnA2Ph+T
 S+z8XAyoKnbihOJjo1lLJYrNkipOimRIfhchvDPk1XMzKDsRkFS1AvNoVRwxOXPCNxBn
 Widp8wnqNDGpROA4Do00eDZAaBNGn+FC9KMFGZowSH0a/+ZcZjsPGlAFUR2uHIPCi6H3
 Liug==
X-Gm-Message-State: AFq9FYLtlB1ZM/V3LNafjm+9/VMAPkQ+SXtUTIS47mIz7/8gvnZ0Tw5l
 btLG10wQMPPaGxUkNSZ39/xUT1Cr8ozpAA29VpLE3OElGWvDurqW0QDfXg7n6gRRT1lgH/tHd4X
 +rKXclcZYtTWcDDdEpj0Klb+R/Oj20b+XVz+/qV4=
X-Gm-Gg: AYBFou31Iz7AUWjhzi7yXsdHweYJo+jHGM5YYDzCRV8NkpcqzQHWf0sZ6+dpju2n/Mz
 Xut+Ti3sDPUIFkPngnwgY2EovDyh9T15/eY1g4NcgesXHyu0qDo4R4pbX0vqki90Mmzu0DXqqY0
 779FadaYJTSZdfCudldMkkYeRCezRlBO4+fMTdbgO62dyz2DcIGWbmU9W/GRwnef+44EqoaLO8B
 Myrt6QS0lhZ/DJk7kvvRmdAabXk8KwGtOu4M/TX/OXbR8oXYIbhFTgAAxtOSlfAHFC38+yFaILo
 HVDleimJ1DoUmnjkoGbqrczuHLR5H0xS3AMitk3Y6V8/ypVo/cDGGsg3Ha+xS+Qs2XSWEaeKN/b
 uvH5qI/uqvbFnSO5Vz3VRANqCvyDeHeSleM18N3cCTtlzbYbeBoVQbSYHc6SuwoK3Alc=
X-Received: by 2002:a05:6214:194e:b0:91c:9db1:f640 with SMTP id
 6a1803df08f44-91ca4ad2ec7mr46253266d6.18.1793378354190; Fri, 30 Oct 2026
 09:39:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CABxOuY-6JxS1+HcR0t-yteY2+S7saB8ogjxkqa7bedwKu2Xw+Q@mail.gmail.com>
In-Reply-To: <CABxOuY-6JxS1+HcR0t-yteY2+S7saB8ogjxkqa7bedwKu2Xw+Q@mail.gmail.com>
From: Paul Sheer <paulsheer@gmail.com>
Date: Fri, 30 Oct 2026 11:38:57 -0500
X-Gm-Features: AclHuK-oGkhrRMDa6ctWujZmxq9dAlSdU7Jclv5JRu1Sz3UXeIESTcw0YKFS4cs
Message-ID: <CABxOuY8+YibOXCTTkcAQKHLVsTP_1twb0tNxmRss_Se56=amiw@mail.gmail.com>
Subject: Re: Solaris 10 on SPARC 64 running, but not stable
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bfe05b065f116f20"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=paulsheer@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000bfe05b065f116f20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update:

I put my changes in these two forked repos:

  https://github.com/paulsheer/qemu/
  https://github.com/paulsheer/openbios/

I don't have more time to try get this stable, so I will be unsubscribing.

Happy to answer any questions on my private email.

Paul



On Mon, Oct 26, 2026 at 12:25=E2=80=AFAM Paul Sheer <paulsheer@gmail.com> w=
rote:

>
> Hello,
>
> I dumped the entire disk of a real Solaris 10 V210/V240 box into a qcow2
> image on Linux,
> and then tried to boot it with qemu.
>
> The list of patches/fixes I needed to apply is very long --- beside a
> bunch of code changes, there is also changing from SCSI to IDE and from
> hme0 to e1000, getting the device mappings to work, and so on.
>
> It finally boots all the way through and starts its services and I can ss=
h
> into it.
>
> However it doesn't seem to be stable. Within an hour it silently stops.
>
> Is anyone interested in this kind of work?
>
> Has anyone got this to run stable and under load?
>
> [[The only reason I keep this V210 around is to occasionally test some
> software big-endian (not that easy these days with big-end boxes
> disappearing =F0=9F=98=82). But I panicked when I had to replace the moth=
erboard
> last week "...what if this box one-day becomes unrepairable?" -- hence my
> experimenting with qemu.]]
>
> If anyone is interested then contact me directly on paulsheer@gmail.com
> and I will share all the changes I made.
>
> Kind regards,
>
> Paul
>
>
>
>

--000000000000bfe05b065f116f20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Update:</div><div><br></di=
v><div>I put my changes in these two forked repos:</div><div><br></div><div=
>=C2=A0 <a href=3D"https://github.com/paulsheer/qemu/">https://github.com/p=
aulsheer/qemu/</a></div><div>=C2=A0 <a href=3D"https://github.com/paulsheer=
/openbios/">https://github.com/paulsheer/openbios/</a></div><div><br></div>=
<div>I don&#39;t have more time to try get this stable, so I will be unsubs=
cribing.</div><div><br></div><div>Happy to answer any questions on my priva=
te email.</div><div><br>Paul</div><div><br></div><div><br></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Mon, Oct 26, 2026 at 12:25=E2=80=AFAM Paul Sheer &lt;<a href=3D"mai=
lto:paulsheer@gmail.com">paulsheer@gmail.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br></div=
>Hello,<div><br><div>I dumped the entire disk of a real Solaris 10 V210/V24=
0 box into a qcow2 image on Linux,</div><div>and then tried to boot it with=
 qemu.</div><div><br></div><div>The list of patches/fixes I needed to apply=
 is very long --- beside a bunch of code changes, there is also changing fr=
om SCSI to IDE and from hme0 to e1000, getting the device mappings to work,=
 and so on.</div><div><br></div><div>It finally boots all the way through a=
nd starts its services and I can ssh into it.</div><div><br></div><div>Howe=
ver it doesn&#39;t seem to be stable. Within an hour it silently stops.</di=
v><div><br></div><div>Is anyone interested in this kind of work?</div><div>=
<br></div><div>Has anyone got this to run stable and under load?</div><div>=
<br></div><div>[[The only reason I keep this=C2=A0<span style=3D"background=
-color:transparent">V210 around is to occasionally test some software big-e=
ndian (not that easy these days with big-end boxes disappearing=C2=A0</span=
>=F0=9F=98=82<span style=3D"background-color:transparent">). But I panicked=
 when I had to replace the motherboard last week &quot;...what if this box =
one-day becomes unrepairable?&quot; -- hence my experimenting with qemu.]]<=
/span></div><div><br></div><div>If anyone is interested then contact me dir=
ectly on <a href=3D"mailto:paulsheer@gmail.com" target=3D"_blank">paulsheer=
@gmail.com</a> and I will share all the changes I made.</div></div><div><br=
></div><div>Kind regards,</div><div><br></div><div>Paul</div><div><br></div=
><div><br></div><div><br></div></div>
</blockquote></div></div>

--000000000000bfe05b065f116f20--


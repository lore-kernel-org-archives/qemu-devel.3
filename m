Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E06CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 06:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXCjO-0005lw-H7; Wed, 10 Jun 2026 02:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wXCjG-0005hm-QF
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 02:48:00 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1wXCjE-0005ED-Ce
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 02:47:58 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DD5703F5D9
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 06:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781074071;
 bh=8QNbzDsmnFsRRByiGf+rqSIg7zfBrNgyf006BzQFddA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=hsrb5QEyTZbIrCUv49ygehHe/ewUoAiEfN7Im4YAbplFm15LtUU25ZaQ/3apmwVRr
 ui63a9+doaAE9t4unPrRC6Et3/0AKTKggZlFII1PYpM6rLkIIYouiI+M9SBIz2KDnF
 qY3fLklyR3ZBLfohyeJbQ8XCAQZEamw9FdfQIboOwunzzr8HpMKJYHEcSnQ3JGhAcj
 VDsiqnp9GtKSfVG204uIDgA9RtXT2VXX7VeMfYGbM5D3BwcFysy2yqOGl4mgYaPIIV
 pGhi64MJk+2DBATycSUc4q0OAJEVDAHGOXOd6p209j7Z2ztlEXnFsobc8jmXTtgSWs
 cFrXr1dIIP3WSW4Tjh5wKCO8v5CS+CMDrm/Hqni2MO04rhtXa0OpzGXRwVIMw5VuwD
 Lsjmi8I/JIHcti6EZ7+ljAVZjZHHZjDFw8743KnVRnxznvTBfW0zdY+7ozN77J1l7J
 5MhUuNzW861xMfOlzuQ9X8U2u6L5d8q54+86Gxo0d9O0eebHsyF2ORaZ0gRR9wpT6I
 ISipmACbUFfxtmoNIuMdNObI1aiP8f87rZtGW4Bd2QUKz68rm1VTSJYEzkMSBv53W4
 5DECCleN2yG8/4gV90suqJ0ugBRDI5MHxkKP63KsvLo6yt6qGN9hiQ69G9Jf0QejHt
 2kPzPfDWkMO5/t5vBlcQ6Q4I=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf9easo8084029a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 23:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781074071; cv=none;
 d=google.com; s=arc-20240605;
 b=dSpyNQxHuxLwpNTfUVj+sa/8GHRYx+r8n/Kjc2M9eGLl4C7do8x4aO/rN4xMVyjusg
 0gae63Z5XrAAd3o5IEFIzQE8DaqvtL2R4maxwmdH6sh2nwNzy5I+ouOx4hqnrLfKE7UT
 yCKRYh16XClZzSFURhfp3ycKQcxLyLRMK7KetXJSX2oATmOC1OYC/JBKagI8fIsmRB7j
 XtJNB9sCfhA8ijo2k4QMtD1ulmXGiou7Ulh9+xk9BYMTALoz2Boh6mA9CIgOS1incIX6
 QzCxguMmGUtUImux99x1NhsxrxS0u1hhYS5b7IW/GHMFHKN3oWi30mDBavqcXa1zfNYI
 veQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=8QNbzDsmnFsRRByiGf+rqSIg7zfBrNgyf006BzQFddA=;
 fh=FKG9/4s0xvi/kTiJ+iuTqU9JOO/MJTqselBsPiSF+sE=;
 b=Y0ZRhpX9GwniM1cnfEgbDqR5xthSa3BVueDvaskYYN5Yt/n7I3aeFXkZwhE9ZEMSVe
 mdWXklYWSfo7594XOul3zGDh3qiGoiLaBHXsKnO3tNb9O46ciplcp8wQgXTR66WscR0o
 3AQsbjxRRYy0Q8+bAWGW6VzxG/Fwg9PhqEz9qKlcf7jI+IBWodDd8Shcu0pC5ToX70wk
 E9EZB2QzMcA2vNYdJTiPb+1qThO194dq8JbdGXx2o/J4edkiVDPuCsn4GHNL8y0GIjbB
 3DRi8aWsrwmpD70RhEJKp6smXSPDTHn/SDQsNUhPkZ90QU0j8JnsAO53h3+KqNVQ01bK
 l9Sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781074071; x=1781678871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QNbzDsmnFsRRByiGf+rqSIg7zfBrNgyf006BzQFddA=;
 b=b+nXBl1qu5YzQvl9ngd2mM7LXblvTPc7+cA+9SpbUE/Dqc1Kmxy08WN9PzqTkm6uJi
 UOci8vXRC+LysuT91+u4tcptzQgv/WtBel2BDrhD0QtcyfABczArMS3qs2fRDYZRgFDP
 poRTTOZ4KnzNtEd6pLSTHkTEI/VeHVhOFICZxiaVfmMznf6pyXqBQ7OBRhDcQzLYruKI
 1X+/Ipn6PMvjJvTPaeBPYwKagYsq8DMtI0bwWMyMBz61CJ+Aty5NHy5wfGqZSx99ZKwH
 Fz4ddfCV1u9Y1BiSdHjBoMvTw/6BgS2n6ENq3jXIDoPgkf3wEfTIDyVdIwv/0ylpUWVa
 1hMA==
X-Gm-Message-State: AOJu0YyJMFYY26+I2ovM+MTfADkUS3BXYWHy7CJAPkJ63S5HV9u8XlGI
 tp8BAXE1HqAutc+5xHuTB4SduM4EIfcv1RUxhzq3BbKJy8whzBb3tU9IFnYaZJHZP3MLvY2nUPA
 gsf8onuYHIC+7blQg3C42nMvphQQ/aCANyQMtEmCHVyHNrly8kAuAVYDhh9+SqqDVk84gfDDGZJ
 4ibztlAerNW4lGiR9JvzB1P0JXm8MHyV5ePs4j1CJF/b/dO9U=
X-Gm-Gg: Acq92OG6XYQNBjXkxh1/WFqz7bten+vh9U2i52f0kuG0oAqXMhhSq879sCGsmCXXY6r
 J4G0l6vW/jBZ0f6B/l+frD4HqdUdChppglAzmBqdYq0hB4ktZCN0tykiRT5omEnMpkNTVgf+qoZ
 fIHh8BzFRZ1wTWwycQB1NIDp0g3AlxB0JvNAkXySZ5QByNlRV4MrG/UYtG4DwgGELunVD2V5KBo
 /+qlS6o6jNs7n9lVNag9Dev1H0j1b2GGFkcSXpA255Y0x9H
X-Received: by 2002:a05:6402:34d1:b0:691:afd5:77e7 with SMTP id
 4fb4d7f45d1cf-691afd579admr7009298a12.22.1781074071128; 
 Tue, 09 Jun 2026 23:47:51 -0700 (PDT)
X-Received: by 2002:a05:6402:34d1:b0:691:afd5:77e7 with SMTP id
 4fb4d7f45d1cf-691afd579admr7009283a12.22.1781074070630; Tue, 09 Jun 2026
 23:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260430132418.275842-1-hector.cao@canonical.com>
 <20260430132418.275842-2-hector.cao@canonical.com>
 <7433C6E4-4D93-4230-8707-AE32CC2BC888@netways.de>
In-Reply-To: <7433C6E4-4D93-4230-8707-AE32CC2BC888@netways.de>
From: Hector Cao <hector.cao@canonical.com>
Date: Wed, 10 Jun 2026 08:47:39 +0200
X-Gm-Features: AVVi8CfRxGj7Hm9FlNukx7BzjCuYEvGrB56MwrFIrvfZcT_xuMtAcqW5uC7Jx_k
Message-ID: <CABjvBV47knahxEp8-Xwm9wYBhwOKaPfE5QkkDjs25o2fc=7ETg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] module: fix early stop for load module function
To: Gabriel Hartmann <gabriel.hartmann@netways.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cfontana@suse.de" <cfontana@suse.de>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004c83dc0653e09fdb"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--0000000000004c83dc0653e09fdb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Gabriel for the review,

May I ask a maintainer to review this and approve it and give me some
confidence so I can downstream it to Distros?

Best,

On Wed, May 20, 2026 at 11:06=E2=80=AFAM Gabriel Hartmann <
gabriel.hartmann@netways.de> wrote:

> On Wed, Apr 30, 2026 at 03:24:18PM +0200, Hector Cao wrote:
> > Commit c551fb0b53d regressed module-loading behavior.
> > Historically, when loading from one module directory failed,
> > QEMU continued searching the remaining directories. That commit
> > made QEMU stop if a matching file was found but could not be
> > loaded (for example, due to a build mismatch).
>
> Thanks for the v2, Hector. The errp handling with error_report_err()
> looks correct now =E2=80=94 errors are reported and cleared between itera=
tions,
> and the last error is propagated to the caller.
>
> One minor edge case: if an earlier directory has a build mismatch
> (rv =3D -1) but the retained module directory doesn't have the file
> at all (ENOENT), rv stays at -1 with *errp =3D=3D NULL. The caller
> gets a failure return without an error message. In practice this
> is unlikely since /run/qemu/<version>/ should contain the module
> if it was retained, so I don't think this needs to block the patch.
>
> Reviewed-by: Gabriel Hartmann <gabriel.hartmann@netways.de>
>
> --
> Gabriel Hartmann
> Senior Systems Engineer
>
> NETWAYS Managed Services GmbH | Deutschherrnstr. 15-19 | D-90429 Nuernber=
g
> Tel: +49 911 92885-0 | Fax: +49 911 92885-77
> CEO: Julian Hein, Bernd Erk, Sebastian Saemann | AG Nuernberg HRB25207
> https://www.netways.de | gabriel.hartmann@netways.de
>
> ** Nuremberg Digital Festival | Open Source Night 23.06.26 |
> https://netways.de/nuedigital2026 **
> ** Open Tech Day 2026 | Software Defined Storage - October | Nuremberg -
> https://opentechday.de/ **
> ** Open Source Monitoring Conference 2026 - November | Nuremberg -
> https://osmc.de **
> ** NETWAYS Web Services - https://nws.netways.de **
> ** NETWAYS Trainings - https://netways.de/trainings **
>


--=20
Hector CAO
Software Engineer =E2=80=93 Server Team / Virtualization
hector.cao@canonical.com
https://launc <https://launchpad.net/~hectorcao>hpad.net/~hectorcao
<https://launchpad.net/~hectorcao>

<https://launchpad.net/~hectorcao>

--0000000000004c83dc0653e09fdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Gabriel for the review,</div><div><br></div><d=
iv>May I ask a maintainer to review this and approve it and give me some co=
nfidence so I can downstream it to Distros?</div><div><br></div><div>Best,<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, May 20, 2026 at 11:06=E2=80=AFAM Gabriel=
 Hartmann &lt;<a href=3D"mailto:gabriel.hartmann@netways.de">gabriel.hartma=
nn@netways.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Wed, Apr 30, 2026 at 03:24:18PM +0200, Hector Cao wrote:<br=
>
&gt; Commit c551fb0b53d regressed module-loading behavior.<br>
&gt; Historically, when loading from one module directory failed,<br>
&gt; QEMU continued searching the remaining directories. That commit<br>
&gt; made QEMU stop if a matching file was found but could not be<br>
&gt; loaded (for example, due to a build mismatch).<br>
<br>
Thanks for the v2, Hector. The errp handling with error_report_err()<br>
looks correct now =E2=80=94 errors are reported and cleared between iterati=
ons,<br>
and the last error is propagated to the caller.<br>
<br>
One minor edge case: if an earlier directory has a build mismatch<br>
(rv =3D -1) but the retained module directory doesn&#39;t have the file<br>
at all (ENOENT), rv stays at -1 with *errp =3D=3D NULL. The caller<br>
gets a failure return without an error message. In practice this<br>
is unlikely since /run/qemu/&lt;version&gt;/ should contain the module<br>
if it was retained, so I don&#39;t think this needs to block the patch.<br>
<br>
Reviewed-by: Gabriel Hartmann &lt;<a href=3D"mailto:gabriel.hartmann@netway=
s.de" target=3D"_blank">gabriel.hartmann@netways.de</a>&gt;<br>
<br>
--=E2=80=82<br>
Gabriel Hartmann<br>
Senior Systems Engineer<br>
<br>
NETWAYS Managed Services GmbH | Deutschherrnstr. 15-19 | D-90429 Nuernberg<=
br>
Tel: +49 911 92885-0 | Fax: +49 911 92885-77<br>
CEO: Julian Hein, Bernd Erk, Sebastian Saemann | AG Nuernberg HRB25207<br>
<a href=3D"https://www.netways.de" rel=3D"noreferrer" target=3D"_blank">htt=
ps://www.netways.de</a> | <a href=3D"mailto:gabriel.hartmann@netways.de" ta=
rget=3D"_blank">gabriel.hartmann@netways.de</a><br>
<br>
** Nuremberg Digital Festival | Open Source Night 23.06.26 | <a href=3D"htt=
ps://netways.de/nuedigital2026" rel=3D"noreferrer" target=3D"_blank">https:=
//netways.de/nuedigital2026</a> **<br>
** Open Tech Day 2026 | Software Defined Storage - October | Nuremberg - <a=
 href=3D"https://opentechday.de/" rel=3D"noreferrer" target=3D"_blank">http=
s://opentechday.de/</a> **<br>
** Open Source Monitoring Conference 2026 - November | Nuremberg - <a href=
=3D"https://osmc.de" rel=3D"noreferrer" target=3D"_blank">https://osmc.de</=
a> **<br>
** NETWAYS Web Services - <a href=3D"https://nws.netways.de" rel=3D"norefer=
rer" target=3D"_blank">https://nws.netways.de</a> **<br>
** NETWAYS Trainings - <a href=3D"https://netways.de/trainings" rel=3D"nore=
ferrer" target=3D"_blank">https://netways.de/trainings</a> **<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div style=3D"text-align:left"></div><div style=3D"text-alig=
n:left">Hector CAO<br></div><div style=3D"text-align:left">Software Enginee=
r =E2=80=93 Server Team / Virtualization</div><div style=3D"text-align:left=
"><a href=3D"mailto:hector.cao@canonical.com" target=3D"_blank">hector.cao@=
canonical.com</a></div><div style=3D"text-align:left"><a href=3D"https://la=
unchpad.net/~hectorcao" target=3D"_blank">https://launc</a><a href=3D"https=
://launchpad.net/~hectorcao" target=3D"_blank">hpad.net/~hectorcao</a></div=
><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div>

--0000000000004c83dc0653e09fdb--


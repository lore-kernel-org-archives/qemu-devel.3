Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BE606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wryk32Y7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUPJb-00019K-Uy; Fri, 20 Nov 2026 09:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xUPJa-00017Q-46
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:10:10 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xUPJY-0005kB-9F
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 09:10:09 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b4c685c751so8015877b3.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 06:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795183802; cv=none;
 d=google.com; s=arc-20260327;
 b=DUrnzgkA0Ivpq76EuQGh1WkNenHQZ6TTFXYSPQxA3IgOK1icjJob4jIcEsMyYr8e9J
 eUfmXERHJ1vZkTP23BrqSZoJc3hObFkhx00VD9RohHuSJoYWHA1UVyOkm3CImqHzbDDM
 c+xnKzLGER0EhIYeDQW00S4pgw18xtaFU1V08l3eukJSU7RYXZo85UMopLY4YvxCJOni
 bRIpK9g9pRdiIzADYUtjNHBg6FkhI/+4DSxNgG1qkMOPpkiuoKze4WDschMfMOwuNWev
 QPCT7AjLK4QdiUsO4VFZUDMrhNJ5L0T/a4K+zgJe/0zYDEmeFPVSpjIJ8IObXd6C82JV
 AxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NtaC4AhW6V+TUn1gZCenl5DHOvKgLNePuYYS6n0OqOI=;
 fh=BFZVXpvKVoryMlUfQ3ow+2rZBOG9jqoHPooclLpjyj4=;
 b=E6M8yB8NcBjiVng9/5O2dqprBGspEja+aQoT4PXEloNDsO9layfSqvbttBrcjAlb0e
 Ugch2oeIfhDJfiNTo7VtDjyz63ft0b3EtCFxQQOdAgcG/MGBX4lXOHp9oCwJQ0nN4agK
 S/i4Zh3SWCuefDHjMGG+EL25/+L5SUj3IIjsQw8p5sD3/tcuD2/s3P5XxxxOfUvRYqiG
 tLQIxfF/u7lZA8rNQMX13P8ezeABunXf9dptgmy6QQEYAcQi6wjv0Tuu6uC7d3ASzGmQ
 VqOcsWOwN7Bl5C42iPBFu/MvkJpOUqmLsaZjkijikGFhu0pHmNmaQcOWXLMqB8lYTdFJ
 qhQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795183802; x=1795788602; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NtaC4AhW6V+TUn1gZCenl5DHOvKgLNePuYYS6n0OqOI=;
 b=Wryk32Y7hai8iqNGcRzWRDR6UHM8BRnQwP9HCRVc+C7GePibhSejhnNwNQkSp2k+9w
 85jpGUJSvcBbgf+XVuQVcc9bPUVQa9Fdh5EdSBiKXPqQLJ/kgzralNGqRS2kG+PnzAsN
 is33C0hp/CCQ+kbTSDvBnfnCbrYhI33xagUiZEL7DjbnPFZlhGotcfeZb8SXNISv+tjW
 iU6MlHOIRsIJzxdLIDGhETKddP7w0+X0e+QBSAWrZWYR0MB2UL/j/Q1EtqDxrCFurbpL
 8QhfyUVIy/JCZeJPfYxaT8t0IxqR0ypzlatXDaaBCOtbTQ2FDqUOfYcqH6b/R6QM4CCS
 Oikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183802; x=1795788602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NtaC4AhW6V+TUn1gZCenl5DHOvKgLNePuYYS6n0OqOI=;
 b=WxbsmUcJ80Sq3sNtYBhZQfEHdI7OUkDy12kI3LqkcefTF46GdLYCBRhuOiLxwD3hSs
 BU/TNjOAP/FRnI7OY0JMxvpaWeB5uHm/6G5ggP23Iefx92ekRO4sKI7SyP9P8ifWP8dS
 9H0yR4NGi6kA2A/s1YrMVjF3x8ZHrDTVe1DPgQR1YCBEsuWQ1GBqd+pi12UZSjrjRPZG
 1x9INtMizDNzNVwukX4Kgm2jo4Z1z35fQdBvopFkSz3cPJpPbo+308ZKENJ7OwkYV9+E
 QJ2OfItaqB+q0OvC2W1cyWha0JmNAJCxpfYUo9jbq6lbP7LxeFEcE14VPZVmpSX0GHXe
 czRA==
X-Gm-Message-State: APuU4Z87iTIR0KUM/F66CjxDbtzVujc1wzeOhaBmqtGq0CQ6v8FT8a4h
 Fu3+gwHY2w055MgP9fz76fFNv5YU70MRGl9uitzkwxxcw4MQyR5TApiKWJLrCh4d9x8cKYpZNBT
 rBBDKjMStDesC9g2BkIL0kJ6OVwl81Cw=
X-Gm-Gg: AZFdTZc/pnPDurU9OrvwsL17bBMuxSEk1ti8GzvHW8YQUPvb0Baw1yZLo528iE067kU
 kvV6SrfVbYCx3xGccDoEcChMxGK56Ps7MaruAMExlPdsaRF4S7OJVNlxvZweKPOIQ6XFr1otPCG
 gVdqGmKbNtKnga9WKZwuB34VAtPn8/xDRl0kEfCh/VrnM0HlS7OeuQOUAu+pJD3RZ7Q7GbQu6I1
 62hpQNLCXtwu+TZFt/kg8qwUunKKGMbaAQjZvLNSAxyfMVJRqBGyfxj0t2KtSTZjwuJF3dyrVUR
 STv9J13Wf9MYvt3ju9d8ILzaTov3Rsxniin05sR5LhvuVGeiZoJYJZmzNKTDQiWswIXTnWyBb0Y
 r8TJHlmV+QoCSsyYqIpFme2IUmSsYpsppgbC1VXgetrH80HeDcO4=
X-Received: by 2002:a05:690c:799:b0:8b4:cbe3:278 with SMTP id
 00721157ae682-8b520434a9amr12275987b3.22.1795183801654; Fri, 20 Nov 2026
 06:10:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112184949.1042-1-nagendranjairam52@gmail.com>
 <87ik1r673b.fsf@draig.linaro.org>
In-Reply-To: <87ik1r673b.fsf@draig.linaro.org>
From: Nagendran Jairam <nagendranjairam52@gmail.com>
Date: Fri, 20 Nov 2026 19:39:50 +0530
X-Gm-Features: AclHuK-mtUrgMlOYLlDao8UQIhictB90aDrO5Zv0HzpuDNLARDzfxg-lwSfMU_w
Message-ID: <CAEAkEp7jbv=uZS61Yd6V-zfNr6cp-MjgHBStC08ft3qROfE2bA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/core/loader.c: Add Extended Tektronix HEX file
 support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org, 
 daan.j.demeyer@gmail.com, peter.maydell@linaro.org, 
 Alistair <alistair@alistair23.me>
Content-Type: multipart/alternative; boundary="000000000000cde1f70660b5cc4c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000cde1f70660b5cc4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026, 17:35 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Nagendran K <nagendranjairam52@gmail.com> writes:
>
> > Add support for loading Extended Tektronix HEX files through the
> > generic loader.
> >
> > The loader parses Extended Tektronix records, validates their
> > checksums, and loads the data at the addresses specified in the file.
> >
> > This allows Extended Tektronix files to be loaded directly without
> > manual conversion to another supported format.
> >
> > Tested by loading an Extended Tektronix file containing a simple UART
> > application on the RealView EB machine. The application executed
> > successfully and produced the expected UART output.
> >
> > Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
>
> Ok before you send another version you should consider:
>
>   - split whitespace and comment updates into their own patches
>   - include a test case for the loader to show its use
>   - verify the whole series applies and builds cleanly on upstream's
> master branch
>
> And the cover letter for the series should also include what changes
> you've made between each iteration. You can also include a summary of
> updates under the --- in the commit messages.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

   Ok sure, but where do I upload cover letter and testcase means the
baremetal build through which I tested or just overall summary of how did I
test?
     Nagendran

>

--000000000000cde1f70660b5cc4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 20, 2026, 17:35 Alex=
 Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Nagendran K &=
lt;<a href=3D"mailto:nagendranjairam52@gmail.com" target=3D"_blank" rel=3D"=
noreferrer">nagendranjairam52@gmail.com</a>&gt; writes:<br>
<br>
&gt; Add support for loading Extended Tektronix HEX files through the<br>
&gt; generic loader.<br>
&gt;<br>
&gt; The loader parses Extended Tektronix records, validates their<br>
&gt; checksums, and loads the data at the addresses specified in the file.<=
br>
&gt;<br>
&gt; This allows Extended Tektronix files to be loaded directly without<br>
&gt; manual conversion to another supported format.<br>
&gt;<br>
&gt; Tested by loading an Extended Tektronix file containing a simple UART<=
br>
&gt; application on the RealView EB machine. The application executed<br>
&gt; successfully and produced the expected UART output.<br>
&gt;<br>
&gt; Signed-off-by: Nagendran K &lt;<a href=3D"mailto:nagendranjairam52@gma=
il.com" target=3D"_blank" rel=3D"noreferrer">nagendranjairam52@gmail.com</a=
>&gt;<br>
<br>
Ok before you send another version you should consider:<br>
<br>
=C2=A0 - split whitespace and comment updates into their own patches<br>
=C2=A0 - include a test case for the loader to show its use<br>
=C2=A0 - verify the whole series applies and builds cleanly on upstream&#39=
;s master branch<br>
<br>
And the cover letter for the series should also include what changes<br>
you&#39;ve made between each iteration. You can also include a summary of<b=
r>
updates under the --- in the commit messages.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0Ok sure, but where do I uploa=
d cover letter and testcase means the baremetal build through which I teste=
d or just overall summary of how did I test?</div><div dir=3D"auto">=C2=A0 =
=C2=A0 =C2=A0Nagendran=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000cde1f70660b5cc4c--


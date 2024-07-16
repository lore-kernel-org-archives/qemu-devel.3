Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5645AC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 02:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTXjg-0001yd-MT; Mon, 15 Jul 2024 22:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1sTXjc-0001xV-NV
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 22:16:09 -0400
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1sTXjX-0001rf-2o
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 22:16:08 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits))
 (Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 4WNN2z5jdLz4QHW
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:15:55 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org", Issuer "R10" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4WNN2z4xBkz4S9f
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:15:55 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
 t=1721096155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vha0Kq0W/b66/a2FEmCPyEVvb3V3dScAGRJBSS2iC0A=;
 b=BZHn4Mhlrr9+TPyanlfpjhX9RJ/0QpoDEKmFH/AICT7L0o8p97vXhSqTl226W6PkAmTCbm
 +jcgr2HV2Y099w6ntm/lkfPf/hxobv8zABpYKGA5I+kXkrhpdMBm3IOeN9aq0EaFKYIeuY
 IThIo/tKiyFoXE4B6O8EDCPHXpjTdHjZ7aVV/ovK2Vo+1X6nom7NgvL0T/1G+r+zfgNHa0
 JOiSwmSobPZQAikXfaL7NWu/KM9nNPDVD2rO5VToklue3Zl59zZEhB2jo1icCZrKtzBw2X
 kmAZev8zvXWINiW3sdxv4QVXZBh7UvJtpDV4eqbwoMsN3H0ehf0/C+3rv/oXCQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1721096155; a=rsa-sha256; cv=none;
 b=v2JnBy1rZGSkPJlGEzaSrDc10R/HRPoIsqY+P14r6fw5p8pWk3+ylpeOGTevR0f/khmlKV
 X/J69V0heW+zmYkeeibBvZGA66qvUAJbBBTa1UO73KemPXIRJpHFtXkU1xcZli7e5e0Fzc
 yYDMG4WtD0p4fXi6dAqf/zLMYJe6HPMglT/Ok1T50NjKoRxyGaDOA1wTuhb172Nk9hVKCm
 q3oXVNXLWVafib6mW7XpC74fNN7wGqzo19X8hbdm1y5nDZMcNDzBEngWPuxJ637spHlKZh
 6pHFmv/YXe9wcePE3kXiqci91lHb3Dvk8MgePUwX+yKheGNYwwWREDY5m0zWog==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
 s=dkim; t=1721096155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vha0Kq0W/b66/a2FEmCPyEVvb3V3dScAGRJBSS2iC0A=;
 b=hc0f6wnhsuUUAZpI+9Bd41az6b0EnlcMbBl0oD0PujFOoU3LkkhqHqefzBN5qBFs5JqaR8
 gWB36FHNma8OPidEL844Xys2OORJZBmKcyk9WB6brsbUx5t943mqPvX9gm9ibUt5k5Hms3
 9NHG9ImoXhKVBN9gFxF8zvkMw4eCufYPm0S+afZwahsd8iTOoGfPk8UIOG8SjbGXOZPVxb
 jE1GFLId27ubxDA04/W+UX8lyHwm749IUyVb4eRtd83RR6QNxZ+lTImrHt0ir3hfQBnWvc
 uAmByBgq7x/p0mCyVz8nUdrxhs5D89GwXIYG5XDj8bI+8Ydy0gr94dmAelSV6g==
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "smtp.gmail.com", Issuer "WR4" (verified OK))
 (Authenticated sender: lwhsu/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 4WNN2z4Y2szLFf
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:15:55 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7035b2947a4so2883854a34.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 19:15:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YyglxsmnZyDLhN5lyHdxAtgelkpspFimptfwFijSA//LtYTWdlH
 hp5LqA8AEREdtWUz1mi2/ndTgYD5yp3vvgjYC4IxE16PFbLdiD/+Vx7qOOPGnvU302CXMwd4g3X
 Yq7MSUEpnGiZnyill1El50p7RpdE=
X-Google-Smtp-Source: AGHT+IGPRNjqjx1a7MX3Rqq4M6DKZzPNyzDfWWewrIKvudUgU3hBa9Uw+ZkhlmBYsLo+mzkXi0ObUCu2QmwBmzsCLyc=
X-Received: by 2002:a05:6830:268c:b0:703:7a58:d005 with SMTP id
 46e09a7af769-708d994ec9bmr1037539a34.11.1721096154366; Mon, 15 Jul 2024
 19:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <63699dab-42d9-45ca-932f-acd6df688b6e@linaro.org>
In-Reply-To: <63699dab-42d9-45ca-932f-acd6df688b6e@linaro.org>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Tue, 16 Jul 2024 10:15:42 +0800
X-Gmail-Original-Message-ID: <CAKBkRUzf1ZWahU3WrTxfM_fHPpxVBMC=YcjHu+evKB5PWdQGaQ@mail.gmail.com>
Message-ID: <CAKBkRUzf1ZWahU3WrTxfM_fHPpxVBMC=YcjHu+evKB5PWdQGaQ@mail.gmail.com>
Subject: Re: FreeBSD update required for CI?
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Ed Maste <emaste@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e7cf85061d53ec79"
Received-SPF: pass client-ip=2610:1c1:1:606c::19:2;
 envelope-from=lwhsu@freebsd.org; helo=mx2.freebsd.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

--000000000000e7cf85061d53ec79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 7:01=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Hi guys,
>
> CI currently failing FreeBSD:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7347517439
>
> > pkg: No packages available to install matching 'py39-pillow' have been
> found in the repositories
> > pkg: No packages available to install matching 'py39-pip' have been
> found in the repositories
> > pkg: No packages available to install matching 'py39-sphinx' have been
> found in the repositories
> > pkg: No packages available to install matching 'py39-sphinx_rtd_theme'
> have been found in the repositories
> > pkg: No packages available to install matching 'py39-yaml' have been
> found in the repositories
>
> Has FreeBSD ports updated to something beyond python 3.9, and we need an
> update to match?
>

Oh yes, the default python version has been changed to 3.11 so the `py39-`
prefix of the package name should be also changed to `py311-`

Where are those packages name listed? I can check if it is possible to
change to use some more deterministic names.

Best,
Li-Wen

--000000000000e7cf85061d53ec79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jul 16, 2024 at 7:01=E2=80=AFAM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi guys,<br>
<br>
CI currently failing FreeBSD:<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/7347517439" rel=3D"n=
oreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/jobs/73=
47517439</a><br>
<br>
&gt; pkg: No packages available to install matching &#39;py39-pillow&#39; h=
ave been found in the repositories<br>
&gt; pkg: No packages available to install matching &#39;py39-pip&#39; have=
 been found in the repositories<br>
&gt; pkg: No packages available to install matching &#39;py39-sphinx&#39; h=
ave been found in the repositories<br>
&gt; pkg: No packages available to install matching &#39;py39-sphinx_rtd_th=
eme&#39; have been found in the repositories<br>
&gt; pkg: No packages available to install matching &#39;py39-yaml&#39; hav=
e been found in the repositories<br>
<br>
Has FreeBSD ports updated to something beyond python 3.9, and we need an up=
date to match?<br></blockquote><div><br></div><div>Oh yes, the default pyth=
on version has been changed to 3.11 so the `py39-` prefix of the package na=
me should be also changed to `py311-`</div><div><br></div><div>Where are th=
ose packages name listed? I can check if it is possible to change to use so=
me more deterministic names.<br></div><div><br></div><div>Best,<br></div><d=
iv>Li-Wen<br></div></div></div>

--000000000000e7cf85061d53ec79--


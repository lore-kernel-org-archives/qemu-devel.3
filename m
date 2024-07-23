Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58596C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAAx-0008PW-5L; Tue, 23 Jul 2024 03:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWAAv-0008P0-OU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:43:09 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWAAs-0000iw-Af
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:43:09 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-44926081beaso25593321cf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721720584; x=1722325384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WND7s4nNccBkVuBfGiOgfgHb4sPvfvPCZCtaYL3Uq8E=;
 b=m00e1Qt+k2fpxCONxs+3+TSjeAAtusFha6tg9Tr0PDe8Nq/9Dswei931qBaGIdKQVZ
 FsR3ryJcE966htnxzBnbg/TLGwIJDoiogIrW2sgQUl+ih76EjoSPskVkKyXebYiUUcmt
 e6YZ6Zmvkc2tKbTqiUSp1cPbDqZqjqJTsBowIvY5GRD3IDtaxHQOveTqjhqud2pGbVZk
 oZ0zxmp4klmmh9r1Ee6flaCRKIT1Eu+40cSIrD4v5ydD3AShZHvO2IOiWACRfUbifhXZ
 HjMbWupCFNZT00/2r46sN8DiMX0fWmctiFy2EHUUWAs/cGg1WPmkIB6txo2dD1jRXsez
 Bl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721720584; x=1722325384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WND7s4nNccBkVuBfGiOgfgHb4sPvfvPCZCtaYL3Uq8E=;
 b=RJ0bj0o3ISRw1Agq5jRZ/SAcsUvYVRTGBDgg9pvGZtDYKM1jHPPtdbjBMKY2bPJjHN
 B6diG3vvzS6lNE5tMbI04o3JKDHaqP6x3uAMU2WamYFskX7BlHiKNGRd3IeJGh3PbM5a
 gKVGELwZzKj202+8nvI2Ka7ETHQBTxHVoqZed/Kd9kPM09FCTLZ48Ka5l/udn/4GDOUl
 fbhcHVGO6pOgi50I5+PRBjgpM8VxYH54xbRRtcCRrQyf4t0sZlc1lEWoBnKDXYZj1WHz
 HANlqGV1BX14r9zK47I9IxJ1X/xA7yt5kti0jmLlnAyHOZYQNVfXn4YZEDA1pFyEXGOG
 IJDw==
X-Gm-Message-State: AOJu0YyKyGztu7loG5Pubickm036jQXS1VXHlHBf79X0hsPMyUGWZ3Os
 BIXgbXDMnBXrqZ9lCkscWZNxXEJDhkJc+zaRGjPOHs0H6zeHetA6ztyWxfdzzce8CN9PXA3+5fS
 gY/gBo2EMHvqM3UaVVPHpabctA1A=
X-Google-Smtp-Source: AGHT+IE1XLWeNWR4syyx1Ap4t4LbH8lrOGFvdXrBT5AHpPCc+7YIqGTM/KOUV5Yl0nvqcqDokfbRT5DrC9dQyNmHvp8=
X-Received: by 2002:ac8:5983:0:b0:446:5c60:b348 with SMTP id
 d75a77b69052e-44fc559c0eemr26403411cf.56.1721720583983; Tue, 23 Jul 2024
 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240717124534.1200735-1-cleger@rivosinc.com>
In-Reply-To: <20240717124534.1200735-1-cleger@rivosinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 23 Jul 2024 11:42:52 +0400
Message-ID: <CAJ+F1CJApZ+xj=PSLJ+gBfENeZFLPBVMV969-tU-+CbPjEmKDQ@mail.gmail.com>
Subject: Re: [PATCH v4] osdep: add a qemu_close_all_open_fd() helper
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cf9962061de54f9c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cf9962061de54f9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 17, 2024 at 4:48=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:

> Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
> POSIX"), the maximum number of file descriptors that can be opened are
> raised to nofile.rlim_max. On recent debian distro, this yield a maximum
> of 1073741816 file descriptors. Now, when forking to start
> qemu-bridge-helper, this actually calls close() on the full possible file
> descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
> takes a considerable amount of time. In order to reduce that time,
> factorize existing code to close all open files descriptors in a new
> qemu_close_all_open_fd() function. This function uses various methods
> to close all the open file descriptors ranging from the most efficient
> one to the least one. It also accepts an ordered array of file
> descriptors that should not be closed since this is required by the
> callers that calls it after forking.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>


GLib already implemented those kinds of portable facilities.

I wonder why launch_script() is not using glib gspawn API.

async-teardown should use g_clownfrom() when glib >=3D 2.80.

my 2c

--=20
Marc-Andr=C3=A9 Lureau

--000000000000cf9962061de54f9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 17, 2024 at 4:48=E2=80=
=AFPM Cl=C3=A9ment L=C3=A9ger &lt;<a href=3D"mailto:cleger@rivosinc.com">cl=
eger@rivosinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Since commit 03e471c41d8b (&quot;qemu_init: increase NOFIL=
E soft limit on<br>
POSIX&quot;), the maximum number of file descriptors that can be opened are=
<br>
raised to nofile.rlim_max. On recent debian distro, this yield a maximum<br=
>
of 1073741816 file descriptors. Now, when forking to start<br>
qemu-bridge-helper, this actually calls close() on the full possible file<b=
r>
descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which<br>
takes a considerable amount of time. In order to reduce that time,<br>
factorize existing code to close all open files descriptors in a new<br>
qemu_close_all_open_fd() function. This function uses various methods<br>
to close all the open file descriptors ranging from the most efficient<br>
one to the least one. It also accepts an ordered array of file<br>
descriptors that should not be closed since this is required by the<br>
callers that calls it after forking.<br>
<br>
Signed-off-by: Cl=C3=A9ment L=C3=A9ger &lt;<a href=3D"mailto:cleger@rivosin=
c.com" target=3D"_blank">cleger@rivosinc.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></blockqu=
ote><div><br></div><div><br></div><div>GLib already implemented those kinds=
 of portable facilities.<br></div><div><br></div><div>I wonder why launch_s=
cript() is not using glib gspawn API.<br></div><div><br></div><div>async-te=
ardown should use g_clownfrom() when glib &gt;=3D 2.80.</div><div><br></div=
></div>my 2c<br clear=3D"all"><div><br><span class=3D"gmail_signature_prefi=
x">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9=
 Lureau<br></div></div></div>

--000000000000cf9962061de54f9c--


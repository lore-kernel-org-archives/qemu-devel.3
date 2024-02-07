Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DD5C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo4K-0008Ft-If; Wed, 07 Feb 2024 14:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo4G-0008AB-Cp
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:58:50 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rXo4D-0002lr-NC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:58:46 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so1248756a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1707335924; x=1707940724;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cD6+iZnfqMoVdKMWJuq8YexL4hPs+IihuTGDKdbjUBs=;
 b=YKA6WhZNzxso3kOX6TU86TGF6z45hE07atidcNXKX7TvgyuufXDVeWRXEVp/DThWaO
 Y93hjvEazABGtSZ1JSaz9utpYjRqSEgadBV6MGC14r6grPmeSOsespr0sNawzi0iNURQ
 pdBahVXOwTnePbyUCAZ2w43Npi57xXaaun01NDshEOE132I5yGDXZQxPdDKO2Te5WxSX
 Qykro1IbV7+wRixn0Dk5M9i2vwg4r7XN0DU+cvMv4zpci2uYNARpLY8i3qW/MzLoie1q
 otZgmE9CLZDhOGxqgRL1T2YKdO/b8djOwiSNLL1htsgiHzjk0wBBo0d2m+7b8deYmqHE
 mVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707335924; x=1707940724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cD6+iZnfqMoVdKMWJuq8YexL4hPs+IihuTGDKdbjUBs=;
 b=MYQrxws8Yn/zfmwnrB1mOPx/pb0XPv2oRdH1bmB/2KBJ/AH2kYNf7+6yQQ8LM6j3B0
 ocfNk1BTG4KgX4lXf/KtVRqqD/3B8+NBYWUHoAfKVpXSDtZxnEqrM9TooNQ6y2vI7Swr
 wxQHEzkUf1Ry4UFFI7oXY+0fBmgsj7xiMAPemwvGFTtEX/PZCfTrJXG9yxrGLBSWpRxz
 KisOBJCgzpEh4mhs/ZBrS4p5eBIsAui7nhJRA8Y46i0fOB4LC04VXKaHnz5d6JlXsE5n
 BEKLtrCAtsQb7BZ05zDh1tl1nL87FBYy31QMdHlfmQZA+rZiI6sVSTlq8tr2EiapA+m5
 it1Q==
X-Gm-Message-State: AOJu0YzoFUEKS3+xFGK4xLkSPIGYtcGZF1PBSTWC8NulXggCb8ZbXruH
 PjhYpHuYtIzfAHBOjGqY+8hY7Z0G2PTm1gAeY81sGrfwdsrO1BWcQ6ZVTxRczCSSKLAlxoboXKo
 lXdGDPNnONl4otsx+Cb5Pdx5yCjSUkEvgK2cthA==
X-Google-Smtp-Source: AGHT+IGGfQgC//Amxuho0jyYmYYwQAjBs30bCRJsMYIoKCmQr4g41W0mjarif/NIouc0TWexIAVPyRIHX6M3S20ptCw=
X-Received: by 2002:aa7:d9c8:0:b0:560:14c4:58fe with SMTP id
 v8-20020aa7d9c8000000b0056014c458femr4243988eds.29.1707335924177; Wed, 07 Feb
 2024 11:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
 <20240207163812.3231697-7-alex.bennee@linaro.org>
In-Reply-To: <20240207163812.3231697-7-alex.bennee@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 7 Feb 2024 12:58:33 -0700
Message-ID: <CANCZdfpX6EBoQ=koMJCrQStBZpj0DKek=nyVVo-Z+gBZFJtd3w@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] tests/vm/freebsd: Reload the sshd configuration
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Marek Vasut <marex@denx.de>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Ed Maste <emaste@freebsd.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000045f2a20610d01f51"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000045f2a20610d01f51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:38=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> From: Ilya Leoshkevich <iii@linux.ibm.com>
>
> After console_sshd_config(), the SSH server needs to be nudged to pick
> up the new configs. The scripts for the other BSD flavors already do
> this with a reboot, but a simple reload is sufficient.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240206002344.12372-3-iii@linux.ibm.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/vm/freebsd | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>



> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index b581bd17fb7..1247f40a385 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -108,6 +108,7 @@ class FreeBSDVM(basevm.BaseVM):
>          prompt =3D "root@freebsd:~ #"
>          self.console_ssh_init(prompt, "root", self._config["root_pass"])
>          self.console_sshd_config(prompt)
> +        self.console_wait_send(prompt, "service sshd reload\n")
>
>          # setup virtio-blk #1 (tarfile)
>          self.console_wait(prompt)
> --
> 2.39.2
>
>

--00000000000045f2a20610d01f51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 7, 2024 at 9:38=E2=80=AFA=
M Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benne=
e@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com"=
 target=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
<br>
After console_sshd_config(), the SSH server needs to be nudged to pick<br>
up the new configs. The scripts for the other BSD flavors already do<br>
this with a reboot, but a simple reload is sufficient.<br>
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank">thuth@redhat.com</a>&gt;<br>
Signed-off-by: Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" ta=
rget=3D"_blank">iii@linux.ibm.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20240206002344.12372-3-iii@linux.ibm.com"=
 target=3D"_blank">20240206002344.12372-3-iii@linux.ibm.com</a>&gt;<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
---<br>
=C2=A0tests/vm/freebsd | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br></blockquote><div><br></div><div>Re=
viewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com=
</a>&gt;</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
diff --git a/tests/vm/freebsd b/tests/vm/freebsd<br>
index b581bd17fb7..1247f40a385 100755<br>
--- a/tests/vm/freebsd<br>
+++ b/tests/vm/freebsd<br>
@@ -108,6 +108,7 @@ class FreeBSDVM(basevm.BaseVM):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prompt =3D &quot;root@freebsd:~ #&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.console_ssh_init(prompt, &quot;root&=
quot;, self._config[&quot;root_pass&quot;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.console_sshd_config(prompt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.console_wait_send(prompt, &quot;service s=
shd reload\n&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# setup virtio-blk #1 (tarfile)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.console_wait(prompt)<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div></div>

--00000000000045f2a20610d01f51--


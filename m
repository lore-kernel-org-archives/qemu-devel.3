Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF671C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2Or-0005zv-OS; Fri, 14 Jun 2024 04:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI2Op-0005xV-Tk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:35:07 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI2On-00054F-Lc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:35:07 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-440f1d9377dso9655521cf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718354104; x=1718958904; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QvyiZUxRnN2fntDf0tqbC/bL1iVPslDZQ3znTCs+WMU=;
 b=CP7sQFocKnLokD836x8TvSgXVn1HbI5UMCIMv17Cm+ho9akqtUXpoRam/aIctPYb/i
 mGyQSpfLlaexAgA1ijL+2ud2MjttMOTQBwciOxY/EMqwWRsQ/Von7/y6YaB1oxPiSNu9
 SSe1EQECFgpUwbBE/T38JHnKliPj+zEgLFzxNWMvfAKaAC2GIAOX1ChZ+PwM385ZIL7p
 Jrvs9GBrv1lpKoxkLjvcnex8RVkaNr8EFwzWDmleHM/dYM0d3kWXiPlQEy69d0gLW/+p
 yhMcciJrObNFTKUdqjKfcNQUJlkPJES/ZyEYsAnr7vCZ5WoTptRZMCP1KKeuC/ipcGja
 Hp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718354104; x=1718958904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QvyiZUxRnN2fntDf0tqbC/bL1iVPslDZQ3znTCs+WMU=;
 b=utAEsrkTKEXOhaqtqqDCWJ+NSMXgkNWpgLqQpzl115hb1GHxp+SAM8cMepe6At7Rx9
 b7N1SF9OkK+m8UVxQYCMreND1tcGoUasP+klL8Y0ZeiCP2A+3BsBE4KleSzXfOep/Lna
 w1we/k36BglWO6icUi1sMy8jKQG6IV4yLJ745KYsRhjdDJ33dlrsxT5mSIonHzqyEetK
 KjWB7zkIr5bGyP9ohA9DG2jv3hQRjyVfKGvGH1xxOKd9Zi2TrnLKlaIajq7ubKZroNFf
 mqFexTlMLEYFviG9p4QZYnxL+pKOrWMS+LxxwtcX5jH0W4Gsnm1SqNmyDB6L6T6/Je2r
 pfag==
X-Gm-Message-State: AOJu0YyOZcHNtTTBGf8gNZBUdH6OT3pR4XX82BcM7WI8a5lQvx/z5FeU
 qiyGAHBIgA1ayskDHhSJIVoz4WGPpRqH5krJiNbU39epD1IkdgO6sQzGczEjUyRWrr3ILESsXIH
 +9wENUelJPZNZ5gTsfAEFGjAK2ks=
X-Google-Smtp-Source: AGHT+IHCMy95idhmbknmatm3R9mIK/V1G3NRSXWPrAFKg2E2IggnNBYnR1KKSInR0tfb3sxrhcWavUZHQ0MsTWlIW1w=
X-Received: by 2002:ac8:58c4:0:b0:440:5fa9:1520 with SMTP id
 d75a77b69052e-442165c42c0mr23493051cf.0.1718354104159; Fri, 14 Jun 2024
 01:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 14 Jun 2024 12:34:52 +0400
Message-ID: <CAJ+F1CJ49ojg1uNL_dsrSxJDSuRJiwmeK3Y5W1qK1GiNo_+S8A@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] qga: clean up command source locations and
 conditionals
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fa190c061ad57d4d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000fa190c061ad57d4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 13, 2024 at 7:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This series is a side effect of other work I started, to attempt to
> make the QGA safe to use in confidential VMs by automatically
> restricting the permitted commands. Since this cleanup stands on
> its own, I'm sending it now.
>
> The QGA codebase has a very complicated maze of #ifdefs to create
> stubs for the various commands that cannot be implemented on certain
> platforms. It then has further logic to dynamically disable the stub
> commands at runtime, except this is not consistently applied, so
> some commands remain enabled despite being merely stubs.
>
> The resulting code is hard to follow, when trying to understand exactly
> what commands are available under what circumstances, and when changing
> impls it is easy to get the #ifdefs wrong, resulting in stubs getting
> missed on platforms without a real impl. In some cases, we have multiple
> stubs for the same command, due to the maze of #ifdefs.
>
> The QAPI schema language has support for many years for expressing
> conditions against commands when declaring them. This results in the
> QAPI code generator omitting their implementation entirely at build
> time. This has mutliple benefits
>
>  * The unsupported commands are guaranteed to not exist at runtime
>  * No stubs need ever be defined in the code
>  * The generated QAPI reference manual documents the build conditions
>
> This series is broadly split into three parts
>
>  * Moving tonnes of Linux only commands out of commands-posix.c
>    into commands-linux.c to remove many #ifdefs.
>  * Adding 'if' conditions in the QAPI schema to reflect the
>    build conditions, removing many more #ifdefs
>  * Sanitizing the logic for disabling/enabling commands at
>    runtime to guarantee consistency
>
> Changed in v2:
>
>  - Make FSFreeze error reporting distinguish inability to enable
>    VSS from user config choice
>
>  - Fully remove ga_command_init_blockedrpcs() methods. No more
>    special case disabling of commands. Either they're disabled
>    at build time, or disabled by user config, or by well defined
>    rule ie not permitted during FS freeze.
>
>  - Apply rules later in startup to avoid crash from NULL config
>    pointer
>
>  - Document changed error messages in commit messages
>
>  - Add -c / --config command line parameter
>
>  - Fix mistaken enabling of fsfreeze hooks on win32
>
>  - Remove pointless 'blockrpcs_key' variable
>
>  - Allow concurrent setting of allow and block lists for
>    RPC commands
>
> Daniel P. Berrang=C3=A9 (22):
>   qga: drop blocking of guest-get-memory-block-size command
>   qga: move linux vcpu command impls to commands-linux.c
>   qga: move linux suspend command impls to commands-linux.c
>   qga: move linux fs/disk command impls to commands-linux.c
>   qga: move linux disk/cpu stats command impls to commands-linux.c
>   qga: move linux memory block command impls to commands-linux.c
>   qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
>   qga: conditionalize schema for commands unsupported on Windows
>   qga: conditionalize schema for commands unsupported on non-Linux POSIX
>   qga: conditionalize schema for commands requiring getifaddrs
>   qga: conditionalize schema for commands requiring linux/win32
>   qga: conditionalize schema for commands only supported on Windows
>   qga: conditionalize schema for commands requiring fsfreeze
>   qga: conditionalize schema for commands requiring fstrim
>   qga: conditionalize schema for commands requiring libudev
>   qga: conditionalize schema for commands requiring utmpx
>   qga: conditionalize schema for commands not supported on other UNIX
>   qga: don't disable fsfreeze commands if vss_init fails
>   qga: move declare of QGAConfig struct to top of file
>   qga: remove pointless 'blockrpcs_key' variable
>   qga: allow configuration file path via the cli
>   qga: centralize logic for disabling/enabling commands
>
>
Something broke patchew handling:
https://patchew.org/QEMU/20240613150127.1361931-1-berrange@redhat.com/20240=
613154406.1365469-1-berrange@redhat.com/

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fa190c061ad57d4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 7:02=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">This series is a side effect of other work I started, to a=
ttempt to<br>
make the QGA safe to use in confidential VMs by automatically<br>
restricting the permitted commands. Since this cleanup stands on<br>
its own, I&#39;m sending it now.<br>
<br>
The QGA codebase has a very complicated maze of #ifdefs to create<br>
stubs for the various commands that cannot be implemented on certain<br>
platforms. It then has further logic to dynamically disable the stub<br>
commands at runtime, except this is not consistently applied, so<br>
some commands remain enabled despite being merely stubs.<br>
<br>
The resulting code is hard to follow, when trying to understand exactly<br>
what commands are available under what circumstances, and when changing<br>
impls it is easy to get the #ifdefs wrong, resulting in stubs getting<br>
missed on platforms without a real impl. In some cases, we have multiple<br=
>
stubs for the same command, due to the maze of #ifdefs.<br>
<br>
The QAPI schema language has support for many years for expressing<br>
conditions against commands when declaring them. This results in the<br>
QAPI code generator omitting their implementation entirely at build<br>
time. This has mutliple benefits<br>
<br>
=C2=A0* The unsupported commands are guaranteed to not exist at runtime<br>
=C2=A0* No stubs need ever be defined in the code<br>
=C2=A0* The generated QAPI reference manual documents the build conditions<=
br>
<br>
This series is broadly split into three parts<br>
<br>
=C2=A0* Moving tonnes of Linux only commands out of commands-posix.c<br>
=C2=A0 =C2=A0into commands-linux.c to remove many #ifdefs.<br>
=C2=A0* Adding &#39;if&#39; conditions in the QAPI schema to reflect the<br=
>
=C2=A0 =C2=A0build conditions, removing many more #ifdefs<br>
=C2=A0* Sanitizing the logic for disabling/enabling commands at<br>
=C2=A0 =C2=A0runtime to guarantee consistency<br>
<br>
Changed in v2:<br>
<br>
=C2=A0- Make FSFreeze error reporting distinguish inability to enable<br>
=C2=A0 =C2=A0VSS from user config choice<br>
<br>
=C2=A0- Fully remove ga_command_init_blockedrpcs() methods. No more<br>
=C2=A0 =C2=A0special case disabling of commands. Either they&#39;re disable=
d<br>
=C2=A0 =C2=A0at build time, or disabled by user config, or by well defined<=
br>
=C2=A0 =C2=A0rule ie not permitted during FS freeze.<br>
<br>
=C2=A0- Apply rules later in startup to avoid crash from NULL config<br>
=C2=A0 =C2=A0pointer<br>
<br>
=C2=A0- Document changed error messages in commit messages<br>
<br>
=C2=A0- Add -c / --config command line parameter<br>
<br>
=C2=A0- Fix mistaken enabling of fsfreeze hooks on win32<br>
<br>
=C2=A0- Remove pointless &#39;blockrpcs_key&#39; variable<br>
<br>
=C2=A0- Allow concurrent setting of allow and block lists for<br>
=C2=A0 =C2=A0RPC commands<br>
<br>
Daniel P. Berrang=C3=A9 (22):<br>
=C2=A0 qga: drop blocking of guest-get-memory-block-size command<br>
=C2=A0 qga: move linux vcpu command impls to commands-linux.c<br>
=C2=A0 qga: move linux suspend command impls to commands-linux.c<br>
=C2=A0 qga: move linux fs/disk command impls to commands-linux.c<br>
=C2=A0 qga: move linux disk/cpu stats command impls to commands-linux.c<br>
=C2=A0 qga: move linux memory block command impls to commands-linux.c<br>
=C2=A0 qga: move CONFIG_FSFREEZE/TRIM to be meson defined options<br>
=C2=A0 qga: conditionalize schema for commands unsupported on Windows<br>
=C2=A0 qga: conditionalize schema for commands unsupported on non-Linux POS=
IX<br>
=C2=A0 qga: conditionalize schema for commands requiring getifaddrs<br>
=C2=A0 qga: conditionalize schema for commands requiring linux/win32<br>
=C2=A0 qga: conditionalize schema for commands only supported on Windows<br=
>
=C2=A0 qga: conditionalize schema for commands requiring fsfreeze<br>
=C2=A0 qga: conditionalize schema for commands requiring fstrim<br>
=C2=A0 qga: conditionalize schema for commands requiring libudev<br>
=C2=A0 qga: conditionalize schema for commands requiring utmpx<br>
=C2=A0 qga: conditionalize schema for commands not supported on other UNIX<=
br>
=C2=A0 qga: don&#39;t disable fsfreeze commands if vss_init fails<br>
=C2=A0 qga: move declare of QGAConfig struct to top of file<br>
=C2=A0 qga: remove pointless &#39;blockrpcs_key&#39; variable<br>
=C2=A0 qga: allow configuration file path via the cli<br>
=C2=A0 qga: centralize logic for disabling/enabling commands<br>
<br></blockquote><div><br></div><div>Something broke patchew handling:<br><=
/div><div><a href=3D"https://patchew.org/QEMU/20240613150127.1361931-1-berr=
ange@redhat.com/20240613154406.1365469-1-berrange@redhat.com/">https://patc=
hew.org/QEMU/20240613150127.1361931-1-berrange@redhat.com/20240613154406.13=
65469-1-berrange@redhat.com/</a> <br></div></div><br><span class=3D"gmail_s=
ignature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">M=
arc-Andr=C3=A9 Lureau<br></div></div>

--000000000000fa190c061ad57d4d--


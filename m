Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F795C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwepW-0005u6-TW; Tue, 16 Apr 2024 05:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rwepU-0005tv-W0
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:10:17 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rwepR-00069P-Ea
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:10:16 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-434b7ab085fso44284881cf.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713258612; x=1713863412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cph4wnFsS72o4diDKIbPBncVkYLnfyS5FY292uJ6NYg=;
 b=J4Im3HGOzv56Vt4d24s1yAcicxD5Tt+ocJR4tzXAE9XXmb5Hh1oM+gOPXncBCuAluq
 ZhvtEaOZd2LNqE93mQHdGqJ347P95xY/o0FfH+KmTH1MVnWRmNtla6TInXZ9WcwHNblQ
 5sj+GenSggD7JIuIohrOKE1MAs3b+7CMKCsx/f3EQIOH/RfQu2sALdkw1H34VeuDcjEr
 ABLTMWgy60l9rltTnnc0EYFDJaewpt4rzuw1B9c+FYAFpCAaw86xTT8nSJVnPSEcyzYG
 t0WC8VdPxk59FVhcc+ngegYYo623IOuGISfIbc5U63GmqAF+TsEqu1fmN4N05Ky7ocdw
 enlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713258612; x=1713863412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cph4wnFsS72o4diDKIbPBncVkYLnfyS5FY292uJ6NYg=;
 b=Vb++bV/b4Qj/Vmt0C+HQHkVoZFCmdryU+Btw3AU+GQgzqpAQlgwa/mwrz2UGpeqOYW
 rA8bkb/h1Pop4ulUk8DXQejPEYTyw1BKHULgLUD91bQv72e37qZm8ZBxnFvj5pbMmAr2
 gPKecDIPBoJT6Wg9fHJBOhXNOh/3GIzkTk6baniVl55TmQphLXX66rBjHtJg/8Ae0r8E
 XcbAhZS/8iPps33hlXEuUwtd8kxyqyvL2NX/clIf3FBLxOSPD5Md2wLFmhjWeVKUhEu2
 /w79Wp7AIqVpc0HoIYNeT5/bZN7EE5ANRWQMjBo/l9blW0MfgbEA8cJbJ0PACysqD9EU
 3Lcw==
X-Gm-Message-State: AOJu0YyAcknivMBnkHZ4c+6xeY0CSsl0LMSbxQR+aD8uxkkot5UB8rgh
 hxL40U04JNRrR8zUi3ooXJt3LbEcGPF58zGDZH6xlfWOxQFZ+M7b31uuflBwvJ9ljRxvarcLfd2
 fBi/6AzeHp0sG1+q5KsixBkONyco=
X-Google-Smtp-Source: AGHT+IEREJQv5AuemdOwRusZu/gF+fyZVY3aaaZaFObeZq+8UX76aHXSJHVVBdT1IZLjzq8/6Y3XIEPQW7EddhjVStc=
X-Received: by 2002:ac8:5fc3:0:b0:434:6c3e:3074 with SMTP id
 k3-20020ac85fc3000000b004346c3e3074mr1897219qta.22.1713258611966; Tue, 16 Apr
 2024 02:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240324152150.21506-1-irina.ryapolova@syntacore.com>
 <CAJ+F1C+hB4Awoids71q3RU8od+_QfqEm47c=3AE8UoC=7+q74A@mail.gmail.com>
In-Reply-To: <CAJ+F1C+hB4Awoids71q3RU8od+_QfqEm47c=3AE8UoC=7+q74A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Apr 2024 13:10:00 +0400
Message-ID: <CAJ+F1CJOt=HLASCwKeFqHwu0A+_H4vx+A=2ZOc-75vONkZYW2A@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio: Fix keyboard input after exit
 Qemu on
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Irina

On Mon, Mar 25, 2024 at 10:44=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Sun, Mar 24, 2024 at 7:23=E2=80=AFPM Irina Ryapolova
> <irina.ryapolova@syntacore.com> wrote:
> >
> > After exit Qemu need to return the terminal to the default state.
> >
> > Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> > ---
> >  chardev/char-win-stdio.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> > index 1a18999e78..4fa2c3de8b 100644
> > --- a/chardev/char-win-stdio.c
> > +++ b/chardev/char-win-stdio.c
> > @@ -220,6 +220,7 @@ err1:
> >  static void char_win_stdio_finalize(Object *obj)
> >  {
> >      WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
> > +    DWORD dwMode;
> >
> >      if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
> >          CloseHandle(stdio->hInputReadyEvent);
> > @@ -230,6 +231,10 @@ static void char_win_stdio_finalize(Object *obj)
> >      if (stdio->hInputThread !=3D INVALID_HANDLE_VALUE) {
> >          TerminateThread(stdio->hInputThread, 0);
> >      }
> > +
> > +    GetConsoleMode(stdio->hStdIn, &dwMode);
> > +    dwMode &=3D ~ENABLE_VIRTUAL_TERMINAL_INPUT;
> > +    SetConsoleMode(stdio->hStdIn, dwMode);
>
> I'd suggest saving the mode when opening instead, to make sure we
> restore the same value.
>
> thanks

Do you agree? Could you update the patch? thanks

--=20
Marc-Andr=C3=A9 Lureau


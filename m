Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4994C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roe5N-0003Yc-1e; Mon, 25 Mar 2024 02:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1roe59-0003T2-Hl
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:45:22 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1roe56-0003R1-Ri
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:45:19 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-61130dd21c1so17870307b3.2
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711349111; x=1711953911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLmvtO39Nt6nmlxrPCOix417UGh0+5kokRqCJbUT3eE=;
 b=J83ZT7vAFjg+XHtkYBhOV0rTiIGh4u8gUA/p9RrmXSRMtvZFSRrT8GZZ7NOPoXc8vu
 sjr24cGBHmQag5J7qN9EJWESn4Jp6alw+JN+NpsQjAED+dmkOdhNQe96SzSWcw9iXgXo
 4r54Ugq4TnBbuGbHibFfImLtf7dZj5hXvDrgiTJMGAwAQQtLIv3Q0nfRA9mFysSiGwn+
 zc9y1G/ROzSV1GFshCS4gJzMG7ztvLesbt/csSL4FBqgOMfTmLbmV1Ofs8xZm/E1+DVP
 k1zC+0dAQ36tjz8dL8NNaIPCZtn10fCxMtgR3VoJJu89SeEgI/VO+G/nPWW5NLnNS0Dx
 FhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711349111; x=1711953911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLmvtO39Nt6nmlxrPCOix417UGh0+5kokRqCJbUT3eE=;
 b=B9lG/Zpr3whxnAzKIE+ygyZlXWKS7WzhjpItystmRGWgOjsaYGKfOz8R9mSIllbJAF
 vdrd48hKeOlvnc3l+PH32l4HdEduMgsf8TuOk2wR9nCFTSYbVgCijJiMx9BX+cW3gBGS
 10+m9Ake1C7Rvjjkl7jdPherDrSrseGzjgzcOBtAmHJAQHWBvB7sdvaRt49vhokGztoj
 JbtlNIC5RVI+9j/FHZkmTMIxyZfvj8/wqzq4ZB3V+VtxP64RmQm9taN3OD37yGGwdWUo
 8KF38evu2n9I3O6ZHRZgRU147LhEcr/jsYU3vM7xv4C4DkXkrqWPXFEGZixDFHEZZUR+
 Tudw==
X-Gm-Message-State: AOJu0YzoNufbc/uqt1eZ74DQNCBbmVUKFgvuNTXBSJ4tWvAOQciAjMz8
 cF8FulS1IDXwf6Zw+73Eaa8J6xTC41vXyay1j3J+pY8oPJhp+zJcwluxmXzqjj0LHq/QurSgya3
 VukLfoqVPm2Y5+yzYnU0xJpPPygo=
X-Google-Smtp-Source: AGHT+IFM+WSOnVDrODbgSnYOuFSEuN5vSrIrQQfYnAwYTdRHP3yKaXODookmAfDr52YXMamOaHnXOCVC9qDJp46+Ocs=
X-Received: by 2002:a81:5254:0:b0:611:45e9:cfa with SMTP id
 g81-20020a815254000000b0061145e90cfamr3333973ywb.5.1711349111245; Sun, 24 Mar
 2024 23:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240324152150.21506-1-irina.ryapolova@syntacore.com>
In-Reply-To: <20240324152150.21506-1-irina.ryapolova@syntacore.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 25 Mar 2024 10:44:59 +0400
Message-ID: <CAJ+F1C+hB4Awoids71q3RU8od+_QfqEm47c=3AE8UoC=7+q74A@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-win-stdio: Fix keyboard input after exit
 Qemu on
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1136.google.com
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

Hi

On Sun, Mar 24, 2024 at 7:23=E2=80=AFPM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> After exit Qemu need to return the terminal to the default state.
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> ---
>  chardev/char-win-stdio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
> index 1a18999e78..4fa2c3de8b 100644
> --- a/chardev/char-win-stdio.c
> +++ b/chardev/char-win-stdio.c
> @@ -220,6 +220,7 @@ err1:
>  static void char_win_stdio_finalize(Object *obj)
>  {
>      WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
> +    DWORD dwMode;
>
>      if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
>          CloseHandle(stdio->hInputReadyEvent);
> @@ -230,6 +231,10 @@ static void char_win_stdio_finalize(Object *obj)
>      if (stdio->hInputThread !=3D INVALID_HANDLE_VALUE) {
>          TerminateThread(stdio->hInputThread, 0);
>      }
> +
> +    GetConsoleMode(stdio->hStdIn, &dwMode);
> +    dwMode &=3D ~ENABLE_VIRTUAL_TERMINAL_INPUT;
> +    SetConsoleMode(stdio->hStdIn, dwMode);

I'd suggest saving the mode when opening instead, to make sure we
restore the same value.

thanks

--=20
Marc-Andr=C3=A9 Lureau


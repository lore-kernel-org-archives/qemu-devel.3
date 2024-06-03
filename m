Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A6C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6if-00011k-IH; Mon, 03 Jun 2024 08:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE6ic-00011B-BR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:23:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE6ia-0003zW-EG
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:23:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a20c600a7so4709379a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417393; x=1718022193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RbRWZRk+xCTLXVsDaAQ99Obi5eVkhzRQ1yVV8E0oMo8=;
 b=iDnyU/D40E+T+qwU9RT7LEOh3YX8nmaEq1WPgA+OSlJWrOj35Aa5i2ZSgzekxTNFRL
 /m+iY849hm97+5qbFgd3geHMb135K/S+WPLKfCLDMtaMkOidGFGLFmgYA9ZqI+Ucgw+R
 B1XOrzJjDpLn5yFKcz73fJYPApWUQBY8yFqLwgRKTJ+TdQcbnCyrWeNtKDaAk8qJulbo
 zGAVczXUMXvXgsDgU3jFPvbwiq0fZzN9g8bhpJIZ3HaJhFb+fIdsWt22dPeJ8uIcNq/D
 20secyQeAhCTYK2njnjlS6jt5fV9Y90QmdszsaGKmckLR883tJOAu+GzJ77ajvdawQ/2
 51KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417393; x=1718022193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RbRWZRk+xCTLXVsDaAQ99Obi5eVkhzRQ1yVV8E0oMo8=;
 b=a1KXKynyA3FI5NsPMVUDR5KIZnyTkwE+LSXRZNF7oRc8R05PaaKQGSLBttZDB+09UD
 cHMUvPxzKWq15TCerKa7HaF2spgIsrUwI5YZwyMN1l+6ct0lWKaNa8K1ExXIwjBWurbd
 yunBiMUgPkx0+sqhbvU/bm6USsiAEtYmVgPEwqToaChZvcejGQr72LaPvObSWW9J+Xfv
 SR/PXPF10wSqvw/DvdFre71S9HElOabMkS5qI8imJ+BG95wNaEtR7ORDQwdaURKq0tmd
 kYJqkLp+WwPB/mqsstcYXMTrwHskgZbk2wrHV/dJ2Pwv6VQzZA00URT2i5KYy/7yFAhP
 Q43w==
X-Gm-Message-State: AOJu0YwujqiobTvxGRFFRGk/t/s/iTEjnsM7XuvctNxaxn0P8Ipnt4jW
 KytSYtTub38C8YRWzL9YnC8WjE6//pJyUhaflEvtKvXapadRfaY1eqADjSgMlGFu6F22E0ZMi2r
 B0Z++DyR3Us1FdlHiAo3vm0iyfzYDIPvfPPVXBw==
X-Google-Smtp-Source: AGHT+IFf7O6/pR7DUqW+GzZsaztNTxKC79PiBph0u8c/qcjX0obmH7JGHJfuOgcySqWLYJp+qmCgR5hHMl8yGX8/IKc=
X-Received: by 2002:a50:bb62:0:b0:57a:30e6:86b4 with SMTP id
 4fb4d7f45d1cf-57a363e0247mr5757491a12.24.1717417392722; Mon, 03 Jun 2024
 05:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240531175153.2716309-1-tavip@google.com>
In-Reply-To: <20240531175153.2716309-1-tavip@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 13:23:00 +0100
Message-ID: <CAFEAcA_zPR=gd95tkhi8cXaZMf+M2OO2WpF=ZfO1vKhsO9=1cA@mail.gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 31 May 2024 at 22:21, Octavian Purdila <tavip@google.com> wrote:
>
> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
>
> Based on patch from Paulo Neves:
>
> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/
>
> Tested with the following invocations that the link is created and
> removed when qemu stops:
>
>   qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
>   -chardev pty,path=test,id=compat_monitor0
>
>   qemu-system-x86_64 -nodefaults -monitor pty:test
>
> Also tested that when a link path is not passed invocations still work, e.g.:
>
>   qemu-system-x86_64 -monitor pty

Could we have some justification here for why the new
functionality is useful, please? (e.g. what new use cases
it permits).

> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -509,7 +509,7 @@
>  ##
>  # @ChardevHostdevWrapper:
>  #
> -# @data: Configuration info for device and pipe chardevs
> +# @data: Configuration info for device, pty and pipe chardevs
>  #
>  # Since: 1.4
>  ##
> @@ -650,7 +650,7 @@
>              'pipe': 'ChardevHostdevWrapper',
>              'socket': 'ChardevSocketWrapper',
>              'udp': 'ChardevUdpWrapper',
> -            'pty': 'ChardevCommonWrapper',
> +            'pty': 'ChardevHostdevWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
>              'msmouse': 'ChardevCommonWrapper',

Does this break QAPI compatibility?

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0..5eec194242 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>  #else
> -    "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> +    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
> @@ -3808,12 +3808,16 @@ The available backends are:
>
>      ``path`` specifies the name of the serial device to open.
>
> -``-chardev pty,id=id``
> +``-chardev pty,id=id[,path=path]``
>      Create a new pseudo-terminal on the host and connect to it. ``pty``
>      does not take any options.

We just added an option, so we should delete the line saying
that it doesn't take any options :-)

>
>      ``pty`` is not available on Windows hosts.
>
> +    ``path`` specifies the symbolic link path to be created that
> +    points to the pty device.

I think we could usefully make this a little less terse. Perhaps
   If ``path`` is specified, QEMU will create a symbolic link at
   that location which points to the new PTY device.
?

thanks
-- PMM


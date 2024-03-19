Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251E1C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 08:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmUrA-0006gv-4A; Tue, 19 Mar 2024 04:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmUr8-0006gV-Mo
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:29:58 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmUr7-0002dv-3b
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 04:29:58 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-609f1f97864so57455357b3.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 01:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710836995; x=1711441795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gATCHIpK7JyeKYB0rPRVwBGCL2Zpfl/yuvvoKlJBZI8=;
 b=ibT2agpwTe9leAEUdZzLNLvv6yLI8WKU2yQDYlT4MqaN3k/wKCR2kCxoAP9AvG7v1R
 4c1zmo0XI5Atk26yCtqZhMTkWaBiOGoqIgcgkGuyg81weum/W3yKDlPUVtNDrdWWS2Rj
 UNLUIWwUlR1v4Ka1BBR/4MiFlMbYcVfY890FYTBYOcP86FVpyLTFTvolADxsDDYEDNsU
 UJEzkhrlD/kNlcU0jBNM96eHbr6S7JI2L1ZJIC7Gbt+RFwSeEjxcLBWdZ1OEKtZ8epo8
 AWVOTOt4iIUf+hmR8IXNvloVVEMeldMiqVbysIgBM2FOAvmbzHp3IAOEewWR1KyqSjm4
 sqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710836995; x=1711441795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gATCHIpK7JyeKYB0rPRVwBGCL2Zpfl/yuvvoKlJBZI8=;
 b=J4o3dGr5BUgpkK8UKrjWCJgIKVb4jHjqA3dKIQPO2q34jTJ15g+706+jYBlU7W67Sc
 8BObMA3tN/5OhAuELUgWA2/19IKTpeKgWRrATktHbm3i8eLBwUhWpB0nc1lsJHi5yWLM
 uqRAJ/M7c7Hhcbawcjrc3qDlm0XArbRsyBlMZeQUj5VeOBK93QqGx1Ytbt7pmiJQsxUh
 5qv1gwNgMB9o7zRkPbO1B/t6j1wOiIFTVb+JUPjtuslkGO5BsRIyB7J1DWr6ggzQfZi2
 cJthNy+euDlX3S5hZb/uTa5NcOnUDbwxnR0tOvSaNbGAiMERxDug7TlL3hzQy3FvVzqb
 qGBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7yLkZQIaOb0m79+NuHNtwYuQkxrgj51oljsxuYYYnaJMdB3FXjaewDTW5jzVkKtxrGPbDKj6VQtgyCoNyP55d5eKa8oY=
X-Gm-Message-State: AOJu0YyNICc4uHQWyfC5lTdNdk6LYveLOr5KZtBwB7MGuHTKgF34tymI
 n38uQ066dfMoovZb+i+/9hdi0pQJ0lUILN5TboD88Y6oE9Rcf+GRbeypyksbqm+N+F3+1lDX78U
 oRK9ktEpyQK54nEfnmlj+7soCbOU=
X-Google-Smtp-Source: AGHT+IFFZru5WvkXraWfufsy7KUFxz90G99wuYK6B/gF8R7K8iBZce1HfGabWlk4HIhb4vX1S32B6mHyAK1zf8LebIc=
X-Received: by 2002:a25:904:0:b0:dbe:9509:141c with SMTP id
 4-20020a250904000000b00dbe9509141cmr1371150ybj.30.1710836994875; Tue, 19 Mar
 2024 01:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
In-Reply-To: <20240319-console-v2-0-3fd6feef321a@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Mar 2024 12:29:43 +0400
Message-ID: <CAJ+F1CKOuZR5nZxcxRzZyoE56p_nNW11cySEmnFvRgiPv5OAdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ui/console: Remove console_select()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Akihiko

On Tue, Mar 19, 2024 at 7:09=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> ui/console has a concept of "active" console; the active console is used
> when NULL is set for DisplayListener::con, and console_select() updates
> the active console state. However, the global nature of the state cause
> odd behaviors, and replacing NULL with the active console also resulted
> in extra code. Remove it to solve these problems.
>
> The active console state is shared, so if there are two displays
> referring to the active console, switching the console for one will also
> affect the other. All displays that use the active console state,
> namely cocoa, curses, and vnc, need to reset some of its state before
> switching the console, and such a reset operation cannot be performed if
> the console is switched by another display. This can result in stuck
> keys, for example.
>
> While the active console state is shared, displays other than cocoa,
> curses, and vnc don't update the state. A chardev-vc inherits the
> size of the active console, but it does not make sense for such a
> display.
>
> This series removes the shared "active" console state from ui/console.
> curses, cocoa, and vnc will hold the reference to the console currently
> shown with DisplayListener::con. This also eliminates the need to
> replace NULL with the active console and save code.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I am willing to take that for 9.0. Is there any bug already opened
about the issues it solves?

> ---
> Changes in v2:
> - Changed to fall back to a text console if there is no graphical
>   console as previously done.
> - Link to v1: https://lore.kernel.org/r/20240318-console-v1-0-f4efbfa7125=
3@daynix.com
>
> ---
> Akihiko Odaki (4):
>       ui/vc: Do not inherit the size of active console
>       ui/vnc: Do not use console_select()
>       ui/cocoa: Do not use console_select()
>       ui/curses: Do not use console_select()
>
>  include/ui/console.h   |   2 +-
>  include/ui/kbd-state.h |  11 ++++
>  ui/console-priv.h      |   2 +-
>  ui/console-vc-stubs.c  |   2 +-
>  ui/console-vc.c        |   7 ++-
>  ui/console.c           | 133 ++++++++++++-------------------------------=
------
>  ui/curses.c            |  48 ++++++++++--------
>  ui/kbd-state.c         |   6 +++
>  ui/vnc.c               |  14 ++++--
>  ui/cocoa.m             |  37 ++++++++++----
>  10 files changed, 118 insertions(+), 144 deletions(-)
> ---
> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
> change-id: 20240317-console-6744d4ab8ba6
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


--=20
Marc-Andr=C3=A9 Lureau


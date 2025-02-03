Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D712C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texRg-0007sA-TQ; Mon, 03 Feb 2025 09:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1texRe-0007rQ-QZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:29:02 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1texRc-0000xp-Vf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:29:02 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5db6890b64eso8565566a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738592939; x=1739197739; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTBv0nnQ9swA4CRzKxvsQCi3cfIRYH1VR9owNua1rHA=;
 b=lDRAsVrvSCNpQAkTww1UhJqaF8nV/QldanO4f6wyC58f/qN6Y3p5xlVPwUv58cY5EC
 v3ZO7mizgYHbo0mhgPcoC++App+2g3slzWhRKiUF/FZ7q5aEPsj7/KzmZn18eEBlnhAY
 79cx6UHp0o+lGEjGCEDToJdmxWyQ35G0N3/w8ONvnZvK4uz5XaXI2kMz0tfz/oK8gQFz
 9SCddd2gL+am6UJk/37xiKAYs9QYjvuTFWzxvX8ZIBf4oZdOmZUaNaQ2cRtxpzxtUNuQ
 ro5omiqcGoNapVxm+w480sde8Hs7cGo5TG8i8MXZYetwS4JBq+zbo+cx/1z0uFOL0eoR
 u8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738592939; x=1739197739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTBv0nnQ9swA4CRzKxvsQCi3cfIRYH1VR9owNua1rHA=;
 b=sivWkqjlKrF1V3Yl22I5FeaqYmB/FUmsL5DTCeI0MY/KlaH7LMu9vXx5SohbLMNmQP
 Y3eEt32EkoL6zN/L+9uYrSpJY9gJxHqByE7UxfT0WnUE0Hl0QWrVTKCGn2MlClpy1ULN
 bfs8AwxNkwKh6U5/O4wTKLGdPJtWX5KyajHZ/ZSFAZSZOeS98diVfCdNmbXp/kW2XjqQ
 eh53nr11x3k1YYRFxpRzDoi6VpSNeHsoc4zE1ATiy2e5qvVYa38xIp/Ecv63zN5Z0FaT
 +FTn4KuwZOnQwrDOw4xYPpYyeErfay+py8yhGdgJxB5kX72JJQ5QJxnuk2cU8H7yZiL/
 4g3A==
X-Gm-Message-State: AOJu0YzzFPCEpOuHY9f1rkQbVODlLDNQuksTf7BbvxC93MgGAgcBwiby
 WS4rhw5mUC5bvs/t1b8laea4409o/6TU0aLCK3lPl/AhKXMTJ3qUPU4ILP5LdJAKRBTAmhD95dw
 ToBey05N2IczsHxg/Alz6fhf2zWliq5gb
X-Gm-Gg: ASbGncv6shYXVp8aTjz2ZS33LqJ+ecMCwPDwYEWiZvc5qKRVgYJgR9EaXHTE81af3W7
 CBcguSUA9z9uZxGYnFE+AImxWUDnawkluMnesu900Eo9ajfEp6FDxBEpsXE+wr6oWp+iZbtc=
X-Google-Smtp-Source: AGHT+IEKCbeZs3tsj3Ygkh/uxC1tcv+R+49CSRerF5TeYqFCxPOcY1z7BA3TzPiOBmmInPeVDjxvy1SOZ4VuPa5o5LY=
X-Received: by 2002:a05:6402:3511:b0:5dc:5c18:6c7 with SMTP id
 4fb4d7f45d1cf-5dc5efa8f1emr25546327a12.5.1738592938413; Mon, 03 Feb 2025
 06:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20250203125721.640451-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250203125721.640451-1-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 3 Feb 2025 09:28:46 -0500
X-Gm-Features: AWEUYZkIIwEtx8ZqixLDj4-rtrzxOqd4lfRcOUP-B_cI5veW-fjsCV6ncxS_9ao
Message-ID: <CAJSP0QX+zW0eenxwdZL4=jrdXB2=dVjpb2hw8BzFM7Ee9EHdrw@mail.gmail.com>
Subject: Re: [PULL 0/8] Ui patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Feb 3, 2025 at 7:58=E2=80=AFAM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 6fccaa2fba391815308a746d68f7fa197bc935=
86:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into=
 staging (2025-02-02 11:09:10 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to f327a2cea1502a8cad2beb13bc4e2c12b95b10ba:
>
>   dbus: add -audio dbus nsamples option (2025-02-03 13:58:08 +0400)
>
> ----------------------------------------------------------------
> UI/chardev-related patch queue
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (4):
>   ui/dbus: on win32, allow ANONYMOUS with p2p

Hi Marc-Andr=C3=A9,
There is an unexpected submodule update in this commit. Although it's
not included in the patch email sent to the mailing list, GitLab shows
it:
https://gitlab.com/marcandre.lureau/qemu/-/commit/31d9023965ba1963afd1e0e0f=
48c75399a7bc23e

Please rebase onto qemu.git/master and remove the spurious libvirt-ci
submodule update before resending this pull request. Thank you!

Stefan

>   ui/dbus: clarify the kind of win32 handle that is shared
>   plugins: fix -Werror=3Dmaybe-uninitialized false-positive
>   dbus: add -audio dbus nsamples option
>
> Roman Penyaev (4):
>   chardev/char-pty: send CHR_EVENT_CLOSED on disconnect
>   chardev/char-hub: implement backend chardev aggregator
>   tests/unit/test-char: add unit tests for hub chardev backend
>   qemu-options.hx: describe hub chardev and aggregation of several
>     backends
>
>  qapi/audio.json            |  22 +-
>  qapi/char.json             |  27 +++
>  chardev/chardev-internal.h |  51 ++++-
>  include/chardev/char.h     |   1 +
>  audio/dbusaudio.c          |  29 ++-
>  chardev/char-hub.c         | 301 ++++++++++++++++++++++++++++
>  chardev/char-pty.c         |   4 +-
>  chardev/char.c             |  23 ++-
>  contrib/plugins/cache.c    |   2 +-
>  tests/unit/test-char.c     | 398 +++++++++++++++++++++++++++++++++++++
>  ui/dbus-console.c          |   8 +-
>  ui/dbus.c                  |  10 +-
>  chardev/meson.build        |   1 +
>  qemu-options.hx            |  49 ++++-
>  ui/dbus-display1.xml       |  16 +-
>  15 files changed, 923 insertions(+), 19 deletions(-)
>  create mode 100644 chardev/char-hub.c
>
> --
> 2.47.0
>
>


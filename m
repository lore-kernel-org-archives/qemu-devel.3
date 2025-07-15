Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D704C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZQB-0000Qv-L5; Tue, 15 Jul 2025 02:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubZJg-0008ES-0E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:39:04 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubZJd-00068L-2o
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:39:03 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7dfc604107eso302724785a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752561539; x=1753166339; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPfKo5E1qPErVZaYej0Iezyzjt90QQhxo5HOOiHcGFM=;
 b=WEeIhOQAJ943npwf0lj8tVnTinaWpNReFPOwnqbSpiJMISblqSQKXtdRXjmei8JK89
 IyQHGBT18lmC5dPIWpCumbU+K5yNZDyqaVomIb9ASTKLFXx3RFTJtwsN6mGS3NmzNqBS
 epjcKI/p/beQz4X38IQWbOYJKrSSNAoiBaRJQVKYNAw5feYZ9G3XwzWCv5R/qJe4/JXX
 98eHf3yQBUq3ZNuwOCJwBS59jD94SwlD8kWVzDAtk/a0thFzh7HRjcKcysRvnid2ECrw
 K94KjtJXUz1rjeQpiQmVPOwPkQ/BxxiBya6XIr5RZWYbxF4SCYz1nQPHX0XOaS3anWZQ
 VTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752561539; x=1753166339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPfKo5E1qPErVZaYej0Iezyzjt90QQhxo5HOOiHcGFM=;
 b=Pl8xHm/xOKy0ctYxQZOnTp7x9DSv+X3nXpv2x9/45XpM3oSYs9Gp6eXvRvFNGZV1yQ
 3f7/2aEl3oXsyvF8KzvRGU9ihtzQ2IlnN7XIMu7xK4tYdwIn9l2NsRhCHBKw+3l+jgs9
 IHSEqCZA3zUH/UCz+ZZ2IUCI6elNOf9ontyde7OQNsIhhwlVmKnqdBtded586oCR0OWP
 03qPlzX6YLnpzRuAqUAAD8VnxHdIcMbbUD4kC4C1sjtZShAza9SSZfXQ3rpUHmgjczVt
 4JIc18IXuhXbNrJb5dyqDK/gRpgctFUJSzIqs6mF22TO0rSu6xlZuivRoESQnJOMAxJn
 cCBg==
X-Gm-Message-State: AOJu0YzCTqtNpsjTydPUsLrUXJLMDZ/00p+al92dgjKXZAS08H3K/ZyU
 1UABKztj+rjrIpDgKwn+PbtwYOCNfJn6UMQPAnKqqFKPUwRVXpOsPvKYaZJIVf0Fx8EQ1xy6tOK
 OjxgE/Adf1VKYTeFs92Qmfn+fiWPiMR4Mb/5wutozcg==
X-Gm-Gg: ASbGncu1XDJF9QTRX/Q6e1Vh2O+vBWf3wmM6iJ+fdpJM1YaoswHAcjRuSfBA0ejaImV
 l62rGYDz+4LgPXaNjBX/DCgqKDOV0+XxgFHVl4J1BIz5e5eq1O5mg7ehEkjzUpQ8Div+zYBxYxR
 PZtUphOIBrQhZWf8nZbehFIg6IrLz8gSAzphHldK1zBgqX7bzqU7tL5apOgKu6ff1MeFt8whI/x
 ezPhYat
X-Google-Smtp-Source: AGHT+IEIrfjQchYGTaYdJ9fDueopOflKyM/Fy9SUEIESjjgHj/yL9jnusxk4yqVXVousMxRaFS2fMjCUR3+PgAl8F40=
X-Received: by 2002:a05:620a:4489:b0:7e3:33e9:9d36 with SMTP id
 af79cd13be357-7e333e9aa0bmr515427485a.50.1752561539187; Mon, 14 Jul 2025
 23:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 15 Jul 2025 10:38:47 +0400
X-Gm-Features: Ac12FXx8uPq_qiGJqWcAi_8EI_cRDwe9jo9Ghxz32vXNoeGq_tg7HJgzLqA86kk
Message-ID: <CAJ+F1CL+qD=ahzoH1rsq7xhSYViR6PsHZJzQYnWHV-WMPpZrZQ@mail.gmail.com>
Subject: Re: [PULL v2 00/13] Ui patches
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x729.google.com
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

On Tue, Jul 15, 2025 at 10:36=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b5433=
36:
>
>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into s=
taging (2025-07-13 01:46:04 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to df892b3954e5b2782165e6c59e5ffd55c2f7ec5a:
>
>   tpm: "qemu -tpmdev help" should return success (2025-07-15 10:22:33 +04=
00)
>
> ----------------------------------------------------------------
> UI-related for 10.1
>
> - [PATCH v3 0/2] ui/vnc: Do not copy z_stream
> - [PATCH v6 0/7] ui/spice: Enable gl=3Don option for non-local or remote =
clients
> - [PATCH v6 0/1] Allow injection of virtio-gpu EDID name
> - [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option
>
> ----------------------------------------------------------------
>
> Akihiko Odaki (2):
>   ui/vnc: Do not copy z_stream
>   ui/vnc: Introduce the VncWorker type

Checkpatch complains with a false positive here:
ERROR: spaces required around that '*' (ctx:WxB)
#250: FILE: ui/vnc-enc-tight.c:356:
+        data =3D (uint##bpp##_t *)tight->tight.buffer;                    =
\
                               ^

ERROR: spaces required around that '*' (ctx:WxV)
#327: FILE: ui/vnc-enc-tight.c:614:
+                               uint##bpp##_t *buf, int w, int h) {      \
                                              ^

total: 2 errors, 0 warnings, 1790 lines checked

Please ignore

>
> Andrew Keesler (1):
>   hw/display: Allow injection of virtio-gpu EDID name
>
> Marc-Andr=C3=A9 Lureau (1):
>   tpm: "qemu -tpmdev help" should return success
>
> Vivek Kasireddy (7):
>   ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
>   ui/spice: Enable gl=3Don option for non-local or remote clients
>   ui/spice: Add an option for users to provide a preferred video codec
>   ui/spice: Add an option to submit gl_draw requests at fixed rate
>   ui/console-gl: Add a helper to create a texture with linear memory
>     layout
>   ui/spice: Create a new texture with linear layout when gl=3Don is
>     specified
>   ui/spice: Blit the scanout texture if its memory layout is not linear
>
> Weifeng Liu (2):
>   ui/gtk: Add keep-aspect-ratio option
>   ui/gtk: Add scale option
>
>  qapi/ui.json                        |  15 +-
>  qapi/virtio.json                    |  18 +-
>  include/hw/display/edid.h           |   2 +
>  include/hw/qdev-properties-system.h |   5 +
>  include/hw/virtio/virtio-gpu.h      |   3 +
>  include/ui/console.h                |   3 +
>  include/ui/gtk.h                    |   2 +
>  include/ui/spice-display.h          |   5 +
>  include/ui/surface.h                |   1 +
>  ui/vnc.h                            |  49 +--
>  hw/core/qdev-properties-system.c    |  44 +++
>  hw/display/virtio-gpu-base.c        |  27 ++
>  system/tpm.c                        |   5 +-
>  ui/console-gl.c                     |  54 ++++
>  ui/egl-helpers.c                    |   6 +
>  ui/gtk.c                            |  58 ++--
>  ui/spice-core.c                     |  32 ++
>  ui/spice-display.c                  | 226 +++++++++++++-
>  ui/vnc-enc-tight.c                  | 456 +++++++++++++++-------------
>  ui/vnc-enc-zlib.c                   |  47 +--
>  ui/vnc-enc-zrle.c                   | 122 ++++----
>  ui/vnc-jobs.c                       |  13 +-
>  ui/vnc.c                            |  83 +++--
>  ui/vnc-enc-zrle.c.inc               |  20 +-
>  qemu-options.hx                     |  13 +
>  25 files changed, 883 insertions(+), 426 deletions(-)
>
> --
> 2.50.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


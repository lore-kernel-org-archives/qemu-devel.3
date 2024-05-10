Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E28C25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PV2-0007Pr-80; Fri, 10 May 2024 08:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5PUz-0007PN-If
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:37:17 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5PUx-0004un-RQ
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:37:17 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43c5c5496a3so7860631cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 05:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715344635; x=1715949435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwIb6KOs81iuMrgx1+Sc2gNb0aC2qX2JeNjNBzM/Unk=;
 b=BDScOCf4/S1VtTqqsX1yWurUtW9kifPy9drOuXNBPVEqGdCca3pNZuqEcxxaI/G/FZ
 2KTZkqBPtuB8qLvS9zWH2uc8VNvI92augaeJ42/ac5JUcOWKywhW/eYmdfpV8zkaKEFA
 SYcE2TK236Q7dE78WoiWQcXpMCGvpKdMuw0dIxGBwUg1MkufIT1Cv9RKn5EwLSO2vb0j
 SUeMw8U4ATMR9tCvmfGY9vxMv06FPCVkvox4Vwy/Opy68xpbLxBMeEmkP6fk4jAcgdYV
 YFdWZnymBrHzlNkdFFTOnILwPs7MTPdU4uIhjsviNjtZLJAfPCWbZ5ks9jTXdVXwhKed
 itaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715344635; x=1715949435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwIb6KOs81iuMrgx1+Sc2gNb0aC2qX2JeNjNBzM/Unk=;
 b=nYO90fEK0aOAk3cdnmvbCQwQT+9kWU2mZGwoiVZDTSsDyMVk8eIQOEmGBWZB09IO/K
 tlO3C3iSwmDW9y9q8cFHs8sie+mAZDevJum3DEPBCzXjM0uKAeJ8kcDNXJrydaVbmGtD
 Srnk8Hm0Eo1+ZNtxf5T/TLj2OazhF/M3P6PieVYnf4D7TXiTnMq9plqaLerN24x5xUwe
 g6oW7UK9jKYHU1ZFkTNacy6XxuJmKdX5Qe/poZsvB6X+Z7q6Fj2tcI0DF8eBxMNU+y+D
 S5g928OQXGy2vVsHJ7AzxoIKhAPsst4aecV2vMwZL2KxhSP3DZEepA56Mrrtc3k+8LAJ
 e6pQ==
X-Gm-Message-State: AOJu0Yx7FsDsOZD9f95403I9M/loqeUd1BLU72hzUIJz6IVt0wphFO0U
 GlpqA+VBFwN6jQ/fkw7y8jpLdpujGTa9nu/SeX96c9Uw1kQYSFkYI3rO4D7Z3wpFnoK524Qi4MF
 MEYKqx5jSuCa7TWuX4R1MIk5ZCpw=
X-Google-Smtp-Source: AGHT+IHDJfHpOQXXiN7wRvTQuvJ5SgfPOJvC1vXTMBZzEshk3x4vNtdF8rXppmvG33Zi5svbmA0CRe6OkTlVL8Z5axc=
X-Received: by 2002:a05:622a:105:b0:43a:abcd:c770 with SMTP id
 d75a77b69052e-43dfdac276dmr28873991cf.26.1715344634634; Fri, 10 May 2024
 05:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240508175403.3399895-1-dongwon.kim@intel.com>
In-Reply-To: <20240508175403.3399895-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 May 2024 16:37:03 +0400
Message-ID: <CAJ+F1CKNb6degW2yHcNuoXTkxyDJJR-Bread0s8KRfL5Hmp_UQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/6] ui/console: Private QemuDmaBuf struct
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Wed, May 8, 2024 at 10:01=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This series introduces privacy enhancements to the QemuDmaBuf struct
> and its contained data to bolster security. it accomplishes this by
> introducing of helper functions for allocating, deallocating, and
> accessing individual fields within the struct and replacing all direct
> references to individual fields in the struct with methods using helpers
> throughout the codebase.
>
> This change was made based on a suggestion from Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com>
>
> (Resumitting same patch series with this new cover-leter)
>
> v6: fixed some typos in patch -
>     ui/console: Introduce dpy_gl_qemu_dmabuf_get_..() helpers)
>
> v7: included minor fix (ui/gtk: Check if fence_fd is equal to or greater =
than 0)
>     (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
>     migrated all helpers and QemuDmaBuf struct into dmabuf.c and their pr=
ototypes
>     to dmabuf.h for better encapsulation (ui/dmabuf: New dmabuf.c and dma=
buf.h..)
>     (Daniel P. Berrang=C3=A9 <berrange@redhat.com> and
>      Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
>     removed 'dpy_gl' from all helpers' names
>     Defined autoptr clean up function for QemuDmaBuf*
>     (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
>     Minor corrections
>
> v8: Introduce new dmabuf.c and dmabuf.h and all helper functions in the s=
econd
>     patch in the series (ui/console: new dmabuf.h and dmabuf.c for QemuDm=
a....)
>     (Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>)
>
> v9: set dmabuf->allow_fences true when it is created in virtio-gpu-udmabu=
f
>
>     removed unnecessary spaces were added in the patch,
>     'ui/console: Use qemu_dmabuf_new() a...'
>
> v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
>      GPL to be in line with QEMU's default license
>      (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
> v11: New helpers added - qemu_dmabuf_dup_fd, qemu_dmabuf_close for duplic=
ating
>      and closing dmabuf->fd. And use them in places where applicable.
>      (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
>      qemu_dmabuf_free helper now close dmabuf->fd before freeing the stru=
ct to
>      prevent any potential leakage (This eliminates the need for
>      qemu_dmabuf_close in several places as qemu_dmabuf_close is done any=
way.)
>      (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
> v12: --- qemu_dmabuf_free does not include qemu_dmabuf_close as there are=
 cases
>          where fd still needs to be used even after QemuDmaBuf struct is
>          destroyed (virtio-gpu: res->dmabuf_fd)
>
>      --- 'dmabuf' is now allocated space so it should be freed at the end=
 of
>          dbus_scanout_texture
>
> v13: --- Immediately free dmabuf after it is released to prevent possible
>          leaking of the ptr
>          (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
>      --- Use g_autoptr macro to define *dmabuf for auto clean up instead =
of
>          calling qemu_dmabuf_free
>          (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
> v14: In ui/console: Use qemu_dmabuf_new() and free() helpers instead
>
>      --- (vhost-user-gpu) Change qemu_dmabuf_free back to g_clear_pointer
>          as it was done because of some misunderstanding (v13).
>
>      --- (vhost-user-gpu) g->dmabuf[m->scanout_id] needs to be set to NUL=
L
>          to prevent freed dmabuf to be accessed again in case if(fd=3D=3D=
-1)break;
>          happens (before new dmabuf is allocated). Otherwise, it would ca=
use
>          invalid memory access when the same function is executed. Also N=
ULL
>          check should be done before qemu_dmabuf_close (it asserts dmabuf=
!=3DNULL.).
>          (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>

thanks, queued

> Dongwon Kim (6):
>   ui/gtk: Check if fence_fd is equal to or greater than 0
>   ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf struct and
>     helpers
>   ui/console: Use qemu_dmabuf_get_..() helpers instead
>   ui/console: Use qemu_dmabuf_set_..() helpers instead
>   ui/console: Use qemu_dmabuf_new() and free() helpers instead
>   ui/console: move QemuDmaBuf struct def to dmabuf.c
>
>  include/hw/vfio/vfio-common.h   |   2 +-
>  include/hw/virtio/virtio-gpu.h  |   4 +-
>  include/ui/console.h            |  20 +--
>  include/ui/dmabuf.h             |  49 +++++++
>  hw/display/vhost-user-gpu.c     |  32 +++--
>  hw/display/virtio-gpu-udmabuf.c |  27 ++--
>  hw/vfio/display.c               |  32 ++---
>  ui/console.c                    |   4 +-
>  ui/dbus-console.c               |   9 +-
>  ui/dbus-listener.c              |  71 +++++-----
>  ui/dmabuf.c                     | 229 ++++++++++++++++++++++++++++++++
>  ui/egl-headless.c               |  23 +++-
>  ui/egl-helpers.c                |  59 ++++----
>  ui/gtk-egl.c                    |  52 +++++---
>  ui/gtk-gl-area.c                |  41 ++++--
>  ui/gtk.c                        |  12 +-
>  ui/spice-display.c              |  50 ++++---
>  ui/meson.build                  |   1 +
>  18 files changed, 524 insertions(+), 193 deletions(-)
>  create mode 100644 include/ui/dmabuf.h
>  create mode 100644 ui/dmabuf.c
>
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


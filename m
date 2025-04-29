Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39067C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 08:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fuk-00051h-C3; Tue, 29 Apr 2025 04:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fui-00051N-N4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:02:00 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fug-0002JA-AW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 04:02:00 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-47664364628so70032191cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745913717; x=1746518517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPDzGVhU6MGC/Ugrwer7bSWmIYJ8B8q33RN2058R8gQ=;
 b=SonhHgRaUtuQqdgudDBcqz6bAAk6y1XJRGcBT46wVNMLLOE82n94qS7cWNT50BG5Vm
 3UdzzpcyP5OF+U8ycVkYlkgMa5xx+DmGVM1f1yeZTZj57BQyCcEIgnbWRZIUXbPAHH4J
 jhPHmJtDjBcuHFH7ZREoRM5fDUZAIsBWrldOh9Gb7lVe8NX1ANPYk+IDLofwAkXPNfZJ
 XUkijDjhInoBJq+aZCoWmqZo/s4hJDrVls2ThV9E+CW3aYNnOhi2H6ZVSF++j7tjr2D8
 FFhyrM9ThVHzRLdDslL6bBaXAyvbuQ4ifPM9Bf1ORaySaQvakyg54LwDBrWyFTijuwNt
 wNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745913717; x=1746518517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPDzGVhU6MGC/Ugrwer7bSWmIYJ8B8q33RN2058R8gQ=;
 b=PMlYMqH1qu2ftOEO+qgsWr665IDy7PAx45Ct0PKHk6rJAdCr25gWJALPTEK5pLdkHJ
 4WeUkpAMbvRejvtU+6lxjnAkL4qZC3o96Fp22TdCcrqhct9s1FYBLC78Ojn8Iroj9+D+
 uzLR8kPApQVNtbCWUXedpyaIbWfSwpU+uMf812gjv6HZ1wyb5Onu+e8hWowcFyjaFX20
 7kCLXI8O7h+FDADVezo+OIdt5w/rcPyhC7rgbHrqyO8OKEEfom7oSgkaE/wbVdgYsmy4
 rWWxH14ody+mUZCaJ1fDsgYTAiRVNBUcv6A0y4GjesfhuqtkjWOlXaXQGflAAB66Zaks
 fRxQ==
X-Gm-Message-State: AOJu0Yxt7uSDVpW6XZ5Ci8N2jMMqtBCn0n8h5irQ2/c3nYBPlnoFr8yc
 82DXXFVAsUhNq2rxdPQM6URNFq7XKHqPVaNZaoQ9kqEx9OMMKER8sqh6GmDllbkAOmW9R+lwPWQ
 cGc1kXy/OL4cvM/uvL+UIARU3Y7c=
X-Gm-Gg: ASbGncsL2up6jIjHHD+nhG5L/UNR44QVVLuDdnNiK0Jg8q4bTK9nK/zt5OdOzi4UC8R
 Mb0o8ll3JenIHFA3k0LQyKNdcwP2378Y4FIsvFOLMF2CpSU6VIx/MStF2tKZXZkNZQuWpI0AcgZ
 AJQwAqoVYFnY24ySYpaEp1klWd6f2hBSR4YEB0ukooOoQavfjN7cm195M=
X-Google-Smtp-Source: AGHT+IGyS3fBxq7WGG/SPKnQBuqEMrPVk9Y3yR6l+4c3Y6RIE3L3gyaA7qVmW/pzQfL2hhTId89uCGD1QQRS9pnm38I=
X-Received: by 2002:a05:622a:610d:b0:475:19cc:a81a with SMTP id
 d75a77b69052e-4885b09e371mr33559281cf.21.1745913716820; Tue, 29 Apr 2025
 01:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
In-Reply-To: <20250429060952.59508-1-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 12:01:44 +0400
X-Gm-Features: ATxdqUG12DDQRqU-iQTUPc_JnQOPU0zTu0MZhhCVZeHzeNZidB4exCqSz7MkZIU
Message-ID: <CAJ+F1CJA1qH5sm+E7e4yD7vdZsOGczYY-w+FD2j3zynX9t5Bjw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ui/spice: Enable gl=on option for non-local or
 remote clients
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, 
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 Dongwon Kim <dongwon.kim@intel.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi Vivek

On Tue, Apr 29, 2025 at 10:13=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> To address the limitation that this option is incompatible with
> remote clients, this patch series adds an option to select a
> preferred codec and also enable gl=3Don option for clients that
> are connected via the network. In other words, with this option
> enabled (and the below linked Spice series merged), it would be
> possible to have Qemu share a dmabuf fd with Spice, which would
> then forward it to a hardware or software based encoder and
> eventually send the data associated with the fd to a client that
> could be located on a different machine.
>
> Essentially, this patch series provides a hardware accelerated,
> opensource VDI option for users using Qemu and Spice by leveraging
> the iGPU/dGPU on the host machine via the Gstreamer framework.
>

Could you explain why Spice or GStreamer can't handle a non-linear
texture layout? It feels like a limitation that is not under QEMU
responsibility, I am not sure it should have to do it.

Btw, the series will likely have conflicts with "ui: support multi
plane texture", which I think we should merge first.
(https://patchew.org/QEMU/20250327025848.46962-1-yuq825@gmail.com/)

> v2 -> v3:
> - Check for errors after invoking glImportMemoryFdEXT() using
>   glGetError() and report the error to user (Dmitry)
>
> v1 -> v2:
> - Replace the option name preferred-codec with video-codecs (Marc-Andr=C3=
=A9)
> - Add a warning when an fd cannot be created from texture (Marc-Andr=C3=
=A9)
> - Add a new patch to blit the scanout texture into a linear one to
>   make it work with virgl
> - Rebased and tested against the latest Spice master
>
> Tested with the following Qemu parameters:
> -device virtio-vga,max_outputs=3D1,xres=3D1920,yres=3D1080,blob=3Dtrue
> -spice port=3D3001,gl=3Don,disable-ticketing=3Don,video-codecs=3Dgstreame=
r:h264
>
> and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.
>
> Associated Spice server MR (merged):
> https://gitlab.freedesktop.org/spice/spice/-/merge_requests/229
>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Vivek Kasireddy (6):
>   ui/spice: Add an option for users to provide a preferred codec
>   ui/spice: Enable gl=3Don option for non-local or remote clients
>   ui/spice: Submit the gl_draw requests at 60 FPS for remote clients
>   ui/console-gl: Add a helper to create a texture with linear memory
>     layout
>   ui/spice: Create a new texture with linear layout when gl=3Don is
>     enabled
>   ui/spice: Blit the scanout texture if its memory layout is not linear
>
>  include/ui/console.h       |   2 +
>  include/ui/spice-display.h |   4 +
>  qemu-options.hx            |   5 +
>  ui/console-gl.c            |  28 ++++++
>  ui/spice-core.c            |  16 ++++
>  ui/spice-display.c         | 184 +++++++++++++++++++++++++++++++++----
>  6 files changed, 223 insertions(+), 16 deletions(-)
>
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


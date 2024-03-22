Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46993C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaqz-000615-5z; Fri, 22 Mar 2024 05:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqx-00060q-Kx
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:19 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqw-00034S-2l
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:19 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-429de32dad9so12401411cf.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098377; x=1711703177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHTCs5FcjXLntKpcU5I8cgwfWVTfiUhEy4nN7RWwNG0=;
 b=O71GecqIVL3hKbnKmlYjc+FnxXnSB4eklqApjfUP84Qysn6UN32uACqgi4ExJ9uE16
 /3vxcJWtu1xSELYAMJwlfDT4qxOdBbkkcd07yGNUPr4C90LK95BDj3CeRK+G39ho7ER2
 6U6MNRKj5sNWsvFs/Cc/WRMWOg+TNMMFcqHVqOd4QHr8Wk2XSthIyz0Swc85BT7Lr8Jv
 BFvgeWk6a9d/wHZCyWlVn3j4xYLMtipax5f9g5nwaTqVKcJsmS+wjmDZRCVtfljwrzTs
 gdKncMtwyK0k4mge/CvcDIVesfm6Eb0Ol3JU1mz7hWZBL39eRznvVOKPaAiP4ZTHK4Qi
 XKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098377; x=1711703177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHTCs5FcjXLntKpcU5I8cgwfWVTfiUhEy4nN7RWwNG0=;
 b=viZPhKDrnmQUJWZp+1Mp8yHt3924a8aUV96sXdQotj2pZpx6QC26bOQNEj2oBajob/
 j2WcDV0bidjnAynkhJHrA7RpJCz8Xd4Ufx8i3Mym07eH3/eD127WePeUqyqKZ0iwIqHb
 ZUJwseYUz0IfYMAQNtZDiZBUChUC40y6ReRKjiZQK/hEZEwDcERQmfHeabgKD8tJqyP/
 set3iPLMPVZh8tPkFqtSu1orDynxQOD4GSRkuuQbtzCrT+qKLCBaYH1AFFuKQakxWzxe
 ZbiXXQgukAWOWB7F+pPoCUdoR0ZN/FYPwDK41TAZ7N72DFc3pS8QLEs2yP+MgbXYdaKx
 S4QQ==
X-Gm-Message-State: AOJu0Yz6l4yRFywW9PobiWo4o0deBmjD4RrFVtoDgrR+/cSOKBTXSg9j
 pz0k7h1zpxTTb23jr0vHrIfV6KtRnVmMrRNCVI6eZvDp/G1GAgWdqBG7L6s55XkUmWfldKir06I
 vqIIgJpiDVwoCmUCHCE8e08BAbxs=
X-Google-Smtp-Source: AGHT+IEHyojiE7Y4jA3x5Dd5khtnj76tF1pUTALAQ2eO1dB7yXeVzkyunpuHQQNyKqYw396mc5PNledgIac4rD/JUQ4=
X-Received: by 2002:ac8:7fcb:0:b0:430:abd3:2684 with SMTP id
 b11-20020ac87fcb000000b00430abd32684mr1532429qtk.48.1711098376848; Fri, 22
 Mar 2024 02:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
 <20240321234236.3476163-3-dongwon.kim@intel.com>
In-Reply-To: <20240321234236.3476163-3-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Mar 2024 13:06:05 +0400
Message-ID: <CAJ+F1C+175z2QCewYxt0KqhhxLwrxeymKv+pJhYdRVyYY+KAzg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ui/console: Introduce dpy_gl_dmabuf_get_fd() helper
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Fri, Mar 22, 2024 at 3:45=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> dpy_gl_dmabuf_get_fd() is a helper for retrieving FD of the dmabuf
> from QemuDmaBuf struct.
>

Same remarks as previous patch regarding exhaustivity, setter,
accepting NULL argument etc.

> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h | 1 +
>  hw/vfio/display.c    | 8 +++++++-
>  ui/console.c         | 9 +++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 6064487fc4..d5334a806c 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -360,6 +360,7 @@ void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
>  uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
>  void dpy_gl_release_dmabuf(QemuConsole *con,
>                             QemuDmaBuf *dmabuf);
>  void dpy_gl_update(QemuConsole *con,
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index c962e5f88f..676b2fc5f3 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -259,9 +259,15 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDe=
vice *vdev,
>
>  static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *d=
mabuf)
>  {
> +    int fd;
> +
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
> +    fd =3D dpy_gl_dmabuf_get_fd(&dmabuf->buf);
> +    if (fd > -1) {
> +        close(fd);
> +    }

The current code assumes that fd is valid. Why should we change that?


> +
>      dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> -    close(dmabuf->buf.fd);

>      g_free(dmabuf);
>  }
>
> diff --git a/ui/console.c b/ui/console.c
> index 1d0513a733..69560aac7e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1504,6 +1504,15 @@ int qemu_console_get_height(QemuConsole *con, int =
fallback)
>      }
>  }
>
> +int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> +{
> +    if (dmabuf) {
> +        return dmabuf->fd;
> +    }
> +
> +    return -1;
> +}
> +
>  int qemu_invalidate_text_consoles(void)
>  {
>      QemuConsole *s;
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau


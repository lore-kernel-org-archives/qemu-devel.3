Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81A6C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 05:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u60jD-0003lh-5u; Sat, 19 Apr 2025 01:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u60j7-0003lI-LR
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 01:26:53 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u60j6-0000LW-1n
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 01:26:53 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-47686580529so26853311cf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745040411; x=1745645211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyuR80U7GxF7aTu858BPNKhHlA3/sJumM+aw94CdUDc=;
 b=dTIthN9LXU9E09FsDWujX3ZYMPOVmWlD1QeUkp7y2UgjKkNXyuKMCUMeeQt/JSujmN
 CY3Q79f+ekDDeEqm91na3h96t9gdL/b3OB2JHGku2hIGgoa4haEkRMYREzwXtHu6wa2h
 AcUreaBJJFF5tV2nk9NbBfEjwTOKp+u0rltjQtyYm+ej4wtrpmhz2hkS1OxbM7AcpVzP
 XoPcxxZKVQB9Nliv3/I3a5oq0eOCZacIj3RbL95JSN1JulJE4X48hXdNtkx6LOLIWTkc
 XmaGW3YB7Zq6HgpGLQrqnVQBtJOc3rGuQCYZcNoYOApzwZ1vFNGtvnNPUioKlf+/cB4v
 x7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745040411; x=1745645211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyuR80U7GxF7aTu858BPNKhHlA3/sJumM+aw94CdUDc=;
 b=VaCeYrwEGk0vw+7YVFYVCuoCXH43Bo+oZqG3/ndPX6U9euNRy8BIQYF6jpQbGv0CEv
 ogkxPc00vbv3qGZr63l9uqU41pmzzOi/m+58KhJnTG4jGvs5MzuylGBM9/wE30zIGw1O
 SLVTGAGfgg2cc5twgW5nYBFj7J9xUtu9T6IRBoE3YB3En9w4kSfC7tBoUNlG0HBr34JF
 cGzhk768wJkgi/+3NUemKasVB902uTNzAnTH0WBGC3HfJvFj1PhMFYLvKwf6kYqRa66N
 8tt/Ek5Ihd80i6ZX1iBtSTVPHhN4IUtiPeW5RIPusur3YYjLYK4BnshguYBjFSbMpBvE
 q88A==
X-Gm-Message-State: AOJu0YzrsgNBtjvQzJ2EC7XOOrorAY6IBzFeXw2tOPVDE85vtbFIcoMV
 Lj5WrsHD69NHRSHeEqguEeEz1kQn/vx7cgZrzoLNUB5uQIQxNUQB5TM9f65X6z0tVRvPCKJKaHT
 gi5zr5sgFiz2PmWAnuco4iEl3fJaVK/OL9oXQiw==
X-Gm-Gg: ASbGnct6M4Gv2UwZpKD8Yi86ql0jSMU2unV5bezqFW0e3oUvmHkuCUrl0GiIVOlqndl
 eiq9NVrg3L21hTfMfg63/NyJQNoBNEPEw6rrY0RbbNLgIYdgwusyxu3Nppz/z753/27tpTMWFO7
 synS5uCCPKBN8fSp3gJIdWveDOS9LP2iMu4w==
X-Google-Smtp-Source: AGHT+IH8X5PKCXFcp40WxkPVmdCsI4HdROYkmk3lkIOx1Tu9ZLxchFhTGor406NLQiacqdVgJSYLe9mIYQnhwkLuXdY=
X-Received: by 2002:ac8:5d04:0:b0:476:ac97:b970 with SMTP id
 d75a77b69052e-47aec4bdf0cmr74778131cf.52.1745040410910; Fri, 18 Apr 2025
 22:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-4-dietmar@proxmox.com>
In-Reply-To: <20250418112953.1744442-4-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 19 Apr 2025 09:26:37 +0400
X-Gm-Features: ATxdqUFL4BOt9WVDBACwPE385w6PeNb7vO0Kj8u5jfsFQOIhGjPeNqb3O2H-F3s
Message-ID: <CAJ+F1CLZjQ-BtjF_kjBD6iv3pRf3W1gd9TzBdG-VGypM=Ezfpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vnc: h264: send additional frames after the
 display is clean
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Fri, Apr 18, 2025 at 3:54=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> The H264 implementation only sends frames when it detects changes in
> the server's framebuffer. This leads to artifacts when there are no
> further changes, as the internal H264 encoder may still contain data.
>
> This patch modifies the code to send a few additional frames in such
> situations to flush the H264 encoder data.
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

(from v1)
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vnc.c | 25 ++++++++++++++++++++++++-
>  ui/vnc.h |  3 +++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index aed25b0183..badc7912c0 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3239,7 +3239,30 @@ static void vnc_refresh(DisplayChangeListener *dcl=
)
>      vnc_unlock_display(vd);
>
>      QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
> -        rects +=3D vnc_update_client(vs, has_dirty);
> +        int client_dirty =3D has_dirty;
> +        if (vs->h264) {
> +            if (client_dirty) {
> +                vs->h264->keep_dirty =3D VNC_H264_KEEP_DIRTY;
> +            } else {
> +                if (vs->h264->keep_dirty > 0) {
> +                    client_dirty =3D 1;
> +                    vs->h264->keep_dirty--;
> +                }
> +            }
> +        }
> +
> +        int count =3D vnc_update_client(vs, client_dirty);
> +        rects +=3D count;
> +
> +        if (vs->h264 && !count && vs->h264->keep_dirty) {
> +            VncJob *job =3D vnc_job_new(vs);
> +            int height =3D pixman_image_get_height(vd->server);
> +            int width =3D pixman_image_get_width(vd->server);
> +            vs->job_update =3D vs->update;
> +            vs->update =3D VNC_STATE_UPDATE_NONE;
> +            vnc_job_add_rect(job, 0, 0, width, height);
> +            vnc_job_push(job);
> +        }
>          /* vs might be free()ed here */
>      }
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index a0d336738d..a5ea134de8 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -236,10 +236,13 @@ typedef struct VncZywrle {
>  } VncZywrle;
>
>  #ifdef CONFIG_GSTREAMER
> +/* Number of frames we send after the display is clean. */
> +#define VNC_H264_KEEP_DIRTY 10
>  typedef struct VncH264 {
>      GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
>      size_t width;
>      size_t height;
> +    guint keep_dirty;
>  } VncH264;
>  #endif
>
> --
> 2.39.5
>
>


--=20
Marc-Andr=C3=A9 Lureau


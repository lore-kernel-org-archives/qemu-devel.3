Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C0EC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Mqm-0000zF-Q2; Mon, 28 Apr 2025 07:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9Mqa-0000rA-Hv
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:40:28 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9MqX-00089j-Ts
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 07:40:27 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-47692b9d059so87303051cf.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840424; x=1746445224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LM9ijuhVDEFEzzp6c/nUKd7I+/FBCwu6/bgEAXUt2Go=;
 b=S7m0Y2OsE19bm7Gx6Lw4niriXnbc91IroFNBhMgxRGObyPk72NfgPhxuRni7wsq8Br
 fsaRFAjdfXXDP86rXOPGfElQOby36H1/jdEWV9A4VGPKOGzd7tgwqzznhatVxTVEVjW+
 44W/NU0K4KU3U50dBp3Kw3qLHP5AjR2+cd4UBuHpyfJxukf28lLOenuZskn2zAM2bwMl
 Ez/7CAJE0sZCu9d/elYp0xSg8udorSBQ9xke6CrPkV43o3GN40VAMAfuh7zMxf3syvMq
 CmQvaBNDDeAHaQDW1DY1WoL4Emf4nCHbIvBgRQO1gB17PRH6fPS9HmMvW8BtCCtoN1x3
 MApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840424; x=1746445224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LM9ijuhVDEFEzzp6c/nUKd7I+/FBCwu6/bgEAXUt2Go=;
 b=qA2SvoIE5MC38L9NiGwJrQ4eQlWVTjicyKOahrIO5SzXyjWevF5QOwxoqsS/0CHFXH
 K4hRsfe3sPdgg1f8VXl8Z8jzalNT/k1A9IcXiPYRXRJYEtjMX/Pq3HmyYFJt6F/QQYeC
 7SJWX27fdn41TwfktegmPrd76cOdJq+0oVWE7REEf0lca3Eu4jRBG8IKEGmPseFxTqfO
 HlSS0+ILdWXlieRmnJolforESSNu6XnRdfxpTtwe42v5+nvbDF6f4sqIOyP+538psL8l
 eiE2CKjDLMppE/laXdiCYtkgzAatoQoMva1iTsoygRFpTc+ZVfZQ/8xJFOzYHCxiay3b
 zYqQ==
X-Gm-Message-State: AOJu0YxNmyZK4KHGvC1KAOa63g12G/lRdOZVETkjs4x4kjgZT+fUnyrq
 6y+d4k23lOQV44iKOhczXVn+BrMRfxqvm5yK2X4fxuRgrvAc1ZIyYH5wk5HG9R4xM5TzCt1rvMP
 7ePDENpvBWfdEpEFKpTUe5+y8Okw=
X-Gm-Gg: ASbGncvArbNk15q9hufbad/jzZGfqISOOgoeT1fMhJL80k4TL9RNDDKufIBVnzui1IF
 xSde4F35toKnmqu4LyxXYj9qyx4JatY7rCVQcgODjAVuBEUMCKtRf7hw1hOTw9y+VangR72V1vG
 9KGDtD04nZZkAvBdGOLmOgaPfGFPYtbiExeS7WyE7FHJAcxND6d1P/xEJpVbO2Z0QPwA==
X-Google-Smtp-Source: AGHT+IG+AZcsjUQtAdRsQNb4X4sX3qN+v7TFiEjBcrJG3ChcxztQgV+ntV7k6pIpGLf6z4CvZJd/qrN384AFEVV49jw=
X-Received: by 2002:ac8:5715:0:b0:476:8e3e:2da3 with SMTP id
 d75a77b69052e-48131de3b89mr130858681cf.30.1745840424518; Mon, 28 Apr 2025
 04:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250428080336.2574852-1-dietmar@proxmox.com>
 <20250428080336.2574852-9-dietmar@proxmox.com>
In-Reply-To: <20250428080336.2574852-9-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Apr 2025 15:40:12 +0400
X-Gm-Features: ATxdqUEO8fXkxTW1TlVmzla6hU0AQE8bgSH6231GWVRP7WICwpU51e3kTLYTuA8
Message-ID: <CAJ+F1CJ7=qGN6FiWjK2kQUv8gf_QaFrHDDJCEMOgAkQ_OkuE5A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] h264: stop gstreamer pipeline before destroying,
 cleanup on exit
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

On Mon, Apr 28, 2025 at 12:06=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.co=
m> wrote:
>
> Some encoders can hang indefinitely (i.e. nvh264enc) if
> the pipeline is not stopped before it is destroyed
> (Observed on Debian bookworm).
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>

In file included from /home/elmarco/src/qemu/include/ui/console.h:4,
                 from ../system/runstate.c:54:
/home/elmarco/src/qemu/include/ui/qemu-pixman.h:10:10: fatal error:
pixman.h: No such file or directory
   10 | #include <pixman.h>
      |          ^~~~~~~~~~

Also it will have to handle the case when !CONFIG_VNC (can probably
use a stub cleanup function)

> ---
>  include/ui/console.h |  1 +
>  system/runstate.c    |  2 ++
>  ui/vnc-enc-h264.c    | 18 ++++++++++++++++++
>  ui/vnc.c             | 15 +++++++++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 46b3128185..ff46e9fe98 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -458,6 +458,7 @@ int vnc_display_password(const char *id, const char *=
password);
>  int vnc_display_pw_expire(const char *id, time_t expires);
>  void vnc_parse(const char *str);
>  int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
> +void vnc_cleanup(void);
>  bool vnc_display_reload_certs(const char *id,  Error **errp);
>  bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
>
> diff --git a/system/runstate.c b/system/runstate.c
> index 272801d307..4b2c6f3525 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -51,6 +51,7 @@
>  #include "qemu/thread.h"
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
> +#include "ui/console.h"
>  #include "system/cpus.h"
>  #include "system/qtest.h"
>  #include "system/replay.h"
> @@ -924,6 +925,7 @@ void qemu_cleanup(int status)
>      job_cancel_sync_all();
>      bdrv_close_all();
>
> +    vnc_cleanup();
>      /* vhost-user must be cleaned up before chardevs.  */
>      tpm_cleanup();
>      net_cleanup();
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 98055c095f..6618f156b4 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c
> @@ -95,6 +95,24 @@ static GstElement *create_encoder(const char *encoder_=
name)
>
>  static void destroy_encoder_context(VncState *vs)
>  {
> +    GstStateChangeReturn state_change_ret;
> +
> +    VNC_DEBUG("Destroy h264 context.\n");
> +
> +    /*
> +     * Some encoders can hang indefinitely (i.e. nvh264enc) if
> +     * the pipeline is not stopped before it is destroyed
> +     * (Observed on Debian bookworm).
> +     */
> +    if (vs->h264->pipeline !=3D NULL) {
> +        state_change_ret =3D gst_element_set_state(
> +            vs->h264->pipeline, GST_STATE_NULL);
> +
> +        if (state_change_ret =3D=3D GST_STATE_CHANGE_FAILURE) {
> +            VNC_DEBUG("Unable to stop the GST pipeline\n");
> +        }
> +    }
> +
>      gst_clear_object(&vs->h264->source);
>      gst_clear_object(&vs->h264->convert);
>      gst_clear_object(&vs->h264->gst_encoder);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 2d1e741705..062d6af0ab 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4366,6 +4366,21 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Er=
ror **errp)
>      return 0;
>  }
>
> +void vnc_cleanup(void)
> +{
> +    VncDisplay *vd;
> +    VncState *vs;
> +
> +    QTAILQ_FOREACH(vd, &vnc_displays, next) {
> +        QTAILQ_FOREACH(vs, &vd->clients, next) {
> +#ifdef CONFIG_GSTREAMER
> +            /* correctly close all h264 encoder pipelines */
> +            vnc_h264_clear(vs);
> +#endif
> +        }
> +    }
> +}
> +
>  static void vnc_register_config(void)
>  {
>      qemu_add_opts(&qemu_vnc_opts);
> --
> 2.39.5
>
>


--=20
Marc-Andr=C3=A9 Lureau


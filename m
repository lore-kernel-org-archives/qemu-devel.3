Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C41C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 10:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6o3W-0003jK-Ro; Mon, 21 Apr 2025 06:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6o3R-0003ip-W1
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6o3L-0002yH-CT
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745230018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkYhyKW4FDK3HKMPejUYYr0NFFuLMhwkYXWZzTmCvb0=;
 b=Hs4ItJQ2VV74YQigvpHrhn56PtYxaMTjtxhEnmyVhhbM7da/Kx+wGtT8nE912YXMpzSXQ6
 TWZELWRqqPr36mngeWwPmNPzrgYrUWwkaBR+1wc454g/T5bELQXrKRU1MdXOdX3SlrfZaf
 j/xYMxRsPzVurNki+KteoDCUCRttUxg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-XFfpxJ2UO5WfO6oe4PBV9A-1; Mon, 21 Apr 2025 06:06:54 -0400
X-MC-Unique: XFfpxJ2UO5WfO6oe4PBV9A-1
X-Mimecast-MFC-AGG-ID: XFfpxJ2UO5WfO6oe4PBV9A_1745230014
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767348e239so78968741cf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 03:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230014; x=1745834814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkYhyKW4FDK3HKMPejUYYr0NFFuLMhwkYXWZzTmCvb0=;
 b=oV9LsUrcVJ62SLh60MZA568LEFT0qmg10QCNOWAcSjDcCbrL0ukdZK5fyOPNhJbJi6
 js6l9wII4evv+wfeg+ZckYKuTQ8lQMCUsw4a8NY5W2U2WPGiQ4f+jlLadQlllNBseGRo
 7aMWt2/jaqflaJ4Rvy5FAzNx3VvIiM2o7b5fAiBSlf9bypS8LGjVRUB4Z2OttQNoYYAL
 HmbOzXG8xSUsS40cn1kbNrkdnxdU1GVFMTiegY9RSuZaX4AOUaVlhmC8nIV/YPgwaT7n
 zRbHFTD8ZWsdN+5YMMsygx27OehR52a2k0OiOhe2AI39aVkhti9k3vUGEExGv1T7qJEo
 PLLA==
X-Gm-Message-State: AOJu0Yz9XW5PtXZ9gkC8FO/Jnd+Gf7IQak6FZDqChL0Y/l1xmxLKmclk
 xN6E3b9GNQSwLIE5Y6SGa8nZZsd2M2UWSfCkNMoqPjbGoHM1iNsO9MQfPDr/GypRZMPTwajerk6
 uUL0F4paH9lHZ8PziQue17GgOZ/m0z2oaxHhYdKMxE+bPmEU5ZxvZpHJpSrPrd3IyXF4xTglkA8
 wZXFbQHBQGX3jFhG42wADRJLhtcUfLskMF+qI=
X-Gm-Gg: ASbGnctmHXMmyCAmi9HfjF+t57fkxs5pvu/AyOuO8rQVtGvwzmZACMC8/k0XYgGFpYk
 RRd8Xk31a3wOvg/n0gXDwLsmfdzkNGehXpdd/kbwSumnihDRHQ9foGJAfJvLy1LkGg0w1Cw==
X-Received: by 2002:ac8:5ac7:0:b0:477:6eca:b40c with SMTP id
 d75a77b69052e-47aec36b3e4mr207957881cf.1.1745230014113; 
 Mon, 21 Apr 2025 03:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAWMENZBFI7M4eXEhfOIrsZ/248QkSD/G3k3FNsmokY4xd7n7/BzKQoacM9oyOduPXi80o26ZDUtooLRKS6cg=
X-Received: by 2002:ac8:5ac7:0:b0:477:6eca:b40c with SMTP id
 d75a77b69052e-47aec36b3e4mr207957591cf.1.1745230013645; Mon, 21 Apr 2025
 03:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-6-dietmar@proxmox.com>
In-Reply-To: <20250418112953.1744442-6-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Apr 2025 14:06:41 +0400
X-Gm-Features: ATxdqUFbOL4bwYvmtCMHf0LACddCljv4uqZ9XZpknV1yE4PebO5fcuxIp1G9hZY
Message-ID: <CAMxuvay1KwnOWCjJ9ND3reF-pWa4ZDWy=Y0A5AQ+LH17oC2V_A@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] h264: new vnc option to configure h264 at server
 side
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 18, 2025 at 3:30=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> Values can be 'on', 'off', or a space sparated list of

separated

> allowed gstreamer encoders.
>
> - on: automatically select the encoder

'auto' then (default?)

> - off: disbale h264

disable

'auto'/'off' but there should be 'on' too.

> - encoder-list: select first available encoder from that list.

This should be a different option.

>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc-enc-h264.c | 30 ++++++++++++++++++++++--------
>  ui/vnc.c          | 25 ++++++++++++++++++++-----
>  ui/vnc.h          |  6 +++++-
>  3 files changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 047f4a3128..0f89cafbf6 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c
> @@ -27,13 +27,21 @@
>
>  #include <gst/gst.h>
>
> -const char *encoder_list[] =3D { "x264enc", "openh264enc", NULL };
> -
> -static const char *get_available_encoder(void)
> +static char *get_available_encoder(const char *encoder_list)
>  {
> +    g_assert(encoder_list !=3D NULL);
> +
> +    if (!strcmp(encoder_list, "")) {
> +        /* use default list */
> +        encoder_list =3D "x264enc openh264enc";
> +    }
> +
> +    char *ret =3D NULL;
> +    char **encoder_array =3D g_strsplit(encoder_list, " ", -1);
> +
>      int i =3D 0;
>      do {
> -        const char *encoder_name =3D encoder_list[i];
> +        const char *encoder_name =3D encoder_array[i];
>          if (encoder_name =3D=3D NULL) {
>              break;
>          }
> @@ -41,12 +49,15 @@ static const char *get_available_encoder(void)
>              encoder_name, "video-encoder");
>          if (element !=3D NULL) {
>              gst_object_unref(element);
> -            return encoder_name;
> +            ret =3D strdup(encoder_name);
> +            break;
>          }
>          i =3D i + 1;
>      } while (true);
>
> -    return NULL;
> +    g_strfreev(encoder_array);
> +
> +    return ret;
>  }
>
>  static GstElement *create_encoder(const char *encoder_name)
> @@ -220,11 +231,13 @@ static bool create_encoder_context(VncState *vs, in=
t w, int h)
>
>  bool vnc_h264_encoder_init(VncState *vs)
>  {
> -    const char *encoder_name;
> +    char *encoder_name;
>
>      g_assert(vs->h264 =3D=3D NULL);
> +    g_assert(vs->vd !=3D NULL);
> +    g_assert(vs->vd->h264_encoder_list !=3D NULL);
>
> -    encoder_name =3D get_available_encoder();
> +    encoder_name =3D get_available_encoder(vs->vd->h264_encoder_list);
>      if (encoder_name =3D=3D NULL) {
>          VNC_DEBUG("No H264 encoder available.\n");
>          return -1;
> @@ -336,6 +349,7 @@ void vnc_h264_clear(VncState *vs)
>      }
>
>      destroy_encoder_context(vs);
> +    g_free(vs->h264->encoder_name);
>
>      g_clear_pointer(&vs->h264, g_free);
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index badc7912c0..feab4c0043 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2190,11 +2190,11 @@ static void set_encodings(VncState *vs, int32_t *=
encodings, size_t n_encodings)
>              break;
>  #ifdef CONFIG_GSTREAMER
>          case VNC_ENCODING_H264:
> -            if (vnc_h264_encoder_init(vs)) {
> -                vnc_set_feature(vs, VNC_FEATURE_H264);
> -                vs->vnc_encoding =3D enc;
> -            } else {
> -                VNC_DEBUG("vnc_h264_encoder_init failed\n");
> +            if (vs->vd->h264_encoder_list !=3D NULL) { /* if h264 is ena=
bled */
> +                if (vnc_h264_encoder_init(vs)) {
> +                    vnc_set_feature(vs, VNC_FEATURE_H264);
> +                    vs->vnc_encoding =3D enc;
> +                }
>              }
>              break;
>  #endif
> @@ -3634,6 +3634,9 @@ static QemuOptsList qemu_vnc_opts =3D {
>          },{
>              .name =3D "power-control",
>              .type =3D QEMU_OPT_BOOL,
> +        },{
> +            .name =3D "h264",
> +            .type =3D QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -4196,6 +4199,18 @@ void vnc_display_open(const char *id, Error **errp=
)
>      }
>  #endif
>
> +#ifdef CONFIG_GSTREAMER
> +    const char *h264_opt =3D qemu_opt_get(opts, "h264");
> +    if (!strcmp(h264_opt, "off")) {
> +        vd->h264_encoder_list =3D NULL; /* disable h264 */
> +    } else if  (!strcmp(h264_opt, "on")) {
> +        vd->h264_encoder_list =3D ""; /* use default encoder list */
> +    } else  {
> +        /* assume this is a list of endiers */
> +        vd->h264_encoder_list =3D h264_opt;
> +    }
> +#endif
> +
>      if (vnc_display_setup_auth(&vd->auth, &vd->subauth,
>                                 vd->tlscreds, password,
>                                 sasl, false, errp) < 0) {
> diff --git a/ui/vnc.h b/ui/vnc.h
> index e97276349e..789b18806b 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -188,6 +188,10 @@ struct VncDisplay
>      VncDisplaySASL sasl;
>  #endif
>
> +#ifdef CONFIG_GSTREAMER
> +    const char *h264_encoder_list;
> +#endif
> +
>      AudioState *audio_state;
>  };
>
> @@ -239,7 +243,7 @@ typedef struct VncZywrle {
>  /* Number of frames we send after the display is clean. */
>  #define VNC_H264_KEEP_DIRTY 10
>  typedef struct VncH264 {
> -    const char *encoder_name;
> +    char *encoder_name;
>      GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
>      size_t width;
>      size_t height;
> --
> 2.39.5
>



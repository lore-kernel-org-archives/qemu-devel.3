Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1A9C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 10:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6oAf-0006vl-G6; Mon, 21 Apr 2025 06:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6oAa-0006vM-IT
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u6oAY-0004Fz-0N
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 06:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745230467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjqvYCtu+Xy48/NkIFYKGBjNU8uDUZ6hh5wOnaTI26k=;
 b=UtL4Ewaw9tri3DVrPBCCV60KulWwSWyvaN6q2V5gKXHDbwdwRUqjl7U4oimQeKOFOZT71C
 FZHP4uM1VPA1F3KOhFDsEwGpQ77SsiyLO8J6Qn79YhudQPZc0mst/pw6wIPHt2SwK6tKd1
 cSSh8Z2KIfPPini51YxaItnvpPjjWQI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-d4MkDba0ORuGOeTy5TiRFA-1; Mon, 21 Apr 2025 06:14:25 -0400
X-MC-Unique: d4MkDba0ORuGOeTy5TiRFA-1
X-Mimecast-MFC-AGG-ID: d4MkDba0ORuGOeTy5TiRFA_1745230464
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47689968650so42566141cf.2
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 03:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230464; x=1745835264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjqvYCtu+Xy48/NkIFYKGBjNU8uDUZ6hh5wOnaTI26k=;
 b=P1XZ1fF4sgCoe3dXX4H/lm8+oNQhrx5+tXoJL1RhnOSItS5Xh4fYK0JruYbWNu0m4f
 Ujama/JDaDxBREyD1T9uuTRIA9BX5I7rjmHRCkITE/Ptl18CI9nLk/8wr23Xjxg+n4K3
 yGnKxFa7hHXotKL0AB+9BbMK2XJLJP7hNcPmw09CUg6WwR3pZgeEAXDUGp+dpZsofhyk
 Khu+/Ea2LGTIdU3CDo5s6Wt8P9Cim4C47KayEiNlJDNv1vtx+ZqqXIMrQcOIH9MdySQU
 uJ2wRVjVc9zjU7nd5CprDYQeV2F9g/8VRUYdweXGODehxv3VoGMkhqZiMbA6I0A6WshT
 0DCg==
X-Gm-Message-State: AOJu0YyacqOeGK8s+4hxJqu35YWYGRno0OvJMgjoSZnBMwLdcoScqvj9
 rnyteatTuwrg3uRfXnJ0hlGEH+pCpJAj3MZ+LTClJlWKJacg7cHic/X6vd4Ng3KflrXjnLaYEsy
 ULRWBKaK/wMipJl6BCPktFVvRBEy9yO5z/X1VhCgEHyPRtxtHqTXSdzQ28LQ710aSxPE84KXOxa
 lal3h31fcBlVDKkRgGWqJfvjGBNFQ=
X-Gm-Gg: ASbGncuOyI4GQevcLQtS6nT9m9Or8NwjXBEtQtAzsgmTCVp9rxTIA16tn/OnDToNjp9
 5SUult6c/kvoDCOYgrSYfGGCKgFM0NX+HcPiAGycfrCoLk8bciI891qTK95TuZNdKTvd1Bw==
X-Received: by 2002:a05:622a:607:b0:476:8a83:960f with SMTP id
 d75a77b69052e-47aec3cbe61mr175842991cf.17.1745230464473; 
 Mon, 21 Apr 2025 03:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH1H5W/SMo4GIQSgBcBaxPAFe3GOsXweXjde4GuUVI3XGAuWMRVX3D7Ss2dm0UzyCpQJ6xNml5xTVqKN/uyV4=
X-Received: by 2002:a05:622a:607:b0:476:8a83:960f with SMTP id
 d75a77b69052e-47aec3cbe61mr175842761cf.17.1745230464157; Mon, 21 Apr 2025
 03:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-10-dietmar@proxmox.com>
In-Reply-To: <20250418112953.1744442-10-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Apr 2025 14:14:11 +0400
X-Gm-Features: ATxdqUGANhD6hQMryyBCWVcJUOUyFGdY9gEyTSwCV2WEUwAuoWfiUP1kIg1gH1k
Message-ID: <CAMxuvaxniAvsag=UT9xWjU5f17ec6ua9hFBDB72iTnh4jiH4vg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] h264: register shutdown notifiers, stop pipeline
 in destroy_encoder_context
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
> Some encoders can hang indefinetly (i.e. nvh264enc) if

indefinitely

> the pipeline is not stopped before it is destroyed
> (Observed on Debian bookworm).

but why do you need the extra shutdown notifier?

>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc-enc-h264.c | 50 ++++++++++++++++++++++++++++++++++++++---------
>  ui/vnc.h          |  1 +
>  2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 840674dbdb..9dbfba3a16 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c
> @@ -23,6 +23,8 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "system/runstate.h"
> +
>  #include "vnc.h"
>
>  #include <gst/gst.h>
> @@ -114,13 +116,33 @@ static GstElement *create_encoder(const char *encod=
er_name)
>      return encoder;
>  }
>
> -static void destroy_encoder_context(VncState *vs)
> +static void destroy_encoder_context(VncH264 *h264)
>  {
> -    gst_clear_object(&vs->h264->source);
> -    gst_clear_object(&vs->h264->convert);
> -    gst_clear_object(&vs->h264->gst_encoder);
> -    gst_clear_object(&vs->h264->sink);
> -    gst_clear_object(&vs->h264->pipeline);
> +    GstStateChangeReturn state_change_ret;
> +
> +    g_assert(h264 !=3D NULL);
> +
> +    VNC_DEBUG("Destroy h264 context.\n");
> +
> +    /*
> +     * Some encoders can hang indefinetly (i.e. nvh264enc) if
> +     * the pipeline is not stopped before it is destroyed
> +     * (Observed on Debian bookworm).
> +     */
> +    if (h264->pipeline !=3D NULL) {
> +        state_change_ret =3D gst_element_set_state(
> +            h264->pipeline, GST_STATE_NULL);
> +
> +        if (state_change_ret =3D=3D GST_STATE_CHANGE_FAILURE) {
> +            VNC_DEBUG("Unable to stop the GST pipeline\n");
> +        }
> +    }
> +
> +    gst_clear_object(&h264->source);
> +    gst_clear_object(&h264->convert);
> +    gst_clear_object(&h264->gst_encoder);
> +    gst_clear_object(&h264->sink);
> +    gst_clear_object(&h264->pipeline);
>  }
>
>  static bool create_encoder_context(VncState *vs, int w, int h)
> @@ -132,7 +154,7 @@ static bool create_encoder_context(VncState *vs, int =
w, int h)
>
>      if (vs->h264->sink) {
>          if (w !=3D vs->h264->width || h !=3D vs->h264->height) {
> -            destroy_encoder_context(vs);
> +            destroy_encoder_context(vs->h264);
>          }
>      }
>
> @@ -239,10 +261,16 @@ static bool create_encoder_context(VncState *vs, in=
t w, int h)
>      return TRUE;
>
>   error:
> -    destroy_encoder_context(vs);
> +    destroy_encoder_context(vs->h264);
>      return FALSE;
>  }
>
> +static void shutdown_h264(Notifier *n, void *opaque)
> +{
> +    VncH264 *h264 =3D  container_of(n, VncH264, shutdown_notifier);
> +    destroy_encoder_context(h264);
> +}
> +
>  bool vnc_h264_encoder_init(VncState *vs)
>  {
>      char *encoder_name;
> @@ -259,6 +287,8 @@ bool vnc_h264_encoder_init(VncState *vs)
>
>      vs->h264 =3D g_new0(VncH264, 1);
>      vs->h264->encoder_name =3D encoder_name;
> +    vs->h264->shutdown_notifier.notify =3D shutdown_h264;
> +    qemu_register_shutdown_notifier(&vs->h264->shutdown_notifier);
>
>      VNC_DEBUG("Allow H264 using encoder '%s`\n", encoder_name);
>
> @@ -362,7 +392,9 @@ void vnc_h264_clear(VncState *vs)
>          return;
>      }
>
> -    destroy_encoder_context(vs);
> +    notifier_remove(&vs->h264->shutdown_notifier);
> +
> +    destroy_encoder_context(vs->h264);
>      g_free(vs->h264->encoder_name);
>
>      g_clear_pointer(&vs->h264, g_free);
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 789b18806b..ea52085b19 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -248,6 +248,7 @@ typedef struct VncH264 {
>      size_t width;
>      size_t height;
>      guint keep_dirty;
> +    Notifier shutdown_notifier;
>  } VncH264;
>  #endif
>
> --
> 2.39.5
>



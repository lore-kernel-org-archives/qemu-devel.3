Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC57C369A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 20:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1tEy-000513-9t; Mon, 07 Apr 2025 16:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u1tEw-00050H-9b
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 16:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u1tEt-00036U-Pi
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 16:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744058317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iWWav+4uTmeD7F94ypI7TQ8ujeYD4SGbORKnifEvjU=;
 b=HpPtBFPwLsjLtNyS9kljbHFpBLBvXtVjk3OqTGW+PkvJk+JREM9OhrB0WcsgMxqUBz1UWb
 2rGHPlC8PePt0GVd5omk294gIai3w03sRt6QDRLswQqEJFhboIcx3oO9gy+aTDnitUf4nR
 XzvpOdGAP2GOxE3WGUpfoButAPeev/4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-8KK6xD5JOFyZzjswm1K07Q-1; Mon, 07 Apr 2025 16:36:15 -0400
X-MC-Unique: 8KK6xD5JOFyZzjswm1K07Q-1
X-Mimecast-MFC-AGG-ID: 8KK6xD5JOFyZzjswm1K07Q_1744058174
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-478f78ff9beso142800511cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 13:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744058174; x=1744662974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3iWWav+4uTmeD7F94ypI7TQ8ujeYD4SGbORKnifEvjU=;
 b=tcQ5cbt8UJGCXgpJG90A7o6OWPghEVnLZRrpcvYdrUtdaESSA6ID9SvQWeK0V9p1Al
 /gRjCUyvq4Iww/eaw5yeBTtoJ1l24fP5tahli2uKVD/us1RQG26dy9v8gi1V1EuQk7bs
 Wus+8aBbcWuiqtGkSThrATgYojkR4u9dIOGfnPbVF2/6eskFGsm6mcmWkjs1B5CZY7ZV
 pVCbaTH9drPh4rtrtHeJDrA+oZLZeaOK2NFAA/4NcL2RjtmcLM2eJLctf3LhKtJmgAb2
 cAm/1xS9EUh4TbVFxO7sZZKbQsux1zknamUxp6+D+16rwT7N+24/buE3AzEgvM53xWzR
 hqzA==
X-Gm-Message-State: AOJu0YyjOQIl5bC52V58BY74+0dWa1smVxodoEYnBwg4hBps4tBp2lwc
 hCljV6tgK9DOxfan36z9NS09bPqvvg16XjQUi3EgzmO0j9o6ZCjDVcHFQXVM+TkAtWzIIcAWGA8
 vd/ev4rFiZVYGhS+c5GwmUfkdq6/FF9bJWjlcuMWbypHqL2XXdPOs6Kk1D3gxT1e1ZUX21gFUqh
 ZUjMn0ClA6rDJETATEluLQsAsDwDJVRsbVRbhSQg==
X-Gm-Gg: ASbGncsCb5RatcWVaojec8s+VEIHt43lID0mJyJXNDrGTsCpZ9sWZSvHTZ0RKbiV4uz
 xpYAYQOYeBbQ7oSPmrrDC03b0+9zjgM71pCGJzYdj9HVJOcO0DutrqalXUgUdaAfmhQsScIAY8j
 iu29Mb8PmscsphFtZPpo6DZOtCTD6fSA==
X-Received: by 2002:ac8:5dd4:0:b0:479:1a3f:f1f0 with SMTP id
 d75a77b69052e-479249a7d77mr209288881cf.41.1744058174230; 
 Mon, 07 Apr 2025 13:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMJx/lXSpHP15Et1UBqpwo+9fZXkfGFrbZaV/ObHsGhqkZNi8wm7hsgWKpBr4jxUQkG+IS6LqLbbXzAreXSZo=
X-Received: by 2002:ac8:5dd4:0:b0:479:1a3f:f1f0 with SMTP id
 d75a77b69052e-479249a7d77mr209288641cf.41.1744058173914; Mon, 07 Apr 2025
 13:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250407105939.1997660-1-dietmar@proxmox.com>
 <20250407105939.1997660-2-dietmar@proxmox.com>
In-Reply-To: <20250407105939.1997660-2-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Apr 2025 00:36:00 +0400
X-Gm-Features: ATxdqUEGDVLqAP1FEqpdUhWpCKbuR6oaXdo1AVVFIJDlD8XI-RyWtq06_NJ2SeY
Message-ID: <CAMxuvaxs+qM3msR-tdCXZfMZkQvHqNbHhHwhYKBPtRPLZGyuMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] add vnc h264 encoder
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Please resend the series with a cover letter
(https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-git-for=
mat-patch)

Some people prefer when the commit message has content too :)

At least, it would be useful if you point to a client that supports
the codec and allow us to test/use it.

Also documentation: this should be
https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-en=
coding
I suppose

On Mon, Apr 7, 2025 at 3:06=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com>=
 wrote:
>
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/meson.build    |   1 +
>  ui/vnc-enc-h264.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++
>  ui/vnc-jobs.c     |  49 ++++++---
>  ui/vnc.c          |  21 ++++
>  ui/vnc.h          |  21 ++++
>  5 files changed, 346 insertions(+), 15 deletions(-)
>  create mode 100644 ui/vnc-enc-h264.c
>
> diff --git a/ui/meson.build b/ui/meson.build
> index 35fb04cadf..34f1f33699 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -46,6 +46,7 @@ vnc_ss.add(files(
>  ))
>  vnc_ss.add(zlib, jpeg)
>  vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
> +vnc_ss.add(when: gstreamer, if_true: files('vnc-enc-h264.c'))
>  system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
>  system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
>
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> new file mode 100644
> index 0000000000..ca8e206335
> --- /dev/null
> +++ b/ui/vnc-enc-h264.c
> @@ -0,0 +1,269 @@
> +#include "qemu/osdep.h"
> +#include "vnc.h"
> +
> +#include <gst/gst.h>
> +
> +static void libavcodec_destroy_encoder_context(VncState *vs)

it's not libavcodec.

> +{
> +    if (!vs->h264) {
> +        return;
> +    }
> +
> +    if (vs->h264->source) {
> +        gst_object_unref(vs->h264->source);
> +        vs->h264->source =3D NULL;
> +    }
> +
> +    if (vs->h264->convert) {
> +        gst_object_unref(vs->h264->convert);
> +        vs->h264->convert =3D NULL;
> +    }
> +
> +    if (vs->h264->gst_encoder) {
> +        gst_object_unref(vs->h264->gst_encoder);
> +        vs->h264->sink =3D NULL;
> +    }
> +
> +    if (vs->h264->sink) {
> +        gst_object_unref(vs->h264->sink);
> +        vs->h264->sink =3D NULL;
> +    }
> +
> +    if (vs->h264->pipeline) {
> +        gst_object_unref(vs->h264->pipeline);
> +        vs->h264->pipeline =3D NULL;
> +    }
> +}
> +
> +static bool libavcodec_create_encoder_context(VncState *vs, int w, int h=
)
> +{
> +    g_assert(vs->h264 !=3D NULL);
> +
> +    if (vs->h264->sink) {
> +        if (w !=3D vs->h264->width || h !=3D vs->h264->height) {
> +            libavcodec_destroy_encoder_context(vs);
> +        }
> +    }
> +
> +    if (vs->h264->sink) {
> +        return TRUE;
> +    }
> +
> +    vs->h264->width =3D w;
> +    vs->h264->height =3D h;
> +
> +    vs->h264->source =3D gst_element_factory_make("appsrc", "source");
> +    if (!vs->h264->source) {
> +        VNC_DEBUG("Could not create gst source\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    vs->h264->convert =3D gst_element_factory_make("videoconvert", "conv=
ert");
> +    if (!vs->h264->convert) {
> +        VNC_DEBUG("Could not create gst convert element\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    vs->h264->gst_encoder =3D gst_element_factory_make("x264enc", "gst-e=
ncoder");

It's libx264. And that might be an issue, since it's not generally
available (not in Fedora).

Have you tried to make it agnostic to the encoder element thanks to
encodebin instead?

> +    if (!vs->h264->gst_encoder) {
> +        VNC_DEBUG("Could not create gst x264 encoder\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    g_object_set(vs->h264->gst_encoder, "tune", 4, NULL); /* zerolatency=
 */
> +    /* fix for zerolatency with novnc (without, noVNC displays green str=
ipes) */
> +    g_object_set(vs->h264->gst_encoder, "threads", 1, NULL);
> +
> +    g_object_set(vs->h264->gst_encoder, "pass", 5, NULL); /* Constant Qu=
ality */
> +    g_object_set(vs->h264->gst_encoder, "quantizer", 26, NULL);
> +
> +    /* avoid access unit delimiters (Nal Unit Type 9) - not required */
> +    g_object_set(vs->h264->gst_encoder, "aud", false, NULL);
> +
> +    vs->h264->sink =3D gst_element_factory_make("appsink", "sink");
> +    if (!vs->h264->sink) {
> +        VNC_DEBUG("Could not create gst sink\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    vs->h264->pipeline =3D gst_pipeline_new("vnc-h264-pipeline");
> +    if (!vs->h264->pipeline) {
> +        VNC_DEBUG("Could not create gst pipeline\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    gst_object_ref(vs->h264->source);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> +        gst_object_unref(vs->h264->source);
> +        VNC_DEBUG("Could not add source to gst pipeline\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    gst_object_ref(vs->h264->convert);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
> +        gst_object_unref(vs->h264->convert);
> +        VNC_DEBUG("Could not add convert to gst pipeline\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    gst_object_ref(vs->h264->gst_encoder);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)=
) {
> +        gst_object_unref(vs->h264->gst_encoder);
> +        VNC_DEBUG("Could not add encoder to gst pipeline\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    gst_object_ref(vs->h264->sink);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
> +        gst_object_unref(vs->h264->sink);
> +        VNC_DEBUG("Could not add sink to gst pipeline\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    GstCaps *source_caps =3D gst_caps_new_simple(
> +        "video/x-raw",
> +        "format", G_TYPE_STRING, "BGRx",
> +        "framerate", GST_TYPE_FRACTION, 33, 1,
> +        "width", G_TYPE_INT, w,
> +        "height", G_TYPE_INT, h,
> +        NULL);
> +
> +    if (!source_caps) {
> +        VNC_DEBUG("Could not create source caps filter\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    g_object_set(vs->h264->source, "caps", source_caps, NULL);
> +    gst_caps_unref(source_caps);
> +
> +    if (gst_element_link_many(
> +            vs->h264->source,
> +            vs->h264->convert,
> +            vs->h264->gst_encoder,
> +            vs->h264->sink,
> +            NULL
> +        ) !=3D TRUE) {
> +        VNC_DEBUG("Elements could not be linked.\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    /* Start playing */
> +    int ret =3D gst_element_set_state(vs->h264->pipeline, GST_STATE_PLAY=
ING);
> +    if (ret =3D=3D GST_STATE_CHANGE_FAILURE) {
> +        VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
> +        libavcodec_destroy_encoder_context(vs);
> +        return FALSE;
> +    }
> +
> +    return TRUE;
> +}
> +
> +int vnc_h264_encoder_init(VncState *vs)
> +{
> +    g_assert(vs->h264 =3D=3D NULL);
> +
> +    vs->h264 =3D g_malloc0(sizeof(VncH264));
> +
> +    return 0;
> +}
> +
> +int vnc_h264_send_framebuffer_update(
> +    VncState *vs,
> +    int _x,
> +    int _y,
> +    int _w,
> +    int _h,
> +) {
> +    g_assert(vs->h264 !=3D NULL);
> +    g_assert(vs->vd !=3D NULL);
> +    g_assert(vs->vd->server !=3D NULL);
> +
> +    int width =3D pixman_image_get_width(vs->vd->server);
> +    int height =3D pixman_image_get_height(vs->vd->server);
> +
> +    g_assert(width =3D=3D vs->client_width);
> +    g_assert(height =3D=3D vs->client_height);
> +
> +    int rdb_h264_flags =3D 0;
> +
> +    if (vs->h264->sink) {
> +        if (width !=3D vs->h264->width || height !=3D vs->h264->height) =
{
> +            rdb_h264_flags =3D 2;
> +        }
> +    } else {
> +        rdb_h264_flags =3D 2;
> +    }
> +
> +    if (!libavcodec_create_encoder_context(vs, width, height)) {
> +        VNC_DEBUG("Create encoder context failed\n");
> +        return -1;
> +    }
> +
> +    g_assert(vs->h264->sink !=3D NULL);
> +
> +    uint8_t *src_data_ptr =3D vnc_server_fb_ptr(vs->vd, 0, 0);
> +    size_t src_data_size =3D width * height * VNC_SERVER_FB_BYTES;
> +
> +    GstBuffer *buffer =3D gst_buffer_new_wrapped_full(
> +        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
> +
> +    GstFlowReturn ret;
> +    g_signal_emit_by_name(vs->h264->source, "push-buffer", buffer, &ret)=
;
> +
> +    if (ret !=3D GST_FLOW_OK) {
> +        VNC_DEBUG("gst appsrc push buffer failed\n");
> +        return -1;
> +    }
> +
> +    GstSample *sample;
> +    /* Retrieve the buffer */
> +    g_signal_emit_by_name(vs->h264->sink, "pull-sample", &sample);
> +    if (sample) {
> +        GstBuffer *buf =3D gst_sample_get_buffer(sample);
> +        GstMapInfo map;
> +        if (gst_buffer_map(buf, &map, 0)) {
> +            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODING=
_H264);
> +            vnc_write_s32(vs, map.size); /* write data length */
> +            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
> +            rdb_h264_flags =3D 0;
> +
> +            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
> +
> +            vnc_write(vs, map.data, map.size);
> +
> +            gst_buffer_unmap(buf, &map);
> +
> +            return 1;
> +        } else {
> +            VNC_DEBUG("unable to map sample\n");
> +        }
> +        gst_sample_unref(sample);
> +        return 1;
> +    } else {
> +        VNC_DEBUG("gst no data\n");
> +        return 0;
> +    }
> +}
> +
> +void vnc_h264_clear(VncState *vs)
> +{
> +    if (!vs->h264) {
> +        return;
> +    }
> +
> +    libavcodec_destroy_encoder_context(vs);
> +
> +    g_free(vs->h264);
> +    vs->h264 =3D NULL;
> +}
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index fcca7ec632..853a547d9a 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, =
VncState *local)
>      local->zlib =3D orig->zlib;
>      local->hextile =3D orig->hextile;
>      local->zrle =3D orig->zrle;
> +    local->h264 =3D orig->h264;
>      local->client_width =3D orig->client_width;
>      local->client_height =3D orig->client_height;
>  }
> @@ -204,6 +205,7 @@ static void vnc_async_encoding_end(VncState *orig, Vn=
cState *local)
>      orig->zlib =3D local->zlib;
>      orig->hextile =3D local->hextile;
>      orig->zrle =3D local->zrle;
> +    orig->h264 =3D local->h264;
>      orig->lossy_rect =3D local->lossy_rect;
>  }
>
> @@ -284,25 +286,42 @@ static int vnc_worker_thread_loop(VncJobQueue *queu=
e)
>      vnc_write_u16(&vs, 0);
>
>      vnc_lock_display(job->vs->vd);
> -    QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> -        int n;
> -
> -        if (job->vs->ioc =3D=3D NULL) {
> -            vnc_unlock_display(job->vs->vd);
> -            /* Copy persistent encoding data */
> -            vnc_async_encoding_end(job->vs, &vs);
> -            goto disconnected;
> -        }
>
> -        if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> -            n =3D vnc_send_framebuffer_update(&vs, entry->rect.x, entry-=
>rect.y,
> -                                            entry->rect.w, entry->rect.h=
);
> +    if (vs.vnc_encoding =3D=3D VNC_ENCODING_H264) {
> +        int width =3D pixman_image_get_width(vs.vd->server);
> +        int height =3D pixman_image_get_height(vs.vd->server);
> +           int n =3D vnc_send_framebuffer_update(&vs, 0, 0, width, heigh=
t);
> +        if (n >=3D 0) {
> +            n_rectangles +=3D n;
> +        }
> +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> +            g_free(entry);
> +        }
> +    } else {
> +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> +            int n;
> +
> +            if (job->vs->ioc =3D=3D NULL) {
> +                vnc_unlock_display(job->vs->vd);
> +                /* Copy persistent encoding data */
> +                vnc_async_encoding_end(job->vs, &vs);
> +                goto disconnected;
> +            }
>
> -            if (n >=3D 0) {
> -                n_rectangles +=3D n;
> +            if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> +                n =3D vnc_send_framebuffer_update(
> +                    &vs,
> +                    entry->rect.x,
> +                    entry->rect.y,
> +                    entry->rect.w,
> +                    entry->rect.h);
> +
> +                if (n >=3D 0) {
> +                    n_rectangles +=3D n;
> +                }
>              }
> +            g_free(entry);
>          }
> -        g_free(entry);
>      }
>      trace_vnc_job_nrects(&vs, job, n_rectangles);
>      vnc_unlock_display(job->vs->vd);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9241caaad9..2e60b55e47 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -972,6 +972,9 @@ int vnc_send_framebuffer_update(VncState *vs, int x, =
int y, int w, int h)
>          case VNC_ENCODING_ZYWRLE:
>              n =3D vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
>              break;
> +        case VNC_ENCODING_H264:
> +            n =3D vnc_h264_send_framebuffer_update(vs, x, y, w, h);
> +            break;
>          default:
>              vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
>              n =3D vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> @@ -1326,6 +1329,10 @@ void vnc_disconnect_finish(VncState *vs)
>      vnc_tight_clear(vs);
>      vnc_zrle_clear(vs);
>
> +#ifdef CONFIG_GSTREAMER
> +    vnc_h264_clear(vs);
> +#endif
> +
>  #ifdef CONFIG_VNC_SASL
>      vnc_sasl_client_cleanup(vs);
>  #endif /* CONFIG_VNC_SASL */
> @@ -2181,6 +2188,16 @@ static void set_encodings(VncState *vs, int32_t *e=
ncodings, size_t n_encodings)
>              vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
>              vs->vnc_encoding =3D enc;
>              break;
> +#ifdef CONFIG_GSTREAMER
> +        case VNC_ENCODING_H264:
> +            if (vnc_h264_encoder_init(vs) =3D=3D 0) {
> +                vnc_set_feature(vs, VNC_FEATURE_H264);

Before advertising support for the codec, it should actually check if
the encoder is present. It would also be useful to have an extra VNC
option like H264=3Don/off/auto.

> +                vs->vnc_encoding =3D enc;
> +            } else {
> +                VNC_DEBUG("vnc_h264_encoder_init failed\n");
> +            }
> +            break;
> +#endif
>          case VNC_ENCODING_DESKTOPRESIZE:
>              vnc_set_feature(vs, VNC_FEATURE_RESIZE);
>              break;
> @@ -4291,6 +4308,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Er=
ror **errp)
>      Error *local_err =3D NULL;
>      char *id =3D (char *)qemu_opts_id(opts);
>
> +#ifdef CONFIG_GSTREAMER
> +    gst_init(NULL, NULL);
> +#endif
> +
>      assert(id);
>      vnc_display_init(id, &local_err);
>      if (local_err) {
> diff --git a/ui/vnc.h b/ui/vnc.h
> index acc53a2cc1..7e232f7dac 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -46,6 +46,10 @@
>  #include "vnc-enc-zrle.h"
>  #include "ui/kbd-state.h"
>
> +#ifdef CONFIG_GSTREAMER
> +#include <gst/gst.h>
> +#endif
> +
>  // #define _VNC_DEBUG 1
>
>  #ifdef _VNC_DEBUG
> @@ -231,6 +235,14 @@ typedef struct VncZywrle {
>      int buf[VNC_ZRLE_TILE_WIDTH * VNC_ZRLE_TILE_HEIGHT];
>  } VncZywrle;
>
> +#ifdef CONFIG_GSTREAMER
> +typedef struct VncH264 {
> +    GstElement *pipeline, *source, *gst_encoder, *sink, *convert;
> +    size_t width;
> +    size_t height;
> +} VncH264;
> +#endif
> +
>  struct VncRect
>  {
>      int x;
> @@ -344,6 +356,9 @@ struct VncState
>      VncHextile hextile;
>      VncZrle *zrle;
>      VncZywrle zywrle;
> +#ifdef CONFIG_GSTREAMER
> +    VncH264 *h264;
> +#endif
>
>      Notifier mouse_mode_notifier;
>
> @@ -404,6 +419,7 @@ enum {
>  #define VNC_ENCODING_TRLE                 0x0000000f
>  #define VNC_ENCODING_ZRLE                 0x00000010
>  #define VNC_ENCODING_ZYWRLE               0x00000011
> +#define VNC_ENCODING_H264                 0x00000032 /* 50   */
>  #define VNC_ENCODING_COMPRESSLEVEL0       0xFFFFFF00 /* -256 */
>  #define VNC_ENCODING_QUALITYLEVEL0        0xFFFFFFE0 /* -32  */
>  #define VNC_ENCODING_XCURSOR              0xFFFFFF10 /* -240 */
> @@ -464,6 +480,7 @@ enum VncFeatures {
>      VNC_FEATURE_XVP,
>      VNC_FEATURE_CLIPBOARD_EXT,
>      VNC_FEATURE_AUDIO,
> +    VNC_FEATURE_H264,
>  };
>
>
> @@ -625,6 +642,10 @@ int vnc_zrle_send_framebuffer_update(VncState *vs, i=
nt x, int y, int w, int h);
>  int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w=
, int h);
>  void vnc_zrle_clear(VncState *vs);
>
> +int vnc_h264_encoder_init(VncState *vs);
> +int vnc_h264_send_framebuffer_update(VncState *vs, int x, int y, int w, =
int h);
> +void vnc_h264_clear(VncState *vs);
> +
>  /* vnc-clipboard.c */
>  void vnc_server_cut_text_caps(VncState *vs);
>  void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
> --
> 2.39.5
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3E2C369B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4agD-0002e6-DD; Tue, 15 Apr 2025 03:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u4ag6-0002bh-DT
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u4ag3-0004D6-Bm
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744701947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkIPfPCQ97SevYIL5PSHT6Ww7BnZIyxy4cY1ANFIjg0=;
 b=TsDel/cw0QegGrqMlk/8kB1uZYUhj4FINdAFnsQts1/8FXPTUzJ+Ufl9Dr7vgTqM4NMvaI
 cOLG3iN6iPFsLT7fMpZLIYHGESq0iRYEoY5HtXR6/SL7zVxrRK20ce/osm0qZgRh1NLrTd
 fUbD/MSnvb4c3g6zVzO5fm2M5OprRXg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-bqP9EFJpOzmg4Upi05pnqg-1; Tue, 15 Apr 2025 03:25:45 -0400
X-MC-Unique: bqP9EFJpOzmg4Upi05pnqg-1
X-Mimecast-MFC-AGG-ID: bqP9EFJpOzmg4Upi05pnqg_1744701944
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-476623ba226so88359821cf.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701944; x=1745306744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkIPfPCQ97SevYIL5PSHT6Ww7BnZIyxy4cY1ANFIjg0=;
 b=Jcz1M+TSTGWRRc70rj73q9sNHZa4HpSK0+3EIVx/oGHgviu2Y/5Tc9BV1E4U7larbQ
 10JREcJCO/G7kw3+i+2NSasnaiNPwkLx2WPfvgtZpMYrQnw3d158Km68di6YJgvl31kT
 /5T8KaDlkvOD5Mc5P30Enpohw8Gp4w0jO8fF9ZkXJlm3owIlsShFwDJmib1DnDwE68Gj
 pFgo/+Q+T+ZvvoMD2G/4IV+upCMd51N/NQyeMhMj3ITokr6vpDnGX709XovHTkAjxcKn
 qYXP6Y+OoIQSju/QUK+xgaT9dqsVd1sxifU5xOc5aOUzcLkg0uuZ3V3ctMmOUVRO885t
 lZIA==
X-Gm-Message-State: AOJu0Yx4Z1QmCTGLcqmFMjwNnJGjQfdB/6L4I60bcxgzqSW4eBngHX4J
 V9FNcaZE9Dd3eZ1tQo2oSbq0KhmKiYNtNPEb62sP2ZhPwtiPwMV7zuOLOTkCzpqWexeQsqTVOmH
 aMXdVfnE40qYuCQx3Jc1kusMfsEF8ePazAOMFl37xVMiQB5PXvs3TpNL3hbfpjUnxT+sXIWK0Be
 uW2FtLuVf6M4dZA+Hu+L6Xi2MvNjcC8n6wYiuVnQ==
X-Gm-Gg: ASbGncuF3HJsU5OAr/wIOYIHAZxbR1MRkBmjoHSrl3RcqqbOeqrB5nRvARE/7fCbYT8
 GBb2Ydl4vtmCKRZBYFUb7IS5q+9skJAOlVbKc8+CegJSKWTltXSutSKNzn9NVgXMkwzzV6Q==
X-Received: by 2002:ac8:7d12:0:b0:477:6ee2:18cd with SMTP id
 d75a77b69052e-47977524a16mr238831721cf.5.1744701944159; 
 Tue, 15 Apr 2025 00:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2II0L2EqcnWpZTwbvHzhCJjNYMZEea/clcODbYClaRcbVhOh5kGoKluXPeIV1X04tHgQ2xR3C4psG+5l2jm4=
X-Received: by 2002:ac8:7d12:0:b0:477:6ee2:18cd with SMTP id
 d75a77b69052e-47977524a16mr238831441cf.5.1744701943659; Tue, 15 Apr 2025
 00:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250410112238.3550155-1-dietmar@proxmox.com>
 <20250410112238.3550155-3-dietmar@proxmox.com>
In-Reply-To: <20250410112238.3550155-3-dietmar@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Apr 2025 11:25:31 +0400
X-Gm-Features: ATxdqUHVHSG7g0iSn7VwLl1ya1zQwPeh28bJ8AZrW6a09sK4-2vObse5VJkUHlM
Message-ID: <CAMxuvaywF+YbO3TAmX_iorD9HMixW=30DWv7-g5Ms6_fxf_gPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] add vnc h264 encoder
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 10, 2025 at 3:22=E2=80=AFPM Dietmar Maurer <dietmar@proxmox.com=
> wrote:
>
> This patch implements H264 support for VNC. The RFB protocol
> extension is defined in:
>
> https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-=
encoding
>
> Currently the Gstreamer x264enc plugin (software encoder) is used
> to encode the video stream.
>
> The gstreamer pipe is:
>
> appsrc -> videoconvert -> x264enc -> appsink
>
> Note: videoconvert is required for RGBx to YUV420 conversion.
>
> The code still use the VNC server framebuffer change detection,
> and only encodes and sends video frames if there are changes.
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

In general, a license header is required.

> +#include "qemu/osdep.h"
> +#include "vnc.h"
> +
> +#include <gst/gst.h>
> +
> +static void libavcodec_destroy_encoder_context(VncState *vs)

please squash the next patch removing the libavcodec prefix.

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

Let's save a few lines:
    gst_clear_object(&vs->h264->source);
    gst_clear_object(&vs->h264->convert);
    gst_clear_object(&vs->h264->gst_encoder);
    gst_clear_object(&vs->h264->sink);
    gst_clear_object(&vs->h264->pipeline);

(We may also rely on the fact that the pipeline will hold the elements
and avoid ref-counting them)


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

Given that you always destroy the context on error, I suggest you add
a "goto error" instead.

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

Why not use a single g_object_set()?

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

Let's declare it with g_autoptr

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

 g_new0(VncH264, 1)

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

../ui/vnc-enc-h264.c:168:1: error: expected declaration specifiers or
=E2=80=98...=E2=80=99 before =E2=80=98)=E2=80=99 token

The function returns an 'int', with value -1, 0 or 1. This needs to be
documented.

Otherwise switch to a bool, with true for success.

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

There is a bit too much mixed declaration in your code. From
docs/devel/style.rst:

Declarations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Mixed declarations (interleaving statements and declarations within
blocks) are generally not allowed; declarations should be at the beginning
...

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

Is there a guarantee that a single sample is produced per frame? I
wonder if this code would be more robust by handling samples in a
loop.

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

Shouldn't this be an error?

> +        }
> +        gst_sample_unref(sample);
> +        return 1;
> +    } else {
> +        VNC_DEBUG("gst no data\n");

I would use a "trace" for this.

> +        return 0;
> +    }
> +}
> +
> +void vnc_h264_clear(VncState *vs)
> +{
> +    if (!vs->h264) {
> +        return;
> +    }

This condition is unneeded here.

> +
> +    libavcodec_destroy_encoder_context(vs);
> +
> +    g_free(vs->h264);
> +    vs->h264 =3D NULL;

g_clear_pointer(&vs->h264, g_free);

> +}
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c

You could split those changes in a different patch.

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

Have you tried to initialize gst during argument processing (so we get
--gst- options)?

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



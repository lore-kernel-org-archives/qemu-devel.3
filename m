Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C51C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZB8-0006Fw-IR; Wed, 23 Apr 2025 08:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZAx-0006D9-D4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZAu-0003UY-2D
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745411158;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EVkltQoH6sDJRuvyKP19c9TGurYhJxE0zHi+lLkqOtE=;
 b=aCoK0pQMJPeSc+cGKxnQ1scnp//NDIZUwPuTOf68KHE5ibvLZa+sYh1F1cP9vTQkvn32yd
 nWJIt8I4YxwwRZRM/jOj2QEsQJBvQzgKvxNnTKYM+inI8E771+1IJyYRjbrIoKw9xjrDD7
 kYU8fhL0+2D1r3BcaVL2KJaUUhTLoyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-a9NMkuV9PfKS8SMnnvBpyQ-1; Wed,
 23 Apr 2025 08:25:57 -0400
X-MC-Unique: a9NMkuV9PfKS8SMnnvBpyQ-1
X-Mimecast-MFC-AGG-ID: a9NMkuV9PfKS8SMnnvBpyQ_1745411156
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 731D41828AB6; Wed, 23 Apr 2025 12:25:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31A471955E95; Wed, 23 Apr 2025 12:25:49 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:25:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAjcSnT_zYnuOG2W@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-3-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 18, 2025 at 01:29:46PM +0200, Dietmar Maurer wrote:
> This patch implements H264 support for VNC. The RFB protocol
> extension is defined in:
> 
> https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding
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
>  ui/vnc-enc-h264.c | 282 ++++++++++++++++++++++++++++++++++++++++++++++
>  ui/vnc-jobs.c     |  49 +++++---
>  ui/vnc.c          |  21 ++++
>  ui/vnc.h          |  21 ++++
>  5 files changed, 359 insertions(+), 15 deletions(-)
>  create mode 100644 ui/vnc-enc-h264.c


> +static bool create_encoder_context(VncState *vs, int w, int h)
> +{
> +    g_autoptr(GstCaps) source_caps = NULL;
> +    GstStateChangeReturn state_change_ret;
> +
> +    g_assert(vs->h264 != NULL);
> +
> +    if (vs->h264->sink) {
> +        if (w != vs->h264->width || h != vs->h264->height) {
> +            destroy_encoder_context(vs);
> +        }
> +    }
> +
> +    if (vs->h264->sink) {
> +        return TRUE;
> +    }
> +
> +    vs->h264->width = w;
> +    vs->h264->height = h;
> +
> +    vs->h264->source = gst_element_factory_make("appsrc", "source");
> +    if (!vs->h264->source) {
> +        VNC_DEBUG("Could not create gst source\n");
> +        goto error;
> +    }
> +
> +    vs->h264->convert = gst_element_factory_make("videoconvert", "convert");
> +    if (!vs->h264->convert) {
> +        VNC_DEBUG("Could not create gst convert element\n");
> +        goto error;
> +    }
> +
> +    vs->h264->gst_encoder = gst_element_factory_make("x264enc", "gst-encoder");
> +    if (!vs->h264->gst_encoder) {
> +        VNC_DEBUG("Could not create gst x264 encoder\n");
> +        goto error;
> +    }
> +
> +    g_object_set(
> +        vs->h264->gst_encoder,
> +        "tune", 4, /* zerolatency */
> +        /*
> +         * fix for zerolatency with novnc (without, noVNC displays
> +         * green stripes)
> +         */
> +        "threads", 1,

It seems a bit dubious for QEMU to workaround VNC client bugs, as our
server should be client agnostic. Shouldn't this flaw be fixed in noVNC
instead.

> +        "pass", 5, /* Constant Quality */
> +        "quantizer", 26,
> +        /* avoid access unit delimiters (Nal Unit Type 9) - not required */
> +        "aud", false,
> +        NULL);
> +
> +    vs->h264->sink = gst_element_factory_make("appsink", "sink");
> +    if (!vs->h264->sink) {
> +        VNC_DEBUG("Could not create gst sink\n");
> +        goto error;
> +    }
> +
> +    vs->h264->pipeline = gst_pipeline_new("vnc-h264-pipeline");
> +    if (!vs->h264->pipeline) {
> +        VNC_DEBUG("Could not create gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->source);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->source)) {
> +        gst_object_unref(vs->h264->source);
> +        VNC_DEBUG("Could not add source to gst pipeline\n");
> +        goto error;
> +    }

If you put the gst_object_ref call after sucessfully calling
gst_bin_add, then it wouldn't need the gst_object_unref call
on failure. Repeated many times below.

> +
> +    gst_object_ref(vs->h264->convert);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->convert)) {
> +        gst_object_unref(vs->h264->convert);
> +        VNC_DEBUG("Could not add convert to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->gst_encoder);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->gst_encoder)) {
> +        gst_object_unref(vs->h264->gst_encoder);
> +        VNC_DEBUG("Could not add encoder to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    gst_object_ref(vs->h264->sink);
> +    if (!gst_bin_add(GST_BIN(vs->h264->pipeline), vs->h264->sink)) {
> +        gst_object_unref(vs->h264->sink);
> +        VNC_DEBUG("Could not add sink to gst pipeline\n");
> +        goto error;
> +    }
> +
> +    source_caps = gst_caps_new_simple(
> +        "video/x-raw",
> +        "format", G_TYPE_STRING, "BGRx",
> +        "framerate", GST_TYPE_FRACTION, 33, 1,
> +        "width", G_TYPE_INT, w,
> +        "height", G_TYPE_INT, h,
> +        NULL);
> +
> +    if (!source_caps) {
> +        VNC_DEBUG("Could not create source caps filter\n");
> +        goto error;
> +    }
> +
> +    g_object_set(vs->h264->source, "caps", source_caps, NULL);
> +
> +    if (gst_element_link_many(
> +            vs->h264->source,
> +            vs->h264->convert,
> +            vs->h264->gst_encoder,
> +            vs->h264->sink,
> +            NULL
> +        ) != TRUE) {
> +        VNC_DEBUG("Elements could not be linked.\n");
> +        goto error;
> +    }
> +
> +    /* Start playing */
> +    state_change_ret = gst_element_set_state(
> +        vs->h264->pipeline, GST_STATE_PLAYING);
> +
> +    if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
> +        VNC_DEBUG("Unable to set the pipeline to the playing state.\n");
> +        goto error;
> +    }
> +
> +    return TRUE;
> +
> + error:
> +    destroy_encoder_context(vs);
> +    return FALSE;
> +}
> +

> +/*
> + * Returns the number of generated framebuffer updates,
> + * or -1 in case of errors
> + */
> +int vnc_h264_send_framebuffer_update(
> +    VncState *vs,
> +    int _x,
> +    int _y,
> +    int _w,
> +    int _h

This line wrapping of params is not needed, put it all
on one line. Also don't use a leading underscore on
the params. Or indeed why have these params at all
if they're not going to be used ?

> +) {
> +    int n = 0;
> +    int rdb_h264_flags = 0;
> +    int width, height;
> +    uint8_t *src_data_ptr = NULL;
> +    size_t src_data_size;
> +    GstFlowReturn flow_ret = GST_FLOW_ERROR;
> +    GstBuffer *src_buffer = NULL;
> +
> +    g_assert(vs->h264 != NULL);
> +    g_assert(vs->vd != NULL);
> +    g_assert(vs->vd->server != NULL);
> +
> +    width = pixman_image_get_width(vs->vd->server);
> +    height = pixman_image_get_height(vs->vd->server);
> +
> +    g_assert(width == vs->client_width);
> +    g_assert(height == vs->client_height);
> +
> +    if (vs->h264->sink) {
> +        if (width != vs->h264->width || height != vs->h264->height) {
> +            rdb_h264_flags = 2;
> +        }
> +    } else {
> +        rdb_h264_flags = 2;
> +    }
> +
> +    if (!create_encoder_context(vs, width, height)) {
> +        VNC_DEBUG("Create encoder context failed\n");
> +        return -1;
> +    }
> +
> +    g_assert(vs->h264->sink != NULL);
> +
> +    src_data_ptr = vnc_server_fb_ptr(vs->vd, 0, 0);
> +    src_data_size = width * height * VNC_SERVER_FB_BYTES;
> +
> +    src_buffer = gst_buffer_new_wrapped_full(
> +        0, src_data_ptr, src_data_size, 0, src_data_size, NULL, NULL);
> +
> +    g_signal_emit_by_name(
> +        vs->h264->source, "push-buffer", src_buffer, &flow_ret);
> +
> +    if (flow_ret != GST_FLOW_OK) {
> +        VNC_DEBUG("gst appsrc push buffer failed\n");
> +        return -1;
> +    }
> +
> +    do {
> +        GstSample *sample = NULL;
> +        GstMapInfo map;
> +        GstBuffer *out_buffer;
> +
> +        /* Retrieve the buffer */
> +        g_signal_emit_by_name(vs->h264->sink, "try-pull-sample", 0, &sample);
> +        if (!sample) {
> +            break;
> +        }
> +        out_buffer = gst_sample_get_buffer(sample);
> +        if (gst_buffer_map(out_buffer, &map, 0)) {
> +            vnc_framebuffer_update(vs, 0, 0, width, height, VNC_ENCODING_H264);
> +            vnc_write_s32(vs, map.size); /* write data length */
> +            vnc_write_s32(vs, rdb_h264_flags); /* write flags */
> +            rdb_h264_flags = 0;
> +
> +            VNC_DEBUG("GST vnc_h264_update send %ld\n", map.size);
> +
> +            vnc_write(vs, map.data, map.size);
> +
> +            gst_buffer_unmap(out_buffer, &map);
> +
> +            n += 1;
> +        } else {
> +            VNC_DEBUG("unable to map sample\n");
> +        }
> +        gst_sample_unref(sample);
> +    } while (true);
> +
> +    return n;
> +}
> +
> +void vnc_h264_clear(VncState *vs)
> +{
> +    if (!vs->h264) {
> +        return;
> +    }
> +
> +    destroy_encoder_context(vs);
> +
> +    g_clear_pointer(&vs->h264, g_free);
> +}
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index fcca7ec632..853a547d9a 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
>      local->zlib = orig->zlib;
>      local->hextile = orig->hextile;
>      local->zrle = orig->zrle;
> +    local->h264 = orig->h264;
>      local->client_width = orig->client_width;
>      local->client_height = orig->client_height;
>  }
> @@ -204,6 +205,7 @@ static void vnc_async_encoding_end(VncState *orig, VncState *local)
>      orig->zlib = local->zlib;
>      orig->hextile = local->hextile;
>      orig->zrle = local->zrle;
> +    orig->h264 = local->h264;
>      orig->lossy_rect = local->lossy_rect;
>  }
>  
> @@ -284,25 +286,42 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>      vnc_write_u16(&vs, 0);
>  
>      vnc_lock_display(job->vs->vd);
> -    QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> -        int n;
> -
> -        if (job->vs->ioc == NULL) {
> -            vnc_unlock_display(job->vs->vd);
> -            /* Copy persistent encoding data */
> -            vnc_async_encoding_end(job->vs, &vs);
> -            goto disconnected;
> -        }
>  
> -        if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> -            n = vnc_send_framebuffer_update(&vs, entry->rect.x, entry->rect.y,
> -                                            entry->rect.w, entry->rect.h);
> +    if (vs.vnc_encoding == VNC_ENCODING_H264) {

Having an encoding branch in this area of code looks wierd...

> +        int width = pixman_image_get_width(vs.vd->server);
> +        int height = pixman_image_get_height(vs.vd->server);
> +           int n = vnc_send_framebuffer_update(&vs, 0, 0, width, height);
> +        if (n >= 0) {
> +            n_rectangles += n;
> +        }
> +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> +            g_free(entry);
> +        }

... and if we're not using the rectangles array, then it feels like
we should not have populated that data to begin with.

If you avoid populating the rectangle array, then the code could be
made independant of encoding. ie instead of checking encoding, check
whether the rectangles list is empty or not. ie use an empty rects
list to decide whether we're doing a full screen update or a regionwise
update.

> +    } else {
> +        QLIST_FOREACH_SAFE(entry, &job->rectangles, next, tmp) {
> +            int n;
> +
> +            if (job->vs->ioc == NULL) {
> +                vnc_unlock_display(job->vs->vd);
> +                /* Copy persistent encoding data */
> +                vnc_async_encoding_end(job->vs, &vs);
> +                goto disconnected;
> +            }
>  
> -            if (n >= 0) {
> -                n_rectangles += n;
> +            if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> +                n = vnc_send_framebuffer_update(
> +                    &vs,
> +                    entry->rect.x,
> +                    entry->rect.y,
> +                    entry->rect.w,
> +                    entry->rect.h);
> +
> +                if (n >= 0) {
> +                    n_rectangles += n;
> +                }
>              }
> +            g_free(entry);
>          }
> -        g_free(entry);
>      }
>      trace_vnc_job_nrects(&vs, job, n_rectangles);
>      vnc_unlock_display(job->vs->vd);

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



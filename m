Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D789C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zbu-0000bw-PG; Thu, 24 Apr 2025 12:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7zbt-0000bk-3g
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:39:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7zbn-0002nr-Qp
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 12:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745512769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zucJViY7xAKd2Thj8ZQykV0ybGntvqBjB1FOcf05IlY=;
 b=JWp8KFYRJ0r7ZmsKN391w5Ye1EJD3oDOC5EcwB4j9duQcl3BNqScrLhmGS8uxdSFd5BxXJ
 6Og3YQbJUulcDbW4fjomucxLjpgwdEaxSrp2l6fa+qbdnv1WtlIshslzTzxpnXYKEzh2u4
 g8wusx/km4wYD2HjKUwyS2WpF5qhqp8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-jH-FLF3gN9ydL2uRzHDOug-1; Thu,
 24 Apr 2025 12:39:26 -0400
X-MC-Unique: jH-FLF3gN9ydL2uRzHDOug-1
X-Mimecast-MFC-AGG-ID: jH-FLF3gN9ydL2uRzHDOug_1745512765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E93721956094; Thu, 24 Apr 2025 16:39:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B89C19560A3; Thu, 24 Apr 2025 16:39:23 +0000 (UTC)
Date: Thu, 24 Apr 2025 17:39:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/9] add vnc h264 encoder
Message-ID: <aAppOBppJI0PPXnw@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-3-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-3-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> index 0000000000..3abe6a1528
> --- /dev/null
> +++ b/ui/vnc-enc-h264.c
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 9241caaad9..aed25b0183 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -972,6 +972,9 @@ int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
>          case VNC_ENCODING_ZYWRLE:
>              n = vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
>              break;
> +        case VNC_ENCODING_H264:
> +            n = vnc_h264_send_framebuffer_update(vs, x, y, w, h);
> +            break;

Needs protecting with #ifdef CONFIG_GSTREAMER otherwise I'd
expect a linker error

>          default:
>              vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
>              n = vnc_raw_send_framebuffer_update(vs, x, y, w, h);
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
> @@ -2181,6 +2188,16 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>              vnc_set_feature(vs, VNC_FEATURE_ZYWRLE);
>              vs->vnc_encoding = enc;
>              break;
> +#ifdef CONFIG_GSTREAMER
> +        case VNC_ENCODING_H264:
> +            if (vnc_h264_encoder_init(vs)) {
> +                vnc_set_feature(vs, VNC_FEATURE_H264);
> +                vs->vnc_encoding = enc;
> +            } else {
> +                VNC_DEBUG("vnc_h264_encoder_init failed\n");
> +            }
> +            break;
> +#endif
>          case VNC_ENCODING_DESKTOPRESIZE:
>              vnc_set_feature(vs, VNC_FEATURE_RESIZE);
>              break;
> @@ -4291,6 +4308,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      Error *local_err = NULL;
>      char *id = (char *)qemu_opts_id(opts);
>  
> +#ifdef CONFIG_GSTREAMER
> +    gst_init(NULL, NULL);
> +#endif
> +
>      assert(id);
>      vnc_display_init(id, &local_err);
>      if (local_err) {
> diff --git a/ui/vnc.h b/ui/vnc.h
> index acc53a2cc1..a0d336738d 100644
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
> @@ -625,6 +642,10 @@ int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
>  int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
>  void vnc_zrle_clear(VncState *vs);
>  
> +bool vnc_h264_encoder_init(VncState *vs);
> +int vnc_h264_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
> +void vnc_h264_clear(VncState *vs);
> +
>  /* vnc-clipboard.c */
>  void vnc_server_cut_text_caps(VncState *vs);
>  void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
> -- 
> 2.39.5
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



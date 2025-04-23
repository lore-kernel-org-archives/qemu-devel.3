Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8067C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZWC-0001Tq-CG; Wed, 23 Apr 2025 08:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZVy-0001Ql-De
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZVw-0005Rd-9a
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lc9oJJSs4vbzh3odjElDkS7uEQdbKJNa07s5iQ5QZ/0=;
 b=ADGlEaiBGOQBpZOliVFgrRE9wJLJyfxNWCQGZaDkmm3Tc4Fp+WwPP9o5eM2iGFAv3ZMnTa
 4EITsjbWTyHJuIgNvDjazxNu8ApePrDa8zWi0kpFEw85tPLTI3pkvbwc8IV3jaZ1dcV8hF
 QK5WH81eiER8UnI5DvabYK1AvvgyOA0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-Bp8H6TU1PaWQfGG1BQ_kaQ-1; Wed,
 23 Apr 2025 08:47:39 -0400
X-MC-Unique: Bp8H6TU1PaWQfGG1BQ_kaQ-1
X-Mimecast-MFC-AGG-ID: Bp8H6TU1PaWQfGG1BQ_kaQ_1745412458
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A8991955F04; Wed, 23 Apr 2025 12:47:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 836221955BCB; Wed, 23 Apr 2025 12:47:36 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:47:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 5/9] h264: new vnc option to configure h264 at server
 side
Message-ID: <aAjhZOK_ztcRZS5T@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-6-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-6-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Fri, Apr 18, 2025 at 01:29:49PM +0200, Dietmar Maurer wrote:
> Values can be 'on', 'off', or a space sparated list of
> allowed gstreamer encoders.

space separated list values on the command line is incredibly unpleasant
syntax as it requires quoting the args.

> 
> - on: automatically select the encoder
> - off: disbale h264
> - encoder-list: select first available encoder from that list.


Overloading one config option to both turn h264 on/off,
an choose encoding is not very desirable.

IMHO there should be a "h264=<bool>" option to turn it
on/off, and a separate flag to choose the encoder.

Do we even need to give a list of encoders, as opposed
to just choosing the desired encoder ?

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
> -const char *encoder_list[] = { "x264enc", "openh264enc", NULL };
> -
> -static const char *get_available_encoder(void)
> +static char *get_available_encoder(const char *encoder_list)
>  {
> +    g_assert(encoder_list != NULL);
> +
> +    if (!strcmp(encoder_list, "")) {
> +        /* use default list */
> +        encoder_list = "x264enc openh264enc";
> +    }
> +
> +    char *ret = NULL;
> +    char **encoder_array = g_strsplit(encoder_list, " ", -1);
> +
>      int i = 0;
>      do {
> -        const char *encoder_name = encoder_list[i];
> +        const char *encoder_name = encoder_array[i];
>          if (encoder_name == NULL) {
>              break;
>          }
> @@ -41,12 +49,15 @@ static const char *get_available_encoder(void)
>              encoder_name, "video-encoder");
>          if (element != NULL) {
>              gst_object_unref(element);
> -            return encoder_name;
> +            ret = strdup(encoder_name);
> +            break;
>          }
>          i = i + 1;
>      } while (true);
>  
> -    return NULL;
> +    g_strfreev(encoder_array);
> +
> +    return ret;
>  }
>  
>  static GstElement *create_encoder(const char *encoder_name)
> @@ -220,11 +231,13 @@ static bool create_encoder_context(VncState *vs, int w, int h)
>  
>  bool vnc_h264_encoder_init(VncState *vs)
>  {
> -    const char *encoder_name;
> +    char *encoder_name;
>  
>      g_assert(vs->h264 == NULL);
> +    g_assert(vs->vd != NULL);
> +    g_assert(vs->vd->h264_encoder_list != NULL);
>  
> -    encoder_name = get_available_encoder();
> +    encoder_name = get_available_encoder(vs->vd->h264_encoder_list);
>      if (encoder_name == NULL) {
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
> @@ -2190,11 +2190,11 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>              break;
>  #ifdef CONFIG_GSTREAMER
>          case VNC_ENCODING_H264:
> -            if (vnc_h264_encoder_init(vs)) {
> -                vnc_set_feature(vs, VNC_FEATURE_H264);
> -                vs->vnc_encoding = enc;
> -            } else {
> -                VNC_DEBUG("vnc_h264_encoder_init failed\n");
> +            if (vs->vd->h264_encoder_list != NULL) { /* if h264 is enabled */
> +                if (vnc_h264_encoder_init(vs)) {
> +                    vnc_set_feature(vs, VNC_FEATURE_H264);
> +                    vs->vnc_encoding = enc;
> +                }
>              }
>              break;
>  #endif
> @@ -3634,6 +3634,9 @@ static QemuOptsList qemu_vnc_opts = {
>          },{
>              .name = "power-control",
>              .type = QEMU_OPT_BOOL,
> +        },{
> +            .name = "h264",
> +            .type = QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -4196,6 +4199,18 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>  #endif
>  
> +#ifdef CONFIG_GSTREAMER
> +    const char *h264_opt = qemu_opt_get(opts, "h264");
> +    if (!strcmp(h264_opt, "off")) {
> +        vd->h264_encoder_list = NULL; /* disable h264 */
> +    } else if  (!strcmp(h264_opt, "on")) {
> +        vd->h264_encoder_list = ""; /* use default encoder list */
> +    } else  {
> +        /* assume this is a list of endiers */
> +        vd->h264_encoder_list = h264_opt;
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
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4780FC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmom-0001A8-Hh; Wed, 04 Jun 2025 08:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMmoI-00012g-Op
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMmo9-0001Ll-RM
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749038482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxyRdI2H6nzTBeaJNMsKyy7WeNzuJ981hV4L0qV6GMk=;
 b=fKzUbbztAFB56rq/oIsh7ZKzo42I8utLA4an99yq9Wb6fGEoXNWrzUtbyHXXJerijZilSw
 biYIv/Vv/Bpjk7Dmns8e8NrJIpoabV1lhwyLUDYWHWXVt4AHvzJRplTLNPbIAwxqUoOYgV
 Qe9Yq8JYW9qe+hhmc/DRrJu1HXtYxo8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-ZXNKnW-fPwiuCz7zkAGJXw-1; Wed, 04 Jun 2025 08:01:20 -0400
X-MC-Unique: ZXNKnW-fPwiuCz7zkAGJXw-1
X-Mimecast-MFC-AGG-ID: ZXNKnW-fPwiuCz7zkAGJXw_1749038479
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-70e84239a18so100378657b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 05:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749038479; x=1749643279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PxyRdI2H6nzTBeaJNMsKyy7WeNzuJ981hV4L0qV6GMk=;
 b=K0M0Q2Lyv0XD/BNhyzFnRLrowJebbvTz2UmLkLnmwwRi+QgYf2/ENeB6AF1alh9QqH
 CJucFvpS5OaFqqOA34yKnueMjwTPAbQuw1Js2yngp1hmEjVezgEy9AORpXOCJtVaBQN5
 KnO8sUEmJQO/QYl5+YqHaEFJQqc1tjqlUKJZLkiv0W4iYGtLvgZfBG4lx3QMGOhSs+wA
 xOhqOpK8gjMIDOQQFcyZ9+++wxPB5gES6b2GiqnF9fScY8XngQS533IDBYJC34tOpjgp
 MZqXhQx4G3XNbMLKKIlWPB/ByY0PqMni1RXG6sfmsNuP2QP+AxGrlTnMrVGhb5Erb6GK
 Tbcw==
X-Gm-Message-State: AOJu0YzRloTVwLPTYHi5f6NZrh/2KMhSnX0iAmrbKqxkbZNQkg2xD2Zx
 rM5LARE807Um3FT2jJkems7Nq4oz4maC7tRmufwTqZKAKDvnxCk0XAHDLet4hf0g01zARl0czuM
 YH/Sw1RKQbLeSNNoy3xSUQUmEfsTbdjU0BJqGSGTWYE/h9qAuARxELafm9k6ylQzzHCyUud8S3t
 d7aE7luMR5YI0M1oOIyOBKitpnboR0BywTEgmQ+iWLfT46
X-Gm-Gg: ASbGncsPeezUt3x3oJ2x49POpbifxsNx1FQQ8FVF9hTl0Nb0QsGbJekgggkEzaq8I7Q
 IfOInvCyULuWXffZPLvY47jX2RlKb/Ep4zEFwHVfeS6pjyTJIXZbwbwHpLVz7cB920ZkQksSG/U
 RUlDcL8smn4pPBzmX6Jlc8+KbVkA==
X-Received: by 2002:a05:690c:380b:b0:70e:142d:9c6e with SMTP id
 00721157ae682-710d9fb94ccmr28391997b3.32.1749038478853; 
 Wed, 04 Jun 2025 05:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuH6MprRfz3opNB9z9gcXQ/i+C3ISq9FU/RO0zvgtFRtwUhGo9gjI9hfFYp0XAAPBqk72cjD61btkQVoXFYgQ=
X-Received: by 2002:a05:6102:dca:b0:4e5:aac2:2393 with SMTP id
 ada2fe7eead31-4e746e418c8mr1190561137.23.1749038466326; Wed, 04 Jun 2025
 05:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
 <20250603-zlib-v3-2-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250603-zlib-v3-2-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Jun 2025 16:00:54 +0400
X-Gm-Features: AX0GCFvcPD6MQu8h4IvZT--acolyjWkmyc6KPyOmrg4FMOViU2tM3VjT0e9cHIA
Message-ID: <CAMxuvayb+fMEqBLyY_7z5OSoYB8E9P5t_dNxN9=uawEdiVpw-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ui/vnc: Introduce the VncWorker type
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 devel@daynix.com
Content-Type: multipart/alternative; boundary="0000000000007c24e40636bdc077"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000007c24e40636bdc077
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 3, 2025 at 1:19=E2=80=AFPM Akihiko Odaki <odaki@rsg.ci.i.u-toky=
o.ac.jp>
wrote:

> The worker thread copies data in VncState to avoid race, but some
> data are too big to copy. Such data are held with pointers to avoid
> the overhead to copy, but it requires tedious memory management and
> makes them vulnerable to race.
>
> Introduce the VncWorker type to contain all data shared without copying.
> It allows allocating and freeing all shared data at once and shows that
> the race with the worker thread needs to be taken care of when
> accessing them.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>

Big patch, but splitting it may not be easy.
I am still left wondering about the remaining shared data and overall
design choices

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/vnc.h              |  49 ++++--
>  ui/vnc-enc-tight.c    | 456
> ++++++++++++++++++++++++++------------------------
>  ui/vnc-enc-zlib.c     |  47 +++---
>  ui/vnc-enc-zrle.c     | 122 +++++++-------
>  ui/vnc-jobs.c         |  13 +-
>  ui/vnc.c              |  86 ++++------
>  ui/vnc-enc-zrle.c.inc |  20 +--
>  7 files changed, 405 insertions(+), 388 deletions(-)
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index
> 82b883bb69fa5ce331945dcffe25588d5fd73f50..8b0afdd17aba06058bbac237eac2b4e=
eb4efea06
> 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -270,8 +270,6 @@ struct VncState
>      gboolean disconnecting;
>
>      DECLARE_BITMAP(dirty[VNC_MAX_HEIGHT], VNC_DIRTY_BITS);
> -    uint8_t **lossy_rect; /* Not an Array to avoid costly memcpy in
> -                           * vnc-jobs-async.c */
>
>      VncDisplay *vd;
>      VncStateUpdate update; /* Most recent pending request from client */
> @@ -339,10 +337,7 @@ struct VncState
>      /* Encoding specific, if you add something here, don't forget to
>       *  update vnc_async_encoding_start()
>       */
> -    VncTight *tight;
> -    VncZlib *zlib;
>      VncHextile hextile;
> -    VncZrle *zrle;
>      VncZywrle zywrle;
>
>      Notifier mouse_mode_notifier;
> @@ -354,6 +349,19 @@ struct VncState
>      QTAILQ_ENTRY(VncState) next;
>  };
>
> +typedef struct VncWorker {
> +    uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];
> +
> +    VncTight tight;
> +    VncZlib zlib;
> +    VncZrle zrle;
> +} VncWorker;
> +
> +typedef struct VncConnection {
> +    VncState vs;
> +    VncWorker worker;
> +} VncConnection;
> +
>
>
>  /***********************************************************************=
******
>   *
> @@ -600,10 +608,11 @@ int vnc_server_fb_stride(VncDisplay *vd);
>
>  void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v);
>  double vnc_update_freq(VncState *vs, int x, int y, int w, int h);
> -void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h);
> +void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h);
>
>  /* Encodings */
> -int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h=
);
> +int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                int x, int y, int w, int h);
>
>  int vnc_raw_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h);
>
> @@ -613,17 +622,21 @@ void vnc_hextile_set_pixel_conversion(VncState *vs,
> int generic);
>
>  void *vnc_zlib_zalloc(void *x, unsigned items, unsigned size);
>  void vnc_zlib_zfree(void *x, void *addr);
> -int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h);
> -void vnc_zlib_clear(VncState *vs);
> -
> -int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h);
> -int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
> -                                          int w, int h);
> -void vnc_tight_clear(VncState *vs);
> -
> -int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h);
> -int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w=
,
> int h);
> -void vnc_zrle_clear(VncState *vs);
> +int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                     int x, int y, int w, int h);
> +void vnc_zlib_clear(VncWorker *worker);
> +
> +int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                      int x, int y, int w, int h);
> +int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worke=
r,
> +                                          int x, int y, int w, int h);
> +void vnc_tight_clear(VncWorker *worker);
> +
> +int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                     int x, int y, int w, int h);
> +int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                       int x, int y, int w, int h);
> +void vnc_zrle_clear(VncWorker *worker);
>
>  /* vnc-clipboard.c */
>  void vnc_server_cut_text_caps(VncState *vs);
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index
> 25c7b2c7889c04253652f63730329052703a10a1..9dfe6ae5a2435ea3c11ebeea85cf514=
16c7d6841
> 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -72,8 +72,8 @@ static const struct {
>  };
>
>
> -static int tight_send_framebuffer_update(VncState *vs, int x, int y,
> -                                         int w, int h);
> +static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker=
,
> +                                         int x, int y, int w, int h);
>
>  #ifdef CONFIG_VNC_JPEG
>  static const struct {
> @@ -111,12 +111,12 @@ static const struct {
>      { 9, PNG_ALL_FILTERS },
>  };
>
> -static int send_png_rect(VncState *vs, int x, int y, int w, int h,
> -                         VncPalette *palette);
> +static int send_png_rect(VncState *vs, VncWorker *worker,
> +                         int x, int y, int w, int h, VncPalette *palette=
);
>
> -static bool tight_can_send_png_rect(VncState *vs, int w, int h)
> +static bool tight_can_send_png_rect(VncState *vs, VncTight *tight, int w=
,
> int h)
>  {
> -    if (vs->tight->type !=3D VNC_ENCODING_TIGHT_PNG) {
> +    if (tight->type !=3D VNC_ENCODING_TIGHT_PNG) {
>          return false;
>      }
>
> @@ -135,7 +135,7 @@ static bool tight_can_send_png_rect(VncState *vs, int
> w, int h)
>   */
>
>  static unsigned int
> -tight_detect_smooth_image24(VncState *vs, int w, int h)
> +tight_detect_smooth_image24(VncState *vs, VncTight *tight, int w, int h)
>  {
>      int off;
>      int x, y, d, dx;
> @@ -144,7 +144,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>      int pixels =3D 0;
>      int pix, left[3];
>      unsigned int errors;
> -    unsigned char *buf =3D vs->tight->tight.buffer;
> +    unsigned char *buf =3D tight->tight.buffer;
>
>      /*
>       * If client is big-endian, color samples begin from the second
> @@ -205,7 +205,8 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>  #define DEFINE_DETECT_FUNCTION(bpp)                                     =
\
>                                                                          =
\
>      static unsigned int                                                 =
\
> -    tight_detect_smooth_image##bpp(VncState *vs, int w, int h) {        =
\
> +    tight_detect_smooth_image##bpp(VncState *vs, VncTight *tight,       =
\
> +                                   int w, int h) {                      =
\
>          bool endian;                                                    =
\
>          uint##bpp##_t pix;                                              =
\
>          int max[3], shift[3];                                           =
\
> @@ -215,7 +216,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int =
h)
>          int pixels =3D 0;                                               =
  \
>          int sample, sum, left[3];                                       =
\
>          unsigned int errors;                                            =
\
> -        unsigned char *buf =3D vs->tight->tight.buffer;                 =
   \
> +        unsigned char *buf =3D tight->tight.buffer;                     =
  \
>                                                                          =
\
>          endian =3D 0; /* FIXME */                                       =
  \
>                                                                          =
\
> @@ -293,11 +294,11 @@ DEFINE_DETECT_FUNCTION(16)
>  DEFINE_DETECT_FUNCTION(32)
>
>  static int
> -tight_detect_smooth_image(VncState *vs, int w, int h)
> +tight_detect_smooth_image(VncState *vs, VncTight *tight, int w, int h)
>  {
>      unsigned int errors;
> -    int compression =3D vs->tight->compression;
> -    int quality =3D vs->tight->quality;
> +    int compression =3D tight->compression;
> +    int quality =3D tight->quality;
>
>      if (!vs->vd->lossy) {
>          return 0;
> @@ -309,7 +310,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
>          return 0;
>      }
>
> -    if (vs->tight->quality !=3D (uint8_t)-1) {
> +    if (tight->quality !=3D (uint8_t)-1) {
>          if (w * h < VNC_TIGHT_JPEG_MIN_RECT_SIZE) {
>              return 0;
>          }
> @@ -320,17 +321,17 @@ tight_detect_smooth_image(VncState *vs, int w, int =
h)
>      }
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -        if (vs->tight->pixel24) {
> -            errors =3D tight_detect_smooth_image24(vs, w, h);
> -            if (vs->tight->quality !=3D (uint8_t)-1) {
> +        if (tight->pixel24) {
> +            errors =3D tight_detect_smooth_image24(vs, tight, w, h);
> +            if (tight->quality !=3D (uint8_t)-1) {
>                  return (errors < tight_conf[quality].jpeg_threshold24);
>              }
>              return (errors <
> tight_conf[compression].gradient_threshold24);
>          } else {
> -            errors =3D tight_detect_smooth_image32(vs, w, h);
> +            errors =3D tight_detect_smooth_image32(vs, tight, w, h);
>          }
>      } else {
> -        errors =3D tight_detect_smooth_image16(vs, w, h);
> +        errors =3D tight_detect_smooth_image16(vs, tight, w, h);
>      }
>      if (quality !=3D (uint8_t)-1) {
>          return (errors < tight_conf[quality].jpeg_threshold);
> @@ -344,15 +345,15 @@ tight_detect_smooth_image(VncState *vs, int w, int =
h)
>  #define DEFINE_FILL_PALETTE_FUNCTION(bpp)                               =
\
>                                                                          =
\
>      static int                                                          =
\
> -    tight_fill_palette##bpp(VncState *vs, int x, int y,                 =
\
> -                            int max, size_t count,                      =
\
> +    tight_fill_palette##bpp(VncState *vs, VncTight *tight,              =
\
> +                            int x, int y, int max, size_t count,        =
\
>                              uint32_t *bg, uint32_t *fg,                 =
\
>                              VncPalette *palette) {                      =
\
>          uint##bpp##_t *data;                                            =
\
>          uint##bpp##_t c0, c1, ci;                                       =
\
>          int i, n0, n1;                                                  =
\
>                                                                          =
\
> -        data =3D (uint##bpp##_t *)vs->tight->tight.buffer;              =
  \
> +        data =3D (uint##bpp##_t *)tight->tight.buffer;                  =
  \
>                                                                          =
\
>          c0 =3D data[0];                                                 =
  \
>          i =3D 1;                                                        =
  \
> @@ -417,15 +418,15 @@ DEFINE_FILL_PALETTE_FUNCTION(8)
>  DEFINE_FILL_PALETTE_FUNCTION(16)
>  DEFINE_FILL_PALETTE_FUNCTION(32)
>
> -static int tight_fill_palette(VncState *vs, int x, int y,
> +static int tight_fill_palette(VncState *vs, VncTight *tight, int x, int =
y,
>                                size_t count, uint32_t *bg, uint32_t *fg,
>                                VncPalette *palette)
>  {
>      int max;
>
> -    max =3D count /
> tight_conf[vs->tight->compression].idx_max_colors_divisor;
> +    max =3D count / tight_conf[tight->compression].idx_max_colors_diviso=
r;
>      if (max < 2 &&
> -        count >=3D tight_conf[vs->tight->compression].mono_min_rect_size=
) {
> +        count >=3D tight_conf[tight->compression].mono_min_rect_size) {
>          max =3D 2;
>      }
>      if (max >=3D 256) {
> @@ -434,12 +435,15 @@ static int tight_fill_palette(VncState *vs, int x,
> int y,
>
>      switch (vs->client_pf.bytes_per_pixel) {
>      case 4:
> -        return tight_fill_palette32(vs, x, y, max, count, bg, fg,
> palette);
> +        return tight_fill_palette32(vs, tight, x, y, max, count, bg, fg,
> +                                    palette);
>      case 2:
> -        return tight_fill_palette16(vs, x, y, max, count, bg, fg,
> palette);
> +        return tight_fill_palette16(vs, tight, x, y, max, count, bg, fg,
> +                                    palette);
>      default:
>          max =3D 2;
> -        return tight_fill_palette8(vs, x, y, max, count, bg, fg, palette=
);
> +        return tight_fill_palette8(vs, tight, x, y, max, count, bg, fg,
> +                                   palette);
>      }
>      return 0;
>  }
> @@ -547,7 +551,8 @@ DEFINE_MONO_ENCODE_FUNCTION(32)
>   */
>
>  static void
> -tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
> +tight_filter_gradient24(VncState *vs, VncTight *tight, uint8_t *buf,
> +                        int w, int h)
>  {
>      uint32_t *buf32;
>      uint32_t pix32;
> @@ -558,7 +563,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>      int x, y, c;
>
>      buf32 =3D (uint32_t *)buf;
> -    memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));
> +    memset(tight->gradient.buffer, 0, w * 3 * sizeof(int));
>
>      if (1 /* FIXME */) {
>          shift[0] =3D vs->client_pf.rshift;
> @@ -575,7 +580,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>              upper[c] =3D 0;
>              here[c] =3D 0;
>          }
> -        prev =3D (int *)vs->tight->gradient.buffer;
> +        prev =3D (int *)tight->gradient.buffer;
>          for (x =3D 0; x < w; x++) {
>              pix32 =3D *buf32++;
>              for (c =3D 0; c < 3; c++) {
> @@ -605,8 +610,8 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>  #define DEFINE_GRADIENT_FILTER_FUNCTION(bpp)                            =
\
>                                                                          =
\
>      static void                                                         =
\
> -    tight_filter_gradient##bpp(VncState *vs, uint##bpp##_t *buf,        =
\
> -                               int w, int h) {                          =
\
> +    tight_filter_gradient##bpp(VncState *vs, VncTight *tight,           =
\
> +                               uint##bpp##_t *buf, int w, int h) {      =
\
>          uint##bpp##_t pix, diff;                                        =
\
>          bool endian;                                                    =
\
>          int *prev;                                                      =
\
> @@ -615,7 +620,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>          int prediction;                                                 =
\
>          int x, y, c;                                                    =
\
>                                                                          =
\
> -        memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));     =
\
> +        memset(tight->gradient.buffer, 0, w * 3 * sizeof(int));         =
\
>                                                                          =
\
>          endian =3D 0; /* FIXME */                                       =
  \
>                                                                          =
\
> @@ -631,7 +636,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf,
> int w, int h)
>                  upper[c] =3D 0;                                         =
  \
>                  here[c] =3D 0;                                          =
  \
>              }                                                           =
\
> -            prev =3D (int *)vs->tight->gradient.buffer;                 =
   \
> +            prev =3D (int *)tight->gradient.buffer;                     =
  \
>              for (x =3D 0; x < w; x++) {                                 =
  \
>                  pix =3D *buf;                                           =
  \
>                  if (endian) {                                           =
\
> @@ -782,10 +787,10 @@ static void extend_solid_area(VncState *vs, int x,
> int y, int w, int h,
>      *w_ptr +=3D cx - (*x_ptr + *w_ptr);
>  }
>
> -static int tight_init_stream(VncState *vs, int stream_id,
> +static int tight_init_stream(VncState *vs, VncTight *tight, int stream_i=
d,
>                               int level, int strategy)
>  {
> -    z_streamp zstream =3D &vs->tight->stream[stream_id];
> +    z_streamp zstream =3D &tight->stream[stream_id];
>
>      if (zstream->opaque =3D=3D NULL) {
>          int err;
> @@ -803,15 +808,15 @@ static int tight_init_stream(VncState *vs, int
> stream_id,
>              return -1;
>          }
>
> -        vs->tight->levels[stream_id] =3D level;
> +        tight->levels[stream_id] =3D level;
>          zstream->opaque =3D vs;
>      }
>
> -    if (vs->tight->levels[stream_id] !=3D level) {
> +    if (tight->levels[stream_id] !=3D level) {
>          if (deflateParams(zstream, level, strategy) !=3D Z_OK) {
>              return -1;
>          }
> -        vs->tight->levels[stream_id] =3D level;
> +        tight->levels[stream_id] =3D level;
>      }
>      return 0;
>  }
> @@ -836,29 +841,29 @@ static void tight_send_compact_size(VncState *vs,
> size_t len)
>      }
>  }
>
> -static int tight_compress_data(VncState *vs, int stream_id, size_t bytes=
,
> -                               int level, int strategy)
> +static int tight_compress_data(VncState *vs, VncTight *tight, int
> stream_id,
> +                               size_t bytes, int level, int strategy)
>  {
> -    z_streamp zstream =3D &vs->tight->stream[stream_id];
> +    z_streamp zstream =3D &tight->stream[stream_id];
>      int previous_out;
>
>      if (bytes < VNC_TIGHT_MIN_TO_COMPRESS) {
> -        vnc_write(vs, vs->tight->tight.buffer, vs->tight->tight.offset);
> +        vnc_write(vs, tight->tight.buffer, tight->tight.offset);
>          return bytes;
>      }
>
> -    if (tight_init_stream(vs, stream_id, level, strategy)) {
> +    if (tight_init_stream(vs, tight, stream_id, level, strategy)) {
>          return -1;
>      }
>
>      /* reserve memory in output buffer */
> -    buffer_reserve(&vs->tight->zlib, bytes + 64);
> +    buffer_reserve(&tight->zlib, bytes + 64);
>
>      /* set pointers */
> -    zstream->next_in =3D vs->tight->tight.buffer;
> -    zstream->avail_in =3D vs->tight->tight.offset;
> -    zstream->next_out =3D vs->tight->zlib.buffer + vs->tight->zlib.offse=
t;
> -    zstream->avail_out =3D vs->tight->zlib.capacity -
> vs->tight->zlib.offset;
> +    zstream->next_in =3D tight->tight.buffer;
> +    zstream->avail_in =3D tight->tight.offset;
> +    zstream->next_out =3D tight->zlib.buffer + tight->zlib.offset;
> +    zstream->avail_out =3D tight->zlib.capacity - tight->zlib.offset;
>      previous_out =3D zstream->avail_out;
>      zstream->data_type =3D Z_BINARY;
>
> @@ -868,14 +873,14 @@ static int tight_compress_data(VncState *vs, int
> stream_id, size_t bytes,
>          return -1;
>      }
>
> -    vs->tight->zlib.offset =3D vs->tight->zlib.capacity -
> zstream->avail_out;
> +    tight->zlib.offset =3D tight->zlib.capacity - zstream->avail_out;
>      /* ...how much data has actually been produced by deflate() */
>      bytes =3D previous_out - zstream->avail_out;
>
>      tight_send_compact_size(vs, bytes);
> -    vnc_write(vs, vs->tight->zlib.buffer, bytes);
> +    vnc_write(vs, tight->zlib.buffer, bytes);
>
> -    buffer_reset(&vs->tight->zlib);
> +    buffer_reset(&tight->zlib);
>
>      return bytes;
>  }
> @@ -914,67 +919,69 @@ static void tight_pack24(VncState *vs, uint8_t *buf=
,
> size_t count, size_t *ret)
>      }
>  }
>
> -static int send_full_color_rect(VncState *vs, int x, int y, int w, int h=
)
> +static int send_full_color_rect(VncState *vs, VncWorker *worker,
> +                                int x, int y, int w, int h)
>  {
> +    VncTight *tight =3D &worker->tight;
> +    int level =3D tight_conf[tight->compression].raw_zlib_level;
>      int stream =3D 0;
>      ssize_t bytes;
>
>  #ifdef CONFIG_PNG
> -    if (tight_can_send_png_rect(vs, w, h)) {
> -        return send_png_rect(vs, x, y, w, h, NULL);
> +    if (tight_can_send_png_rect(vs, tight, w, h)) {
> +        return send_png_rect(vs, worker, x, y, w, h, NULL);
>      }
>  #endif
>
>      vnc_write_u8(vs, stream << 4); /* no flushing, no filter */
>
> -    if (vs->tight->pixel24) {
> -        tight_pack24(vs, vs->tight->tight.buffer, w * h,
> -                     &vs->tight->tight.offset);
> +    if (tight->pixel24) {
> +        tight_pack24(vs, tight->tight.buffer, w * h,
> &tight->tight.offset);
>          bytes =3D 3;
>      } else {
>          bytes =3D vs->client_pf.bytes_per_pixel;
>      }
>
> -    bytes =3D tight_compress_data(vs, stream, w * h * bytes,
> -
> tight_conf[vs->tight->compression].raw_zlib_level,
> +    bytes =3D tight_compress_data(vs, tight, stream, w * h * bytes, leve=
l,
>                              Z_DEFAULT_STRATEGY);
>
>      return (bytes >=3D 0);
>  }
>
> -static int send_solid_rect(VncState *vs)
> +static int send_solid_rect(VncState *vs, VncWorker *worker)
>  {
> +    VncTight *tight =3D &worker->tight;
>      size_t bytes;
>
>      vnc_write_u8(vs, VNC_TIGHT_FILL << 4); /* no flushing, no filter */
>
> -    if (vs->tight->pixel24) {
> -        tight_pack24(vs, vs->tight->tight.buffer, 1,
> &vs->tight->tight.offset);
> +    if (tight->pixel24) {
> +        tight_pack24(vs, tight->tight.buffer, 1, &tight->tight.offset);
>          bytes =3D 3;
>      } else {
>          bytes =3D vs->client_pf.bytes_per_pixel;
>      }
>
> -    vnc_write(vs, vs->tight->tight.buffer, bytes);
> +    vnc_write(vs, tight->tight.buffer, bytes);
>      return 1;
>  }
>
> -static int send_mono_rect(VncState *vs, int x, int y,
> +static int send_mono_rect(VncState *vs, VncWorker *worker, int x, int y,
>                            int w, int h, uint32_t bg, uint32_t fg)
>  {
>      ssize_t bytes;
>      int stream =3D 1;
> -    int level =3D tight_conf[vs->tight->compression].mono_zlib_level;
> +    int level =3D tight_conf[worker->tight.compression].mono_zlib_level;
>
>  #ifdef CONFIG_PNG
> -    if (tight_can_send_png_rect(vs, w, h)) {
> +    if (tight_can_send_png_rect(vs, &worker->tight, w, h)) {
>          int ret;
>          int bpp =3D vs->client_pf.bytes_per_pixel * 8;
>          VncPalette *palette =3D palette_new(2, bpp);
>
>          palette_put(palette, bg);
>          palette_put(palette, fg);
> -        ret =3D send_png_rect(vs, x, y, w, h, palette);
> +        ret =3D send_png_rect(vs, worker, x, y, w, h, palette);
>          palette_destroy(palette);
>          return ret;
>      }
> @@ -992,12 +999,12 @@ static int send_mono_rect(VncState *vs, int x, int =
y,
>          uint32_t buf[2] =3D {bg, fg};
>          size_t ret =3D sizeof (buf);
>
> -        if (vs->tight->pixel24) {
> +        if (worker->tight.pixel24) {
>              tight_pack24(vs, (unsigned char*)buf, 2, &ret);
>          }
>          vnc_write(vs, buf, ret);
>
> -        tight_encode_mono_rect32(vs->tight->tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect32(worker->tight.tight.buffer, w, h, bg,
> fg);
>          break;
>      }
>      case 2:
> @@ -1006,7 +1013,7 @@ static int send_mono_rect(VncState *vs, int x, int =
y,
>          uint16_t fg16 =3D fg;
>          vnc_write(vs, &bg16, 2);
>          vnc_write(vs, &fg16, 2);
> -        tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect16(worker->tight.tight.buffer, w, h, bg,
> fg);
>          break;
>      }
>      default:
> @@ -1015,18 +1022,20 @@ static int send_mono_rect(VncState *vs, int x, in=
t
> y,
>          uint8_t fg8 =3D fg;
>          vnc_write_u8(vs, bg8);
>          vnc_write_u8(vs, fg8);
> -        tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
> +        tight_encode_mono_rect8(worker->tight.tight.buffer, w, h, bg, fg=
);
>          break;
>      }
>      }
> -    vs->tight->tight.offset =3D bytes;
> +    worker->tight.tight.offset =3D bytes;
>
> -    bytes =3D tight_compress_data(vs, stream, bytes, level,
> Z_DEFAULT_STRATEGY);
> +    bytes =3D tight_compress_data(vs, &worker->tight, stream, bytes, lev=
el,
> +                                Z_DEFAULT_STRATEGY);
>      return (bytes >=3D 0);
>  }
>
>  struct palette_cb_priv {
>      VncState *vs;
> +    VncTight *tight;
>      uint8_t *header;
>  #ifdef CONFIG_PNG
>      png_colorp png_palette;
> @@ -1046,53 +1055,58 @@ static void write_palette(int idx, uint32_t color=
,
> void *opaque)
>      }
>  }
>
> -static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
> +static bool send_gradient_rect(VncState *vs, VncWorker *worker,
> +                               int x, int y, int w, int h)
>  {
> +    VncTight *tight =3D &worker->tight;
>      int stream =3D 3;
> -    int level =3D tight_conf[vs->tight->compression].gradient_zlib_level=
;
> +    int level =3D tight_conf[tight->compression].gradient_zlib_level;
>      ssize_t bytes;
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 1) {
> -        return send_full_color_rect(vs, x, y, w, h);
> +        return send_full_color_rect(vs, worker, x, y, w, h);
>      }
>
>      vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
>      vnc_write_u8(vs, VNC_TIGHT_FILTER_GRADIENT);
>
> -    buffer_reserve(&vs->tight->gradient, w * 3 * sizeof(int));
> +    buffer_reserve(&tight->gradient, w * 3 * sizeof(int));
>
> -    if (vs->tight->pixel24) {
> -        tight_filter_gradient24(vs, vs->tight->tight.buffer, w, h);
> +    if (tight->pixel24) {
> +        tight_filter_gradient24(vs, tight, tight->tight.buffer, w, h);
>          bytes =3D 3;
>      } else if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -        tight_filter_gradient32(vs, (uint32_t *)vs->tight->tight.buffer,
> w, h);
> +        tight_filter_gradient32(vs, tight, (uint32_t
> *)tight->tight.buffer,
> +                                w, h);
>          bytes =3D 4;
>      } else {
> -        tight_filter_gradient16(vs, (uint16_t *)vs->tight->tight.buffer,
> w, h);
> +        tight_filter_gradient16(vs, tight, (uint16_t
> *)tight->tight.buffer,
> +                                w, h);
>          bytes =3D 2;
>      }
>
> -    buffer_reset(&vs->tight->gradient);
> +    buffer_reset(&tight->gradient);
>
>      bytes =3D w * h * bytes;
> -    vs->tight->tight.offset =3D bytes;
> +    tight->tight.offset =3D bytes;
>
> -    bytes =3D tight_compress_data(vs, stream, bytes,
> +    bytes =3D tight_compress_data(vs, tight, stream, bytes,
>                                  level, Z_FILTERED);
>      return (bytes >=3D 0);
>  }
>
> -static int send_palette_rect(VncState *vs, int x, int y,
> +static int send_palette_rect(VncState *vs, VncWorker *worker, int x, int
> y,
>                               int w, int h, VncPalette *palette)
>  {
> +    VncTight *tight =3D &worker->tight;
>      int stream =3D 2;
> -    int level =3D tight_conf[vs->tight->compression].idx_zlib_level;
> +    int level =3D tight_conf[tight->compression].idx_zlib_level;
>      int colors;
>      ssize_t bytes;
>
>  #ifdef CONFIG_PNG
> -    if (tight_can_send_png_rect(vs, w, h)) {
> -        return send_png_rect(vs, x, y, w, h, palette);
> +    if (tight_can_send_png_rect(vs, tight, w, h)) {
> +        return send_png_rect(vs, worker, x, y, w, h, palette);
>      }
>  #endif
>
> @@ -1107,38 +1121,38 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>      {
>          size_t old_offset, offset, palette_sz =3D palette_size(palette);
>          g_autofree uint32_t *header =3D g_new(uint32_t, palette_sz);
> -        struct palette_cb_priv priv =3D { vs, (uint8_t *)header };
> +        struct palette_cb_priv priv =3D { vs, tight, (uint8_t *)header }=
;
>
>          old_offset =3D vs->output.offset;
>          palette_iter(palette, write_palette, &priv);
>          vnc_write(vs, header, palette_sz * sizeof(uint32_t));
>
> -        if (vs->tight->pixel24) {
> +        if (tight->pixel24) {
>              tight_pack24(vs, vs->output.buffer + old_offset, colors,
> &offset);
>              vs->output.offset =3D old_offset + offset;
>          }
>
> -        tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
> palette);
> +        tight_encode_indexed_rect32(tight->tight.buffer, w * h, palette)=
;
>          break;
>      }
>      case 2:
>      {
>          size_t palette_sz =3D palette_size(palette);
>          g_autofree uint16_t *header =3D g_new(uint16_t, palette_sz);
> -        struct palette_cb_priv priv =3D { vs, (uint8_t *)header };
> +        struct palette_cb_priv priv =3D { vs, tight, (uint8_t *)header }=
;
>
>          palette_iter(palette, write_palette, &priv);
>          vnc_write(vs, header, palette_sz * sizeof(uint16_t));
> -        tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
> palette);
> +        tight_encode_indexed_rect16(tight->tight.buffer, w * h, palette)=
;
>          break;
>      }
>      default:
>          return -1; /* No palette for 8bits colors */
>      }
>      bytes =3D w * h;
> -    vs->tight->tight.offset =3D bytes;
> +    tight->tight.offset =3D bytes;
>
> -    bytes =3D tight_compress_data(vs, stream, bytes,
> +    bytes =3D tight_compress_data(vs, tight, stream, bytes,
>                                  level, Z_DEFAULT_STRATEGY);
>      return (bytes >=3D 0);
>  }
> @@ -1154,8 +1168,8 @@ static int send_palette_rect(VncState *vs, int x,
> int y,
>  /* This is called once per encoding */
>  static void jpeg_init_destination(j_compress_ptr cinfo)
>  {
> -    VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight->jpeg;
> +    VncTight *tight =3D cinfo->client_data;
> +    Buffer *buffer =3D &tight->jpeg;
>
>      cinfo->dest->next_output_byte =3D (JOCTET *)buffer->buffer +
> buffer->offset;
>      cinfo->dest->free_in_buffer =3D (size_t)(buffer->capacity -
> buffer->offset);
> @@ -1164,8 +1178,8 @@ static void jpeg_init_destination(j_compress_ptr
> cinfo)
>  /* This is called when we ran out of buffer (shouldn't happen!) */
>  static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
>  {
> -    VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight->jpeg;
> +    VncTight *tight =3D cinfo->client_data;
> +    Buffer *buffer =3D &tight->jpeg;
>
>      buffer->offset =3D buffer->capacity;
>      buffer_reserve(buffer, 2048);
> @@ -1176,13 +1190,14 @@ static boolean
> jpeg_empty_output_buffer(j_compress_ptr cinfo)
>  /* This is called when we are done processing data */
>  static void jpeg_term_destination(j_compress_ptr cinfo)
>  {
> -    VncState *vs =3D cinfo->client_data;
> -    Buffer *buffer =3D &vs->tight->jpeg;
> +    VncTight *tight =3D cinfo->client_data;
> +    Buffer *buffer =3D &tight->jpeg;
>
>      buffer->offset =3D buffer->capacity - cinfo->dest->free_in_buffer;
>  }
>
> -static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int
> quality)
> +static int send_jpeg_rect(VncState *vs, VncWorker *worker,
> +                          int x, int y, int w, int h, int quality)
>  {
>      struct jpeg_compress_struct cinfo;
>      struct jpeg_error_mgr jerr;
> @@ -1193,15 +1208,15 @@ static int send_jpeg_rect(VncState *vs, int x, in=
t
> y, int w, int h, int quality)
>      int dy;
>
>      if (surface_bytes_per_pixel(vs->vd->ds) =3D=3D 1) {
> -        return send_full_color_rect(vs, x, y, w, h);
> +        return send_full_color_rect(vs, worker, x, y, w, h);
>      }
>
> -    buffer_reserve(&vs->tight->jpeg, 2048);
> +    buffer_reserve(&worker->tight.jpeg, 2048);
>
>      cinfo.err =3D jpeg_std_error(&jerr);
>      jpeg_create_compress(&cinfo);
>
> -    cinfo.client_data =3D vs;
> +    cinfo.client_data =3D &worker->tight;
>      cinfo.image_width =3D w;
>      cinfo.image_height =3D h;
>      cinfo.input_components =3D 3;
> @@ -1231,9 +1246,9 @@ static int send_jpeg_rect(VncState *vs, int x, int
> y, int w, int h, int quality)
>
>      vnc_write_u8(vs, VNC_TIGHT_JPEG << 4);
>
> -    tight_send_compact_size(vs, vs->tight->jpeg.offset);
> -    vnc_write(vs, vs->tight->jpeg.buffer, vs->tight->jpeg.offset);
> -    buffer_reset(&vs->tight->jpeg);
> +    tight_send_compact_size(vs, worker->tight.jpeg.offset);
> +    vnc_write(vs, worker->tight.jpeg.buffer, worker->tight.jpeg.offset);
> +    buffer_reset(&worker->tight.jpeg);
>
>      return 1;
>  }
> @@ -1249,7 +1264,7 @@ static void write_png_palette(int idx, uint32_t pix=
,
> void *opaque)
>      VncState *vs =3D priv->vs;
>      png_colorp color =3D &priv->png_palette[idx];
>
> -    if (vs->tight->pixel24)
> +    if (priv->tight->pixel24)
>      {
>          color->red =3D (pix >> vs->client_pf.rshift) & vs->client_pf.rma=
x;
>          color->green =3D (pix >> vs->client_pf.gshift) & vs->client_pf.g=
max;
> @@ -1274,12 +1289,12 @@ static void write_png_palette(int idx, uint32_t
> pix, void *opaque)
>  static void png_write_data(png_structp png_ptr, png_bytep data,
>                             png_size_t length)
>  {
> -    VncState *vs =3D png_get_io_ptr(png_ptr);
> +    VncWorker *worker =3D png_get_io_ptr(png_ptr);
>
> -    buffer_reserve(&vs->tight->png, vs->tight->png.offset + length);
> -    memcpy(vs->tight->png.buffer + vs->tight->png.offset, data, length);
> +    buffer_reserve(&worker->tight.png, worker->tight.png.offset + length=
);
> +    memcpy(worker->tight.png.buffer + worker->tight.png.offset, data,
> length);
>
> -    vs->tight->png.offset +=3D length;
> +    worker->tight.png.offset +=3D length;
>  }
>
>  static void png_flush_data(png_structp png_ptr)
> @@ -1296,16 +1311,16 @@ static void vnc_png_free(png_structp png_ptr,
> png_voidp ptr)
>      g_free(ptr);
>  }
>
> -static int send_png_rect(VncState *vs, int x, int y, int w, int h,
> -                         VncPalette *palette)
> +static int send_png_rect(VncState *vs, VncWorker *worker,
> +                         int x, int y, int w, int h, VncPalette *palette=
)
>  {
>      png_byte color_type;
>      png_structp png_ptr;
>      png_infop info_ptr;
>      png_colorp png_palette =3D NULL;
>      pixman_image_t *linebuf;
> -    int level =3D tight_png_conf[vs->tight->compression].png_zlib_level;
> -    int filters =3D tight_png_conf[vs->tight->compression].png_filters;
> +    int level =3D tight_png_conf[worker->tight.compression].png_zlib_lev=
el;
> +    int filters =3D tight_png_conf[worker->tight.compression].png_filter=
s;
>      uint8_t *buf;
>      int dy;
>
> @@ -1322,7 +1337,7 @@ static int send_png_rect(VncState *vs, int x, int y=
,
> int w, int h,
>          return -1;
>      }
>
> -    png_set_write_fn(png_ptr, (void *) vs, png_write_data,
> png_flush_data);
> +    png_set_write_fn(png_ptr, worker, png_write_data, png_flush_data);
>      png_set_compression_level(png_ptr, level);
>      png_set_filter(png_ptr, PNG_FILTER_TYPE_DEFAULT, filters);
>
> @@ -1343,29 +1358,30 @@ static int send_png_rect(VncState *vs, int x, int
> y, int w, int h,
>                                   palette_size(palette));
>
>          priv.vs =3D vs;
> +        priv.tight =3D &worker->tight;
>          priv.png_palette =3D png_palette;
>          palette_iter(palette, write_png_palette, &priv);
>
>          png_set_PLTE(png_ptr, info_ptr, png_palette,
> palette_size(palette));
>
>          if (vs->client_pf.bytes_per_pixel =3D=3D 4) {
> -            tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
> +            tight_encode_indexed_rect32(worker->tight.tight.buffer, w * =
h,
>                                          palette);
>          } else {
> -            tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
> +            tight_encode_indexed_rect16(worker->tight.tight.buffer, w * =
h,
>                                          palette);
>          }
>      }
>
>      png_write_info(png_ptr, info_ptr);
>
> -    buffer_reserve(&vs->tight->png, 2048);
> +    buffer_reserve(&worker->tight.png, 2048);
>      linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, w);
>      buf =3D (uint8_t *)pixman_image_get_data(linebuf);
>      for (dy =3D 0; dy < h; dy++)
>      {
>          if (color_type =3D=3D PNG_COLOR_TYPE_PALETTE) {
> -            memcpy(buf, vs->tight->tight.buffer + (dy * w), w);
> +            memcpy(buf, worker->tight.tight.buffer + (dy * w), w);
>          } else {
>              qemu_pixman_linebuf_fill(linebuf, vs->vd->server, w, x, y +
> dy);
>          }
> @@ -1383,46 +1399,47 @@ static int send_png_rect(VncState *vs, int x, int
> y, int w, int h,
>
>      vnc_write_u8(vs, VNC_TIGHT_PNG << 4);
>
> -    tight_send_compact_size(vs, vs->tight->png.offset);
> -    vnc_write(vs, vs->tight->png.buffer, vs->tight->png.offset);
> -    buffer_reset(&vs->tight->png);
> +    tight_send_compact_size(vs, worker->tight.png.offset);
> +    vnc_write(vs, worker->tight.png.buffer, worker->tight.png.offset);
> +    buffer_reset(&worker->tight.png);
>      return 1;
>  }
>  #endif /* CONFIG_PNG */
>
> -static void vnc_tight_start(VncState *vs)
> +static void vnc_tight_start(VncState *vs, VncTight *tight)
>  {
> -    buffer_reset(&vs->tight->tight);
> +    buffer_reset(&tight->tight);
>
>      // make the output buffer be the zlib buffer, so we can compress it
> later
> -    vs->tight->tmp =3D vs->output;
> -    vs->output =3D vs->tight->tight;
> +    tight->tmp =3D vs->output;
> +    vs->output =3D tight->tight;
>  }
>
> -static void vnc_tight_stop(VncState *vs)
> +static void vnc_tight_stop(VncState *vs, VncTight *tight)
>  {
>      // switch back to normal output/zlib buffers
> -    vs->tight->tight =3D vs->output;
> -    vs->output =3D vs->tight->tmp;
> +    tight->tight =3D vs->output;
> +    vs->output =3D tight->tmp;
>  }
>
> -static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h=
,
> +static int send_sub_rect_nojpeg(VncState *vs, VncWorker *worker,
> +                                int x, int y, int w, int h,
>                                  int bg, int fg, int colors, VncPalette
> *palette)
>  {
>      int ret;
>
>      if (colors =3D=3D 0) {
> -        if (tight_detect_smooth_image(vs, w, h)) {
> -            ret =3D send_gradient_rect(vs, x, y, w, h);
> +        if (tight_detect_smooth_image(vs, &worker->tight, w, h)) {
> +            ret =3D send_gradient_rect(vs, worker, x, y, w, h);
>          } else {
> -            ret =3D send_full_color_rect(vs, x, y, w, h);
> +            ret =3D send_full_color_rect(vs, worker, x, y, w, h);
>          }
>      } else if (colors =3D=3D 1) {
> -        ret =3D send_solid_rect(vs);
> +        ret =3D send_solid_rect(vs, worker);
>      } else if (colors =3D=3D 2) {
> -        ret =3D send_mono_rect(vs, x, y, w, h, bg, fg);
> +        ret =3D send_mono_rect(vs, worker, x, y, w, h, bg, fg);
>      } else if (colors <=3D 256) {
> -        ret =3D send_palette_rect(vs, x, y, w, h, palette);
> +        ret =3D send_palette_rect(vs, worker, x, y, w, h, palette);
>      } else {
>          ret =3D 0;
>      }
> @@ -1430,34 +1447,35 @@ static int send_sub_rect_nojpeg(VncState *vs, int
> x, int y, int w, int h,
>  }
>
>  #ifdef CONFIG_VNC_JPEG
> -static int send_sub_rect_jpeg(VncState *vs, int x, int y, int w, int h,
> +static int send_sub_rect_jpeg(VncState *vs, VncWorker *worker,
> +                              int x, int y, int w, int h,
>                                int bg, int fg, int colors,
>                                VncPalette *palette, bool force)
>  {
>      int ret;
>
>      if (colors =3D=3D 0) {
> -        if (force || (tight_jpeg_conf[vs->tight->quality].jpeg_full &&
> -                      tight_detect_smooth_image(vs, w, h))) {
> -            int quality =3D tight_conf[vs->tight->quality].jpeg_quality;
> +        if (force || (tight_jpeg_conf[worker->tight.quality].jpeg_full &=
&
> +                      tight_detect_smooth_image(vs, &worker->tight, w,
> h))) {
> +            int quality =3D tight_conf[worker->tight.quality].jpeg_quali=
ty;
>
> -            ret =3D send_jpeg_rect(vs, x, y, w, h, quality);
> +            ret =3D send_jpeg_rect(vs, worker, x, y, w, h, quality);
>          } else {
> -            ret =3D send_full_color_rect(vs, x, y, w, h);
> +            ret =3D send_full_color_rect(vs, worker, x, y, w, h);
>          }
>      } else if (colors =3D=3D 1) {
> -        ret =3D send_solid_rect(vs);
> +        ret =3D send_solid_rect(vs, worker);
>      } else if (colors =3D=3D 2) {
> -        ret =3D send_mono_rect(vs, x, y, w, h, bg, fg);
> +        ret =3D send_mono_rect(vs, worker, x, y, w, h, bg, fg);
>      } else if (colors <=3D 256) {
>          if (force || (colors > 96 &&
> -                      tight_jpeg_conf[vs->tight->quality].jpeg_idx &&
> -                      tight_detect_smooth_image(vs, w, h))) {
> -            int quality =3D tight_conf[vs->tight->quality].jpeg_quality;
> +                      tight_jpeg_conf[worker->tight.quality].jpeg_idx &&
> +                      tight_detect_smooth_image(vs, &worker->tight, w,
> h))) {
> +            int quality =3D tight_conf[worker->tight.quality].jpeg_quali=
ty;
>
> -            ret =3D send_jpeg_rect(vs, x, y, w, h, quality);
> +            ret =3D send_jpeg_rect(vs, worker, x, y, w, h, quality);
>          } else {
> -            ret =3D send_palette_rect(vs, x, y, w, h, palette);
> +            ret =3D send_palette_rect(vs, worker, x, y, w, h, palette);
>          }
>      } else {
>          ret =3D 0;
> @@ -1475,8 +1493,10 @@ static void vnc_tight_cleanup(Notifier *n, void
> *value)
>      color_count_palette =3D NULL;
>  }
>
> -static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
> +static int send_sub_rect(VncState *vs, VncWorker *worker,
> +                         int x, int y, int w, int h)
>  {
> +    VncTight *tight =3D &worker->tight;
>      uint32_t bg =3D 0, fg =3D 0;
>      int colors;
>      int ret =3D 0;
> @@ -1491,57 +1511,59 @@ static int send_sub_rect(VncState *vs, int x, int
> y, int w, int h)
>          qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
>      }
>
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
> +    vnc_framebuffer_update(vs, x, y, w, h, tight->type);
>
> -    vnc_tight_start(vs);
> +    vnc_tight_start(vs, tight);
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> -    vnc_tight_stop(vs);
> +    vnc_tight_stop(vs, tight);
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (!vs->vd->non_adaptive && vs->tight->quality !=3D (uint8_t)-1) {
> +    if (!vs->vd->non_adaptive && tight->quality !=3D (uint8_t)-1) {
>          double freq =3D vnc_update_freq(vs, x, y, w, h);
>
> -        if (freq < tight_jpeg_conf[vs->tight->quality].jpeg_freq_min) {
> +        if (freq < tight_jpeg_conf[tight->quality].jpeg_freq_min) {
>              allow_jpeg =3D false;
>          }
> -        if (freq >=3D
> tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
> +        if (freq >=3D tight_jpeg_conf[tight->quality].jpeg_freq_threshol=
d) {
>              force_jpeg =3D true;
> -            vnc_sent_lossy_rect(vs, x, y, w, h);
> +            vnc_sent_lossy_rect(worker, x, y, w, h);
>          }
>      }
>  #endif
>
> -    colors =3D tight_fill_palette(vs, x, y, w * h, &bg, &fg,
> color_count_palette);
> +    colors =3D tight_fill_palette(vs, tight, x, y, w * h, &bg, &fg,
> +                                color_count_palette);
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (allow_jpeg && vs->tight->quality !=3D (uint8_t)-1) {
> -        ret =3D send_sub_rect_jpeg(vs, x, y, w, h, bg, fg, colors,
> +    if (allow_jpeg && tight->quality !=3D (uint8_t)-1) {
> +        ret =3D send_sub_rect_jpeg(vs, worker, x, y, w, h, bg, fg, color=
s,
>                                   color_count_palette, force_jpeg);
>      } else {
> -        ret =3D send_sub_rect_nojpeg(vs, x, y, w, h, bg, fg, colors,
> -                                   color_count_palette);
> +        ret =3D send_sub_rect_nojpeg(vs, worker, x, y, w, h, bg, fg,
> +                                   colors, color_count_palette);
>      }
>  #else
> -    ret =3D send_sub_rect_nojpeg(vs, x, y, w, h, bg, fg, colors,
> +    ret =3D send_sub_rect_nojpeg(vs, worker, x, y, w, h, bg, fg, colors,
>                                 color_count_palette);
>  #endif
>
>      return ret;
>  }
>
> -static int send_sub_rect_solid(VncState *vs, int x, int y, int w, int h)
> +static int send_sub_rect_solid(VncState *vs, VncWorker *worker,
> +                               int x, int y, int w, int h)
>  {
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
> +    vnc_framebuffer_update(vs, x, y, w, h, worker->tight.type);
>
> -    vnc_tight_start(vs);
> +    vnc_tight_start(vs, &worker->tight);
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> -    vnc_tight_stop(vs);
> +    vnc_tight_stop(vs, &worker->tight);
>
> -    return send_solid_rect(vs);
> +    return send_solid_rect(vs, worker);
>  }
>
> -static int send_rect_simple(VncState *vs, int x, int y, int w, int h,
> -                            bool split)
> +static int send_rect_simple(VncState *vs, VncWorker *worker,
> +                            int x, int y, int w, int h, bool split)
>  {
>      int max_size, max_width;
>      int max_sub_width, max_sub_height;
> @@ -1549,8 +1571,8 @@ static int send_rect_simple(VncState *vs, int x, in=
t
> y, int w, int h,
>      int rw, rh;
>      int n =3D 0;
>
> -    max_size =3D tight_conf[vs->tight->compression].max_rect_size;
> -    max_width =3D tight_conf[vs->tight->compression].max_rect_width;
> +    max_size =3D tight_conf[worker->tight.compression].max_rect_size;
> +    max_width =3D tight_conf[worker->tight.compression].max_rect_width;
>
>      if (split && (w > max_width || w * h > max_size)) {
>          max_sub_width =3D (w > max_width) ? max_width : w;
> @@ -1560,18 +1582,18 @@ static int send_rect_simple(VncState *vs, int x,
> int y, int w, int h,
>              for (dx =3D 0; dx < w; dx +=3D max_width) {
>                  rw =3D MIN(max_sub_width, w - dx);
>                  rh =3D MIN(max_sub_height, h - dy);
> -                n +=3D send_sub_rect(vs, x+dx, y+dy, rw, rh);
> +                n +=3D send_sub_rect(vs, worker, x + dx, y + dy, rw, rh)=
;
>              }
>          }
>      } else {
> -        n +=3D send_sub_rect(vs, x, y, w, h);
> +        n +=3D send_sub_rect(vs, worker, x, y, w, h);
>      }
>
>      return n;
>  }
>
> -static int find_large_solid_color_rect(VncState *vs, int x, int y,
> -                                       int w, int h, int max_rows)
> +static int find_large_solid_color_rect(VncState *vs, VncWorker *worker,
> +                                       int x, int y, int w, int h, int
> max_rows)
>  {
>      int dx, dy, dw, dh;
>      int n =3D 0;
> @@ -1583,7 +1605,7 @@ static int find_large_solid_color_rect(VncState *vs=
,
> int x, int y,
>          /* If a rectangle becomes too large, send its upper part now. */
>
>          if (dy - y >=3D max_rows) {
> -            n +=3D send_rect_simple(vs, x, y, w, max_rows, true);
> +            n +=3D send_rect_simple(vs, worker, x, y, w, max_rows, true)=
;
>              y +=3D max_rows;
>              h -=3D max_rows;
>          }
> @@ -1622,26 +1644,28 @@ static int find_large_solid_color_rect(VncState
> *vs, int x, int y,
>              /* Send rectangles at top and left to solid-color area. */
>
>              if (y_best !=3D y) {
> -                n +=3D send_rect_simple(vs, x, y, w, y_best-y, true);
> +                n +=3D send_rect_simple(vs, worker, x, y, w, y_best - y,
> true);
>              }
>              if (x_best !=3D x) {
> -                n +=3D tight_send_framebuffer_update(vs, x, y_best,
> +                n +=3D tight_send_framebuffer_update(vs, worker, x, y_be=
st,
>                                                     x_best-x, h_best);
>              }
>
>              /* Send solid-color rectangle. */
> -            n +=3D send_sub_rect_solid(vs, x_best, y_best, w_best, h_bes=
t);
> +            n +=3D send_sub_rect_solid(vs, worker,
> +                                     x_best, y_best, w_best, h_best);
>
>              /* Send remaining rectangles (at right and bottom). */
>
>              if (x_best + w_best !=3D x + w) {
> -                n +=3D tight_send_framebuffer_update(vs, x_best+w_best,
> +                n +=3D tight_send_framebuffer_update(vs, worker, x_best =
+
> w_best,
>                                                     y_best,
>                                                     w-(x_best-x)-w_best,
>                                                     h_best);
>              }
>              if (y_best + h_best !=3D y + h) {
> -                n +=3D tight_send_framebuffer_update(vs, x, y_best+h_bes=
t,
> +                n +=3D tight_send_framebuffer_update(vs, worker,
> +                                                   x, y_best + h_best,
>                                                     w,
> h-(y_best-y)-h_best);
>              }
>
> @@ -1649,73 +1673,73 @@ static int find_large_solid_color_rect(VncState
> *vs, int x, int y,
>              return n;
>          }
>      }
> -    return n + send_rect_simple(vs, x, y, w, h, true);
> +    return n + send_rect_simple(vs, worker, x, y, w, h, true);
>  }
>
> -static int tight_send_framebuffer_update(VncState *vs, int x, int y,
> -                                         int w, int h)
> +static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker=
,
> +                                         int x, int y, int w, int h)
>  {
>      int max_rows;
>
>      if (vs->client_pf.bytes_per_pixel =3D=3D 4 && vs->client_pf.rmax =3D=
=3D 0xFF
> &&
>          vs->client_pf.bmax =3D=3D 0xFF && vs->client_pf.gmax =3D=3D 0xFF=
) {
> -        vs->tight->pixel24 =3D true;
> +        worker->tight.pixel24 =3D true;
>      } else {
> -        vs->tight->pixel24 =3D false;
> +        worker->tight.pixel24 =3D false;
>      }
>
>  #ifdef CONFIG_VNC_JPEG
> -    if (vs->tight->quality !=3D (uint8_t)-1) {
> +    if (worker->tight.quality !=3D (uint8_t)-1) {
>          double freq =3D vnc_update_freq(vs, x, y, w, h);
>
> -        if (freq >
> tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
> -            return send_rect_simple(vs, x, y, w, h, false);
> +        if (freq >
> tight_jpeg_conf[worker->tight.quality].jpeg_freq_threshold) {
> +            return send_rect_simple(vs, worker, x, y, w, h, false);
>          }
>      }
>  #endif
>
>      if (w * h < VNC_TIGHT_MIN_SPLIT_RECT_SIZE) {
> -        return send_rect_simple(vs, x, y, w, h, true);
> +        return send_rect_simple(vs, worker, x, y, w, h, true);
>      }
>
>      /* Calculate maximum number of rows in one non-solid rectangle. */
>
> -    max_rows =3D tight_conf[vs->tight->compression].max_rect_size;
> -    max_rows /=3D MIN(tight_conf[vs->tight->compression].max_rect_width,=
 w);
> +    max_rows =3D tight_conf[worker->tight.compression].max_rect_size;
> +    max_rows /=3D MIN(tight_conf[worker->tight.compression].max_rect_wid=
th,
> w);
>
> -    return find_large_solid_color_rect(vs, x, y, w, h, max_rows);
> +    return find_large_solid_color_rect(vs, worker, x, y, w, h, max_rows)=
;
>  }
>
> -int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y,
> -                                      int w, int h)
> +int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                      int x, int y, int w, int h)
>  {
> -    vs->tight->type =3D VNC_ENCODING_TIGHT;
> -    return tight_send_framebuffer_update(vs, x, y, w, h);
> +    worker->tight.type =3D VNC_ENCODING_TIGHT;
> +    return tight_send_framebuffer_update(vs, worker, x, y, w, h);
>  }
>
> -int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
> -                                          int w, int h)
> +int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worke=
r,
> +                                          int x, int y, int w, int h)
>  {
> -    vs->tight->type =3D VNC_ENCODING_TIGHT_PNG;
> -    return tight_send_framebuffer_update(vs, x, y, w, h);
> +    worker->tight.type =3D VNC_ENCODING_TIGHT_PNG;
> +    return tight_send_framebuffer_update(vs, worker, x, y, w, h);
>  }
>
> -void vnc_tight_clear(VncState *vs)
> +void vnc_tight_clear(VncWorker *worker)
>  {
>      int i;
> -    for (i =3D 0; i < ARRAY_SIZE(vs->tight->stream); i++) {
> -        if (vs->tight->stream[i].opaque) {
> -            deflateEnd(&vs->tight->stream[i]);
> +    for (i =3D 0; i < ARRAY_SIZE(worker->tight.stream); i++) {
> +        if (worker->tight.stream[i].opaque) {
> +            deflateEnd(&worker->tight.stream[i]);
>          }
>      }
>
> -    buffer_free(&vs->tight->tight);
> -    buffer_free(&vs->tight->zlib);
> -    buffer_free(&vs->tight->gradient);
> +    buffer_free(&worker->tight.tight);
> +    buffer_free(&worker->tight.zlib);
> +    buffer_free(&worker->tight.gradient);
>  #ifdef CONFIG_VNC_JPEG
> -    buffer_free(&vs->tight->jpeg);
> +    buffer_free(&worker->tight.jpeg);
>  #endif
>  #ifdef CONFIG_PNG
> -    buffer_free(&vs->tight->png);
> +    buffer_free(&worker->tight.png);
>  #endif
>  }
> diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
> index
> 52e9193eab572a79733b11c89bde81daf01679e7..a6d287118aaaed30372d90668f0406d=
e4d14599c
> 100644
> --- a/ui/vnc-enc-zlib.c
> +++ b/ui/vnc-enc-zlib.c
> @@ -46,23 +46,23 @@ void vnc_zlib_zfree(void *x, void *addr)
>      g_free(addr);
>  }
>
> -static void vnc_zlib_start(VncState *vs)
> +static void vnc_zlib_start(VncState *vs, VncWorker *worker)
>  {
> -    buffer_reset(&vs->zlib->zlib);
> +    buffer_reset(&worker->zlib.zlib);
>
>      // make the output buffer be the zlib buffer, so we can compress it
> later
> -    vs->zlib->tmp =3D vs->output;
> -    vs->output =3D vs->zlib->zlib;
> +    worker->zlib.tmp =3D vs->output;
> +    vs->output =3D worker->zlib.zlib;
>  }
>
> -static int vnc_zlib_stop(VncState *vs)
> +static int vnc_zlib_stop(VncState *vs, VncWorker *worker)
>  {
> -    z_streamp zstream =3D &vs->zlib->stream;
> +    z_streamp zstream =3D &worker->zlib.stream;
>      int previous_out;
>
>      // switch back to normal output/zlib buffers
> -    vs->zlib->zlib =3D vs->output;
> -    vs->output =3D vs->zlib->tmp;
> +    worker->zlib.zlib =3D vs->output;
> +    vs->output =3D worker->zlib.tmp;
>
>      // compress the zlib buffer
>
> @@ -76,7 +76,7 @@ static int vnc_zlib_stop(VncState *vs)
>          zstream->zalloc =3D vnc_zlib_zalloc;
>          zstream->zfree =3D vnc_zlib_zfree;
>
> -        err =3D deflateInit2(zstream, vs->tight->compression, Z_DEFLATED=
,
> +        err =3D deflateInit2(zstream, worker->tight.compression, Z_DEFLA=
TED,
>                             MAX_WBITS,
>                             MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
>
> @@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
>              return -1;
>          }
>
> -        vs->zlib->level =3D vs->tight->compression;
> +        worker->zlib.level =3D worker->tight.compression;
>          zstream->opaque =3D vs;
>      }
>
> -    if (vs->tight->compression !=3D vs->zlib->level) {
> -        if (deflateParams(zstream, vs->tight->compression,
> +    if (worker->tight.compression !=3D worker->zlib.level) {
> +        if (deflateParams(zstream, worker->tight.compression,
>                            Z_DEFAULT_STRATEGY) !=3D Z_OK) {
>              return -1;
>          }
> -        vs->zlib->level =3D vs->tight->compression;
> +        worker->zlib.level =3D worker->tight.compression;
>      }
>
>      // reserve memory in output buffer
> -    buffer_reserve(&vs->output, vs->zlib->zlib.offset + 64);
> +    buffer_reserve(&vs->output, worker->zlib.zlib.offset + 64);
>
>      // set pointers
> -    zstream->next_in =3D vs->zlib->zlib.buffer;
> -    zstream->avail_in =3D vs->zlib->zlib.offset;
> +    zstream->next_in =3D worker->zlib.zlib.buffer;
> +    zstream->avail_in =3D worker->zlib.zlib.offset;
>      zstream->next_out =3D vs->output.buffer + vs->output.offset;
>      zstream->avail_out =3D vs->output.capacity - vs->output.offset;
>      previous_out =3D zstream->avail_out;
> @@ -118,7 +118,8 @@ static int vnc_zlib_stop(VncState *vs)
>      return previous_out - zstream->avail_out;
>  }
>
> -int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h)
> +int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                     int x, int y, int w, int h)
>  {
>      int old_offset, new_offset, bytes_written;
>
> @@ -129,9 +130,9 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, in=
t
> x, int y, int w, int h)
>      vnc_write_s32(vs, 0);
>
>      // compress the stream
> -    vnc_zlib_start(vs);
> +    vnc_zlib_start(vs, worker);
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
> -    bytes_written =3D vnc_zlib_stop(vs);
> +    bytes_written =3D vnc_zlib_stop(vs, worker);
>
>      if (bytes_written =3D=3D -1)
>          return 0;
> @@ -145,10 +146,10 @@ int vnc_zlib_send_framebuffer_update(VncState *vs,
> int x, int y, int w, int h)
>      return 1;
>  }
>
> -void vnc_zlib_clear(VncState *vs)
> +void vnc_zlib_clear(VncWorker *worker)
>  {
> -    if (vs->zlib->stream.opaque) {
> -        deflateEnd(&vs->zlib->stream);
> +    if (worker->zlib.stream.opaque) {
> +        deflateEnd(&worker->zlib.stream);
>      }
> -    buffer_free(&vs->zlib->zlib);
> +    buffer_free(&worker->zlib.zlib);
>  }
> diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
> index
> 97ec6c7119bc6da3af0e46e73a9e36220646d010..7679014c9e3379e21390f5815163854=
f5283700c
> 100644
> --- a/ui/vnc-enc-zrle.c
> +++ b/ui/vnc-enc-zrle.c
> @@ -35,45 +35,45 @@ static const int bits_per_packed_pixel[] =3D {
>  };
>
>
> -static void vnc_zrle_start(VncState *vs)
> +static void vnc_zrle_start(VncState *vs, VncZrle *zrle)
>  {
> -    buffer_reset(&vs->zrle->zrle);
> +    buffer_reset(&zrle->zrle);
>
>      /* make the output buffer be the zlib buffer, so we can compress it
> later */
> -    vs->zrle->tmp =3D vs->output;
> -    vs->output =3D vs->zrle->zrle;
> +    zrle->tmp =3D vs->output;
> +    vs->output =3D zrle->zrle;
>  }
>
> -static void vnc_zrle_stop(VncState *vs)
> +static void vnc_zrle_stop(VncState *vs, VncZrle *zrle)
>  {
>      /* switch back to normal output/zlib buffers */
> -    vs->zrle->zrle =3D vs->output;
> -    vs->output =3D vs->zrle->tmp;
> +    zrle->zrle =3D vs->output;
> +    vs->output =3D zrle->tmp;
>  }
>
> -static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,
> -                             int bpp)
> +static void *zrle_convert_fb(VncState *vs, VncZrle *zrle,
> +                             int x, int y, int w, int h, int bpp)
>  {
>      Buffer tmp;
>
> -    buffer_reset(&vs->zrle->fb);
> -    buffer_reserve(&vs->zrle->fb, w * h * bpp + bpp);
> +    buffer_reset(&zrle->fb);
> +    buffer_reserve(&zrle->fb, w * h * bpp + bpp);
>
>      tmp =3D vs->output;
> -    vs->output =3D vs->zrle->fb;
> +    vs->output =3D zrle->fb;
>
>      vnc_raw_send_framebuffer_update(vs, x, y, w, h);
>
> -    vs->zrle->fb =3D vs->output;
> +    zrle->fb =3D vs->output;
>      vs->output =3D tmp;
> -    return vs->zrle->fb.buffer;
> +    return zrle->fb.buffer;
>  }
>
> -static int zrle_compress_data(VncState *vs, int level)
> +static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)
>  {
> -    z_streamp zstream =3D &vs->zrle->stream;
> +    z_streamp zstream =3D &zrle->stream;
>
> -    buffer_reset(&vs->zrle->zlib);
> +    buffer_reset(&zrle->zlib);
>
>      if (zstream->opaque !=3D vs) {
>          int err;
> @@ -93,13 +93,13 @@ static int zrle_compress_data(VncState *vs, int level=
)
>      }
>
>      /* reserve memory in output buffer */
> -    buffer_reserve(&vs->zrle->zlib, vs->zrle->zrle.offset + 64);
> +    buffer_reserve(&zrle->zlib, zrle->zrle.offset + 64);
>
>      /* set pointers */
> -    zstream->next_in =3D vs->zrle->zrle.buffer;
> -    zstream->avail_in =3D vs->zrle->zrle.offset;
> -    zstream->next_out =3D vs->zrle->zlib.buffer;
> -    zstream->avail_out =3D vs->zrle->zlib.capacity;
> +    zstream->next_in =3D zrle->zrle.buffer;
> +    zstream->avail_in =3D zrle->zrle.offset;
> +    zstream->next_out =3D zrle->zlib.buffer;
> +    zstream->avail_out =3D zrle->zlib.capacity;
>      zstream->data_type =3D Z_BINARY;
>
>      /* start encoding */
> @@ -108,8 +108,8 @@ static int zrle_compress_data(VncState *vs, int level=
)
>          return -1;
>      }
>
> -    vs->zrle->zlib.offset =3D vs->zrle->zlib.capacity - zstream->avail_o=
ut;
> -    return vs->zrle->zlib.offset;
> +    zrle->zlib.offset =3D zrle->zlib.capacity - zstream->avail_out;
> +    return zrle->zlib.offset;
>  }
>
>  /* Try to work out whether to use RLE and/or a palette.  We do this by
> @@ -252,21 +252,21 @@ static void zrle_write_u8(VncState *vs, uint8_t
> value)
>  #undef ZRLE_COMPACT_PIXEL
>  #undef ZRLE_BPP
>
> -static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
> -                                        int w, int h)
> +static int zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                        int x, int y, int w, int h)
>  {
>      bool be =3D vs->client_endian =3D=3D G_BIG_ENDIAN;
>      size_t bytes;
>      int zywrle_level;
>
> -    if (vs->zrle->type =3D=3D VNC_ENCODING_ZYWRLE) {
> -        if (!vs->vd->lossy || vs->tight->quality =3D=3D (uint8_t)-1
> -            || vs->tight->quality =3D=3D 9) {
> +    if (worker->zrle.type =3D=3D VNC_ENCODING_ZYWRLE) {
> +        if (!vs->vd->lossy || worker->tight.quality =3D=3D (uint8_t)-1
> +            || worker->tight.quality =3D=3D 9) {
>              zywrle_level =3D 0;
> -            vs->zrle->type =3D VNC_ENCODING_ZRLE;
> -        } else if (vs->tight->quality < 3) {
> +            worker->zrle.type =3D VNC_ENCODING_ZRLE;
> +        } else if (worker->tight.quality < 3) {
>              zywrle_level =3D 3;
> -        } else if (vs->tight->quality < 6) {
> +        } else if (worker->tight.quality < 6) {
>              zywrle_level =3D 2;
>          } else {
>              zywrle_level =3D 1;
> @@ -275,25 +275,25 @@ static int zrle_send_framebuffer_update(VncState
> *vs, int x, int y,
>          zywrle_level =3D 0;
>      }
>
> -    vnc_zrle_start(vs);
> +    vnc_zrle_start(vs, &worker->zrle);
>
>      switch (vs->client_pf.bytes_per_pixel) {
>      case 1:
> -        zrle_encode_8ne(vs, x, y, w, h, zywrle_level);
> +        zrle_encode_8ne(vs, &worker->zrle, x, y, w, h, zywrle_level);
>          break;
>
>      case 2:
>          if (vs->client_pf.gmax > 0x1F) {
>              if (be) {
> -                zrle_encode_16be(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_16be(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              } else {
> -                zrle_encode_16le(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_16le(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              }
>          } else {
>              if (be) {
> -                zrle_encode_15be(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_15be(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              } else {
> -                zrle_encode_15le(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_15le(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              }
>          }
>          break;
> @@ -314,53 +314,55 @@ static int zrle_send_framebuffer_update(VncState
> *vs, int x, int y,
>
>          if ((fits_in_ls3bytes && !be) || (fits_in_ms3bytes && be)) {
>              if (be) {
> -                zrle_encode_24abe(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_24abe(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              } else {
> -                zrle_encode_24ale(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_24ale(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>            }
>          } else if ((fits_in_ls3bytes && be) || (fits_in_ms3bytes && !be)=
)
> {
>              if (be) {
> -                zrle_encode_24bbe(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_24bbe(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              } else {
> -                zrle_encode_24ble(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_24ble(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              }
>          } else {
>              if (be) {
> -                zrle_encode_32be(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_32be(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              } else {
> -                zrle_encode_32le(vs, x, y, w, h, zywrle_level);
> +                zrle_encode_32le(vs, &worker->zrle, x, y, w, h,
> zywrle_level);
>              }
>          }
>      }
>      break;
>      }
>
> -    vnc_zrle_stop(vs);
> -    bytes =3D zrle_compress_data(vs, Z_DEFAULT_COMPRESSION);
> -    vnc_framebuffer_update(vs, x, y, w, h, vs->zrle->type);
> +    vnc_zrle_stop(vs, &worker->zrle);
> +    bytes =3D zrle_compress_data(vs, &worker->zrle, Z_DEFAULT_COMPRESSIO=
N);
> +    vnc_framebuffer_update(vs, x, y, w, h, worker->zrle.type);
>      vnc_write_u32(vs, bytes);
> -    vnc_write(vs, vs->zrle->zlib.buffer, vs->zrle->zlib.offset);
> +    vnc_write(vs, worker->zrle.zlib.buffer, worker->zrle.zlib.offset);
>      return 1;
>  }
>
> -int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w,
> int h)
> +int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                     int x, int y, int w, int h)
>  {
> -    vs->zrle->type =3D VNC_ENCODING_ZRLE;
> -    return zrle_send_framebuffer_update(vs, x, y, w, h);
> +    worker->zrle.type =3D VNC_ENCODING_ZRLE;
> +    return zrle_send_framebuffer_update(vs, worker, x, y, w, h);
>  }
>
> -int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w=
,
> int h)
> +int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                       int x, int y, int w, int h)
>  {
> -    vs->zrle->type =3D VNC_ENCODING_ZYWRLE;
> -    return zrle_send_framebuffer_update(vs, x, y, w, h);
> +    worker->zrle.type =3D VNC_ENCODING_ZYWRLE;
> +    return zrle_send_framebuffer_update(vs, worker, x, y, w, h);
>  }
>
> -void vnc_zrle_clear(VncState *vs)
> +void vnc_zrle_clear(VncWorker *worker)
>  {
> -    if (vs->zrle->stream.opaque) {
> -        deflateEnd(&vs->zrle->stream);
> +    if (worker->zrle.stream.opaque) {
> +        deflateEnd(&worker->zrle.stream);
>      }
> -    buffer_free(&vs->zrle->zrle);
> -    buffer_free(&vs->zrle->fb);
> -    buffer_free(&vs->zrle->zlib);
> +    buffer_free(&worker->zrle.zrle);
> +    buffer_free(&worker->zrle.fb);
> +    buffer_free(&worker->zrle.zlib);
>  }
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index
> d3486af9e2138aaf5e0bb24ed3e7c97940582820..bed33950a8791e7915f3396933b0ed1=
d474b1575
> 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -185,14 +185,10 @@ static void vnc_async_encoding_start(VncState *orig=
,
> VncState *local)
>      local->vnc_encoding =3D orig->vnc_encoding;
>      local->features =3D orig->features;
>      local->vd =3D orig->vd;
> -    local->lossy_rect =3D orig->lossy_rect;
>      local->write_pixels =3D orig->write_pixels;
>      local->client_pf =3D orig->client_pf;
>      local->client_endian =3D orig->client_endian;
> -    local->tight =3D orig->tight;
> -    local->zlib =3D orig->zlib;
>      local->hextile =3D orig->hextile;
> -    local->zrle =3D orig->zrle;
>      local->client_width =3D orig->client_width;
>      local->client_height =3D orig->client_height;
>  }
> @@ -200,11 +196,7 @@ static void vnc_async_encoding_start(VncState *orig,
> VncState *local)
>  static void vnc_async_encoding_end(VncState *orig, VncState *local)
>  {
>      buffer_free(&local->output);
> -    orig->tight =3D local->tight;
> -    orig->zlib =3D local->zlib;
>      orig->hextile =3D local->hextile;
> -    orig->zrle =3D local->zrle;
> -    orig->lossy_rect =3D local->lossy_rect;
>  }
>
>  static bool vnc_worker_clamp_rect(VncState *vs, VncJob *job, VncRect
> *rect)
> @@ -237,6 +229,7 @@ static bool vnc_worker_clamp_rect(VncState *vs, VncJo=
b
> *job, VncRect *rect)
>
>  static int vnc_worker_thread_loop(VncJobQueue *queue)
>  {
> +    VncConnection *vc;
>      VncJob *job;
>      VncRectEntry *entry, *tmp;
>      VncState vs =3D {};
> @@ -256,6 +249,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>      }
>
>      assert(job->vs->magic =3D=3D VNC_MAGIC);
> +    vc =3D container_of(job->vs, VncConnection, vs);
>
>      vnc_lock_output(job->vs);
>      if (job->vs->ioc =3D=3D NULL || job->vs->abort =3D=3D true) {
> @@ -295,7 +289,8 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>          }
>
>          if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
> -            n =3D vnc_send_framebuffer_update(&vs, entry->rect.x,
> entry->rect.y,
> +            n =3D vnc_send_framebuffer_update(&vs, &vc->worker,
> +                                            entry->rect.x, entry->rect.y=
,
>                                              entry->rect.w, entry->rect.h=
);
>
>              if (n >=3D 0) {
> diff --git a/ui/vnc.c b/ui/vnc.c
> index
> 59009ff61b350487153960d0236eb438f93e665b..0556b154a840f5a2e7ecc8dba35415e=
aed077966
> 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -56,11 +56,6 @@
>  #include "io/dns-resolver.h"
>  #include "monitor/monitor.h"
>
> -typedef struct VncConnection {
> -    VncState vs;
> -    VncZlib zlib;
> -} VncConnection;
> -
>  #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
>  #define VNC_REFRESH_INTERVAL_INC  50
>  #define VNC_REFRESH_INTERVAL_MAX  GUI_REFRESH_INTERVAL_IDLE
> @@ -951,29 +946,30 @@ int vnc_raw_send_framebuffer_update(VncState *vs,
> int x, int y, int w, int h)
>      return 1;
>  }
>
> -int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h=
)
> +int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,
> +                                int x, int y, int w, int h)
>  {
>      int n =3D 0;
>
>      switch(vs->vnc_encoding) {
>          case VNC_ENCODING_ZLIB:
> -            n =3D vnc_zlib_send_framebuffer_update(vs, x, y, w, h);
> +            n =3D vnc_zlib_send_framebuffer_update(vs, worker, x, y, w, =
h);
>              break;
>          case VNC_ENCODING_HEXTILE:
>              vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_HEXTILE)=
;
>              n =3D vnc_hextile_send_framebuffer_update(vs, x, y, w, h);
>              break;
>          case VNC_ENCODING_TIGHT:
> -            n =3D vnc_tight_send_framebuffer_update(vs, x, y, w, h);
> +            n =3D vnc_tight_send_framebuffer_update(vs, worker, x, y, w,=
 h);
>              break;
>          case VNC_ENCODING_TIGHT_PNG:
> -            n =3D vnc_tight_png_send_framebuffer_update(vs, x, y, w, h);
> +            n =3D vnc_tight_png_send_framebuffer_update(vs, worker, x, y=
,
> w, h);
>              break;
>          case VNC_ENCODING_ZRLE:
> -            n =3D vnc_zrle_send_framebuffer_update(vs, x, y, w, h);
> +            n =3D vnc_zrle_send_framebuffer_update(vs, worker, x, y, w, =
h);
>              break;
>          case VNC_ENCODING_ZYWRLE:
> -            n =3D vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
> +            n =3D vnc_zywrle_send_framebuffer_update(vs, worker, x, y, w=
,
> h);
>              break;
>          default:
>              vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
> @@ -1311,7 +1307,7 @@ static void vnc_disconnect_start(VncState *vs)
>
>  void vnc_disconnect_finish(VncState *vs)
>  {
> -    int i;
> +    VncConnection *vc =3D container_of(vs, VncConnection, vs);
>
>      trace_vnc_client_disconnect_finish(vs, vs->ioc);
>
> @@ -1325,9 +1321,9 @@ void vnc_disconnect_finish(VncState *vs)
>
>      qapi_free_VncClientInfo(vs->info);
>
> -    vnc_zlib_clear(vs);
> -    vnc_tight_clear(vs);
> -    vnc_zrle_clear(vs);
> +    vnc_zlib_clear(&vc->worker);
> +    vnc_tight_clear(&vc->worker);
> +    vnc_zrle_clear(&vc->worker);
>
>  #ifdef CONFIG_VNC_SASL
>      vnc_sasl_client_cleanup(vs);
> @@ -1355,19 +1351,12 @@ void vnc_disconnect_finish(VncState *vs)
>      }
>      buffer_free(&vs->jobs_buffer);
>
> -    for (i =3D 0; i < VNC_STAT_ROWS; ++i) {
> -        g_free(vs->lossy_rect[i]);
> -    }
> -    g_free(vs->lossy_rect);
> -
>      object_unref(OBJECT(vs->ioc));
>      vs->ioc =3D NULL;
>      object_unref(OBJECT(vs->sioc));
>      vs->sioc =3D NULL;
>      vs->magic =3D 0;
> -    g_free(vs->zrle);
> -    g_free(vs->tight);
> -    g_free(container_of(vs, VncConnection, vs));
> +    g_free(vc);
>  }
>
>  size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
> @@ -2131,13 +2120,14 @@ static void send_xvp_message(VncState *vs, int
> code)
>
>  static void set_encodings(VncState *vs, int32_t *encodings, size_t
> n_encodings)
>  {
> +    VncConnection *vc =3D container_of(vs, VncConnection, vs);
>      int i;
>      unsigned int enc =3D 0;
>
>      vs->features =3D 0;
>      vs->vnc_encoding =3D 0;
> -    vs->tight->compression =3D 9;
> -    vs->tight->quality =3D -1; /* Lossless by default */
> +    vc->worker.tight.compression =3D 9;
> +    vc->worker.tight.quality =3D -1; /* Lossless by default */
>      vs->absolute =3D -1;
>
>      /*
> @@ -2225,11 +2215,11 @@ static void set_encodings(VncState *vs, int32_t
> *encodings, size_t n_encodings)
>              vnc_server_cut_text_caps(vs);
>              break;
>          case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0
> + 9:
> -            vs->tight->compression =3D (enc & 0x0F);
> +            vc->worker.tight.compression =3D (enc & 0x0F);
>              break;
>          case VNC_ENCODING_QUALITYLEVEL0 ... VNC_ENCODING_QUALITYLEVEL0 +
> 9:
>              if (vs->vd->lossy) {
> -                vs->tight->quality =3D (enc & 0x0F);
> +                vc->worker.tight.quality =3D (enc & 0x0F);
>              }
>              break;
>          default:
> @@ -2958,7 +2948,7 @@ static VncRectStat *vnc_stat_rect(VncDisplay *vd,
> int x, int y)
>      return &vs->stats[y / VNC_STAT_RECT][x / VNC_STAT_RECT];
>  }
>
> -void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
> +void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
>  {
>      int i, j;
>
> @@ -2969,7 +2959,7 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y=
,
> int w, int h)
>
>      for (j =3D y; j <=3D h; j++) {
>          for (i =3D x; i <=3D w; i++) {
> -            vs->lossy_rect[j][i] =3D 1;
> +            worker->lossy_rect[j][i] =3D 1;
>          }
>      }
>  }
> @@ -2985,6 +2975,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd,
> int x, int y)
>      x =3D QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
>
>      QTAILQ_FOREACH(vs, &vd->clients, next) {
> +        VncConnection *vc =3D container_of(vs, VncConnection, vs);
>          int j;
>
>          /* kernel send buffers are full -> refresh later */
> @@ -2992,11 +2983,11 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd,
> int x, int y)
>              continue;
>          }
>
> -        if (!vs->lossy_rect[sty][stx]) {
> +        if (!vc->worker.lossy_rect[sty][stx]) {
>              continue;
>          }
>
> -        vs->lossy_rect[sty][stx] =3D 0;
> +        vc->worker.lossy_rect[sty][stx] =3D 0;
>          for (j =3D 0; j < VNC_STAT_RECT; ++j) {
>              bitmap_set(vs->dirty[y + j],
>                         x / VNC_DIRTY_PIXELS_PER_BIT,
> @@ -3249,12 +3240,8 @@ static void vnc_connect(VncDisplay *vd,
> QIOChannelSocket *sioc,
>      VncConnection *vc =3D g_new0(VncConnection, 1);
>      VncState *vs =3D &vc->vs;
>      bool first_client =3D QTAILQ_EMPTY(&vd->clients);
> -    int i;
>
>      trace_vnc_client_connect(vs, sioc);
> -    vs->zlib =3D &vc->zlib;
> -    vs->zrle =3D g_new0(VncZrle, 1);
> -    vs->tight =3D g_new0(VncTight, 1);
>      vs->magic =3D VNC_MAGIC;
>      vs->sioc =3D sioc;
>      object_ref(OBJECT(vs->sioc));
> @@ -3262,23 +3249,23 @@ static void vnc_connect(VncDisplay *vd,
> QIOChannelSocket *sioc,
>      object_ref(OBJECT(vs->ioc));
>      vs->vd =3D vd;
>
> -    buffer_init(&vs->input,          "vnc-input/%p", sioc);
> -    buffer_init(&vs->output,         "vnc-output/%p", sioc);
> -    buffer_init(&vs->jobs_buffer,    "vnc-jobs_buffer/%p", sioc);
> +    buffer_init(&vs->input,                 "vnc-input/%p", sioc);
> +    buffer_init(&vs->output,                "vnc-output/%p", sioc);
> +    buffer_init(&vs->jobs_buffer,           "vnc-jobs_buffer/%p", sioc);
>
> -    buffer_init(&vs->tight->tight,    "vnc-tight/%p", sioc);
> -    buffer_init(&vs->tight->zlib,     "vnc-tight-zlib/%p", sioc);
> -    buffer_init(&vs->tight->gradient, "vnc-tight-gradient/%p", sioc);
> +    buffer_init(&vc->worker.tight.tight,    "vnc-tight/%p", sioc);
> +    buffer_init(&vc->worker.tight.zlib,     "vnc-tight-zlib/%p", sioc);
> +    buffer_init(&vc->worker.tight.gradient, "vnc-tight-gradient/%p",
> sioc);
>  #ifdef CONFIG_VNC_JPEG
> -    buffer_init(&vs->tight->jpeg,     "vnc-tight-jpeg/%p", sioc);
> +    buffer_init(&vc->worker.tight.jpeg,     "vnc-tight-jpeg/%p", sioc);
>  #endif
>  #ifdef CONFIG_PNG
> -    buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
> +    buffer_init(&vc->worker.tight.png,      "vnc-tight-png/%p", sioc);
>  #endif
> -    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
> -    buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
> -    buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
> -    buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
> +    buffer_init(&vc->worker.zlib.zlib,      "vnc-zlib/%p", sioc);
> +    buffer_init(&vc->worker.zrle.zrle,      "vnc-zrle/%p", sioc);
> +    buffer_init(&vc->worker.zrle.fb,        "vnc-zrle-fb/%p", sioc);
> +    buffer_init(&vc->worker.zrle.zlib,      "vnc-zrle-zlib/%p", sioc);
>
>      if (skipauth) {
>          vs->auth =3D VNC_AUTH_NONE;
> @@ -3295,11 +3282,6 @@ static void vnc_connect(VncDisplay *vd,
> QIOChannelSocket *sioc,
>      VNC_DEBUG("Client sioc=3D%p ws=3D%d auth=3D%d subauth=3D%d\n",
>                sioc, websocket, vs->auth, vs->subauth);
>
> -    vs->lossy_rect =3D g_malloc0(VNC_STAT_ROWS * sizeof (*vs->lossy_rect=
));
> -    for (i =3D 0; i < VNC_STAT_ROWS; ++i) {
> -        vs->lossy_rect[i] =3D g_new0(uint8_t, VNC_STAT_COLS);
> -    }
>
-
>      VNC_DEBUG("New client on socket %p\n", vs->sioc);
>      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
>      qio_channel_set_blocking(vs->ioc, false, NULL);
> diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
> index
> 2ef7501d52165f80fd6af8aab8e7d7097b283399..68d28f58b7ef3a96a149a740b3f90b6=
41ec80f40
> 100644
> --- a/ui/vnc-enc-zrle.c.inc
> +++ b/ui/vnc-enc-zrle.c.inc
> @@ -62,16 +62,16 @@
>  #define ZRLE_ENCODE_TILE     ZRLE_CONCAT2(zrle_encode_tile,
> ZRLE_ENCODE_SUFFIX)
>  #define ZRLE_WRITE_PALETTE
>  ZRLE_CONCAT2(zrle_write_palette,ZRLE_ENCODE_SUFFIX)
>
> -static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int =
h,
> -                             int zywrle_level);
> +static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL
> *data,
> +                             int w, int h, int zywrle_level);
>
>  #if ZRLE_BPP !=3D 8
>  #include "vnc-enc-zywrle-template.c"
>  #endif
>
>
> -static void ZRLE_ENCODE(VncState *vs, int x, int y, int w, int h,
> -                        int zywrle_level)
> +static void ZRLE_ENCODE(VncState *vs, VncZrle *zrle,
> +                        int x, int y, int w, int h, int zywrle_level)
>  {
>      int ty;
>
> @@ -87,16 +87,16 @@ static void ZRLE_ENCODE(VncState *vs, int x, int y,
> int w, int h,
>
>              tw =3D MIN(VNC_ZRLE_TILE_WIDTH, x + w - tx);
>
> -            buf =3D zrle_convert_fb(vs, tx, ty, tw, th, ZRLE_BPP);
> -            ZRLE_ENCODE_TILE(vs, buf, tw, th, zywrle_level);
> +            buf =3D zrle_convert_fb(vs, zrle, tx, ty, tw, th, ZRLE_BPP);
> +            ZRLE_ENCODE_TILE(vs, zrle, buf, tw, th, zywrle_level);
>          }
>      }
>  }
>
> -static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int =
h,
> -                             int zywrle_level)
> +static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL
> *data,
> +                             int w, int h, int zywrle_level)
>  {
> -    VncPalette *palette =3D &vs->zrle->palette;
> +    VncPalette *palette =3D &zrle->palette;
>
>      int runs =3D 0;
>      int single_pixels =3D 0;
> @@ -236,7 +236,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL
> *data, int w, int h,
>  #if ZRLE_BPP !=3D 8
>          if (zywrle_level > 0 && !(zywrle_level & 0x80)) {
>              ZYWRLE_ANALYZE(data, data, w, h, w, zywrle_level,
> vs->zywrle.buf);
> -            ZRLE_ENCODE_TILE(vs, data, w, h, zywrle_level | 0x80);
> +            ZRLE_ENCODE_TILE(vs, zrle, data, w, h, zywrle_level | 0x80);
>          }
>          else
>  #endif
>
> --
> 2.49.0
>
>

--0000000000007c24e40636bdc077
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 3, 20=
25 at 1:19=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-=
tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">The worker thread copies data in V=
ncState to avoid race, but some<br>
data are too big to copy. Such data are held with pointers to avoid<br>
the overhead to copy, but it requires tedious memory management and<br>
makes them vulnerable to race.<br>
<br>
Introduce the VncWorker type to contain all data shared without copying.<br=
>
It allows allocating and freeing all shared data at once and shows that<br>
the race with the worker thread needs to be taken care of when<br>
accessing them.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.a=
c.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br></blockquot=
e><div><br></div><div>Big patch, but splitting it may not be easy.</div><di=
v>I am still left wondering about the remaining shared data and overall des=
ign choices</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &l=
t;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.co=
m</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
---<br>
=C2=A0ui/vnc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 49 +=
+++--<br>
=C2=A0ui/vnc-enc-tight.c=C2=A0 =C2=A0 | 456 ++++++++++++++++++++++++++-----=
-------------------<br>
=C2=A0ui/vnc-enc-zlib.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 47 +++---<br>
=C2=A0ui/vnc-enc-zrle.c=C2=A0 =C2=A0 =C2=A0| 122 +++++++-------<br>
=C2=A0ui/vnc-jobs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 86 +=
+++------<br>
=C2=A0ui/vnc-enc-zrle.c.inc |=C2=A0 20 +--<br>
=C2=A07 files changed, 405 insertions(+), 388 deletions(-)<br>
<br>
diff --git a/ui/vnc.h b/ui/vnc.h<br>
index 82b883bb69fa5ce331945dcffe25588d5fd73f50..8b0afdd17aba06058bbac237eac=
2b4eeb4efea06 100644<br>
--- a/ui/vnc.h<br>
+++ b/ui/vnc.h<br>
@@ -270,8 +270,6 @@ struct VncState<br>
=C2=A0 =C2=A0 =C2=A0gboolean disconnecting;<br>
<br>
=C2=A0 =C2=A0 =C2=A0DECLARE_BITMAP(dirty[VNC_MAX_HEIGHT], VNC_DIRTY_BITS);<=
br>
-=C2=A0 =C2=A0 uint8_t **lossy_rect; /* Not an Array to avoid costly memcpy=
 in<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* vnc-jobs-async.c */<br>
<br>
=C2=A0 =C2=A0 =C2=A0VncDisplay *vd;<br>
=C2=A0 =C2=A0 =C2=A0VncStateUpdate update; /* Most recent pending request f=
rom client */<br>
@@ -339,10 +337,7 @@ struct VncState<br>
=C2=A0 =C2=A0 =C2=A0/* Encoding specific, if you add something here, don&#3=
9;t forget to<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 update vnc_async_encoding_start()<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 VncTight *tight;<br>
-=C2=A0 =C2=A0 VncZlib *zlib;<br>
=C2=A0 =C2=A0 =C2=A0VncHextile hextile;<br>
-=C2=A0 =C2=A0 VncZrle *zrle;<br>
=C2=A0 =C2=A0 =C2=A0VncZywrle zywrle;<br>
<br>
=C2=A0 =C2=A0 =C2=A0Notifier mouse_mode_notifier;<br>
@@ -354,6 +349,19 @@ struct VncState<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_ENTRY(VncState) next;<br>
=C2=A0};<br>
<br>
+typedef struct VncWorker {<br>
+=C2=A0 =C2=A0 uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];<br>
+<br>
+=C2=A0 =C2=A0 VncTight tight;<br>
+=C2=A0 =C2=A0 VncZlib zlib;<br>
+=C2=A0 =C2=A0 VncZrle zrle;<br>
+} VncWorker;<br>
+<br>
+typedef struct VncConnection {<br>
+=C2=A0 =C2=A0 VncState vs;<br>
+=C2=A0 =C2=A0 VncWorker worker;<br>
+} VncConnection;<br>
+<br>
<br>
=C2=A0/********************************************************************=
*********<br>
=C2=A0 *<br>
@@ -600,10 +608,11 @@ int vnc_server_fb_stride(VncDisplay *vd);<br>
<br>
=C2=A0void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v);<br>
=C2=A0double vnc_update_freq(VncState *vs, int x, int y, int w, int h);<br>
-void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h);<br>
+void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h);<b=
r>
<br>
=C2=A0/* Encodings */<br>
-int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);=
<br>
+int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h);<br>
<br>
=C2=A0int vnc_raw_send_framebuffer_update(VncState *vs, int x, int y, int w=
, int h);<br>
<br>
@@ -613,17 +622,21 @@ void vnc_hextile_set_pixel_conversion(VncState *vs, i=
nt generic);<br>
<br>
=C2=A0void *vnc_zlib_zalloc(void *x, unsigned items, unsigned size);<br>
=C2=A0void vnc_zlib_zfree(void *x, void *addr);<br>
-int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, in=
t h);<br>
-void vnc_zlib_clear(VncState *vs);<br>
-<br>
-int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y, int w, i=
nt h);<br>
-int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt w, int h);<br>
-void vnc_tight_clear(VncState *vs);<br>
-<br>
-int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, in=
t h);<br>
-int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, =
int h);<br>
-void vnc_zrle_clear(VncState *vs);<br>
+int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, in=
t w, int h);<br>
+void vnc_zlib_clear(VncWorker *worker);<br>
+<br>
+int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, i=
nt w, int h);<br>
+int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worker,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt x, int y, int w, int h);<br>
+void vnc_tight_clear(VncWorker *worker);<br>
+<br>
+int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, in=
t w, int h);<br>
+int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, in=
t y, int w, int h);<br>
+void vnc_zrle_clear(VncWorker *worker);<br>
<br>
=C2=A0/* vnc-clipboard.c */<br>
=C2=A0void vnc_server_cut_text_caps(VncState *vs);<br>
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c<br>
index 25c7b2c7889c04253652f63730329052703a10a1..9dfe6ae5a2435ea3c11ebeea85c=
f51416c7d6841 100644<br>
--- a/ui/vnc-enc-tight.c<br>
+++ b/ui/vnc-enc-tight.c<br>
@@ -72,8 +72,8 @@ static const struct {<br>
=C2=A0};<br>
<br>
<br>
-static int tight_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t w, int h);<br>
+static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t x, int y, int w, int h);<br>
<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
=C2=A0static const struct {<br>
@@ -111,12 +111,12 @@ static const struct {<br>
=C2=A0 =C2=A0 =C2=A0{ 9, PNG_ALL_FILTERS },<br>
=C2=A0};<br>
<br>
-static int send_png_rect(VncState *vs, int x, int y, int w, int h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0VncPalette *palette);<br>
+static int send_png_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int x, int y, int w, int h, VncPalette *palette);<br>
<br>
-static bool tight_can_send_png_rect(VncState *vs, int w, int h)<br>
+static bool tight_can_send_png_rect(VncState *vs, VncTight *tight, int w, =
int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;type !=3D VNC_ENCODING_TIGHT_PNG) {<br>
+=C2=A0 =C2=A0 if (tight-&gt;type !=3D VNC_ENCODING_TIGHT_PNG) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -135,7 +135,7 @@ static bool tight_can_send_png_rect(VncState *vs, int w=
, int h)<br>
=C2=A0 */<br>
<br>
=C2=A0static unsigned int<br>
-tight_detect_smooth_image24(VncState *vs, int w, int h)<br>
+tight_detect_smooth_image24(VncState *vs, VncTight *tight, int w, int h)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int off;<br>
=C2=A0 =C2=A0 =C2=A0int x, y, d, dx;<br>
@@ -144,7 +144,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)=
<br>
=C2=A0 =C2=A0 =C2=A0int pixels =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int pix, left[3];<br>
=C2=A0 =C2=A0 =C2=A0unsigned int errors;<br>
-=C2=A0 =C2=A0 unsigned char *buf =3D vs-&gt;tight-&gt;tight.buffer;<br>
+=C2=A0 =C2=A0 unsigned char *buf =3D tight-&gt;tight.buffer;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If client is big-endian, color samples begin from th=
e second<br>
@@ -205,7 +205,8 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)=
<br>
=C2=A0#define DEFINE_DETECT_FUNCTION(bpp)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0static unsigned int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 tight_detect_smooth_image##bpp(VncState *vs, int w, int h) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 tight_detect_smooth_image##bpp(VncState *vs, VncTight *tight=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, int h) {=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool endian;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##bpp##_t pix;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int max[3], shift[3];=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -215,7 +216,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pixels =3D 0;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int sample, sum, left[3];=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int errors;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char *buf =3D vs-&gt;tight-&gt;tight.=
buffer;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char *buf =3D tight-&gt;tight.buffer;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endian =3D 0; /* FIXME */=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -293,11 +294,11 @@ DEFINE_DETECT_FUNCTION(16)<br>
=C2=A0DEFINE_DETECT_FUNCTION(32)<br>
<br>
=C2=A0static int<br>
-tight_detect_smooth_image(VncState *vs, int w, int h)<br>
+tight_detect_smooth_image(VncState *vs, VncTight *tight, int w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int errors;<br>
-=C2=A0 =C2=A0 int compression =3D vs-&gt;tight-&gt;compression;<br>
-=C2=A0 =C2=A0 int quality =3D vs-&gt;tight-&gt;quality;<br>
+=C2=A0 =C2=A0 int compression =3D tight-&gt;compression;<br>
+=C2=A0 =C2=A0 int quality =3D tight-&gt;quality;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vs-&gt;vd-&gt;lossy) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -309,7 +310,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;quality !=3D (uint8_t)-1) {<br>
+=C2=A0 =C2=A0 if (tight-&gt;quality !=3D (uint8_t)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (w * h &lt; VNC_TIGHT_JPEG_MIN_RECT_SI=
ZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -320,17 +321,17 @@ tight_detect_smooth_image(VncState *vs, int w, int h)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vs-&gt;client_pf.bytes_per_pixel =3D=3D 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_i=
mage24(vs, w, h);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;tight-&gt;quality !=
=3D (uint8_t)-1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_i=
mage24(vs, tight, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tight-&gt;quality !=3D (uint=
8_t)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (error=
s &lt; tight_conf[quality].jpeg_threshold24);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (errors &lt; tight_c=
onf[compression].gradient_threshold24);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_i=
mage32(vs, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_i=
mage32(vs, tight, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_image16(vs, w, =
h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 errors =3D tight_detect_smooth_image16(vs, tig=
ht, w, h);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (quality !=3D (uint8_t)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (errors &lt; tight_conf[quality].j=
peg_threshold);<br>
@@ -344,15 +345,15 @@ tight_detect_smooth_image(VncState *vs, int w, int h)=
<br>
=C2=A0#define DEFINE_FILL_PALETTE_FUNCTION(bpp)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0static int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 tight_fill_palette##bpp(VncState *vs, int x, int y,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int max, size_t count,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 tight_fill_palette##bpp(VncState *vs, VncTight *tight,=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int max, size_t count,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *bg, uint32_t *fg,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VncPalette *palette) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##bpp##_t *data;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##bpp##_t c0, c1, ci;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i, n0, n1;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D (uint##bpp##_t *)vs-&gt;tight-&gt;tig=
ht.buffer;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D (uint##bpp##_t *)tight-&gt;tight.buff=
er;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c0 =3D data[0];=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -417,15 +418,15 @@ DEFINE_FILL_PALETTE_FUNCTION(8)<br>
=C2=A0DEFINE_FILL_PALETTE_FUNCTION(16)<br>
=C2=A0DEFINE_FILL_PALETTE_FUNCTION(32)<br>
<br>
-static int tight_fill_palette(VncState *vs, int x, int y,<br>
+static int tight_fill_palette(VncState *vs, VncTight *tight, int x, int y,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t count, uint32_t *bg, uint32_t =
*fg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VncPalette *palette)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int max;<br>
<br>
-=C2=A0 =C2=A0 max =3D count / tight_conf[vs-&gt;tight-&gt;compression].idx=
_max_colors_divisor;<br>
+=C2=A0 =C2=A0 max =3D count / tight_conf[tight-&gt;compression].idx_max_co=
lors_divisor;<br>
=C2=A0 =C2=A0 =C2=A0if (max &lt; 2 &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 count &gt;=3D tight_conf[vs-&gt;tight-&gt;comp=
ression].mono_min_rect_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 count &gt;=3D tight_conf[tight-&gt;compression=
].mono_min_rect_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (max &gt;=3D 256) {<br>
@@ -434,12 +435,15 @@ static int tight_fill_palette(VncState *vs, int x, in=
t y,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (vs-&gt;client_pf.bytes_per_pixel) {<br>
=C2=A0 =C2=A0 =C2=A0case 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette32(vs, x, y, max, cou=
nt, bg, fg, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette32(vs, tight, x, y, m=
ax, count, bg, fg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 palette);<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette16(vs, x, y, max, cou=
nt, bg, fg, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette16(vs, tight, x, y, m=
ax, count, bg, fg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 palette);<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max =3D 2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette8(vs, x, y, max, coun=
t, bg, fg, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tight_fill_palette8(vs, tight, x, y, ma=
x, count, bg, fg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
@@ -547,7 +551,8 @@ DEFINE_MONO_ENCODE_FUNCTION(32)<br>
=C2=A0 */<br>
<br>
=C2=A0static void<br>
-tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)<br>
+tight_filter_gradient24(VncState *vs, VncTight *tight, uint8_t *buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t *buf32;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t pix32;<br>
@@ -558,7 +563,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int=
 w, int h)<br>
=C2=A0 =C2=A0 =C2=A0int x, y, c;<br>
<br>
=C2=A0 =C2=A0 =C2=A0buf32 =3D (uint32_t *)buf;<br>
-=C2=A0 =C2=A0 memset(vs-&gt;tight-&gt;gradient.buffer, 0, w * 3 * sizeof(i=
nt));<br>
+=C2=A0 =C2=A0 memset(tight-&gt;gradient.buffer, 0, w * 3 * sizeof(int));<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0if (1 /* FIXME */) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shift[0] =3D vs-&gt;client_pf.rshift;<br>
@@ -575,7 +580,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int=
 w, int h)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0upper[c] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0here[c] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D (int *)vs-&gt;tight-&gt;gradient.buff=
er;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D (int *)tight-&gt;gradient.buffer;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0; x &lt; w; x++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pix32 =3D *buf32++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (c =3D 0; c &lt; 3; c++=
) {<br>
@@ -605,8 +610,8 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int=
 w, int h)<br>
=C2=A0#define DEFINE_GRADIENT_FILTER_FUNCTION(bpp)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0static void=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 tight_filter_gradient##bpp(VncState *vs, uint##bpp##_t *buf,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, int h) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 tight_filter_gradient##bpp(VncState *vs, VncTight *tight,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##bpp##_t *buf, int w, int h) {=
=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint##bpp##_t pix, diff;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool endian;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *prev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
@@ -615,7 +620,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int=
 w, int h)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int prediction;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, y, c;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(vs-&gt;tight-&gt;gradient.buffer, 0, w =
* 3 * sizeof(int));=C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(tight-&gt;gradient.buffer, 0, w * 3 * s=
izeof(int));=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0endian =3D 0; /* FIXME */=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -631,7 +636,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int=
 w, int h)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0upper[c] =3D =
0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0here[c] =3D 0=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D (int *)vs-&gt;tight-&gt=
;gradient.buffer;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D (int *)tight-&gt;gradie=
nt.buffer;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0; x &lt; w; x++=
) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pix =3D *buf;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (endian) {=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
@@ -782,10 +787,10 @@ static void extend_solid_area(VncState *vs, int x, in=
t y, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0*w_ptr +=3D cx - (*x_ptr + *w_ptr);<br>
=C2=A0}<br>
<br>
-static int tight_init_stream(VncState *vs, int stream_id,<br>
+static int tight_init_stream(VncState *vs, VncTight *tight, int stream_id,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int level, int strategy)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 z_streamp zstream =3D &amp;vs-&gt;tight-&gt;stream[stream_id=
];<br>
+=C2=A0 =C2=A0 z_streamp zstream =3D &amp;tight-&gt;stream[stream_id];<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (zstream-&gt;opaque =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
@@ -803,15 +808,15 @@ static int tight_init_stream(VncState *vs, int stream=
_id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;levels[stream_id] =3D level;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight-&gt;levels[stream_id] =3D level;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zstream-&gt;opaque =3D vs;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;levels[stream_id] !=3D level) {<br>
+=C2=A0 =C2=A0 if (tight-&gt;levels[stream_id] !=3D level) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (deflateParams(zstream, level, strateg=
y) !=3D Z_OK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;levels[stream_id] =3D level;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight-&gt;levels[stream_id] =3D level;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
@@ -836,29 +841,29 @@ static void tight_send_compact_size(VncState *vs, siz=
e_t len)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int level, int strategy)<br>
+static int tight_compress_data(VncState *vs, VncTight *tight, int stream_i=
d,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bytes, int level, int strategy=
)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 z_streamp zstream =3D &amp;vs-&gt;tight-&gt;stream[stream_id=
];<br>
+=C2=A0 =C2=A0 z_streamp zstream =3D &amp;tight-&gt;stream[stream_id];<br>
=C2=A0 =C2=A0 =C2=A0int previous_out;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (bytes &lt; VNC_TIGHT_MIN_TO_COMPRESS) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vnc_write(vs, vs-&gt;tight-&gt;tight.buffer, v=
s-&gt;tight-&gt;tight.offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vnc_write(vs, tight-&gt;tight.buffer, tight-&g=
t;tight.offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bytes;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (tight_init_stream(vs, stream_id, level, strategy)) {<br>
+=C2=A0 =C2=A0 if (tight_init_stream(vs, tight, stream_id, level, strategy)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* reserve memory in output buffer */<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;tight-&gt;zlib, bytes + 64);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;tight-&gt;zlib, bytes + 64);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set pointers */<br>
-=C2=A0 =C2=A0 zstream-&gt;next_in =3D vs-&gt;tight-&gt;tight.buffer;<br>
-=C2=A0 =C2=A0 zstream-&gt;avail_in =3D vs-&gt;tight-&gt;tight.offset;<br>
-=C2=A0 =C2=A0 zstream-&gt;next_out =3D vs-&gt;tight-&gt;zlib.buffer + vs-&=
gt;tight-&gt;zlib.offset;<br>
-=C2=A0 =C2=A0 zstream-&gt;avail_out =3D vs-&gt;tight-&gt;zlib.capacity - v=
s-&gt;tight-&gt;zlib.offset;<br>
+=C2=A0 =C2=A0 zstream-&gt;next_in =3D tight-&gt;tight.buffer;<br>
+=C2=A0 =C2=A0 zstream-&gt;avail_in =3D tight-&gt;tight.offset;<br>
+=C2=A0 =C2=A0 zstream-&gt;next_out =3D tight-&gt;zlib.buffer + tight-&gt;z=
lib.offset;<br>
+=C2=A0 =C2=A0 zstream-&gt;avail_out =3D tight-&gt;zlib.capacity - tight-&g=
t;zlib.offset;<br>
=C2=A0 =C2=A0 =C2=A0previous_out =3D zstream-&gt;avail_out;<br>
=C2=A0 =C2=A0 =C2=A0zstream-&gt;data_type =3D Z_BINARY;<br>
<br>
@@ -868,14 +873,14 @@ static int tight_compress_data(VncState *vs, int stre=
am_id, size_t bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;zlib.offset =3D vs-&gt;tight-&gt;zlib.capac=
ity - zstream-&gt;avail_out;<br>
+=C2=A0 =C2=A0 tight-&gt;zlib.offset =3D tight-&gt;zlib.capacity - zstream-=
&gt;avail_out;<br>
=C2=A0 =C2=A0 =C2=A0/* ...how much data has actually been produced by defla=
te() */<br>
=C2=A0 =C2=A0 =C2=A0bytes =3D previous_out - zstream-&gt;avail_out;<br>
<br>
=C2=A0 =C2=A0 =C2=A0tight_send_compact_size(vs, bytes);<br>
-=C2=A0 =C2=A0 vnc_write(vs, vs-&gt;tight-&gt;zlib.buffer, bytes);<br>
+=C2=A0 =C2=A0 vnc_write(vs, tight-&gt;zlib.buffer, bytes);<br>
<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;tight-&gt;zlib);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;tight-&gt;zlib);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return bytes;<br>
=C2=A0}<br>
@@ -914,67 +919,69 @@ static void tight_pack24(VncState *vs, uint8_t *buf, =
size_t count, size_t *ret)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static int send_full_color_rect(VncState *vs, int x, int y, int w, int h)<=
br>
+static int send_full_color_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncTight *tight =3D &amp;worker-&gt;tight;<br>
+=C2=A0 =C2=A0 int level =3D tight_conf[tight-&gt;compression].raw_zlib_lev=
el;<br>
=C2=A0 =C2=A0 =C2=A0int stream =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0ssize_t bytes;<br>
<br>
=C2=A0#ifdef CONFIG_PNG<br>
-=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, w, h)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_png_rect(vs, x, y, w, h, NULL);<br=
>
+=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, tight, w, h)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_png_rect(vs, worker, x, y, w, h, N=
ULL);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, stream &lt;&lt; 4); /* no flushing, no=
 filter */<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_pack24(vs, vs-&gt;tight-&gt;tight.buffer=
, w * h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;vs-&gt;tight-&gt;tight.offset);<br>
+=C2=A0 =C2=A0 if (tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_pack24(vs, tight-&gt;tight.buffer, w * h=
, &amp;tight-&gt;tight.offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D 3;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D vs-&gt;client_pf.bytes_per_pixe=
l;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, stream, w * h * bytes,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tight_conf[vs-&gt;tight-&gt;compression].raw_zlib_=
level,<br>
+=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, tight, stream, w * h * byt=
es, level,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Z_DEFAULT_STRATEGY);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (bytes &gt;=3D 0);<br>
=C2=A0}<br>
<br>
-static int send_solid_rect(VncState *vs)<br>
+static int send_solid_rect(VncState *vs, VncWorker *worker)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncTight *tight =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0size_t bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, VNC_TIGHT_FILL &lt;&lt; 4); /* no flus=
hing, no filter */<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_pack24(vs, vs-&gt;tight-&gt;tight.buffer=
, 1, &amp;vs-&gt;tight-&gt;tight.offset);<br>
+=C2=A0 =C2=A0 if (tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_pack24(vs, tight-&gt;tight.buffer, 1, &a=
mp;tight-&gt;tight.offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D 3;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D vs-&gt;client_pf.bytes_per_pixe=
l;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vnc_write(vs, vs-&gt;tight-&gt;tight.buffer, bytes);<br>
+=C2=A0 =C2=A0 vnc_write(vs, tight-&gt;tight.buffer, bytes);<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-static int send_mono_rect(VncState *vs, int x, int y,<br>
+static int send_mono_rect(VncState *vs, VncWorker *worker, int x, int y,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int w, int h, uint32_t bg, uint32_t fg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ssize_t bytes;<br>
=C2=A0 =C2=A0 =C2=A0int stream =3D 1;<br>
-=C2=A0 =C2=A0 int level =3D tight_conf[vs-&gt;tight-&gt;compression].mono_=
zlib_level;<br>
+=C2=A0 =C2=A0 int level =3D tight_conf[worker-&gt;tight.compression].mono_=
zlib_level;<br>
<br>
=C2=A0#ifdef CONFIG_PNG<br>
-=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, w, h)) {<br>
+=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, &amp;worker-&gt;tight, w, h)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int bpp =3D vs-&gt;client_pf.bytes_per_pi=
xel * 8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VncPalette *palette =3D palette_new(2, bp=
p);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_put(palette, bg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_put(palette, fg);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_png_rect(vs, x, y, w, h, palette)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_png_rect(vs, worker, x, y, w, h, =
palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_destroy(palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -992,12 +999,12 @@ static int send_mono_rect(VncState *vs, int x, int y,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t buf[2] =3D {bg, fg};<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t ret =3D sizeof (buf);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (worker-&gt;tight.pixel24) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tight_pack24(vs, (unsigned =
char*)buf, 2, &amp;ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write(vs, buf, ret);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect32(vs-&gt;tight-&gt;tigh=
t.buffer, w, h, bg, fg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect32(worker-&gt;tight.tigh=
t.buffer, w, h, bg, fg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
@@ -1006,7 +1013,7 @@ static int send_mono_rect(VncState *vs, int x, int y,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t fg16 =3D fg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write(vs, &amp;bg16, 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write(vs, &amp;fg16, 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect16(vs-&gt;tight-&gt;tigh=
t.buffer, w, h, bg, fg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect16(worker-&gt;tight.tigh=
t.buffer, w, h, bg, fg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -1015,18 +1022,20 @@ static int send_mono_rect(VncState *vs, int x, int =
y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t fg8 =3D fg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, bg8);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, fg8);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect8(vs-&gt;tight-&gt;tight=
.buffer, w, h, bg, fg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_mono_rect8(worker-&gt;tight.tight=
.buffer, w, h, bg, fg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;tight.offset =3D bytes;<br>
+=C2=A0 =C2=A0 worker-&gt;tight.tight.offset =3D bytes;<br>
<br>
-=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, stream, bytes, level, Z_DE=
FAULT_STRATEGY);<br>
+=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, &amp;worker-&gt;tight, str=
eam, bytes, level,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Z_DEFAULT_STRATEGY);<br>
=C2=A0 =C2=A0 =C2=A0return (bytes &gt;=3D 0);<br>
=C2=A0}<br>
<br>
=C2=A0struct palette_cb_priv {<br>
=C2=A0 =C2=A0 =C2=A0VncState *vs;<br>
+=C2=A0 =C2=A0 VncTight *tight;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *header;<br>
=C2=A0#ifdef CONFIG_PNG<br>
=C2=A0 =C2=A0 =C2=A0png_colorp png_palette;<br>
@@ -1046,53 +1055,58 @@ static void write_palette(int idx, uint32_t color, =
void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)<b=
r>
+static bool send_gradient_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int w, int h)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncTight *tight =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0int stream =3D 3;<br>
-=C2=A0 =C2=A0 int level =3D tight_conf[vs-&gt;tight-&gt;compression].gradi=
ent_zlib_level;<br>
+=C2=A0 =C2=A0 int level =3D tight_conf[tight-&gt;compression].gradient_zli=
b_level;<br>
=C2=A0 =C2=A0 =C2=A0ssize_t bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vs-&gt;client_pf.bytes_per_pixel =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_full_color_rect(vs, x, y, w, h);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_full_color_rect(vs, worker, x, y, =
w, h);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) &=
lt;&lt; 4);<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, VNC_TIGHT_FILTER_GRADIENT);<br>
<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;tight-&gt;gradient, w * 3 * sizeo=
f(int));<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;tight-&gt;gradient, w * 3 * sizeof(int))=
;<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient24(vs, vs-&gt;tight-&gt;t=
ight.buffer, w, h);<br>
+=C2=A0 =C2=A0 if (tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient24(vs, tight, tight-&gt;t=
ight.buffer, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D 3;<br>
=C2=A0 =C2=A0 =C2=A0} else if (vs-&gt;client_pf.bytes_per_pixel =3D=3D 4) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient32(vs, (uint32_t *)vs-&gt=
;tight-&gt;tight.buffer, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient32(vs, tight, (uint32_t *=
)tight-&gt;tight.buffer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D 4;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient16(vs, (uint16_t *)vs-&gt=
;tight-&gt;tight.buffer, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_filter_gradient16(vs, tight, (uint16_t *=
)tight-&gt;tight.buffer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;tight-&gt;gradient);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;tight-&gt;gradient);<br>
<br>
=C2=A0 =C2=A0 =C2=A0bytes =3D w * h * bytes;<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;tight.offset =3D bytes;<br>
+=C2=A0 =C2=A0 tight-&gt;tight.offset =3D bytes;<br>
<br>
-=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, stream, bytes,<br>
+=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, tight, stream, bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0level, Z_FILTERED);<br>
=C2=A0 =C2=A0 =C2=A0return (bytes &gt;=3D 0);<br>
=C2=A0}<br>
<br>
-static int send_palette_rect(VncState *vs, int x, int y,<br>
+static int send_palette_rect(VncState *vs, VncWorker *worker, int x, int y=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w, int h, VncPalette *palette)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncTight *tight =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0int stream =3D 2;<br>
-=C2=A0 =C2=A0 int level =3D tight_conf[vs-&gt;tight-&gt;compression].idx_z=
lib_level;<br>
+=C2=A0 =C2=A0 int level =3D tight_conf[tight-&gt;compression].idx_zlib_lev=
el;<br>
=C2=A0 =C2=A0 =C2=A0int colors;<br>
=C2=A0 =C2=A0 =C2=A0ssize_t bytes;<br>
<br>
=C2=A0#ifdef CONFIG_PNG<br>
-=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, w, h)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_png_rect(vs, x, y, w, h, palette);=
<br>
+=C2=A0 =C2=A0 if (tight_can_send_png_rect(vs, tight, w, h)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_png_rect(vs, worker, x, y, w, h, p=
alette);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
@@ -1107,38 +1121,38 @@ static int send_palette_rect(VncState *vs, int x, i=
nt y,<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t old_offset, offset, palette_sz =3D=
 palette_size(palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree uint32_t *header =3D g_new(uin=
t32_t, palette_sz);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct palette_cb_priv priv =3D { vs, (uint8_t=
 *)header };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct palette_cb_priv priv =3D { vs, tight, (=
uint8_t *)header };<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_offset =3D vs-&gt;output.offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_iter(palette, write_palette, &amp=
;priv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write(vs, header, palette_sz * sizeof=
(uint32_t));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tight-&gt;pixel24) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tight_pack24(vs, vs-&gt;out=
put.buffer + old_offset, colors, &amp;offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;output.offset =3D ol=
d_offset + offset;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect32(vs-&gt;tight-&gt;t=
ight.buffer, w * h, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect32(tight-&gt;tight.bu=
ffer, w * h, palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t palette_sz =3D palette_size(palett=
e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree uint16_t *header =3D g_new(uin=
t16_t, palette_sz);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct palette_cb_priv priv =3D { vs, (uint8_t=
 *)header };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct palette_cb_priv priv =3D { vs, tight, (=
uint8_t *)header };<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_iter(palette, write_palette, &amp=
;priv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_write(vs, header, palette_sz * sizeof=
(uint16_t));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect16(vs-&gt;tight-&gt;t=
ight.buffer, w * h, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect16(tight-&gt;tight.bu=
ffer, w * h, palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1; /* No palette for 8bits colors=
 */<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0bytes =3D w * h;<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;tight.offset =3D bytes;<br>
+=C2=A0 =C2=A0 tight-&gt;tight.offset =3D bytes;<br>
<br>
-=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, stream, bytes,<br>
+=C2=A0 =C2=A0 bytes =3D tight_compress_data(vs, tight, stream, bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0level, Z_DEFAULT_STRATEGY);<br=
>
=C2=A0 =C2=A0 =C2=A0return (bytes &gt;=3D 0);<br>
=C2=A0}<br>
@@ -1154,8 +1168,8 @@ static int send_palette_rect(VncState *vs, int x, int=
 y,<br>
=C2=A0/* This is called once per encoding */<br>
=C2=A0static void jpeg_init_destination(j_compress_ptr cinfo)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VncState *vs =3D cinfo-&gt;client_data;<br>
-=C2=A0 =C2=A0 Buffer *buffer =3D &amp;vs-&gt;tight-&gt;jpeg;<br>
+=C2=A0 =C2=A0 VncTight *tight =3D cinfo-&gt;client_data;<br>
+=C2=A0 =C2=A0 Buffer *buffer =3D &amp;tight-&gt;jpeg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0cinfo-&gt;dest-&gt;next_output_byte =3D (JOCTET *)buffe=
r-&gt;buffer + buffer-&gt;offset;<br>
=C2=A0 =C2=A0 =C2=A0cinfo-&gt;dest-&gt;free_in_buffer =3D (size_t)(buffer-&=
gt;capacity - buffer-&gt;offset);<br>
@@ -1164,8 +1178,8 @@ static void jpeg_init_destination(j_compress_ptr cinf=
o)<br>
=C2=A0/* This is called when we ran out of buffer (shouldn&#39;t happen!) *=
/<br>
=C2=A0static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VncState *vs =3D cinfo-&gt;client_data;<br>
-=C2=A0 =C2=A0 Buffer *buffer =3D &amp;vs-&gt;tight-&gt;jpeg;<br>
+=C2=A0 =C2=A0 VncTight *tight =3D cinfo-&gt;client_data;<br>
+=C2=A0 =C2=A0 Buffer *buffer =3D &amp;tight-&gt;jpeg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0buffer-&gt;offset =3D buffer-&gt;capacity;<br>
=C2=A0 =C2=A0 =C2=A0buffer_reserve(buffer, 2048);<br>
@@ -1176,13 +1190,14 @@ static boolean jpeg_empty_output_buffer(j_compress_=
ptr cinfo)<br>
=C2=A0/* This is called when we are done processing data */<br>
=C2=A0static void jpeg_term_destination(j_compress_ptr cinfo)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VncState *vs =3D cinfo-&gt;client_data;<br>
-=C2=A0 =C2=A0 Buffer *buffer =3D &amp;vs-&gt;tight-&gt;jpeg;<br>
+=C2=A0 =C2=A0 VncTight *tight =3D cinfo-&gt;client_data;<br>
+=C2=A0 =C2=A0 Buffer *buffer =3D &amp;tight-&gt;jpeg;<br>
<br>
=C2=A0 =C2=A0 =C2=A0buffer-&gt;offset =3D buffer-&gt;capacity - cinfo-&gt;d=
est-&gt;free_in_buffer;<br>
=C2=A0}<br>
<br>
-static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int qu=
ality)<br>
+static int send_jpeg_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int x, int y, int w, int h, int quality)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct jpeg_compress_struct cinfo;<br>
=C2=A0 =C2=A0 =C2=A0struct jpeg_error_mgr jerr;<br>
@@ -1193,15 +1208,15 @@ static int send_jpeg_rect(VncState *vs, int x, int =
y, int w, int h, int quality)<br>
=C2=A0 =C2=A0 =C2=A0int dy;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (surface_bytes_per_pixel(vs-&gt;vd-&gt;ds) =3D=3D 1)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_full_color_rect(vs, x, y, w, h);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_full_color_rect(vs, worker, x, y, =
w, h);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;tight-&gt;jpeg, 2048);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;worker-&gt;tight.jpeg, 2048);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cinfo.err =3D jpeg_std_error(&amp;jerr);<br>
=C2=A0 =C2=A0 =C2=A0jpeg_create_compress(&amp;cinfo);<br>
<br>
-=C2=A0 =C2=A0 cinfo.client_data =3D vs;<br>
+=C2=A0 =C2=A0 cinfo.client_data =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0cinfo.image_width =3D w;<br>
=C2=A0 =C2=A0 =C2=A0cinfo.image_height =3D h;<br>
=C2=A0 =C2=A0 =C2=A0cinfo.input_components =3D 3;<br>
@@ -1231,9 +1246,9 @@ static int send_jpeg_rect(VncState *vs, int x, int y,=
 int w, int h, int quality)<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, VNC_TIGHT_JPEG &lt;&lt; 4);<br>
<br>
-=C2=A0 =C2=A0 tight_send_compact_size(vs, vs-&gt;tight-&gt;jpeg.offset);<b=
r>
-=C2=A0 =C2=A0 vnc_write(vs, vs-&gt;tight-&gt;jpeg.buffer, vs-&gt;tight-&gt=
;jpeg.offset);<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;tight-&gt;jpeg);<br>
+=C2=A0 =C2=A0 tight_send_compact_size(vs, worker-&gt;tight.jpeg.offset);<b=
r>
+=C2=A0 =C2=A0 vnc_write(vs, worker-&gt;tight.jpeg.buffer, worker-&gt;tight=
.jpeg.offset);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;worker-&gt;tight.jpeg);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
@@ -1249,7 +1264,7 @@ static void write_png_palette(int idx, uint32_t pix, =
void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0VncState *vs =3D priv-&gt;vs;<br>
=C2=A0 =C2=A0 =C2=A0png_colorp color =3D &amp;priv-&gt;png_palette[idx];<br=
>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;pixel24)<br>
+=C2=A0 =C2=A0 if (priv-&gt;tight-&gt;pixel24)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color-&gt;red =3D (pix &gt;&gt; vs-&gt;cl=
ient_pf.rshift) &amp; vs-&gt;client_pf.rmax;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color-&gt;green =3D (pix &gt;&gt; vs-&gt;=
client_pf.gshift) &amp; vs-&gt;client_pf.gmax;<br>
@@ -1274,12 +1289,12 @@ static void write_png_palette(int idx, uint32_t pix=
, void *opaque)<br>
=C2=A0static void png_write_data(png_structp png_ptr, png_bytep data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 png_size_t length)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VncState *vs =3D png_get_io_ptr(png_ptr);<br>
+=C2=A0 =C2=A0 VncWorker *worker =3D png_get_io_ptr(png_ptr);<br>
<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;tight-&gt;png, vs-&gt;tight-&gt;p=
ng.offset + length);<br>
-=C2=A0 =C2=A0 memcpy(vs-&gt;tight-&gt;png.buffer + vs-&gt;tight-&gt;png.of=
fset, data, length);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;worker-&gt;tight.png, worker-&gt;tight.p=
ng.offset + length);<br>
+=C2=A0 =C2=A0 memcpy(worker-&gt;tight.png.buffer + worker-&gt;tight.png.of=
fset, data, length);<br>
<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;png.offset +=3D length;<br>
+=C2=A0 =C2=A0 worker-&gt;tight.png.offset +=3D length;<br>
=C2=A0}<br>
<br>
=C2=A0static void png_flush_data(png_structp png_ptr)<br>
@@ -1296,16 +1311,16 @@ static void vnc_png_free(png_structp png_ptr, png_v=
oidp ptr)<br>
=C2=A0 =C2=A0 =C2=A0g_free(ptr);<br>
=C2=A0}<br>
<br>
-static int send_png_rect(VncState *vs, int x, int y, int w, int h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0VncPalette *palette)<br>
+static int send_png_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int x, int y, int w, int h, VncPalette *palette)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0png_byte color_type;<br>
=C2=A0 =C2=A0 =C2=A0png_structp png_ptr;<br>
=C2=A0 =C2=A0 =C2=A0png_infop info_ptr;<br>
=C2=A0 =C2=A0 =C2=A0png_colorp png_palette =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0pixman_image_t *linebuf;<br>
-=C2=A0 =C2=A0 int level =3D tight_png_conf[vs-&gt;tight-&gt;compression].p=
ng_zlib_level;<br>
-=C2=A0 =C2=A0 int filters =3D tight_png_conf[vs-&gt;tight-&gt;compression]=
.png_filters;<br>
+=C2=A0 =C2=A0 int level =3D tight_png_conf[worker-&gt;tight.compression].p=
ng_zlib_level;<br>
+=C2=A0 =C2=A0 int filters =3D tight_png_conf[worker-&gt;tight.compression]=
.png_filters;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *buf;<br>
=C2=A0 =C2=A0 =C2=A0int dy;<br>
<br>
@@ -1322,7 +1337,7 @@ static int send_png_rect(VncState *vs, int x, int y, =
int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 png_set_write_fn(png_ptr, (void *) vs, png_write_data, png_f=
lush_data);<br>
+=C2=A0 =C2=A0 png_set_write_fn(png_ptr, worker, png_write_data, png_flush_=
data);<br>
=C2=A0 =C2=A0 =C2=A0png_set_compression_level(png_ptr, level);<br>
=C2=A0 =C2=A0 =C2=A0png_set_filter(png_ptr, PNG_FILTER_TYPE_DEFAULT, filter=
s);<br>
<br>
@@ -1343,29 +1358,30 @@ static int send_png_rect(VncState *vs, int x, int y=
, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 palette_size(palette));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv.vs =3D vs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 priv.tight =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priv.png_palette =3D png_palette;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0palette_iter(palette, write_png_palette, =
&amp;priv);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0png_set_PLTE(png_ptr, info_ptr, png_palet=
te, palette_size(palette));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vs-&gt;client_pf.bytes_per_pixel =3D=
=3D 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect32(vs-&=
gt;tight-&gt;tight.buffer, w * h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect32(work=
er-&gt;tight.tight.buffer, w * h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pa=
lette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect16(vs-&=
gt;tight-&gt;tight.buffer, w * h,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tight_encode_indexed_rect16(work=
er-&gt;tight.tight.buffer, w * h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pa=
lette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0png_write_info(png_ptr, info_ptr);<br>
<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;tight-&gt;png, 2048);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;worker-&gt;tight.png, 2048);<br>
=C2=A0 =C2=A0 =C2=A0linebuf =3D qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8=
, w);<br>
=C2=A0 =C2=A0 =C2=A0buf =3D (uint8_t *)pixman_image_get_data(linebuf);<br>
=C2=A0 =C2=A0 =C2=A0for (dy =3D 0; dy &lt; h; dy++)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (color_type =3D=3D PNG_COLOR_TYPE_PALE=
TTE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf, vs-&gt;tight-&gt;tig=
ht.buffer + (dy * w), w);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf, worker-&gt;tight.tig=
ht.buffer + (dy * w), w);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_pixman_linebuf_fill(li=
nebuf, vs-&gt;vd-&gt;server, w, x, y + dy);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1383,46 +1399,47 @@ static int send_png_rect(VncState *vs, int x, int y=
, int w, int h,<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u8(vs, VNC_TIGHT_PNG &lt;&lt; 4);<br>
<br>
-=C2=A0 =C2=A0 tight_send_compact_size(vs, vs-&gt;tight-&gt;png.offset);<br=
>
-=C2=A0 =C2=A0 vnc_write(vs, vs-&gt;tight-&gt;png.buffer, vs-&gt;tight-&gt;=
png.offset);<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;tight-&gt;png);<br>
+=C2=A0 =C2=A0 tight_send_compact_size(vs, worker-&gt;tight.png.offset);<br=
>
+=C2=A0 =C2=A0 vnc_write(vs, worker-&gt;tight.png.buffer, worker-&gt;tight.=
png.offset);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;worker-&gt;tight.png);<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_PNG */<br>
<br>
-static void vnc_tight_start(VncState *vs)<br>
+static void vnc_tight_start(VncState *vs, VncTight *tight)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;tight-&gt;tight);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;tight-&gt;tight);<br>
<br>
=C2=A0 =C2=A0 =C2=A0// make the output buffer be the zlib buffer, so we can=
 compress it later<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;tmp =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;tight-&gt;tight;<br>
+=C2=A0 =C2=A0 tight-&gt;tmp =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D tight-&gt;tight;<br>
=C2=A0}<br>
<br>
-static void vnc_tight_stop(VncState *vs)<br>
+static void vnc_tight_stop(VncState *vs, VncTight *tight)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0// switch back to normal output/zlib buffers<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;tight =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;tight-&gt;tmp;<br>
+=C2=A0 =C2=A0 tight-&gt;tight =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D tight-&gt;tmp;<br>
=C2=A0}<br>
<br>
-static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h,<=
br>
+static int send_sub_rect_nojpeg(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int bg, int fg, int colors, Vn=
cPalette *palette)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (colors =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tight_detect_smooth_image(vs, w, h)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_gradient_rect(vs, x=
, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tight_detect_smooth_image(vs, &amp;worker-=
&gt;tight, w, h)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_gradient_rect(vs, w=
orker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_full_color_rect(vs,=
 x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_full_color_rect(vs,=
 worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_solid_rect(vs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_solid_rect(vs, worker);<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors =3D=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_mono_rect(vs, x, y, w, h, bg, fg)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_mono_rect(vs, worker, x, y, w, h,=
 bg, fg);<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors &lt;=3D 256) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_palette_rect(vs, x, y, w, h, pale=
tte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_palette_rect(vs, worker, x, y, w,=
 h, palette);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1430,34 +1447,35 @@ static int send_sub_rect_nojpeg(VncState *vs, int x=
, int y, int w, int h,<br>
=C2=A0}<br>
<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-static int send_sub_rect_jpeg(VncState *vs, int x, int y, int w, int h,<br=
>
+static int send_sub_rect_jpeg(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int bg, int fg, int colors,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VncPalette *palette, bool force)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (colors =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (force || (tight_jpeg_conf[vs-&gt;tight-&gt=
;quality].jpeg_full &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_detect_smooth_image(vs, w, h))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int quality =3D tight_conf[vs-&g=
t;tight-&gt;quality].jpeg_quality;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (force || (tight_jpeg_conf[worker-&gt;tight=
.quality].jpeg_full &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_detect_smooth_image(vs, &amp;worker-&gt;tight, w, h))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int quality =3D tight_conf[worke=
r-&gt;tight.quality].jpeg_quality;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_jpeg_rect(vs, x, y,=
 w, h, quality);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_jpeg_rect(vs, worke=
r, x, y, w, h, quality);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_full_color_rect(vs,=
 x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_full_color_rect(vs,=
 worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors =3D=3D 1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_solid_rect(vs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_solid_rect(vs, worker);<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors =3D=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_mono_rect(vs, x, y, w, h, bg, fg)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_mono_rect(vs, worker, x, y, w, h,=
 bg, fg);<br>
=C2=A0 =C2=A0 =C2=A0} else if (colors &lt;=3D 256) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (force || (colors &gt; 96 &amp;&amp;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_jpeg_conf[vs-&gt;tight-&gt;quality].jpeg_idx &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_detect_smooth_image(vs, w, h))) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int quality =3D tight_conf[vs-&g=
t;tight-&gt;quality].jpeg_quality;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_jpeg_conf[worker-&gt;tight.quality].jpeg_idx &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tight_detect_smooth_image(vs, &amp;worker-&gt;tight, w, h))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int quality =3D tight_conf[worke=
r-&gt;tight.quality].jpeg_quality;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_jpeg_rect(vs, x, y,=
 w, h, quality);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_jpeg_rect(vs, worke=
r, x, y, w, h, quality);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_palette_rect(vs, x,=
 y, w, h, palette);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_palette_rect(vs, wo=
rker, x, y, w, h, palette);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
@@ -1475,8 +1493,10 @@ static void vnc_tight_cleanup(Notifier *n, void *val=
ue)<br>
=C2=A0 =C2=A0 =C2=A0color_count_palette =3D NULL;<br>
=C2=A0}<br>
<br>
-static int send_sub_rect(VncState *vs, int x, int y, int w, int h)<br>
+static int send_sub_rect(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int x, int y, int w, int h)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncTight *tight =3D &amp;worker-&gt;tight;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t bg =3D 0, fg =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int colors;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
@@ -1491,57 +1511,59 @@ static int send_sub_rect(VncState *vs, int x, int y=
, int w, int h)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_atexit_add(&amp;vnc_tight_cle=
anup_notifier);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, vs-&gt;tight-&gt;type=
);<br>
+=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, tight-&gt;type);<br>
<br>
-=C2=A0 =C2=A0 vnc_tight_start(vs);<br>
+=C2=A0 =C2=A0 vnc_tight_start(vs, tight);<br>
=C2=A0 =C2=A0 =C2=A0vnc_raw_send_framebuffer_update(vs, x, y, w, h);<br>
-=C2=A0 =C2=A0 vnc_tight_stop(vs);<br>
+=C2=A0 =C2=A0 vnc_tight_stop(vs, tight);<br>
<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-=C2=A0 =C2=A0 if (!vs-&gt;vd-&gt;non_adaptive &amp;&amp; vs-&gt;tight-&gt;=
quality !=3D (uint8_t)-1) {<br>
+=C2=A0 =C2=A0 if (!vs-&gt;vd-&gt;non_adaptive &amp;&amp; tight-&gt;quality=
 !=3D (uint8_t)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0double freq =3D vnc_update_freq(vs, x, y,=
 w, h);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &lt; tight_jpeg_conf[vs-&gt;tight-&gt=
;quality].jpeg_freq_min) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &lt; tight_jpeg_conf[tight-&gt;qualit=
y].jpeg_freq_min) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allow_jpeg =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &gt;=3D tight_jpeg_conf[vs-&gt;tight-=
&gt;quality].jpeg_freq_threshold) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &gt;=3D tight_jpeg_conf[tight-&gt;qua=
lity].jpeg_freq_threshold) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0force_jpeg =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vnc_sent_lossy_rect(vs, x, y, w,=
 h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vnc_sent_lossy_rect(worker, x, y=
, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-=C2=A0 =C2=A0 colors =3D tight_fill_palette(vs, x, y, w * h, &amp;bg, &amp=
;fg, color_count_palette);<br>
+=C2=A0 =C2=A0 colors =3D tight_fill_palette(vs, tight, x, y, w * h, &amp;b=
g, &amp;fg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_count_palette);<br>
<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-=C2=A0 =C2=A0 if (allow_jpeg &amp;&amp; vs-&gt;tight-&gt;quality !=3D (uin=
t8_t)-1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_sub_rect_jpeg(vs, x, y, w, h, bg,=
 fg, colors,<br>
+=C2=A0 =C2=A0 if (allow_jpeg &amp;&amp; tight-&gt;quality !=3D (uint8_t)-1=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_sub_rect_jpeg(vs, worker, x, y, w=
, h, bg, fg, colors,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_count_palette, force_jp=
eg);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_sub_rect_nojpeg(vs, x, y, w, h, b=
g, fg, colors,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0color_count_palette);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D send_sub_rect_nojpeg(vs, worker, x, y,=
 w, h, bg, fg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0colors, color_count_pal=
ette);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 ret =3D send_sub_rect_nojpeg(vs, x, y, w, h, bg, fg, colors,=
<br>
+=C2=A0 =C2=A0 ret =3D send_sub_rect_nojpeg(vs, worker, x, y, w, h, bg, fg,=
 colors,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color_count_palette);<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-static int send_sub_rect_solid(VncState *vs, int x, int y, int w, int h)<b=
r>
+static int send_sub_rect_solid(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int w, int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, vs-&gt;tight-&gt;type=
);<br>
+=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, worker-&gt;tight.type=
);<br>
<br>
-=C2=A0 =C2=A0 vnc_tight_start(vs);<br>
+=C2=A0 =C2=A0 vnc_tight_start(vs, &amp;worker-&gt;tight);<br>
=C2=A0 =C2=A0 =C2=A0vnc_raw_send_framebuffer_update(vs, x, y, w, h);<br>
-=C2=A0 =C2=A0 vnc_tight_stop(vs);<br>
+=C2=A0 =C2=A0 vnc_tight_stop(vs, &amp;worker-&gt;tight);<br>
<br>
-=C2=A0 =C2=A0 return send_solid_rect(vs);<br>
+=C2=A0 =C2=A0 return send_solid_rect(vs, worker);<br>
=C2=A0}<br>
<br>
-static int send_rect_simple(VncState *vs, int x, int y, int w, int h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bool split)<br>
+static int send_rect_simple(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h, bool split)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int max_size, max_width;<br>
=C2=A0 =C2=A0 =C2=A0int max_sub_width, max_sub_height;<br>
@@ -1549,8 +1571,8 @@ static int send_rect_simple(VncState *vs, int x, int =
y, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0int rw, rh;<br>
=C2=A0 =C2=A0 =C2=A0int n =3D 0;<br>
<br>
-=C2=A0 =C2=A0 max_size =3D tight_conf[vs-&gt;tight-&gt;compression].max_re=
ct_size;<br>
-=C2=A0 =C2=A0 max_width =3D tight_conf[vs-&gt;tight-&gt;compression].max_r=
ect_width;<br>
+=C2=A0 =C2=A0 max_size =3D tight_conf[worker-&gt;tight.compression].max_re=
ct_size;<br>
+=C2=A0 =C2=A0 max_width =3D tight_conf[worker-&gt;tight.compression].max_r=
ect_width;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (split &amp;&amp; (w &gt; max_width || w * h &gt; ma=
x_size)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_sub_width =3D (w &gt; max_width) ? ma=
x_width : w;<br>
@@ -1560,18 +1582,18 @@ static int send_rect_simple(VncState *vs, int x, in=
t y, int w, int h,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (dx =3D 0; dx &lt; w; d=
x +=3D max_width) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rw =3D MIN(ma=
x_sub_width, w - dx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rh =3D MIN(ma=
x_sub_height, h - dy);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_re=
ct(vs, x+dx, y+dy, rw, rh);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_re=
ct(vs, worker, x + dx, y + dy, rw, rh);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_rect(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_rect(vs, worker, x, y, w, h);<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return n;<br>
=C2=A0}<br>
<br>
-static int find_large_solid_color_rect(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, in=
t h, int max_rows)<br>
+static int find_large_solid_color_rect(VncState *vs, VncWorker *worker,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, in=
t y, int w, int h, int max_rows)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int dx, dy, dw, dh;<br>
=C2=A0 =C2=A0 =C2=A0int n =3D 0;<br>
@@ -1583,7 +1605,7 @@ static int find_large_solid_color_rect(VncState *vs, =
int x, int y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If a rectangle becomes too large, send=
 its upper part now. */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dy - y &gt;=3D max_rows) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_rect_simple(vs, x, y=
, w, max_rows, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_rect_simple(vs, work=
er, x, y, w, max_rows, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0y +=3D max_rows;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h -=3D max_rows;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1622,26 +1644,28 @@ static int find_large_solid_color_rect(VncState *vs=
, int x, int y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Send rectangles at top a=
nd left to solid-color area. */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (y_best !=3D y) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_rect_s=
imple(vs, x, y, w, y_best-y, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_rect_s=
imple(vs, worker, x, y, w, y_best - y, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (x_best !=3D x) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, x, y_best,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, worker, x, y_best,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x_best-x, h_best);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Send solid-color rectang=
le. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_rect_solid(vs, x=
_best, y_best, w_best, h_best);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D send_sub_rect_solid(vs, w=
orker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x_best, y_best, =
w_best, h_best);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Send remaining rectangle=
s (at right and bottom). */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (x_best + w_best !=3D x =
+ w) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, x_best+w_best,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, worker, x_best + w_best,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 y_best,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w-(x_best-x)-w_best,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h_best);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (y_best + h_best !=3D y =
+ h) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, x, y_best+h_best,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n +=3D tight_send_=
framebuffer_update(vs, worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x, y_best + h_best,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w, h-(y_best-y)-h_best);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1649,73 +1673,73 @@ static int find_large_solid_color_rect(VncState *vs=
, int x, int y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 return n + send_rect_simple(vs, x, y, w, h, true);<br>
+=C2=A0 =C2=A0 return n + send_rect_simple(vs, worker, x, y, w, h, true);<b=
r>
=C2=A0}<br>
<br>
-static int tight_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t w, int h)<br>
+static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
t x, int y, int w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int max_rows;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vs-&gt;client_pf.bytes_per_pixel =3D=3D 4 &amp;&amp=
; vs-&gt;client_pf.rmax =3D=3D 0xFF &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;client_pf.bmax =3D=3D 0xFF &amp;&a=
mp; vs-&gt;client_pf.gmax =3D=3D 0xFF) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;pixel24 =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;tight.pixel24 =3D true;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;pixel24 =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;tight.pixel24 =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;quality !=3D (uint8_t)-1) {<br>
+=C2=A0 =C2=A0 if (worker-&gt;tight.quality !=3D (uint8_t)-1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0double freq =3D vnc_update_freq(vs, x, y,=
 w, h);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &gt; tight_jpeg_conf[vs-&gt;tight-&gt=
;quality].jpeg_freq_threshold) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_rect_simple(vs, x, y=
, w, h, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (freq &gt; tight_jpeg_conf[worker-&gt;tight=
.quality].jpeg_freq_threshold) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_rect_simple(vs, work=
er, x, y, w, h, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (w * h &lt; VNC_TIGHT_MIN_SPLIT_RECT_SIZE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_rect_simple(vs, x, y, w, h, true);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return send_rect_simple(vs, worker, x, y, w, h=
, true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Calculate maximum number of rows in one non-solid re=
ctangle. */<br>
<br>
-=C2=A0 =C2=A0 max_rows =3D tight_conf[vs-&gt;tight-&gt;compression].max_re=
ct_size;<br>
-=C2=A0 =C2=A0 max_rows /=3D MIN(tight_conf[vs-&gt;tight-&gt;compression].m=
ax_rect_width, w);<br>
+=C2=A0 =C2=A0 max_rows =3D tight_conf[worker-&gt;tight.compression].max_re=
ct_size;<br>
+=C2=A0 =C2=A0 max_rows /=3D MIN(tight_conf[worker-&gt;tight.compression].m=
ax_rect_width, w);<br>
<br>
-=C2=A0 =C2=A0 return find_large_solid_color_rect(vs, x, y, w, h, max_rows)=
;<br>
+=C2=A0 =C2=A0 return find_large_solid_color_rect(vs, worker, x, y, w, h, m=
ax_rows);<br>
=C2=A0}<br>
<br>
-int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w, int h)<b=
r>
+int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, i=
nt w, int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;type =3D VNC_ENCODING_TIGHT;<br>
-=C2=A0 =C2=A0 return tight_send_framebuffer_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 worker-&gt;tight.type =3D VNC_ENCODING_TIGHT;<br>
+=C2=A0 =C2=A0 return tight_send_framebuffer_update(vs, worker, x, y, w, h)=
;<br>
=C2=A0}<br>
<br>
-int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt w, int h)<br>
+int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worker,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nt x, int y, int w, int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;type =3D VNC_ENCODING_TIGHT_PNG;<br>
-=C2=A0 =C2=A0 return tight_send_framebuffer_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 worker-&gt;tight.type =3D VNC_ENCODING_TIGHT_PNG;<br>
+=C2=A0 =C2=A0 return tight_send_framebuffer_update(vs, worker, x, y, w, h)=
;<br>
=C2=A0}<br>
<br>
-void vnc_tight_clear(VncState *vs)<br>
+void vnc_tight_clear(VncWorker *worker)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(vs-&gt;tight-&gt;stream); i+=
+) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vs-&gt;tight-&gt;stream[i].opaque) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;vs-&gt;tight-&gt=
;stream[i]);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(worker-&gt;tight.stream); i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (worker-&gt;tight.stream[i].opaque) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;worker-&gt;tight=
.stream[i]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;tight-&gt;tight);<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;tight-&gt;zlib);<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;tight-&gt;gradient);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;tight.tight);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;tight.zlib);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;tight.gradient);<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;tight-&gt;jpeg);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;tight.jpeg);<br>
=C2=A0#endif<br>
=C2=A0#ifdef CONFIG_PNG<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;tight-&gt;png);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;tight.png);<br>
=C2=A0#endif<br>
=C2=A0}<br>
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c<br>
index 52e9193eab572a79733b11c89bde81daf01679e7..a6d287118aaaed30372d90668f0=
406de4d14599c 100644<br>
--- a/ui/vnc-enc-zlib.c<br>
+++ b/ui/vnc-enc-zlib.c<br>
@@ -46,23 +46,23 @@ void vnc_zlib_zfree(void *x, void *addr)<br>
=C2=A0 =C2=A0 =C2=A0g_free(addr);<br>
=C2=A0}<br>
<br>
-static void vnc_zlib_start(VncState *vs)<br>
+static void vnc_zlib_start(VncState *vs, VncWorker *worker)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;zlib-&gt;zlib);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;worker-&gt;zlib.zlib);<br>
<br>
=C2=A0 =C2=A0 =C2=A0// make the output buffer be the zlib buffer, so we can=
 compress it later<br>
-=C2=A0 =C2=A0 vs-&gt;zlib-&gt;tmp =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;zlib-&gt;zlib;<br>
+=C2=A0 =C2=A0 worker-&gt;zlib.tmp =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D worker-&gt;zlib.zlib;<br>
=C2=A0}<br>
<br>
-static int vnc_zlib_stop(VncState *vs)<br>
+static int vnc_zlib_stop(VncState *vs, VncWorker *worker)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 z_streamp zstream =3D &amp;vs-&gt;zlib-&gt;stream;<br>
+=C2=A0 =C2=A0 z_streamp zstream =3D &amp;worker-&gt;zlib.stream;<br>
=C2=A0 =C2=A0 =C2=A0int previous_out;<br>
<br>
=C2=A0 =C2=A0 =C2=A0// switch back to normal output/zlib buffers<br>
-=C2=A0 =C2=A0 vs-&gt;zlib-&gt;zlib =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;zlib-&gt;tmp;<br>
+=C2=A0 =C2=A0 worker-&gt;zlib.zlib =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D worker-&gt;zlib.tmp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0// compress the zlib buffer<br>
<br>
@@ -76,7 +76,7 @@ static int vnc_zlib_stop(VncState *vs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zstream-&gt;zalloc =3D vnc_zlib_zalloc;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zstream-&gt;zfree =3D vnc_zlib_zfree;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D deflateInit2(zstream, vs-&gt;tight-&gt=
;compression, Z_DEFLATED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D deflateInit2(zstream, worker-&gt;tight=
.compression, Z_DEFLATED,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 MAX_WBITS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);<br>
<br>
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;zlib-&gt;level =3D vs-&gt;tight-&gt;com=
pression;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;zlib.level =3D worker-&gt;tight.com=
pression;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zstream-&gt;opaque =3D vs;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;tight-&gt;compression !=3D vs-&gt;zlib-&gt;level)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deflateParams(zstream, vs-&gt;tight-&gt;co=
mpression,<br>
+=C2=A0 =C2=A0 if (worker-&gt;tight.compression !=3D worker-&gt;zlib.level)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (deflateParams(zstream, worker-&gt;tight.co=
mpression,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Z_DEFAULT_STRATEGY) !=3D Z_OK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;zlib-&gt;level =3D vs-&gt;tight-&gt;com=
pression;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;zlib.level =3D worker-&gt;tight.com=
pression;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0// reserve memory in output buffer<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;output, vs-&gt;zlib-&gt;zlib.offs=
et + 64);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;output, worker-&gt;zlib.zlib.offs=
et + 64);<br>
<br>
=C2=A0 =C2=A0 =C2=A0// set pointers<br>
-=C2=A0 =C2=A0 zstream-&gt;next_in =3D vs-&gt;zlib-&gt;zlib.buffer;<br>
-=C2=A0 =C2=A0 zstream-&gt;avail_in =3D vs-&gt;zlib-&gt;zlib.offset;<br>
+=C2=A0 =C2=A0 zstream-&gt;next_in =3D worker-&gt;zlib.zlib.buffer;<br>
+=C2=A0 =C2=A0 zstream-&gt;avail_in =3D worker-&gt;zlib.zlib.offset;<br>
=C2=A0 =C2=A0 =C2=A0zstream-&gt;next_out =3D vs-&gt;output.buffer + vs-&gt;=
output.offset;<br>
=C2=A0 =C2=A0 =C2=A0zstream-&gt;avail_out =3D vs-&gt;output.capacity - vs-&=
gt;output.offset;<br>
=C2=A0 =C2=A0 =C2=A0previous_out =3D zstream-&gt;avail_out;<br>
@@ -118,7 +118,8 @@ static int vnc_zlib_stop(VncState *vs)<br>
=C2=A0 =C2=A0 =C2=A0return previous_out - zstream-&gt;avail_out;<br>
=C2=A0}<br>
<br>
-int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, in=
t h)<br>
+int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, in=
t w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int old_offset, new_offset, bytes_written;<br>
<br>
@@ -129,9 +130,9 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int =
x, int y, int w, int h)<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_s32(vs, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0// compress the stream<br>
-=C2=A0 =C2=A0 vnc_zlib_start(vs);<br>
+=C2=A0 =C2=A0 vnc_zlib_start(vs, worker);<br>
=C2=A0 =C2=A0 =C2=A0vnc_raw_send_framebuffer_update(vs, x, y, w, h);<br>
-=C2=A0 =C2=A0 bytes_written =3D vnc_zlib_stop(vs);<br>
+=C2=A0 =C2=A0 bytes_written =3D vnc_zlib_stop(vs, worker);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (bytes_written =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
@@ -145,10 +146,10 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, in=
t x, int y, int w, int h)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-void vnc_zlib_clear(VncState *vs)<br>
+void vnc_zlib_clear(VncWorker *worker)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (vs-&gt;zlib-&gt;stream.opaque) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;vs-&gt;zlib-&gt;stream);<br>
+=C2=A0 =C2=A0 if (worker-&gt;zlib.stream.opaque) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;worker-&gt;zlib.stream);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;zlib-&gt;zlib);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;zlib.zlib);<br>
=C2=A0}<br>
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c<br>
index 97ec6c7119bc6da3af0e46e73a9e36220646d010..7679014c9e3379e21390f581516=
3854f5283700c 100644<br>
--- a/ui/vnc-enc-zrle.c<br>
+++ b/ui/vnc-enc-zrle.c<br>
@@ -35,45 +35,45 @@ static const int bits_per_packed_pixel[] =3D {<br>
=C2=A0};<br>
<br>
<br>
-static void vnc_zrle_start(VncState *vs)<br>
+static void vnc_zrle_start(VncState *vs, VncZrle *zrle)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;zrle-&gt;zrle);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;zrle-&gt;zrle);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* make the output buffer be the zlib buffer, so we can=
 compress it later */<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;tmp =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;zrle-&gt;zrle;<br>
+=C2=A0 =C2=A0 zrle-&gt;tmp =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D zrle-&gt;zrle;<br>
=C2=A0}<br>
<br>
-static void vnc_zrle_stop(VncState *vs)<br>
+static void vnc_zrle_stop(VncState *vs, VncZrle *zrle)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* switch back to normal output/zlib buffers */<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;zrle =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;zrle-&gt;tmp;<br>
+=C2=A0 =C2=A0 zrle-&gt;zrle =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D zrle-&gt;tmp;<br>
=C2=A0}<br>
<br>
-static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int bpp)<br>
+static void *zrle_convert_fb(VncState *vs, VncZrle *zrle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, int w, int h, int bpp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Buffer tmp;<br>
<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;zrle-&gt;fb);<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;zrle-&gt;fb, w * h * bpp + bpp);<=
br>
+=C2=A0 =C2=A0 buffer_reset(&amp;zrle-&gt;fb);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;zrle-&gt;fb, w * h * bpp + bpp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D vs-&gt;output;<br>
-=C2=A0 =C2=A0 vs-&gt;output =3D vs-&gt;zrle-&gt;fb;<br>
+=C2=A0 =C2=A0 vs-&gt;output =3D zrle-&gt;fb;<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_raw_send_framebuffer_update(vs, x, y, w, h);<br>
<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;fb =3D vs-&gt;output;<br>
+=C2=A0 =C2=A0 zrle-&gt;fb =3D vs-&gt;output;<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;output =3D tmp;<br>
-=C2=A0 =C2=A0 return vs-&gt;zrle-&gt;fb.buffer;<br>
+=C2=A0 =C2=A0 return zrle-&gt;fb.buffer;<br>
=C2=A0}<br>
<br>
-static int zrle_compress_data(VncState *vs, int level)<br>
+static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 z_streamp zstream =3D &amp;vs-&gt;zrle-&gt;stream;<br>
+=C2=A0 =C2=A0 z_streamp zstream =3D &amp;zrle-&gt;stream;<br>
<br>
-=C2=A0 =C2=A0 buffer_reset(&amp;vs-&gt;zrle-&gt;zlib);<br>
+=C2=A0 =C2=A0 buffer_reset(&amp;zrle-&gt;zlib);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (zstream-&gt;opaque !=3D vs) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
@@ -93,13 +93,13 @@ static int zrle_compress_data(VncState *vs, int level)<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* reserve memory in output buffer */<br>
-=C2=A0 =C2=A0 buffer_reserve(&amp;vs-&gt;zrle-&gt;zlib, vs-&gt;zrle-&gt;zr=
le.offset + 64);<br>
+=C2=A0 =C2=A0 buffer_reserve(&amp;zrle-&gt;zlib, zrle-&gt;zrle.offset + 64=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set pointers */<br>
-=C2=A0 =C2=A0 zstream-&gt;next_in =3D vs-&gt;zrle-&gt;zrle.buffer;<br>
-=C2=A0 =C2=A0 zstream-&gt;avail_in =3D vs-&gt;zrle-&gt;zrle.offset;<br>
-=C2=A0 =C2=A0 zstream-&gt;next_out =3D vs-&gt;zrle-&gt;zlib.buffer;<br>
-=C2=A0 =C2=A0 zstream-&gt;avail_out =3D vs-&gt;zrle-&gt;zlib.capacity;<br>
+=C2=A0 =C2=A0 zstream-&gt;next_in =3D zrle-&gt;zrle.buffer;<br>
+=C2=A0 =C2=A0 zstream-&gt;avail_in =3D zrle-&gt;zrle.offset;<br>
+=C2=A0 =C2=A0 zstream-&gt;next_out =3D zrle-&gt;zlib.buffer;<br>
+=C2=A0 =C2=A0 zstream-&gt;avail_out =3D zrle-&gt;zlib.capacity;<br>
=C2=A0 =C2=A0 =C2=A0zstream-&gt;data_type =3D Z_BINARY;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* start encoding */<br>
@@ -108,8 +108,8 @@ static int zrle_compress_data(VncState *vs, int level)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;zlib.offset =3D vs-&gt;zrle-&gt;zlib.capacit=
y - zstream-&gt;avail_out;<br>
-=C2=A0 =C2=A0 return vs-&gt;zrle-&gt;zlib.offset;<br>
+=C2=A0 =C2=A0 zrle-&gt;zlib.offset =3D zrle-&gt;zlib.capacity - zstream-&g=
t;avail_out;<br>
+=C2=A0 =C2=A0 return zrle-&gt;zlib.offset;<br>
=C2=A0}<br>
<br>
=C2=A0/* Try to work out whether to use RLE and/or a palette.=C2=A0 We do t=
his by<br>
@@ -252,21 +252,21 @@ static void zrle_write_u8(VncState *vs, uint8_t value=
)<br>
=C2=A0#undef ZRLE_COMPACT_PIXEL<br>
=C2=A0#undef ZRLE_BPP<br>
<br>
-static int zrle_send_framebuffer_update(VncState *vs, int x, int y,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int w, i=
nt h)<br>
+static int zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, i=
nt y, int w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool be =3D vs-&gt;client_endian =3D=3D G_BIG_ENDIAN;<b=
r>
=C2=A0 =C2=A0 =C2=A0size_t bytes;<br>
=C2=A0 =C2=A0 =C2=A0int zywrle_level;<br>
<br>
-=C2=A0 =C2=A0 if (vs-&gt;zrle-&gt;type =3D=3D VNC_ENCODING_ZYWRLE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vs-&gt;vd-&gt;lossy || vs-&gt;tight-&gt;q=
uality =3D=3D (uint8_t)-1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || vs-&gt;tight-&gt;quality =3D=
=3D 9) {<br>
+=C2=A0 =C2=A0 if (worker-&gt;zrle.type =3D=3D VNC_ENCODING_ZYWRLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vs-&gt;vd-&gt;lossy || worker-&gt;tight.q=
uality =3D=3D (uint8_t)-1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || worker-&gt;tight.quality =3D=
=3D 9) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zywrle_level =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;zrle-&gt;type =3D VNC_ENC=
ODING_ZRLE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vs-&gt;tight-&gt;quality &lt; 3) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;zrle.type =3D VNC_ENC=
ODING_ZRLE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (worker-&gt;tight.quality &lt; 3) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zywrle_level =3D 3;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vs-&gt;tight-&gt;quality &lt; 6) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (worker-&gt;tight.quality &lt; 6) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zywrle_level =3D 2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zywrle_level =3D 1;<br>
@@ -275,25 +275,25 @@ static int zrle_send_framebuffer_update(VncState *vs,=
 int x, int y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0zywrle_level =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vnc_zrle_start(vs);<br>
+=C2=A0 =C2=A0 vnc_zrle_start(vs, &amp;worker-&gt;zrle);<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (vs-&gt;client_pf.bytes_per_pixel) {<br>
=C2=A0 =C2=A0 =C2=A0case 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_8ne(vs, x, y, w, h, zywrle_level);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_8ne(vs, &amp;worker-&gt;zrle, x, y=
, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vs-&gt;client_pf.gmax &gt; 0x1F) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_16be(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_16be(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_16le(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_16le(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_15be(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_15be(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_15le(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_15le(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -314,53 +314,55 @@ static int zrle_send_framebuffer_update(VncState *vs,=
 int x, int y,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fits_in_ls3bytes &amp;&amp; !be) || =
(fits_in_ms3bytes &amp;&amp; be)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24abe(=
vs, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24abe(=
vs, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24ale(=
vs, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24ale(=
vs, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if ((fits_in_ls3bytes &amp;&amp; b=
e) || (fits_in_ms3bytes &amp;&amp; !be)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24bbe(=
vs, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24bbe(=
vs, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24ble(=
vs, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_24ble(=
vs, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_32be(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_32be(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_32le(v=
s, x, y, w, h, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zrle_encode_32le(v=
s, &amp;worker-&gt;zrle, x, y, w, h, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 vnc_zrle_stop(vs);<br>
-=C2=A0 =C2=A0 bytes =3D zrle_compress_data(vs, Z_DEFAULT_COMPRESSION);<br>
-=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, vs-&gt;zrle-&gt;type)=
;<br>
+=C2=A0 =C2=A0 vnc_zrle_stop(vs, &amp;worker-&gt;zrle);<br>
+=C2=A0 =C2=A0 bytes =3D zrle_compress_data(vs, &amp;worker-&gt;zrle, Z_DEF=
AULT_COMPRESSION);<br>
+=C2=A0 =C2=A0 vnc_framebuffer_update(vs, x, y, w, h, worker-&gt;zrle.type)=
;<br>
=C2=A0 =C2=A0 =C2=A0vnc_write_u32(vs, bytes);<br>
-=C2=A0 =C2=A0 vnc_write(vs, vs-&gt;zrle-&gt;zlib.buffer, vs-&gt;zrle-&gt;z=
lib.offset);<br>
+=C2=A0 =C2=A0 vnc_write(vs, worker-&gt;zrle.zlib.buffer, worker-&gt;zrle.z=
lib.offset);<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, in=
t h)<br>
+int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, int y, in=
t w, int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;type =3D VNC_ENCODING_ZRLE;<br>
-=C2=A0 =C2=A0 return zrle_send_framebuffer_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 worker-&gt;zrle.type =3D VNC_ENCODING_ZRLE;<br>
+=C2=A0 =C2=A0 return zrle_send_framebuffer_update(vs, worker, x, y, w, h);=
<br>
=C2=A0}<br>
<br>
-int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, =
int h)<br>
+int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int x, in=
t y, int w, int h)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 vs-&gt;zrle-&gt;type =3D VNC_ENCODING_ZYWRLE;<br>
-=C2=A0 =C2=A0 return zrle_send_framebuffer_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 worker-&gt;zrle.type =3D VNC_ENCODING_ZYWRLE;<br>
+=C2=A0 =C2=A0 return zrle_send_framebuffer_update(vs, worker, x, y, w, h);=
<br>
=C2=A0}<br>
<br>
-void vnc_zrle_clear(VncState *vs)<br>
+void vnc_zrle_clear(VncWorker *worker)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (vs-&gt;zrle-&gt;stream.opaque) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;vs-&gt;zrle-&gt;stream);<br>
+=C2=A0 =C2=A0 if (worker-&gt;zrle.stream.opaque) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 deflateEnd(&amp;worker-&gt;zrle.stream);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;zrle-&gt;zrle);<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;zrle-&gt;fb);<br>
-=C2=A0 =C2=A0 buffer_free(&amp;vs-&gt;zrle-&gt;zlib);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;zrle.zrle);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;zrle.fb);<br>
+=C2=A0 =C2=A0 buffer_free(&amp;worker-&gt;zrle.zlib);<br>
=C2=A0}<br>
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c<br>
index d3486af9e2138aaf5e0bb24ed3e7c97940582820..bed33950a8791e7915f3396933b=
0ed1d474b1575 100644<br>
--- a/ui/vnc-jobs.c<br>
+++ b/ui/vnc-jobs.c<br>
@@ -185,14 +185,10 @@ static void vnc_async_encoding_start(VncState *orig, =
VncState *local)<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;vnc_encoding =3D orig-&gt;vnc_encoding;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;features =3D orig-&gt;features;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;vd =3D orig-&gt;vd;<br>
-=C2=A0 =C2=A0 local-&gt;lossy_rect =3D orig-&gt;lossy_rect;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;write_pixels =3D orig-&gt;write_pixels;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;client_pf =3D orig-&gt;client_pf;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;client_endian =3D orig-&gt;client_endian;<br>
-=C2=A0 =C2=A0 local-&gt;tight =3D orig-&gt;tight;<br>
-=C2=A0 =C2=A0 local-&gt;zlib =3D orig-&gt;zlib;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;hextile =3D orig-&gt;hextile;<br>
-=C2=A0 =C2=A0 local-&gt;zrle =3D orig-&gt;zrle;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;client_width =3D orig-&gt;client_width;<br>
=C2=A0 =C2=A0 =C2=A0local-&gt;client_height =3D orig-&gt;client_height;<br>
=C2=A0}<br>
@@ -200,11 +196,7 @@ static void vnc_async_encoding_start(VncState *orig, V=
ncState *local)<br>
=C2=A0static void vnc_async_encoding_end(VncState *orig, VncState *local)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0buffer_free(&amp;local-&gt;output);<br>
-=C2=A0 =C2=A0 orig-&gt;tight =3D local-&gt;tight;<br>
-=C2=A0 =C2=A0 orig-&gt;zlib =3D local-&gt;zlib;<br>
=C2=A0 =C2=A0 =C2=A0orig-&gt;hextile =3D local-&gt;hextile;<br>
-=C2=A0 =C2=A0 orig-&gt;zrle =3D local-&gt;zrle;<br>
-=C2=A0 =C2=A0 orig-&gt;lossy_rect =3D local-&gt;lossy_rect;<br>
=C2=A0}<br>
<br>
=C2=A0static bool vnc_worker_clamp_rect(VncState *vs, VncJob *job, VncRect =
*rect)<br>
@@ -237,6 +229,7 @@ static bool vnc_worker_clamp_rect(VncState *vs, VncJob =
*job, VncRect *rect)<br>
<br>
=C2=A0static int vnc_worker_thread_loop(VncJobQueue *queue)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncConnection *vc;<br>
=C2=A0 =C2=A0 =C2=A0VncJob *job;<br>
=C2=A0 =C2=A0 =C2=A0VncRectEntry *entry, *tmp;<br>
=C2=A0 =C2=A0 =C2=A0VncState vs =3D {};<br>
@@ -256,6 +249,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(job-&gt;vs-&gt;magic =3D=3D VNC_MAGIC);<br>
+=C2=A0 =C2=A0 vc =3D container_of(job-&gt;vs, VncConnection, vs);<br>
<br>
=C2=A0 =C2=A0 =C2=A0vnc_lock_output(job-&gt;vs);<br>
=C2=A0 =C2=A0 =C2=A0if (job-&gt;vs-&gt;ioc =3D=3D NULL || job-&gt;vs-&gt;ab=
ort =3D=3D true) {<br>
@@ -295,7 +289,8 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vnc_worker_clamp_rect(&amp;vs, job, &=
amp;entry-&gt;rect)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_send_framebuffer_updat=
e(&amp;vs, entry-&gt;rect.x, entry-&gt;rect.y,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_send_framebuffer_updat=
e(&amp;vs, &amp;vc-&gt;worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 entry-&gt;rect.x, entry-&gt;rect.y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0entry-&gt;rect.w, entry-&gt;rect.h);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n &gt;=3D 0) {<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 59009ff61b350487153960d0236eb438f93e665b..0556b154a840f5a2e7ecc8dba35=
415eaed077966 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -56,11 +56,6 @@<br>
=C2=A0#include &quot;io/dns-resolver.h&quot;<br>
=C2=A0#include &quot;monitor/monitor.h&quot;<br>
<br>
-typedef struct VncConnection {<br>
-=C2=A0 =C2=A0 VncState vs;<br>
-=C2=A0 =C2=A0 VncZlib zlib;<br>
-} VncConnection;<br>
-<br>
=C2=A0#define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT<br>
=C2=A0#define VNC_REFRESH_INTERVAL_INC=C2=A0 50<br>
=C2=A0#define VNC_REFRESH_INTERVAL_MAX=C2=A0 GUI_REFRESH_INTERVAL_IDLE<br>
@@ -951,29 +946,30 @@ int vnc_raw_send_framebuffer_update(VncState *vs, int=
 x, int y, int w, int h)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
<br>
-int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)<=
br>
+int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int x, int y, int w, int h)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int n =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch(vs-&gt;vnc_encoding) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_ZLIB:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zlib_send_framebuffer_=
update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zlib_send_framebuffer_=
update(vs, worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_HEXTILE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_framebuffer_update(vs, =
x, y, w, h, VNC_ENCODING_HEXTILE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D vnc_hextile_send_fram=
ebuffer_update(vs, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_TIGHT:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_tight_send_framebuffer=
_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_tight_send_framebuffer=
_update(vs, worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_TIGHT_PNG:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_tight_png_send_framebu=
ffer_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_tight_png_send_framebu=
ffer_update(vs, worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_ZRLE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zrle_send_framebuffer_=
update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zrle_send_framebuffer_=
update(vs, worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_ZYWRLE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zywrle_send_framebuffe=
r_update(vs, x, y, w, h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n =3D vnc_zywrle_send_framebuffe=
r_update(vs, worker, x, y, w, h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_framebuffer_update(vs, =
x, y, w, h, VNC_ENCODING_RAW);<br>
@@ -1311,7 +1307,7 @@ static void vnc_disconnect_start(VncState *vs)<br>
<br>
=C2=A0void vnc_disconnect_finish(VncState *vs)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 VncConnection *vc =3D container_of(vs, VncConnection, vs);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vnc_client_disconnect_finish(vs, vs-&gt;ioc);<br>
<br>
@@ -1325,9 +1321,9 @@ void vnc_disconnect_finish(VncState *vs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_VncClientInfo(vs-&gt;info);<br>
<br>
-=C2=A0 =C2=A0 vnc_zlib_clear(vs);<br>
-=C2=A0 =C2=A0 vnc_tight_clear(vs);<br>
-=C2=A0 =C2=A0 vnc_zrle_clear(vs);<br>
+=C2=A0 =C2=A0 vnc_zlib_clear(&amp;vc-&gt;worker);<br>
+=C2=A0 =C2=A0 vnc_tight_clear(&amp;vc-&gt;worker);<br>
+=C2=A0 =C2=A0 vnc_zrle_clear(&amp;vc-&gt;worker);<br>
<br>
=C2=A0#ifdef CONFIG_VNC_SASL<br>
=C2=A0 =C2=A0 =C2=A0vnc_sasl_client_cleanup(vs);<br>
@@ -1355,19 +1351,12 @@ void vnc_disconnect_finish(VncState *vs)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0buffer_free(&amp;vs-&gt;jobs_buffer);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; VNC_STAT_ROWS; ++i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vs-&gt;lossy_rect[i]);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_free(vs-&gt;lossy_rect);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(vs-&gt;ioc));<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;ioc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(vs-&gt;sioc));<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;sioc =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;magic =3D 0;<br>
-=C2=A0 =C2=A0 g_free(vs-&gt;zrle);<br>
-=C2=A0 =C2=A0 g_free(vs-&gt;tight);<br>
-=C2=A0 =C2=A0 g_free(container_of(vs, VncConnection, vs));<br>
+=C2=A0 =C2=A0 g_free(vc);<br>
=C2=A0}<br>
<br>
=C2=A0size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)<br>
@@ -2131,13 +2120,14 @@ static void send_xvp_message(VncState *vs, int code=
)<br>
<br>
=C2=A0static void set_encodings(VncState *vs, int32_t *encodings, size_t n_=
encodings)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 VncConnection *vc =3D container_of(vs, VncConnection, vs);<b=
r>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int enc =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;features =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;vnc_encoding =3D 0;<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;compression =3D 9;<br>
-=C2=A0 =C2=A0 vs-&gt;tight-&gt;quality =3D -1; /* Lossless by default */<b=
r>
+=C2=A0 =C2=A0 vc-&gt;worker.tight.compression =3D 9;<br>
+=C2=A0 =C2=A0 vc-&gt;worker.tight.quality =3D -1; /* Lossless by default *=
/<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;absolute =3D -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -2225,11 +2215,11 @@ static void set_encodings(VncState *vs, int32_t *en=
codings, size_t n_encodings)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vnc_server_cut_text_caps(vs=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_=
ENCODING_COMPRESSLEVEL0 + 9:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;compression =3D=
 (enc &amp; 0x0F);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;worker.tight.compression =
=3D (enc &amp; 0x0F);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case VNC_ENCODING_QUALITYLEVEL0 ... VNC_E=
NCODING_QUALITYLEVEL0 + 9:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vs-&gt;vd-&gt;lossy) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;tight-&gt;q=
uality =3D (enc &amp; 0x0F);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;worker.tigh=
t.quality =3D (enc &amp; 0x0F);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
@@ -2958,7 +2948,7 @@ static VncRectStat *vnc_stat_rect(VncDisplay *vd, int=
 x, int y)<br>
=C2=A0 =C2=A0 =C2=A0return &amp;vs-&gt;stats[y / VNC_STAT_RECT][x / VNC_STA=
T_RECT];<br>
=C2=A0}<br>
<br>
-void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)<br>
+void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i, j;<br>
<br>
@@ -2969,7 +2959,7 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y, =
int w, int h)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (j =3D y; j &lt;=3D h; j++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D x; i &lt;=3D w; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;lossy_rect[j][i] =3D 1;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker-&gt;lossy_rect[j][i] =3D =
1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -2985,6 +2975,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int=
 x, int y)<br>
=C2=A0 =C2=A0 =C2=A0x =3D QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);<br>
<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_FOREACH(vs, &amp;vd-&gt;clients, next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VncConnection *vc =3D container_of(vs, VncConn=
ection, vs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int j;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* kernel send buffers are full -&gt; ref=
resh later */<br>
@@ -2992,11 +2983,11 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, i=
nt x, int y)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vs-&gt;lossy_rect[sty][stx]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vc-&gt;worker.lossy_rect[sty][stx]) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;lossy_rect[sty][stx] =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vc-&gt;worker.lossy_rect[sty][stx] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt; VNC_STAT_RECT; ++j) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_set(vs-&gt;dirty[y +=
 j],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 x / VNC_DIRTY_PIXELS_PER_BIT,<br>
@@ -3249,12 +3240,8 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSo=
cket *sioc,<br>
=C2=A0 =C2=A0 =C2=A0VncConnection *vc =3D g_new0(VncConnection, 1);<br>
=C2=A0 =C2=A0 =C2=A0VncState *vs =3D &amp;vc-&gt;vs;<br>
=C2=A0 =C2=A0 =C2=A0bool first_client =3D QTAILQ_EMPTY(&amp;vd-&gt;clients)=
;<br>
-=C2=A0 =C2=A0 int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vnc_client_connect(vs, sioc);<br>
-=C2=A0 =C2=A0 vs-&gt;zlib =3D &amp;vc-&gt;zlib;<br>
-=C2=A0 =C2=A0 vs-&gt;zrle =3D g_new0(VncZrle, 1);<br>
-=C2=A0 =C2=A0 vs-&gt;tight =3D g_new0(VncTight, 1);<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;magic =3D VNC_MAGIC;<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;sioc =3D sioc;<br>
=C2=A0 =C2=A0 =C2=A0object_ref(OBJECT(vs-&gt;sioc));<br>
@@ -3262,23 +3249,23 @@ static void vnc_connect(VncDisplay *vd, QIOChannelS=
ocket *sioc,<br>
=C2=A0 =C2=A0 =C2=A0object_ref(OBJECT(vs-&gt;ioc));<br>
=C2=A0 =C2=A0 =C2=A0vs-&gt;vd =3D vd;<br>
<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;input,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;vnc-input/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;output,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;vnc-output/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;jobs_buffer,=C2=A0 =C2=A0 &quot;vnc-=
jobs_buffer/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;input,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vnc-input/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;output,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vnc-output/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;jobs_buffer,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;vnc-jobs_buffer/%p&quot;, sioc);<br>
<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;tight-&gt;tight,=C2=A0 =C2=A0 &quot;=
vnc-tight/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;tight-&gt;zlib,=C2=A0 =C2=A0 =C2=A0&=
quot;vnc-tight-zlib/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;tight-&gt;gradient, &quot;vnc-tight-=
gradient/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.tight.tight,=C2=A0 =C2=A0 &qu=
ot;vnc-tight/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.tight.zlib,=C2=A0 =C2=A0 =C2=
=A0&quot;vnc-tight-zlib/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.tight.gradient, &quot;vnc-tig=
ht-gradient/%p&quot;, sioc);<br>
=C2=A0#ifdef CONFIG_VNC_JPEG<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;tight-&gt;jpeg,=C2=A0 =C2=A0 =C2=A0&=
quot;vnc-tight-jpeg/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.tight.jpeg,=C2=A0 =C2=A0 =C2=
=A0&quot;vnc-tight-jpeg/%p&quot;, sioc);<br>
=C2=A0#endif<br>
=C2=A0#ifdef CONFIG_PNG<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;tight-&gt;png,=C2=A0 =C2=A0 =C2=A0 &=
quot;vnc-tight-png/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.tight.png,=C2=A0 =C2=A0 =C2=
=A0 &quot;vnc-tight-png/%p&quot;, sioc);<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;zlib.zlib,=C2=A0 =C2=A0 =C2=A0 &quot=
;vnc-zlib/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;zrle-&gt;zrle,=C2=A0 =C2=A0 =C2=A0 &=
quot;vnc-zrle/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;zrle-&gt;fb,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;vnc-zrle-fb/%p&quot;, sioc);<br>
-=C2=A0 =C2=A0 buffer_init(&amp;vs-&gt;zrle-&gt;zlib,=C2=A0 =C2=A0 =C2=A0 &=
quot;vnc-zrle-zlib/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.zlib.zlib,=C2=A0 =C2=A0 =C2=
=A0 &quot;vnc-zlib/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.zrle.zrle,=C2=A0 =C2=A0 =C2=
=A0 &quot;vnc-zrle/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.zrle.fb,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;vnc-zrle-fb/%p&quot;, sioc);<br>
+=C2=A0 =C2=A0 buffer_init(&amp;vc-&gt;worker.zrle.zlib,=C2=A0 =C2=A0 =C2=
=A0 &quot;vnc-zrle-zlib/%p&quot;, sioc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (skipauth) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vs-&gt;auth =3D VNC_AUTH_NONE;<br>
@@ -3295,11 +3282,6 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSo=
cket *sioc,<br>
=C2=A0 =C2=A0 =C2=A0VNC_DEBUG(&quot;Client sioc=3D%p ws=3D%d auth=3D%d suba=
uth=3D%d\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sioc, websocket, vs-=
&gt;auth, vs-&gt;subauth);<br>
<br>
-=C2=A0 =C2=A0 vs-&gt;lossy_rect =3D g_malloc0(VNC_STAT_ROWS * sizeof (*vs-=
&gt;lossy_rect));<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; VNC_STAT_ROWS; ++i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vs-&gt;lossy_rect[i] =3D g_new0(uint8_t, VNC_S=
TAT_COLS);<br>
-=C2=A0 =C2=A0 }<br></blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
-<br>
=C2=A0 =C2=A0 =C2=A0VNC_DEBUG(&quot;New client on socket %p\n&quot;, vs-&gt=
;sioc);<br>
=C2=A0 =C2=A0 =C2=A0update_displaychangelistener(&amp;vd-&gt;dcl, VNC_REFRE=
SH_INTERVAL_BASE);<br>
=C2=A0 =C2=A0 =C2=A0qio_channel_set_blocking(vs-&gt;ioc, false, NULL);<br>
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc<br>
index 2ef7501d52165f80fd6af8aab8e7d7097b283399..68d28f58b7ef3a96a149a740b3f=
90b641ec80f40 100644<br>
--- a/ui/vnc-enc-zrle.c.inc<br>
+++ b/ui/vnc-enc-zrle.c.inc<br>
@@ -62,16 +62,16 @@<br>
=C2=A0#define ZRLE_ENCODE_TILE=C2=A0 =C2=A0 =C2=A0ZRLE_CONCAT2(zrle_encode_=
tile,=C2=A0 ZRLE_ENCODE_SUFFIX)<br>
=C2=A0#define ZRLE_WRITE_PALETTE=C2=A0 =C2=A0ZRLE_CONCAT2(zrle_write_palett=
e,ZRLE_ENCODE_SUFFIX)<br>
<br>
-static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int zywrle_level);<br>
+static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL *data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, int h, int zywrle_level);<br>
<br>
=C2=A0#if ZRLE_BPP !=3D 8<br>
=C2=A0#include &quot;vnc-enc-zywrle-template.c&quot;<br>
=C2=A0#endif<br>
<br>
<br>
-static void ZRLE_ENCODE(VncState *vs, int x, int y, int w, int h,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int zywrle_level)<br>
+static void ZRLE_ENCODE(VncState *vs, VncZrle *zrle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int x, int y, int w, int h, int zywrle_level)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ty;<br>
<br>
@@ -87,16 +87,16 @@ static void ZRLE_ENCODE(VncState *vs, int x, int y, int=
 w, int h,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tw =3D MIN(VNC_ZRLE_TILE_WI=
DTH, x + w - tx);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D zrle_convert_fb(vs, tx, =
ty, tw, th, ZRLE_BPP);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ZRLE_ENCODE_TILE(vs, buf, tw, th=
, zywrle_level);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D zrle_convert_fb(vs, zrle=
, tx, ty, tw, th, ZRLE_BPP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ZRLE_ENCODE_TILE(vs, zrle, buf, =
tw, th, zywrle_level);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int zywrle_level)<br>
+static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL *data=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int w, int h, int zywrle_level)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VncPalette *palette =3D &amp;vs-&gt;zrle-&gt;palette;<br>
+=C2=A0 =C2=A0 VncPalette *palette =3D &amp;zrle-&gt;palette;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int runs =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int single_pixels =3D 0;<br>
@@ -236,7 +236,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *=
data, int w, int h,<br>
=C2=A0#if ZRLE_BPP !=3D 8<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zywrle_level &gt; 0 &amp;&amp; !(zywr=
le_level &amp; 0x80)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ZYWRLE_ANALYZE(data, data, =
w, h, w, zywrle_level, vs-&gt;zywrle.buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ZRLE_ENCODE_TILE(vs, data, w, h,=
 zywrle_level | 0x80);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ZRLE_ENCODE_TILE(vs, zrle, data,=
 w, h, zywrle_level | 0x80);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0#endif<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000007c24e40636bdc077--



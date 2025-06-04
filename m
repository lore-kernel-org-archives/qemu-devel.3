Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C556FC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 08:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMjKV-00009B-HQ; Wed, 04 Jun 2025 04:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uMjKT-00008z-8Z
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:18:33 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uMjKR-0006Vc-EC
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:18:33 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so6062571cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 01:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749025110; x=1749629910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EM368NjXoZgbTQsCG18CyhxuaOCHYWvrjy93GJRMkf8=;
 b=jhWOQyi9obS3x2YPeym/gBl9uLflGBkMlFZ1Crv4Nsoo/f11H1LwAUXnMqwfUPQ4n7
 gR8xVRMljSo0/+zN1qOteTIoP8wDMoX2Ii3I0uT/6g7lVeq1AW5+HjoZg947lv4HUVYx
 CpoHyPBuajn/o2XczbdINY4zMyoqBO18howqlQSsjlyznwUfFpmvOTiKYRb/bY51gNZy
 tTxEsZrCxSaTI080ae0RUJonF4hCaqodlvATr7R6i0bYdsn6dsR9U0V8FDYzdurjuaqB
 VwoFsJh3ugf7kxOXzwfgmdoa65/1uX57km+5Ux4e950RhdfFWPR66SimL3MaMXu2tkcY
 GMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749025110; x=1749629910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EM368NjXoZgbTQsCG18CyhxuaOCHYWvrjy93GJRMkf8=;
 b=kedqx0xh+HcGxkpWUzPBtBZsJnnCViutG/DSy5tXwkdzB8nTCTkDFD5NhoDEc8whTp
 YDBAz81HHhFiltKIRVPripmWZxqwA6+od2EBom4S29E/xNUhkdoV6ZpA/gZ10seO0sxR
 Xfu3A6K3uqTWl0eX67gyuqRXSCOPNHBIQfE3bDdU/sk2EH3QwgWHrf3+eJflhYTWlkpC
 GxTx5hK6LLmRYnu7s3xPY3MbXPAVo68cKW71W+psVs/Q8XV+Cd2b/19IHlpn1GBzzLK0
 UYuMLP99v18e2K3kcfel88KMHdq14k6/JBssfudCnBFl/w+E0SHz7Xf3LYdWUUE/u+3y
 C8IA==
X-Gm-Message-State: AOJu0Yyeo7KGYBxuqWbLQWoHU3eCPy/sxhrveiUlbwXMA7fG7zwjZNc2
 gugVOfxVmk1i/vq/xuxEwU/NODvXlUHAbT6CkCveuI1vvysKnIY6PyTx7pxoNlFbzfyAAL92FdV
 A9OxMkm7eO5PwvHRhWuCg7piFjvnpr8I=
X-Gm-Gg: ASbGncv0jkl7YA+v2RMIcwYW8SPL0sToEQGm3MA4CRc2TjD+yA8LOX/63dz5dLLtOdL
 6nu6PyLvKQ/Gr473h/Ar3UQ55kAhSRbMoE9V4C1yOXDpS+Gj/71VSrAjeReM4lFy9AtxSOUrbW6
 Kk0uLpm3h7dH6TI5wrxb/5ya9gcLImNx1iMS0G4twmnkuVtV5YGHiW5NgFzgd2mlzgHQ==
X-Google-Smtp-Source: AGHT+IHiQeWJFfDQssrwwFC6bmdQHN4SgNdBz8ybOrFFKMLTObjuEidkv6FqRTdWj7noblNQyCtYoKVyUiFBRgC7+L0=
X-Received: by 2002:a05:622a:2305:b0:4a3:fcc7:c73d with SMTP id
 d75a77b69052e-4a5a58b692bmr32846911cf.49.1749025109903; Wed, 04 Jun 2025
 01:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
 <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Jun 2025 12:18:18 +0400
X-Gm-Features: AX0GCFvD4KVgckrNC7KXzX0ZDfphYBVv4e-KzHEAl48YFRS_Q3T6UERMVs85qY0
Message-ID: <CAJ+F1CLHYE7ZpiBzbawRaME4BeEFqQwP8ftWd13ypsPRUmetmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ui/vnc: Do not copy z_stream
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

Hi Akihiko

On Tue, Jun 3, 2025 at 1:19=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> vnc_worker_thread_loop() copies z_stream stored in its local VncState to
> the persistent VncState, and the copied one is freed with deflateEnd()
> later. However, deflateEnd() refuses to operate with a copied z_stream
> and returns Z_STREAM_ERROR, leaking the allocated memory.
>
> Avoid copying the zlib state to fix the memory leak.
>
> Fixes: bd023f953e5e ("vnc: threaded VNC server")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

lgtm,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I wonder if VncZlib could be created and owned exclusively by the
worker thread though.

It looks like we could drop this too:
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -201,7 +201,6 @@ static void vnc_async_encoding_end(VncState *orig,
VncState *local)
 {
     buffer_free(&local->output);
     orig->tight =3D local->tight;
-    orig->zlib =3D local->zlib;


> ---
>  ui/vnc.h          |  2 +-
>  ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
>  ui/vnc.c          | 13 ++++++++++---
>  3 files changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/ui/vnc.h b/ui/vnc.h
> index 02613aa63a170901734a04aee84abff7b58d8736..82b883bb69fa5ce331945dcff=
e25588d5fd73f50 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -340,7 +340,7 @@ struct VncState
>       *  update vnc_async_encoding_start()
>       */
>      VncTight *tight;
> -    VncZlib zlib;
> +    VncZlib *zlib;
>      VncHextile hextile;
>      VncZrle *zrle;
>      VncZywrle zywrle;
> diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
> index 900ae5b30f6bd2ddbcd797d212c010c48d451094..52e9193eab572a79733b11c89=
bde81daf01679e7 100644
> --- a/ui/vnc-enc-zlib.c
> +++ b/ui/vnc-enc-zlib.c
> @@ -48,21 +48,21 @@ void vnc_zlib_zfree(void *x, void *addr)
>
>  static void vnc_zlib_start(VncState *vs)
>  {
> -    buffer_reset(&vs->zlib.zlib);
> +    buffer_reset(&vs->zlib->zlib);
>
>      // make the output buffer be the zlib buffer, so we can compress it =
later
> -    vs->zlib.tmp =3D vs->output;
> -    vs->output =3D vs->zlib.zlib;
> +    vs->zlib->tmp =3D vs->output;
> +    vs->output =3D vs->zlib->zlib;
>  }
>
>  static int vnc_zlib_stop(VncState *vs)
>  {
> -    z_streamp zstream =3D &vs->zlib.stream;
> +    z_streamp zstream =3D &vs->zlib->stream;
>      int previous_out;
>
>      // switch back to normal output/zlib buffers
> -    vs->zlib.zlib =3D vs->output;
> -    vs->output =3D vs->zlib.tmp;
> +    vs->zlib->zlib =3D vs->output;
> +    vs->output =3D vs->zlib->tmp;
>
>      // compress the zlib buffer
>
> @@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
>              return -1;
>          }
>
> -        vs->zlib.level =3D vs->tight->compression;
> +        vs->zlib->level =3D vs->tight->compression;
>          zstream->opaque =3D vs;
>      }
>
> -    if (vs->tight->compression !=3D vs->zlib.level) {
> +    if (vs->tight->compression !=3D vs->zlib->level) {
>          if (deflateParams(zstream, vs->tight->compression,
>                            Z_DEFAULT_STRATEGY) !=3D Z_OK) {
>              return -1;
>          }
> -        vs->zlib.level =3D vs->tight->compression;
> +        vs->zlib->level =3D vs->tight->compression;
>      }
>
>      // reserve memory in output buffer
> -    buffer_reserve(&vs->output, vs->zlib.zlib.offset + 64);
> +    buffer_reserve(&vs->output, vs->zlib->zlib.offset + 64);
>
>      // set pointers
> -    zstream->next_in =3D vs->zlib.zlib.buffer;
> -    zstream->avail_in =3D vs->zlib.zlib.offset;
> +    zstream->next_in =3D vs->zlib->zlib.buffer;
> +    zstream->avail_in =3D vs->zlib->zlib.offset;
>      zstream->next_out =3D vs->output.buffer + vs->output.offset;
>      zstream->avail_out =3D vs->output.capacity - vs->output.offset;
>      previous_out =3D zstream->avail_out;
> @@ -147,8 +147,8 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, in=
t x, int y, int w, int h)
>
>  void vnc_zlib_clear(VncState *vs)
>  {
> -    if (vs->zlib.stream.opaque) {
> -        deflateEnd(&vs->zlib.stream);
> +    if (vs->zlib->stream.opaque) {
> +        deflateEnd(&vs->zlib->stream);
>      }
> -    buffer_free(&vs->zlib.zlib);
> +    buffer_free(&vs->zlib->zlib);
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index d095cd7da31e2fe0d7241894b7ed5d2cbb21f72c..59009ff61b350487153960d02=
36eb438f93e665b 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -56,6 +56,11 @@
>  #include "io/dns-resolver.h"
>  #include "monitor/monitor.h"
>
> +typedef struct VncConnection {
> +    VncState vs;
> +    VncZlib zlib;
> +} VncConnection;
> +
>  #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
>  #define VNC_REFRESH_INTERVAL_INC  50
>  #define VNC_REFRESH_INTERVAL_MAX  GUI_REFRESH_INTERVAL_IDLE
> @@ -1362,7 +1367,7 @@ void vnc_disconnect_finish(VncState *vs)
>      vs->magic =3D 0;
>      g_free(vs->zrle);
>      g_free(vs->tight);
> -    g_free(vs);
> +    g_free(container_of(vs, VncConnection, vs));
>  }
>
>  size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
> @@ -3241,11 +3246,13 @@ static void vnc_refresh(DisplayChangeListener *dc=
l)
>  static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
>                          bool skipauth, bool websocket)
>  {
> -    VncState *vs =3D g_new0(VncState, 1);
> +    VncConnection *vc =3D g_new0(VncConnection, 1);
> +    VncState *vs =3D &vc->vs;
>      bool first_client =3D QTAILQ_EMPTY(&vd->clients);
>      int i;
>
>      trace_vnc_client_connect(vs, sioc);
> +    vs->zlib =3D &vc->zlib;
>      vs->zrle =3D g_new0(VncZrle, 1);
>      vs->tight =3D g_new0(VncTight, 1);
>      vs->magic =3D VNC_MAGIC;
> @@ -3268,7 +3275,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelS=
ocket *sioc,
>  #ifdef CONFIG_PNG
>      buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
>  #endif
> -    buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
> +    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
>      buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
>      buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
>      buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
>
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


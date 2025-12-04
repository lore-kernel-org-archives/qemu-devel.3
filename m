Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C557DD1D872
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 06:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR32A-0007OR-Pk; Thu, 04 Dec 2025 01:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR328-0007OG-PT
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:41:44 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vR325-0003TD-84
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 01:41:44 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B46e7LS053372
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Dec 2025 15:41:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/tQJuHy0mgdPjdRnZBYVngCSmhs69z5f5ltulLwJ4V0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764830490; v=1;
 b=ZuPw3q9DWPMXOv/c8Bdf6QJgS6hxiNG3sZJmxT49Q5lyhU15pJ5Cz4BRDtdeeJqM
 RqME7v6qrSnapxVOZpfOj4Xz/Jck529CbtWebYoY0Xa0rSTZASFOltjEa4GwQ1Mh
 RB36hwmZSpx1BV6W9hcH+4xTLyfZv+q9N12hAqlnMEdGjiGuhoOemafs/TfP6wJ9
 nBYvb7wcUOTbhVaWcVRMvbSNmMXlUca0XoHWn7Y/jpaJ+Ju6IoZClnyQ21p7gOkw
 5+9lgSh7V/6vtSMeKAZrHBQ1BaN+dUbXD4BtxXQliBipzz7GoNHp4cV4cinXHfwZ
 NlTK0Ly073io9RE0Mgb/jw==
Message-ID: <a3f3b84a-451d-4b41-8f32-fa96ed8a608f@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 4 Dec 2025 15:40:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/7] console: rename `d3d_tex2d` to `native`
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-4-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251203040754.94487-4-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/03 13:07, Joelle van Dyne wrote:
> In order to support native texture scanout beyond D3D, we make this more
> generic allowing for multiple native texture handle types.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   include/ui/console.h          | 22 +++++++++++++++++++---
>   include/ui/gtk.h              |  4 ++--
>   include/ui/sdl2.h             |  2 +-
>   hw/display/virtio-gpu-virgl.c | 10 +++++++---
>   ui/console.c                  |  8 ++++----
>   ui/dbus-console.c             |  2 +-
>   ui/dbus-listener.c            |  8 ++++----
>   ui/egl-headless.c             |  2 +-
>   ui/gtk-egl.c                  |  2 +-
>   ui/gtk-gl-area.c              |  2 +-
>   ui/sdl2-gl.c                  |  2 +-
>   ui/spice-display.c            |  2 +-
>   12 files changed, 43 insertions(+), 23 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 98feaa58bd..25e45295d4 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -131,6 +131,22 @@ struct QemuConsoleClass {
>       ObjectClass parent_class;
>   };
>   
> +typedef enum ScanoutTextureNativeType {
> +    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> +    SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> +} ScanoutTextureNativeType;
> +
> +typedef struct ScanoutTextureNative {
> +    ScanoutTextureNativeType type;
> +    union {
> +        void *d3d_tex2d;
> +    } u;> +} ScanoutTextureNative;

Instead, I suggest:

typedef struct ScanoutTextureNative {
     ScanoutTextureNativeType type;
     void *handle;
} ScanoutTextureNative;

...to align with the definition of struct 
virgl_renderer_resource_info_ext and 
virgl_renderer_create_handle_for_scanout(), which do not add a field for 
each type (except the one for the backward compatibility).

Regards,
Akihiko Odaki

> +
> +#define NO_NATIVE_TEXTURE ((ScanoutTextureNative){ \
> +    .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE \
> +})
> +
>   typedef struct ScanoutTexture {
>       uint32_t backing_id;
>       bool backing_y_0_top;
> @@ -140,7 +156,7 @@ typedef struct ScanoutTexture {
>       uint32_t y;
>       uint32_t width;
>       uint32_t height;
> -    void *d3d_tex2d;
> +    ScanoutTextureNative native;
>   } ScanoutTexture;
>   
>   typedef struct QemuUIInfo {
> @@ -245,7 +261,7 @@ typedef struct DisplayChangeListenerOps {
>                                      uint32_t backing_height,
>                                      uint32_t x, uint32_t y,
>                                      uint32_t w, uint32_t h,
> -                                   void *d3d_tex2d);
> +                                   ScanoutTextureNative native);
>       /* optional (default to true if has dpy_gl_scanout_dmabuf) */
>       bool (*dpy_has_dmabuf)(DisplayChangeListener *dcl);
>       /* optional */
> @@ -329,7 +345,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                               uint32_t backing_id, bool backing_y_0_top,
>                               uint32_t backing_width, uint32_t backing_height,
>                               uint32_t x, uint32_t y, uint32_t w, uint32_t h,
> -                            void *d3d_tex2d);
> +                            ScanoutTextureNative native);
>   void dpy_gl_scanout_dmabuf(QemuConsole *con,
>                              QemuDmaBuf *dmabuf);
>   void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 3e6ce3cb48..f88e2b281d 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -178,7 +178,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>                               uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t w, uint32_t h,
> -                            void *d3d_tex2d);
> +                            ScanoutTextureNative native);
>   void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>                              QemuDmaBuf *dmabuf);
>   void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
> @@ -215,7 +215,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>                                   uint32_t backing_height,
>                                   uint32_t x, uint32_t y,
>                                   uint32_t w, uint32_t h,
> -                                void *d3d_tex2d);
> +                                ScanoutTextureNative native);
>   void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
>   void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>                                 uint32_t x, uint32_t y, uint32_t w, uint32_t h);
> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index dbe6e3d973..fdefb88229 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -93,7 +93,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                                uint32_t backing_height,
>                                uint32_t x, uint32_t y,
>                                uint32_t w, uint32_t h,
> -                             void *d3d_tex2d);
> +                             ScanoutTextureNative native);
>   void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>                              uint32_t x, uint32_t y, uint32_t w, uint32_t h);
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index adf02ac22b..d0e6ad4b17 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -434,14 +434,18 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>   
>       if (ss.resource_id && ss.r.width && ss.r.height) {
>           struct virgl_renderer_resource_info info;
> -        void *d3d_tex2d = NULL;
> +        ScanoutTextureNative native = { .type = SCANOUT_TEXTURE_NATIVE_TYPE_NONE };
>   
>   #if VIRGL_VERSION_MAJOR >= 1
>           struct virgl_renderer_resource_info_ext ext;
>           memset(&ext, 0, sizeof(ext));
>           ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
>           info = ext.base;
> -        d3d_tex2d = ext.d3d_tex2d;
> +        native = (ScanoutTextureNative){
> +            .type = ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D :
> +                                    SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> +            .u.d3d_tex2d = ext.d3d_tex2d,
> +        };
>   #else
>           memset(&info, 0, sizeof(info));
>           ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
> @@ -461,7 +465,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>               info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
>               info.width, info.height,
>               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> -            d3d_tex2d);
> +            native);
>       } else {
>           dpy_gfx_replace_surface(
>               g->parent_obj.scanout[ss.scanout_id].con, NULL);
> diff --git a/ui/console.c b/ui/console.c
> index 2d00828c53..9378afd53d 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -295,7 +295,7 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
>                                            con->scanout.texture.y,
>                                            con->scanout.texture.width,
>                                            con->scanout.texture.height,
> -                                         con->scanout.texture.d3d_tex2d);
> +                                         con->scanout.texture.native);
>       }
>   }
>   
> @@ -1023,7 +1023,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                               uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t width, uint32_t height,
> -                            void *d3d_tex2d)
> +                            ScanoutTextureNative native)
>   {
>       DisplayState *s = con->ds;
>       DisplayChangeListener *dcl;
> @@ -1031,7 +1031,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>       con->scanout.kind = SCANOUT_TEXTURE;
>       con->scanout.texture = (ScanoutTexture) {
>           backing_id, backing_y_0_top, backing_width, backing_height,
> -        x, y, width, height, d3d_tex2d,
> +        x, y, width, height, native,
>       };
>       QLIST_FOREACH(dcl, &s->listeners, next) {
>           if (con != dcl->con) {
> @@ -1042,7 +1042,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
>                                                backing_y_0_top,
>                                                backing_width, backing_height,
>                                                x, y, width, height,
> -                                             d3d_tex2d);
> +                                             native);
>           }
>       }
>   }
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 85e215ef23..651f0daeaf 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -99,7 +99,7 @@ dbus_gl_scanout_texture(DisplayChangeListener *dcl,
>                           uint32_t backing_height,
>                           uint32_t x, uint32_t y,
>                           uint32_t w, uint32_t h,
> -                        void *d3d_tex2d)
> +                        ScanoutTextureNative native)
>   {
>       DBusDisplayConsole *ddc = container_of(dcl, DBusDisplayConsole, dcl);
>   
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 52e041edb0..a737752996 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -587,7 +587,7 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
>                                    uint32_t backing_height,
>                                    uint32_t x, uint32_t y,
>                                    uint32_t w, uint32_t h,
> -                                 void *d3d_tex2d)
> +                                 ScanoutTextureNative native)
>   {
>       trace_dbus_scanout_texture(tex_id, backing_y_0_top,
>                                  backing_width, backing_height, x, y, w, h);
> @@ -618,8 +618,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
>       assert(surface_width(ddl->ds) == w);
>       assert(surface_height(ddl->ds) == h);
>   
> -    if (d3d_tex2d) {
> -        dbus_scanout_share_d3d_texture(ddl, d3d_tex2d, backing_y_0_top,
> +    if (native.type == SCANOUT_TEXTURE_NATIVE_TYPE_D3d) {

s/SCANOUT_TEXTURE_NATIVE_TYPE_D3d/SCANOUT_TEXTURE_NATIVE_TYPE_D3D/

Regards,
Akihiko Odaki

> +        dbus_scanout_share_d3d_texture(ddl, native.u.d3d_tex2d, backing_y_0_top,
>                                          backing_width, backing_height, x, y, w, h);
>       } else {
>           dbus_scanout_map(ddl);
> @@ -868,7 +868,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
>   
>           /* TODO: lazy send dmabuf (there are unnecessary sent otherwise) */
>           dbus_scanout_texture(&ddl->dcl, ddl->ds->texture, false,
> -                             width, height, 0, 0, width, height, NULL);
> +                             width, height, 0, 0, width, height, NO_NATIVE_TEXTURE);
>       }
>   }
>   #endif
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index 1f6b845500..e36778bd48 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -62,7 +62,7 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
>                                   uint32_t backing_height,
>                                   uint32_t x, uint32_t y,
>                                   uint32_t w, uint32_t h,
> -                                void *d3d_tex2d)
> +                                ScanoutTextureNative native)
>   {
>       egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
>   
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index ae9239999c..7933237d45 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -239,7 +239,7 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>                               uint32_t backing_width, uint32_t backing_height,
>                               uint32_t x, uint32_t y,
>                               uint32_t w, uint32_t h,
> -                            void *d3d_tex2d)
> +                            ScanoutTextureNative native)
>   {
>       VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>   
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index cd86022d26..f2ed543d6a 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -306,7 +306,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>                                   uint32_t backing_height,
>                                   uint32_t x, uint32_t y,
>                                   uint32_t w, uint32_t h,
> -                                void *d3d_tex2d)
> +                                ScanoutTextureNative native)
>   {
>       VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
>   
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 3be17d1079..b15db86f24 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -206,7 +206,7 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
>                                uint32_t backing_height,
>                                uint32_t x, uint32_t y,
>                                uint32_t w, uint32_t h,
> -                             void *d3d_tex2d)
> +                             ScanoutTextureNative native)
>   {
>       struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
>   
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index db71e866f8..2a2285cb1f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1084,7 +1084,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
>                                             uint32_t backing_height,
>                                             uint32_t x, uint32_t y,
>                                             uint32_t w, uint32_t h,
> -                                          void *d3d_tex2d)
> +                                          ScanoutTextureNative native)
>   {
>       SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
>       EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EC2CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 19:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCk70-0004R3-Cv; Sat, 25 Oct 2025 15:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1vCk6y-0004Qp-FD
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:39:36 -0400
Received: from mail-francesouthazolkn190110001.outbound.protection.outlook.com
 ([2a01:111:f403:d207::1] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1vCk6w-0004tV-Lc
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:39:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RidZD4GCzGnInzirMj/Z8EEucFqKN4vjoOOcZqUS8L/SdRVjbuOEk2KDZliGVa86no2M5CdkiqZOaslqfI5rAVUAv00mwaQ49BVWvbZnuVaELqdpOl+UYNDk6BWXCyfCa/h+/qxogqJ+nwnsxBdTp5SMOSQcSHzGHkF5QHHwCd0BECylXCBMvMv0gsmnGlRi4cWNhvXRPqLzQzXmoPnbLY27+IbAiIG/x6YkrLsgSyjN3a+oaqVVzEE4DO8AwkfOgveU+QVB5U9as7/RT1YizsG471jNnYVa/0IcffWJTxDAUfZKfliNA9xgV2YMfUldM/DJfxME8rvsPLSvciHvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eBsOB/jeGBM57c41LzPIilkFXWvWIyCyiiu075iN7I=;
 b=m4rrdyO7U0HzN0UP7VmmtEIRh5EfxWAsqAyQN/qAmwMtEiuskk9BBItWUBqvCpsocBXYnenLrd4kT0iD5esp88OlYngKzGRU2NQLz0ogF6WJ1k46Z93hXRwQbDMOvV55ThzNq+ZfTF9gB/uUoGIq5ueJSiEQzb51IjpZWX+Hdk4HcJAXOQ7yzbeKpVi9GAz4C9gfxVxoiNgwX5rZ+i1+46Sg8qEQAjB9/C0vA8qw5nzHCuDWIEKnt3pb9u1KVTjaTPB8kTYbgDQ28rbkzJrD8PncQQlPpAlVlBjfTe0uEGvYe0rVccV3gSvlvb+BLa33SL7N9u2rDPvzIrCRPd+fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eBsOB/jeGBM57c41LzPIilkFXWvWIyCyiiu075iN7I=;
 b=nQCclOvO2gMw0Nzl22V5YJtnuUdowREZOItffGHt3oIBuHlIg8e9j7tsWv4NR1bx3e9ZU3meqwMR5zNKFWzZNKi+E/uZvYSzuwaRDOTjq/5gCi9KJi8uVTnw1mN6LgLaNYg+IJCDBJ+IBhmWYXc30fslHykf3WCAqYjYX+1esOpsdscLUQS/xC2a3j6LIc2YvRZlghFtnSNxqHfhGiQ3Na5preY1Bhtvzll8mzsG00c5tU9KwKsjFevvtYVohYXoU6L4mA2QQCt7DnyTYnlq/ky4YatCtty0xtQcVQD3km/w0bUCdpPbWhNHjQ3xS/rlQ+hhsALw8rPCqCFSQ8eQVQ==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by AS8P195MB2214.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sat, 25 Oct
 2025 19:39:31 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 19:39:31 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] ui/sdl2: Fix using GL display on macOS
Thread-Topic: [PATCH v2] ui/sdl2: Fix using GL display on macOS
Thread-Index: AQHcRecVhyuGzRbUmU6MZknMGnHLdw==
Date: Sat, 25 Oct 2025 19:39:31 +0000
Message-ID: <EF2D0DC2-C653-4DDC-B6D2-184EA737BAE7@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|AS8P195MB2214:EE_
x-ms-office365-filtering-correlation-id: 336c5db6-ef35-4ab7-264e-08de13fe37f0
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799012|8022599003|41001999006|8060799015|8062599012|31061999003|19110799012|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?OgOJuBIzSnNW3l4kjQo4O5yVpYOA0NTcY9p4sFrrKUj9yU0UeAEsbxbl0BWm?=
 =?us-ascii?Q?6e5a/HGAwYt0v8EOsyZVGswEp3TyRa2yclzouM8TzMNQrQ2UpwUjs98VfIwM?=
 =?us-ascii?Q?ZxkbNzUrZxxpZ1joXHqVjNzgksaBbSgy4Tkt5P2ekFuNd5Jh4e6n3qWjkMSf?=
 =?us-ascii?Q?d9KY2T2iHf/q0N/CuF08YxrKhza5jI/Dg8LHSzV8cq0Fyfz6z3Ts9NRelNVK?=
 =?us-ascii?Q?k+TSLwBrlKhhe23ueg4J3vk65Jl0liFRYrQKCjX/gpa46Ac0Jjmj+ZAZNa0V?=
 =?us-ascii?Q?Z77Pdf5OvHkJyjjZbeH+edrTYXWdiVPTktfvg+/xj/3T+iy3/xlvzXE05Fa5?=
 =?us-ascii?Q?YQto3qK+EI8fq6sH5czfkLbhco4r2sP+AtGGMPQl+qFG6eYv4xRrVp0mEJbU?=
 =?us-ascii?Q?WP/ypBE080GvQT5HzHW/KsTQtfPFQJan5bulkfLpvHZ0e87yOIS3OIsB+hN6?=
 =?us-ascii?Q?6Qw4tGW8U/Bo5JbfeGRwyqpe4d3bdOvzfwn5cGjWUXGxdyUP+rbreV2zLAiC?=
 =?us-ascii?Q?/+0kVs5CYsfY2eloErOAt0dVBTuest3TZC3FsM/yJDEvj/fQ4azXR21e33WL?=
 =?us-ascii?Q?cBmcbSujdasThzDgqGaMiXQ2iJpg5o52rhcmKnAyPJ4NQ/M5e92NDAVjnPFD?=
 =?us-ascii?Q?ALaBHYyUcv0ifOTdzkUob7Xh2Yn8mE4ld/L+NvRLVUVXZZmUh1YDPsSV/1Ya?=
 =?us-ascii?Q?vuIJz+Sb/F1452NY48GhYxFQgFYN5qbsYuTYCKX00irZoeDfVJ5iUwtlFWVW?=
 =?us-ascii?Q?0a6QgwmSX2jqF0xmnR9uhjYuEXZhA0vuWAlKynKVRuZ5X4Z6UQIZj6WB0UTo?=
 =?us-ascii?Q?ZKBg8yZTBfx/Wzj4YzX4Iy18BYe8rTtoBuKxtWK3ImQpLq7xE3sVwJ0UHP1J?=
 =?us-ascii?Q?1NVRgxky8+EfBmzGKI7vq6OMeSl4+v72XIVHprXBvqEnx+k0rT6oQeddBxVn?=
 =?us-ascii?Q?gmicqM69BCOYmp+VRRrNHlOa/C8dtAXqQRSI1HvaGmo8WPvdOQKKi7RhxvzF?=
 =?us-ascii?Q?SxEdfnb0NCkvvSjIe8CGV/YRR8d08Feh3dvFdsTfZAGAlELLrYak3gf5cAPl?=
 =?us-ascii?Q?Y73yca/b4zQdbXRzY1XrFsab9KLpmBFihcbdMta8Gvtn35G7+xaxDZWudr0k?=
 =?us-ascii?Q?TXyBADIkGLa5FMmSbMwnFHaSwgfUaywQpErPpDlhMyRo+tmVY/MgPqE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1zzr8POoGDUna2VoVDFUWi8bJ4xseApTwSnjTUi15tCghQ+Z6Vc3jIMk+Ajf?=
 =?us-ascii?Q?DxxnZVbNfZvsrZTEQwEK7gKON33rqWMSIgWu0unaY+0scINMpWaG3wVlFLSm?=
 =?us-ascii?Q?IfwUV7lXRAnTbuko1tj/y/aQwVQBP0/4rqOCfH64dPZT2iL5PZNaD1qUPBbd?=
 =?us-ascii?Q?A5NkiwcU/+y7C+wuCxlxf8O96o6RAfaU1RNdBYv+PVxQWtUb9YwFf2nAE1xc?=
 =?us-ascii?Q?qZx7A5TwCrgC0kFGdt9oHJE5slHo8fCgAnXjzNgRqrlRY0DU5NgjqyWZKNNY?=
 =?us-ascii?Q?vbP11y3y/HQKk++rAQLi+pNKQwkow4WZJQRJUeyV7s2BcaLUezMFbrs8A4Gp?=
 =?us-ascii?Q?LDXbewE8kLZVW8q9VdH3dOVIs7BnKyF+rU6IKNPrAAKvldLl9pifGtewIvJ4?=
 =?us-ascii?Q?h+Hl0Wfu7nCcfsy5vNHZKA2Os6szSu+haF+RMciLJ5gAT1LMAshRf9Fumcfd?=
 =?us-ascii?Q?QvSaIBInuXdqlne7fWSTngQDcq39v7gEabmeu1Ca29QGv9Kw3C0TOXVkG0bm?=
 =?us-ascii?Q?MaYnyILGnaQLhczqbre5u5hvfqYioucOHLylNM3j+f2NkppxbmCWsa66P0DT?=
 =?us-ascii?Q?sv42F1rDlnvr6mGjpIoZCA8+uiSpJLgrSbkyG4yafsmjdyFpDxxYPa+bRQOx?=
 =?us-ascii?Q?jlEzy9g9DGJYcAsQbB5ipH0E6/rvGjcbI0OSxAFJNkedIpSJLwZAaeGEQD6/?=
 =?us-ascii?Q?YOMuv9aD4nwr8ftCzUBpfNezzbmNOB+sAs2m7rBkqI1dcWMcUXb9C1LD8eHd?=
 =?us-ascii?Q?J7JfLKn4UEttrp4xYrMTHhHFnyoQ9fhe4bqBDUm/vp2cwiTIL5ZV7AfP0wp+?=
 =?us-ascii?Q?5r7/bGKBHC5W5QBDxgV0JIyuoNA56FMTRLIvWbLwblLUKlEgoYHq8dz+48m1?=
 =?us-ascii?Q?MJbp5m7pbpTjvUt7dK9r1e0rwo/Z2GCELyiJD+RKSVbpHdsnss5wC0p5ny3w?=
 =?us-ascii?Q?HCmd6DgIU9RYMKBb+glVp/cW9w5FtAIUpUtKX56oE0rJl7GXusdHMl1f2IQT?=
 =?us-ascii?Q?t7nE1SxPKYqTX6LnMySJvFvyBOfHlOc8tkHbygUHk/WCPyCVHq0hegKVdTwD?=
 =?us-ascii?Q?qHYgiHRzbGWDel/8VjoPR0UqbUiaXR13Ifpd/3b2o+BFc4m9yKbf2xQ+tCYv?=
 =?us-ascii?Q?OaF8yu5WsoftpYi5vwufsCYN+AUoM8e+xiBxmckOomEmW7lgrtVxE/vvgCET?=
 =?us-ascii?Q?djkMcNzWe7OO4n562WVT+CVBl5yjlvHUjgNtTczj3Wyse/rRDoqYbZkM+Rus?=
 =?us-ascii?Q?8cHOw7RpPraTLK+Np7lZ9w5vdMmHi1H9fs7L10hhmCfUN1kVJ1jP0HzKnCXz?=
 =?us-ascii?Q?cm0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <810F72D6D0036241B1619886BF0F9FD3@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 336c5db6-ef35-4ab7-264e-08de13fe37f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 19:39:31.4100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2214
Received-SPF: pass client-ip=2a01:111:f403:d207::1;
 envelope-from=mohd.akram@outlook.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SDL_GL_CONTEXT_PROFILE_MASK needs to be set before creating the window
so that SDL can load the ANGLE library for GL ES support. The shader
source version also needs to match the library used. Avoid falling back
to GL ES on macOS since it will not be available if ANGLE was not the
library loaded initially.
---
 ui/sdl2-gl.c                     | 14 ++++++--------
 ui/sdl2.c                        |  8 ++++++++
 ui/shader.c                      | 14 ++++++++++++--
 ui/shader/texture-blit-flip.vert |  2 --
 ui/shader/texture-blit.frag      |  2 --
 ui/shader/texture-blit.vert      |  2 --
 6 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 3be17d107..7ec720fb6 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -30,6 +30,10 @@
 #include "ui/input.h"
 #include "ui/sdl2.h"
=20
+#ifdef CONFIG_DARWIN
+#include <TargetConditionals.h>
+#endif
+
 static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanout)
 {
     if (scon->scanout_mode =3D=3D scanout) {
@@ -147,14 +151,6 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dgc=
,
     SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
=20
     SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
-    if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON ||
-        scon->opts->gl =3D=3D DISPLAY_GL_MODE_CORE) {
-        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                            SDL_GL_CONTEXT_PROFILE_CORE);
-    } else if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
-        SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
-                            SDL_GL_CONTEXT_PROFILE_ES);
-    }
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
     SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
=20
@@ -163,11 +159,13 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *dg=
c,
     /* If SDL fail to create a GL context and we use the "on" flag,
      * then try to fallback to GLES.
      */
+#if !TARGET_OS_OSX
     if (!ctx && scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON) {
         SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
                             SDL_GL_CONTEXT_PROFILE_ES);
         ctx =3D SDL_GL_CreateContext(scon->real_window);
     }
+#endif
     return (QEMUGLContext)ctx;
 }
=20
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 032dc14bc..426cafb25 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -96,6 +96,14 @@ void sdl2_window_create(struct sdl2_console *scon)
 #ifdef CONFIG_OPENGL
     if (scon->opengl) {
         flags |=3D SDL_WINDOW_OPENGL;
+        if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON ||
+            scon->opts->gl =3D=3D DISPLAY_GL_MODE_CORE) {
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_CORE);
+        } else if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
+        }
     }
 #endif
=20
diff --git a/ui/shader.c b/ui/shader.c
index ab448c41d..4ac5a3381 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -153,10 +153,20 @@ QemuGLShader *qemu_gl_init_shader(void)
 {
     QemuGLShader *gls =3D g_new0(QemuGLShader, 1);
=20
+    const char *fmt =3D "#version %s\n%s";
+    const char *version =3D epoxy_is_desktop_gl() ? "140" : "300 es";
+
+    g_autofree const char *blit_vert_src =3D g_strdup_printf(
+        fmt, version, texture_blit_vert_src);
+    g_autofree const char *blit_flip_vert_src =3D g_strdup_printf(
+        fmt, version, texture_blit_flip_vert_src);
+    g_autofree const char *blit_frag_src =3D g_strdup_printf(
+        fmt, version, texture_blit_frag_src);
+
     gls->texture_blit_prog =3D qemu_gl_create_compile_link_program
-        (texture_blit_vert_src, texture_blit_frag_src);
+        (blit_vert_src, blit_frag_src);
     gls->texture_blit_flip_prog =3D qemu_gl_create_compile_link_program
-        (texture_blit_flip_vert_src, texture_blit_frag_src);
+        (blit_flip_vert_src, blit_frag_src);
     if (!gls->texture_blit_prog || !gls->texture_blit_flip_prog) {
         exit(1);
     }
diff --git a/ui/shader/texture-blit-flip.vert b/ui/shader/texture-blit-flip=
.vert
index f7a448d22..1e4ac4c94 100644
--- a/ui/shader/texture-blit-flip.vert
+++ b/ui/shader/texture-blit-flip.vert
@@ -1,5 +1,3 @@
-#version 300 es
-
 in vec2  in_position;
 out vec2 ex_tex_coord;
=20
diff --git a/ui/shader/texture-blit.frag b/ui/shader/texture-blit.frag
index 8ed95a46b..bd296a2ff 100644
--- a/ui/shader/texture-blit.frag
+++ b/ui/shader/texture-blit.frag
@@ -1,5 +1,3 @@
-#version 300 es
-
 uniform sampler2D image;
 in  mediump vec2 ex_tex_coord;
 out mediump vec4 out_frag_color;
diff --git a/ui/shader/texture-blit.vert b/ui/shader/texture-blit.vert
index fb48d7066..ae205f637 100644
--- a/ui/shader/texture-blit.vert
+++ b/ui/shader/texture-blit.vert
@@ -1,5 +1,3 @@
-#version 300 es
-
 in vec2  in_position;
 out vec2 ex_tex_coord;
=20
--=20
2.51.0



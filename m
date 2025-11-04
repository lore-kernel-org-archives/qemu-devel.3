Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87094CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKFH-00071B-1p; Tue, 04 Nov 2025 11:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1vGKCz-0006id-3m
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:48:50 -0500
Received: from mail-10631.protonmail.ch ([79.135.106.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <startergo@protonmail.com>)
 id 1vGKCp-0002if-N0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1762274904; x=1762534104;
 bh=m8PiRNpPGb9MqMR3xD3mCobqyH9jVoDuB3GPE5WBNdg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=J+bPap0NBsBXEIswCDWW+PUjKg+hYTpJUwgVa3pUFjcwQG5jSTkPyW8s6+UNIi8hc
 nt6I7GGAq94OrK70z74CpjzXQs5rWgyWvFRl41MhBIoZnD0fot511E5SWYiaJ4959h
 qHdNSLVpUR4gDA9rLiJcmy9Gn3ai/6vXp71f5OoMityiUg0Yf0A9uOBWoHoN5lm4Ja
 Ep95df04ZjGFR5OqDOYF0xg6/EWxQfWktGzeMbVTHQtGkKP7XUAHXOf42TbGND8Ph7
 9hLGUb/EdQ2tfaYa42x27nRpFxB43sllRUTdRvg8QBWYhsA1VMpUn0vIDu7x/ALHgv
 rLvWi5slq5Cdw==
Date: Tue, 04 Nov 2025 16:48:18 +0000
To: qemu-devel@nongnu.org
From: startergo <startergo@protonmail.com>
Cc: mohd.akram@outlook.com, startergo <startergo@protonmail.com>
Subject: Re: [PATCH v3] ui/sdl2: Fix using GL display on macOS with
 improvements
Message-ID: <H77mgjukq822_nsOX2KWyOpMcXT6vh-IoFHveNUaqFyUcqqbGzC4qZbyRPZwtAnBCqceP2c3I0aK-chV_-aaWK5h99oku_luP3Y1l0Gr9uk=@protonmail.com>
In-Reply-To: <20251103202322.24813-1-startergo@protonmail.com>
References: <20251103202322.24813-1-startergo@protonmail.com>
Feedback-ID: 25315608:user:proton
X-Pm-Message-ID: f0b09cc3cb3482c94fe61f56e0a7d4e8c17907a6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.31;
 envelope-from=startergo@protonmail.com; helo=mail-10631.protonmail.ch
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Subject: Re: [PATCH v3] ui/sdl2: Fix using GL display on macOS with improve=
ments

Please disregard this v3 patch. After discussion with Mohamed Akram, I'm=20
withdrawing this submission due to authorship confusion.

Mohamed's v2 patch (submitted October 25) should proceed as the correct=20
minimal fix for this issue. I will submit any additional enhancements as a=
=20
separate follow-up patch series after his v2 is merged.

Apologies for any confusion caused.

Best regards,
startergo




Sent with Proton Mail secure email.

On Monday, November 3rd, 2025 at 3:23 PM, startergo <startergo@protonmail.c=
om> wrote:

> SDL_GL_CONTEXT_PROFILE_MASK needs to be set before creating the window
> so that SDL can load the ANGLE library for GL ES support. The shader
> source version also needs to match the library used. Avoid falling back
> to GL ES on macOS since it will not be available if ANGLE was not the
> library loaded initially.
>=20
> Enhancements in v3:
> - Add better error handling and diagnostics
> - Add GL context validation after creation
> - Improve shader version detection for better compatibility
> - Add conditional precision qualifiers for GLES vs GL
> - Add runtime ANGLE detection
> - Improve code comments and documentation
> - Fix potential memory issues with shader compilation
> - Add trace points for debugging
>=20
> Signed-off-by: Mohamed Akram mohd.akram@outlook.com
>=20
> ---
> ui/sdl2-gl.c | 54 ++++++++++++++++++++++-----
> ui/sdl2.c | 18 +++++++++
> ui/shader.c | 64 ++++++++++++++++++++++++++++++--
> ui/shader/texture-blit-flip.vert | 2 -
> ui/shader/texture-blit.frag | 2 -
> ui/shader/texture-blit.vert | 2 -
> ui/trace-events | 7 ++++
> 7 files changed, 130 insertions(+), 19 deletions(-)
>=20
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 3be17d1..1db85d2 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -30,6 +30,11 @@
> #include "ui/input.h"
> #include "ui/sdl2.h"
>=20
> +#ifdef CONFIG_DARWIN
> +#include <TargetConditionals.h>
>=20
> +#endif
> +#include "trace.h"
> +
> static void sdl2_set_scanout_mode(struct sdl2_console *scon, bool scanout=
)
> {
> if (scon->scanout_mode =3D=3D scanout) {
>=20
> @@ -147,27 +152,56 @@ QEMUGLContext sdl2_gl_create_context(DisplayGLCtx *=
dgc,
> SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>=20
>=20
> SDL_GL_SetAttribute(SDL_GL_SHARE_WITH_CURRENT_CONTEXT, 1);
> - if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON ||
>=20
> - scon->opts->gl =3D=3D DISPLAY_GL_MODE_CORE) {
>=20
> - SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> - SDL_GL_CONTEXT_PROFILE_CORE);
> - } else if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
>=20
> - SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> - SDL_GL_CONTEXT_PROFILE_ES);
> - }
> +
> + /*
> + * Note: SDL_GL_CONTEXT_PROFILE_MASK should be set before window creatio=
n
> + * (see sdl2_window_create) so SDL can load the correct GL library (ANGL=
E
> + * for ES support on macOS). Setting it here only affects shared context=
s.
> + */
> +
> SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, params->major_ver);
>=20
> SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, params->minor_ver);
>=20
>=20
> ctx =3D SDL_GL_CreateContext(scon->real_window);
>=20
>=20
> - /* If SDL fail to create a GL context and we use the "on" flag,
> - * then try to fallback to GLES.
> + if (ctx) {
> + /* Validate the created context */
> + SDL_GL_MakeCurrent(scon->real_window, ctx);
>=20
> + int profile =3D 0;
> + SDL_GL_GetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, &profile);
> +
> + trace_sdl2_gl_context_created(profile, params->major_ver,
>=20
> + params->minor_ver);
>=20
> +
> + /* Check if ANGLE is being used */
> + const char *renderer =3D (const char *)glGetString(GL_RENDERER);
> + if (renderer && strstr(renderer, "ANGLE")) {
> + trace_sdl2_gl_using_angle(renderer);
> + }
> + } else {
> + const char *err =3D SDL_GetError();
> + warn_report("Failed to create GL context (v%d.%d): %s",
> + params->major_ver, params->minor_ver,
>=20
> + err ? err : "unknown error");
> + }
> +
> + /*
> + * If SDL fail to create a GL context and we use the "on" flag,
> + * then try to fallback to GLES. On macOS, this will not work because
> + * SDL must load ANGLE at window creation time for ES support. If the
> + * Core profile was requested initially, ANGLE was not loaded and this
> + * fallback will fail.
> */
> +#if !TARGET_OS_OSX
> if (!ctx && scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON) {
>=20
> SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> SDL_GL_CONTEXT_PROFILE_ES);
> ctx =3D SDL_GL_CreateContext(scon->real_window);
>=20
> + if (ctx) {
> + trace_sdl2_gl_fallback_to_es();
> + }
> }
> +#endif
> return (QEMUGLContext)ctx;
> }
>=20
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 032dc14..5522bcc 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -34,6 +34,7 @@
> #include "system/system.h"
> #include "qemu/log.h"
> #include "qemu-main.h"
> +#include "trace.h"
>=20
> static int sdl2_num_outputs;
> static struct sdl2_console *sdl2_console;
> @@ -96,6 +97,23 @@ void sdl2_window_create(struct sdl2_console *scon)
> #ifdef CONFIG_OPENGL
> if (scon->opengl) {
>=20
> flags |=3D SDL_WINDOW_OPENGL;
> +
> + /*
> + * Set GL context profile before creating the window.
> + * This is critical on macOS where SDL needs to know which GL library
> + * to load: the native OpenGL framework (for Core profile) or ANGLE
> + * (for ES profile). This cannot be changed after window creation.
> + */
> + if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ON ||
>=20
> + scon->opts->gl =3D=3D DISPLAY_GL_MODE_CORE) {
>=20
> + SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> + SDL_GL_CONTEXT_PROFILE_CORE);
> + trace_sdl2_gl_request_core_profile();
> + } else if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
>=20
> + SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
> + SDL_GL_CONTEXT_PROFILE_ES);
> + trace_sdl2_gl_request_es_profile();
> + }
> }
> #endif
>=20
> diff --git a/ui/shader.c b/ui/shader.c
> index ab448c4..9a19ed4 100644
> --- a/ui/shader.c
> +++ b/ui/shader.c
> @@ -26,6 +26,8 @@
> */
> #include "qemu/osdep.h"
> #include "ui/shader.h"
> +#include "ui/shader/texture-blit-frag.h"
> +#include "qemu/error-report.h"
>=20
> #include "ui/shader/texture-blit-vert.h"
> #include "ui/shader/texture-blit-flip-vert.h"
> @@ -153,12 +155,68 @@ QemuGLShader *qemu_gl_init_shader(void)
> {
> QemuGLShader gls =3D g_new0(QemuGLShader, 1);
>=20
> + /
> + * Detect GL version and set appropriate shader version.
> + * Desktop GL: Use GLSL 1.40 (OpenGL 3.1) for broad compatibility
> + * ES: Use GLSL ES 3.00 (OpenGL ES 3.0)
> + */
> + bool is_desktop =3D epoxy_is_desktop_gl();
> + const char version =3D is_desktop ? "140" : "300 es";
> +
> + /
> + * Add precision qualifiers for GLES (required), but not for desktop GL
> + * where they may cause warnings on some drivers.
> + */
> + const char precision =3D is_desktop ? "" : "precision mediump float;\n"=
;
> +
> + / Log GL context information for debugging */
> + int gl_version =3D epoxy_gl_version();
> + const char *vendor =3D (const char *)glGetString(GL_VENDOR);
> + const char *renderer =3D (const char *)glGetString(GL_RENDERER);
> + const char *gl_version_str =3D (const char )glGetString(GL_VERSION);
> +
> + info_report("Initializing shaders: %s GL %d.%d (%s / %s / %s)",
> + is_desktop ? "Desktop" : "ES",
> + gl_version / 10, gl_version % 10,
> + vendor ? vendor : "unknown",
> + renderer ? renderer : "unknown",
> + gl_version_str ? gl_version_str : "unknown");
> +
> + / Check for required GL features /
> + if (is_desktop &&
> + !epoxy_has_gl_extension("GL_ARB_vertex_array_object")) {
> + warn_report("GL_ARB_vertex_array_object not available, "
> + "rendering may fail");
> + }
> +
> + / Build shader source with appropriate version and precision */
> + const char *vert_fmt =3D "#version %s\n%s";
> + const char *frag_fmt =3D "#version %s\n%s%s";
> +
> + char *blit_vert_src =3D g_strdup_printf(
> + vert_fmt, version, texture_blit_vert_src);
> + char *blit_flip_vert_src =3D g_strdup_printf(
> + vert_fmt, version, texture_blit_flip_vert_src);
> + char blit_frag_src =3D g_strdup_printf(
> + frag_fmt, version, precision, texture_blit_frag_src);
> +
> + / Compile and link shader programs */
> gls->texture_blit_prog =3D qemu_gl_create_compile_link_program
>=20
> - (texture_blit_vert_src, texture_blit_frag_src);
> + (blit_vert_src, blit_frag_src);
> gls->texture_blit_flip_prog =3D qemu_gl_create_compile_link_program
>=20
> - (texture_blit_flip_vert_src, texture_blit_frag_src);
> + (blit_flip_vert_src, blit_frag_src);
> +
> + /* Clean up temporary shader source strings */
> + g_free(blit_vert_src);
> + g_free(blit_flip_vert_src);
> + g_free(blit_frag_src);
> +
> if (!gls->texture_blit_prog || !gls->texture_blit_flip_prog) {
>=20
> - exit(1);
> + error_report("Failed to compile GL shaders (GL %s %d.%d)",
> + is_desktop ? "Desktop" : "ES",
> + gl_version / 10, gl_version % 10);
> + qemu_gl_fini_shader(gls);
> + return NULL;
> }
>=20
> gls->texture_blit_vao =3D
>=20
> diff --git a/ui/shader/texture-blit-flip.vert b/ui/shader/texture-blit-fl=
ip.vert
> index f7a448d..1e4ac4c 100644
> --- a/ui/shader/texture-blit-flip.vert
> +++ b/ui/shader/texture-blit-flip.vert
> @@ -1,5 +1,3 @@
> -#version 300 es
> -
> in vec2 in_position;
> out vec2 ex_tex_coord;
>=20
> diff --git a/ui/shader/texture-blit.frag b/ui/shader/texture-blit.frag
> index 8ed95a4..bd296a2 100644
> --- a/ui/shader/texture-blit.frag
> +++ b/ui/shader/texture-blit.frag
> @@ -1,5 +1,3 @@
> -#version 300 es
> -
> uniform sampler2D image;
> in mediump vec2 ex_tex_coord;
> out mediump vec4 out_frag_color;
> diff --git a/ui/shader/texture-blit.vert b/ui/shader/texture-blit.vert
> index fb48d70..ae205f6 100644
> --- a/ui/shader/texture-blit.vert
> +++ b/ui/shader/texture-blit.vert
> @@ -1,5 +1,3 @@
> -#version 300 es
> -
> in vec2 in_position;
> out vec2 ex_tex_coord;
>=20
> diff --git a/ui/trace-events b/ui/trace-events
> index 3eba9ca..5effcc0 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -182,5 +182,12 @@ dbus_gl_gfx_switch(void *p) "surf: %p"
> dbus_filter(unsigned int serial, unsigned int filter) "serial=3D%u (<=3D =
%u)"
> dbus_can_share_map(bool share) "can_share_map: %d"
>=20
> +# sdl2-gl.c
> +sdl2_gl_context_created(int profile, int major, int minor) "profile=3D%d=
 version=3D%d.%d"
> +sdl2_gl_using_angle(const char *renderer) "renderer=3D%s"
> +sdl2_gl_fallback_to_es(void) "Falling back to OpenGL ES"
> +sdl2_gl_request_core_profile(void) "Requesting Core profile"
> +sdl2_gl_request_es_profile(void) "Requesting ES profile"
> +
> # egl-helpers.c
> egl_init_d3d11_device(void *p) "d3d device: %p"
> --
> 2.51.1


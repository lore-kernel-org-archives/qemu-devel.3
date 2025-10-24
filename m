Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72492CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 20:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNwT-0005ZC-Pp; Fri, 24 Oct 2025 15:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1vCNwS-0005Z0-CS
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:59:16 -0400
Received: from mail-northeuropeazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d200::2] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1vCNwQ-0005XD-3P
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLia5Tk8hn4A94PlGIzF0xuKKNXQ1m/av0JPi1K0IGtzi5KYYSE1nnkKpkduYm3cUT0UP7DFCSYLZZAESE1AJKLgqBtAueXneykYpgRz+6h4DoMCygaPefo82V3e6n24E5CVw1Xjrc/ZF+VTYbKYHPNta2IYNO4lmVVR0bZXlpIsSlOF4VYy4qChxKcjF7tqEDIERC3CwytkmqyT/nEAJ6nrzk8ZNvrj7OB73H1pXNMxlmyt4rry9sPPE0W7qu/I8hny3TKjXPQQyYIf7qdhrY6fCxIw8CQLgmcXSFumDXXE3Q9d7w5YlvnMlLQZLm38RZfOWAJpRzxJetaDhdiX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m3f4aRzHUrT9UZJpGXvyRw7yOnobYFJYHu9viN6O4s=;
 b=HtivufhmRdClaxlKegKV93YgqabsPqUDmBCdsyDqt7m2XtZPTBD8ivxbBQ6PbcOgGKHJCWnWA7+S0XPV4sSiC+JqA1Ylf+xzc6SWOg7IfqeOHnymyJP3B4sg2u8/UbhxgZOCmIMXMRQsKGStf7URVjCww7lexDOfumXVkmNQmiRimGqDHDGrhjvX4pncir09TpB1lluwfsWUWtHhb4cxOz4/Njc2XNOSWLqKUmczNxBqCGdZr7DOW09I3MJz5oOLe6hFt2DjVJk2hgbF/LXvuyF2Bc8nnLd92fIxr13E45Vw3E2XTc5x0v8J/mPDIaTl0GxWrDmZ+vaRmzjj+4hUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m3f4aRzHUrT9UZJpGXvyRw7yOnobYFJYHu9viN6O4s=;
 b=JCZkym/jDxNibGU+bQeRT44yNG4s7ATOQbRaUg9VFJmNCats51QQNf/f/zo9XawAobkH1BIlLERWZTrrPAFGHNSw1Zs0dGKC0VkW9B+0F4XLXY1fcRac43S6Bw3UC9XpAm5UgNcfMTxxvAPV6eZGNOw3GHwOshac/ABnuu9wHsnT+j/EiWwhUAhiR2z+ciZMXYu2Au5ksYOf6SqiDiZDO1SQ8qMd315MY71/FkiafkWIOGaQATf4XY5pILBh7jWz+XWuWIYnK1xhRObmrMl5koJ23/8UeE20nw135MsPGkG8XD/oylB8h9HRIUZeI1ueXlZ+a6zhqj0JCUzgE/eiRg==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by PR3P195MB0715.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:54:08 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:54:08 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] ui/sdl2: Fix using GL display on macOS
Thread-Topic: [PATCH] ui/sdl2: Fix using GL display on macOS
Thread-Index: AQHcRR/2heEnVOiFa0izof1DjCjp3Q==
Date: Fri, 24 Oct 2025 19:54:08 +0000
Message-ID: <37B9BDFD-B730-428A-A572-F3E91FAA5260@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|PR3P195MB0715:EE_
x-ms-office365-filtering-correlation-id: c6d69b04-990b-43e5-19a4-08de1337188b
x-microsoft-antispam: BCL:0;
 ARA:14566002|41001999006|8060799015|461199028|15080799012|8062599012|31061999003|19110799012|40105399003|51005399003|39105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?igZi5keOb0xUxFgSdBsi4RNl915SxbBEOloiKxJidmblc8H6J54K6dkwenx5?=
 =?us-ascii?Q?H8/hMmwbC8J0hgDpbUP9qacw7Esa+z/qE2+IIcgHnGij36x82Bqv2jfdk7sX?=
 =?us-ascii?Q?QL46so6gqo8ELUYYFOrKaOTDpBFunH2j2SkJAs2pb1WTNxYIi4fjN3HoO6+G?=
 =?us-ascii?Q?WDB7xJYRgbhSO1SziXZ1qKcfyodfqqB7m+MNCr3XyWHsZ3KF2QmwvGmKHh7Q?=
 =?us-ascii?Q?SaVu5sslF8R/3zntsmswmttwJbInbmgfK4jY+rYnHiBVhpjzn9BI4RZw0+Ej?=
 =?us-ascii?Q?IMoZYfij5SVftxp+mqM83TFxPK9GrpvY54ua3jEsMAspY60r9W8BJQ3/a37C?=
 =?us-ascii?Q?UUmjmH2aGc4/NGregCR/SxUhSCYZI5iq0CE8olL95+F64y5/QtlNz7IiKPF7?=
 =?us-ascii?Q?LjdT7Y7G9733uGHBl2MEfxHDWvkUe5BAaFECxzyoSpdDaRg5QOc+WYSyp5+G?=
 =?us-ascii?Q?3XplO8fAAdJU3ZgHJTP8EWShe6QK3jDH9EpQL3B9Nm31Wjdd3xJFMfLWTUzk?=
 =?us-ascii?Q?yPpLh52LjYCX+H8Nw9Ie/3fAHDFU2jYaiUy5aCyxiFPpn14ts0Rg50E4p51Z?=
 =?us-ascii?Q?SVcaDMePop0zZhLD0J56L3NVe38qg+oknixvh1EaSbJOASodz7yqvt7PoSxX?=
 =?us-ascii?Q?7a/Lzi3VtJiH/uJaOx2DL6mZR3k9IkurM7Tvy17NeQz/7A5Xr2N1VNd40h71?=
 =?us-ascii?Q?TGK8gQfWM/MUvakwa1Cy8CdVJHZXnEuNkJnABnhyk0DnwRQIOjTZkJRy+gmr?=
 =?us-ascii?Q?aovbaNQhR2goQiCbkic7f3e4YKZU10b+57m1HMOwab/pV7Kx/kEMIPRbIJiG?=
 =?us-ascii?Q?dNmlRE9zSVDQab13Em9PiBxO0Z/bCiC7xLvMQ65sri5Wx4uvx4cJVLrbTlE5?=
 =?us-ascii?Q?VWqjoUAjCnNWw1nvESLwwNbu1RtXnXpoQWpUEYGCFnd2TYUbtjKIEIJ0rIrq?=
 =?us-ascii?Q?Zsa1f6VA8eSn6EeCOFFZn2dQIuYdq5l/ItkTUTDMfuMRB/JNVCG8A0iqwgJk?=
 =?us-ascii?Q?8CpTCKyohutl8ENcdPT3XGUUs6H9+z6g7pEe+DHlpU1SZdCL+tHXC8BOLFXH?=
 =?us-ascii?Q?H9uywIJiAB/5fpExyl3w5DSEOsjSpCu6GXAhbnZdSkdjss/1T9LRKGnJjMZR?=
 =?us-ascii?Q?kqbAQh9q0rZxuUXPcR8ZbrW/+vCEGBn78TLxGg0kSJUdT4yt+RMkCYZu1Z2c?=
 =?us-ascii?Q?niu0GV6atigRZn26/9Oi+Zt83m7VHQvh1EBlnoc1Yav/PfQ5cJmoSfzbIp+l?=
 =?us-ascii?Q?5wGYWwjnKdugAn0FJczZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7HcotAcSTuWtTMfEiRmX5N5rq8eu45WyrP0IYtbSX+5rnhxBOiMydGeXHFix?=
 =?us-ascii?Q?h7BX3a/eo2zePDJm4WIsPbLYz7DAXrHijTlVhfSjvVNWHf7f8hVye4mBDdZJ?=
 =?us-ascii?Q?Awwj7UB9QxrQU7o6xTusYYVzNe56ksdHo2yPpjO6OpLI/jmBUV/6Y0W65Idm?=
 =?us-ascii?Q?ewG2g2Eh3DkKtq3Fxk+jwhVtMcKRQ1j3g+fhNKc6vK8Ua11p1IBNiEB+6Df3?=
 =?us-ascii?Q?jBWH7ewLH+CWrU7uiX0qIoh9L8RedpT51eqcidAxwwflIDAxJKg5VVcNFEzA?=
 =?us-ascii?Q?sCSg9ta7eQV6O7hqHdtxYMEEKrQnbJyDfrgiKUu8KRLSBc4kzwkcwwnUgtOO?=
 =?us-ascii?Q?yJ7i2g3wy2GNm9C8cKak0Q7UYMHYC2F+IqWKnw8bEPC3VoNAr2ims332p+wy?=
 =?us-ascii?Q?r9eGXS1UUox+F1nUvgsAviulZUH8hnERL5NH5RThw6r05tcBUwNTO65627CU?=
 =?us-ascii?Q?NoBdUjXwn16ni3S8qUJ/GjofCsE3rR00lYhwm28sv49zcBoLT/5/pPMCVQiz?=
 =?us-ascii?Q?e5rdvQHxaOWHH9OpPn2eqVorYJsLNDw3EhPsbHGiLrRCHFwrVCmOhT5atcjL?=
 =?us-ascii?Q?51dKlgkBjtK44MDhH3RQlkXfp2q0gpvWCg34okD1V9GkTpKN5lR9uP6QpZKB?=
 =?us-ascii?Q?oxy/pQ/+Hbs5VLCgg9C36QG6cXIMIoPql9JN1QJlsSPprPtIMKIDuEXnwhrG?=
 =?us-ascii?Q?LaHHqngn0ipBvd8OfGJLVXWgfWAEfSzzjhvg+cLGFlSOKLls3V3yZe0iDr+i?=
 =?us-ascii?Q?eizxidjwHRmCnBsjZC1YaVXRIQBzm9M0v/MsBYkZJEXQJnRkTwsuCXUy0ocq?=
 =?us-ascii?Q?kacukL/wvCCEVov1M1BuyXP9N+0PnewF1SHvWR1BrpqjTQ3/gcfiD7HZpn9c?=
 =?us-ascii?Q?AK2Y3i3fZp6SzMnwviYOleowtFUbbtR32g8njkDHxwwqcNcwflU2FRWBAMnO?=
 =?us-ascii?Q?OEo3l7xL3xdpEWAXUpdq587Pfku6H0fN9ZEwRvNCZ37gQzUdOrga1FgRfSbI?=
 =?us-ascii?Q?dLp2Qq99JnivN8A1F800OFEzIT5OuluZOTdJshUbs7ez6QrJ2I7GAmYgHixY?=
 =?us-ascii?Q?Vb/g8XSr4o6yJNrUvB3Uqi5r+hrfSy+yOtiV5fdANm6ySsPVZeHkjwP651Yx?=
 =?us-ascii?Q?TnuOWwuTj4h4fjdqKRXlBJcDLOOTraDP0cPJRKmxJmsIpVkqAcC1Kh/laNjZ?=
 =?us-ascii?Q?VDlRNKd5FKyuv5TLiHi4s0AKr2ySXKCE+I9A1EPEg089+s9JiHPWjViUzHt6?=
 =?us-ascii?Q?9Jsuez2m5oZ42Ai7hKE2Fs15+vLAe+Rh/MQ48kd5XoM1yAgAMMLwsxD/u7XL?=
 =?us-ascii?Q?Vrs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41365C6ADB92C543956B2F783B659E2C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d69b04-990b-43e5-19a4-08de1337188b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 19:54:08.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0715
Received-SPF: pass client-ip=2a01:111:f403:d200::2;
 envelope-from=mohd.akram@outlook.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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
 ui/shader.c                      | 18 ++++++++++++++++--
 ui/shader/texture-blit-flip.vert |  2 --
 ui/shader/texture-blit.frag      |  2 --
 ui/shader/texture-blit.vert      |  2 --
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 3be17d107..65163a956 100644
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
+#ifndef TARGET_OS_OSX
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
index ab448c41d..445b49e20 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -153,10 +153,24 @@ QemuGLShader *qemu_gl_init_shader(void)
 {
     QemuGLShader *gls =3D g_new0(QemuGLShader, 1);
=20
+    const char *fmt =3D "#version %s\n%s";
+
+    const char *version =3D epoxy_is_desktop_gl() ? "140" : "300 es";
+
+    g_autofree const char *blit_vert_src =3D g_strdup_printf(
+        fmt, version, texture_blit_vert_src);
+
+    g_autofree const char *blit_flip_vert_src =3D g_strdup_printf(
+        fmt, version, texture_blit_flip_vert_src);
+
+    g_autofree const char *blit_frag_src =3D g_strdup_printf(
+        fmt, version, texture_blit_frag_src);
+
     gls->texture_blit_prog =3D qemu_gl_create_compile_link_program
-        (texture_blit_vert_src, texture_blit_frag_src);
+        (blit_vert_src, blit_frag_src);
     gls->texture_blit_flip_prog =3D qemu_gl_create_compile_link_program
-        (texture_blit_flip_vert_src, texture_blit_frag_src);
+        (blit_flip_vert_src, blit_frag_src);
+
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



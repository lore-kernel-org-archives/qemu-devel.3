Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15624FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHJdk-00012O-Nd; Mon, 27 Apr 2026 06:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wHJdc-00010L-DJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:56:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <benno.fuenfstueck@neodyme.io>)
 id 1wHJdZ-00068i-Ez
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:56:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ad135063so92257625e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neodyme.io; s=google; t=1777287381; x=1777892181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZRs1OCHPcx9hN6j0fIIM5Fbvz2EoRUmdAfqwfTt8RI=;
 b=cSJAwQqsX2XZZw9JEWYZCSVDA4fDzSXoKT/pGNyQAdpBTxezwp6aZLzCPkaAKQV2aV
 5siQ0DtfibqkluuiAL78YAeBZ8IkMz6tehj9ntaaZqxt3F8eXefPTDDhZlHs5OgnYR4A
 A9XEEOuansky1wmvxqIFiT11EmokrxT5u6U3zIQnfWtjxQ1ZlI5w/7bRzigk94x+bZ18
 S5a0BTO8NlwtLsq9a+1yrJF413LHrFroqbEB2L1OdOhIJaUk8j1RbVsz1B0Z2uge0GR1
 YNoZbW9Z+fq9Sj7S2La/JyPqgVtovWviOgkq+rDbFODIaFpSqYPWRt9GUq4lB1KRXkQP
 ol8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777287381; x=1777892181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZRs1OCHPcx9hN6j0fIIM5Fbvz2EoRUmdAfqwfTt8RI=;
 b=H+idlUK8mmxToXrxgHA29CYLVW2rRtkwf8uHjrJ4Ux/7gI97/JNXgsZkubtpoa47D5
 04DPCjmn/+Vak9FHJfFG64yWiNnNgqG8mNOwX9YGy/PecHGK+JZ3D3+AmDlK08U76Df3
 HICpMJYshSs47e5To9+6RzbHtG6VOVdDJHLi9CqzDEdzpOPceBB0SHSDdgATqiRhIBhP
 WkhVtvxU3c5debrI7MuiVLHifGrXwIts4UJ6EOJz2mEaRH+XvawYTtXOdWA4K9P2f0D8
 RD7duWssHwyCeG694f4gHA8P7x9w4EydazPlyLt4iXtfs6ouTo5J/Szhd9k2GlZiNCFb
 TGjg==
X-Gm-Message-State: AOJu0YyrF21PfZqzOcqzumO84HkiLO8mLRoMh8E1DJCoi6yXXllFzZ2w
 cvnuAZ5wsczFk+RrmMTAyCN+ycYXh31aBCHfv526zRAus+kdb+/kn6SsCEqm9VtfaBynVOXj4Au
 ZTdr6+Ui6wwWC8+gsG0h/ff5EQ6nUPOqYlGlVNSUt7U0g7WK+4SfNGY5KKacUP4Y1mlzMLrlcLi
 g=
X-Gm-Gg: AeBDieuKtTq94H3SGPy9iJt6MGWTpzM9i9GI/cJx0B3YVSj8SnB0xyp2sTXrB+npEhA
 iqV7SUtcEXmQ/z2Z+vQyxleyk/5WH8NpQ1JvqMaNl6WyTSaCpeZGdzxNMrV7yFmXPCAahQKl6ID
 Xd/GNwMtqavnJAQjFtldp8HbjWuJb9a70UreGDx150wIkaORFm7f+Hc87tNDWvnSpdG2GH3Kwc8
 PnjnsDIWLf3R3penKT6tJvfJBEmFEnycVc50g4vwNtbAEwdlI2eW5qZ4ZlEmL3iug1P5q38sj7N
 aZR/K14Mne2g8XGBUFEefh+h5Swx8cQVhEmQ68AV7BslWnY++vfWVL8pxbcE6nbZtRfaebdJPVZ
 RM+i2zwhmhokKMmySkYGevOzrc2mfZvpzNfAGpqCOg/jffLOaZbgYXZlT642bmWS0HIz3yAvcy6
 cGnPBm5ZrYBy2VbLLHaRTC25VHFLIuTTQdtIINuAyvXaSt8g4DF4DsJ1zc993JsdlJWQ==
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id
 5b1f17b1804b1-48a55743e96mr391725165e9.7.1777287380641; 
 Mon, 27 Apr 2026 03:56:20 -0700 (PDT)
Received: from i-cube.net ([2003:a:1211:8e00:481b:c50e:1a28:4b5a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891978ef6bsm263372245e9.4.2026.04.27.03.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 03:56:20 -0700 (PDT)
From: =?UTF-8?q?Benno=20F=C3=BCnst=C3=BCck?= <benno.fuenfstueck@neodyme.io>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Benno=20F=C3=BCnfst=C3=BCck?= <benno.fuenfstueck@neodyme.io>
Subject: [PATCH v2] virtio-gpu: fix inverted mouse cursor
Date: Mon, 27 Apr 2026 12:54:00 +0200
Message-ID: <20260427105531.75701-1-benno.fuenfstueck@neodyme.io>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=benno.fuenfstueck@neodyme.io; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>

This is a fix for a bug in virglrenderer, where if the guest uses hardware =
mouse cursor acceleration then the mouse cursor can end up being a resource=
 with the flag Y_0_TOP set.
But virglrenderer does not honor this flag when reading the cursor data.
This has been fixed in current virglrenderer master.
For older virglrenderer, we need to make sure to flip the cursor data such =
that display clients render it correctly.

For example, this fixes mouse cursor rendering for wlroots-based window man=
agers (like Sway) in Linux guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2315
Signed-off-by: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>
---
Now with a version check, since the fix for this is in virlglrenderer maste=
r so I think it is any version newer than the current one (which is 1.3.0).
I copied the code from virtio-gpu-virgl.c for the version check for simplic=
ty, if I should instead move that code for some DRY feel free to say so.

 hw/display/virtio-gpu-gl.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c466..6505a84f5e 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -26,6 +26,25 @@
=20
 #include <virglrenderer.h>
=20
+/*
+ * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixe=
d
+ * in 1.1.0. Undefine bugged version of the macro and provide our own.
+ */
+#if defined(VIRGL_CHECK_VERSION) && \
+    VIRGL_VERSION_MAJOR =3D=3D 1 && VIRGL_VERSION_MINOR < 1
+#undef VIRGL_CHECK_VERSION
+#endif
+
+#ifndef VIRGL_CHECK_VERSION
+#define VIRGL_CHECK_VERSION(major, minor, micro) \
+    (VIRGL_VERSION_MAJOR > (major) || \
+     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR > (minor) |=
| \
+     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR =3D=3D (min=
or) && \
+     VIRGL_VERSION_MICRO >=3D (micro))
+#endif
+
+#define VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX (!VIRGL_CHECK_VERSION(1, 3, 1))
+
 static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
                                              struct virtio_gpu_scanout *s,
                                              uint32_t resource_id)
@@ -33,6 +52,11 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *=
g,
     VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
     uint32_t width, height;
     uint32_t pixels, *data;
+#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
+    bool y_0_top =3D true;
+    int ret;
+    struct virgl_renderer_resource_info info;
+#endif
=20
     if (gl->renderer_state !=3D RS_INITED) {
         return;
@@ -49,8 +73,29 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *=
g,
         return;
     }
=20
+#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
+    memset(&info, 0, sizeof(info));
+    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
+    if (ret =3D=3D 0) {
+        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
+    }
+#endif
+
     pixels =3D s->current_cursor->width * s->current_cursor->height;
+#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
+    if (y_0_top) {
+        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
+    } else {
+        uint32_t *dst =3D s->current_cursor->data;
+        for (uint32_t y =3D 0; y < height; y++) {
+            memcpy(dst + y * width,
+                   data + (height - 1 - y) * width,
+                   width * sizeof(uint32_t));
+        }
+    }
+#else
     memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
+#endif
     free(data);
 }
=20
--=20
2.51.2


--=20
Neodyme AG
Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |=C2=A0
85748 Garching b.M=C3=BCnchen
Postanschrift:=C2=A0=E2=80=8BRosenthaler Stra=C3=9Fe 72a |=C2=A0=E2=80=8B10=
119=20
Berlin

Registergericht / Registry court: M=C3=BCnchen, HRB 269168
Vorstand /=20
Management Board: Thomas Lambertz | Tobias Madl
Aufsichtsratsvorsitzender /=20
Chairman of the Supervisory Board: Hendrik Hofstadt






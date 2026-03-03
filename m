Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF08EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVT-0007pD-7O; Tue, 03 Mar 2026 08:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPV9-0007RF-NR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:36 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPUz-0000Nj-9J
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:22 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 623D90Jd018783
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 22:09:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S4C+88C0SUBLbaqYPf8jQpMtM8zDaqeRVmdrCn0YM0E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772543351; v=1;
 b=qGGG8VJIhKGLVzdl+BWacpss+4QJVA00y7F1fL1436l7b76DfnHPBeoeLyacEcqt
 Ei21zRCCMeiDRpiIGuDscDksAS/+BMdaHn2emFQ/x7noT+MyvijyZuWoesIh6Ft0
 i9JzT4wLE7LDnWAgO7kuVx7G0NQPxLL2p9TVtqUi4A2NjwEmNwUFELYjf1/2JW2S
 PQCqHVaM4x+2JVICMXZPGXNNIFAKi8cfahDhpXJBpfo+Rn95R7sT8tVv60v4Oizx
 1h0/tMXKNctSSWpwmYC1HkCpKpiKqqum/PKSJJQnx3aqEr2kzCr0hGi6l6h6F9qG
 P+ikeCqOMkj/krvE6tfr1g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 03 Mar 2026 22:08:55 +0900
Subject: [PATCH 2/3] ui/console: Remove DisplaySurface::mem_obj
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-gl-v1-2-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
References: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Only spice uses it so move it to spice.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/spice-display.h | 1 +
 include/ui/surface.h       | 1 -
 ui/console-gl.c            | 6 ------
 ui/spice-display.c         | 9 ++++++++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 690ece73801e..a382553fa8e3 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -121,6 +121,7 @@ struct SimpleSpiceDisplay {
     QEMUBH *gl_unblock_bh;
     QEMUTimer *gl_unblock_timer;
     QemuGLShader *gls;
+    GLuint gl_surface_mem_obj;
     int gl_updates;
     bool have_scanout;
     bool have_surface;
diff --git a/include/ui/surface.h b/include/ui/surface.h
index 006b1986bb95..f16f7be8be81 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -22,7 +22,6 @@ typedef struct DisplaySurface {
     GLenum glformat;
     GLenum gltype;
     GLuint texture;
-    GLuint mem_obj;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 22e9787c4156..73be35c1fc78 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -185,12 +185,6 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
     }
     glDeleteTextures(1, &surface->texture);
     surface->texture = 0;
-#ifdef GL_EXT_memory_object_fd
-    if (surface->mem_obj) {
-        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
-        surface->mem_obj = 0;
-    }
-#endif
 }
 
 void surface_gl_setup_viewport(QemuGLShader *gls,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 28399f8a8174..789a67010522 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -950,7 +950,14 @@ static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
     } else {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
         ssd->ds->texture = texture;
-        ssd->ds->mem_obj = mem_obj;
+
+#ifdef GL_EXT_memory_object_fd
+        if (ssd->gl_surface_mem_obj) {
+            glDeleteMemoryObjectsEXT(1, &ssd->gl_surface_mem_obj);
+        }
+
+        ssd->gl_surface_mem_obj = mem_obj;
+#endif
     }
     return ret;
 }

-- 
2.53.0



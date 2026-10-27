Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C3606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l0r3d8gw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmJb-0001V5-5m; Tue, 27 Oct 2026 14:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJa-0001Uw-0h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:30 -0400
Received: from mail-dy2-x08.google.com ([2607:f8b0:4864:36::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLmJY-0007ZY-Fe
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 14:54:29 -0400
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-3678f64d078so173333eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793127267; x=1793732067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0xdUelrc8I+7zBA0sQy4UOI4d0EQ/9eh6GrStrVCQ10=;
 b=l0r3d8gw1snXEQy5fNSD+JBTnjeU+VeDA6hhEFxKKgG0+4osPrjJxMesP3sAI+QMe+
 UoVnLN9t6vSDjLTY5Tv2Tofx8qdpQy+JiMphLJYldZ199GCtmKdQJJLUm7TDhYEUbKMP
 iUgfBZFoALlF62UQM6k+N8sIqe+/r24aoHX1L6H2rttVAqhahsMMS4HmqBxPUYAhOdC3
 VYR7mYPWvw8b1q5sjTYAf4tcOcOSrJBOl5CBfijqaBMtIepC79EENxGklszx9qLOJib8
 XoD3i5bDhPz3WrpRn93wc9MSui39mV3ZJxgsayyLn00l2WE8yTBEQsexvX1C65VObbR3
 0goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127267; x=1793732067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xdUelrc8I+7zBA0sQy4UOI4d0EQ/9eh6GrStrVCQ10=;
 b=SM3SlWuedPwZUZXuY8YDEkvzKHVJhH1pVjhY37cGpZU5re3FFSI0GpQJmq1LitMaSZ
 AP+LAfhHpSwrP64C0xPPXjDTaPeFFcFHoTffOomtGa3dbc+4uBF6/wOLYG9wOPZoFeWA
 +d1kvWo5H3ODEeJt98aj7c/yZ8deqb/alwcSaS9Mjb7+Hm6Gnxjew8XBVHcDxUlNTCe+
 lhsmtpR8zumccl6/xN+mk8NDcwKOdYZKl7j+9T2jl7ISHgSQp4ZIqFXahXmMO6ScYDyi
 koAjj293n9IYAs084LYFmSu2tl9Wfm6ZSCwz/5JxKzdaIsiMxiQsrYM3S0wFV2vOVX/0
 8r1Q==
X-Gm-Message-State: AFq9FYI5vEHliYWn5kWWuTA8nStzPXLyN6uUzCPqLdY6UOgh5bUN/pLj
 mOpPdjsVs5grtECQ0eQTZFMPOonq6MNYCHf1/nKam8mi8E2G8uLp8fIDAUS3LGy4bTE=
X-Gm-Gg: AYBFou3wPs/0gjihHVuvFSCow6wKGmmIj3AEKhFSrFSJpqZDBvahDMRvQXdTsFmBycG
 By+BbImpfnN1Yog++C552IeR8HS7s6NFqpbGoUVvgrpa0uGg/hjK2Mk7vJYYgRojM1DmI7wdx9t
 dkOgeoTCR3dbF0/KNEQOmbA6ITFcXfVuWOSaKD5c0h5YhQ0zBBzEzf9BMHHnrWuyS9rAMj/1t4Y
 u9250YUO6+o8reiqYkrLAW/dTQm3zOCI7xSYDKtFjl7M3LHixKlK4Jsm0kG6T8U8mCBL0AJX6wO
 IUe8FvUXYo3N/BoUPzRsApMSyb2wwNVRRVBDJSkrd3D/ZVQ2BKzBLNJuhlQQMv/WTUzO3PQsZLk
 9zS/jcm00AR42S9UJWPEUP+u5TrzOXs6yuF5GJ64oFSGaGKeH6xPKx2qQYymkOVY1sYtJo0xjD2
 Ubvc3pNJtk6FV/XYuUmZi38fDBGn0bxe/BaLlVbRh+j2aAVKvcmZicXIVdt+B4j/abo7ULtO3UI
 imeyT1Uq9oG8zCDuMSJJyklR7yHIZz3+K8KOyQumv2SRL0WU42PM02OuqOhBPKWyrNJlytM54+6
 fQOROUH83fDfHsFjMb27xrAyAvf57mZxjJ7iUTtdQXnEPRPxJTzruTo6weFY4vSiUUknImrTX1c
 I61ZlPJXg2ISsBms/cDssWHNjA1tQxr1jMcMuyPJQ8vAFDa8uFaw=
X-Received: by 2002:a05:7022:7e89:b0:190:5edf:b405 with SMTP id
 a92af1059eb24-1a6cc34d4c3mr175724c88.14.1793127266784; 
 Tue, 27 Oct 2026 11:54:26 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a6da44c132sm75324c88.18.2026.10.27.11.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:54:26 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: qemu-devel@nongnu.org,
	sarkarsoumyajyoti23@gmail.com
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 2/8] ui/gtk: forward smooth scroll deltas as high-resolution
 scroll events
Date: Wed, 28 Oct 2026 00:18:51 +0530
Message-ID: <20261027184857.60775-3-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
References: <20261027184857.60775-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::8;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x08.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

For GDK_SCROLL_SMOOTH events gd_scroll_event() only looked at the sign
of the deltas and sent a single wheel button click, so any amount of
scrolling became one detent.  It also dropped the horizontal delta
whenever there was vertical movement.

Convert the deltas, which GDK reports in detents, into 1/120 detent
units and send them as scroll events on both axes.  Fractions are
carried over to the next event so slow scrolling is not lost.
Discrete GDK_SCROLL_UP/DOWN/LEFT/RIGHT events still send button
clicks.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
---
 ui/gtk.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 8d312d6a4b..9df83b6225 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1152,27 +1152,33 @@ static gboolean gd_scroll_event(GtkWidget *widget, GdkEventScroll *scroll,
         btn_horizontal = INPUT_BUTTON_WHEEL_RIGHT;
         has_horizontal = true;
     } else if (scroll->direction == GDK_SCROLL_SMOOTH) {
+        static double residual_x, residual_y;
         gdouble delta_x, delta_y;
+        int units;
+
         if (!gdk_event_get_scroll_deltas((GdkEvent *)scroll,
                                          &delta_x, &delta_y)) {
             return TRUE;
         }
 
-        if (delta_y > 0) {
-            btn_vertical = INPUT_BUTTON_WHEEL_DOWN;
-            has_vertical = true;
-        } else if (delta_y < 0) {
-            btn_vertical = INPUT_BUTTON_WHEEL_UP;
-            has_vertical = true;
-        } else if (delta_x > 0) {
-            btn_horizontal = INPUT_BUTTON_WHEEL_RIGHT;
-            has_horizontal = true;
-        } else if (delta_x < 0) {
-            btn_horizontal = INPUT_BUTTON_WHEEL_LEFT;
-            has_horizontal = true;
-        } else {
-            return TRUE;
+        residual_y += delta_y * INPUT_EVENT_SCROLL_DETENT;
+        units = (int)residual_y;
+        residual_y -= units;
+        if (units) {
+            qemu_input_queue_scroll(vc->gfx.dcl.con,
+                                    INPUT_SCROLL_AXIS_VERTICAL, units);
+        }
+
+        residual_x += delta_x * INPUT_EVENT_SCROLL_DETENT;
+        units = (int)residual_x;
+        residual_x -= units;
+        if (units) {
+            qemu_input_queue_scroll(vc->gfx.dcl.con,
+                                    INPUT_SCROLL_AXIS_HORIZONTAL, units);
         }
+
+        qemu_input_event_sync();
+        return TRUE;
     } else {
         return TRUE;
     }
-- 
2.56.0



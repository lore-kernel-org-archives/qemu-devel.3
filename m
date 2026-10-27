Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936E606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LL9oC5mJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLn4t-0006nD-Kl; Tue, 27 Oct 2026 15:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4o-0006m3-Uu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:19 -0400
Received: from mail-dy2-x09.google.com ([2607:f8b0:4864:36::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xLn4m-0003sM-3A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:43:17 -0400
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-35adc681e1aso369477eec.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793130193; x=1793734993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0xdUelrc8I+7zBA0sQy4UOI4d0EQ/9eh6GrStrVCQ10=;
 b=LL9oC5mJju1Fj2vaqXXg8a8BI7a3jA+ZOjoonUHpcYAjU3ftziE5gYY6Khz6powAw9
 6ibZce700Qtn8sZY0OXV+7vFUZI7C0Gev33afEe4s/64rGbjpt/yAKIQy5vphQUwalXs
 Ax3/Ij9BY3rEnAYtI/ELoB7zGMyxxOi+vWHbYoNlHLAxhyXs+VD9mJ12K6BS3aBqvnfu
 ajsT+QTa1+FN8uQ3c00rQNAPiYqS9v+6dBCGGXmZXgdceiWO/db9vZKFrOotbKd0Y9Fb
 Br+KRxIwQm4KyY1AnB6X3jOQCgkHSL0/i9ZBeMOa31FNJ8+nhCBcBT76pm4nPvbHXb7Q
 mVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793130193; x=1793734993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0xdUelrc8I+7zBA0sQy4UOI4d0EQ/9eh6GrStrVCQ10=;
 b=O51w2fEaViDhJiXbiga2vuqMtxZy2K8tHRsq/h05+DdfdOLSFG7hg1sdaT7UpqWKPK
 55iu7yCYzn2DINRqqpyLKcS79LpuWEAOQgvGMLy0zkeAKZbpfzQmDjo1F0kuDyxEhwMy
 4g1XTCl0k0Dq/e7PwQdM5Qvovj+6h82zC3eBJJEgSKXsnPL+/zXwgPX1V5p5SUSxYqMS
 yONZd2kfY/wVOyWeF5unzm7PHvoyYr95P5Iz/ki5X5Oof+KZNuQYtyReceSQMvgMksor
 E/wAfPcp4H2UI19uTrvcXEsNFE+izoN4y6QJ9EZNHs0MhlmNfv/Iotdx/+WOl132OEgs
 ivwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQM/fqi+spCGgKKSnLuHeVprgJt4HWsk71J123/rTQvFdCDvx7m7lWppK5Bpl+SaL8T6+C6888jUk2@nongnu.org
X-Gm-Message-State: AFq9FYI4Z+3rN3NagdCawWthCRGUUlCVU5ItSsZhzQJta1NKwEN3wMHP
 YeDwsdt4zP0VSdGO6dxlJNHIy0syQwB9zUBL4iTL4NIu2sF4aD9E2mBR
X-Gm-Gg: AYBFou01PeWzGvACbaoHRX+TfYFqO0Atf72cp4NJPfHYJAzEatPBGbri98LXES+RZch
 ROJ3w2IOKmOmaBK6eIckDBgTculQFkiKD+1I9vwnaHOF12qCL96Prb9m8goZqYAY8tELESicKvE
 wDVIooBu0Gz8sGlYGaXYGLvGGq7nJePTUoJ204D0MLybERSc1QKsgskhzWXXojkx5WRBdjwNQ+L
 N29ebEdCQsL19vmGacasxAWpe3ClFNtAJEOiIKVagT2Nwwxb29RXG3oSMniFW4JrAALfp1ekujH
 NxslFPeO83ijohf6sNh3J16UIvkzqav5jCwegQrpti9brjEDRYYaa1ITXqW1LJBphOp/gyO39+n
 Mo6mlD+1IvhV39IJTx+Lx5q8iI7Bz0OKK8lfuU5X9KffV2FM+T7ligRe/XeyXXjfoHbNL71Ch36
 5+uw8siKLE/2zfjStpO+D2sLE3sKhHRghKTUeWv8P526GHSEewI48N+9A2o8nPN+jP9Xkdvz5hA
 ClFw/GuuexZvvnCrAx0HXPfTTybBBrVelhQWUmt976ODzue/6MXYMWFJTo0Lo/F3xncc6NQOOAi
 myjybCxIYiYaul7k8X+cCa5Zhn/vv8mDoZ/IAXKu+nNBrSI6h2EQAnll2N+hwhxL8qS/y8Ohn/2
 oMJK/U2nLQi2afdjG3xrkEYqnr1ThmbVUrpTbK6akHOrBzLO2Dw==
X-Received: by 2002:a05:693c:4008:b0:369:9af5:7bcc with SMTP id
 5a478bee46e88-36a203ac768mr616302eec.8.1793130192904; 
 Tue, 27 Oct 2026 12:43:12 -0700 (PDT)
Received: from fedora.tail9bb79b.ts.net ([119.82.106.50])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a064510b0sm20446558eec.2.2026.10.27.12.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:43:12 -0700 (PDT)
From: soumyajyotisarkar23@gmail.com
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 2/8] ui/gtk: forward smooth scroll deltas as
 high-resolution scroll events
Date: Wed, 28 Oct 2026 01:12:50 +0530
Message-ID: <20261027194256.76031-3-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
References: <20261027194256.76031-1-soumyajyotisarkar23@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::9;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-dy2-x09.google.com
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
scrolling became one detent. It also dropped the horizontal delta
whenever there was vertical movement.

Convert the deltas, which GDK reports in detents, into 1/120 detent
units and send them as scroll events on both axes. Fractions are
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



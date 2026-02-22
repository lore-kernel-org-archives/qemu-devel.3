Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A55E6817A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIXP-0001k0-6M; Sun, 22 Feb 2026 18:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXN-0001jd-PH
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXM-0005wZ-8B
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48375f10628so23004355e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801610; x=1772406410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TRSLoEFEzwSsAV1OIyTMcpc9DCRIvmdEXunZ1hteP4g=;
 b=FPZHrQweBVBdM9IXymeE2ClWe74Lr5yc6h+2YyQX8/7M1YtknXfgOFAUnRzUviBnyc
 +pmLzBCoYApNlFWOOTe2diaeRe6O3XVgqqHH5xxzAoOucZfCXKS01lG3yUE4NFbDn6Um
 dpXtCxNtzh0Z/qP2qbCdVmO0SKW/QOVFM+nnB3DgHSWUmUBo/ElZz/vyNWoFw5hJ4SK5
 w6+VrR+xC5JeKpGidJ750xFJAHCSFFPfvWDJfnmzgqAyRYNtzr/eA+a+hn4hu1HEU8fP
 E15OR3pyRKHGLXfRfo5sXT09xQFzbQtOgJZVvyuOR3VjLGbo9mFdmA+PdzHIjFO/rvB4
 U8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801610; x=1772406410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TRSLoEFEzwSsAV1OIyTMcpc9DCRIvmdEXunZ1hteP4g=;
 b=ozglqpFMQTPFykVO8FlJk74m6eKXNa6eGebeJvI6GOLQg/5Y8fg1zBxXnWwf1jHwTB
 uHw2L0GZbMVkldBPiMM90l0eTTcRnhqwP43BMtNGo2T3/PVWxnfarF3pAf6Mgjov4o/U
 3jBVGD9yb7AAFlRD1w4cMjryYQt/Gmbm1lJRni2P2C2CiuV8kqCj3JQKqWbUlZX+dTjp
 PCoV2k+yQcZXSg8PgR18voigd+YJS5w/KSA6alubhwaerEIsyhU+uqNsHT5qc+qQd249
 EU/Owms1cAZrgTzltQ8KepFRoGzBxRhYujXRFsey0PS6aLayHcWQn5iUCkj3R5rDQv6q
 oPhg==
X-Gm-Message-State: AOJu0YzK9Nto/WWUj0RJvNpidNrjICes42pZ/BDXcZEvxBipfFlyxEP1
 MuDft80PSa70VXSQEJXn7RRH21hyadhreoaZjhS5D78w3ZQM9oLIuHdb1cCD9kMGT9fkscSnNRd
 /nmm458I=
X-Gm-Gg: AZuq6aLvwQNVPw5LjFHr7x+MIkGUVcnToRehZ+lRtVZZl+Agqr8tdN2tcUmxW+omvvv
 KNw4XtOSm0Yiudc2nVdEg1va6D1pemc0huxwdBAorQBvt+8EPX8h077hjkJDOZqVjijjqaSLQcb
 b8AWepRdGf/5f4VsIZahz8tXs4FgkXWN2uF2vPeLRjH2dFO2DSc+Qmt5HK1mRFgrwNhgmol4egy
 DlV5lP2JalOJlwOIH8CNRSU19jwho3jk59SLv4pQr5JUqUoISv5LAN3Lg3xgfsZcUS5p5jBJJYg
 DJZ0zl4OMttalzVeJX3qd+3EiCMj4HtfAyMijT48FSxlk7izV+lQQ3Nufzy+l2yUp/R1YpnZhFb
 ITzdEAFHXKc334HlyuxqkCgVgqgGidHrxqlqX5wNMWxT6PotAPdTCsJyMbit2iFul+6iGW5qNcr
 yWBupUQjUh5LSjTLJPj4xagH81msx+HqHYMRIszBNHjGCTpX6WpcE80USAhMErUOxEmg0AcUlP
X-Received: by 2002:a05:600c:3b0a:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-483a95be7c9mr129820765e9.13.1771801610524; 
 Sun, 22 Feb 2026 15:06:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c00d0csm15173759f8f.11.2026.02.22.15.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/20] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
Date: Mon, 23 Feb 2026 00:05:48 +0100
Message-ID: <20260222230602.5756-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
machine. Check and set it once in the MacFB DeviceRealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-5-philmd@linaro.org>
---
 hw/display/macfb.c | 4 ++++
 hw/m68k/q800.c     | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 8ef174dc6df..b8115c2be13 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -645,6 +645,10 @@ static bool macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
 {
     DisplaySurface *surface;
 
+    if (s->width == 1152 && s->height == 870) {
+        s->type = MACFB_DISPLAY_APPLE_21_COLOR;
+    }
+
     s->mode = macfb_find_mode(s->type, s->width, s->height, s->depth);
     if (!s->mode) {
         gchar *list;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b55c03a90bf..ba32da2fa45 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -563,11 +563,6 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
     qdev_prop_set_uint8(dev, "depth", graphic_depth);
-    if (graphic_width == 1152 && graphic_height == 870) {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_APPLE_21_COLOR);
-    } else {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
-    }
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
-- 
2.52.0



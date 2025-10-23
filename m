Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5459CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBl23-0004Yp-An; Wed, 22 Oct 2025 22:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1vBl1x-0004VO-9C
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:26:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetan.singh.foss@gmail.com>)
 id 1vBl1u-0003va-RS
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:26:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-290c2b6a6c2so3111065ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 19:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761186376; x=1761791176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mkUwpWC0UU/XVyIlVhLjchJb6AK9ihA3gLRbKFlOCHo=;
 b=BStmiCTGin6XFXArROcJ8GvlxiWOPFNXgciBZylFYVFrIrs5XrI9LBHFrtpA4+f/++
 aVpu83HjxXaCoZ0qio4l3y/3wtAFwyHIKx9BtMICMQII2kdgBafphFgx81k14S8FuD2W
 I4ekESzkB/oGyLtYTELDfmGVK+VshpvgdNeHoAQPyZmNntAhJwYKuXCkVRnubqSjF5uh
 8Gk91lZJv9wKFOSulCiKDLzSyetE5p3S2rwOZ0h8TX2a0V4a11ENIGZf+XzmBiZrLSiB
 Drbe+mBFAFb6AR8ywcZEVXlSZTN7xff75hQkoaGeOz9If9yBcTEk5LSTWIHfB5OQkvRk
 7eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761186376; x=1761791176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mkUwpWC0UU/XVyIlVhLjchJb6AK9ihA3gLRbKFlOCHo=;
 b=VAyjSh6rFmrhqVMFLjyP0Fh6z1qWVWQiMi+KNVBUGZJnwLbWlZf4akLGlgpw3/pq/I
 LSK4LXvihP0qrtTtWBzDrWjmwWSoHgY/didP4dR22ALUf7aRbEdU9e2HtvFcIYCji/kQ
 NHpGqPag5ZBBieU11DBm/ZUUue7gxc/EuDpuNhsV9vV2f4QZoWD+epnaDA2A6YOm9EHe
 5SUYH2cy6QS0FtyBgvvB6rADsuSF5bsivB54COzvYdkRe169hPmOYyhgpChbXqxa/QPJ
 ZS9MlzndAE3wriah0F1VuCCjQxuU/UnWaSSQ/JwQqOlJIeRygiF18FE96zg0ZH1jiuiX
 ug+w==
X-Gm-Message-State: AOJu0YyRxp/uLvHCQUV9rjuAxEIQ+B9sNcydDCNsunzDOv+KZm2ZPwJu
 Sa6curO8isXTwU2WzY2HIF2868rpfBe1M8ETPn4zuHkzUL/G7NSihPxplWkTNzquCeA=
X-Gm-Gg: ASbGncuoOCHduTFqaQktos+/Fuy2jki+C9EmB+ikSlaVJIce7qr8eTRpIMNDohplGs+
 clat7mjvlUejV0kpLQO9Rkt70PvaIkCjrRA8lUxvUc/kVmIEXOMJ0Rbrn+oSHxDF8HTZPxfL076
 DdfuOyfrsIenlgnwXHA3Ix1AZOSG1duTyCXKL0wRIzXiw4JcNWu+kytx7a9tcHb7sjjZKWfKcPa
 djMZ7TiojdYgL6pDFOr6VM8WYHYYslJiytLtsUM1aY+7sRPr4bp5f5WXe8Fzjya/EZl8VE4Tkzh
 UClqI5waL2w5rgKdSKdXVx7d0AHkX8xl46JHdNqZeSExJ2z8nUl+Bj1nbKZf31T+S6DaiU2U7o6
 quADJz4X9cQLWvdHYWGFaj/CSn9fMFD+pi7kkYD+ClzUo8m3SpVSffYOop10mgMlY6XdeiDo+P4
 A42kvWyazR+TXl91sMlEKLMqykIA==
X-Google-Smtp-Source: AGHT+IG8FCtljT51BRRML2WX+uXFsikevxoxJueuOBa1dw75uu/O72+FBvbffdU13IXeZAcF1YbdGg==
X-Received: by 2002:a17:902:ce8d:b0:282:2c52:5094 with SMTP id
 d9443c01a7336-290caf831c2mr252402065ad.37.1761186376063; 
 Wed, 22 Oct 2025 19:26:16 -0700 (PDT)
Received: from Skynet.localdomain ([2601:642:4c01:53cb:feb7:8b1d:7d2a:c810])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4c05146sm500268a12.12.2025.10.22.19.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 19:26:15 -0700 (PDT)
From: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, aodaki@rsg.ci.i.u-tokyo.ac.j, hi@alyssa.is,
 dmitry.osipenko@collabora.com, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Subject: [PATCH] docs/system: update rutabaga_gfx and gfxstream locations
Date: Wed, 22 Oct 2025 19:26:11 -0700
Message-ID: <20251023022611.11495-1-gurchetan.singh.foss@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gurchetan.singh.foss@gmail.com; helo=mail-pl1-x62d.google.com
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

Both rutabaga_gfx and gfxstream have moved to Github to facilitate
faster iteration and greater open-source collaboration.

gfxstream requires a corporate CLA so it can use Google's CI/CD
$$$.  rutabaga_gfx does not require a CLA, preferring to remove
any possible barriers to a first-class FOSS solution.

Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 0f4bb304a9..ff9d5a7103 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -119,7 +119,7 @@ Surfaceless is the default if ``wsi`` is not specified.
        hostmem=8G,wayland-socket-path=/tmp/nonstandard/mock_wayland.sock,
        wsi=headless
 
-.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _gfxstream: https://github.com/google/gfxstream
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
-.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gfx
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
-- 
2.51.1



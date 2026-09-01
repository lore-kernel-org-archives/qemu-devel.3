Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56277C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MeX-0003OP-91; Tue, 01 Sep 2026 07:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x1MeU-0003O7-NN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:27:42 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x1MeR-00072I-P4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:27:42 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 681BRF44081875
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 1 Sep 2026 20:27:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WLlccH7JTl6rVotQdxDRDEZRS5ekcp2OMvU1l6YZr+s=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788262045; v=1;
 b=Ok2HhYR1t1PG0vgfbCDgqZ5eXu8FsWnlCcHpYfdioDlR/3j/dHGEDrM0GS+4pq9N
 yRpx+AxTCXDAI3x5ONCmzwSGNJx9zXh+wbcpu3PINDfvjgaJ+cuPLuEVmLpbIse9
 d2MtxmYMX9V1FxR05I027qIwsRozRSDVgX4wzokNOQLOWGIygDtWfhyWUNY0qOxT
 IcYUaMkzuwCJZJlU9RV1qL10ii098jAhTy7m1CsWOD6voHk2fX2fIa8IR+r3c22o
 qwp4v4mICSoNF5goFCcSDYWLu3TMO7AJlnvn3F0EeDgrd/W3ubeIXZ4vHepOzuGP
 Uj8pWAh8LgJ5WLpsihDwrA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 01 Sep 2026 20:27:02 +0900
Subject: [PATCH] docs/system: virtio-gpu: Update Rutabaga link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwND3eSi/OKyXF0zUwsDI3MDQ8PkJFMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AyLgQTGoAAAA=
X-Change-ID: 20260801-crosvm-658027011cb5
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=o4ua3A2CHs8J1zpH88+O04Deg5WtSS0Yf84HKQe959A=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9a0bXO2dT+8epdXNyxrtcHxQ0HNeUd/Pt99aX3vwrlf/
 ZbUcdowdJSyMIhxMciKKbKkFO3m1oiu/VSYEN8CM4eVCWQIAxenAEwk/xcjQ1fF44efmreyy24z
 8r3YIRn38HPSqXnrpF3nXlx8w7vtmykjw0TpIMWgt7ynzy3aWcP5NUTRWSxXeWLS/py8TQ/7Vjo
 ncQEA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Rutabaga was externalized from crosvm:
https://chromium.googlesource.com/crosvm/crosvm/+/481338d967d5c8b506e17b8e335798f5cb89d7ee

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 docs/system/devices/virtio/virtio-gpu.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index d05f8cb8e3f9..8ce4da306acd 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -185,8 +185,9 @@ rendering and `Wayland display passthrough`_.  With the gfxstream rendering
 mode, GLES and Vulkan calls are forwarded to the host with minimal
 modification.
 
-The crosvm book provides directions on how to build a `gfxstream-enabled
-rutabaga`_ and launch a `guest Wayland proxy`_.
+rutabaga_gfx's documentation provides directions on how to build a
+`gfxstream-enabled rutabaga`_. The crosvm book provides directions on
+how to launch a `guest Wayland proxy`_.
 
 This device does require host blob support (``hostmem`` field below). The
 ``hostmem`` field specifies the size of virtio-gpu host memory window.
@@ -214,7 +215,7 @@ Surfaceless is the default if ``wsi`` is not specified.
 
 .. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
-.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gfx#rutabaga-c-api
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
 
 .. list-table:: Linux Host Requirements

---
base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475
change-id: 20260801-crosvm-658027011cb5

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



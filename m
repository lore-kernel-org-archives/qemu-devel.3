Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1709BC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5G8h-0001wM-Pk; Sat, 12 Sep 2026 01:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5G8W-0001vy-71
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:18:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x5G8R-0005w1-05
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:18:46 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68C5IITE089814
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 12 Sep 2026 14:18:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EePQXosuxsp1n5Nm72vaKGbLwuHIwAdMi95bQ7tiflA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789190300; v=1;
 b=WAcQSHpBjHIIbeJbqLuJIlcoKEBZs6FnSFXAlgNOgv+lpdDC+CKSbBPJaMqJ2s2K
 noqQKT2DN1dpY5ZGWEexD1pnzIR/mHJXI7vRJ1bVxOS8qmdnAbk21GNwXULH3eYp
 EivaSSJztDZqhxb4t/j//lgwGWEIt6qhnaR9jnz03sBPqhngP7O1Jm40n8Zz1E4p
 1B0QoOJP1Muj+7sF0JuGvzVziW9es2D8L2DXpuFpT+NTncfcZoxD7D6X/blydRTL
 6Te3TtyIc0haRs/Tq1IGVtowa7i8FHTAN2iMXM9Qc5j6JLBfSti8O6kPuYMGGJDN
 uJW27PuSS6cGppHNvqu37w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 12 Sep 2026 14:18:02 +0900
Subject: [PATCH v2] docs/system: virtio-gpu: Update Rutabaga links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-crosvm-v2-1-11a8c4ecff2f@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WNyw6CMBBFf4V0bZu28nTlfxgWMA4wGCnpQCMh/
 LuAC5cnOffcVTB6Qha3aBUeAzG5YQd7iQR01dCipOfOwmqb6lwbCd5xeMs0ybXNtDFQJ2KXR48
 Nfc7Qo/wxz3WPMB3rw+iIJ+eX8ymYw/tFi380GGlkEdumzjNIML7ePbcKSJGa5eRei1MVqH4U5
 bZtX8gFRUO7AAAA
X-Change-ID: 20260801-crosvm-658027011cb5
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=8inVG3IkidgxiFtFjcVA5RXX36w1IansFlHrgHki8TQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9aSB1N+fPm3jIO1uPTWxKjy2Yt2X9r9w5W5aWWYuJnM9
 28sx6ad7ShlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZhIsSUjw6uFF2xauoraejzf
 auqZVnW+ZGcT/OYndTep7a/0tb+uVYwMyx896luw6lSfhgzbiw9vqldO1goTbPh3tWH3md3Oord
 zuAA=
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

The latest code of gfxstream is now hosted on GitHub.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Update the gfxstream link to point to its GitHub repository.
- Link to v1: https://lore.kernel.org/qemu-devel/20260901-crosvm-v1-1-942fb87c5e43@rsg.ci.i.u-tokyo.ac.jp
---
 docs/system/devices/virtio/virtio-gpu.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index d05f8cb8e3f9..c5e07c60fe1a 100644
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
@@ -212,9 +213,9 @@ Surfaceless is the default if ``wsi`` is not specified.
        hostmem=8G,wayland-socket-path=/tmp/nonstandard/mock_wayland.sock,
        wsi=headless
 
-.. _gfxstream: https://android.googlesource.com/platform/hardware/google/gfxstream/
+.. _gfxstream: https://github.com/google/gfxstream
 .. _Wayland display passthrough: https://www.youtube.com/watch?v=OZJiHMtIQ2M
-.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabaga_gfx.html
+.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gfx#rutabaga-c-api
 .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
 
 .. list-table:: Linux Host Requirements

---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260801-crosvm-658027011cb5

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



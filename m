Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FCACC6B09
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGVeL-0003bi-7i; Tue, 13 Oct 2026 02:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xGVeH-0003aZ-PW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:06:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xGVeE-0001qO-8a
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:06:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e8662d5e95so13726755ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791871559; x=1792476359;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k5V9XPqBs9Hbx3fNKIKEh9J0EfokO4BTfSItLKlu0bw=;
 b=EY98aET2lr93fy9iL5mW9R5edA0lbN9F/dA/Mnh1CL+kfF2qZNEtoLcnVHQD3NiiFk
 SZBJWMbIDSw0JJJ0ml+0Bd9ddSJqrmaN89ASgoNZDY4kEcujcL2VqyBJ+EUDXi08amMo
 YLaBWGoXWY/VfxkqqHrImrQHDPAjnCCJ8ScEgjBLTU25cY7BbvFXgonSRvPdQFNct0Xp
 Vdm5kKpm0N9V7YHVkntMLx8PiE+IPNXYSvKG7F9QiwZqM7r+42Pu8KKEv5gh7wc++Fe6
 AQZiz/NiWcmOPg+SIqwilLAkmpEM/2jBVCgp+SApL36HsYSmCq0ae4Ox27yNG2FyAjDf
 dk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791871559; x=1792476359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k5V9XPqBs9Hbx3fNKIKEh9J0EfokO4BTfSItLKlu0bw=;
 b=G5sWrzCRfJ3ltlGHH/SVGiJZcRbhRsDdhjVKiesOR+bZmjdThkxTl6agdUSFPbGsuM
 XOcBYFPUAVCZk2XrsV8eJT+LYQjN3TuU9uJVzfPtYQrdytopLWPS5bzZp0vdGecqKrP+
 H0JGfNoAvIt8YpzpoouITQMTtHMWdFQY4thGghhgef6ym2ReovknBAUhmZJELVxEFBoO
 JIfvlEU+XOTd7K4lCTr/9v3qW+qec77NJ6RcLbM8rlb/kVszW+A+A0JpjAaYcULFFs3K
 Zt5sCm6FT2HaYaSlIE4CuEWieHnQcpZAROxpBSYA9kxlOpRQnepEbCVKWjYrY2S0Z5Bo
 qY8g==
X-Gm-Message-State: AFq9FYK67tox2fJGgD9ATzbaY4W7kDtNQgp3oDyvHgS9ly/QX8i9udgZ
 Ys9r4JVWgy9dRF4rxbMI82oezCdlL3c6/29K/efDnY4BlEZPWq/iwpiQ9MyIDjXd6s+Gj/Sq96Y
 ISrNtgKtmcww7+r7BuNCb4973R2Vohu3wojFu06R6P3qv+jsGiDeTjmKqI/23SMU=
X-Gm-Gg: AYBFou3yC5JjQt433YZ18K6LFP37LkOLrShPArZHx63NXqd146DLqodbELu+vSk4NGJ
 0OuUBLMUf4nHKQ56mH1G/gpaGwbcGPMSfp3tuVEW6j0UgOTiLbDNMAFxKJAlEwWveLKeKqt7EXJ
 kX04LkL9Clxl4fb+BhCQ3TSFoii4/xT3Nlyf3ZEiWTCubc0PYW6q1ne8IIlKf0GhHorJhCXDErg
 JFcn1lrllhweIvLMCtfQC3PmP0dMxZ/qV9TzUNP3f35KhWYyRkvkfbgvjLYT/py5WE8xOSIxv58
 4tlT/+jdHuhaDviEL9xMaJEnbk6tVlL9mrpfa4lDLUYRc8VZFHyCOBm7zliO+mXf4qpFMMB+I2v
 OHZUHtUckt9bpPaKY7SA4UCuSvp03aehZaNwChzGOOE4KBdf/gDyJszIELzIuKHqmDKL4Ac0NNy
 prFnn719Byyx1N7G1oYgIZdIP17hrSWB+7PtXRzuUkmb4I/NANMXhtTpn/Z9wpqmXz8ksP7Rr16
 xY=
X-Received: by 2002:a17:902:dace:b0:2df:9257:8088 with SMTP id
 d9443c01a7336-2e842e16665mr102419205ad.57.1791871558938; 
 Mon, 12 Oct 2026 23:05:58 -0700 (PDT)
Received: from 9950x ([174.136.204.24]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e1643sm51941445ad.70.2026.10.12.23.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 23:05:58 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH] block/mirror: inherit the source node discard flag in
 mirror_top
Date: Tue, 13 Oct 2026 14:05:49 +0800
Message-ID: <20261013060549.3008438-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

mirror_start_job() inserts a mirror_top filter above the source node
for both mirror and active commit jobs. Previously, the filter was
opened with BDRV_O_RDWR only, even when the source had BDRV_O_UNMAP
enabled.

The block layer checks BDRV_O_UNMAP before invoking a node's discard
callback. Without this flag on mirror_top, discard requests return
success without reaching bdrv_mirror_top_pdiscard(). Consequently,
starting a job can silently suppress guest UNMAP/TRIM requests that
would otherwise reach the discard-enabled source.

Initialize the filter's open flags with BDRV_O_RDWR and conditionally
add BDRV_O_UNMAP from bs->open_flags. Pass the resulting flags to
bdrv_new_open_driver() so that mirror_top follows the source node's
discard setting.

This allows discard requests to reach the existing filter callback,
which forwards them to the source and either tracks the affected
range in the dirty bitmap or synchronously propagates the discard
to the target, depending on the copy mode.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 block/mirror.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 089856f4a8..a551d392c6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1854,6 +1854,7 @@ static BlockJob *mirror_start_job(
     BlockDriverState *mirror_top_bs;
     bool target_is_backing;
     uint64_t target_perms, target_shared_perms;
+    int flags;
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -1886,8 +1887,13 @@ static BlockJob *mirror_start_job(
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
-    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
-                                         BDRV_O_RDWR, errp);
+    flags = BDRV_O_RDWR;
+    if (bs->open_flags & BDRV_O_UNMAP) {
+        flags |= BDRV_O_UNMAP;
+    }
+    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top,
+                                         filter_node_name,
+                                         flags, errp);
     if (mirror_top_bs == NULL) {
         return NULL;
     }
-- 
2.53.0



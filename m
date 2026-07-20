Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29701C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wliF5-0002zP-2r; Mon, 20 Jul 2026 03:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wliEm-0002xo-Dd
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:16:30 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wliEi-0001kX-Ru
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:16:27 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabe9335f1so58864245ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784531782; x=1785136582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pfScrBn38640llKJwckOWShlKCm58AeclKkJ/RdzCGw=;
 b=ZCN3swTGld0gIj9GhBRBnazVn/Uw2gXeh6KQJzlo9HIWvQ5vMYRBJcnbKtoZYr6sUl
 BBiadhgYs5Y/3IgUZF6H/yhSw00hEgV4eImpC83HSre64Bv76rq0M6ayMNB+EgG/xnmQ
 dViWettjunCKnWYUjrIdNkmP1aQi128EvW+ahGAuk7dx9/KJoka8fNTmxh90ZKNbmWb0
 ltPo8me3lq8PDWKMTYOFeobJolrp5LW0DNmSfWeax8Pvbkk40JStnik6d5pxiUzojIV0
 QpcS8pbvH/vT0J9Tb4XEVm5+n7CmnB4pP36E4LqhXnX8zymZhe2gB4MB4RnQY4eD7S3x
 QkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784531782; x=1785136582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pfScrBn38640llKJwckOWShlKCm58AeclKkJ/RdzCGw=;
 b=hGZ0eOkxfOnz2Wsa7TbhiR8GoZoZjGm7X/x/ebIjZpCKQ3BuJazTQ1l3zkTaVqbdsl
 5B4V3iGXYuiXq2mI+4GhUAZBcidTjuxiV8jT4HIV03PQ286wkzfa7P8tIhS7lNfeYXM2
 0VtypUQSuS1/xUxW0haS+5TnO+sm6RvGDYVPMGGnwW0MKrbifzpWcq/R6MOyClnLnfZL
 sFyeazl5frLI9sykh6iFNigfA6CuhbrzDHGYcO/ZYaQHFn9oFT2/MNV/o/biOHyJfLB3
 CFUD4G/8T9aBITFJt3GhTTBO8UbrUMYK1dpnVMzUkop8IwLT6/mhhqvexwO1iHaxSk8w
 63qQ==
X-Gm-Message-State: AOJu0YzBSTOfNfUE3cWxlukroaPrf8/ZsQXXO2KJYRClMyicUf8w/suq
 MzJCJvzGSIOwNwLhO4bSL7z78POILumJHwb7OJu8MofV29qm6s2tO70rYU/AAzOEcXPrY7ef
X-Gm-Gg: AfdE7ckuQcusEIAXMNmWtzNC1YbO+rZMTqWhJ3FMv7X22FxkzJ+zLqfVoEFosp7UWGb
 d6/IcCVnRDB1Dow7Ti3TyOq02xHVv0I+dDDLkGtf68kU0yIcQjN2GMWkL6c5a+vMejAeF9BuKZc
 RktLB4RUruzcE64NavWG6WEJdJpygYerSn6o9EOMJieqDskORdeD3kCuTlC/ta9++tX+oRLEw59
 nhnfLsmavu+nj/t4k8ZKiE58+JuVhaALC0G9/rhMBZVqcWy8bYUzd5HVIQRpVEcN8wtX16zVaH/
 wFM0EsNN/Lu1UU1KJ712juZ/s+blMtXv22/ume0kE+Z+lkU98M/qtHBNyuRSW6hVbCQ7wZRnFOX
 48aygHNFg2QVduLLbE5otzVgKG78e4V3X9iVWgkDQRAXFxSBX309vs7D+o+bm6k9rH7F80oR496
 t6N+MxKZEOOotD9QtJMOU9v+j2h1EKRgsb0Qa9lJNA1+gUXuPTBh2frln7ampsn90lxLRg/GDPE
 t1eAKxf0KZUqgzaP8fEEc5EG8oBVw==
X-Received: by 2002:a17:902:ce89:b0:2bf:9760:b94d with SMTP id
 d9443c01a7336-2cf3485ea4emr138122105ad.15.1784531782054; 
 Mon, 20 Jul 2026 00:16:22 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.116.239.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf346db113sm50931775ad.39.2026.07.20.00.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 00:16:21 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-stable@nongnu.org,
 Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH v2] virtio-gpu: fix NULL deref in rutabaga set_scanout
Date: Mon, 20 Jul 2026 15:15:56 +0800
Message-Id: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pj2-x04.google.com
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
(16), but does not check scanout_id < conf.max_outputs like the base
class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.

With the default max_outputs=1, virtio_gpu_base_device_realize only
initializes scanout[0].con. A guest submitting SET_SCANOUT with
scanout_id >= 1 takes the con=NULL path, and
qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
QEMU.

Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
CHECK, since realization already ensures max_outputs <=
VIRTIO_GPU_MAX_SCANOUTS.

Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-rutabaga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 6ff1263901..3f78899442 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
                                      ss.r.width, ss.r.height, ss.r.x, ss.r.y);
 
-    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
+    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
     scanout = &vb->scanout[ss.scanout_id];
 
     if (ss.resource_id == 0) {
-- 
2.34.1



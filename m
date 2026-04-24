Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41446FDEE58
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG43W-0006fa-Fd; Thu, 23 Apr 2026 20:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43R-0006ex-Rg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:05:57 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43Q-0000yW-5h
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:05:57 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so6824948eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776989154; x=1777593954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Okui3+LoiEw6Ead0/iU3+dwFPXpVpxuXn0Pb9e4RdJE=;
 b=J2Y4Oi3sVRMaT2q9TiQJHMk+PjqyMUozfm/XifvWHdu+iDnIYDE2MowwDq/Nyx341b
 Y7feFqXWeP7tXB4/7Q160fgsQjLW0GUv+PxqUrNR3m4+hB5IPpPSBi2PY64ODVVwsQCz
 34Go+jHqQ5C3R9hamV0oHN6R7GyoSJ5EqqxyPv/HNrxLR3ShGseRvy0qsFgKx7Jpw8df
 nLHr921CTLtFwTmD3XtJch3eL4OZh2HLOVgwOVOiUynFMnc+cz6mIygJ9T6nG3ShbiBF
 BXWifCBngWdssWB7HmWPHXVVh/Bk3hKwVlGgJTimlsQQvQ5KDxwnhEL0V6KGoidc2uVu
 rb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776989154; x=1777593954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Okui3+LoiEw6Ead0/iU3+dwFPXpVpxuXn0Pb9e4RdJE=;
 b=g6tnOGBlbVpmzLiHHnpDsy/fRPmQOVzIaLXNDGL87QEC7El+T/QLoX3waRVOUoUOWK
 8aoTpTNhp4rbtpLvusJYneXqFd+Olb0g+QxCWtkmBWRwAVa3oUDb5PD54/h5ztPG121o
 3NjGlxAzVblZHlJr1EQRxU9YEYZeUo0maLy+Q1B3COcGi8HStsJ7CCiGJngDBjN0x4b0
 ZcuPEKAFsC71nDQNImwgfr7PAagF17mGuVKi6KRj3A0YxB6UlZNDrJtDQhd+k9LyofMh
 70k6zvq9egOSvC8in5XN1MM6S/cjswyBrCnMd1q2CS3iL5/L2il3I2xk/T+x+4jO79wt
 rMRg==
X-Gm-Message-State: AOJu0YxlpT29kbAVIY+B6SHORh1rWfXhnj1PxXYNjFMoB+wNcZOw5bL9
 3pbmDGJrnU0F61F6XbIt5qxEJilgMDAtGvIbBNVFB5grGkyUfHKZD1u6sPu4SIILSXo=
X-Gm-Gg: AeBDieuBcYTUGr6NQUGzUWS0dNcqdtlf3DW18sunm/HuT5isxAkss/qPcx7JKHXhFlz
 nsz3KNm21dFUYb+oxHFSbhn09D0pSbP7cpLjQyLzyBTj7SX3m8OR/cZpzhAesGzpAyIlH6X+sgT
 vpoHm7z+c6BfYR5jLy+aoc1qLLBQHbz+Z+xO5UzVsYpI9Y2Z5oBTrsooWQBh8CG3RiMxQrrHgma
 fE7hDN0/vkFO4SL5g9Kw88Nr1RN6xCubHhQhV0Ijlld8Df9yoYcfFrTOXMGRN8QIvQ72IOxKrxv
 hlbaLWPNWJ1DxnAyvgaGVMfsTW9H3zOnNW3e7iyBe5bakTuQ6dK4Pn7+2y+IqyF15wloSa67QRK
 sjRUQN4QBlZxw0PGUFZn8fPjdYL83gqXPpBGeduBjzgqdb4ljxcOO8nw3/ZnVPpdcBGrM9OfQTk
 08NTgV+DVewy2R9Q9WDzHDbJ7hWSSIRLeImmHX7RrAGZuGari8/grMqMv/YZfU7t3IH4RbpsJu
X-Received: by 2002:a05:693c:2b04:b0:2d1:a3ea:d8d4 with SMTP id
 5a478bee46e88-2e4647d03a2mr16651570eec.6.1776989154285; 
 Thu, 23 Apr 2026 17:05:54 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ea8e4b373dsm12958055eec.6.2026.04.23.17.05.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 17:05:54 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 1/3] virtio-gpu: validate host page alignment for MAP_FIXED
 blobs
Date: Thu, 23 Apr 2026 21:05:42 -0300
Message-ID: <20260424000544.9617-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424000544.9617-1-lucaaamaral@gmail.com>
References: <20260424000544.9617-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 4eb0aace ("virtio-gpu: Support mapping hostmem blobs with
map_fixed") uses mmap(MAP_FIXED) to map blob resources into a
pre-allocated hostmem region.  Both the offset and size passed to
mmap must be aligned to the host page size, but the code does not
validate this.

On hosts where qemu_real_host_page_size() exceeds the guest's page
size (e.g. ARM64 with 16KB or 64KB pages, macOS ARM64), the guest
may provide blob offsets aligned to its own page size (4KB) but not
to the host's.  This causes mmap(MAP_FIXED) to fail with EINVAL,
and the subsequent unmap (which also uses mmap MAP_FIXED) fails the
same way, producing:

  virtio_gpu_virgl_unmap_resource_blob: failed to unmap(fixed)
  virgl resource: Invalid argument

Add an alignment check before attempting MAP_FIXED.  When the offset
or blob size is not host-page-aligned, skip the MAP_FIXED path and
fall through to the existing subregion method, which handles any
alignment.

Fixes: 4eb0aace ("virtio-gpu: Support mapping hostmem blobs with map_fixed")
Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 hw/display/virtio-gpu-virgl.c | 45 +++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b7a2d160..f6583b48 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -185,25 +185,34 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
         return -EBUSY;
     }
 
-    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
-                                            gl->hostmem_mmap + offset);
-    switch (ret) {
-    case 0:
-        res->map_fixed = gl->hostmem_mmap + offset;
-        return 0;
-
-    case -EOPNOTSUPP:
-        /*
-         * MAP_FIXED is unsupported by this resource.
-         * Mapping falls back to a blob subregion method in that case.
-         */
-        break;
+    /*
+     * MAP_FIXED requires host-page-aligned offset and size.  Hosts with
+     * page sizes larger than the guest's (e.g. 16KB on ARM64) may receive
+     * non-aligned blob offsets.  Fall through to the subregion method when
+     * alignment requirements are not met.
+     */
+    if (QEMU_IS_ALIGNED(offset, qemu_real_host_page_size()) &&
+        QEMU_IS_ALIGNED(res->base.blob_size, qemu_real_host_page_size())) {
+        ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
+                                                gl->hostmem_mmap + offset);
+        switch (ret) {
+        case 0:
+            res->map_fixed = gl->hostmem_mmap + offset;
+            return 0;
+
+        case -EOPNOTSUPP:
+            /*
+             * MAP_FIXED is unsupported by this resource.
+             * Mapping falls back to a blob subregion method in that case.
+             */
+            break;
 
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: failed to map(fixed) virgl resource: %s\n",
-                      __func__, strerror(-ret));
-        return ret;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to map(fixed) virgl resource: %s\n",
+                          __func__, strerror(-ret));
+            return ret;
+        }
     }
 #endif
 
-- 
2.52.0



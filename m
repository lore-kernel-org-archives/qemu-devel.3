Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFB7D58B08
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 03:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1cMg-0004wF-4Z; Sat, 14 Mar 2026 23:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cMe-0004vf-51
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:42:04 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w1cMc-0003ka-5T
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 23:42:03 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-128e3125372so2526782c88.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773546120; x=1774150920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Okui3+LoiEw6Ead0/iU3+dwFPXpVpxuXn0Pb9e4RdJE=;
 b=jgS1ExvettYLyNojPaWzQ8XBvgLB81dAA/7ZEyeAB8+CUhrRSl///LagIGt0+Y8FXI
 N7PmhI8Oc8d8agPwahcUuEK2gd+xZIn1JNCtlHyZZCdBMcqeC1tAqzV8ksHNGroEv+cW
 u3EAZfzq3Fcg9fnRrHgOxCCWRMJNv+g9r50gDjrxqstgn+sNWf5yo29CWD3YPEpx4489
 WCpCqOwmS2zJ+R3QXwCpKWpInmEnJvg4ARPTSCVAhaTh0N7RsphMpSd6K6Ei+eAFEtaH
 ti4n7TZlvWhGuQX4yUYtZQpgBq0ayWbN/1jzHHuEva4rHGDQdM9K/DmUv8OQVDaaSUmc
 MvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773546120; x=1774150920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Okui3+LoiEw6Ead0/iU3+dwFPXpVpxuXn0Pb9e4RdJE=;
 b=YQVXAwYqY3BuID6hxfcdTKXdOMVCAxUcHCpmghMteYBjKaak/sE3BC+dzXZdJVcdd+
 tZgsYY3TaqEoMCOwizJi4pGL7soba6st8EPbC/MPk8f1tukCX94lXrncxKF5zkMsEes2
 lLTyQymRbsoYgydIpOa8dwr9pRsslHwyZdYFidr7n2Fhj6oT66xw1wgm1TaBLJ5sBDGm
 t+KQuQyKtMRqpK6ZLrTfuS9zLIqZwyhFA75GzbZYKy9pgnTiEyfZqe7Axl+TjiXPzEND
 Ql+wWO4ajqriw2Is7ctAiJ2NNNsTy36xOrFvdmxTxKmi3qBEuLo9WJB1o2LMvwIi2wH5
 gn+w==
X-Gm-Message-State: AOJu0YxvnvBWxcBdeR1xfBbM7r5Kl4swcXNopEPGZIZLWb4PvXwR2WHE
 KG63Pa2CDUKG1ckSmhPgn7saklMTKsd+bVoifFS5hjchjLbNMDCkX8miBTnB6A==
X-Gm-Gg: ATEYQzxIWhHqKzR3cX0Zp5ioYZ6qZcok7aw/6CWiq8tXUZdjl2jtbpyH6ysng1vj2fE
 b7eSdAoAj2tYtmh3yDgWe0NEBxSTurhBO1ipthy8e1mHJeoPsc4VQWTB0Y20iGFibqMdPq+GSZr
 a0Z9LF60Ebj+H1Yn/Cs3II4cHWMgY+E37qVRf3iNubUUTPYFbc4vIo7IZAQaQaQa+gsC6BbxgAt
 x4ybMYBFhoBtvuKpjklLJXp8YJZPUKq0RwyDNUvEY9IqLG2vyqoqWJT+wnx9HHlqqgcHnfEChCG
 +nl2fHZAfvy2kduKoqkIGB5L3fppLkkILZgvqUT7aCd4/bl/Vp4udHyYtTcut7R8X7WfcqFHf9c
 IPQiFkwFTcCA+7ueTzE5Wkemt6iW1fHzOCS+bYIatHk5mWMweFLPrEfHcswVhufOZInMHCIkGit
 IUBI4Xt/thrqcZqQ2OeRFlP39n22yabx46w8PnyL0=
X-Received: by 2002:a05:7022:2385:b0:123:331f:978f with SMTP id
 a92af1059eb24-128ecba8bb9mr5189261c88.7.1773546120423; 
 Sat, 14 Mar 2026 20:42:00 -0700 (PDT)
Received: from 192.168.7.2 ([189.6.247.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab57b2b2sm8862982eec.33.2026.03.14.20.41.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 14 Mar 2026 20:42:00 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH 1/3] virtio-gpu: validate host page alignment for MAP_FIXED
 blobs
Date: Sun, 15 Mar 2026 00:41:52 -0300
Message-ID: <20260315034154.41986-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260315034154.41986-1-lucaaamaral@gmail.com>
References: <20260311022732.64141-1-lucaaamaral@gmail.com>
 <20260315034154.41986-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



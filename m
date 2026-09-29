Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F197CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUek-0006y7-9E; Tue, 29 Sep 2026 06:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUei-0006xj-ST
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:49 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeg-00088B-Ny
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:48 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485ac898fa4so3247406f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676105; x=1791280905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yb1O3Pn56o4LiGypd3inPYKXfLS5LOODB/H+Z8H+8kI=;
 b=xyki7hluCVQ3EcUSGWg6nSZsNk8EJT6Gh1mNzEL56jCKvLGkVmVgSZiE7BmNZTnEBd
 AkiAj7CKR8cB5E9K+5DOVD1Y+li4jkZ/KASK6jmVCFhijqJbu61mrzBTEjCyqwKhLTa9
 Dyv5nblgWM33/Fi2VB+s4gnrOggbACD9eKb1tWwXBT/WX1IJdKIyf62BnVf1Nz6r6BeE
 m2hRnH59ibp4UHppZ2x5JGJ2kTaLoBSCREmqz67RcA9Qe0FTzxwaCaq8QoZgLZVt8Epa
 In7+P4Apgclu9ipcM+veccRf9oBsCm/QU/Foewr1mznYfS6TSVwVY240ViCb9dnzYmDm
 O8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676105; x=1791280905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yb1O3Pn56o4LiGypd3inPYKXfLS5LOODB/H+Z8H+8kI=;
 b=KE5WRZ59RcuaLTatb7YiZA1c/imjW7QxryouD+giWLsLfDgYvWCLLJxeofDo/Kqh/w
 a0PKYjegb1ZHvO69tELAKNw/vwzQE3nGFGEDJX/yf1ULTQSVgkRMDdjmJEvAZyJNcelP
 VAw0aEig29GvOdvOmjwgRtexGaxDpBJ9k5D+Wi2XAtnbmSxRh7CBRjvwhkqmwgQLqx3+
 f0dA4PA1l5SO78IjoePawdjQ3gPgz26P9KTt+iyjq5KaT8N9bONsFMkKsD/6i/Dt6moZ
 Jvsdb/cBBPOw+1Fgfec84jsl8EtQC+6JJr0IdojOAZYRIm/QBY60j56OaNJrXDJo1irP
 erfw==
X-Gm-Message-State: AFq9FYJY894QjcKeUFlhN26vU0gkd6UM/Fe1Lo2e6VmzYaM2bcOlaLUC
 47jZTh1x/sa9fZOYJ1FlPLRnbYNQD6yk3VCR6LjrLV5YzrmZcrCSRSN13HT2VAmc24A3uNb2Ac0
 npwDy
X-Gm-Gg: AYBFou1l08AI3W9NamjSydQ0NtV/XHsGyUzCq5SSBUB0QujEnlFpOg5llsX5dY5N/rK
 QWKYu+l3WJkbrWy7JzqbcXpZWzXLPjRcBXCDlbSHElbsgKzkesbYTeM2WcNdp0QH2yfgniU9Sne
 dAqJREwmA2yEZBgclcDb8qg+TVLjs6SSA89dpSs/k0QikW5iPgStir4v0r5+lmIzzkjUXH26/FQ
 6tM+wjtXKXJjMwwVymxbsD+vADa9kD5+VmR4GKu5OStYSQ+m0czXf+i3R/2bVdNLDEAYhgKk9fH
 sbOr+lqbQK1QXVhDb99wv2EgBKZQcv2yNUSu0mxTU9j3UdM9YdY38JbD4FBTJBRIC92OvT+m4Uv
 r59N5FBaqNzboiyOEjxt0vn3Rn4mMsHZ9LUCFPdL+H3eHEOmSld7Z4yr/Vxf77XTnJGieZhLFbk
 mZcb4BP4qkckZSjpIgOFJ9oodjmO538xn4p2ONOK8G8m/NhWCzepIRgqiG0pGSsSUcHGa7Bq/d6
 YxGQZXLwA9IZK8JFR7g4vC5VK3rM0ym1TYD5WYCwndiWkErOnN45iEyVdjbe6fJbxbroL799zXS
 Tp8=
X-Received: by 2002:a5d:5d11:0:b0:486:e949:532c with SMTP id
 ffacd0b85a97d-48871875a05mr30542295f8f.43.1790676105189; 
 Tue, 29 Sep 2026 03:01:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/37] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
Date: Tue, 29 Sep 2026 11:01:01 +0100
Message-ID: <20260929100133.2598676-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: "Matthew R. Ochs" <mochs@nvidia.com>

With CMDQV enabled, resetting a guest after it enables VINTF invokes
the VINTF page0 unmap path. The resulting crash is intermittent and
has been observed on the RCU reclaim thread as:

  reboot: Restarting system
  double free or corruption (!prev)
  ...
  #5 address_space_dispatch_free
  #6 flatview_destroy
  #7 call_rcu_thread

FlatViews retain raw MemoryRegion pointers and release their references
asynchronously through RCU. The VINTF page0 unmap path removes the
subregion and immediately unparents and frees it. An old FlatView can
then access the freed region during teardown, resulting in a
use-after-free and heap corruption.

Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and tie its lifetime
to the VINTF page0 mmap. Initialize and add the region disabled after
successful vIOMMU allocation, and remove and unparent it before releasing
the mmap during allocation unwind. Guest VINTF enable and disable then
only toggle the region with memory_region_set_enabled(). New FlatViews
omit the disabled region, while old views continue to reference valid
storage.

Keeping the region initialized across VINTF disable and reset is safe
because the vIOMMU association and its VINTF page0 mmap remain stable
once the guest CMDQ has been initialized. QEMU blocks hot-unplug of the
device that established the association, so later hot-adds reuse it
instead of associating the initialized guest CMDQ with a different host
SMMUv3. The CMDQV free_viommu path is therefore only invoked while
unwinding initial allocation, when the region is still disabled and has
never entered a FlatView.

Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Message-id: 20260914222554.708582-1-mochs@nvidia.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 54 +++++++++++++++++++++--------------------
 hw/arm/tegra241-cmdqv.h |  2 +-
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 273633e6293..57041408a7f 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -131,36 +131,12 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
 
 static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    if (!cmdqv->mr_vintf_page0) {
-        return;
-    }
-
-    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
-    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
-    g_free(cmdqv->mr_vintf_page0);
-    cmdqv->mr_vintf_page0 = NULL;
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
 }
 
 static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
 {
-    char *name;
-
-    if (cmdqv->mr_vintf_page0) {
-        return;
-    }
-
-    name = g_strdup_printf("%s vintf-page0",
-                           memory_region_name(&cmdqv->mmio_cmdqv));
-    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
-    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
-                                      memory_region_owner(&cmdqv->mmio_cmdqv),
-                                      name, VINTF_PAGE_SIZE,
-                                      cmdqv->vintf_page0);
-    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
-    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
-                                        CMDQV_VINTF_PAGE0_BASE,
-                                        cmdqv->mr_vintf_page0, 1);
-    g_free(name);
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, true);
 }
 
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
@@ -899,6 +875,9 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
         cmdqv->veventq = NULL;
     }
     if (cmdqv->vintf_page0) {
+        memory_region_del_subregion(&cmdqv->mmio_cmdqv,
+                                    &cmdqv->mr_vintf_page0);
+        object_unparent(OBJECT(&cmdqv->mr_vintf_page0));
         munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE);
         cmdqv->vintf_page0 = NULL;
     }
@@ -910,6 +889,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                             uint32_t *out_viommu_id, Error **errp)
 {
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+    char *name;
     uint32_t viommu_id, veventq_id, veventq_fd;
     IOMMUFDVeventq *veventq;
     int flags;
@@ -955,6 +935,28 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
 
     /* Set up event handler for veventq fd */
     qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
+
+    /*
+     * Tie the MemoryRegion lifetime to the VINTF page0 mmap. Initialize it
+     * disabled. If initial vIOMMU setup later unwinds, the region has never
+     * entered a FlatView and can be removed and unparented before releasing
+     * the mmap. After successful setup, keep it parented across guest disable
+     * and reset, and only toggle its enabled state so old FlatViews continue
+     * to reference valid storage.
+     */
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_set_skip_iommu_map(&cmdqv->mr_vintf_page0, true);
+    memory_region_set_enabled(&cmdqv->mr_vintf_page0, false);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        &cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+
     *out_viommu_id = viommu_id;
     return true;
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index de4c1e53358..bba985099e3 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -49,7 +49,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
-    MemoryRegion *mr_vintf_page0;
+    MemoryRegion mr_vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
-- 
2.43.0



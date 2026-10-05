Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C6BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhL9-0001XF-NC; Mon, 05 Oct 2026 07:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKn-0001U3-1x
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:21 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKk-0002xh-Qp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:20 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 2E3C91D000D3
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 05 Oct 2026 07:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1791201498; x=
 1791287898; bh=gK8s1ulRpBUK8H49IzkWtXw9we6XkINXvwJOkUhDBzQ=; b=M
 3CWS0PJrVvpkr5VwiAs+Op70JaIbZD0Ohnpg2FHG/klTq1wK+eaYwU6CQMsYxk7L
 tAaRMpIcRK5h8VQOVnJLB7jsTxLyXBpQlPxljbK8k89wgQM/MRO+VF1d7AU1VKfJ
 otIKpZgT7FmSkhBwkK58S2X44Ha//B1LJBovccDVK3bNV9MXHq/5hhEonX438fFj
 voLd6iQ8DlqZBmRaF8deWA0Ck9KRW1OcXvGWBKpwNnnq0rKyUFq2GZCUPHasaz+y
 YwlG57uED5AEg//R+bYKl+qKufuwsXObhRytvhwE21w/SM5gMxc8DJGySwbO/MNP
 gvsUtBoDv89kYzPQxmagA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791201498; x=1791287898; bh=g
 K8s1ulRpBUK8H49IzkWtXw9we6XkINXvwJOkUhDBzQ=; b=dCnQLxKwv1vxfIU8c
 DIwPV2kpb5pevHM0oq1ODxe+nlVacsQ+1pHC/XOb0n9Ahj6hjuwsKjX6dxLoWFRE
 4k3UInTXSoLDcJkFTliuUzNQTOejnAPGmqQe0u11Tn2+FW+MKsGczpPYIgm7ZXfc
 i6ZOo8hBgkTZ+jUQ24EgWp8oHh5vRX1fuvPSH8NkI5Qtq2MtgyX9+JC2d3LrDbV5
 M58J5Mdd94dRq/ik48vscgGT0sWrgOZfyD0hjyrepi890BZSGCM7MpSTw2Oc7HiF
 W47mEF2gS3C8hx+UTCPtG3GdY0XMFCJd7gFrb50CKGcfeSN0SwfvBYbLiy8aYd48
 csinQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201498; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:aJ6gp9LQhhbs8a5DMPWf7OTM1j6OMjrQTlKJ02fjfiU9bJq
 8LAN7X4oL6i81epmB+YA0AgCxmO9vXZz7hsOVf39wkRf5mtg5KbGwIBxp16m4Lyu
 AyAT/+Tyxc7MONn0X1/cE3KT66Le8H31RPtmt7AIM39G0C6UHsWHpLTLK9Ft0trJ
 DGEAQhY5dM0+qBLKNc89JO7z7VEaRIPgYJey3QYR2+Jmdp/fMXT4snz32Yvlg27V
 ixRylGI2nFmSUjsDRf5ZX+6XBhAmd8dewALtZyLfEn5P3iLBFg8l9wU1CUx+e5dl
 X2+9VP14QZLNNdaESPpDAEcynkJ2Kz2vLc0IIFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:kS8LCX7o4xCK8DcTnxivJGXfDR5JZtFRjAjIHPxANi4=:cxsZwPy9xPXPcYAhLIpVwB7Xto8ubYloAwYGC4oPeuQ=;
X-ME-Sender: <xms:2ZDDahItPAJFQTc0q6Plj7sLGI2O171y4zD3JOvu7xj8QRv6mI8u2A>
 <xme:2ZDDanO8An_4ri9clr2f1JGczmpzN8v25tQwfw5FuT6xEVPHULjUW2ZK9vf8hjLpR
 xbLB1rbFf8Gxo43SYbXdWz8I59HzTxbSQG94cR1SBgFYuQGrbE4mg>
X-ME-Received: <xmr:2ZDDapnqV3ElMB0QwbdQha_kkujmT8ZuMPY1E_Cd8yRcVDdytOxO0GauwwzSPIbrbFB6lEKxQGpeCxK0m1i9PyOL>
X-ME-Proxy-Cause: dmFkZTGBqm9Tnuc8Q7oXt0qG4S37jB3ca+dwPggMm/4DbSi+r/PKAIimqWh4i3gxlSXgTA
 omDfi+D5JYgrvVsGPzwjCPVi9Z+xofK2t7xsWdfjUaIGAO+zs3+PFHQ+ngadEQPigikWax
 znhW7Dewf5D0XKW6dVlozMw1Sh5k7T4r2jO8ZgHqq3MErCU5RkI7xjfxtL5varo4Lwl2TK
 L84rAr7ZF0BOSrngZUsBoMXTyobCldT9LtJyyAVrm0GIB2r3B4HIme/LUCuPwBiYfuFrv6
 x0LYJjsbgEXspRRlTQxY6cI5GG4ZcNOGlUwJiefG1Ngbn72lYa+4C380guNER+d5YP6DsZ
 biClhx6K7ndln/I0g5SvYCTmkuuzu67DWO9sDiDuNcU4G6oijtPmqxJApRAHm4f7uEahJj
 8GCf5Wl3bysAwyP9T8qFKMjSU0gYzobqlCZJXVp+f08DAzjndjS6DzOLYyxbh5BekYsO10
 Y+s2Xpp8iflpgJVgj6Aw+C+4LsAlbQndDCQYp86jolLKIFKbzC8KQGAmvsFMzfuvaiyhf7
 mx9ducQ8T0Y/RWZ8IChYqJXql8TksO8nJXoBu7mFDCBGG+yo6eazDkL33xg4nJSOPPGtOM
 qtlNn1jdAcJkPCH3GsltPcEekhg3Mvv/rBSVk5rp6dblpYJeVsoUL1x93sUA
X-ME-Proxy: <xmx:2ZDDaj5UqcAwftYZeS05TOHI5J_9Ts09Zy2BFrkeYmct7NGyW2wGqw>
 <xmx:2ZDDal1QfSpqmF-O66Qgh5JozLOLTo7VfRdKpie7U0dZ5ybYiQtqwQ>
 <xmx:2ZDDamHjM95h6Dztb76mKIRchGCW-pAmuVcHPu-PUKn75srDXVWPcg>
 <xmx:2ZDDasiECx44sUHL55SXwnOfsj_AOWeR59mSVb6S9aAN60RDblV9Wg>
 <xmx:2pDDarynPhB6aOh1FIkTeECMbJK5b9NOa5RXE2Nqcibcn7fauviJKRFC>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:16 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 2/5] hw/nvme: support online resize
Date: Mon,  5 Oct 2026 13:58:02 +0200
Message-ID: <20261005115805.99042-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005115805.99042-1-its@irrelevant.dk>
References: <20261005115805.99042-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=its@irrelevant.dk;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Implement (BlockDevOps *)->resize_cb() for NVMe namespace to enable
online resize support.

We must handle cases when multiple namespaces are attached to
a single controller, or namespace is shared across a few
different controllers by iterating over controllers attached to
a NvmeSubsystem and properly notify every controller about a size change.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c |  9 +++++++
 hw/nvme/ns.c   | 67 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 597aeedd6a11..3e8a1c8b77b1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7043,6 +7043,15 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+void nvme_ctrl_notify_ns_resize(NvmeCtrl *ctrl, NvmeNamespace *ns)
+{
+    if (!test_and_set_bit(ns->params.nsid, ctrl->changed_nsids)) {
+        nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                           NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                           NVME_LOG_CHANGED_NSLIST);
+    }
+}
+
 typedef struct NvmeFormatAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 7f0f9ac7662c..de15921b613b 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -163,6 +163,69 @@ lbaf_found:
     return 0;
 }
 
+static void nvme_ns_resize_cb(void *opaque)
+{
+    NvmeNamespace *ns = opaque;
+    int64_t size;
+    int cntlid, notified_ctrls;
+
+    size = blk_getlength(ns->blkconf.blk);
+    if (size < 0) {
+        error_report("can't get size of block device %s: %s",
+                     blk_name(ns->blkconf.blk), strerror(-size));
+        return;
+    }
+
+    ns->size = size;
+    nvme_ns_init_format(ns);
+
+    if (!ns->attached) {
+        return;
+    }
+
+    /*
+     * Okay, the namespace is attached so we need to notify all controllers
+     * about size change.
+     *
+     * Let's just take ns->subsys, iterate over all controllers and find
+     * to which of them our namespace is attached.
+     */
+
+    assert(ns->subsys);
+
+    notified_ctrls = 0;
+    for (cntlid = 0; cntlid < ARRAY_SIZE(ns->subsys->ctrls); cntlid++) {
+        NvmeCtrl *ctrl;
+
+        /* notified everyone? */
+        if (notified_ctrls == ns->attached) {
+            break;
+        }
+
+        ctrl = nvme_subsys_ctrl(ns->subsys, cntlid);
+        if (!ctrl) {
+            continue;
+        }
+
+        for (uint32_t nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+            NvmeNamespace *ns_iter = ctrl->namespaces[nsid];
+
+            if (!ns_iter || ns_iter != ns) {
+                continue;
+            }
+
+            nvme_ctrl_notify_ns_resize(ctrl, ns);
+
+            notified_ctrls++;
+            break;
+        }
+    }
+}
+
+static const BlockDevOps nvme_ns_block_ops = {
+    .resize_cb     = nvme_ns_resize_cb,
+};
+
 static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
 {
     bool read_only;
@@ -172,10 +235,12 @@ static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
     }
 
     read_only = !blk_supports_write_perm(ns->blkconf.blk);
-    if (!blkconf_apply_backend_options(&ns->blkconf, read_only, false, errp)) {
+    if (!blkconf_apply_backend_options(&ns->blkconf, read_only, true, errp)) {
         return -1;
     }
 
+    blk_set_dev_ops(ns->blkconf.blk, &nvme_ns_block_ops, ns);
+
     if (ns->blkconf.discard_granularity == -1) {
         ns->blkconf.discard_granularity =
             MAX(ns->blkconf.logical_block_size, MIN_DISCARD_GRANULARITY);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 43e3c916f73f..a4b2c01a2cc4 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -764,6 +764,8 @@ void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
                                        uint16_t nabspf, NvmeAtomic *atomic);
 
+void nvme_ctrl_notify_ns_resize(NvmeCtrl *ctrl, NvmeNamespace *ns);
+
 extern const VMStateDescription nvme_vmstate_atomic;
 extern const VMStateDescription nvme_vmstate_ns;
 
-- 
2.53.0



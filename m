Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FFFCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhLl-0001eB-8P; Mon, 05 Oct 2026 07:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhL0-0001VZ-Cj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:37 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xDhKx-0002zJ-13
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 07:58:33 -0400
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id EF1CB1D000D1
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2026 07:58:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Mon, 05 Oct 2026 07:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1791201507; x=
 1791287907; bh=EKZh4XODpsgLfXbLl630gxCEf0eFOXdRtsr+tgIzYPw=; b=U
 yBB+yJkeYplSp7vL5XM2zy3J/I2X/B57iZ79ncJJOcQgiuyION6aCjiY8spZkXyU
 77AEDP4Fkq52EH8banwhkUXhO1SNvRzFAVO+CWLKlNUKn8qfetYw1OLfWj7iQ3oV
 +bDjRrQL58H3ujqNZxK5S1JdJaROAAZ/wRt2eaaSbZfUhpNpdVhn1Kr8tTjMh/pS
 LFeloP+vQpdXqXGqwXLYgiIScPkMiS5hRauRpYKWC2KAFw2y7tIe1VmRkmq8YEPE
 du+enSDQQVrFHkqyt++uWJ2hnJR6qoNtAbVH1RyiC4R1eq1DQ1MoMaUJA/vm0yYe
 zQxTpEbhptbwxxvOmh/xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791201507; x=1791287907; bh=E
 KZh4XODpsgLfXbLl630gxCEf0eFOXdRtsr+tgIzYPw=; b=xHbyh9iJG5zSnpUbo
 WjSkRvwL4jjSIHG1TH7oYk9hA6RYc6ZVgp57CT3jJpjaHu00/e4RZcC8koJ4/80Q
 J8OxGSYFJgS69Vr2531bdgwRD8kVjWkBOBxyXcdgedMJ/K1GFKCyocoZxUnzPtq4
 i4r+8ysaZqHVfGPeDNGQm3VAjec8hlUAOPjdanJ0IWs65iiGhmfMn2QLKFXK6Uli
 36zRMaQ2Z0LSopxTqpxdmwQiCUMpsJXaYACKg3an8aEDQPCuLmop1bSJPobyUBTQ
 i6K/bgpJAjKYJwoOM8Y95lXHn+P3yPAiplGwVsf5cmtcaWxlQrmSFFpKo8A17uEr
 rSxNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791201507; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm1:rsa-sha256:Ql4+SP2ofqPGDl03W31nx6CfrPY+673iPeoQmmUpwfeckhb
 APqiWu5yF0YMBIMcC0Hs8rB+fWyiJE2TVTr3q16C7vI73050NSnyFp6AePQ0j5Nx
 mSCMMLT/gqkjgoG9YDbSqC1clrSgm6/RipJTI80H8d2TmUjJv63n0WTd0gz/FkR/
 ssY5AQQXbKGshcrEC6ds1ri9221EpxjOKiV1/6GIu8kviaba+MLqD5+S5CmDGu+t
 ok6JNAKgQ63K8Pjtsfjgrn1SBx4kPxh4sGS7lG5ODl16gvc7d6OH5MBV3iwuU89w
 YtW1PyDhD/7FLFbsq7KulVbUjcJGHGNPl+OgTOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:iqUSenGXt+B5fDGlFGIAwTV3inSUIatszesgawXNB2Q=:qFdRk+ZPAtl445tv66oxL5gsbhRXSv+4CyEDhybTsKo=;
X-ME-Sender: <xms:45DDatIRmS8jk6JOg-pEl1_3fKnqfsCnP8vL6FpfcyqBoOEDBCi4Fg>
 <xme:45DDalJAfzQVGta1MS5TSIWhVpAa-MF20B1sy41EM3wk2cosnlSehs-65A8Cnkz63
 mz0Wz92my-5TyszHBzZwnZE5gcgPVhDXyPlcaq9b7Nr_jsrSQPvWdc>
X-ME-Received: <xmr:45DDan5fU5iIhyt6sER9EScLVve1MAaGY43dQQPx168ySNxbt0vhF-CVv16YH3pEuRtHozfUmfTw2NYMt6cxIrY4>
X-ME-Proxy-Cause: dmFkZTElup7zJv9BsDzzdIERZhzdTcjLqSpSZc/CZbDydEWo/47/TUizh4zqwWQ98FXp0v
 RvRuJGx1PMMLFcfBz1XYS325AmkxTkhcTpZ25PnsDdZFedfaMsYIQLiobaRoo/f/GDCb/5
 nP6fhfgPT6b8RCMQQUk6LJsNUaU5+ESkyOx6ZvpBKdyAN3G0PwQEkErvh+QwUswWzbT9BI
 IjBYAHnRNv8/a7YS+piaSoKL6GLHpS9hJus2fOTXzj4PtssNdtaKG6qVK55TPwmFaG/oE1
 atLVo+TkA18fCSro52mA1sdcAc2WXxYavbVTEU/XfsC8/PnPI1IupszITbHeduqFmV74c3
 kaKI8hRE64a5SHU3G3BV86gxhV6fIStVCEJOWjR1YaXtCpRONcrwfNcPw8kDDrPEsDxQ3Z
 xkTneCarZKcxwxIIt+3dJ4spn2KCaKD9Cbiw62blm5jRkZiTbh55N67vV11hTOSINMASsR
 4aCochV33w6xldKL1Ux9If6MDAN5L6eQzS8k4U5OyDraLq8ShRbPvozNdDPiPWlKQqJ0lt
 nWyoZY35GLSkzU5TdtmNisSFCz9fZqCkw8Wr+guoH9Vb0FODMaS6eTLFLzquP7mpdlHC01
 AAwkeU7Jj85oeqcGNgmPwShd8J6uWfzcdux0/ePT1CJwbn/wZpcT9TZsXEMQ
X-ME-Proxy: <xmx:45DDave8JkJJKE7VbY2JlmfKujd1R_GSO2IKsPne_h0wONr8gVzusQ>
 <xmx:45DDaiE0FuVAqLuwyjlIbVY5kB07Dk7M_4kFKQtYEnJG_5l8eMpEow>
 <xmx:45DDaoSNQjfYBzmjjndHTip8pNHkLIsfFjRFTyx2YGGAeUhvpY6Gag>
 <xmx:45DDagYJq8Hjt1XdfNeGHMHrPeGGTnDsppUOHqefIGK6oJd-UW0y-A>
 <xmx:45DDalBctEUZaxJzeeYtEKxVV5Uz-i3wEXS_IrqiCB-drYfwNC51Ti7T>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 07:58:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 5/5] hw/nvme: fix firmware boot path when nvme-ns has a
 bootindex
Date: Mon,  5 Oct 2026 13:58:05 +0200
Message-ID: <20261005115805.99042-6-its@irrelevant.dk>
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

From: Luigi Leonardi <leonardi@redhat.com>

The correct way to register an NVMe namespace in fw_boot_order is to use
the NVMe controller as the device pointer with the namespace ID appended
as a suffix, producing:

  /pci@i0cf8/pci1b36,0010@4/namespace@1,0

This is how the controller-level bootindex works.
Explicit nvme-ns devices instead register the nvme-ns device itself,
which is wrong: realize() reparents the namespace onto the NVMe subsystem
bus, disconnecting it from the controller in the bus hierarchy.
qdev_get_fw_dev_path() therefore produces a path without the controller's
address:

  /nvme-ns/namespace@1,0

Fix by re-registering in realize(), once the controller and final nsid
are known, using the controller as the device pointer with the namespace
suffix. The old entry (registered against the nvme-ns device) must be
removed first since add_boot_device_path() only removes entries matching
the same device pointer, and leaving both would cause a
duplicate-bootindex error.

device_add_bootindex_property() cannot be called in realize() because
QEMU parses command-line properties before realize() runs, so the
bootindex property must exist by instance_init() time. The final nsid is
not yet known then either as it's assigned in realize().

The fix is restricted to non-shared namespaces: for shared namespaces
there is no single controller to register the boot path against.

Also add the symmetric unrealize() cleanup so that hot-unplugging a
non-shared nvme-ns with a bootindex removes the fw_boot_order entry that
was registered against the controller in realize().

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index de15921b613b..2ae26a9acbd0 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -792,6 +792,10 @@ static void nvme_ns_unrealize(DeviceState *dev)
     nvme_ns_shutdown(ns);
     nvme_ns_cleanup(ns);
 
+    if (!ns->params.shared && ns->bootindex >= 0) {
+        del_boot_device_path(DEVICE(ns->ctrl), ns->bootindex_suffix);
+    }
+
     /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[nsid]. */
     if (subsys && nsid && subsys->namespaces[nsid] == ns) {
         subsys->namespaces[nsid] = NULL;
@@ -956,6 +960,19 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     if (!ns->params.shared) {
         ns->ctrl = n;
+
+        /*
+         * Register the boot device path using the NVMe controller
+         * so the OFW path includes the controller's PCI address:
+         *   /pci@i0cf8/pci1b36,0010@<slot>,0/namespace@<nsid>,0
+         */
+        if (ns->bootindex >= 0) {
+            del_boot_device_path(dev, NULL);
+            snprintf(ns->bootindex_suffix, sizeof(ns->bootindex_suffix),
+                     "/namespace@%" PRIu32 ",0", nsid);
+            add_boot_device_path(ns->bootindex, DEVICE(n),
+                                 ns->bootindex_suffix);
+        }
     }
 }
 
@@ -1182,10 +1199,8 @@ static void nvme_ns_instance_init(Object *obj)
 {
     NvmeNamespace *ns = NVME_NS(obj);
 
-    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
-
     device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
-                                  ns->bootindex_suffix, DEVICE(obj));
+                                  NULL, DEVICE(obj));
 }
 
 static const TypeInfo nvme_ns_info = {
-- 
2.53.0



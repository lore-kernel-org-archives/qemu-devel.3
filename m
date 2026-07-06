Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E31C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3a-0001tW-CA; Mon, 06 Jul 2026 18:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wgs3Z-0001sp-KH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:53 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wgs3Y-0000x0-4B
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:44:53 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 508F47A01DD;
 Mon,  6 Jul 2026 18:44:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 18:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377891; x=
 1783464291; bh=3APf4nwAux95GbU1jGRozkoBxabTHnbgGvUjZhM48/k=; b=A
 U0JahiMDag9vowZr8hklBxoaCRirBuytn6AjN4c1bxQQ751vrUlbwTdcNhuL0pvm
 y5slbgknHUkLQkKaFUkNXEtI/Tg3sKMRlxKtosfwXuVMScqEMhlu4fU43SV9DuNu
 N4W4j99ape538KlkMbfiRRNhyI1QJUZzf24f7Velf611zQtTjJ5XsY8eFbNKaSGi
 pOEUC1hDfacDBHZ8rD3yjbm99CKGm1qk76L2yhHzss4T1hAsES/39iCmP3WxkChE
 DFJLH4pVDQxdVCJPa0yPM9xgbTi0CX7fcxAyFz+m/IPPZEOVmJMABsO4GElzq1NG
 as7skRID1U3zB8mbwLSAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377891; x=1783464291; bh=3
 APf4nwAux95GbU1jGRozkoBxabTHnbgGvUjZhM48/k=; b=FlhRjctmtm9r0hDku
 eKMzYQGNy9UH5yReNZieW2DZtgloUiJdv34LeCEG+uAt8kAftn5F2oC1KFz3tpwl
 FYWMPkhwbJmqy2a0EBlu3r6zfa3/Y6qflDhdSQO8tJ+U/ITkCumqhjA7xFXcIlaj
 pn5WjkO9tZwCozVO8x8lt/uzEEKZ2p+cVg3a3Vc7o/kzihG6Mz5TZBkuTGFXiv25
 IeiDQ1hTroRpDKaAXUy6HeC6RyRTD9qjWHwaMOqgioW6UUVc192E2M8+hphUC0nW
 sKVgzhzW+L6eU7sYBoBZ1Wz6SE4TMgNGNweNutBj+0POnUOKTENwpsdsMn8q4Yl2
 fNJUA==
X-ME-Sender: <xms:4i9MaoqZ_XyOzOHrCAdzX_EpFZkVfsBxXvwmNEvbSdkxqo2AQx4FTw>
 <xme:4i9Mapl6VNbNYC0rxsp4Rqy7VXx8UGwalkJe9rzEblpBanMn_t6d5GxhaPKShQf2Y
 ZsqjNpnRE7lfcyChfM8yb0PdrOLtlssApgRCK2Z4W7xX_eM1I3xsQs>
X-ME-Received: <xmr:4i9MasMfMuk_RI1pSVQjXRTBeRXiJIkYmnlc-A13_U7ysjsuM4RvCHCC9e034bGMwYeI4hY2YtKudgUffdCXY_3khO322KfozN7-cBaJfWDljYFkwF56sLa9Vg>
X-ME-Proxy-Cause: dmFkZTEBar+xcPJ6TGk2BRFD+/PQr7WZKLLnzl1lVSCdlSIyG0uCVLY82Gs7M5B5GndyFB
 O/P0+eD2zh/XrQgDHxqg00p15q5Qzw7PIbLGVkgQfI5ah8WSj2rr7xsbk02s3QNueEyg1P
 uHxCWWE7GNu317gk6JJEmbd3+/oen3y+m0Z15/F78rk451OEixAYafgzZVoxR9YsiHTnsi
 pkl5vDKm1IAyDDaEn/THuzeN7lX4xDLhr5j8Z6HscItNeJ4zDsnoQOgY57OGYvnzGv3L7c
 Ix4dWml9kPIpVOZvBZLF5TfBYx6q2yDYcVFI9eF2o7kl9f8NN4MyRbYzFs1rZrzVp7Rfps
 0QSzfeKXNci3ClHwdXmBPdy1XLY+biLGq/yWixuUXbxv8iHBHOBjKQgBZ/E07SeIGvYrcV
 y5zDCRqFINEiRbN8hGLvpczjPy8W6C3P7GbjsRLxU9AdWG6xGQFxvu4gCJJqAEYsrkij6Q
 NXkJs8SV7Fg8YoHZgJx9XPZbQ1n2GpNGdTo27i1Jrc7sKnZ+Lr5hHxfOwz3JXZw+OeEutq
 vY3LmgNnRvVSGSrjyATn/9jB90ln/tlFRPUqd0DM9zhmaQ+GgfUAAKuXOmdvZDDRbo19NZ
 Y6bWusunLNE8at1bwcHgkeTyrnkS0WD2qXJVQNKei4QeuFsbxD0vSZGrPHrA
X-ME-Proxy: <xmx:4i9MalO8crOwC8HdvGScl5L_ZQ85dqFxwLMQnDAHAR04_MDZnHQUBA>
 <xmx:4i9Malid1P4fU3FU0Oxw4mAe1Dscw_P3eXbxIZMofEquJuI_dVwLbw>
 <xmx:4i9Maqt8s3Fb4QUVKv6Z_PDV4P_qt2UKPMm9sSbJbzXPKAieXFCQ1A>
 <xmx:4i9MajSLxipsZy7Qni5Xh-D8fK-VMnbUDz2zsssHMEH6cyOhqbVMHA>
 <xmx:4y9MavvnT6MmXyV9lSS1JBjaAeQ5GzIvVkilrreUIH3EvLWcS2PMSKnT>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/11] tests/functional/migration: add VM launch/configure hooks
Date: Tue,  7 Jul 2026 00:44:15 +0200
Message-ID: <20260706224426.14156-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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

Introduce configure_machine, launch_source_vm and assert_dest_vm
methods to allow child classes to override some pieces of
source/dest VMs creation, start and check logic.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 tests/functional/migration.py | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index 3b7674af3b68..4344e03be417 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -40,19 +40,36 @@ def assert_migration(self, src_vm, dst_vm):
         self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
         self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
+    # Can be overridden by subclasses to configure both source/dest VMs.
+    def configure_machine(self, vm):
+        vm.add_args('-nodefaults')
+
+    # Can be overridden by subclasses to prepare the source VM before
+    # migration, e.g. by running some workload inside the source VM
+    # to see if it continues to run properly after migration.
+    def launch_source_vm(self, vm):
+        vm.launch()
+
+    # Can be overridden by subclasses to check the destination VM after
+    # migration, e.g. by checking if the workload is still running after
+    # migration.
+    def assert_dest_vm(self, vm):
+        pass
+
     def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
         dst_vm.qmp('migrate-incoming', uri=dst_uri)
         src_vm.qmp('migrate', uri=src_uri)
         self.assert_migration(src_vm, dst_vm)
+        self.assert_dest_vm(dst_vm)
 
     def migrate(self, dst_uri, src_uri=None):
         dst_vm = self.get_vm('-incoming', 'defer', name="dst-qemu")
-        dst_vm.add_args('-nodefaults')
+        self.configure_machine(dst_vm)
         dst_vm.launch()
 
         src_vm = self.get_vm(name="src-qemu")
-        src_vm.add_args('-nodefaults')
-        src_vm.launch()
+        self.configure_machine(src_vm)
+        self.launch_source_vm(src_vm)
 
         if src_uri is None:
             src_uri = dst_uri
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE82C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28f9-0002n6-2d; Thu, 03 Sep 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f6-0002jL-RU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f4-00044H-MW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso1741186f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446609; x=1789051409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jfZ0sib9Q6CuIrjV7feNJ39M8KHkevHDagQkapzRWc=;
 b=bspXF3O+fyt66YyQJprt7Dvsv/LqmyFclLfg5uCX83FdlZvF9B8ZIovepV9bnD43sk
 OQGjiyt+TGnonOdNx8APOKbQ/A2aO4KodFg10VZWZxF8IWK0t+UlmyeGgu1LAPza/0U3
 cZgbAU2MYZ7dhMb5MjrIwVV8FQxoRfPlRrxq50epPffuRHBQC8tkjOHTlY9/wDhNZcsO
 VeQSAwx+31sdMSzZxYDG4U6z96esMNTgZ/n98joE0xhLLEK8xDT7jGr4RSSm6tl5ezIP
 o9FhKCX+YGAaDVvLXJiB8tNsIyt4vj3Bc2R6T3jfX4AZ9YYY53Fpby4Z9aNUPaMeO3og
 cUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446609; x=1789051409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jfZ0sib9Q6CuIrjV7feNJ39M8KHkevHDagQkapzRWc=;
 b=SjGXGCJWGEWMMMLp3XCUnjP1LnmyjzJiDgQmHfFNeTPWdYeNNbSeWW2cMhO2Da+mT/
 MYDsr/wHAeQS8xnadzfinAc11VQ3tZBJFHja4CqzpdeHQn2qIHEkUeAWe8Uv3FJGMYjq
 f/l26wc46TnHJu7oGENvz8KLicATocHrr41H1PfNWm6UMJqTbB5smo7lvUUI09Bfy8LS
 kN8J9HAA9HxynYLvWBtnektVlmOTGBWjhnN+skyXLJ4pb8QhfGMDO9T+EVpnxsvfFl2y
 A+R4RfyMg0GWwZB+Hs4Y+yVZQgS+1ZIKGGkLVDHYzSX6TTJRm+WtSDTe/4cO4CC8ml2S
 JwBQ==
X-Gm-Message-State: AFuF++kT/E8GjgyJoxcJUCt3B5JQdBg8omF16j1sTj8l0KnygTY6bKKJ
 qsRp0pVyNW17w/8ryy0OCFx7wfalSW0zFGefYy5MANkomgVGxk2QehwyiKNTJmys3xb9U0c9+Ni
 RE5uF
X-Gm-Gg: AYBFou3To7XyDqdgBtu0T0epSemmHrqHPj06stLBJ/hcaNcDNzjkAwHWmAmCLWtavpM
 ZlkyLHFjJ1lClBUlYC1WKvTPDmuzcd48Y5CyTSjn0cZ3KIJiqWiQ7cL1J/kVd70hikV99Ns3h4k
 WlSWsqBTCliMJeEUzG0Ii96UAzzeScKxDC2gnlczOTp4o76bxWmBx87vi+78DEjyJsi1SwnjTxq
 //KCGQSkT3mpS2aEemBbnZibQTcTRRl1fKOBCIRc3jf4ejA39idziOU29nDOVBxlOGdZufXKGUt
 qpCd0vN0DymjjHWz45Sx414pWDH81imVXr4p2vmasXZs3Ci3VUGjGW2vNBjvsMkgMCyySWBKtrW
 yl4rkNldEZ+d3M7h3pbWKbEWVGSHjNstsDfGobBJfIbIqRABtrhYH9WNs1ZbLyhwudz8ROahhGm
 0A9ubHdFj8rTk/W23VJhE7fmhBZh/XiPLHRlG56AAHKWAH5bzHmIu6jt25
X-Received: by 2002:a05:6000:4698:b0:485:4277:fbab with SMTP id
 ffacd0b85a97d-4854277fc83mr17049675f8f.27.1788446609090; 
 Thu, 03 Sep 2026 07:43:29 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 15/25] iotests: run the persistent dirty bitmap test on
 parallels
Date: Thu,  3 Sep 2026 16:41:33 +0200
Message-ID: <20260903144143.2328870-16-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

From: Denis V. Lunev <den@openvz.org>

parallels stores persistent dirty bitmaps now, so test 165 applies to it
as well. The bitmap name is the only format specific bit: parallels
keeps it as the UUID identifying the bitmap in the image, so a name like
'bitmap0' is rejected on store.

test_reopen_rw is skipped, as parallels has no bdrv_reopen_prepare() and
blockdev-reopen fails with "does not support reopening files". Skipped
cases do not show up in the reference output, so 165.out stays as it is.

test_persistent covers what the series adds: it dirties the bitmap,
records its hash, restarts the VM twice and compares the hash again,
which passes only if the bitmap survives both the store on inactivation
and the load on open.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/165 | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 8fc79daae1..13b784fcc6 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -27,6 +27,12 @@ from iotests import qemu_img
 disk = os.path.join(iotests.test_dir, 'disk')
 disk_size = 0x40000000 # 1G
 
+# parallels stores a bitmap name as the UUID identifying it in the image
+if iotests.imgfmt == 'parallels':
+    bitmap_name = 'b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45'
+else:
+    bitmap_name = 'bitmap0'
+
 # regions for qemu_io: (start, count) in bytes
 regions1 = ((0x0fff00, 0x10000),
             (0x200000, 0x100000))
@@ -50,12 +56,12 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def getSha256(self):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=bitmap_name)
         return result['return']['sha256']
 
     def checkBitmap(self, sha256):
         result = self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
-                             node='drive0', name='bitmap0')
+                             node='drive0', name=bitmap_name)
         self.assert_qmp(result, 'return/sha256', sha256);
 
     def writeRegions(self, regions):
@@ -65,7 +71,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def qmpAddBitmap(self):
         self.vm.qmp('block-dirty-bitmap-add', node='drive0',
-                    name='bitmap0', persistent=True)
+                    name=bitmap_name, persistent=True)
 
     def test_persistent(self):
         self.vm = self.mkVm()
@@ -100,6 +106,8 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
         self.vm.shutdown()
 
+    # parallels has no bdrv_reopen_prepare() yet
+    @iotests.skip_for_formats(('parallels',))
     def test_reopen_rw(self):
         self.vm = self.mkVm()
         self.vm.launch()
@@ -115,7 +123,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 != sha256_2 # Otherwise, it's not very interesting.
 
         self.vm.cmd('block-dirty-bitmap-clear', node='drive0',
-                    name='bitmap0')
+                    name=bitmap_name)
 
         # Start with regions1
 
@@ -152,7 +160,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
+    iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
                  unsupported_imgopts=['compat'],
                  require_hmp=True)
-- 
2.53.0



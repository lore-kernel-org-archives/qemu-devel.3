Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D6FCFA753
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNbB-0005hB-E7; Fri, 21 Nov 2025 04:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNb9-0005gT-9o
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNb7-0004FP-Lu
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763717913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gfd3JGnB55h/gWpnDDpuGuCCRpgd7XAEzIOj46BhsZU=;
 b=T4l7MGckRBRpdI0RL+D2rQnk9qbCPkqDlbL8pDar1c0h0Zung++mEpde9ia1saug9CJCoW
 YznysjQU9Jt56bBEfvHSxQtXkMLD0cPcDWIr4vnDJ+f+SIN+3sJME/JGh39DfC08rZZyMM
 4V8JUkB3YAPl3dVGuYk+RFmDxS9dPLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-0etdcs1qOg60Wm1pCVFUQw-1; Fri,
 21 Nov 2025 04:38:30 -0500
X-MC-Unique: 0etdcs1qOg60Wm1pCVFUQw-1
X-Mimecast-MFC-AGG-ID: 0etdcs1qOg60Wm1pCVFUQw_1763717910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA6CD1956096; Fri, 21 Nov 2025 09:38:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C9B930044E8; Fri, 21 Nov 2025 09:38:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/10] tests/functional/ppc/test_amiga: Fix issues reported by
 pylint and flake8
Date: Fri, 21 Nov 2025 10:38:08 +0100
Message-ID: <20251121093812.280911-7-thuth@redhat.com>
In-Reply-To: <20251121093812.280911-1-thuth@redhat.com>
References: <20251121093812.280911-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Pylint complains about unused variable "tar_name" and a missing "check"
for subprocess.run(), and flake8 suggest a second empty line after the
class. While we're at it, also remove the unused "timeout" class variable
(that was only necessary for the avocado framework which we don't use
anymore).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251119082636.43286-10-thuth@redhat.com>
---
 tests/functional/ppc/test_amiga.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/ppc/test_amiga.py b/tests/functional/ppc/test_amiga.py
index 8600e2e9633..36378fb6972 100755
--- a/tests/functional/ppc/test_amiga.py
+++ b/tests/functional/ppc/test_amiga.py
@@ -15,8 +15,6 @@
 
 class AmigaOneMachine(QemuSystemTest):
 
-    timeout = 90
-
     ASSET_IMAGE = Asset(
         ('https://www.hyperion-entertainment.com/index.php/'
          'downloads?view=download&format=raw&file=25'),
@@ -25,19 +23,19 @@ class AmigaOneMachine(QemuSystemTest):
     def test_ppc_amigaone(self):
         self.require_accelerator("tcg")
         self.set_machine('amigaone')
-        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
         self.archive_extract(self.ASSET_IMAGE, format="zip")
         bios = self.scratch_file("u-boot-amigaone.bin")
         with open(bios, "wb") as bios_fh:
             subprocess.run(['tail', '-c', '524288',
                             self.scratch_file("floppy_edition",
                                               "updater.image")],
-                           stdout=bios_fh)
+                           stdout=bios_fh, check=True)
 
         self.vm.set_console()
         self.vm.add_args('-bios', bios)
         self.vm.launch()
         wait_for_console_pattern(self, 'FLASH:')
 
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.1



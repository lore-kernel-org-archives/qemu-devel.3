Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9A4CFA753
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNbK-0005p4-FK; Fri, 21 Nov 2025 04:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNbH-0005n7-VX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vMNbG-0004GI-K8
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 04:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763717922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QxDo+pG4ZXjTonYsr8uVHfU5KTurY6c3GiBASdOIgOc=;
 b=Wz4So9rpMDrusIRPp5ekfs9m8N5i1dLswcl2ckDP8/9Ruq8yxXn0uriSUR2HB5yT2YVCYw
 G/xaBdDRaktxS3mrmsAzYIqDMlSo6Sy+O6lOio+xrYBLY6Hm3xuf4mvIhv1/QirgA7tL2U
 1nkYMIwG5mVfanPEE9bhrfxLA0zx9Pk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-ptKFKLupO4C8T0tLYRrnCg-1; Fri,
 21 Nov 2025 04:38:37 -0500
X-MC-Unique: ptKFKLupO4C8T0tLYRrnCg-1
X-Mimecast-MFC-AGG-ID: ptKFKLupO4C8T0tLYRrnCg_1763717916
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 379ED18002FC; Fri, 21 Nov 2025 09:38:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A05B330044DB; Fri, 21 Nov 2025 09:38:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] tests/functional/aarch64/test_rme_sbsaref: Silence
 issues reported by pylint
Date: Fri, 21 Nov 2025 10:38:11 +0100
Message-ID: <20251121093812.280911-10-thuth@redhat.com>
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

Drop unused import and use an encoding for open().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251119082636.43286-15-thuth@redhat.com>
---
 tests/functional/aarch64/test_rme_sbsaref.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index 6f92858397a..4845c824960 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -14,7 +14,6 @@
 import shutil
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
-from qemu_test import exec_command_and_wait_for_pattern
 
 
 class Aarch64RMESbsaRefMachine(QemuSystemTest):
@@ -48,7 +47,7 @@ def test_aarch64_rme_sbsaref(self):
         efi = join(rme_stack, 'out', 'EFI')
         os.makedirs(efi, exist_ok=True)
         shutil.copyfile(join(rme_stack, 'out', 'Image'), join(efi, 'Image'))
-        with open(join(efi, 'startup.nsh'), 'w') as startup:
+        with open(join(efi, 'startup.nsh'), 'w', encoding='ascii') as startup:
             startup.write('fs0:Image nokaslr root=/dev/vda rw init=/init --'
                           ' /host/out/lkvm run --realm'
                           ' -m 256m'
-- 
2.51.1



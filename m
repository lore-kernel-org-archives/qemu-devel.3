Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8970CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1LK-0001f9-7v; Wed, 29 Oct 2025 04:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1LH-0001aI-Ke
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vE1L5-0005GN-6O
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761725723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l6+zfLdkw8EuX9kWfIgRpvWslSH9NbN+rlpm0AsWvlA=;
 b=DnxWZIpz5uER5nKz1YCDgoz+U4S3LZoze6fMWHaatN9JxszkHSP3BMbu4GhTHPAO6Y5UJg
 sKbl69VKFvIs5Rls3HLiUqK3VEnJ5sAybmsyLjJu8t5gUjZExpbVFpUnENIYs4V8mYs084
 pg6P30mcUHAKp0RLIKA7rmaCYKD68Y4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-Nstbjx7kNn2e3ES0iNyYSQ-1; Wed,
 29 Oct 2025 04:15:19 -0400
X-MC-Unique: Nstbjx7kNn2e3ES0iNyYSQ-1
X-Mimecast-MFC-AGG-ID: Nstbjx7kNn2e3ES0iNyYSQ_1761725718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 934E61800744; Wed, 29 Oct 2025 08:15:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C9B71955F1B; Wed, 29 Oct 2025 08:15:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] tests/functional/x86_64/test_acpi_bits: Silence warnings
 reported by pylint
Date: Wed, 29 Oct 2025 09:15:14 +0100
Message-ID: <20251029081514.60802-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pylint complains about too many positional arguments for the __init__
function of the QEMUBitsMachine class, use a "*" to enforce argument
passing by names instead (which the calling sites are doing here already).

Second, use lazy logging when calling self.log.info() with a "%s" format
string, and drop a superfluous "else:" that is not necessary after a
"raise" statement.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/x86_64/test_acpi_bits.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index 9a2816533d6..ec716d643bf 100755
--- a/tests/functional/x86_64/test_acpi_bits.py
+++ b/tests/functional/x86_64/test_acpi_bits.py
@@ -57,6 +57,7 @@ class QEMUBitsMachine(QEMUMachine): # pylint: disable=too-few-public-methods
     """
     def __init__(self,
                  binary: str,
+                 *,
                  args: Sequence[str] = (),
                  wrapper: Sequence[str] = (),
                  name: Optional[str] = None,
@@ -225,7 +226,7 @@ def generate_bits_iso(self):
                                       stdout=subprocess.PIPE,
                                       stderr=subprocess.STDOUT,
                                       check=True)
-                self.log.info("grub-mkrescue output %s" % proc.stdout)
+                self.log.info("grub-mkrescue output %s", proc.stdout)
             else:
                 subprocess.check_call([mkrescue_script, '-o',
                                       iso_file, bits_dir],
@@ -287,9 +288,8 @@ def parse_log(self):
             except AssertionError as e:
                 self._print_log(log)
                 raise e
-            else:
-                if os.getenv('V') or os.getenv('BITS_DEBUG'):
-                    self._print_log(log)
+            if os.getenv('V') or os.getenv('BITS_DEBUG'):
+                self._print_log(log)
 
     def tearDown(self):
         """
-- 
2.51.0



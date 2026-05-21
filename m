Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E1ECD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzBF-0008IV-Ki; Thu, 21 May 2026 04:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPzBD-0008I4-I6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPzBB-0007sR-Km
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779353695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2oiCpXlLt26lE1qyknl45r2g+osP9rbPqKj6/UdTgvY=;
 b=H1yp5tGIaiVYE1pCODIjX0Sye6i8uZ/4ZpwZZJqp4OrvV/bNWcz8F6/ucQm0I0Mf39mXzS
 HEl6sSRqpVCxVkc9VRXjyZvpfba1fK6OvO9A+PNb2XSmDm5HenUfvPZFEiHOc4LJsXSlqJ
 1cDDG2NJmC3daiwORAFNO2ixQAEoCAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-xV_bQRJ4Owmh7P8Go1_IBA-1; Thu,
 21 May 2026 04:54:51 -0400
X-MC-Unique: xV_bQRJ4Owmh7P8Go1_IBA-1
X-Mimecast-MFC-AGG-ID: xV_bQRJ4Owmh7P8Go1_IBA_1779353690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82E0F1956095; Thu, 21 May 2026 08:54:50 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A01319560AB; Thu, 21 May 2026 08:54:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8] iotests: mark 151, 181, 185 & 308 as flaky tests
Date: Thu, 21 May 2026 09:51:49 +0100
Message-ID: <20260521085148.1492614-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce a "_flaky_test" function for shell based I/O tests which
accepts a GitLab issue URL, and causes the I/O test to be skipped
unless the $QEMU_TEST_FLAKY_TESTS environment variable is set.

The equivalent "skip_flaky" test decorator is added for python based
I/O tests with the same behaviour.

This is used by:

  * Test 151 which fails in QEMU private AWS runners due to failure
    to make progress in time
  * Test 181 which fails with a non-responsive QEMU on AWS runners
    with the QED format
  * Test 185 which fails in GitLab shared runners
  * Test 308 which fails to see disk usage increase after fallocate

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

Previously posted as part of the larger I/O tests series. Attempted
to merge but it failed on AWS private runners, while still passing
on GitLab shared runners.

  https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04939.html

To skip the further tests we needed changes to iotests.py too, hence
posting for re-review before proposing for merge again

 tests/qemu-iotests/151        |  1 +
 tests/qemu-iotests/181        |  2 ++
 tests/qemu-iotests/185        |  1 +
 tests/qemu-iotests/308        |  2 ++
 tests/qemu-iotests/common.rc  | 16 ++++++++++++++++
 tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
 6 files changed, 38 insertions(+)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 9b9c815db5..647194094a 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -308,6 +308,7 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
 class TestLowThrottledWithNbdExport(TestThrottledWithNbdExportBase):
     iops = 16
 
+    @iotests.skip_flaky("https://gitlab.com/qemu-project/qemu/-/work_items/3513")
     def testUnderLoad(self):
         '''
         Throttle the source node, then issue a whole bunch of external requests
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index dc90a10757..b904e8ce01 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -48,6 +48,8 @@ _unsupported_fmt qcow vdi vhdx vmdk vpc vvfat parallels
 _supported_proto generic
 _supported_os Linux
 
+_flaky_test https://gitlab.com/qemu-project/qemu/-/work_items/3515
+
 size=64M
 _make_test_img $size
 
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 17489fb91c..a62ae8d329 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -50,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
 
 size=$((64 * 1048576))
 TEST_IMG="${TEST_IMG}.base" _make_test_img $size
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index f4a06a522e..a2290825f4 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -53,6 +53,8 @@ _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
 _require_disk_usage
 
+_flaky_test https://gitlab.com/qemu-project/qemu/-/work_items/3514
+
 # $1: Export ID
 # $2: Options (beyond the node-name and ID)
 # $3: Expected return value (defaults to 'return')
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 731e4b2b99..298bc483e0 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1088,5 +1088,21 @@ _qcow2_dump_header()
     fi
 }
 
+# This must be referenced after any _require_  lines, so that
+# test filtering happens first
+_flaky_test()
+{
+    if test -z "$1"
+    then
+	echo "A GitLab issue URL must be provided for a flaky test"
+	exit 1
+    fi
+
+    if test -z "$QEMU_TEST_FLAKY_TESTS"
+    then
+	_notrun "Test is flaky (see $1) and \$QEMU_TEST_FLAKY_TESTS is not set"
+    fi
+}
+
 # make sure this script returns success
 true
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 05274772ce..072be80e07 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1603,6 +1603,22 @@ def func_wrapper(*args, **kwargs):
             return func(*args, **kwargs)
     return func_wrapper
 
+def skip_flaky(bugurl):
+    '''Skip Test Decorator
+       Always skips test due to unreliable design.
+       Requires a bug report URL for historical record.'''
+    def skip_test_decorator(func):
+        def func_wrapper(*args, **kwargs):
+            if os.environ.get("QEMU_TEST_FLAKY_TESTS", None) is None:
+                case_notrun(
+                    ('{}: test is flaky (see {}) and $QEMU_TEST_FLAKY_TESTS ' +
+                     'is not set').format(args[0], bugurl))
+                return None
+            else:
+                return func(*args, **kwargs)
+        return func_wrapper
+    return skip_test_decorator
+
 # We need to filter out the time taken from the output so that
 # qemu-iotest can reliably diff the results against master output,
 # and hide skipped tests from the reference output.
-- 
2.54.0



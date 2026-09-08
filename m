Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8D5C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sVL-0004Fa-T0; Tue, 08 Sep 2026 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVK-0004FR-JX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVJ-0002h5-8X
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h45NC8FecTNEUOzbKc/p4cUQZxb46uQ+uutWrRRVbZI=;
 b=XLVZoWrTcqn1JgCOi+VvJRBAxFMVWwDwbsZibeBe44I0OUak3+WE5SI4zcWqb0fPN//1dM
 FCcmK8htYGCw2Pr9AGZUJo+/+qowd8arAhUN2gXIT9CIxWVluQAFxlSIKCZnkUOrDMdetl
 dfYQsk+heLz676urtwCCZZ6dfnaYtKY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-1z5FLesmNIq3XdiGw6rmXw-1; Tue,
 08 Sep 2026 05:52:35 -0400
X-MC-Unique: 1z5FLesmNIq3XdiGw6rmXw-1
X-Mimecast-MFC-AGG-ID: 1z5FLesmNIq3XdiGw6rmXw_1788861154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23E4C1844048; Tue,  8 Sep 2026 09:52:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52F6819560AB; Tue,  8 Sep 2026 09:52:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:59 +0400
Subject: [GIT PULL 10/10] tests: fix qemu:func-hexagon-linters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-10-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q6LE4Fr91J2kSugK7tsTuxXr+CRfx98ipN0FH65D0U8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6VCL+is4zLnJs0Dunlh0BNz7z/17RJv5pE
 LgBs8JPYLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5UlKD/4slhBI+ApQa3GmJdHup6NAwto52v9zLsA2sGMU+czn/fgtWleWg0P2SbWJbTC6MNe2VZJ
 ve+esumqDrsotzC+M6zxObqRyAc18HCyTYLOGysZ3V2a8vgUB4UY9w618iLavW67FggsaDbRKgM
 sYlR5JkDtpROjfC7TbShDBavTBcGaSlFKmkk/dAqe0FWxC+YTAlRv9wIdH4GR1h6RhjgmtL6ZTT
 c/AlGRZiZV3i7SYNTgZ4Jnjxqy0lcv6RlElM3b200EdhyeReX9y2eMKCPH3Rm1DmW7eSdAmlBrO
 jaF+YELY/jHLFA5W2r1PZBIPsy5TNSRFU+Jf6eR0dgkXdOyaN4mT8YrWC8ulB1mv6OkqZmceGcC
 I/lruah/iykb6sDuduM1JZVDeShlT5VTmhB9N3Pil/xc8aIPCCnujWForWICydCC3LHeyiaoQhh
 LpfHslnvIuq4K9R+8YKyE14QJJnMovGtpXNuErbgdS2EGJ+bhnpbJz6Q5tlDPnlestVZowmsOZB
 kvI2SoQ1DcFkL0evpr4DM2wcPo3uJQEVaHGTcBjtbI66+0dZYKJG7lXq/bjoWrdb8VPRdk8yhhE
 EgbKEXo+aDgnLhyyA4uMCrjhOQ6Imy+8I4Jj/x3ukZ6KlPrecasZeq3t87c+ihUKBHhmyQqWhXG
 75SdZZOaHbBXgxw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Fix pylint W1514: unspecified-encoding

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/hexagon/test_systests.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index 983ee1672ce4..2779efa9172f 100755
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -65,14 +65,14 @@ def test_fopen(self):
         import tempfile
         # The fopen binary has a short cmdline buffer; use a short path.
         dummy = os.path.join(tempfile.gettempdir(), "qemu_fopen_test.so")
-        with open(dummy, "w") as f:
+        with open(dummy, "w", encoding="utf-8") as f:
             f.write("valid\n")
         self.run_exit_zero("fopen", "-append", dummy)
 
     def test_ftrunc(self):
         """ftrunc truncates _testfile_ftrunc from 6 bytes to 1 byte."""
         ftrunc_path = self.scratch_file("_testfile_ftrunc")
-        with open(ftrunc_path, "w") as f:
+        with open(ftrunc_path, "w", encoding="utf-8") as f:
             f.write("valid\n")
         # Sleep 1 s so mtime change is observable
         time.sleep(1)
@@ -83,7 +83,7 @@ def test_ftrunc(self):
     def test_access(self):
         """access checks R_OK|W_OK on _testfile_access."""
         testfile = self.scratch_file("_testfile_access")
-        with open(testfile, "w") as f:
+        with open(testfile, "w", encoding="utf-8") as f:
             f.write("valid\n")
         self.run_exit_zero("access", "-append", testfile)
 

-- 
2.55.0.543.g5ebe2ebe4ea8



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DD9C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJk-0007eI-0T; Tue, 08 Sep 2026 04:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJX-0007OY-C1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJV-0007Jo-Vo
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h45NC8FecTNEUOzbKc/p4cUQZxb46uQ+uutWrRRVbZI=;
 b=CI3QJaNWtAGoRIoBu+slobZdU6fcyQ1nRaOQw4/HKDE5HxZgmYLoFtvuB3kZCJM41fGb5w
 LrM4UirwncJaTktJ1+5BO7Kk8thFzswqv6u8zEGvbyqF0Y5ZpF9Scl+UMVCy75tAeM/eSQ
 gDVJ4YKpNgbazoB6cLTaf9hkArNhnFc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-gIeul6hmPxCovDE7hUk4aQ-1; Tue,
 08 Sep 2026 04:36:16 -0400
X-MC-Unique: gIeul6hmPxCovDE7hUk4aQ-1
X-Mimecast-MFC-AGG-ID: gIeul6hmPxCovDE7hUk4aQ_1788856575
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02833182A137; Tue,  8 Sep 2026 08:36:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A4361800598; Tue,  8 Sep 2026 08:36:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:42 +0400
Subject: [GIT PULL 10/10] tests: fix qemu:func-hexagon-linters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-10-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q6LE4Fr91J2kSugK7tsTuxXr+CRfx98ipN0FH65D0U8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jYAUhJTr28eRLbDtimLKJR/HgmR0C2dsloq
 fjzczjcKxKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5a8aEACt7qgbYBU//IdPAmj7QecZ4tQRPwgdFvHWgh5GXxH0adXD8SB+//Pawi0ifFSN4RZBjS7
 PuuX7G2TuIz+Miogy+2YJuHfWwqYlUEXsEpAY5qKi46zFgeN7JFOdncXlfQTC2gW2k9vIqNFhac
 fbjLFtSresYV9SkZAX2ol5lDmhKoBBLp3JqCNZECWi/tGlzbPFtUtThooL5iw0YCtuOXJzvvHcE
 pzn94g30/EsdXfKmzblooobnEwdPLuFludeXne9eZB4Z+/puHwumm7SjT23exowZdBEqKSN+gep
 TsW+nt+kebpqniJNfifICtGL+/mpqcyt0VLRDjhWQlOrnp3NmxvUT8+gKVwZmYfj9NP650T6E4Q
 xzqOK5MwEM4t1uTy1w01CYQUD/gnn6zJ7PbOGnznjIidy71R6sjWakmGjjQy7gmkqANRY7aMqda
 oi8on9hjDSkME3ouiopsOhsKVvXbTlKjLorN4CGz3B3oQLFi5XENcW8iaN1vd9AnBQiAEM5tMp4
 uRvBhygiTbG18WLvEMrP0yJgUnpg/veJBOpDaXqSK/DwX+wRFIThSXbRSBtGNxkszNf71UwG7E8
 /HroJX1bFGvlvOEhfk9SIdU32W1rnEs93NWEAvvrf9kta4T+Mk9Aqq1VN02VSuy5ev4GViatVi+
 24inCqadgN7PRCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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



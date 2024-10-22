Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE0D2CDFF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4c-0000Me-Nl; Tue, 22 Oct 2024 12:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4a-0000Hw-1H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-00065E-8W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0ZiwsCWhMmJcdocwXil0ov8/vtrwY/088vJRb2QPCQ=;
 b=KIUZVatu1fV6QBgV6r1D3qBOJ5jvCf1RxDbClCRJJbHfsaFWJTX10ywfEqyCgZomKDMUYY
 E1E9HTY3jV8L/uZTBw8+S7dRhBMxYOLd2SkSHOj3pRSyHuNUrquk8ImTz/LM5UXUo4Gaqs
 wHwbZX8J4GcZ7Gp6dooarUNueFCxXos=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-eaeCG3_vPfKwkkCpa8PRIA-1; Tue,
 22 Oct 2024 12:49:20 -0400
X-MC-Unique: eaeCG3_vPfKwkkCpa8PRIA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 926D31955F65; Tue, 22 Oct 2024 16:49:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 199AA1956056; Tue, 22 Oct 2024 16:49:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/9] tests/qemu-iotests/211.out: Update to expect MapEntry
 'compressed' field
Date: Tue, 22 Oct 2024 18:48:57 +0200
Message-ID: <20241022164903.282174-4-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 52b10c9c0c68e90f in 2023 the QAPI MapEntry struct was
updated to add a 'compressed' field. That commit updated a number
of iotest expected-output files, but missed 211, which is vdi
specific. The result is that
 ./check -vdi
and more specifically
 ./check -vdi 211
fails because the expected and actual output don't match.

Update the reference output.

Cc: qemu-stable@nongnu.org
Fixes: 52b10c9c0c68e90f ("qemu-img: map: report compressed data blocks")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241008164708.2966400-4-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/211.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/211.out b/tests/qemu-iotests/211.out
index f02c75409c..ff9f9a6913 100644
--- a/tests/qemu-iotests/211.out
+++ b/tests/qemu-iotests/211.out
@@ -17,7 +17,7 @@ file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 134217728, "present": true, "start": 0, "zero": true}]
 === Successful image creation (explicit defaults) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -35,7 +35,7 @@ file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 cluster_size: 1048576
 
-[{"data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
+[{"compressed": false, "data": false, "depth": 0, "length": 67108864, "present": true, "start": 0, "zero": true}]
 === Successful image creation (with non-default options) ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vdi", "size": 0}}}
@@ -53,7 +53,7 @@ file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 1048576
 
-[{"data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
+[{"compressed": false, "data": true, "depth": 0, "length": 3072, "offset": 1024, "present": true, "start": 0, "zero": false}, {"compressed": false, "data": true, "depth": 0, "length": 33551360, "offset": 4096, "present": true, "start": 3072, "zero": true}]
 === Invalid BlockdevRef ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vdi", "file": "this doesn't exist", "size": 33554432}}}
-- 
2.47.0



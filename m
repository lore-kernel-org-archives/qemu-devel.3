Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77CDCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnwa-0003m5-EQ; Thu, 08 Oct 2026 09:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnwF-00033h-Ff
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnwB-0002UV-JM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMT9eini1AFVzQ5tLDCkJZu8yAlX1bYCDBnwSIMPXZA=;
 b=EL2g7hg4A4nfL4mBeWRYlbbn1Cp2n46HJXN2rea59QzpyNZGC8666qtubKGHEal7QnG9fU
 JsTu8JKDj0EqR34WTJFT1hF5VLqorYkVGWfC+HRJJ5SQcnAhoLFpR+y1sVcv4px0FLc8P/
 xveVSU3YySsKxkwMiCwAd422aMMB4sg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-ySaJJR5LNsyPvUDtnZzAiw-1; Thu,
 08 Oct 2026 09:13:28 -0400
X-MC-Unique: ySaJJR5LNsyPvUDtnZzAiw-1
X-Mimecast-MFC-AGG-ID: ySaJJR5LNsyPvUDtnZzAiw_1791465207
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 615A2183093A; Thu,  8 Oct 2026 13:13:27 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB8EC30001BB; Thu,  8 Oct 2026 13:13:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...),
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PULL 15/15] iotests/iothreads-nbd-export: Skip on s390
Date: Thu,  8 Oct 2026 08:11:54 -0500
Message-ID: <20261008131216.2437896-32-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Farman <farman@linux.ibm.com>

Running this test on s390 causes long python exception tracebacks
at the beginning of the system_reset loop. The problem appears to
be the same one described by commit ad302b21aab6, in that QEMU
will exit on s390 without any kernel or boot disk.

In other tests, this is addressed by adding -no-shutdown to the
command line, and that does create a clean failure instead of a
long line of python exceptions:

  --- /home/farman/git/qemu/tests/qemu-iotests/tests/iothreads-nbd-export.out
  +++ /home/farman/git/qemu/build/scratch/qcow2-file-iothreads-nbd-export/iothreads-nbd-export.out.bad
  @@ -16,4 +16,4 @@
   {"return": {}}
   {"return": {}}
   Checking that it is still alive...
  -{"return": {"running": true, "status": "running"}}
  +{"return": {"running": false, "status": "prelaunch"}}
  Failures: iothreads-nbd-export
  Failed 1 of 1 iotests

...but obviously this isn't still a successful test, since it is
expected that the guest will be still be usable after the reset loop.
So, barring a solution to that, just skip this test on s390.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-ID: <20260925194409.716498-6-farman@linux.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-nbd-export | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/tests/iothreads-nbd-export b/tests/qemu-iotests/tests/iothreads-nbd-export
index 037260729c7..72493ad2279 100755
--- a/tests/qemu-iotests/tests/iothreads-nbd-export
+++ b/tests/qemu-iotests/tests/iothreads-nbd-export
@@ -25,6 +25,11 @@ import iotests
 iotests.script_initialize(supported_fmts=['qcow2'],
                           supported_platforms=['linux'])

+# QEMU on s390 will exit without any sort of backing disk,
+# so the reset loop requested by this test will fail.
+if iotests.qemu_default_machine == 's390-ccw-virtio':
+    iotests.notrun('Cannot run test on s390')
+
 with iotests.FilePath('disk1.img') as path, \
      iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock, \
      qemu.machine.QEMUMachine(iotests.qemu_prog) as vm:
-- 
2.56.0



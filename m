Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A470CCCF9F6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xT-0003DL-Mw; Wed, 29 Oct 2025 08:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xK-00039G-PJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4x9-00050f-7o
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUxKI9ns8Nrn0orRcTM3BhllWySnqVTo3lPyM2Y42S8=;
 b=RsZf1NnaBacOEsSu08CY4WZLcDwiVpyAfXrUDLcbw52xNfKhLywLUEJSLnnDBqneMTGUJW
 bhg9Jb7eu3dqlMr3MhCl3VI9MzBOue4Th+q355Jk6Pjh+uUyRMnLWFwM6XD9tjSs+ZLSSW
 Gkw/YppF+56PJg2OaVQX4PZv6Y6waaI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-7K41TIr5P6OEsU2S0XbAYg-1; Wed,
 29 Oct 2025 08:06:52 -0400
X-MC-Unique: 7K41TIr5P6OEsU2S0XbAYg-1
X-Mimecast-MFC-AGG-ID: 7K41TIr5P6OEsU2S0XbAYg_1761739611
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5FA81801231; Wed, 29 Oct 2025 12:06:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77FBB180057C; Wed, 29 Oct 2025 12:06:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/18] iotests: Adjust fuse-allow-other expected output
Date: Wed, 29 Oct 2025 13:06:23 +0100
Message-ID: <20251029120634.288467-8-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eric Blake <eblake@redhat.com>

The iotest fuse-allow-other has been broken since commit effd60c8 in
v9.0.0; but as Dan Berrange's efforts to improve CI have proven, we
haven't been reliably running it to notice.  The change in that commit
was good (moving coroutine commands to run in the right context), but
it meant that "execute":"quit" now waits to complete until the
coroutines tearing down fuse have first reported the SHUTDOWN event,
in the opposite order of what happened pre-patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context",
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251021205843.2585624-2-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/fuse-allow-other.out | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/tests/fuse-allow-other.out b/tests/qemu-iotests/tests/fuse-allow-other.out
index 543fa52a06..3219fc35e0 100644
--- a/tests/qemu-iotests/tests/fuse-allow-other.out
+++ b/tests/qemu-iotests/tests/fuse-allow-other.out
@@ -28,9 +28,9 @@ stat: cannot statx 'fuse-export': Permission denied
 cat: fuse-export: Permission denied
 stat: cannot statx 'fuse-export': Permission denied
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}
 
 --- allow-other=on ---
 {'execute': 'qmp_capabilities'}
@@ -55,9 +55,9 @@ Permissions seen by nobody: 444
 cat: fuse-export: Permission denied
 Permissions seen by nobody: 440
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}
 
 --- allow-other=auto ---
 {'execute': 'qmp_capabilities'}
@@ -82,7 +82,7 @@ Permissions seen by nobody: 444
 cat: fuse-export: Permission denied
 Permissions seen by nobody: 440
 {'execute': 'quit'}
-{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "export"}}
+{"return": {}}
 *** done
-- 
2.51.0



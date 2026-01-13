Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB3D2D108
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vffDh-0005Qt-Dv; Tue, 13 Jan 2026 09:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vffDZ-0005QO-2S
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vffDX-0004Rp-FU
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 09:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768313871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O7DxV0rHCGZeu0f/wRF659gzDFMEGnIhuADhFcngc/8=;
 b=ERsjukPObaPw7sxdOQWcpvmO2fOLqBmYbyRj5Sk0o9GIHMFRj+obW8jVgFD4FC97mYbJod
 jFdXAYSzV6zDh1ek4iPja7f+tkImGQO1sd11vK7rGoUmHsmCh4i9H1o5pv6dr9sFQKuCoh
 mcYYc7h09qgdbwQYuNKLCuDWk0WVSJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-x4y3Il88Ot-yYC2tygcY8Q-1; Tue,
 13 Jan 2026 09:17:49 -0500
X-MC-Unique: x4y3Il88Ot-yYC2tygcY8Q-1
X-Mimecast-MFC-AGG-ID: x4y3Il88Ot-yYC2tygcY8Q_1768313868
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ACFF1954B06; Tue, 13 Jan 2026 14:17:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5225F30001A2; Tue, 13 Jan 2026 14:17:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/qemu-iotests: Mark 182 as Linux-only
Date: Tue, 13 Jan 2026 15:17:44 +0100
Message-ID: <20260113141744.97469-1-thuth@redhat.com>
MIME-Version: 1.0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Running test 182 on FreeBSD fails with this error message in the output:

 +warning: File lock requested but OFD locking syscall is unavailable, falling back to POSIX file locks
 +Due to the implementation, locks can be lost unexpectedly.

OFD locks seem to be only available on Linux, so let's mark this
test as Linux-only to silence the failure.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/182 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index bbd1132b052..af5eeb599c1 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
+_supported_os Linux
 
 size=32M
 
-- 
2.52.0



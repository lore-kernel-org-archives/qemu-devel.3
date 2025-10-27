Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D6ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKeg-0006zN-4l; Mon, 27 Oct 2025 06:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDKeL-0006Zm-11
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDKeF-0001Q5-Ck
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761561620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SxnX81cpJVMMcPQuuzxhikMfv0rbmxiMIZ9cPg0ZaHg=;
 b=K9/MN3R2p+queJIwfCbBJHFaKczGXqmP5v4WjSETGXauPz0BxR8/vJtl03XWrAof548h8f
 28zLD0m7hJvbYkj0rUBsB1Lo4fyH8s6nsAVQA17RPtxklOLRIvsLRekc8dindHeMzGPPhF
 6PgEEjgFhSp9FzSuBXsFhCOGrtIMbTw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-FjCroFjONoOVQ2Qp1yBvUw-1; Mon,
 27 Oct 2025 06:40:17 -0400
X-MC-Unique: FjCroFjONoOVQ2Qp1yBvUw-1
X-Mimecast-MFC-AGG-ID: FjCroFjONoOVQ2Qp1yBvUw_1761561616
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D5CC19560AF; Mon, 27 Oct 2025 10:40:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDCB51955F1B; Mon, 27 Oct 2025 10:40:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] tests/functional/i386: Remove unused variable from the replay
 test
Date: Mon, 27 Oct 2025 11:40:12 +0100
Message-ID: <20251027104012.51682-1-thuth@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove a left-over from the time when this test was still an
avocado-based test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/i386/test_replay.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/i386/test_replay.py b/tests/functional/i386/test_replay.py
index 7c4c2602da9..3a92ecde173 100755
--- a/tests/functional/i386/test_replay.py
+++ b/tests/functional/i386/test_replay.py
@@ -17,7 +17,6 @@ class I386Replay(ReplayKernelBase):
 
     def test_pc(self):
         self.set_machine('pc')
-        kernel_url = ()
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
         console_pattern = 'VFS: Cannot open root device'
-- 
2.51.0



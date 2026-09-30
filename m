Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDA5CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw4r-0007Bl-3t; Wed, 30 Sep 2026 11:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBw4n-0007BO-S5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBw4l-0001IQ-L6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lyA71xFaduauOkFSLPylVOSgrHiJZlwUq6xGuj5wK+M=;
 b=RMiBefmgnPnfv0YKudYaVpy63L84qH2/rIHGU8gpT+5q4t03Xg8yZZvk/aONbZMbn54Y5h
 8jSh99f8TY/CkhgPxwu6khDYA0vGEZH2TZqv5yt6fLnx+pBN4LzBcMjFOtX9oaTK35YAOc
 FdL+FgxWIlw7SqHsrU19nHA1mQFKrHo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-qmJwnnrrMtSa0pQC6W1Kkw-1; Wed,
 30 Sep 2026 11:18:28 -0400
X-MC-Unique: qmJwnnrrMtSa0pQC6W1Kkw-1
X-Mimecast-MFC-AGG-ID: qmJwnnrrMtSa0pQC6W1Kkw_1790781507
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA578195D02D
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 15:18:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.222])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAB061956050; Wed, 30 Sep 2026 15:18:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2] qapi: convert intro sections fixup
Date: Wed, 30 Sep 2026 11:18:25 -0400
Message-ID: <20260930151825.3161398-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"We" (Me, I, Myself) missed two last spots during bulk conversion of the
intro section syntax.

Some definitions are still intentionally left without an intro
section: BlockdevSnapshotSync is the only case I am presently aware
of.

The remaining two were genuinely just missed; convert them now.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-s390x.json |  4 ++--
 qapi/qom.json           | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index 8d8cbe2fb75..9ae559bbc2d 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -150,8 +150,8 @@
 
 ##
 # @DummyBootCertificates:
-#
-# Not used by QMP; hack to let us use BootCertificatesList internally.
+#     Not used by QMP; hack to let us use BootCertificatesList
+#     internally.
 #
 # Since: 11.2
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index e03ede34421..34e23003c26 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1039,16 +1039,16 @@
 
 ##
 # @SevSnpGuestProperties:
+#     Properties for sev-snp-guest objects.  Most of these are direct
+#     arguments for the KVM_SNP_* interfaces documented in the Linux
+#     kernel source under
+#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
+#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
+#     commands documented in the SEV-SNP Firmware ABI Specification
+#     (Rev 0.9).
 #
-# Properties for sev-snp-guest objects.  Most of these are direct
-# arguments for the KVM_SNP_* interfaces documented in the Linux
-# kernel source under
-# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
-# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
-# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
-#
-# More usage information is also available in the QEMU source tree
-# under docs/amd-memory-encryption.
+#     More usage information is also available in the QEMU source tree
+#     under docs/amd-memory-encryption.
 #
 # @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
 #     defined in the SEV-SNP firmware ABI (default: 0x30000)
-- 
2.55.0



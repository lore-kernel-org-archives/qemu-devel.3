Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4863DCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 22:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBgLr-0002BM-SD; Tue, 29 Sep 2026 18:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBgLk-00029m-3E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 18:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBgLf-00014F-16
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 18:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790721052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QBdLpLkQHs+63P3JZoRbxhqP2/CY8BTAv6o77RD771A=;
 b=BJw7516/ZSzXbskSRUD3mNbtxdtKBtqgCtlU/vyVCKnj49039lmwXyF2rECcGP62kCme02
 ffQ4rY+Xm2GfFqYy0lsZqKzSuxPppHZ+6b3Td6qYkk3jamDwX7Jv9S20RPpYrP0gPoK8HK
 JpOh4Di4FVobkgigpWmF4rGLi7Lp+Lk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-m5IXl5_2Og6Y-HuwCwlRKg-1; Tue,
 29 Sep 2026 18:30:51 -0400
X-MC-Unique: m5IXl5_2Og6Y-HuwCwlRKg-1
X-Mimecast-MFC-AGG-ID: m5IXl5_2Og6Y-HuwCwlRKg_1790721050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0127A196C40B
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 22:30:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E8A51800577; Tue, 29 Sep 2026 22:30:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] qapi: convert intro sections fixup
Date: Tue, 29 Sep 2026 18:30:44 -0400
Message-ID: <20260929223044.2998391-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
 qapi/qom.json           | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

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
index e03ede34421..2d0d0e47fbb 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1039,13 +1039,13 @@
 
 ##
 # @SevSnpGuestProperties:
-#
-# Properties for sev-snp-guest objects.  Most of these are direct
-# arguments for the KVM_SNP_* interfaces documented in the Linux
-# kernel source under
-# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
-# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
-# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
+#     Properties for sev-snp-guest objects.  Most of these are direct
+#     arguments for the KVM_SNP_* interfaces documented in the Linux
+#     kernel source under
+#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
+#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
+#     commands documented in the SEV-SNP Firmware ABI Specification
+#     (Rev 0.9).
 #
 # More usage information is also available in the QEMU source tree
 # under docs/amd-memory-encryption.
-- 
2.55.0



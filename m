Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0338606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TR75S96q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxI5-0004U9-6l; Fri, 27 Nov 2026 09:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxI3-0004Q6-Us
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:51:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWxI2-0007cB-8P
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795791064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkPO6xB2XfCyuDzVe0pC1SVXStdqnPBRoms+gdmjwv0=;
 b=TR75S96q+MRpmaz1hR45Y9TZf4bc73LYitoox0eV49HD9lI/hkYQc+uFstzuI9XxFRZX0j
 KG4RefBxQWWjIyuMXAIZ3+psfJlhQwoKiVCFHinu3gS7wuiiG46KKe+ZoFLoZniLUDpxwB
 X0+D6T+/qgM1a5yZTkb6u84raJUNKjM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-yD1xZ3H0PByVsfmaXu6zaw-1; Fri,
 27 Nov 2026 14:51:02 +0000
X-MC-Unique: yD1xZ3H0PByVsfmaXu6zaw-1
X-Mimecast-MFC-AGG-ID: yD1xZ3H0PByVsfmaXu6zaw_1795791061
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA4518002C6
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:51:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F023F1801A78
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:51:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 742A521E692D; Fri, 27 Nov 2026 15:50:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	eblake@redhat.com
Subject: [PATCH v2 1/2] qapi: convert intro sections fixup
Date: Fri, 27 Nov 2026 15:50:57 +0100
Message-ID: <20261127145058.191944-2-armbru@redhat.com>
In-Reply-To: <20261127145058.191944-1-armbru@redhat.com>
References: <20261127145058.191944-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: John Snow <jsnow@redhat.com>

"We" (Me, I, Myself) missed two last spots during bulk conversion of the
intro section syntax.

BlockdevSnapshotSync is intentionally left without an intro section.

Two more were genuinely just missed; convert them now.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
[SevSnpGuestProperties intro split]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine-s390x.json | 4 ++--
 qapi/qom.json           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index 32a59269361..6b6f63216cf 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1054,10 +1054,10 @@
 
 ##
 # @SevSnpGuestProperties:
+#     Properties for sev-snp-guest objects.
 #
-# Properties for sev-snp-guest objects.  Most of these are direct
-# arguments for the KVM_SNP_* interfaces documented in the Linux
-# kernel source under
+# Most of these are direct arguments for the KVM_SNP_* interfaces
+# documented in the Linux kernel source under
 # Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
 # closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
 # documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
-- 
2.55.0



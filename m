Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADABCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrjQ-00026r-Vx; Wed, 30 Sep 2026 06:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrih-0001Ic-Dm
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jP-DT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NqzFE4icAEkOZSrELr1wFVdLZElSFKv4bQfvHL4fI9E=;
 b=TO+gwLUVRXpt6/saZfLqP8eRW23Az+wRFLhxPHUY4Z20dHiCzm+h9XRdzIMMOjEsUH3GIz
 hIbRusue2uizdWUnJF6Pesrw+1MAMj9FtTQID8gm0BYwEJeNtNo9AXpad86tsH83iY6FoZ
 QEKLLOnAOXUq5tcebjVhyuPGFeXYBC0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-vbyes21MNRWYTgJoQB4GJA-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: vbyes21MNRWYTgJoQB4GJA-1
X-Mimecast-MFC-AGG-ID: vbyes21MNRWYTgJoQB4GJA_1790764759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4104B1808873; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F298A1956042; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09B4B21E68A0; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 028/105] qapi: convert trivial intro sections for misc-i386.json
Date: Wed, 30 Sep 2026 12:37:53 +0200
Message-ID: <20260930103910.3934848-29-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-29-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-i386.json | 52 ++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c41..78ec9aec64 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -25,8 +25,7 @@
 
 ##
 # @SevState:
-#
-# An enumeration of SEV state information used during `query-sev`.
+#     An enumeration of SEV state information used during `query-sev`.
 #
 # @uninit: The guest is uninitialized.
 #
@@ -52,8 +51,7 @@
 
 ##
 # @SevGuestType:
-#
-# An enumeration indicating the type of SEV guest being run.
+#     An enumeration indicating the type of SEV guest being run.
 #
 # @sev: The guest is a legacy SEV or SEV-ES guest.
 #
@@ -66,8 +64,7 @@
 
 ##
 # @SevGuestInfo:
-#
-# Information specific to legacy SEV/SEV-ES guests.
+#     Information specific to legacy SEV/SEV-ES guests.
 #
 # @policy: SEV policy value
 #
@@ -81,8 +78,7 @@
 
 ##
 # @SevSnpGuestInfo:
-#
-# Information specific to SEV-SNP guests.
+#     Information specific to SEV-SNP guests.
 #
 # @snp-policy: SEV-SNP policy value
 #
@@ -93,8 +89,7 @@
 
 ##
 # @SevInfo:
-#
-# Information about Secure Encrypted Virtualization (SEV) support
+#     Information about Secure Encrypted Virtualization (SEV) support
 #
 # @enabled: true if SEV is active
 #
@@ -144,8 +139,7 @@
 
 ##
 # @SevLaunchMeasureInfo:
-#
-# SEV Guest Launch measurement information
+#     SEV Guest Launch measurement information
 #
 # @data: the measurement value encoded in base64
 #
@@ -180,9 +174,8 @@
 
 ##
 # @SevCapability:
-#
-# The struct describes capability for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes capability for a Secure Encrypted
+#     Virtualization feature.
 #
 # @pdh: Platform Diffie-Hellman key (base64 encoded)
 #
@@ -252,9 +245,8 @@
 
 ##
 # @SevAttestationReport:
-#
-# The struct describes attestation report for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes attestation report for a Secure Encrypted
+#     Virtualization feature.
 #
 # @data: guest attestation report (base64 encoded)
 #
@@ -294,8 +286,7 @@
 
 ##
 # @SgxEpcSection:
-#
-# Information about intel SGX EPC section
+#     Information about intel SGX EPC section
 #
 # @node: the numa node
 #
@@ -309,8 +300,7 @@
 
 ##
 # @SgxInfo:
-#
-# Information about intel Safe Guard eXtension (SGX) support
+#     Information about intel Safe Guard eXtension (SGX) support
 #
 # @sgx: true if SGX is supported
 #
@@ -333,8 +323,7 @@
 
 ##
 # @query-sgx:
-#
-# Return information about configured SGX capabilities of guest
+#     Return information about configured SGX capabilities of guest
 #
 # Since: 6.2
 #
@@ -350,8 +339,7 @@
 
 ##
 # @query-sgx-capabilities:
-#
-# Return information about SGX capabilities of host
+#     Return information about SGX capabilities of host
 #
 # Since: 6.2
 #
@@ -367,8 +355,7 @@
 
 ##
 # @EvtchnPortType:
-#
-# An enumeration of Xen event channel port types.
+#     An enumeration of Xen event channel port types.
 #
 # @closed: The port is unused.
 #
@@ -389,8 +376,7 @@
 
 ##
 # @EvtchnInfo:
-#
-# Information about a Xen event channel port
+#     Information about a Xen event channel port
 #
 # @port: the port number
 #
@@ -419,8 +405,7 @@
 
 ##
 # @xen-event-list:
-#
-# Query the Xen event channels opened by the guest.
+#     Query the Xen event channels opened by the guest.
 #
 # Returns: list of open event channel ports.
 #
@@ -456,8 +441,7 @@
 
 ##
 # @xen-event-inject:
-#
-# Inject a Xen event channel port (interrupt) to the guest.
+#     Inject a Xen event channel port (interrupt) to the guest.
 #
 # @port: The port number
 #
-- 
2.55.0



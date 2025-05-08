Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC1C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1lv-0002g2-V7; Thu, 08 May 2025 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lk-0002IT-Gx
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1li-00078w-Ki
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hPoX3+g5yoi+lu2W5gYVL/9YBdd/J2tb6XH0pc+jbBQ=;
 b=cBNx05moqg2XJrhxllxaqWJO6ayU/QCKVPd49Xcd7pybsj5c130Itc5mZWtaMIO2B7oQUC
 Y5OgOImNRz+OVJ3RIYMccYAkqbhE5bvEBoqIbBGwNpXng3oaOCYst/2rNf+pEWwFWPr+OC
 Qk0w9t+Hld7rjVfofaafJyuiQ2KVRHA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-K2EpjwVSOOO1PJj9tiAUWQ-1; Thu,
 08 May 2025 09:58:30 -0400
X-MC-Unique: K2EpjwVSOOO1PJj9tiAUWQ-1
X-Mimecast-MFC-AGG-ID: K2EpjwVSOOO1PJj9tiAUWQ_1746712709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E420180036F; Thu,  8 May 2025 13:58:29 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB46E180049D; Thu,  8 May 2025 13:58:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/10] qapi: expand docs for SEV commands
Date: Thu,  8 May 2025 14:58:08 +0100
Message-ID: <20250508135816.673087-3-berrange@redhat.com>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This gives some more context about the behaviour of the commands in
unsupported guest configuration or platform scenarios.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 5d0ffb0164..ae55e437a5 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -110,7 +110,11 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV
+# Returns information about SEV/SEV-ES/SEV-SNP.
+#
+# If unavailable due to an incompatible configuration the
+# returned @enabled field will be set to 'false' and the
+# state of all other fields is undefined.
 #
 # Returns: @SevInfo
 #
@@ -141,7 +145,16 @@
 ##
 # @query-sev-launch-measure:
 #
-# Query the SEV guest launch information.
+# Query the SEV/SEV-ES guest launch information.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The launch
+# measurement for SEV-SNP guests is only available within
+# the guest.
+#
+# This will return an error if the launch measurement is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
@@ -185,8 +198,9 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is supported
-# on AMD X86 platforms only.
+# This command is used to get the SEV capabilities, and is only
+# supported on AMD X86 platforms with KVM enabled. If SEV is not
+# available on the platform an error will be returned.
 #
 # Returns: SevCapability objects.
 #
@@ -205,7 +219,15 @@
 ##
 # @sev-inject-launch-secret:
 #
-# This command injects a secret blob into memory of SEV guest.
+# This command injects a secret blob into memory of a SEV/SEV-ES guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. SEV-SNP guests
+# do not support launch secret injection
+#
+# This will return an error if launch secret injection is not possible,
+# either due to an invalid guest configuration, or if the guest has not
+# reached the required SEV state.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -236,8 +258,15 @@
 ##
 # @query-sev-attestation-report:
 #
-# This command is used to get the SEV attestation report, and is
-# supported on AMD X86 platforms only.
+# This command is used to get the SEV attestation report.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
+# This will return an error if the attestation report is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
-- 
2.49.0



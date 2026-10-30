Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FLskoT5j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnQH-0002T7-4m; Fri, 30 Oct 2026 10:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQA-0002Ry-F2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQ9-0002oq-1u
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793369848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqLvTrUpoKCpiDVokF7a6j+p2iqFovepChBZfkThh6c=;
 b=FLskoT5jGZD6jwQdk0fGe6USDA5v4aGq6xmLndqYk6zOoo/+O+ftMdDsRvmI+DX+t3rVyt
 dWtuUSynX2aJywO3O9Eiv81lou1p61SBk17gqlaSnd0evUWOO/nFN9RpuCxWHwb/OWVrvl
 pzW4ubaqzl1WE+RO1bWEeFWlXZSLW60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-YKLGxFIcMDaWA9CYd9eevg-1; Fri,
 30 Oct 2026 10:17:23 -0400
X-MC-Unique: YKLGxFIcMDaWA9CYd9eevg-1
X-Mimecast-MFC-AGG-ID: YKLGxFIcMDaWA9CYd9eevg_1793369842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14E51955E97; Fri, 30 Oct 2026 14:17:22 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A8A41800347; Fri, 30 Oct 2026 14:17:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 3/8] qapi: rename 'insecure-types' to 'insecure-input'
Date: Fri, 30 Oct 2026 14:17:08 +0000
Message-ID: <20261030141713.2841710-4-berrange@redhat.com>
In-Reply-To: <20261030141713.2841710-1-berrange@redhat.com>
References: <20261030141713.2841710-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This provides better conceptual naming alignment with other
-compat flags.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 2 +-
 qapi/compat.json         | 4 ++--
 qapi/qapi-util.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index 75e39caedea..e211fdd2344 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -168,7 +168,7 @@ eligible for CVE assignment. Annotations will be extended to other backend
 and object types over time, to make their security status explicit.
 
 It is possible to control or identify the usage of types that do not offer
-an explicit security boundary using the ``insecure-types`` parameter to the
+an explicit security boundary using the ``insecure-input`` parameter to the
 ``-compat`` argument, which accepts three values:
 
  * accept: usage of any type will be permitted. This is the current
diff --git a/qapi/compat.json b/qapi/compat.json
index 60591468ec0..61a670e3cda 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -80,7 +80,7 @@
 # @unstable-output: how to handle unstable output (default 'accept')
 #     (since 6.2)
 #
-# @insecure-types: how to handle types that are not declared secure
+# @insecure-input: how to handle types that are not declared secure
 #     (default 'accept') (since 11.2)
 #
 # Since: 6.0
@@ -90,4 +90,4 @@
             '*deprecated-output': 'CompatPolicyOutput',
             '*unstable-input': 'CompatPolicyInput',
             '*unstable-output': 'CompatPolicyOutput',
-            '*insecure-types': 'CompatPolicySecurity' } }
+            '*insecure-input': 'CompatPolicySecurity' } }
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index fe0a6a57c85..e5d8662f8bb 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -72,7 +72,7 @@ bool compat_policy_check_security(const CompatPolicy *policy,
         return true;
     }
 
-    switch (policy->insecure_types) {
+    switch (policy->insecure_input) {
     case COMPAT_POLICY_SECURITY_ACCEPT:
         return true;
 
-- 
2.56.0



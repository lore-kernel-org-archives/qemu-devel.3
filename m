Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8E606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jAkhtU+i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3pN-0004xX-La; Wed, 28 Oct 2026 09:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pB-0004vP-9x
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3p8-0007gE-RM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1+rq7QSkU88zkvPLsIUznOuFo3T8ZSDb3UEZtedQDwY=;
 b=jAkhtU+iJHBwzplQ0DnkN1gPpd/V54u1RGyyT3Ykx5+6gbf4zzRRFBB/sgNvz2YZ+oeYGN
 qb1eT3oH5OhRk2YyExouKScKg4D83DoG4FKH8qZihMIWMSTQuZp4Kwgb/1pioFnlwhMLSL
 DACIAvTUOkQJ18pP8glb88fm7ljXJ/A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-QESZrijDNrKwqmLqGYoSWQ-1; Wed,
 28 Oct 2026 09:36:12 -0400
X-MC-Unique: QESZrijDNrKwqmLqGYoSWQ-1
X-Mimecast-MFC-AGG-ID: QESZrijDNrKwqmLqGYoSWQ_1793194571
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1353B18021D0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:11 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CEA530002D0; Wed, 28 Oct 2026 13:36:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/8] qapi: rename 'insecure-types' to 'insecure-input'
Date: Wed, 28 Oct 2026 13:35:58 +0000
Message-ID: <20261028133603.1893289-4-berrange@redhat.com>
In-Reply-To: <20261028133603.1893289-1-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
index dfa3fea0577..f28c24149c8 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -77,7 +77,7 @@
 # @unstable-output: how to handle unstable output (default 'accept')
 #     (since 6.2)
 #
-# @insecure-types: how to handle types that are not declared secure
+# @insecure-input: how to handle types that are not declared secure
 #     (default 'accept') (since 11.2)
 #
 # Since: 6.0
@@ -87,4 +87,4 @@
             '*deprecated-output': 'CompatPolicyOutput',
             '*unstable-input': 'CompatPolicyInput',
             '*unstable-output': 'CompatPolicyOutput',
-            '*insecure-types': 'CompatPolicySecurity' } }
+            '*insecure-input': 'CompatPolicySecurity' } }
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index f81a171a5b1..e6f3006b16c 100644
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



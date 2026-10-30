Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F95606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HepLykSk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnQM-0002WZ-Mc; Fri, 30 Oct 2026 10:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQF-0002TG-P4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMnQE-0002pN-61
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793369853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE9JxlguqZcZ4uic8sGueLBZLsRv4rO+wuswEaNRj1o=;
 b=HepLykSkKV+C0dcvFpSK3PIiNMBe4rbKacSdp/FOI+2kYtTGzVUix2a4+Kgh6eZm6jtgvv
 5yHYCrmrPs11hg6Vr32QbCf7Iuz3wA48ex5RjC/kNO/Vh5eP2LLb9AtEW4ooSEwuAvwiMR
 XQ9Dr2q2wfBzRuR7M4AUKfTvyMGYcew=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-s5v3ufbUNKWQX2Y3Qh_zaA-1; Fri,
 30 Oct 2026 10:17:32 -0400
X-MC-Unique: s5v3ufbUNKWQX2Y3Qh_zaA-1
X-Mimecast-MFC-AGG-ID: s5v3ufbUNKWQX2Y3Qh_zaA_1793369851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3160D1801BD5; Fri, 30 Oct 2026 14:17:31 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9153E1800480; Fri, 30 Oct 2026 14:17:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 7/8] qemu-options: document -compat insecure-input parameter
Date: Fri, 30 Oct 2026 14:17:12 +0000
Message-ID: <20261030141713.2841710-8-berrange@redhat.com>
In-Reply-To: <20261030141713.2841710-1-berrange@redhat.com>
References: <20261030141713.2841710-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This adds documentation for the previously added 'insecure-input'
parameter to -compat, which controls policy for insecure
configuration requests.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 854341e7a07..0b8e6d0d8a9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4696,7 +4696,9 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
     "-compat [deprecated-input=accept|reject|crash|warn][,deprecated-output=accept|hide]\n"
     "                Policy for handling deprecated management interfaces\n"
     "-compat [unstable-input=accept|reject|crash|warn][,unstable-output=accept|hide]\n"
-    "                Policy for handling unstable management interfaces\n",
+    "                Policy for handling unstable management interfaces\n"
+    "-compat [insecure-input=accept|reject|crash|warn]\n"
+    "                Policy for handling insecure configuration requests\n",
     QEMU_ARCH_ALL)
 SRST
 ``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
@@ -4736,6 +4738,25 @@ SRST
         Suppress unstable command results and events
 
     Limitation: covers only syntactic aspects of QMP.
+
+``-compat [insecure-input=<input-policy>]``
+    Set policy for handling insecure configuration requests:
+
+    ``insecure-input=accept`` (default)
+        Accept insecure configurations requests silently
+    ``insecure-input=warn``
+        Accept insecure configuration requests with warning repeated
+        warnings on stderr
+    ``insecure-input=reject``
+        Reject insecure configuration requests
+    ``insecure-input=crash``
+        Crash on insecure configuration requests
+
+    Limitation: an insecure configuration is one where QEMU does
+    not provide a security boundary to protect against malicious
+    usage / untrusted data. Covers only user creatable QOM types
+    for devices, machine types and accelerators. Implicitly created
+    QOM types and parent types are not checked at this time.
 ERST
 
 DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
-- 
2.56.0



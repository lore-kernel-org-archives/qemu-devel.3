Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R4JzzStt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3pg-00054X-5K; Wed, 28 Oct 2026 09:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pN-0004xy-TP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xM3pJ-0007hB-Pe
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793194579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlXKjct+pS1q6/UVSHZyFHDD3PQ7ReTmBlruhCI3o30=;
 b=R4JzzSttNBzIZUx47fYH6Ep6S6iNfdA5LkXyFeAFdASOWPrrSBA95Qb0joUi7fzFsuqbg1
 ysAPDhf8dRIlJrI4cV03tGdLWqoUsk0iMIBWA1NdQ9QOStANFDWgasglJX+ewBmayCTVQk
 IFtfp16TFAzda3v58uaYa2n6+HLUjmg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-_yRIA2rPNQSp70WVPlUV4w-1; Wed,
 28 Oct 2026 09:36:17 -0400
X-MC-Unique: _yRIA2rPNQSp70WVPlUV4w-1
X-Mimecast-MFC-AGG-ID: _yRIA2rPNQSp70WVPlUV4w_1793194576
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DEFD1955DC1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:36:16 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EB4D30002CB; Wed, 28 Oct 2026 13:36:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 7/8] qemu-options: document -compat insecure-input parameter
Date: Wed, 28 Oct 2026 13:36:02 +0000
Message-ID: <20261028133603.1893289-8-berrange@redhat.com>
In-Reply-To: <20261028133603.1893289-1-berrange@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds documentation for the previously added 'insecure-input'
parameter to -compat, which controls policy for insecure
configuration requests.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 16d9c6c9072..0487e74bb3e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4696,7 +4696,9 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
     "-compat [deprecated-input=accept|reject|crash|warn][,deprecated-output=accept|hide]\n"
     "                Policy for handling deprecated management interfaces\n"
     "-compat [unstable-input=accept|reject|crash|warn][,unstable-output=accept|hide]\n"
-    "                Policy for handling unstable management interfaces\n",
+    "                Policy for handling unstable management interfaces\n"
+    "-compat [insecure-input=accept|reject|crash|warn]\n"
+    "                Policy for handling requests for insecure configuration requests\n",
     QEMU_ARCH_ALL)
 SRST
 ``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
@@ -4734,6 +4736,24 @@ SRST
         Suppress unstable command results and events
 
     Limitation: covers only syntactic aspects of QMP.
+
+``-compat [insecure-input=<input-policy>]
+    Set policy for handling requests for insecure configuration
+    requests:
+
+    ``insecure-input=accept`` (default)
+        Accept insecure configurations requests silently
+    ``insecure-input=warn``
+        Accept insecure configuration requests with warning on stderr
+    ``insecure-input=reject``
+        Reject insecure configuration requests
+    ``insecure-input=crash``
+        Crash on insecure configuration requests
+
+    Limitation: an insecure configuration is one where QEMU has
+    not intended to provide a security boundary to protect against
+    malicious usage. Covers only QOM types for devices, machine types
+    and accelerators.
 ERST
 
 DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
-- 
2.56.0



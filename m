Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE719CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpvv-0005EU-MT; Mon, 07 Oct 2024 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvr-0005A9-V6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvp-0002YO-Su
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728315957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHT9bzk7iZ6Hr+wEwZTdWZD3MAdisW6GXcAQc3HKdK4=;
 b=Y6CjvnMIWSglvpC5qP1c9LAiIokqr+3HUrzQ818JU5qSHtlMbFxq0QrZO5lN7plP1AI2Ts
 4Gd4ToETeoh/unTX7sR1AAtvXM69LaNPgYJpEmJYBGWFM1TXjMRWppM6xktveI1EPstnzP
 1LCVVZgL/1T3M4ggR27Phalj0dJmfA4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-IFfafe2BPlu2eelkoAN5VQ-1; Mon,
 07 Oct 2024 11:45:56 -0400
X-MC-Unique: IFfafe2BPlu2eelkoAN5VQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ABE61978F59
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 15:45:54 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E14F300019E; Mon,  7 Oct 2024 15:45:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] scripts: validate SPDX license choices
Date: Mon,  7 Oct 2024 16:45:47 +0100
Message-ID: <20241007154548.1144961-3-berrange@redhat.com>
In-Reply-To: <20241007154548.1144961-1-berrange@redhat.com>
References: <20241007154548.1144961-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We expect all new code to be contributed with the "GPL-2.0-or-later"
license tag. Divergance is permitted if the new file is derived from
pre-existing code under a different license, whether from elsewhere
in QEMU codebase, or outside.

Issue a warning if the declared license is not "GPL-2.0-or-later",
and an error if the license is not one of the handful of the
expected licenses to prevent unintended proliferation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cc266abdcd..cd1ed90f4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1353,6 +1353,67 @@ sub checkfilename {
 	}
 }
 
+sub checkspdx {
+    my ($file, $expr) = @_;
+
+    # Imported Linux headers probably have SPDX tags, but if they
+    # don't we're not requiring contributors to fix this
+    if ($file =~ m,include/standard-headers, ||
+	$file =~ m,linux-headers,) {
+	return;
+    }
+
+    my $origexpr = $expr;
+
+    # Flatten sub-expressions
+    $expr =~ s/\(|\)/ /g;
+    $expr =~ s/OR|AND/ /g;
+
+    # Merge WITH exceptions to the license
+    $expr =~ s/\s+WITH\s+/-WITH-/g;
+
+    # Cull more leading/trailing whitespace
+    $expr =~ s/^\s*//g;
+    $expr =~ s/\s*$//g;
+
+    my @bits = split / +/, $expr;
+
+    my $prefer = "GPL-2.0-or-later";
+    my @valid = qw(
+	LGPL-2.0-or-later
+	LGPL-2.1-or-later
+	GPL-2.0-only
+	LGPL-2.0-only
+	LGPL-2.0-only
+	BSD-2-Clause
+	BSD-3-Clause
+	MIT
+	);
+
+    my $nonpreferred = 0;
+    my @unknown = ();
+    foreach my $bit (@bits) {
+	if ($bit eq $prefer) {
+	    next;
+	}
+	if (grep /^$bit$/, @valid) {
+	    $nonpreferred = 1;
+	} else {
+	    push @unknown, $bit;
+	}
+    }
+    if (@unknown) {
+	ERROR("Saw unacceptable licenses '" . join(',', @unknown) .
+	      "', valid choices for QEMU are:\n" . join("\n", $prefer, @valid));
+    }
+
+    if ($nonpreferred) {
+	WARN("Saw acceptable license '$origexpr' but note '$prefer' is preferred " .
+	     "for new files unless the code is derived from a source with an" .
+	     "existed declared license that must be followed.");
+    }
+}
+
 sub process {
 	my $filename = shift;
 
@@ -1641,6 +1702,11 @@ sub process {
 		    }
 		}
 
+# Check SPDX-License-Identifier references a permitted license
+		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
+		    &checkspdx($realfile, $1);
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.46.0



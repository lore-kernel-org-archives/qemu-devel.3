Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B2EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 14:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFZ7w-0002SI-UR; Thu, 15 May 2025 10:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ7r-0002RB-Gk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFZ7p-0007qZ-6R
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747317591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yY0034+dLlvt+8K1D+vx4cXEv2LUnKHQjrjWN9QxREU=;
 b=DsRG41V0Cg40JQfFIPeKNpZxXziqlsU1g+i58ldxRGr0YK95eQmnVnXMGEVtzMsh7AtY68
 Fp5odWTA0plKCows0q/nTdHzgX0ywX/4j88fxHLfTH8sInaEoRLu0SFYIfbxBqV1O+xrKB
 wlPpWx85W+i5Jgvp7V3Ke2eZ4yyjff0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Aeb1sYA5PYOxw3f6XcYSnA-1; Thu,
 15 May 2025 09:59:48 -0400
X-MC-Unique: Aeb1sYA5PYOxw3f6XcYSnA-1
X-Mimecast-MFC-AGG-ID: Aeb1sYA5PYOxw3f6XcYSnA_1747317587
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D59961800115; Thu, 15 May 2025 13:59:46 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F355730075D4; Thu, 15 May 2025 13:59:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 2/9] scripts/checkpatch.pl: fix various indentation mistakes
Date: Thu, 15 May 2025 14:59:29 +0100
Message-ID: <20250515135936.86760-3-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-1-berrange@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Various checks in the code were under-indented relative to other
surrounding code.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 98 +++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d355c0dad5..7675418b0b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1681,19 +1681,19 @@ sub process {
 
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
-		    &checkspdx($realfile, $1);
+			&checkspdx($realfile, $1);
 		}
 
 		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
-		    my $tag = $1;
-		    my @permitted = qw(
-			SPDX-License-Identifier
-		    );
-
-		    unless (grep { /^$tag$/ } @permitted) {
-			ERROR("Tag $tag not permitted in QEMU code, valid " .
-			      "choices are: " . join(", ", @permitted));
-		    }
+			my $tag = $1;
+			my @permitted = qw(
+				SPDX-License-Identifier
+			);
+
+			unless (grep { /^$tag$/ } @permitted) {
+				ERROR("Tag $tag not permitted in QEMU code, valid " .
+				      "choices are: " . join(", ", @permitted));
+			}
 		}
 
 # Check for wrappage within a valid hunk of the file
@@ -2274,7 +2274,7 @@ sub process {
 
 # missing space after union, struct or enum definition
 		if ($line =~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)?(?:\s+$Ident)?[=\{]/) {
-		    ERROR("missing space after $1 definition\n" . $herecurr);
+			ERROR("missing space after $1 definition\n" . $herecurr);
 		}
 
 # check for spacing round square brackets; allowed:
@@ -2569,7 +2569,7 @@ sub process {
 
 		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
 		    $line !~ /^.typedef/) {
-		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
+			ERROR("named $1 should be typedefed separately\n" . $herecurr);
 		}
 
 # Need a space before open parenthesis after if, while etc
@@ -3118,48 +3118,48 @@ sub process {
 
 # Qemu error function tests
 
-	# Find newlines in error messages
-	my $qemu_error_funcs = qr{error_setg|
-				error_setg_errno|
-				error_setg_win32|
-				error_setg_file_open|
-				error_set|
-				error_prepend|
-				warn_reportf_err|
-				error_reportf_err|
-				error_vreport|
-				warn_vreport|
-				info_vreport|
-				error_report|
-				warn_report|
-				info_report|
-				g_test_message}x;
-
-	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
-		ERROR("Error messages should not contain newlines\n" . $herecurr);
-	}
+		# Find newlines in error messages
+		my $qemu_error_funcs = qr{error_setg|
+					 error_setg_errno|
+					 error_setg_win32|
+					 error_setg_file_open|
+					 error_set|
+					 error_prepend|
+					 warn_reportf_err|
+					 error_reportf_err|
+					 error_vreport|
+					 warn_vreport|
+					 info_vreport|
+					 error_report|
+					 warn_report|
+					 info_report|
+					 g_test_message}x;
+
+		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
+			ERROR("Error messages should not contain newlines\n" . $herecurr);
+		}
 
-	# Continue checking for error messages that contains newlines. This
-	# check handles cases where string literals are spread over multiple lines.
-	# Example:
-	# error_report("Error msg line #1"
-	#              "Error msg line #2\n");
-	my $quoted_newline_regex = qr{\+\s*\".*\\n.*\"};
-	my $continued_str_literal = qr{\+\s*\".*\"};
+		# Continue checking for error messages that contains newlines. This
+		# check handles cases where string literals are spread over multiple lines.
+		# Example:
+		# error_report("Error msg line #1"
+		#              "Error msg line #2\n");
+		my $quoted_newline_regex = qr{\+\s*\".*\\n.*\"};
+		my $continued_str_literal = qr{\+\s*\".*\"};
 
-	if ($rawline =~ /$quoted_newline_regex/) {
-		# Backtrack to first line that does not contain only a quoted literal
-		# and assume that it is the start of the statement.
-		my $i = $linenr - 2;
+		if ($rawline =~ /$quoted_newline_regex/) {
+			# Backtrack to first line that does not contain only a quoted literal
+			# and assume that it is the start of the statement.
+			my $i = $linenr - 2;
 
-		while (($i >= 0) & $rawlines[$i] =~ /$continued_str_literal/) {
-			$i--;
-		}
+			while (($i >= 0) & $rawlines[$i] =~ /$continued_str_literal/) {
+				$i--;
+			}
 
-		if ($rawlines[$i] =~ /\b(?:$qemu_error_funcs)\s*\(/) {
-			ERROR("Error messages should not contain newlines\n" . $herecurr);
+			if ($rawlines[$i] =~ /\b(?:$qemu_error_funcs)\s*\(/) {
+				ERROR("Error messages should not contain newlines\n" . $herecurr);
+			}
 		}
-	}
 
 # check for non-portable libc calls that have portable alternatives in QEMU
 		if ($line =~ /\bffs\(/) {
-- 
2.49.0



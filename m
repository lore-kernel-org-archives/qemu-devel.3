Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB9C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Bj-00034M-FB; Thu, 22 May 2025 06:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Bh-00033X-L4
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Be-0006bf-FH
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSadqX7JF7v4vi+CLTCLnCLIIM+Idk1jD2gv7AoF4PA=;
 b=SBARdGUZLE3RqxFzJcL/a3yEySD1I9rQD60OqFRv65Nm34viUPXtT7moyB0QwIGPwf6zCj
 6K2e1SM+2LwYQjYkQUU8iyklAcyr44NaU1Yvu4zE+xy8ElQEXwvVSI3U5Xn5jNhfGxG356
 mHNjLErSM8NkzEBkAs0/10hRebTKitc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-L5mxZXFNO7iboIdCK3atpg-1; Thu,
 22 May 2025 06:30:02 -0400
X-MC-Unique: L5mxZXFNO7iboIdCK3atpg-1
X-Mimecast-MFC-AGG-ID: L5mxZXFNO7iboIdCK3atpg_1747909800
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 424FE1800256; Thu, 22 May 2025 10:30:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DB79195801F; Thu, 22 May 2025 10:29:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/23] scripts/checkpatch.pl: fix various indentation mistakes
Date: Thu, 22 May 2025 11:29:09 +0100
Message-ID: <20250522102923.309452-10-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
surrounding code. Some places used 4-space indents instead of
single tab, while other places simply used too few tabs.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 101 ++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d355c0dad5..2c19f6f0f2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1681,19 +1681,20 @@ sub process {
 
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
+			    ERROR("Tag $tag not permitted in QEMU code, " .
+				  "valid choices are: " .
+				  join(", ", @permitted));
+			}
 		}
 
 # Check for wrappage within a valid hunk of the file
@@ -2274,7 +2275,7 @@ sub process {
 
 # missing space after union, struct or enum definition
 		if ($line =~ /^.\s*(?:typedef\s+)?(enum|union|struct)(?:\s+$Ident)?(?:\s+$Ident)?[=\{]/) {
-		    ERROR("missing space after $1 definition\n" . $herecurr);
+			ERROR("missing space after $1 definition\n" . $herecurr);
 		}
 
 # check for spacing round square brackets; allowed:
@@ -2569,7 +2570,7 @@ sub process {
 
 		if ($line =~ /^.\s*(Q(?:S?LIST|SIMPLEQ|TAILQ)_HEAD)\s*\(\s*[^,]/ &&
 		    $line !~ /^.typedef/) {
-		    ERROR("named $1 should be typedefed separately\n" . $herecurr);
+			ERROR("named $1 should be typedefed separately\n" . $herecurr);
 		}
 
 # Need a space before open parenthesis after if, while etc
@@ -3118,48 +3119,50 @@ sub process {
 
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
+		# Continue checking for error messages that contains newlines.
+		# This check handles cases where string literals are spread
+		# over multiple lines.
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
+			# Backtrack to first line that does not contain only
+			# a quoted literal and assume that it is the start
+			# of the statement.
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



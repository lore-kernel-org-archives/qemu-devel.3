Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6396ECFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpvt-0005AC-0B; Mon, 07 Oct 2024 11:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvp-00058o-Fy
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxpvo-0002Xe-1p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728315954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTX+6cRA+/ltHCjvlFktg7Y59mCZ2nEaRmncVeNd1ko=;
 b=D+jDJ2sRvul/ejKjM5HA0ogkTkD+Wm/5H05P300BTb4pwLh4bRy0yKNLNs9sSXZY8QMPzn
 G4KRiDlmTX2x3ZqrHy8jqvL0aS8BeMK8YiBQfjxhaife8iu5pa/YEfTgpJvETNkRcjacqh
 MoN8jRYb0jvCwyh91QgiCetlbek7ZFo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-AbbImbsWNQSWd0oDYgUtlg-1; Mon,
 07 Oct 2024 11:45:53 -0400
X-MC-Unique: AbbImbsWNQSWd0oDYgUtlg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DB2D1955EAB
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2024 15:45:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6224A300019E; Mon,  7 Oct 2024 15:45:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
Date: Mon,  7 Oct 2024 16:45:46 +0100
Message-ID: <20241007154548.1144961-2-berrange@redhat.com>
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

Going forward we want all newly created source files to have an
SPDX-License-Identifier tag present.

Initially mandate this for C, Python and Perl source files, and
encourage this for other file types.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b21249c91..cc266abdcd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1378,6 +1378,8 @@ sub process {
 	my $in_imported_file = 0;
 	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
+	my $expect_spdx = 0;
+	my $expect_spdx_file;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -1615,6 +1617,30 @@ sub process {
 			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
 
+# All new files should have a SPDX-License-Identifier tag
+		if ($line =~ /^new file mode\s*\d+\s*$/) {
+		    if ($expect_spdx) {
+			if ($expect_spdx_file =~ /\.(c|h|py|pl|c\.inc)$/) {
+			    # source code files MUST have SPDX license declared
+			    ERROR("expected 'SPDX-License-Identifer' in new file $expect_spdx_file");
+			} else {
+			    # Other files MAY have SPDX license if appropriate
+			    WARNING("Does new file $expect_spdx_file need 'SPDX-License-Identifer'?");
+			}
+		    }
+		    $expect_spdx = 1;
+		    $expect_spdx_file = undef;
+		} elsif ($expect_spdx) {
+		    $expect_spdx_file = $realfile unless defined $expect_spdx_file;
+
+		    # SPDX tagsd may occurr in comments which were
+		    # stripped from '$line', so use '$rawline'
+		    if ($rawline =~ /SPDX-License-Identifier/) {
+			$expect_spdx = 0;
+			$expect_spdx_file = undef;
+		    }
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.46.0



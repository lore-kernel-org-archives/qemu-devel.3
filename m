Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA478C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woF2H-0008Gy-MK; Mon, 27 Jul 2026 02:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woF2G-0008GS-50
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woF2E-0001Uy-9s
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785134517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z1vkUhFf1Ayr3m8Q/cKW2P6QHRBwZl0jJeSWAQ2RN/I=;
 b=Zo99U+KD6NWdZeg7SDFkF9OMp56qrcOIWWnbajX6w+rWquVHX7XPWUDN6Vy1G4ZO9oUx45
 T16fBVE9yFI6i7+d4k4hLh6bFjoWuJ41lSZsmZ83z2oWyFsFCNfHVUFRmidligxCnlNGYZ
 7s4tBK7vAaXTvtgvBVb6hL0twC0gvaA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-9K6fiMioPUSUT271KIMs6Q-1; Mon,
 27 Jul 2026 02:41:55 -0400
X-MC-Unique: 9K6fiMioPUSUT271KIMs6Q-1
X-Mimecast-MFC-AGG-ID: 9K6fiMioPUSUT271KIMs6Q_1785134514
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 218191801358; Mon, 27 Jul 2026 06:41:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0ACE180034F; Mon, 27 Jul 2026 06:41:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
Date: Mon, 27 Jul 2026 08:41:49 +0200
Message-ID: <20260727064149.1469828-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Adapt the kernel's checkpatch Fixes: tag validation for QEMU.

Add a git_commit_info() helper to resolve commit hashes and validate
the Fixes: tag in commit messages. The canonical form is:

  Fixes: <12+ chars of sha1> ("<title line>")

The check validates capitalization, spacing, hash length, lowercase
hex, and quoted title. When the format is wrong and the commit can
be resolved, suggest the corrected Fixes: line.

When running inside a git repository, also verify that the referenced
commit is an ancestor of master.

Lines matching "Fixes: CVE-*" are skipped. The check can be disabled
with --no-fixes-tag.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v2:
 - Introduced $git_command

 scripts/checkpatch.pl | 71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..59ae3532d012f49122ea097cec1eeb2b95354f99 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -21,6 +21,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
 my $quiet = 0;
 my $tree = 1;
 my $chk_signoff = 1;
+my $chk_fixes_tag = 1;
 my $chk_patch = undef;
 my $chk_branch = undef;
 my $tst_only;
@@ -54,6 +55,7 @@ Options:
   -q, --quiet                quiet
   --no-tree                  run without a qemu tree
   --no-signoff               do not check for 'Signed-off-by' line
+  --no-fixes-tag             do not check for 'Fixes:' tag
   --patch                    treat FILE as patchfile
   --branch                   treat args as GIT revision list
   --emacs                    emacs compile window format
@@ -94,6 +96,7 @@ GetOptions(
 	'q|quiet+'		=> \$quiet,
 	'tree!'			=> \$tree,
 	'signoff!'		=> \$chk_signoff,
+	'fixes-tag!'		=> \$chk_fixes_tag,
 	'patch!'		=> \$chk_patch,
 	'branch!'		=> \$chk_branch,
 	'emacs!'		=> \$emacs,
@@ -441,6 +444,11 @@ sub build_types {
 build_types();
 
 $chk_signoff = 0 if ($file);
+$chk_fixes_tag = 0 if ($file);
+
+my $git_command ='export LANGUAGE=en_US.UTF-8; git';
+my $gitroot = $ENV{'GIT_DIR'};
+$gitroot = ".git" if !defined($gitroot);
 
 my @rawlines = ();
 my @lines = ();
@@ -561,6 +569,28 @@ sub which {
 	return "";
 }
 
+sub git_commit_info {
+	my ($commit, $id, $desc) = @_;
+
+	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
+
+	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
+	$output =~ s/^\s*//gm;
+	my @lines = split("\n", $output);
+
+	return ($id, $desc) if ($#lines < 0);
+
+	if ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./ ||
+	    $lines[0] =~ /^fatal: bad object $commit/) {
+		$id = undef;
+	} else {
+		$id = substr($lines[0], 0, 12);
+		$desc = substr($lines[0], 41);
+	}
+
+	return ($id, $desc);
+}
+
 sub expand_tabs {
 	my ($str) = @_;
 
@@ -1811,6 +1841,47 @@ sub process {
 			}
 		}
 
+# Check Fixes: tag format and commit validity
+		if ($chk_fixes_tag &&
+		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})\s*(.*)?/i) {
+			my $tag = $1;
+			my $orig_commit = $2;
+			my $title = $3;
+
+			if ($line !~ /^\s*Fixes:\s+CVE/i) {
+				my $tag_case = not ($tag eq "Fixes:");
+				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
+				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
+				my $id_case = not ($orig_commit !~ /[A-F]/);
+
+				my $id = "0123456789ab";
+				my $description = "commit title";
+				my $has_quotes = 0;
+
+				if (defined $title && $title =~ /^\("(.*?)"\)$/) {
+					$description = $1 if ($1);
+					$has_quotes = 1;
+				} elsif (defined $title && $title =~ /^\(?(.*?)\)?$/) {
+					$description = $1 if ($1);
+				}
+
+				my ($cid, $ctitle) = git_commit_info($orig_commit, $id, $description);
+
+				if (defined($cid) && ($ctitle ne $description || $tag_case || $tag_space || $id_length || $id_case || !$has_quotes)) {
+					my $fixed = "Fixes: $cid (\"$ctitle\")";
+					WARN("Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")'" .
+						" - ie: '$fixed'\n" . $herecurr);
+				}
+				if (which("git") ne "" && -e "$gitroot") {
+					my $hash = defined($cid) ? $cid : $orig_commit;
+					`git merge-base --is-ancestor $hash master 2>/dev/null`;
+					if ($? != 0) {
+						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
+					}
+				}
+			}
+		}
+
 # Check SPDX-License-Identifier references a permitted license
 		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
 			$rawline !~ /^-/) {
-- 
2.55.0



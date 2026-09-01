Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A412C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QiQ-000497-Hd; Tue, 01 Sep 2026 11:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1QiI-00048M-JA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1QiF-00060Z-Fx
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788277669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZCpljYCLdtZNipZBfonf8ZC1J22mKRnn0zpDGufHVcE=;
 b=frx6EvR4N7BMdHqhpzn6Z24qxfK9OZHi6ecWCHUp8hvUpKWvATpY6NHfKZU4wyoQR5w554
 T2hrUZP5WBtZLI4TQ8guBxFc9tovlVIAB81mYnW8MDxsnuhpLerKVlg0qf6cZU/a9WDMs7
 3pJQsiu7KFwsvVNxXrvAka27I/uYhkE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-H4aT8nL_NzmtyNJezoeANg-1; Tue,
 01 Sept 2026 11:47:46 -0400
X-MC-Unique: H4aT8nL_NzmtyNJezoeANg-1
X-Mimecast-MFC-AGG-ID: H4aT8nL_NzmtyNJezoeANg_1788277665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA35B195609F; Tue,  1 Sep 2026 15:47:44 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CAD41955E72; Tue,  1 Sep 2026 15:47:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] gitlab: use --emacs --quiet for checkpatch.pl instead of
 --terse
Date: Tue,  1 Sep 2026 16:47:41 +0100
Message-ID: <20260901154741.1488763-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The default checkpatch.pl output includes a lot of "progress"
information...

   NN/MM Checking commit HASH (SUBJECT)
   total: 0 errors, 0 warnings, 105 lines checked

for large patch series, this results in alot of noise from
clean patches (which are the common case), obscuring the
info about the patch violations.

Since the alerts from gitlab job failures only include the
last few lines of log output, we want the checkpatch.pl
output to be highly relevant to the failure.

We previously addressed that by adding use of the --terse
flag in 7025111a199b97ae806817788bec50f456c47d85, but that
made the output a bit too terse. It no longer prints the
offending line of code, so understanding the CI job failure
now requires manually re-running checkpatch.pl locally.

Using the '--quiet' flag gets rid of the "Check commit HASH.."
messages which create noise, while adding '--emacs' causes
the WARNING/ERROR message lines to include the commit hash.

This is a more useful tradeoff for the CI job logs. The
output is limited to only patches which include code
violations, while still including the offending lines of
code in the output.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/check-patch.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index be13e6f77d..45be77295d 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -46,7 +46,11 @@
 
 print("\nChecking all commits since %s...\n" % ancestor, flush=True)
 
-ret = subprocess.run(["scripts/checkpatch.pl", "--terse", ancestor + "..."])
+# We don't want "noise" for clean patches, but do want to see
+# the full commit hash for each violation, along with the
+# offending patch content
+ret = subprocess.run(["scripts/checkpatch.pl", "--emacs", "--quiet",
+                      ancestor + "..."])
 
 if ret.returncode != 0:
     print("    ❌ FAIL one or more commits failed scripts/checkpatch.pl")
-- 
2.55.0



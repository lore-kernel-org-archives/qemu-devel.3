Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE71606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=Ld1dD7dy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQIzw-0003ET-LV; Mon, 09 Nov 2026 01:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQIzu-0003EE-F3
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:36:54 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQIzr-0003sj-VI
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 01:36:54 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A96ageQ097550
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 15:36:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DEmQt5DKlwriy/PWQF4EedxgO9WHougMI1uL+du4t4o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794206204; v=1;
 b=Ld1dD7dyAQn1x5OC4nK0Ko9pz/EUOsrH8cbgMs3JBp1SPydmBG2OAVryDb0b4u23
 4N3qvKNDQqZip+JAzCR17g5qZgOhFalRoJr0L+kZtVxB8JWc3e5lar+qqpO1Sz+h
 wNx4xLooZJb+jhedDpudgdfW7BjDNypfFk9CfsKyiC97HLu90J8e45mVDLlwlrUF
 JpgzmI32vynULm0+Ikh2rFZM0WzPPSy5brjrQvABLE8zfkxil2azjNtcAmT/sHqp
 i2+XbWLdwtvwSQMetayVtTXQka9wrDKjYOg1FUrKX03Ti7HxLB/wcgk3df7LpY4L
 EP7vjIntrGsCKzrehQDDyA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 15:36:27 +0900
Subject: [PATCH] scripts/checkpatch: Drop the author extraction in-header check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-from-v1-1-019dacf55d63@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMzQpAQBSG4Vs5fWtTZkLN3IosMAdH+WkGKbl3Y
 fkunvdC5CAc4ehC4EOiLDMc6YTQDvXcsxIPRzCpKbROrerCMqm8YZNZ7zNrCySENXAn57cpq7/
 j3ozcbq/FfT/vz6X5aAAAAA==
X-Change-ID: 20261109-from-5be249dd4996
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=nui/dyF4NineRwty/7s94nvNM6dY7mSpycyQ5UCm3xA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHzG8Xm6fYmotO2toncenJpBiXS7m16s9Ep359WNUts
 v1u3+SwjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlkVzAyTNtdtU5j65E1yudu
 rguJLTL8sL5a+cvv0Hsr7ef6hc1oCGFk+PVRYuJ/P7e7674+X8Sg5bA45Kij14qF6R5XbLxiDmr
 lsQEA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An in-body From: denotes the author when the sender is different.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 82f62f602125..2904bd691dc5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1823,7 +1823,7 @@ sub process {
 		}
 
 # Extract author email for trailer checks
-		if ($in_header_lines && $line =~ /^(?:Author|From):\s*(.*)/) {
+		if ($line =~ /^(?:Author|From):\s*(.*)/) {
 			my $author_info = $1;
 			if ($author_info =~ /<([^>]+)>/) {
 				$author_email = $1;

---
base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
change-id: 20261109-from-5be249dd4996

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



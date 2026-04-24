Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048ECFE51F3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCpe-0008Ba-V2; Fri, 24 Apr 2026 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCp5-0007Q8-17
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCp0-0007aA-1K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:42 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63O9RHIi004358
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 18:27:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wzGInr5tGeKcs9kj5j/LreDA3mI0ZOwS94BodO37T70=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777022847; v=1;
 b=dbd146IriZSMW+4HN59foUhN0HnPvlIRsHb0CLOVq8/r1gg4Su1Zf3SUe1ZanY+x
 69Rn8dn6MogTtYzUUZQus3pRf2bpUp5ujX8+fwvV3vMqqVy/EghHTHo9R+DdU+ZS
 Hd7sqJrlkt6IGlCzl3+dgYbxEDuyhswFFQsDRh4XU9AdhQNc3DQQvDWIfFP+5ayH
 Lf6a9amxwK6JxPPS+IAA/w8U1tSYIJ7Srk7ocuVw2gabceyV9dySyy4a4jLOGeE2
 KfxMD2v31k+Ap+mlbvryJ5I34DI3H8ZHaXypDA3b94vwXfc5wJ2yzFCP7O0ONGyj
 zaxtXScjmvmDND+WKJak0A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Apr 2026 18:27:11 +0900
Subject: [PATCH v4 6/6] scripts/checkpatch: Avoid false positive on empty
 blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-force_rcu-v4-6-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
References: <20260424-force_rcu-v4-0-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260424-force_rcu-v4-0-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

SUSPECT_CODE_INDENT checks the first line after a conditional statement.
When the block is empty, the first line after the conditional is the
closing brace at the same indentation level, so checkpatch reports a
bogus indentation error.

Ignore same-indented braces and else statements, matching with:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6950a735f29e782bc219ece22bb91d6e1ab7bbc

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b77bd693288b..df92b92ac975 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2282,7 +2282,8 @@ sub process {
 			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
 
 			if ($check && (($sindent % 4) != 0 ||
-			    ($sindent <= $indent && $s ne ''))) {
+			    ($sindent <= $indent &&
+			     $s !~ /^\s*(?:\}|\{|else\b)/))) {
 				ERROR("suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
 		}

-- 
2.53.0



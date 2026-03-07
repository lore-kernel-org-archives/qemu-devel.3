Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D0CFC9EC3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 03:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyiG2-0002QP-QT; Fri, 06 Mar 2026 22:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyiG1-0002QE-9m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:23:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyiFy-0002Uu-Gp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:23:13 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6273MPQh034556
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 12:22:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9kzn3lSfn7dRtKl5erSnx7Z8JG7ERggzWdsAhFche6M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772853759; v=1;
 b=CtlNfzZEisGt5P5SPVZuSDi/29F0rRsBGnj3iU9nsB94allO5ZEkKwBMdn0PZ49b
 QFIM7DfntPgNawGeFc3kxARLxtB8A856vS5QAOrag1M/hCDkHaYfPBrbBIRRIAeB
 DrzFxTw0K277QlnPxriFzKaZqmWMFHgUA41rQOp5KT/H7oRLHl+p+wqiQYBUVcTy
 4S3FxY0lYBBFgr7X3Z2ug+pAMqUgrljSPo4/SpoLg1UH6mUeWZU6tfEBSntRh6mv
 zHh2AnHTfUZWXPVjYC01fdabDuEjrM1NCuRxGzkaCuhuzL1sYDiOTlKeh7zgLGqO
 pP0OXs/yds6rIYigkkR3HA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 07 Mar 2026 12:22:25 +0900
Subject: [PATCH] contrib/plugins/bbv.c: Check if file is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-bbv-v1-1-d5757d1deac8@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAPCZq2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNz3aSkMl0jcwOLVAMDI+NUgzQloMqCotS0zAqwKdGxtbUAITXx9VU
 AAAA=
X-Change-ID: 20260307-bbv-2708e0023e0f
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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

The file pointer can be NULL when e.g., opening the file failed.
vcpu_interval_exec() already implements a NULL-pointer check, but
plugin_exit() misses it. Handle the condition by adding the missing
check to plugin_exit().

Fixes: 0d279bec0f14 ("contrib/plugins: Add a plugin to generate basic block vectors")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 contrib/plugins/bbv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
index b9da6f815e36..5913cc6c637d 100644
--- a/contrib/plugins/bbv.c
+++ b/contrib/plugins/bbv.c
@@ -30,8 +30,13 @@ static uint64_t interval = 100000000;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
+    Vcpu *vcpu;
+
     for (int i = 0; i < qemu_plugin_num_vcpus(); i++) {
-        fclose(((Vcpu *)qemu_plugin_scoreboard_find(vcpus, i))->file);
+        vcpu = qemu_plugin_scoreboard_find(vcpus, i);
+        if (vcpu->file) {
+            fclose(vcpu->file);
+        }
     }
 
     g_hash_table_unref(bbs);

---
base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
change-id: 20260307-bbv-2708e0023e0f

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



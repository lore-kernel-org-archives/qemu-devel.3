Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA6DCEFD15
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 22:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdF9j-00005d-HH; Tue, 06 Jan 2026 17:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vdF9g-0008Si-M9
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:03:56 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vdF9e-0004gs-77
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 17:03:55 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 48be1b9fffe7a540cf3acbe3a6d898da2ddd5633bd7318dfffec6707d90c5c48 with SMTP id
 695d86c01804cccf5ca9f07a; Tue, 06 Jan 2026 22:03:44 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1767737023;
 bh=TM0YFFpxn0xRwAIl/7fxZ3lZTuiRdep6mFmSWUzoFg0=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=eULLb5iiqmMaSw+xXlGS9zx6dtmlRDDVnZX3tvox1HIvnl+HucFDLxzADEzRdf04V
 48QPE8UIkJYKCgOCfwU2HaavURErriO6hayuCofu77dXCFXX0oMIeYxDx/JItd81L+
 iHkH2FxS9Hy1gMdfBipkTvk1J5IY7V/bQlZYGySGDZjyYTE8Qup7Z3YYmW29npent2
 7P8bqtNMvGofu1D0jlNN/yhyS448ot/w3rgaGLyUY0COUOu7y65tDvL03Fapb77Stg
 b7++IiybLVBhjo+LMwpes8CEOPwFRtswT9DhFZd6tLo42Wipr3YHuHzVPsFVqzQ2NX
 NKtqt/lorJk+w==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH] tests/functional/qemu_test/testcase: Fix mismatched quotations
Date: Tue,  6 Jan 2026 16:03:19 -0600
Message-ID: <20260106220319.74785-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A debug string incorrectly mixes single-quotes with double-quotes,
causing the variable within to be treated as a literal. Fix it.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 tests/functional/qemu_test/testcase.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 58f2740100..ff86c9d187 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -349,7 +349,7 @@ def require_netdev(self, netdevname):
         helptxt = run([self.qemu_bin, '-M', 'none', '-netdev', 'help'],
                       capture_output=True, check=True, encoding='utf8').stdout
         if helptxt.find('\n' + netdevname + '\n') < 0:
-            self.skipTest('no support for " + netdevname + " networking')
+            self.skipTest('no support for ' + netdevname + ' networking')
 
     def require_device(self, devicename):
         helptxt = run([self.qemu_bin, '-M', 'none', '-device', 'help'],
-- 
2.52.0



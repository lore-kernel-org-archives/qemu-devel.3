Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310C8C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIKL-00075U-DT; Thu, 20 Jun 2024 09:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sKIKJ-00075M-FU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:59:47 -0400
Received: from redisdead.crans.org ([2a0c:700:2::ff:fe01:2402])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erdnaxe@crans.org>) id 1sKIKH-0000aR-Gm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crans.org; s=mail;
 t=1718891971; bh=utWa3G2ROFcZq2Bxifn6vY1dON8iJ2NFho33pEVqScE=;
 h=From:To:Cc:Subject:Date:From;
 b=K8LslR+ovaJIyxkxf9pPaOzNhP+Jcz4FKn+px6tK9JA9cJ1ObKiEi1tgn+elaQdBW
 jd7phTXUoj7tGZl27xRz/QMQ1owRMWk3IcptyXKHuVwMP6PsFQ4TySluvX0/mNCZ8U
 nknIsJ9SvmQIc0syeOWr48N+5ESJtD+1AcohRP6Ax5hRu4I8n86EA/QfGj3kv97+mi
 NqbXPyrVtYQW7iE+8jxW2RhTw+X6A8aoF8xuWioTFVDER1rVvisadMQAgoPYlM8ObA
 H+kt8X6YQXddj2mQgFk8xY5wQtOjjK9PkRlIa3vHPHGfeQyNkG4j7jjpyxqmDz0JOn
 yAY8c+HFGwvW2UwsnU6Z6mCew1wbSVbqwwKJXfQGhEM/qDETI5NI6W20q4TTwgOJ7y
 6wZtmLHY0C7yqbfrNQjdfKX7jHf1BhdOHEfZWxMigWmtEcvFCjikXzkunnl07nt6tl
 K89v4smHRU4DrB4HrN+lFqL7tbpJfAIMNK63pzIYp5Tz+Azh0Iv73hpBR87hS4yo5H
 ckaJWG9+otfYDAmcYwPQPDGkagJ5kquPGXm4Dg4s4rb5OYQANL/pfVZ9Ev6irAlBKl
 oiDQ874jy8SrzQwlCuYt67iJRZqaigRrvQ4ZpKsK8pk/jp649B48F1JZuK91TCQoZs
 lq8mD0aTFQVnGg/L98eSf6jY=
Received: from zamok.crans.org (users.adm.crans.org [172.16.10.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by redisdead.crans.org (Postfix) with ESMTPS id 03716215;
 Thu, 20 Jun 2024 15:59:31 +0200 (CEST)
Received: by zamok.crans.org (Postfix, from userid 11692)
 id E4E91E0123; Thu, 20 Jun 2024 15:59:30 +0200 (CEST)
From: Alexandre Iooss <erdnaxe@crans.org>
To: 
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] docs: add precision about capstone for execlog plugin
Date: Thu, 20 Jun 2024 15:57:32 +0200
Message-Id: <20240620135731.977377-1-erdnaxe@crans.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a0c:700:2::ff:fe01:2402;
 envelope-from=erdnaxe@crans.org; helo=redisdead.crans.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some people are wondering why they get an empty string as disassembly.
Most of the time, they configured QEMU without Capstone support.
Let's document this behaviour to help users.

Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
---
 docs/devel/tcg-plugins.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 9cc09d8c3d..f7d7b9e3a4 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -539,7 +539,9 @@ which will output an execution trace following this structure::
   0, 0xd34, 0xf9c8f000, "bl #0x10c8"
   0, 0x10c8, 0xfff96c43, "ldr r3, [r0, #0x44]", load, 0x200000e4, RAM
 
-the output can be filtered to only track certain instructions or
+Please note that you need to configure QEMU with Capstone support to get disassembly.
+
+The output can be filtered to only track certain instructions or
 addresses using the ``ifilter`` or ``afilter`` options. You can stack the
 arguments if required::
 
-- 
2.30.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E31CD8CBF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvAu-0002t9-Gq; Tue, 09 Jun 2026 08:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWvAt-0002sk-Cl
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:03:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWvAr-0003gR-QI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:03:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso43011455e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781006596; x=1781611396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7YwEYq5tAk50bAMiN0egrL0NL2NcfKktOgcLpeX06pc=;
 b=B0E6wCVrq2iwW5oCBiB7wfLCmIaJbdQvzTFQvl1vVcHs3/6JnxQ9OMVgEVPerfoj3P
 qBzNVmR2fkTO+uYvSlIVZ46mngqs7jppmH+qfF0n/3pN5iOlfaHWhJApRTWALos7uZfj
 Y8H3ID9v/PaZdwg+HHN7rS7KCh/M+SG0twES7yl0bDDk5wJZmZUBdHr7Zcap4dc+YZoT
 /JvB0UOVswS/bCfJbMIzfHOmXQ80qf+BmQG3c7x8ys2V2IxZxjvwKxZ7ngFzc6UoSoC9
 y0uSWCTUV5CfTwtts0PPMeoCKlub0g+Mfv6fIKNL5MS4eJjKYsy7Lqcc8VJPFCHqaxRU
 +hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781006596; x=1781611396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YwEYq5tAk50bAMiN0egrL0NL2NcfKktOgcLpeX06pc=;
 b=FMpDXXgCJBUQYeeSC0CtjmcVwJuOfvCBEq9sjQ1DUCHEZrV/mrbQ7p/j3fscdGaj48
 9uKSY+q3XJlwiWHkN4nxhDZVRk44RzeODXpuuRg8lKy3E/3mSpFALz/aRjjy0YjPtbGK
 9ar/0N6PFND7//2B0w6LQ2uqbLVGTcx7QXiQor05LSVC582xgCwDxmqzDwIekK71+zpF
 yPz941fsJa1kZJlR5oP3BAr9PlKM487jct7A3wiiCFcjXTN9nSHrjrksoLE2ikaft97a
 XBKPrvEWaIdtzAZgVgfKZae5FJM4ZrMrUwBPyZqUrp2TsKw3KVSAVGHTok+m0SAm0eAZ
 YMzg==
X-Gm-Message-State: AOJu0YwVyyYooBkybvVVPLSVoMu8KVM/IdIcrdzfSE/aIm71bHAhLInx
 003wN2KwZdRbWKyj50ivmAdaALl/s9pWyJbHBOiA2paLKxE0KrgDqOy+c4aR1bR+
X-Gm-Gg: Acq92OH8F0Wz5z7I5ngtYKOZK3pupcN/QqY8BOXZwFaJql5Wk1PDV5QJoaRYBWOmR/A
 Q0VXbvedCZ7c5pZxbtEhQia1uaUWFKJ8cJU1HLLBsD6LQmUiYWdMFZQ60Z7RS3Rf/+ujF7Ocoyu
 9ltu/NwrDbqmdfDxyNUlOtSVwjecME9iieGUCj0u815H/6d+ZRP/ZYS6ihSAPNZZdS73qXeg1qa
 fUK23esDoUc/TM9AYeWxpbbOB2zLREFbaga2YWGUIBacTuKXP34cvbP3omIY4ArsdMjGjCNjgPa
 nA2k09Q+t3nHApitizVtYUhOCLAEdIGYwqkr5TNOqqEn5pMcX/MCQgP4ACpsbS6QozAgfS6FxAM
 an1cheWYZmLzX7r64XJOLKKSf0Grtxj6kZ8gKlHxQw5yJazPLaT3NPJxZiC3iThkMLWYatAbX2B
 YqPYjX55q8teZ0WHmZCgW/uicO0GHpg38BNf3ePXc0rq18IA7weDHknB4lEArcYW1lHjMEdKybn
 Q==
X-Received: by 2002:a05:600c:4750:b0:490:9dc3:3483 with SMTP id
 5b1f17b1804b1-490c2cb81fbmr233795115e9.2.1781006596009; 
 Tue, 09 Jun 2026 05:03:16 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm62263140f8f.2.2026.06.09.05.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:03:15 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] qapi: drop "must exist" from ID descriptions for
 consistency
Date: Tue,  9 Jun 2026 14:01:27 +0200
Message-ID: <20260609120221.461303-1-filip.hejsek@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make chardev ID param descriptions more consistent with ID descriptions
elsewhere.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---

On Tue, 2026-06-09 at 12:34 +0200, Markus Armbruster wrote:
> Uh, this fell through the cracks, possibly because it was buried within
> a thread.

It was fine, I was planning on rolling it into v7 of the resize series, but of
course you can merge it now if you want.

> Typo: consistent

On Tue, 2026-06-09 at 06:36 -0400, Michael S. Tsirkin wrote:
> maybe after it gets a signed off by tag from the author.

Both fixed.

 qapi/char.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index aa5ee9ffcd..abaccefa97 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -821,7 +821,7 @@
 #
 # Change a character device backend
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # @backend: new backend type and parameters
 #
@@ -862,7 +862,7 @@
 #
 # Remove a character device backend
 #
-# @id: the chardev's ID, must exist and not be in use
+# @id: the chardev's ID, must not be in use
 #
 # Since: 1.4
 #
@@ -879,7 +879,7 @@
 #
 # Send a break to a character device
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # Since: 2.10
 #
-- 
2.54.0



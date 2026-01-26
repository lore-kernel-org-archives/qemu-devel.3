Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3284C88E7C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIuK-0001NA-2c; Mon, 26 Jan 2026 04:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuE-0001MB-Nw
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:10 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkIuD-0006r4-Co
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:29:10 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so2097393b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 01:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769419747; x=1770024547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h3TrHTeaWpaoUakjRDj68rNy/00gB9mvgtDT0XiwlKc=;
 b=JX8N5XzIuzmJIBDlIOieG++2zrIaZSJz17PxjY1G2ZeIM/9jKPOXZdqWrR1lptbpCI
 B3upfI5c8j0Ppj5LB5G3TrNRMgtmXG5TZvotd9pHKekNScOI/LdYbNmF0CMZAiQpqUG7
 uOHBNuJ/9sQOppMnBj7nQ9yntud004M9PJJHraxjgCEg587i/m0uzlqxAOz+J/wC+g+7
 Uw8KewPukDj7SLc68AeigKUkiRRcWMw2+jvMIQFgPotEm1ChRaPd/poJx2onAfC1MH4o
 rt2fjhmRWAXS4g3yRHSZKBoi3Mq7Q9cUgXar+gM1WDiVSz8r4fCvVOiJQ/fTkvpKzvfe
 Wm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769419747; x=1770024547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3TrHTeaWpaoUakjRDj68rNy/00gB9mvgtDT0XiwlKc=;
 b=wUj4Kplgcq2PJ6l2uF63E6RniIqV7VtQdLeAfYwu9oGQOl70CBoM3QjyoJhZ2rYiN4
 kjmS9YSPjl081nNmk/gE58qpdG4ZC5NM5lYY/KVMOs7sr5nginc0/ooQ6PybeG8Y9KnA
 NaGR3385CD94kVIwiFtRRYmpjijWW/AyOgDLbTP/KRdPvag9VbVgfkuQDTRIsdlyUkDC
 lO5a3OwrdJLknC/Tv9yum5pR3aEf+DzVsl5jmcOXEY0aDZEgB2aTpmgaHSZzK3mYIsjv
 y61c75H+tgjBOOzQaWO2qJIvjMTNzXLjsbzAfYpZOkxf4/qv7QyqTcybHsyWOxw19OhF
 0dEw==
X-Gm-Message-State: AOJu0YzVX83KxFR5zTrDKql/gKei0gF73pwLAtzJiXWKEEDm4nrJ9uW0
 IQsQTaV6L/nLSq1OwD5WQxlv82O8AoUBwl0TxD0Px0Ahhv85irGeVyhsPP6qaFzo
X-Gm-Gg: AZuq6aLKST/iB8TlYkcdlmAecaFAbEodyhjJgBycAH/k22TFDjmaoNCzOxIqU7OSqdC
 vrcToDR1IKelUYJ74h2aroM7zU9dJPXpszUzAL50f4NzCu0W5AvGFZvjwqNNSeooyl1yVj13/bY
 RCFMg3E3YcQr3wtY071SrMnta+q5AJuXNU8pWEj6a1frgFu6Ddykrvt2VoTly1NkBzM7WIWSto0
 /Z1127wPsXw0InFMa4oDaJ/f0BDq9Ahq5jibyrmC4db8PG7li4aHNH8p4np9vs0SFjLyc03T2oT
 WjALyZUJidl4BFYbERrlDK9khHKyZvNBRHVeIOWV+RYUckwCmlzIUbg85lFlUTF1JbdcSyl4xUf
 44fvAtkBSV6EslXWtohNqQQwxqgZz+Uc+UqhIoMBUPEp+402fdBSHQnsH2gJ3qs2dCFKuKnozQh
 M7lFGD+xU3X1hRm1w=
X-Received: by 2002:a05:6a21:62c3:b0:38d:f135:5095 with SMTP id
 adf61e73a8af0-38e9e527b71mr3775175637.9.1769419746786; 
 Mon, 26 Jan 2026 01:29:06 -0800 (PST)
Received: from localhost.localdomain ([129.227.88.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f97a8csm85568265ad.53.2026.01.26.01.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Jan 2026 01:29:06 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V3 1/3] qapi/misc: Fix missed query-iothreads items
Date: Mon, 26 Jan 2026 17:28:52 +0800
Message-ID: <20260126092854.20343-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42a.google.com
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..1f5062df2a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -117,11 +117,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0



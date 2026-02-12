Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED7EB48F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqTPZ-0005TL-HT; Thu, 12 Feb 2026 04:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vqTPY-0005Px-LC
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:55:00 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vqTPX-0005ZE-3O
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 04:55:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so47221795e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 01:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770890097; x=1771494897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IK1mfHcvv/SU6XTFHR2FsHEAD+gPrVDgCiTX9YDKd/c=;
 b=MAqoUp/UrZOtzzpLjd14k8zfOFo5s6dNENvx+XIcwjwPim2ubK9o8yGkA4K6RoTagZ
 5spomiNkLTwwf7OkVWlNpwhmOnyUMP6HFhO5rtZDPC62GIUplomKOBt3ibXTwYgrG+kq
 uAE057zCcMYjel3C6UNVw0Qpzck64fRhxsIjZJsSqd170HuV9AL52g8hp419Oj/z8tPk
 MaxN3eUEbVj6OtCAGcI036496Slu35IT61e/Lfxhb9ltqy3oNPhBzWLdW/cW7lJT1no1
 kqkU+/+ZcOhS66m8JiB+U0Iwt0gyoRBVA4VWUFlXDA4dNs7fmLbkAOl/PtG//4WRSVx8
 u95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770890097; x=1771494897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IK1mfHcvv/SU6XTFHR2FsHEAD+gPrVDgCiTX9YDKd/c=;
 b=NttcBrDcvsOkkBz4ex/WJmaDTrP49omSY+FFCqaS3+01LAtqaI2595F9DD1KgvYM6c
 BxZ/RlklK/AU2AsBnTFVZgrvfP5AWlQ3mBNq7AID5B1DA70SH0ICzVPnxo6uSleMisiZ
 ITCgpZVh86iCB6dK2gPD3lLfy2h7nlYtA0Mxt3TTnYFFvZUyWzOhf5mMofuvOt2N4eka
 9wTGQg9pv5FI8+m0L6aaUMnUROWjSZGWa3PAEMhd8XB9vGjY7gqIpLZSc/F6F2gv9rlw
 KdSNMY47BcN7FvZHBUTxeX/ohEGM7019vRURjUENg4eY4J2+kwdDpqyRliabSu66jdJt
 gmlA==
X-Gm-Message-State: AOJu0YzzXd1IGO/GJsIYKQX/5esWJ71qbtqGglv5BPriWb1e8Yv0macs
 BroFfL+M2tmUQhnEPho8FLjBuo/OzDm6uKM/bbgaU660Wto4fgFNYa3Y7CLZ1d4XmUIQIR1CXed
 USBf5o/+AFpyxnRahFyW7nic1s21Pcmx0WF1AJ6SoXrUrq7un/N+PnO/easAn5kJiPXAFzfkdZT
 ZkgjyfOr9bJbQiGqHPD9ZNb4eVjS6fxiNUF9GyUh+SA6HbqA==
X-Gm-Gg: AZuq6aLfAF+6rPlDkSzAW1V35pAP9lG2YyLwte5eW5xeOzCjw6IE/3eErDQ+5oVg3TK
 kPopgq0Xcam9Om+RZuIYMC+lfxwW03vmcFxxLE+qmds1zKyjZ6Yuh6RlxABOa2f37U5G3AijHvO
 c4QSJU4HNpGc4rbYc/Fd+vjoFC8H8FZE3JMC4JkKIaSLrUYgMeLTgPcYMq6UvQuSaxh6XwvfBP0
 D2ynQK9cmJ4TW6b5Ac0XilDCI175nma81ASqgSOH2KuclkviY3HhPGefuSD0FMAM7LxlArT4/Da
 /Trw61i75HdR4tujPQBNG95NbAMawoWtjN1CBE+KM/3MJ2h9ZMKI4r2PAX4155+QFmI3/4bYed/
 oCFjIApJJoAyWVAsz0CXplDgw22dIvYcL9jkAMRTskuOsDR2jNKXgdXFbhQ1EcQAvi0AgWAjaaG
 jVkIAELYAJVwFBUXKzKmXuotNdVuBzYLQKVEpz00wq7ZVMCGKv+g==
X-Received: by 2002:a05:600c:5391:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-48365716ac1mr26321415e9.28.1770890096594; 
 Thu, 12 Feb 2026 01:54:56 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d36f86sm10181526f8f.7.2026.02.12.01.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 01:54:56 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] linux-user: Check if RESOLVE_CACHED flag is defined before
 using it
Date: Thu, 12 Feb 2026 17:54:49 +0800
Message-ID: <20260212095449.683135-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=frank.chang@sifive.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

openat2.h was introduced in Linux kernel 5.6. However, RESOLVE_CACHED
flag was only added in kernel 5.12 and later. Therefore, we need to check
if RESOLVE_CACHED flag is defined before using it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 linux-user/strace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 758c5d32b6c..a903b414fd2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1125,7 +1125,9 @@ UNUSED static const struct flags openat2_resolve_flags[] = {
     FLAG_GENERIC(RESOLVE_NO_SYMLINKS),
     FLAG_GENERIC(RESOLVE_BENEATH),
     FLAG_GENERIC(RESOLVE_IN_ROOT),
+#ifdef RESOLVE_CACHED
     FLAG_GENERIC(RESOLVE_CACHED),
+#endif
 #endif
     FLAG_END,
 };
-- 
2.43.0



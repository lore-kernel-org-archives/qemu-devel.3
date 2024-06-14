Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2AAC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 21:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIE8P-0004eL-3z; Fri, 14 Jun 2024 17:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sIE8M-0004dH-Uu; Fri, 14 Jun 2024 17:06:54 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trentmhuber@gmail.com>)
 id 1sIE8L-00015T-Bu; Fri, 14 Jun 2024 17:06:54 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b08742a59fso1123456d6.3; 
 Fri, 14 Jun 2024 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718399212; x=1719004012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tFos4srfRrVrzQUm0UGzVsyI/wQsDZvZJgCvm060/KA=;
 b=doxbb10TLbBZOa8ltdIPswmMbEdmBLFczWyv2ZXvWqnj3r8NNNnxfgA9xBJoEx4ItI
 PhO2BOoX3qMtJGFYvXsd6eJirwC3OBWLKmxCI7PbcwlvZBZgC2JdiRDVxmfFVoQewVRn
 bYKcQEBJg5DHVn1d4vAyL/artMmi5OK9t/OL1piC/wiG9wRvmKzHYKwM0mgwktNGhKnv
 vsQILuB6yQvpq/x+keRU4j23HC8phUeRXZ4eK7t2s+mzY9xe6cQdY8Y5qyFHs99306Mz
 y+fusRwNTk6YXbiby/ww+UUx5UeeUCRb/c78pv3FyiKM0r28LoSu105T8854/aBiY8Il
 3apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718399212; x=1719004012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFos4srfRrVrzQUm0UGzVsyI/wQsDZvZJgCvm060/KA=;
 b=S0KcSgDu3hi6TaekDhcOGNgRSQ1EXzWfYaAg4sSVieBQROu/egULjaYxpWYUbBVVLP
 mkSYqPFszC7ECtyPrzahEhy+ct05NXpmDO7xHu9vh16E7cInBZvRed8xula/HWuoQDTx
 I9T8o928W3pF53JgJ4bivm2aGY5QyMrZaPKB2Htkzv7OFTqDUha6+jRXx4DivM9t3E8f
 6dQ+zbJN09nCdAnyS2+xfc4Oq5vOHZ5t22A4enxsBKHFGEfTJNvIBho5aUDRf5/z0Vcv
 rWvtdBlRNY46foNGoEzbgOUf0+voemabzV7jm/7ZZepMsCbgVJWhQdVCVW4dpgGKrnUM
 jSIA==
X-Gm-Message-State: AOJu0Yx0qUEaSOfIx1vRdixuSo1ifo3ZUb+JirdM3QOuUqhJGQuzvzqK
 MdwuhEBfWIIXqM6MHM0dqr0wlQsgcSS8FIiVqz8YLRXqN5KqmV9WXF9BQzHrks8=
X-Google-Smtp-Source: AGHT+IHXVM92hdyXXseaz7HIjPBDz5EJHFXf3/QTkPFd7CynrGdP6asiIi/lKAL+ExQ9JeF3n1Misg==
X-Received: by 2002:a05:6214:528b:b0:6b2:af3c:f70c with SMTP id
 6a1803df08f44-6b2afd9f616mr39718486d6.3.1718399211661; 
 Fri, 14 Jun 2024 14:06:51 -0700 (PDT)
Received: from localhost.localdomain
 (pool-96-227-82-228.phlapa.fios.verizon.net. [96.227.82.228])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5c2e9d2sm22545376d6.59.2024.06.14.14.06.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Jun 2024 14:06:51 -0700 (PDT)
From: Trent Huber <trentmhuber@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com,
 Trent Huber <trentmhuber@gmail.com>
Subject: [PATCH v2] os-posix: Expand setrlimit() syscall compatibility
Date: Fri, 14 Jun 2024 17:06:38 -0400
Message-Id: <20240614210638.5959-1-trentmhuber@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=trentmhuber@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Darwin uses a subtly different version of the setrlimit() syscall as
described in the COMPATIBILITY section of the macOS man page. The value
of the rlim_cur member has been adjusted accordingly for Darwin-based
systems.

Signed-off-by: Trent Huber <trentmhuber@gmail.com>
---
The previous version assumed OPEN_MAX was a constant defined on all
POSIX systems--turns out it's only a macOS constant. This version adds
preprocessing conditionals to maintain compatibility with Linux.

 os-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/os-posix.c b/os-posix.c
index a4284e2c07..43f9a43f3f 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -270,7 +270,11 @@ void os_setup_limits(void)
         return;
     }
 
+#ifdef CONFIG_DARWIN
+    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : nofile.rlim_max;
+#else
     nofile.rlim_cur = nofile.rlim_max;
+#endif
 
     if (setrlimit(RLIMIT_NOFILE, &nofile) < 0) {
         warn_report("unable to set NOFILE limit: %s", strerror(errno));
-- 
2.24.3 (Apple Git-128)



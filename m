Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04384C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2g-0005zR-8m; Fri, 01 Mar 2024 18:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1m-0003zh-8A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:59 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1k-00062O-GF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:54 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e49518f375so1109680a34.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334651; x=1709939451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6tPGvcWUCgEHkg4WhhgoNhXXsmKMPZyhGixNdkwuIE=;
 b=GILe9hoH0YjVaq9230ldul13mDDZzl1m3HvvDq6dDYBob8JmoqtOr6b5m4EcbryE07
 NSaxC+qJPFFvpsx6JjrCppyLfpnNJJOKyTTGAwoso/MMKyPZ8Tfa3bcYQXXp+LV0HMXQ
 F0fwiXHW53vKDx65yiLqR9kOoR4PCGqcZTZhowIRJ/QmR0w0wXdz3C5yVyEQT1HFPooO
 lzogJJjfjFD1TECqDeFdcGwwZM1qdDTUh72JQT1UNbfCxSYIs3At8Q/TSXwwbQOayo1R
 cPuU0gnARBRLAvpBY28ihPJ3ZCVLJ9lm9lZBtHLEZlzhfU7yMF/fdjp8l7zbc8V/ZSCW
 IWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334651; x=1709939451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6tPGvcWUCgEHkg4WhhgoNhXXsmKMPZyhGixNdkwuIE=;
 b=E36gfb/17a9o1V8T3kyKjOtRnRKz2iIoIJ3fVC8Gb6fyLkiLtU+iqhaFUpJHqnWfUB
 N5Dw5ycgKKp2P1PMldjOulZpbLUKhWDxyURFxUqPHycZGM/f4PmEERAgOmRHnqHlU4iD
 WHxA3TmswLRSW+bTipG8OVO8bf42376UYqGHlzVtMbAZXFPcQcZyyXeMpJCXfB5xm3+O
 LUHpqEu/AV/YqPbS9M8Ir+GeCy2fy1fYL05Gq08rUkHAGQWlfTMssH2i7WT4GuCQW94H
 15xf89DWL1ioLgzIVK6/yx1pR6DvEmD9WwQjwqWkzsN+Yz0yhlWPCs+0dsKKD53xTpV4
 OsTQ==
X-Gm-Message-State: AOJu0Yykq/ZG8px1/6Ag/OHQmLAp8EwDHT6fw5L/fb7TttMMLX9CoJYH
 SxLpzx2ZcOLcv9AvmBntsmzuddEgukAPfH36oPTUgZRlpKJgkqBZv9T+gElaG4izPpJaIOQjO2Y
 A
X-Google-Smtp-Source: AGHT+IHHaxj6DzVYlUPsjRsiS8sq/PRn2zRmYazDx5JZ/uqyf7n2n894LIweDzTvWXQQ1aqnhpo8IA==
X-Received: by 2002:a05:6830:1108:b0:6e2:de7a:8f6e with SMTP id
 w8-20020a056830110800b006e2de7a8f6emr3493299otq.31.1709334651431; 
 Fri, 01 Mar 2024 15:10:51 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 60/60] tests/tcg: Check that shmat() does not break
 /proc/self/maps
Date: Fri,  1 Mar 2024 13:06:19 -1000
Message-Id: <20240301230619.661008-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a regression test for a recently fixed issue, where shmat()
desynced the guest and the host view of the address space and caused
open("/proc/self/maps") to SEGV.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <jwyuvao4apydvykmsnvacwshdgy3ixv7qvkh4dbxm3jkwgnttw@k4wpaayou7oq>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-shmat-maps.c | 55 ++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c

diff --git a/tests/tcg/multiarch/linux/linux-shmat-maps.c b/tests/tcg/multiarch/linux/linux-shmat-maps.c
new file mode 100644
index 0000000000..0ccf7a973a
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-shmat-maps.c
@@ -0,0 +1,55 @@
+/*
+ * Test that shmat() does not break /proc/self/maps.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <unistd.h>
+
+int main(void)
+{
+    char buf[128];
+    int err, fd;
+    int shmid;
+    ssize_t n;
+    void *p;
+
+    shmid = shmget(IPC_PRIVATE, 1, IPC_CREAT | 0600);
+    assert(shmid != -1);
+
+    /*
+     * The original bug required a non-NULL address, which skipped the
+     * mmap_find_vma step, which could result in a host mapping smaller
+     * than the target mapping.  Choose an address at random.
+     */
+    p = shmat(shmid, (void *)0x800000, SHM_RND);
+    if (p == (void *)-1) {
+        /*
+         * Because we are now running the testcase for all guests for which
+         * we have a cross-compiler, the above random address might conflict
+         * with the guest executable in some way.  Rather than stopping,
+         * continue with a system supplied address, which should never fail.
+         */
+        p = shmat(shmid, NULL, 0);
+        assert(p != (void *)-1);
+    }
+
+    fd = open("/proc/self/maps", O_RDONLY);
+    assert(fd != -1);
+    do {
+        n = read(fd, buf, sizeof(buf));
+        assert(n >= 0);
+    } while (n != 0);
+    close(fd);
+
+    err = shmdt(p);
+    assert(err == 0);
+    err = shmctl(shmid, IPC_RMID, NULL);
+    assert(err == 0);
+
+    return EXIT_SUCCESS;
+}
-- 
2.34.1



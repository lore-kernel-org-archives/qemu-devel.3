Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC63606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MD6wEtsG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsOx-000396-Ky; Sun, 25 Oct 2026 03:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKsOo-00038B-W8
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:12:11 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xKsOn-0002qX-Bm
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:12:10 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so3532241eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792912328; x=1793517128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Si1hd1x7SCedpghybKN06a5/+kyb5OfoYF8j6pFZRY=;
 b=MD6wEtsG6uKxI5Le7LcecUE7azZ9Y2lpqLTYcU+ZlmoM5UYNBQ3LntZxZiam1EbpJH
 ZxjDUG8JQ4erDXcBGYt+X3rRlsZIv8I82cUREFxLI2UMxsjUKN07Sn8HJZ7x9XDIq8g1
 25aQF2vI2ZHoLp8OE32iJ/LTGJn/fx1YDFk+aOqpGzM77YSx46Tb53XSeAbMQP7dywgX
 Nwor6M8YGpdoHWfLZyQ2khdy7hyba9vde9pDD+80RjJwCf9KhX+yLOBWnpaQYzo2+z4U
 N18F5/4JChhtN06rlysTwjsTS8Rjw146mYSLV1u2G4lXUi4pTKZqVZYHgHcl10qQjXcx
 rmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912328; x=1793517128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Si1hd1x7SCedpghybKN06a5/+kyb5OfoYF8j6pFZRY=;
 b=bWb43Wv7dVnbLb9BDK3fNGJfZbSJaSMdWGoNjy7MpdSSdbQgPOwUs9dDyp3DFZy/QC
 4SbRIKli/lHmUszXDGsf9qzhaANIej7ZLzLi6AxRT5bmSvuo0VQzZJWxVW9RFoSK/LWM
 9QB+fIsK1EBdOT/9OyJ9s6WE2Zs8qSQqTbJ87aPg1VHgNx1rtJX9GSdYBHgrVWSJhfun
 5Q+mM9Rux09Xu5RHdhHqlpoYEW/fcFlAeDtHSEqOzDhAh/7lRYZ2tEu/RfFohQ/CbAQo
 jkHWv/Agc1LGpjfXfnELmCGtjMrOP/ZxWy8oTi58HxK+E2dGEEM1H9c+OjQ3sjNWSWvn
 PdRA==
X-Gm-Message-State: AFq9FYLjLynsQqnd7rFpLqJ1pXvHXXnBhfVAtb8CGEZ7YD06Ts6rMRs4
 7rP6aTRoSIqvFLKFCvpgIhBSan1/Ymi4/0iHhz37+K4mDRx92q2OqOgTECNysA==
X-Gm-Gg: AYBFou3NV407L5UWAvSyVz9PTwwfKMeAttPTFgpJ+vxITMNA/QIKe93tD2u3vRcezPv
 qJ8kcnFdxy0KhnvbEd3Jg0shbrhoGHLL/V6xI3KLLU/70BKdQygvHaLm5FVcl8YHft/2L0YB0NI
 qFc3vHe6dpQIbBoZKIUwIdZnVbO2zt9VE6lAanv9KaRRyvLEyjDyuUC+HisYNJD1TpZuR8Dd1Cb
 7y0dD5kj/hhl6/hOnpxpMlcPeTbM+K205knM3wdRbJ5Tps3dsFe3t1FkPSy/ouss8b2bk0bPyRS
 iuo3YjprgCfIzTbsLLRcCBxbVB1PpS0GYEm/1U7gqt6U3UOVZ9uOvvoHdrT7cf2imjP8KvfqLQ5
 A8dyo9rxew57T7mjLoO0hbn0fgOs/knIFa2hgdXruoECysxYrv77ynT1eW376BoExOb6T4QGIte
 DB4DdL/pfBGGaeT5QJ3ULDmCpfUVspfwzrxnt3cCbZ/ldYI+FnNS6DS46EOLtP7x28ziH7c+NVn
 hWEZxAhVQchLwx2xarhbTOB3D7Vr52ZrrxofwbGWa+L8ec=
X-Received: by 2002:a05:7300:8291:b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-369e8362b32mr5597780eec.4.1792912327793; 
 Sun, 25 Oct 2026 00:12:07 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec9276sm23307132eec.25.2026.10.25.00.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:12:07 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] tests/tcg: check that a zero-length readv/writev
 validates the fd
Date: Sun, 25 Oct 2026 07:12:03 +0000
Message-ID: <20261025071203.1214199-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071203.1214199-1-takano32@gmail.com>
References: <20261025071203.1214199-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel checks the file mode before it looks at the vector, so an
empty vector on a descriptor opened the wrong way has to fail with
EBADF rather than report a successful no-op.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../multiarch/linux/linux-zero-len-iovec.c    | 41 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-zero-len-iovec.c

diff --git a/tests/tcg/multiarch/linux/linux-zero-len-iovec.c b/tests/tcg/multiarch/linux/linux-zero-len-iovec.c
new file mode 100644
index 0000000000..e16b643ed4
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-zero-len-iovec.c
@@ -0,0 +1,41 @@
+/*
+ * A zero-length readv()/writev() still validates the file descriptor.
+ *
+ * The kernel checks the file mode before it looks at the vector, so an
+ * empty vector on a descriptor opened the wrong way fails with EBADF
+ * instead of returning 0.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+int main(void)
+{
+    int ro = open("/dev/null", O_RDONLY);
+    int wo = open("/dev/null", O_WRONLY);
+
+    assert(ro >= 0);
+    assert(wo >= 0);
+
+    errno = 0;
+    assert(readv(wo, NULL, 0) == -1 && errno == EBADF);
+    errno = 0;
+    assert(writev(ro, NULL, 0) == -1 && errno == EBADF);
+
+    /* A closed descriptor is rejected all the same. */
+    close(wo);
+    errno = 0;
+    assert(readv(wo, NULL, 0) == -1 && errno == EBADF);
+
+    /* On a usable descriptor an empty vector is a successful no-op. */
+    assert(readv(ro, NULL, 0) == 0);
+
+    close(ro);
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index e60a052700..97e2ba76dc 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -61,6 +61,7 @@ tests += {
   multiarch/'linux/linux-shmat-null.c': {},
   multiarch/'linux/linux-sigrtminmax.c': {},
   multiarch/'linux/linux-test.c': {},
+  multiarch/'linux/linux-zero-len-iovec.c': {},
   multiarch/'linux/test-vma.c': {},
 }
 
-- 
2.53.0



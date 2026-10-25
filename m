Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WATdUs4J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL5C9-0000TW-Rw; Sun, 25 Oct 2026 16:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C7-0000Sf-Li
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:55 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xL5C6-0006AX-1S
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 16:51:55 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35d0be18c71so4086325eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792961511; x=1793566311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uSJ2CEYN4UhQwFZrnsW7lOqDilBREcb1D2+lCHaL0cc=;
 b=WATdUs4JYCDxpFXHali3AXs7onVHBEug8LoChm7gH0CWaP2xV8ZpG1F9HptNa89l33
 sgGKFWSnwMr2VmtymEv4R/Ty7I5aXlijelGVeBhlptZLzlSgENXnMBCRqUEUHJv7JwsG
 UA9aEInF8iTCnuslCNuF1dE0XNVpE+v1FQg2WwW1ucrhjAlAFhNMwxK58xs+LywhSBfs
 TP13YSmf7fE455C4G2bAn2YTg7wDE6ld174bEGISmnCKBhuUJnVBuw/RE8IjJPjddkZy
 PM5Q9ia6Y0iIkvfP4op9toUueFPjp7d7+UkHIOXK3XiPhS2f8UvGGSVqXsp1wL7LInhC
 cJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792961511; x=1793566311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uSJ2CEYN4UhQwFZrnsW7lOqDilBREcb1D2+lCHaL0cc=;
 b=dMLScLKZ688/+2JkNBHbRAGDyg3ytt6aOS0e6Ialy6P+dNwZvYXSkW/nhbKYU3uUG8
 a2w7XB4aiL0QgpO9urErn38/UJlg2YxpQk+wFi6ZRYKblCabo7z9UhWBTjeRWQenxJZe
 N3Qi2aMNiFTZLqWUS2Asvh0l3EUKLhwypHKGcwIKW8R0vwQa6ACfVwJdsa5nAl9RNm9Y
 cnxpUA7DpgjYafaqtwR5qIxF6Gg/rMunDdbONKPKvZAbbUSiOtCIFvWu+joVFaHzMOoG
 yBAgiMAepgFx31QZEW/yYeCzFdewmLmWOGn4eWgCa6+6WwQUvxe74CMsTAicMCawsZ3Z
 JLcg==
X-Gm-Message-State: AFq9FYKE6Iob5dTjdKAV95Wb8vlvoFkw7HXYz0R2/5GA2lOt0jveTB6j
 g25WHWSkA/+uI5BciP/vs6S6P1nMAuQ8AcdyS11lthJJswfBpO8DIjXcaiz/RA==
X-Gm-Gg: AYBFou21CcpZP7NDSYMQRBIe4TXrtvZCh43xTE33vMYMIyDzxhH1ZNkjF2fni9APIaI
 70Td05piia1z9yrjJ9GFZ2RhoyQCMXs/DTkIx3JMO4jlymK6qPUt/FXgoqT+EQuLmlzkQ1MEVRh
 sU7RzHVQI3n8UnJ9k3hqt5uM1gK4ohO1JiyVE6vZ48eqGcTQ0EgyIkDNQCOX3UgaNu1xjicsFwr
 0y3hm9xUSB7ZdwCbpe8UVlhcCUjX0of2Hyikq1TFa0VMxaNTlEOKjn8BjtWNQi5MeJj46BBwM0d
 uN5WUAWe4+cF3ZAV69FYzzD3VLXKZeHKCKiwlv92mWp7EK2VMu7oEBWHCxXJaXwuVeyK3NCoHQG
 yRo1Q/d7n+CKy4kc6Aaicif/xg/yZi+vB2pugfs5Sji/3Kv9i6/KZsdQ1p4UkIWHDTQi0I32KOc
 0lPUQ3bAQZdbEY2M6QmwnNn1rG8DESyJdQHTGiuU2LuuIMJ51A9OgXreCyw4L1/19oAcKw9b5mG
 VTpDOPT46Ju+RVFb34TN8T7gI2WhPcRW2IvU9lMI7IH/lI=
X-Received: by 2002:a05:701b:4181:20b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-199295d370amr6857385c88.3.1792961511263; 
 Sun, 25 Oct 2026 13:51:51 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5937dsm18680738c88.20.2026.10.25.13.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 13:51:50 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/2] tests/tcg: check that a zero-length readv/writev
 validates the fd
Date: Sun, 25 Oct 2026 20:51:44 +0000
Message-ID: <20261025205144.1781959-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025205144.1781959-1-takano32@gmail.com>
References: <87o6chn1nw.fsf@draig.linaro.org>
 <20261025205144.1781959-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=takano32@gmail.com; helo=mail-dy1-x1334.google.com
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
empty vector on a descriptor opened the wrong way has to fail with EBADF
rather than report a successful no-op.  Cover readv, writev and recvmsg,
including the usable descriptor cases, where the call has to return 0 or
the error of the socket instead.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../multiarch/linux/linux-zero-len-iovec.c    | 56 +++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/multiarch/linux/linux-zero-len-iovec.c

diff --git a/tests/tcg/multiarch/linux/linux-zero-len-iovec.c b/tests/tcg/multiarch/linux/linux-zero-len-iovec.c
new file mode 100644
index 0000000000..79666dba88
--- /dev/null
+++ b/tests/tcg/multiarch/linux/linux-zero-len-iovec.c
@@ -0,0 +1,56 @@
+/*
+ * A zero-length readv()/writev()/recvmsg() still validates the file
+ * descriptor.
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
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+int main(void)
+{
+    int ro = open("/dev/null", O_RDONLY);
+    int wo = open("/dev/null", O_WRONLY);
+    struct msghdr msg = { 0 };
+    int sv[2];
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
+    /* recvmsg() with an empty vector reaches the socket too. */
+    assert(socketpair(AF_UNIX, SOCK_DGRAM, 0, sv) == 0);
+    close(sv[0]);
+    msg.msg_iov = NULL;
+    msg.msg_iovlen = 0;
+    errno = 0;
+    assert(recvmsg(sv[0], &msg, 0) == -1 && errno == EBADF);
+    errno = 0;
+    assert(recvmsg(sv[1], &msg, MSG_DONTWAIT) == -1 && errno == EAGAIN);
+
+    close(sv[1]);
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



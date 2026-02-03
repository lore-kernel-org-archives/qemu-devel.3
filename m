Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C419AE7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExN-0008BE-04; Tue, 03 Feb 2026 06:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx4-0007yj-VG
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:15 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx2-0005AD-9c
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:14 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so809426166b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119529; x=1770724329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Joeyp3Wt8eRfhFTETp2dv+O0vYWQ3id566kC7NlCTjk=;
 b=Tw+1LvwBa6J9UZYBsXwnKlUb5tcuukmDIkDMbS0YgEj1T0FYUv7XIhvVwaxwD7Oqu8
 zrQp0xPIGlrWqG6uuTYfzoe6Dd7E1hMSvP4ltCRR7vsa8B4gyjrLQ2cB0qtfcqjBueeP
 2T/QJQY3yAV3b2xk1VaTuXaChFeyPNAic1Ii4kdlcvFOjjBuS+MQcEW9Q6yv2Idohzw9
 EvWgCSyUCQg53I74TCmedh3A3M/M7V1POvMxz72naHbK23acs+OzxsuU3mq7n98cevHj
 I5EPilShMAHdouzESUiB1lzF2ek3SEqF/rXFZGKI/J/auPywAb9ogop53FejeGcJXyuw
 qbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119529; x=1770724329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Joeyp3Wt8eRfhFTETp2dv+O0vYWQ3id566kC7NlCTjk=;
 b=RM5Sc+m9nt65HBaQ7OqnlgePB3gJxsvLSZzgIkqFZcMO1Nv6EmYZB8Sk3gGDSz+hkE
 N9qXtLJyw6N158R57SoqPD/VsZ3c+3JXBYhoo8X4txNpma0ocVj9FWh9eKgK63BJvHdo
 PM9yIBRFBsU90HWVtbyqHfprb4u+4ReTFjOx7tM+eeRLYQt8ZSg09dgQkYaIp2l8I3XY
 R3/dbliIJOFesWrJ+cLQZOxeE4YOLFaddM51I9XJz4uiUxYEFqpGRjlxT8dYh+EezYMd
 yCv7NzZB2t7F4YjSho5QYQDO+HMwD1E/xupfZVBaH02zQGnd7b1rZJcHGF9s9/CzPkFR
 jZCg==
X-Gm-Message-State: AOJu0Yz0UuS4RuLYGYUX6K/NHnB0damF5atcKDRfokyakZG+hX11SAuU
 NTdTw2e0NvvKppG6fRc8hsoMPiTKHNco4jdMwWQOTULbwKjZ5vsmftdOG97MWxxI9Tc=
X-Gm-Gg: AZuq6aIGeiYRKIModd7OJIlJir3hPS+6jGB7IcOgXeZ/5mQmvsoGjvBQEsUdW2dlmqs
 Snrkd4ZSXy0c5/CRAIxpNeQdbru4u/wft/pZwfsLsLGY3/tSH8GrSwBdvrydBp4P4D7+ofr7vCJ
 JcSNkIWh0PUVjME08pm7qOAKAWCpbjIeXnfVprpFnZi8je8rGLRuYKTyCgvU53eGFAi369TZyT6
 tkXR3gmoZL6o3aaZZwf2NduSTV1cDP8f8mIVc3KbqrHxs6r/JlJt8oPTsdl3lN5HYGbTMPSLAWn
 N5W6PapN1ENlSCvqSzKoKZBbu9sb43RRRe/FK3rv+Vq+JXnsPNbHNiV6t8l63CKxMnr5Ea01Xx5
 aqH3GxvSaop4jdtV+bkIrs2F+y4tbxWy98zbUUUmpqvaC2geoC+irNpf2lTK52r27ta3WJKufNq
 iryyWsBAaVuDw=
X-Received: by 2002:a17:906:7308:b0:b8a:f225:ede1 with SMTP id
 a640c23a62f3a-b8dff72c615mr978091366b.41.1770119529252; 
 Tue, 03 Feb 2026 03:52:09 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf1baa42sm1032887166b.46.2026.02.03.03.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D17B0602F5;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 08/11] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
Date: Tue,  3 Feb 2026 11:51:58 +0000
Message-ID: <20260203115201.2387721-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Move host_to_gdb_errno from target/m68k/m68k-semi.c to
gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.

Add both newly added GDB File-I/O supported errno values, EIO and
ENOSYS, to the mapping.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-3-yodel.eldar@yodel.dev>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/syscalls.h |  9 +++++++++
 gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
 target/m68k/m68k-semi.c    | 29 -----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index 6200416f77a..a09559128b1 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -102,6 +102,15 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...);
  */
 int use_gdb_syscalls(void);
 
+/**
+ * host_to_gdb_errno: convert host errno to GDB errno value
+ * @err: errno from host
+ *
+ * Given an error number from the host, this helper function returns
+ * its GDB File-I/O specified representation.
+ */
+int host_to_gdb_errno(int err);
+
 /**
  * gdb_exit: exit gdb session, reporting inferior status
  * @code: exit code reported
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index d8bb90cc1c7..15050984a04 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -145,6 +145,42 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
     gdb_syscall_handling(gdbserver_syscall_state.syscall_buf);
 }
 
+/*
+ * Map host error numbers to their GDB protocol counterparts.
+ * For the list of GDB File-I/O supported error numbers, please consult:
+ * https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
+ */
+int host_to_gdb_errno(int err)
+{
+#define E(X)  case E##X: return GDB_E##X
+    switch (err) {
+    E(PERM);
+    E(NOENT);
+    E(INTR);
+    E(IO);
+    E(BADF);
+    E(ACCES);
+    E(FAULT);
+    E(BUSY);
+    E(EXIST);
+    E(NODEV);
+    E(NOTDIR);
+    E(ISDIR);
+    E(INVAL);
+    E(NFILE);
+    E(MFILE);
+    E(FBIG);
+    E(NOSPC);
+    E(SPIPE);
+    E(ROFS);
+    E(NOSYS);
+    E(NAMETOOLONG);
+    default:
+        return GDB_EUNKNOWN;
+    }
+#undef E
+}
+
 /*
  * GDB Command Handlers
  */
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 578a08dfee8..bdc798a28cb 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -46,35 +46,6 @@
 #define HOSTED_ISATTY 12
 #define HOSTED_SYSTEM 13
 
-static int host_to_gdb_errno(int err)
-{
-#define E(X)  case E##X: return GDB_E##X
-    switch (err) {
-    E(PERM);
-    E(NOENT);
-    E(INTR);
-    E(BADF);
-    E(ACCES);
-    E(FAULT);
-    E(BUSY);
-    E(EXIST);
-    E(NODEV);
-    E(NOTDIR);
-    E(ISDIR);
-    E(INVAL);
-    E(NFILE);
-    E(MFILE);
-    E(FBIG);
-    E(NOSPC);
-    E(SPIPE);
-    E(ROFS);
-    E(NAMETOOLONG);
-    default:
-        return GDB_EUNKNOWN;
-    }
-#undef E
-}
-
 static void m68k_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 {
     CPUM68KState *env = cpu_env(cs);
-- 
2.47.3



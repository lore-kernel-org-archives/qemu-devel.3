Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A072C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sx3-0004h8-Os; Wed, 16 Sep 2026 12:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x6sx0-0004h0-QI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:57:40 -0400
Received: from mail-ed2-x2a.google.com ([2a00:1450:4864:33::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x6sws-00039g-HU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:57:35 -0400
Received: by mail-ed2-x2a.google.com with SMTP id
 4fb4d7f45d1cf-6aa06e51bc3so1910820a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789577847; x=1790182647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tZisafzgtk2/mw3WI/Dweiz7Xg4YQl/QK9bqI8aVIwU=;
 b=s6IFfT+QwtRqBCFeN08X1Nrlk8dMCsNyVq8X0gp8AxwXYEs1BxZlo3Jb/brR08Ak3P
 0+gZnmhSznu26D8XfpRo0wBnxjAPzvkzUJzhbI6rTByyF68LIwdLdElKHM+KRBQZpJQY
 yWrbkOpA6toa9zq2HbuHJBf0ZEWa1X1FNX2TvYjCnNEosWXIovYXVrqn3dGJYVjbUKDL
 XrN9PRG5Z2naZ9nv3+/pgASO/YcY9btSmRt7xB8QEbZV3r1z5XaKrv/OYZ0MdzJ5n98u
 eKaJbF+gyt4vqIZwpxZnHYBBlOfcFD7BeUW8mT17m2GUaTfryt3/YXgxpaEA9Fp6GziP
 EoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577847; x=1790182647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tZisafzgtk2/mw3WI/Dweiz7Xg4YQl/QK9bqI8aVIwU=;
 b=2SPMMIvtMcqhoMYMe2luSlE16Tgk2xfc5vNoNNwgaDaYi6orOxJM2M1FgVvuRsxkUe
 d1DJPNHEa37QrDrKKGOscgYvkzbIPIPxRtDomyiwfAgDpbOd/fSm63BxUuScWVui/hIK
 c6tfNPsYEe1gi7Zjm8lUSu6UFiXlgfYHdpLWZgn/Ahc8Z+tf9NnKsJDbeuDEBKpUzXZn
 m/NcW9atExu7tyCIHNZljQ7qMXvQPuT61abMaCjVr2s6U3g6DdaqxVc7/9iWrH4GNeb0
 ONqlZ+jj6PdexZiteGx9N1tlj/QJZUGRF2A1U+++u4tOMCVjaLz+2LdtFj8nZAlY08eA
 7aig==
X-Gm-Message-State: AFuF++k/CSNJSx9dSg3Ko8IkiQ+p8tFrEUt7uuqD2l6S6ke5jlqRNwUD
 iRVFXX+U23X1d1jHjjsV78LpPSvsVMGfiKhQCMwChqv1kiz2Rw3LDNixO6s3LN0x
X-Gm-Gg: AYBFou2djX84wlrHdow9biYmv4TzvRMU/z3McDU24F5mUEUPf3aNBBwXDgUEUDbhqv3
 HgduEHC+FLW6YX/jg+7C+DY/H6ny6/J419kbd7Js2KQvYx/YDdmSSHNKBDB6qjowcPzvok6tGbH
 Z3QgYd2Y41gr8UXcYSTqh4V+zzUjUw0z2u45Tu+nzCFZXXfGAgGI1D4t6TrBp0m1OJcDTtMLIoL
 h0eojB8cjC2L/TToUf13Ol+L1b23msHssFDNVuZTy0flsRZYE2UFmrmjZR1u9k59Gsbt/UzOnQF
 fNQIN5+xiybCf+pJeu5IBfipjaBJo2cZm1M8CmryCXovtuUe1sZTSsD9PlaY3eAAvFVrYTL4l56
 HhvHay2btdt1X+DkDXzP9JNanzWceaQX3Nqx/DZ5e4NXOBkEQc+w8KlnSUMh2SI8pa8Fdsnbuys
 WKcXGotqqPA/IRVSp0KJtzH349tFkfRW4ibsqnD0QvzHn5Em4lBQXWZdUJjNY3WHU06Jnplispb
 OXyIdlsPT745U09l/HkiCFCK5Oy8Ml4rfC2bnPrnCpXL0nHz21OXRSZlx7x731aK/h+4X2EcL3o
 7K4mplEyqA==
X-Received: by 2002:a05:6402:23dc:b0:6aa:1112:62fa with SMTP id
 4fb4d7f45d1cf-6aa2224c8ccmr2210269a12.4.1789577846629; 
 Wed, 16 Sep 2026 09:57:26 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a874esm2005558a12.29.2026.09.16.09.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:57:26 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] tests/unit/test-qga: enable on FreeBSD
Date: Wed, 16 Sep 2026 18:56:20 +0200
Message-ID: <20260916165620.56264-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::2a;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

FreeBSD has all necessary commands implemented,
so enable test-qga for it.

Requires only minimal portability fixes for sockets
in connect_qga().

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/unit/meson.build | 2 +-
 tests/unit/test-qga.c  | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225a..0ca0d8974e 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -169,7 +169,7 @@ if have_system
   tests += {'test-qdev': [qom, hwcore]}
 endif
 
-if have_ga and host_os == 'linux'
+if have_ga and host_os in ['freebsd', 'linux']
   tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
   test_deps += {'test-qga': qga}
 endif
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 01ccf826e6..dbedfe3d5f 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -18,7 +18,7 @@ typedef struct {
 static int connect_qga(char *path)
 {
     int s, ret, len, i = 0;
-    struct sockaddr_un remote;
+    struct sockaddr_un remote = { 0 };
 
     s = socket(AF_UNIX, SOCK_STREAM, 0);
     g_assert(s != -1);
@@ -26,7 +26,11 @@ static int connect_qga(char *path)
     remote.sun_family = AF_UNIX;
     do {
         strcpy(remote.sun_path, path);
+#ifdef SUN_LEN
+        len = SUN_LEN(&remote);
+#else
         len = strlen(remote.sun_path) + sizeof(remote.sun_family);
+#endif
         ret = connect(s, (struct sockaddr *)&remote, len);
         if (ret == -1) {
             g_usleep(G_USEC_PER_SEC);
-- 
2.55.0



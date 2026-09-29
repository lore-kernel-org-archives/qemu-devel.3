Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B258C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZLz-00066N-Rc; Tue, 29 Sep 2026 11:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xBZLp-00061n-54
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:02:37 -0400
Received: from mail-ed2-x27.google.com ([2a00:1450:4864:33::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xBZLn-0005CH-Jj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:02:36 -0400
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so6774552a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790694154; x=1791298954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wCJraiJ68H240sGoSZi0TruiHWrQBb5Al1gM9FHqa+I=;
 b=O3IeigNkVQScqjADWVWzYc7EGeYmwc+iUwz1NZd3wB9D/QmvR0WVMvCwkttpSkjReR
 4pTSnG+oOqO21vub+UAb1mdinUYfr5FGsrOVzYfbbiGufngVbm6RN1U32od0uuk94hO9
 8WpL6UFxn7DjbZHZ+SSMBEVJIsxpKmiu8Zv9Fb7DTYNedtknLHJKKlZuVRr09m34hqp6
 JyJrmT5SvzuSY/f3ZG8H/Rd5FDZKU+rybwWSymWuuz+ycEKN7XI6qXd5KUHg4Ax1WWke
 Q+giDfpI1YVX4sfNh2XKPz7QkwO1/unmhBPswzxvbvaTyj8dUxAn1hm4IPhfMpq7w5oH
 qXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694154; x=1791298954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCJraiJ68H240sGoSZi0TruiHWrQBb5Al1gM9FHqa+I=;
 b=GrxxLOnMu8/WSvxjxeaCYbvp9V5vXQYfKlE5ekxj/H+KTuNf9cSKBrZ5vTofuy8n/9
 xUFR1s/xhLHjEWD0jI3e3BXcyNl+vOmrwZXOpAQZVUw4XdGM5hnyCPcP308hrWfFd1rI
 IaZhsCarb31WvswbTg4kxIA/bwrYdvfPOUrfpQYgBHzFk4nCoRPnl7crSJXUg/pG9VM/
 Q8pm/bnsschT5fTeDmmL6GlD74jaljzX1xbRzdEY6/i5OF4P9eyG2hh3VoKpoUlUtTyh
 r48FyfVsO1dRsdMr7Mp/qeWERHV7soUhgsSRoJsx5RCySM1Rsr7n/GtFbP7EDvnG2RNl
 yceg==
X-Gm-Message-State: AFq9FYIcZKi4GFs6Sitr7FBSBlt2xrwFIozWLw+tg301EkLBAZoxETCY
 5fTC94+g0T/xpdhCqMglOlCUu6yPJxMzh22gjKtCGUqSzSfxH6ofjB5s2Gfn1bxS
X-Gm-Gg: AYBFou3HC9GiHnY1cAPI8wvkB1gzyx1Ua9HrXttxdaL07x+cjl5QK6LkciU6aR7iF80
 lhDoSZ2Kh7hSnxaWbN7++AtplHkEQ41lC85hsrxPt+qM+QIA9hG87p+derD6AzikNW4sZE28R9c
 XK8PC4xPusauAU87ZrdtI8yyFB642yzvA+HmPQQT7eNHJU6EboYYTFt1VfFm05qVkaIQ9SXZKBR
 TDWhMVji32znsbuJCHf9xvtzcDBVwouFzwhAgzhiVw/EKFN/kuTE7o3NBVcO0EtbLvyhKVz/YqT
 EOW5BX7ogvbUH8N5RFDQy0+0IqACRJOOI3Gwa4JdAYek0MSwoR2TX9YrKis22nV4Qm2ll1Plgj1
 Ega+qURgSMdrG1ZF3tYJh780T6mrA1I0VihnHz+ayuUG2rfKXG7vDms09q2PRMAQguA05Dqq2sr
 oQ3jNmaBmL5uZu9yruWY28rXdJMESAw+dfJ6stUw3/aZTQiokYkOSM7XQnB+08wabnA0FM8z6ZN
 eFeL3OZa7YzUfnwBeanroxiyPXPTVW9KyUiSUZGZKT9Q/LxLk+BqCUtVHB2LgGX3hs3uHeliNoL
 QJwkfKPq
X-Received: by 2002:a05:6402:274b:b0:6ac:be1b:71dc with SMTP id
 4fb4d7f45d1cf-6acbe1b76e5mr803658a12.6.1790694153348; 
 Tue, 29 Sep 2026 08:02:33 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6acb90360a3sm1018301a12.27.2026.09.29.08.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:02:33 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2] tests/unit/test-qga: enable on FreeBSD
Date: Tue, 29 Sep 2026 17:01:00 +0200
Message-ID: <20260929150100.66035-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::27;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed2-x27.google.com
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

FreeBSD has all necessary commands implemented,
so enable test-qga for it.

Requires only minimal portability fixes for sockets
in connect_qga().

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
Changes since v1:

 - Drop SUN_LEN() for 'len' calculation on FreeBSD,
   use 'len = sizeof(remote)' on all platforms.

 tests/unit/meson.build | 2 +-
 tests/unit/test-qga.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c187..295df1a7eb 100644
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
index 01ccf826e6..b1c84c188b 100644
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
@@ -26,7 +26,7 @@ static int connect_qga(char *path)
     remote.sun_family = AF_UNIX;
     do {
         strcpy(remote.sun_path, path);
-        len = strlen(remote.sun_path) + sizeof(remote.sun_family);
+        len = sizeof(remote);
         ret = connect(s, (struct sockaddr *)&remote, len);
         if (ret == -1) {
             g_usleep(G_USEC_PER_SEC);
-- 
2.55.0



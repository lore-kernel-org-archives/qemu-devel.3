Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAD2F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxN-0001Wi-7D; Mon, 09 Mar 2026 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxC-0000uB-2S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxA-0000g2-Cr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485345e1013so11881745e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071730; x=1773676530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v9qodVqSzhxy9EFNfzaSmBMIOfVE8pcU0DSadNCtLco=;
 b=LRxf7P1a4Cj1arDq3Ki3HXLlAGgnvOtn5MVtt++5rC4tZ4F8r8ZhpyKUOc+opvyzjz
 7b8G4cPMFXSAatKQqCYbXWJ6vHmhxf4ZBjSpsi24nK5TJxKu981DBGL5361PH+U1k97n
 NGhb2ux8aHViYfZKgDy43Ck6zKUDfwnXHvn1GinGl70MGAGLUYljii8WGsUyuDQ+4k0C
 f9W7krtGGmiIlAecHPe1rnQEeHGb8qNzxNw6bB+N6so1raEWUcrBTP0FLCpLPWWV4x1D
 icIq4LstFeXxIBWVwmFCJYDESBLXupTiYWuy3RRR6IlI7vJ7OCmRzXD4rKOVCrsGoHs0
 75cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071730; x=1773676530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v9qodVqSzhxy9EFNfzaSmBMIOfVE8pcU0DSadNCtLco=;
 b=PddrxUL0UerTpak1iJ9d1QhOy6VQybLe9FJiYY7MoyfNLzKuqFZ+1CjvyZRy4HVTnW
 /tZyDK9C6Ju0tJ8UXZEmL93ZVT4q9aWs1OAlX6PDxWowv3BRNLJmOU9vY4ekjqlGamEm
 OK29x0WP2gncdzfCXeFfyABz5Qv1t6yL60+4L848JN3lECc7EOtw6QKAA158enili8SF
 qBelvP1t/0IJ5JuMnpSEwFGy4a909lPYbrayvztDffNLBrGx59ajw+mmIGkEKsnhFQxM
 kDvgdk4Lt6ESXT8+HOax9ttN9JjCGgHQcbMjZ+LkMPcqGxzPRhFx9cFNQq6KgDBX1dhh
 Rk6Q==
X-Gm-Message-State: AOJu0YyrSeqfmAtg1Lw8oEtnnR9gwzv6q9J+cHDx29e99BmxNq6mbZj7
 nRfIp3ABhuU3kfbxxNb/xDSpEB5uNtg99mBlSlwwgmygyMIH+Q29GXekrF8vXxuSknCdG4GW7Wf
 DdRRCkSo=
X-Gm-Gg: ATEYQzwML85UeP3HpJt5EaetWUYxnC186fCRasanuKXDPJKnbuVyLFvnTAz+hOfJvHn
 tTW0TgM3xCfTUYgOAstUdseY5jsCiozf61s1wxof+6DgHFuaIFHeY4QFMy13ZhKCAYWD3/Trd3g
 Cxx5W/INAWEuS83FzidLcNopNBd5O3rzTL5BIgFnDGwZtrGmKNtyOEFza/Ukm1Jh3QBdNyp4W87
 mSEIo1YS0vfffy3FGjwCZqDvDRj1pHHqQ0vRnEWB9+cGyHQ+70JiciBXSnF6bHjAk5OPHno81e4
 F0ZFcPmQfOYnzsBNnRA0Jiy/KH7cV/QQn5v9+nDUy7WcOk7giLpDjRTXkUeECHGAS6t3zqC6uj+
 3Zr3zieYgLmoOcw54izmi63vpZzxQR+oZTgkfGDVPndibG90IjnUQiIcYEFEk5dwUs/ksnwF/t8
 cAOY2UkLY3nw2xxlw7YJ53kftN6fR9ipQgohoAGQKWc1GVQiFCtXhQTC7kDcuE8WQ3jjy09WNMF
 B68DDYWpqM=
X-Received: by 2002:a05:600c:4509:b0:485:3b4a:f707 with SMTP id
 5b1f17b1804b1-485419de2fdmr1830225e9.10.1773071730518; 
 Mon, 09 Mar 2026 08:55:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9e549sm745355e9.12.2026.03.09.08.55.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/49] net/passt: Only kill passt if it wrote a pidfile
Date: Mon,  9 Mar 2026 16:51:58 +0100
Message-ID: <20260309155219.62400-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Peter Foley <pefoley@google.com>

Avoid killing qemu if passt failed before writing a pidfile.

pid is initialized to 0, so calling pid in this scenario would kill the
entire process group.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Peter Foley <pefoley@google.com>
Message-ID: <20260305-passt-v2-1-f0582198afc0@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/passt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/passt.c b/net/passt.c
index 9ed811a5142..b3d4b713140 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -102,7 +102,9 @@ static void net_passt_cleanup(NetClientState *nc)
     }
 #endif
 
-    kill(s->pid, SIGTERM);
+    if (s->pid > 0) {
+        kill(s->pid, SIGTERM);
+    }
     if (g_remove(s->pidfile) != 0) {
         warn_report("Failed to remove passt pidfile %s: %s",
                     s->pidfile, strerror(errno));
-- 
2.53.0



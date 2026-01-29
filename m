Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7877D73E85
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyS-0004pD-AZ; Thu, 29 Jan 2026 12:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyQ-0004hQ-C7
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:30 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyO-0000fQ-Jw
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:30 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso1169182b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708307; x=1770313107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjhHTfr1mROlpEqdEr0G1kp1OMMPs0Q/qCF0PmqBvts=;
 b=X9BWXQFMTWXElQcZQ7+1V3nOwziZOcg9iJSmnuFRB1SR+FE7U+4iYV1Hq+X+GtILN3
 AvwQjwxasVq0wV1ZWaJE3p7m5uTycSUgNOFjFE0wKEqO7obsqnGt63tPQT0px6e/JJvJ
 ATql/uNlo6vG23+rfZ5oULBhc5RZe+5iHvJ8s7WgWaVO1Frh2c0/zh9fsAL4R9WOIjTK
 oa6WwIivbqjYbWI+rFE7xsFfyxpOq5YChYMDikJ+hgMnSlfsnQilq0XZRJ9mbk9Q7PY0
 RcnQOJvCUg4ODUtn5k6dcrOnfKzv3uqkP2UjDyMl8eEZJmH0371CjC5irsRNg7w78/OM
 YKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708307; x=1770313107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjhHTfr1mROlpEqdEr0G1kp1OMMPs0Q/qCF0PmqBvts=;
 b=tbO+GuyAlEWRKRD5rdqR8Ami6SNdhVGVsW1fWRC0yTBfMjLBDY/iF6I8817BXWgoL7
 0TqxWet4tnK34jBcBDgaqFX3TnIyjliNHUim5j0fwadLvxjzC4FR3vQKq9fET+9TzvCD
 Jf55Q+AD1iqJMQJ/OLmUL2dGMGS/TeSbkvuYF6ObTWUeD6YFOCnNmG5uVtQLOI18Ih5F
 6SIImg1+461ZatIlTMi+gZ/UuwNd7n5FEXRyl3RBL+Z2BloQmNwUXpeA1tKnJA7/HHue
 1mT8lBaGZR4Wn6AIl4f4BFWsa6YKnyo84+3KQMtBdwR/4iOAZ9Fky8CjSP0TZuLmFvBf
 C7qQ==
X-Gm-Message-State: AOJu0YyXsBaC5xUcOq0o2nIZ4YuOLzB6wjXVfkweRiUl50SmoM5Sea92
 Bh3MejLGyST+KLdn4SZxDgcM6xdWbpDgql2OybO5/LmOiaC/pCYHdoiEepzv8v6n9cPu6yjQ1ee
 NXlZx
X-Gm-Gg: AZuq6aJ4Pz1XJcnB3TtvcRji/l2JmkQctN9w29ItMVMoiQHdgoF4tmWZSQ79g4Fss+8
 RTbn22PVDI5Lnd/JG2QWartugZOFe16xDevCMmXbdDk0uv5xF4VVbH/ualm80XOR6O4Ay/n6jyZ
 HNkAnRP2QmRnjCiKjId3dN4cBELi4pDCSo0sESsl7Nzcbl5WWhBzPkR7y4Yx3djZXp11fOHk6gH
 Xr8UilbkKf/5a/QHByderZQ2CcKwI/bcigmhfvykpehFXVnPo/qdQVnuV83IkAHzvNUckdPvKAM
 ktBfXJpbohaA8+pYCupbetpmyNnrrjbqeWJ9Lyfzvbo8zavDRkuKLyIsKKRj+4ymDvUr5DWZFSo
 q2XMa7jNZCKv+Es/cbEv1YbpU3/hLWDVcnTDB5c1mPDiHnvl2RFm7sF9YnxXt/pPH4BdNAeOgJm
 zfzg4l1gTZlDOmow3LYMAE54NDp2wV0GqaVpsjAD4sLNHi2t7+jAuBnvWSSMmnqsmG
X-Received: by 2002:a05:6a00:4216:b0:81e:af19:34b5 with SMTP id
 d2e1a72fcca58-82369299aefmr8660663b3a.38.1769708306923; 
 Thu, 29 Jan 2026 09:38:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 12/21] plugins: use complete filename for defining plugins
 sources
Date: Thu, 29 Jan 2026 09:37:58 -0800
Message-ID: <20260129173811.138036-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-4-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/meson.build   | 10 +++++-----
 tests/tcg/plugins/meson.build |  7 +++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6915ffa5fbc..3d2d7862e0c 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,15 +1,15 @@
-contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'traps', 'uftrace']
+contrib_plugins = ['bbv.c', 'cache.c', 'cflow.c', 'drcov.c', 'execlog.c',
+                   'hotblocks.c', 'hotpages.c', 'howvec.c', 'hwprofile.c',
+                   'ips.c', 'stoptrigger.c', 'traps.c', 'uftrace.c']
 if host_os != 'windows'
   # lockstep uses socket.h
-  contrib_plugins += 'lockstep'
+  contrib_plugins += 'lockstep.c'
 endif
 
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    t += shared_module(i, files(i + '.c'),
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7823704616..303f97f9679 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,7 +1,10 @@
+test_plugins = ['bb.c', 'discons.c', 'empty.c', 'inline.c', 'insn.c', 'mem.c',
+                'reset.c', 'syscall.c', 'patch.c']
+
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    t += shared_module(i, files(i + '.c'),
+  foreach i : test_plugins
+    t += shared_module(fs.stem(i), files(i),
                        dependencies: plugins_deps)
   endforeach
 endif
-- 
2.47.3



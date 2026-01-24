Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D8FD715EF
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiO8-0004M4-Me; Sat, 24 Jan 2026 13:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO7-0004LM-JG
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:35 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO5-0003hE-V3
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:35 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso1420400b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279373; x=1769884173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=t6H+05dblIOSRNav/AvECZGd75m8f1MWd20mcPhSQJ75SNCObl69pxSfUxYDOR2N85
 KpsCQAw6n+GAzG/2croyawNquxX8PLlsQd8SKTollYZe0hFQENk844MqiAJrLUqmvIWF
 4cO9k5As7gbh5rHUdCK8uCpSNcIQekkSjXdzVxJgaeHqkc0SSreHFrvCxmA4r7PpGc/j
 U8KjuVCv9wBRNeDhvxv+7/xNsoNi2Nk95zjgvIdb9tr1w3R7igzRMCxTdQLl6tMlolwv
 5P1MUY2cSE08Pr+f0qM0+XQ+ndkF3XnsQjyxonjvWJvtuF6ZnbmR5BBAOx6HOmAfv9zT
 oGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279373; x=1769884173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZEmhWV50Bdw75mIkmSTg87b5KWsClkrsHwxNSDCjPXY=;
 b=hoewS6zaailqcL9A03Ny8vw18ZP4F2y67R5Ri2IYtcLIZtYuIieOoS5qNUA1bXPVnD
 3wjSxybWtsb6fjjd6zV+VTpsroU7WXVDVwjke4j+zL7MGVli+qWW7uAsJkqdKKHC3AME
 YRrVIGBPUmppjzyN70wdNdGbWj4TxyRuU4lRvQ/S4KKh7G0J5mXHpVJ5Ut8+Seo8LE4J
 X7ggG01U4RluCQahTh+3xxTJhwStadkRIWnpb4CcgtboDlHLtD7ngogeeSgxRx4Ur3qZ
 T0wB53jkonKtV9mVQZgijYUNyhzDoQS94OtLLqeCFoSgLVD0nKLcRVK8wfV+5tX/wikE
 evDg==
X-Gm-Message-State: AOJu0YzVGfBxEdxYbSlIW+PrGBPjyA5g79pDPSyGSRCYCXtprDDA9t7z
 jrZyLUMALHxNVxh8OyrM6w0ZK+PJd1ja0BxtNyQEnoDtwaSabVXRMpta1Xrooir0WygSj2anLCK
 nDAXtv7A=
X-Gm-Gg: AZuq6aKC7yaNSsfucNcA6S5iP1MQk9DPdx1jXK4IBuOWuKajEcZ5PEFu8GBEdZNxVpp
 IPzdrUPgSBEGr0Gr9oUOp0DEIs4k4e0SV1O2QM8taDwI8OnC++Nc0bH1hCzrA2CIf2VPHsZivtl
 Edl4OBs94hFOb/kVguw4PP8CFf8f6y8myY7/0Ps3buWLtsqhdYX1hQRHCNAzVBN0Ei42ox4L05g
 HPahEsEly2qh1udQEJ4RP8olDKDVXJVpCKt0mohQKiM3jjhdkZwXK5j/GG9LA3OafZqszLVLv/E
 coOj3gHAHQuVXK/EId9KBbEp/WMTG9Fy3DmkLylCRK/M78Dl91IPzXnoe7JpAB8BkH5EuxveB29
 FigyyAcJRtZcW7np/wYSdUy1Z/YeCFrkkLzWTT4uFrZUN5Sf7YexSQam1AzDi9WmH7vGm9URCvD
 Sj4qchW+8qH3ypaE0temBWfiQGYXdS802hXRTMXmHPsuZ5OKhN2Dwv4yDJ1z+btgYu
X-Received: by 2002:a05:6a00:1819:b0:81d:a1b1:731b with SMTP id
 d2e1a72fcca58-82317da6160mr5850319b3a.19.1769279372594; 
 Sat, 24 Jan 2026 10:29:32 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 03/11] plugins: use complete filename for defining plugins
 sources
Date: Sat, 24 Jan 2026 10:29:13 -0800
Message-ID: <20260124182921.531562-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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



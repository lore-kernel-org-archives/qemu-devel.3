Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E898AC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 05:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpgyj-0006y9-3V; Wed, 05 Mar 2025 00:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpgyg-0006xr-FH
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 00:07:30 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpgye-0003aY-LP
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 00:07:30 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fce3b01efcso9263964a91.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 21:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741151246; x=1741756046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uj7qf+WzVKuOWckdGCCDk5d/YrFlbuE/1XEFwKiwrXU=;
 b=hcQajt7yuH5PZHKqQBkD4Ls/5+/+QHZZHuflVtAnNGr2q+WuvfLHxr2swN/nXUmELD
 iwGYPw90bhAEmc392MOZuiS6s1yhnhs1X4lveyoKNUyHHIg5CAb1Tl+zgBZjOFKISELA
 +hCb9R5By2Tf0IqGMXmf5fmycbFnuWhjcOjlHpFhPSGFu6cLmWoDLiitYU3ovHgWQNLi
 XUsUFCcXrAZO/XitF/G1ImrvF9+ew3j+dPSypY8joAGBSf+gY0oDoJFtc7O8bmcjZ7+j
 cQDcWTxmtsHj7//S/IfoLJNl2VuXTcnuGGhlxqkdyEYgI9fW4l6LKHalKjZ/cklqE43L
 U+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741151246; x=1741756046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uj7qf+WzVKuOWckdGCCDk5d/YrFlbuE/1XEFwKiwrXU=;
 b=qrFJyMUaPi4Hp0AgETSZ/1iemMwSET5gKaTk+w1Jz7UFncwlGdNMwueWR5UE4h4buE
 d3v0jurRw5ACBXbAhX1OyEXUmQL2KSIi4ItX53adVHHmXymcABWtjAaCk8E6wgN6kWiM
 N3YhmkKwkiZSgGF5VZSDBSJV7MymGOSUXyrCXoUbpGzk2tORW18j0kvhwmVqjSZVKxkh
 qduY940OByqDyUFIlQKq64C0h7zuCmzhxefmcGA4fKp1l0pcGjarvr/S7Ae28HvMxB+e
 eFQJoC4PPQaxNsLoRnHl20dKAt8FxI+pHLaBg8Cgi6Lu6dep7G0BsXflESdQaBkTJcNq
 pBjg==
X-Gm-Message-State: AOJu0Yz21VZ0cxSu66hvReuSk0gHmbVCVQT5CAnKBwAN9TACeUys844J
 oMf+aUm6nQnd3uE45G0kLuIxBr/NOgCGG7Dt4YWAP1ZRunZqt+e/hlhP9DirjLhH965QNuE5sUN
 4
X-Gm-Gg: ASbGncuWjlblGK2QoTEOs4YTkzNKofNu4VBiQkYdneNaQAvdOkbQf87nguX/rymyWdW
 yQYCEm3Jol8JPqmFp7KOxF+7+S+5e/AX/bbqqS9RaOTQ0kzkeDuFKws0yMLOAYVDiyDe+sv7xlq
 XzPIe2nh5eJLt1Yj8VnmQTt3fcxtIYFEmHK/W+y9XhDQHxk1KOakFPR9EZzSVNlRFIji/Js/0+R
 SuxBWg1Skn/SwmNdHlO7A8QVGtz5i0l9qn6oclogRv5U1gPY9LfWMuj6S+KYlBF+NeCiI/hLLT5
 jHOvY/arzNFw827nMuny5yyaVmrytFla0xCb0PwhBn3Y
X-Google-Smtp-Source: AGHT+IHZnxeSAVcVugTam9XE0Axi9kAURAqJc7OjCt26Rc+BFyNXG4Rs3kSEuer+cBYnSTpofU8rbw==
X-Received: by 2002:a17:90b:4c43:b0:2fe:dd2c:f8f0 with SMTP id
 98e67ed59e1d1-2ff497ff88cmr2779828a91.22.1741151246510; 
 Tue, 04 Mar 2025 21:07:26 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7bc883sm363124a91.45.2025.03.04.21.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 21:07:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, alex.bennee@linaro.org,
 Stefan Hajnoczi <stefanha@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] trace/control-target: cleanup headers and make compilation
 unit common
Date: Tue,  4 Mar 2025 21:07:16 -0800
Message-Id: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 trace/control-target.c | 2 --
 trace/meson.build      | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index d58e84f6dd8..57ceac21084 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -8,8 +8,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/lockable.h"
-#include "cpu.h"
 #include "trace/control.h"
 
 
diff --git a/trace/meson.build b/trace/meson.build
index c3412dc0ba5..3df45493555 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,6 +1,4 @@
-system_ss.add(files('trace-hmp-cmds.c'))
-
-specific_ss.add(files('control-target.c'))
+system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
 
 trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
-- 
2.39.5


